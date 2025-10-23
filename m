Return-Path: <linux-kernel+bounces-867560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C577CC02FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C265654041C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40134DB54;
	Thu, 23 Oct 2025 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAe+IZ07"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929F534C9B4
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244097; cv=none; b=HAjJnytvZMR4BLAY1HWWIlqluc2FUrIPPCwX1dCvz6gy+Mwv0GZjJJ0NT7Kkwm3GJiYNKIHzx/CURho0XpF5/wv54tevpKRN+0uoYv8KfdHtkUJMHJlFyHrcuxm5hcJsLgne4aic9UQkHtwLItHvH762MekZxHeplrGcl1n+6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244097; c=relaxed/simple;
	bh=kUefiKfkicMX8tmziLXEi//+t8csN8furvqT9U5IgCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUTfgBN6w7w66OuMSfHjPz9rWwyTy2Bq5A692mkE0vxhc2F+9yW7+CyTJV0V0VVrWRV1S6+HxTO1hB6bvz5VK67S9/I2eQJTwF8/Mx/U2vtz1E7SR+XzebJIzqPeisfGYE+weZ/TV8yCDLyHtrUFsSngzXSr/r5lS/9pImLbFck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAe+IZ07; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso1005566a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244090; x=1761848890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENceTHQQLbApf5YaDY/ZTac12ozK8h8RipNYM83YVxY=;
        b=cAe+IZ07igbq+BkPU5qd+wVGpHzBGx1pBdllSZR/VonoXlggQ3aJeJsqd+mEjZpvhI
         4m0eyW70hHmZ2aNrQaaTqk+UgOVDRc8K9cVvAevIR3tAKDXIx+H6qMCvIr0isQlDXREN
         wHGA4UC+WvDqiuC2+sdMGBBySqkANDJ2TuuyHupRn5XWQ3IC+/p5+eJqgRRW9It3bpWW
         CenuUolDtzE3y2wYcOggBUzYSKWZv2BKqNbzPQoV2Zswg464V8DPzGlKBmCKhsKp3Slj
         Oc2P/qvcV6vbmGGbFHSjf0Nh2sjCFjEEAhIvHXPQ/sJbl5JCf26oocvNPLqRn6rVXo4z
         LwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244090; x=1761848890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENceTHQQLbApf5YaDY/ZTac12ozK8h8RipNYM83YVxY=;
        b=rd/mV7ffVSLY0kx4nEAIqsYiVkMAHNr2+L8vjY52gmup64HezOJdGk0LHQIcusGOyY
         Kqrb/5KtlFS4xn/bt7l4uJOo8At66MJ0VMZGDR+l+QpLm8JJutbNI3OjAuLIUHxD66PC
         hCGd6y696p0H7t1xzR1bHWflrVf8pfIPIcXe5jw5MvZwZYHTyKUZO3ZiEEnUQ2+B0Ix/
         4osTIgkV7bNiiJvquzu1vEKCzwNSUgh3AQVzJI776m5SWpNPUMjHaVot92GcrScyVjmW
         IhIXxH3O39WxHM2Y9NxhyfutyNCg5Q7+YKCxRZ2Kok6WLw4ev6s449PWDxetlXROCd6+
         w3dg==
X-Forwarded-Encrypted: i=1; AJvYcCXOwj+fujfYqtIoWFXRk2+A1R1fsXXk/8Y50Mm0ke5UDY6V104VybKjWdrUDUele7wd8IKmWFDIgnyPvWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfN11SWsjz5z0MNtY8nYUshxSFvdMfUFpa0u307nM8zOBHrtmd
	SLXMtXvoAKXJ13V9ZLMbamP10KRNAGkf1CvjZHnYQdpH9ggqWIUmcc63/55pUGov
X-Gm-Gg: ASbGncsvCPnJ8Trz1Eu0bxqXJRjPbZZzQPP230O83fELKFYjXVVs/cgU8TAXb17CazA
	LWGOD1dopOfYZ6LtstKVLelEMYp6VxxbER25bQ7OrIR2QM+EQfHQXU7+o044L3uF7h6dAwkfdkO
	fzq1KJya+718i3T7KTalIRfTOpHqrfUlMyK8z8d7og7UWFWmI/mJedPwzfEv5xEeUAVskii77b0
	m9Jfg4DD5l5jTAtQn6bATS7blrWWz8UB9XjbUfP9JUmVWJjm+f/TyfvAxCF26upzIiD9ywL5/Vq
	k2blreM7/Wq+7DJRs86DUCc6LD15jJHvMWP4qgfYpIrJXDYDghd7oVMe8p1UpPa4wmAn3X4oJCB
	ncg5lwXKcbZ8ab4sTWjOA8XqLrqU3hSpi70NVZIoLIZnxbNdIVgmY2bIDDAouo18oXBbEFR2J
X-Google-Smtp-Source: AGHT+IGL+PtKUr5eZ+mANzrBQrF6tJP4JHS8yZ0mhNm5Rv4OrWq7HGiA79wb53NBZDSFfGYBMJn/Vw==
X-Received: by 2002:a17:903:2443:b0:290:bd15:24ad with SMTP id d9443c01a7336-290cb65b68fmr269267885ad.45.1761244089851;
        Thu, 23 Oct 2025 11:28:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb01915f6sm3089451a91.16.2025.10.23.11.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:09 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:45 -0700
Subject: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Enable network namespace support in the virtio-vsock common transport
layer by declaring namespace pointers in the transmit and receive
paths.

The changes include:
1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
   pointer for outgoing packets.
2. Store the namespace and namespace mode in the skb control buffer when
   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
   not have an associated socket).
3. Retrieve namespace information from skbs on the receive path for
   lookups using vsock_find_connected_socket_net() and
   vsock_find_bound_socket_net().

This allows users of virtio transport common code
(vhost-vsock/virtio-vsock) to later enable namespace support.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- add comment explaining the !vsk case in virtio_transport_alloc_skb()
---
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 29290395054c..f90646f82993 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
 	struct msghdr *msg;
+	struct net *net;
 	u32 pkt_len;
 	u16 type;
 	u16 op;
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index dcc8a1d5851e..b8e52c71920a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 					 info->flags,
 					 zcopy);
 
+	/*
+	 * If there is no corresponding socket, then we don't have a
+	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
+	 */
+	if (vsk) {
+		virtio_vsock_skb_set_net(skb, info->net);
+		virtio_vsock_skb_set_net_mode(skb, vsk->net_mode);
+	}
+
 	return skb;
 out:
 	kfree_skb(skb);
@@ -527,6 +536,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1067,6 +1077,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_REQUEST,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1082,6 +1093,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
 			 (mode & SEND_SHUTDOWN ?
 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1108,6 +1120,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
 		.msg = msg,
 		.pkt_len = len,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1145,6 +1158,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.reply = !!skb,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
@@ -1465,6 +1479,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
+		.net = sock_net(sk_vsock(vsk)),
 	};
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
 void virtio_transport_recv_pkt(struct virtio_transport *t,
 			       struct sk_buff *skb)
 {
+	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+	struct net *net = virtio_vsock_skb_net(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
@@ -1606,9 +1623,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	/* The socket must be in connected or bound table
 	 * otherwise send reset back
 	 */
-	sk = vsock_find_connected_socket(&src, &dst);
+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
 	if (!sk) {
-		sk = vsock_find_bound_socket(&dst);
+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
 		if (!sk) {
 			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;

-- 
2.47.3


