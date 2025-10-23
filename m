Return-Path: <linux-kernel+bounces-867554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E8C02F35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25086507BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D034C13A;
	Thu, 23 Oct 2025 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTTAcvJc"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B234AAF2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244087; cv=none; b=Vh6q8EiVpmrAy6DJh9XvI5uMClaB2G+BMmPPiDlYw5r9pDgkdlmVartcAQqM5cGvkQn6eiEDYKwsqKLndSs0p3hZwY/yBzaFbIyIg1IuOC+nx0UnlbhxP9RIXJNG+oEVMtusV4Gnxf/cnTJWyd7KnegQGjRGZLPFPssNwCzslSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244087; c=relaxed/simple;
	bh=DiDrb1BokArJE32Lh27GZlJPhGF6a+qvcuLYVDPWq/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u8fasfEf8Di3f3lHc8tUzVPJSzeEQYLwC0HTTuKgLrAf9PDDuQL1vMYy7Kslnv679MSmRkcfhQBRaQ+XVC8Rh9lYKJp0/Rybh2aSJ4d3n+GeZLT7pKazRbxZQ8Gu932ZN5o/CKFi1meB82FCFETnuDk/pz/tMl2MX8A6mFIsScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTTAcvJc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so1496964a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244085; x=1761848885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFTV345Uxjg8NO2N6HSXl0oNvQ4licLKHdUY0ZmDF6U=;
        b=bTTAcvJcPOuUichYxopxjkFdlouuc078rC4slf+Y6vqS1V6KYG004KLikpk8xlw4iZ
         qdfzOn2XUXhBMnqNt9SpxjvWPogKIcGc1StidBzpE+HlFNTu+zJQdmRLYy7XJzSYluH7
         YCECEZg+mR6iUZXxu0y43gMTlIVYjPzHuGbP0r+pNACRIStRrFBgHUlhh6hlvebwh+PF
         I0zFjl9zkLVIIySTUqvU24rXhA+ldZ/f/F05p/BxCFoLHDnqf1jIMUx7deTe6L7xEBo6
         Yhl2d95VunXf2kk/UxhFqyBvzoTRezbFgNXYJftu09dQthF9Ht28QuCDse4hh8dNraG+
         mHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244085; x=1761848885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFTV345Uxjg8NO2N6HSXl0oNvQ4licLKHdUY0ZmDF6U=;
        b=AraLHdKDVfK11MeFlZVBANY83eCMD0mJ8qAPv2muIRPxo5rrcJK91OJX2PFLOGUEIJ
         ywtkR41X52JpjKzuO4SSlS05wNGl31QhECCCeCyGsZevCgbqheAZDT8RVJ4yv2JIozWL
         PYLVy0WOvZOrkY8/cyR4Zsj1xiAbgpWckQiUnLtr3eTMqca1zlkvBGMqyG9WsaMd8bsL
         wr+HpnTNS9ABQR0BOxfPbQxvUmCirsE3GZEe1QkUkSNiEgkeqiXg+uw7qxEBG4mmNxza
         8uobhuENka+U+9v2+FDdKK6GHueKFkJHs1QBwozDt5QIOppP5plISS9IuW3HbZyYR9AW
         PMJw==
X-Forwarded-Encrypted: i=1; AJvYcCUDcNvWJ29fME2VqyemPsbZguTBjKctz9bU1rTrHfayB6fjPzZmSFdciBNYI8sQyAGm/HsdcjCpktr50HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wb4zvgKyQZXWQ5QKobPFQTLud0YRzYoAwcoo0rs9YOfpXD+D
	y9oNC5cN0ulyTCcF2/PJAG9Ttvx7oJZTuDXHY6pSiu3ghVfyP6Maj68O
