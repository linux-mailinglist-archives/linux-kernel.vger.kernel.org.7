Return-Path: <linux-kernel+bounces-896491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51509C50869
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B53B4D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D692D7813;
	Wed, 12 Nov 2025 04:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASML86Vl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB282D7397
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762921714; cv=none; b=jHWs12sPLbyVr7MneGk6fqRTqq4M/fdrOxKZNkQM308JezvFYjCDjMccFtk6v0+GExmhzrgKxtfvuLU0zUAtbSwBmdnnppZOJDO92NsaqnnwFMnPcDN/SZBJT3m8YJSGhTXoavYTE4CShazImQsbWnoW2R/Zoy3DqCCTw9BpxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762921714; c=relaxed/simple;
	bh=CSNpcjZHL9pVJrnk1JfX7pOti7wT8d8rdC2TqemtXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsmbD9WEi1BE9j1kI1XY7veqll4J88krDXVRjo3mbX2y8bD73+SfKCoYnNyQGzKe3h/6D7sAGe/qvXn68tcdI3X/xzNVhBLDgHduETOIsNMP/MjW3A9G3wY3vukXQyf5YTPlZn3CvYKrY6r3wJ2JiD+jvs5ofR/ZsfnhGwZutSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASML86Vl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso277939a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762921711; x=1763526511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwMH/feAbYG5hMxYbw3J+YyHR7bCjVFZQaW7MKJUtGI=;
        b=ASML86VlMk+jcqJMvq+4BtpDseLiZazSvyliNHObeeNmpdLKOG3is1x5pMT9Tylcef
         hmYMrsOR0SA8mnKxECIahuDvFlD5HoPkeJPmWF/MkR42ZLKw1qsg5kJ9qcVO2PuHzS85
         3oJIc5Xk2W76tmHQikY4hWim3bDObvOfl/hzm2LLBM5ll6WZoAUNuamkDS8+4MhkL1Cp
         KYqGyEv4x4LPgX3h+ufHRX+VYCTDCPkQEGTeOGX5W6CrVbyU4KQz5oh9PsImCiC8VJsL
         W+GgXxf+SN/oSd92kRs3LuP5CZ5exJ5IMVcCQ601m1HUGL4rjJcPJaBltPS41Fp4jSnk
         6t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762921711; x=1763526511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwMH/feAbYG5hMxYbw3J+YyHR7bCjVFZQaW7MKJUtGI=;
        b=I3h8SPLle/znvaXxHORDiLdykFZcYdkgbUP7g3n0k0Fa9cJBVQ9zyoUcvrn45Q6wvL
         +X57tK7oXKdceEMNfUi6MpF8oNDwuVbu2gnhHIM6fjXPZQn/mpztKpYwUqoBXRJSEQOu
         nGO0BhxnA6zM1yfJVE7ZLLZ9lxcTPdufPPlQke6YUcpqGPUprW83xt9h4bsdbr1KR+wm
         0aczuqKs2vrpVE6NsnSkbbCdRWET8voKzcc7q3UCDtQzHKDSicrUBgW8cl89KQ6fwbVS
         CLyBCQxS0wlbzvoNqGF9+5KtHsILHbc7urT3pRnnUIRNwGploHstt5Jbg9Lhmxh4Jx5t
         nBTA==
X-Forwarded-Encrypted: i=1; AJvYcCUOn4GqXeaU3tPn8fkHhQUGU4+Sfwb9dZ47+SdNt9yRQ1BKghR8BqJBKayPBPd+gvnSdETnTtMtjLZxtL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO5gA+7HA4ePKv168rMeKt/ci6zsGo5ciXLtd2O4e1vawPagl
	/Rnkme8XNAYOjhxuL2WgO1QoT2ehuNpzez3gaFpsbxfmgV2CQ9UStmZ2
X-Gm-Gg: ASbGncta1Wqoypxn9sr34HOWr6jKHJNTCSyrF3EgZT82Ls67MdTMF9ZB6fCKjTFpF6d
	A/uKjd0YTgFv8NSFGl8+2ogjN5zA4RRG+9MJMtZot5o6GkST2YyFGL27+JMq8LZofi59SxmtkSX
	4HJkt2s3qFUo/QOL1VGRimt3NJjVAblnneWn3M1zHECbOp+SjG/qRcRrX7AZxTr2EzwB5003lVg
	7pdBgVZV9R6BqUayRVgbL6GVjA8RLSeALXGpwru0wmOVitGi0qjnFn2vFu2inuJCHuWBW+oKz2Q
	hY6YG7V7QrbUR1/gw+Nti+c+ggP/tHHMuc3LB8Ax0WBKt51k0D+yYYh1Anh01WY+7kEOoh0Hmof
	5+BTr57a2VkQ+rgYOa3TJN7egAUqXrwL29HseVwFCR44IuNBm5dXzGwOlv+srHGbmsigTI8Xozp
	vea9+M/yThxPqnsCXZ5AVFGBYGxdFyDf6bHJah01kpZh5IJM13jBsf/Mn1/w8fd0ybIRnKGQ8M9
	7aocWIJ3Q==
