Return-Path: <linux-kernel+bounces-895188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E836C4D275
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6C34EB65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F0350A17;
	Tue, 11 Nov 2025 10:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InNTWs9p"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A234B1AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858079; cv=none; b=JXIb2jOQ/jQQUd5z7JjTj1z44bdupIK+SxxKfN++Plmgjp9ijz451ietWlT5sBVIdRxkAQuhCUm7DHnhMgW4vwt/rNPTpOBpBHGTO6uLkZJdxol6cuG/mOI8Lj/7jMN9zDPwXZmJOEDZYAQA6nAgh7WioDUcn622TxcRM9epgRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858079; c=relaxed/simple;
	bh=WfUCYKomq065xhjullLuTILgOb0RdHyS2EMF53wqVws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XbkHDGMdMaF2q544J/2fg886aBs6g4buHGN5QpRScCE+zan+AphTUXctY70GgOUREOqT2CBz1oZ+P5/+CQygTQiDmw8FKRrhV9VYFwEs07pDJndm3J6CP/aB2e39Pg3lV/deBkL+Txsc8g8KhiivLJFKpCNDzZXEMDmYK2t2Jk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InNTWs9p; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7afc154e411so2427875b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762858077; x=1763462877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGM7v17X5fBjnUVPBs36cQEsoFHwlXkRLxBvLVWWErg=;
        b=InNTWs9pHe/+aVO8dwNa+HcMialSUjjTYWzOPDgL3TCnagT87j2UVwGBGYpFzcFqP1
         CD+7gHWpC0HRT3CYdW2gDRMj+dN8qEYxEsqLtm4oXzFUlKnVAGHdRIvsSnGLupuHqgQD
         bmQeo1dNsVmDG2DpF61pAEtqSCKSAgyn5LCn1GQvjiKaXNRVhbmANeENrwc0/cQC7/g3
         fKFgJ0kakyW+Ewwz+G4B1QIACdraTBqwNYtJpm/KzfVvDb5fWBT3r0qIzIStm64Tn2xI
         WaYbQcU9xJxLlDog6ROOcLPhLZCb5iTJgTELGyzeZ/geWX9zYoQBX1UPnq0RiWhbsHei
         pGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762858077; x=1763462877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGM7v17X5fBjnUVPBs36cQEsoFHwlXkRLxBvLVWWErg=;
        b=m/HAalJd3NtlxyIMuTB4/76m3o7p3MJs2EcJTGD+XXlAkziaN9PjRnKylkyBdg0XIw
         +PXcfTtg1YreXRViCg5o+YhbgajkfzmPGxPw0tVS9EN+b19LBGIsMTXaJD1nnRK8qcjk
         9p3k4kPlZWwfZSsvFBFnSlaqopet/jLL8yJTZ3uBD1QtpYv3M5rKla5tolkEThOz1DtN
         0yyZU9wyEddfDywamwwFV0c58JO4kN1+tmDjx3kf3cxaeQQuycbW+z4gwSEbGmlm7UVl
         hSCRFJwoAHPEHoLprjDEz8tuGeHK7BREixRE5Bn0a7ZHknfb+GMtZAxrrkeoSQ5OcJnX
         hScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN0rZ5ovxeVJbJJWKf397iuH42xXbloA8/AtBbhWgIMNUfOOztX0mzQG/L+wC6JtxJAJxMMk9HXvBpSP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCCkOFxXgYNjt7rcxk/RYcgO4xXPB9Ak8Q7dZH1ymKkKepsBD
	wSCbWA/uSzqZV0dreR7uGm4f1t6QNArygGDa9ZfSH3cVdlZjCTRvWuHQ
X-Gm-Gg: ASbGncvYvGSlCCBdfweDz/jBF2/cJcwxAKLIYBjfC9zAV+dGdmo9wxe5GVqnJL2a7dN
	oTncqmIWxozT6EhIobw8D3Whom3T60i2Z5uDD4HxDwvMOsRg12T4d8qsUPVJ5s0qxWR8P3OumtA
	JRSDQ1jt4+O4Udy22Qm5739FD+K4TZJpU/yUu0M4MHlDKex+urv7Iu+fmENqQGDTysCFwF2Q0wA
	hOB3wsiBBI/ZBZnqU5HcD4QgGDJGIhtzBw4TGlUeot8ZEt3hp/f4IXE9ZyHOMGUVBJqlnCfv8Xe
	erDfOe4JOdJKT3Bh6bNKPQRIPz+L9A6GmAqzK4CQUn+Zkdhhd+Zi7dRRAsh4jnn5JIy36+jU6f0
	QAdJvTPyuFKc5tp8aww/ypcHPewO4hNCTUM2QW4iBS5rpWu8SVjM3g9X2N9tjGqLMUVT40OmIEw
	==
X-Google-Smtp-Source: AGHT+IEGEeJH5qOCRfzOE45L5zCqZ3JL5eKpNLRtF+FdalHg2ufAcdmgy4UMZm2EL294xytUUaIh9g==
X-Received: by 2002:a05:6a00:ccc:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-7b225c8d22bmr14790664b3a.12.1762858077096;
        Tue, 11 Nov 2025 02:47:57 -0800 (PST)
