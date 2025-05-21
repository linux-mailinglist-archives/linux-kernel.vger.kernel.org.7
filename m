Return-Path: <linux-kernel+bounces-656547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5280ABE7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 00:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC373B12D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167A262FD6;
	Tue, 20 May 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="a1zwU4lC"
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA725A322
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781793; cv=none; b=QZstDMt8TLxv6v741k+PzDh/TVjlENT9fFmFG8vGI633MltGApTUU6Quhl5L9aLkFzti7a136R+Qh1O7mnmti0GoGntOkJ00pprc/0HPCVKxLoKJ1VsngHPW6fhsoqz1ODtkP4mDncibDN0o6q8Wp+kF05PDlL4DU8/GyOpNjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781793; c=relaxed/simple;
	bh=wQQubEBib3byNdfTnd7ko0vhCud06Uio7n09JluN5A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oS0LH9w9gLNeOzmHePQiPGL0uZGfJTTegEiJFE9UNsXvFbG86W91fNl/pXsPebofrmplkUcujYswY67tOghqUfjkyOIGFXpYaC5sE240PW9hIuYQIPKe2yhfIVh0XxbFp6dLbhIrezYlav6IpVHX2q34ZiyOL+fqGTmEK+cMyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=a1zwU4lC; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uHVsi-001X5G-Em; Wed, 21 May 2025 00:56:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=J8ECBmbAYxlbH2+qPMrZpA1tVV7W3mma7W+7fWFHowY=; b=a1zwU4lCjIw4rl0eCGmePhdG70
	Kl5MZpMWS3dDQKCbhrvJuYTJICmXOGRkgD6tSjAQ8IiGd6MX/2NVB3J/JEe3jmdNkaYOXfkBX1HOF
	titg1QEnk4LOFk22l1ttevdjoS2E559+ym1/Zr00rZO5NdIEoVjphwk1Hp3p0R8gUlnrzJLBuROj+
	pppmsVvoNZRMHuK8sqZagfc63xgF3JBR7NtfRNnTW8LiXj7cX8GoI+d5HEpzwTzvSyIYrPX1mf6N7
	DnETfPryVxqiiBBRXqyfJ9Mx6vMFCvgEmhtHpV6ve+b6EDEpej9FLZ0Z8g+vSHgijXUKU4ri7JPAj
	6F2jVpdA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uHVsi-0007nJ-6I; Wed, 21 May 2025 00:56:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uHVsZ-00CxGf-Hx; Wed, 21 May 2025 00:56:11 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 21 May 2025 00:55:23 +0200
Subject: [PATCH net-next v5 5/5] vsock/test: Add test for an unexpectedly
 lingering close()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-vsock-linger-v5-5-94827860d1d6@rbox.co>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
In-Reply-To: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

There was an issue with SO_LINGER: instead of blocking until all queued
messages for the socket have been successfully sent (or the linger timeout
has been reached), close() would block until packets were handled by the
peer.

Add a test to alert on close() lingering when it should not.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f401c6a79495bc7fda97012e5bfeabec7dbfb60a..1040503333cf315e52592c876f2c1809b36fdfdb 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1839,6 +1839,50 @@ static void test_stream_linger_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_nolinger_client(const struct test_opts *opts)
+{
+	bool nowait;
+	time_t ns;
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	enable_so_linger(fd);
+	send_byte(fd, 1, 0); /* Left unread to expose incorrect behaviour. */
+	nowait = vsock_wait_sent(fd);
+
+	ns = current_nsec();
+	close(fd);
+	ns = current_nsec() - ns;
+
+	if (nowait) {
+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
+	} else if ((ns + NSEC_PER_SEC - 1) / NSEC_PER_SEC >= LINGER_TIMEOUT) {
+		fprintf(stderr, "Unexpected lingering\n");
+		exit(EXIT_FAILURE);
+	}
+
+	control_writeln("DONE");
+}
+
+static void test_stream_nolinger_server(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("DONE");
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -1999,6 +2043,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_linger_client,
 		.run_server = test_stream_linger_server,
 	},
+	{
+		.name = "SOCK_STREAM SO_LINGER close() on unread",
+		.run_client = test_stream_nolinger_client,
+		.run_server = test_stream_nolinger_server,
+	},
 	{},
 };
 

-- 
2.49.0