X-Google-Smtp-Source: AGHT+IHLsvrCYQlNmzagnHaIUAwzof2318bAn+2sz/wwmJG5Nv1JCItAUXzYrY+80FssVU6l5G3G/g==
X-Received: by 2002:a17:90b:3943:b0:343:78ed:8d19 with SMTP id 98e67ed59e1d1-343bf0bd417mr7600541a91.7.1762921710572;
        Tue, 11 Nov 2025 20:28:30 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fbc0dsm854681a91.2.2025.11.11.20.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 20:28:30 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: chuck.lever@oracle.com,
	hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
Date: Wed, 12 Nov 2025 14:27:18 +1000
Message-ID: <20251112042720.3695972-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112042720.3695972-1-alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

When reporting the msg-type to userspace let's also support reporting
KeyUpdate events. This supports reporting a client/server event and if
the other side requested a KeyUpdateRequest.

Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v5:
 - Drop clientkeyupdaterequest and serverkeyupdaterequest
v4:
 - Don't overload existing functions, instead create new ones
v3:
 - Fixup yamllint and kernel-doc failures

 Documentation/netlink/specs/handshake.yaml | 16 ++++-
 drivers/nvme/host/tcp.c                    | 15 +++-
 drivers/nvme/target/tcp.c                  | 10 ++-
 include/net/handshake.h                    |  6 ++
 include/uapi/linux/handshake.h             | 11 +++
 net/handshake/tlshd.c                      | 83 +++++++++++++++++++++-
 6 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index a273bc74d26f..2f77216c8ddf 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -21,12 +21,18 @@ definitions:
     type: enum
     name: msg-type
     value-start: 0
-    entries: [unspec, clienthello, serverhello]
+    entries: [unspec, clienthello, serverhello, clientkeyupdate,
+              serverkeyupdate]
   -
     type: enum
     name: auth
     value-start: 0
     entries: [unspec, unauth, psk, x509]
+  -
+    type: enum
+    name: key-update-type
+    value-start: 0
+    entries: [unspec, send, received, received_request_update]
 
 attribute-sets:
   -
@@ -74,6 +80,13 @@ attribute-sets:
       -
         name: keyring
         type: u32
+      -
+        name: key-update-request
+        type: u32
+        enum: key-update-type
+      -
+        name: session-id
+        type: u32
   -
     name: done
     attributes:
@@ -116,6 +129,7 @@ operations:
             - certificate
             - peername
             - keyring
+            - session-id
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 024d02248831..4797a4532b0d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,7 @@
 #include <linux/iov_iter.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <uapi/linux/handshake.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -206,6 +207,10 @@ static struct workqueue_struct *nvme_tcp_wq;
 static const struct blk_mq_ops nvme_tcp_mq_ops;
 static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
 static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
+static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
+			      struct nvme_tcp_queue *queue,
+			      key_serial_t pskid,
+			      enum handshake_key_update_type keyupdate);
 
 static inline struct nvme_tcp_ctrl *to_tcp_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1729,7 +1734,8 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid,
 
 static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			      struct nvme_tcp_queue *queue,
-			      key_serial_t pskid)
+			      key_serial_t pskid,
+			      enum handshake_key_update_type keyupdate)
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
@@ -1751,7 +1757,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
-	ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_client_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_client_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		dev_err(nctrl->device, "queue %d: failed to start TLS: %d\n",
 			qid, ret);
@@ -1901,7 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	/* If PSKs are configured try to start TLS */
 	if (nvme_tcp_tls_configured(nctrl) && pskid) {
-		ret = nvme_tcp_start_tls(nctrl, queue, pskid);
+		ret = nvme_tcp_start_tls(nctrl, queue, pskid, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC);
 		if (ret)
 			goto err_init_connect;
 	}
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7f8516892359..818efdeccef1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1833,7 +1833,8 @@ static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w)
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
+static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
+				   enum handshake_key_update_type keyupdate)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
@@ -1852,7 +1853,10 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
-	ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	if (keyupdate == HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC)
+		ret = tls_server_hello_psk(&args, GFP_KERNEL);
+	else
+		ret = tls_server_keyupdate_psk(&args, GFP_KERNEL, keyupdate);
 	if (ret) {
 		kref_put(&queue->kref, nvmet_tcp_release_queue);
 		pr_err("failed to start TLS, err=%d\n", ret);
@@ -1934,7 +1938,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		sk->sk_data_ready = port->data_ready;
 		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
-			if (!nvmet_tcp_tls_handshake(queue))
+			if (!nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC))
 				return;
 			/* TLS handshake failed, terminate the connection */
 			goto out_destroy_sq;
diff --git a/include/net/handshake.h b/include/net/handshake.h
index 68d7f89e431a..f5a249327bf6 100644
--- a/include/net/handshake.h
+++ b/include/net/handshake.h
@@ -10,6 +10,8 @@
 #ifndef _NET_HANDSHAKE_H
 #define _NET_HANDSHAKE_H
 
