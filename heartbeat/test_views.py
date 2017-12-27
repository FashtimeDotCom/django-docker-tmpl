# from .views import heartbeat


def test_heartbeat(client):
    response = client.get('/heartbeat/')

    data = response.json()

    assert response.status_code == 200
    assert data['mode'] == 'simple'
    assert data['status'] == 'running'


def test_heartbeat_no_ending_slash(client):
    response = client.get('/heartbeat')

    assert response.status_code == 301