Received: from gmail.com ([2a09:bac1:19c0:20::4:2ee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccd4edc3sm14912911b3a.66.2025.11.11.02.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:47:56 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2] ksmbd: server: avoid busy polling in accept loop
Date: Tue, 11 Nov 2025 18:47:49 +0800
Message-ID: <20251111104750.25739-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ksmbd listener thread was using busy waiting on a listening socket by
calling kernel_accept() with SOCK_NONBLOCK and retrying every 100ms on
-EAGAIN. Since this thread is dedicated to accepting new connections,
there is no need for non-blocking mode.

Switch to a blocking accept() call instead, allowing the thread to sleep
until a new connection arrives. This avoids unnecessary wakeups and CPU
usage. During teardown, call shutdown() on the listening socket so that
accept() returns -EINVAL and the thread exits cleanly.

The socket release mutex is redundant because kthread_stop() blocks until
the listener thread returns, guaranteeing safe teardown ordering.

Also remove sk_rcvtimeo and sk_sndtimeo assignments, which only caused
accept() to return -EAGAIN prematurely.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v1 -> v2: https://lore.kernel.org/linux-cifs/20251030064736.24061-1-dqfext@gmail.com
 Do not remove TCP_NODELAY, as accepted sockets inherits from it.
 Fix accept() blocking forever on older kernel versions.
 Remove a redundant mutex

 fs/smb/server/transport_tcp.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 6e03e93321b8..79319815b2fc 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -22,7 +22,6 @@ struct interface {
 	struct socket		*ksmbd_socket;
 	struct list_head	entry;
 	char			*name;
-	struct mutex		sock_release_lock;
 	int			state;
 };
 
@@ -236,20 +235,14 @@ static int ksmbd_kthread_fn(void *p)
 	unsigned int max_ip_conns;
 
 	while (!kthread_should_stop()) {
-		mutex_lock(&iface->sock_release_lock);
 		if (!iface->ksmbd_socket) {
-			mutex_unlock(&iface->sock_release_lock);
 			break;
 		}
-		ret = kernel_accept(iface->ksmbd_socket, &client_sk,
-				    SOCK_NONBLOCK);
-		mutex_unlock(&iface->sock_release_lock);
-		if (ret) {
-			if (ret == -EAGAIN)
-				/* check for new connections every 100 msecs */
-				schedule_timeout_interruptible(HZ / 10);
+		ret = kernel_accept(iface->ksmbd_socket, &client_sk, 0);
+		if (ret == -EINVAL)
+			break;
+		if (ret)
 			continue;
-		}
 
 		if (!server_conf.max_ip_connections)
 			goto skip_max_ip_conns_limit;
@@ -458,10 +451,6 @@ static void tcp_destroy_socket(struct socket *ksmbd_socket)
 	if (!ksmbd_socket)
 		return;
 
-	/* set zero to timeout */
-	ksmbd_tcp_rcv_timeout(ksmbd_socket, 0);
-	ksmbd_tcp_snd_timeout(ksmbd_socket, 0);
-
 	ret = kernel_sock_shutdown(ksmbd_socket, SHUT_RDWR);
 	if (ret)
 		pr_err("Failed to shutdown socket: %d\n", ret);
@@ -532,9 +521,6 @@ static int create_socket(struct interface *iface)
 		goto out_error;
 	}
 
-	ksmbd_socket->sk->sk_rcvtimeo = KSMBD_TCP_RECV_TIMEOUT;
-	ksmbd_socket->sk->sk_sndtimeo = KSMBD_TCP_SEND_TIMEOUT;
-
 	ret = kernel_listen(ksmbd_socket, KSMBD_SOCKET_BACKLOG);
 	if (ret) {
 		pr_err("Port listen() error: %d\n", ret);
@@ -604,12 +590,11 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 		if (iface && iface->state == IFACE_STATE_CONFIGURED) {
 			ksmbd_debug(CONN, "netdev-down event: netdev(%s) is going down\n",
 					iface->name);
+			kernel_sock_shutdown(iface->ksmbd_socket, SHUT_RDWR);
 			tcp_stop_kthread(iface->ksmbd_kthread);
 			iface->ksmbd_kthread = NULL;
-			mutex_lock(&iface->sock_release_lock);
-			tcp_destroy_socket(iface->ksmbd_socket);
+			sock_release(iface->ksmbd_socket);
 			iface->ksmbd_socket = NULL;
-			mutex_unlock(&iface->sock_release_lock);
 
 			iface->state = IFACE_STATE_DOWN;
 			break;
@@ -672,7 +657,6 @@ static struct interface *alloc_iface(char *ifname)
 	iface->name = ifname;
 	iface->state = IFACE_STATE_DOWN;
 	list_add(&iface->entry, &iface_list);
-	mutex_init(&iface->sock_release_lock);
 	return iface;
 }
 
-- 
2.43.0