X-Gm-Gg: ASbGncsb8mKPVRAZ0c2A5Peq2oTL3uuO0m2mWwhxQweS2rgeCMerGOImonXaBRG5007
	/yRuXLSj6da9CamXMjbOeAqbNrcey4ZEW/sO9p4yCL3Ims9xv/7ayZj4/b5WjXt9VUCivZ6czxo
	2ai1hpGnDCppGKIkMR8opza28KFsMUWl9yqrC4tbPopj/Vnwy6vrwEHaQ04c41QJfPRI0vYRyVA
	b85YBWdEA5rOe/jL3Thld2oxmKeEAptmtBn9lbz5IiOrOL61HmNk71wP7KcVTozhURW10+e+T0a
	Xh9Fuvv6PNTRbAgG57Q94lAPr/49GLG6CwP/dx1hcZgLjzDXwGmXrT70IpuZ0gUiqLlxi9+8nHP
	ZCxA0C4c2BgEutsiMEoHZe2IYURpD38xFYt1QfKpKFM9wy0Er8dyjFQl1CN2F58ZWf7D84/egM6
	si9HyB/IquXr5oct8PAQ==
X-Google-Smtp-Source: AGHT+IF5gCB8PDbjBmaJRaXuLaNEfiH+8q7bEw4A0Za+n8p2aXh1gbRC1f7GemMYYIIeYwiqsz/RpA==
X-Received: by 2002:a17:90b:35cc:b0:32e:43ae:e7e9 with SMTP id 98e67ed59e1d1-33bcf8ec899mr35313668a91.17.1761244084653;
        Thu, 23 Oct 2025 11:28:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb00500b8sm3093014a91.6.2025.10.23.11.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:04 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:40 -0700
Subject: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
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

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

A "net_mode" field is added to vsock_sock to store the mode of the
namespace when the vsock_sock was created. In order to evaluate
namespace mode rules we need to know both a) which namespace the
endpoints are in, and b) what mode that namespace had when the endpoints
were created. This allows us to handle the changing of modes from global
to local *after* a socket has been created by remembering that the mode
was global when the socket was created. If we were to use the current
net's mode instead, then the lookup would fail and the socket would
break.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v7:
- clarify vsock_net_check_mode() comments
- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
- remove extraneous explanation of `orig_net_mode`
- rename `written` to `mode_locked`
- rename `vsock_hdr` to `sysctl_hdr`
- change `orig_net_mode` to `net_mode`
- make vsock_net_check_mode() more generic by taking just net pointers
  and modes, instead of a vsock_sock ptr, for reuse by transports
  (e.g., vhost_vsock)

Changes in v6:
- add orig_net_mode to store mode at creation time which will be used to
  avoid breakage when namespace changes mode during socket/VM lifespan

Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 20 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea72b3bd2248..dd765bbf79ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27070,6 +27070,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..bce5389ef742 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -65,6 +66,7 @@ struct vsock_sock {
 	u32 peer_shutdown;
 	bool sent_request;
 	bool ignore_connecting_rst;
+	enum vsock_net_mode net_mode;
 
 	/* Protected by lock_sock(sk) */
 	u64 buffer_size;
@@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	enum vsock_net_mode ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+
+	if (net->vsock.mode_locked) {
+		ret = false;
+		goto skip;
+	}
+
+	net->vsock.mode = mode;
+	net->vsock.mode_locked = true;
+	ret = true;
+
+skip:
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * ns0 and ns1 are the namespaces being checked.
+ * mode0 and mode1 are the vsock namespace modes of ns0 and ns1.
+ *
+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *ns0, enum vsock_net_mode mode0,
+					struct net *ns1, enum vsock_net_mode mode1)
+{
+	/* Any vsocks within the same network namespace are always reachable,
+	 * regardless of the mode.
+	 */
+	if (net_eq(ns0, ns1))
+		return true;
+
+	/*
+	 * If the network namespaces differ, vsocks are only reachable if both
+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
+	 */
+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
+}
 #endif /* __AF_VSOCK_H__ */
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..66d3de1d935f 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/vsock.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -196,6 +197,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_VSOCKETS)
+	struct netns_vsock	vsock;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
new file mode 100644
index 000000000000..c9a438ad52f2
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+enum vsock_net_mode {
+	VSOCK_NET_MODE_GLOBAL,
+	VSOCK_NET_MODE_LOCAL,
+};
+
+struct netns_vsock {
+	struct ctl_table_header *sysctl_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	enum vsock_net_mode mode;
+	bool mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


