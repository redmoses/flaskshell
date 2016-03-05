from flask import Flask
from flask import request
import subprocess

app = Flask('flaskshell')
# mysql credentials
db_user = 'flaskuser'
db_pass = 'flask123'
db_host = 'mysql'
# whitelist
ip_whitelist = []
# queries
query_success = "SELECT COUNT(*) FROM flaskshell.tasks WHERE task_status='Success'"
query_pending = "SELECT COUNT(*) FROM flaskshell.tasks WHERE task_status='Pending'"
query_failed = "SELECT COUNT(*) FROM flaskshell.tasks WHERE task_status='Failed'"


def valid_ip():
    client = request.remote_addr
    if len(ip_whitelist) <= 0:
        return True

    if client in ip_whitelist:
        return True

    return False


@app.route('/status/')
def get_status():
    if valid_ip():
        base_command = "mysql -u{0} -p{1} -h ${2}".format(
            db_user, db_pass, db_host
        )
        command_success = "{0} -e '{1}'".format(base_command, query_success)
        command_pending = "{0} -e '{1}'".format(base_command, query_pending)
        command_failed = "{0} -e '{1}'".format(base_command, query_failed)

        try:
            result_success = subprocess.check_output(
                [command_success], shell=True)
            result_pending = subprocess.check_output(
                [command_pending], shell=True)
            result_failed = subprocess.check_output(
                [command_failed], shell=True)
        except subprocess.CalledProcessError as e:
            return "An error occurred while trying to fetch task status updates."

        return 'Success %s, Pending %s, Failed %s' % (result_success, result_pending, result_failed)
    else:
        return """
        <title>404 Not Found</title>
        <h1>Not Found</h1>
        <p>The requested URL was not found on the server.
        If you entered the URL manually please check your
        spelling and try again.</p>
        """, 404


if __name__ == '__main__':
    app.run()
