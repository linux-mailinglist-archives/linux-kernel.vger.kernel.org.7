Return-Path: <linux-kernel+bounces-863853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F6BF94C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 374CE4F3EF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFF2C2358;
	Tue, 21 Oct 2025 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bADi7B/p"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6A242D69
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090423; cv=none; b=jX4BNFa/KM4hbcgCbcfd7pjghGe8TPjvaMAUsdZqDyroXHTA4ghq1e5PfL9IOterarSGliuTxbfqxukmKfb98eB9h9CR570AgAt0/nAfaQr56aCrtz2zyeanWoN2E3vwQXR8OBRrho8q8Uyy1Hyl951cLyOTwrdjs8Swrcw59CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090423; c=relaxed/simple;
	bh=i/0blcvw30L2XmsZDP8JwezkIYQz0CtWUOjE1zydzXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u54hqmiVXwaalFjQXdwoEo2mck0lSKltPp1CcGDXznDBlSNcQgVZ2wWyY/g7WCWZOdEjJGbU0Lr/0I57i66f7y3iT6ItNzkvivPKFss24kuEkfLhVaYNhAAbCt4B9T4GWYvUGgh6jVQwCZZPz8qKPktGeFhWz2Z6j0SksN3qz3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bADi7B/p; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5620966a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090420; x=1761695220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ux00ENqxNtzazJRP0kNIFZEFFfqT/sB9ciqM1XMIy8Y=;
        b=bADi7B/pZVDCE7VQv7lugnzQ18wRMEqm0V+SsIVNvoOsEejkuOFcmucO70NUMdlrRn
         nDgIfYNZFKZpatd2u9Ouia5gQcwNGRFmEg+bTsP+4w5feLim+Bj8M5wP1FHn6cjbhGqj
         IZeB8umpj4ftY9zphnMT5lDd5Dv8NP8ePlgItJgbl8NvdtI8GbT1A8PicdvliKK9dBkZ
         ZzJ33tn28IB63lB35dsp6/9vnTxSg3zAC8vCxCg8lfa0MlVsmXgR8pPI6Yw7Tcpegb/J
         VUs6rzSPXDRveYIJ2t8enX41n3ysSdp7tQMviUFFnrHbwM14mZCDSuzwgkvodgByLUvy
         vz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090420; x=1761695220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux00ENqxNtzazJRP0kNIFZEFFfqT/sB9ciqM1XMIy8Y=;
        b=mB7g4EFOgyLYBdL9mkFupmpApog8q/ecEX5QIixHwV45+4MfZdC/i9rjSXZu9QRiI1
         wXwFjGnaEeYp2xdZNlAhXlx+ryVL9IvWaSQX4cbFOR7frX0xz2ZflOqx3ZqyySULmL5u
         M7utMuTNdYP7DXRXkioyk+ryurjmyAX+8yi2Ruhfhzrs5Gx/I4N0ZnTaQ2O1yPC0EPjs
         XPLEttz7x9rmYguBdHonMHQ5DLa29IOy1oYG5l0Mui3kPgdepZbfjsXQ9pdjhlvixNHi
         GSmadoymZD0bb5ZTl/9Q9sxWacRv2pqHg79vOWOKYp4X7Nwres4vuse33iZ1wzPAHdA3
         IvLw==
X-Forwarded-Encrypted: i=1; AJvYcCVfrZ35lR2+S9O4Kaqg71xSIdXbJQRQ9vkqNgzpbhiSXXMhq+/KmZxfvUoEyl0xG0yuFXIX4K4yFQo5BVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywgiDkI2VqP2vfncZaVD/PAV7Zc86KubDgvgdBn3OguY8CSfZY
	LD9WRlkI/7+9yAhpQbOHUYP02JuXREXcMANXXEKVuD+y1M7ILzG3Sf4N
X-Gm-Gg: ASbGncsHpvnapIyt1uDzG0lBfSpe5hWgRjrmUzkjNNQQ3fbw5rkeU4OvV5UEQOVBUpQ
	4sGyVIigqbUE83C5hYUEDCJ3YhZNX1lWtPbmGRDW9jgwlPmyPK1uvuotKIukA0hMaeX+3EUn2Tv
	GZp3Ovm3yYolhQCO9h4HPJhBjaWSgfte0j5G7TSLpqIxPgenn54YMQ9GCnm6h4opJ+W5YS/vSEB
	kZmxxLcckeGKiaE1XRkiHWUcNDHcPwXt85H28RrXPUmyUVWp+OrhzP14LNlvdq0eW5eEUqMDuqa
	dH9qsEHjl+rK8bi+ERGW5m73xSFQkYAojHHLmVQhJ3qdK45H3Hw00YCnPlgT8FJQTVQkLS8RhXU
	XE+5hmnxLtL+SEQJof97UWZf6iB4Lm6QdvXRStBppowWboCkiNUHhPYgD1cLnqSJ/vPodKFOZ
X-Google-Smtp-Source: AGHT+IHeGId/ywDSD1+B3HjeV1Dv8DYhirb7ZJAGBaWWTqw55VcAYUuGBf/b9fQl2uNxLFwxdMYmNQ==
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id d9443c01a7336-290ca1219e1mr253823315ad.36.1761090419637;
        Tue, 21 Oct 2025 16:46:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9e8sm120714105ad.85.2025.10.21.16.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:46:59 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:44 -0700
Subject: [PATCH net-next v7 01/26] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-1-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

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
 include/net/af_vsock.h      | 64 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 +++
 include/net/netns/vsock.h   | 20 ++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4faa7719bf86..c58f9e38898a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27062,6 +27062,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..a1053d3668cf 100644
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
@@ -256,4 +258,66 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
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
+	 *
+	 * The vsock namespace mode is write-once, and the default is
+	 * VSOCK_NET_MODE_GLOBAL. Once set to VSOCK_NET_MODE_LOCAL, it cannot
+	 * revert to GLOBAL. It is not possible to have a case where a socket
+	 * was created in LOCAL mode, and then the mode switched to GLOBAL.
+	 *
+	 * As a result, we only need to check if the modes were global at
+	 * creation time.
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