+#include <uapi/linux/handshake.h>
+
 enum {
 	TLS_NO_KEYRING = 0,
 	TLS_NO_PEERID = 0,
@@ -38,8 +40,12 @@ struct tls_handshake_args {
 int tls_client_hello_anon(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate);
 int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
 int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate);
 
 bool tls_handshake_cancel(struct sock *sk);
 void tls_handshake_close(struct socket *sock);
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index b68ffbaa5f31..483815a064f0 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -19,6 +19,8 @@ enum handshake_msg_type {
 	HANDSHAKE_MSG_TYPE_UNSPEC,
 	HANDSHAKE_MSG_TYPE_CLIENTHELLO,
 	HANDSHAKE_MSG_TYPE_SERVERHELLO,
+	HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE,
+	HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE,
 };
 
 enum handshake_auth {
@@ -28,6 +30,13 @@ enum handshake_auth {
 	HANDSHAKE_AUTH_X509,
 };
 
+enum handshake_key_update_type {
+	HANDSHAKE_KEY_UPDATE_TYPE_UNSPEC,
+	HANDSHAKE_KEY_UPDATE_TYPE_SEND,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED,
+	HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED_REQUEST_UPDATE,
+};
+
 enum {
 	HANDSHAKE_A_X509_CERT = 1,
 	HANDSHAKE_A_X509_PRIVKEY,
@@ -46,6 +55,8 @@ enum {
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
 	HANDSHAKE_A_ACCEPT_KEYRING,
+	HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+	HANDSHAKE_A_ACCEPT_SESSION_ID,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 85c5fed690c0..91d2bb515b7d 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -41,6 +41,7 @@ struct tls_handshake_req {
 	unsigned int		th_num_peerids;
 	key_serial_t		th_peerid[5];
 
+	unsigned int		th_key_update_request;
 	key_serial_t		handshake_session_id;
 };
 
@@ -58,7 +59,8 @@ tls_handshake_req_init(struct handshake_req *req,
 	treq->th_num_peerids = 0;
 	treq->th_certificate = TLS_NO_CERT;
 	treq->th_privkey = TLS_NO_PRIVKEY;
-	treq->handshake_session_id = TLS_NO_PRIVKEY;
+	treq->handshake_session_id = args->handshake_session_id;
+
 	return treq;
 }
 
@@ -265,6 +267,16 @@ static int tls_handshake_accept(struct handshake_req *req,
 		break;
 	}
 
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_SESSION_ID,
+			  treq->handshake_session_id);
+	if (ret < 0)
+		goto out_cancel;
+
+	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEY_UPDATE_REQUEST,
+			  treq->th_key_update_request);
+	if (ret < 0)
+		goto out_cancel;
+
 	genlmsg_end(msg, hdr);
 	return genlmsg_reply(msg, info);
 
@@ -372,6 +384,44 @@ int tls_client_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_client_hello_psk);
 
+/**
+ * tls_client_keyupdate_psk - request a PSK-based TLS handshake on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-EINVAL: Wrong number of local peer IDs
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_client_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+	unsigned int i;
+
+	if (!args->ta_num_peerids ||
+	    args->ta_num_peerids > ARRAY_SIZE(treq->th_peerid))
+		return -EINVAL;
+
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_CLIENTKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = args->ta_num_peerids;
+	for (i = 0; i < args->ta_num_peerids; i++)
+		treq->th_peerid[i] = args->ta_my_peerids[i];
+
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_client_keyupdate_psk);
+
 /**
  * tls_server_hello_x509 - request a server TLS handshake on a socket
  * @args: socket and handshake parameters for this request
@@ -428,6 +478,37 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags)
 }
 EXPORT_SYMBOL(tls_server_hello_psk);
 
+/**
+ * tls_server_keyupdate_psk - request a server TLS KeyUpdate on a socket
+ * @args: socket and handshake parameters for this request
+ * @flags: memory allocation control flags
+ * @keyupdate: specifies the type of KeyUpdate operation
+ *
+ * Return values:
+ *   %0: Handshake request enqueue; ->done will be called when complete
+ *   %-ESRCH: No user agent is available
+ *   %-ENOMEM: Memory allocation failed
+ */
+int tls_server_keyupdate_psk(const struct tls_handshake_args *args, gfp_t flags,
+			     enum handshake_key_update_type keyupdate)
+{
+	struct tls_handshake_req *treq;
+	struct handshake_req *req;
+
+	req = handshake_req_alloc(&tls_handshake_proto, flags);
+	if (!req)
+		return -ENOMEM;
+	treq = tls_handshake_req_init(req, args);
+	treq->th_type = HANDSHAKE_MSG_TYPE_SERVERKEYUPDATE;
+	treq->th_key_update_request = keyupdate;
+	treq->th_auth_mode = HANDSHAKE_AUTH_PSK;
+	treq->th_num_peerids = 1;
+	treq->th_peerid[0] = args->ta_my_peerids[0];
+
+	return handshake_req_submit(args->ta_sock, req, flags);
+}
+EXPORT_SYMBOL(tls_server_keyupdate_psk);
+
 /**
  * tls_handshake_cancel - cancel a pending handshake
  * @sk: socket on which there is an ongoing handshake
-- 
2.51.1


