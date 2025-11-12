Return-Path: <linux-kernel+bounces-896616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4E8C50C87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 301D334C697
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25202E7659;
	Wed, 12 Nov 2025 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b58GMzo7"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8D2DEA9D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930539; cv=none; b=Vp8ndVm9xk+2vpFHPoBLBkmcdVOeH6tCYQYSrP1l6VFJpFEqi3wTWR/nrCAeZFhCAAZX2B6Tv+di0l0CBZ61IfcVeEPF0v/1oWI1wnntk4qQGVME3ZF+Hivo5nwiu9QHKx1VQRwPhNKZ9PXFA1XRcEhtnCmjR4/OiYZ/F3SM5vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930539; c=relaxed/simple;
	bh=XNKPdVFzsGOhe2gZnl7us44PlmC+Oq2NfCeV3pOPxu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWuWIZLHZZZAmqUYWjo7lvQCDWpKlTFXyuQIKtts8uVQC1vxfhFpZxBDQiE5YtqqDpaU2CWlD8OSAdm2vDrhONVIE9Y+kodXZC67+p43oH7/VchOAZTjmKN/ObzdsIlZcUTWTtcqBdpQDeYyCYWpnMLc5rll3IH86gxPamn0xvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b58GMzo7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so610460b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930535; x=1763535335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO556RbKEFfkt16keFlex8O2QEbd+b/5QmAbZJPQ9N0=;
        b=b58GMzo76skLhZopszLjo+liDdvg/FVn3Fgcptr+G3vwInWLzylBOmwhI8kw2oIUEp
         ijuhh+ukByEVSQ8kVOLVkKecqPRj3MRhUJF2mLqi2AJYmzWfJxV9jCnDHxgEpVtUg+2e
         qKG2M/KUzDYtw89Vp4+Un8Cl/jLEtrFk92NatBayZn6ykrhDZDJ8MeM5tRnrbPJcI98h
         sz7nyMOrR1WRUyLFmh39lYciCKjBNsZoY9D7nAFymtWvM4m6HTqYRaXXoK/4IbcZlxc1
         Jd0D+NZES237YpPrCRaBsWFH1mrEntQHO67iQzqPYXHAVmeHqrQinE32dcV8AyJjGaUW
         ZgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930535; x=1763535335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XO556RbKEFfkt16keFlex8O2QEbd+b/5QmAbZJPQ9N0=;
        b=o5yMO8t70hxZdmqHsuHX+d+w/hLBsI3F3xHkRpd+47eZUjOXZyq9X2jqINB8CysZfm
         hTOjF/HSXKmgy/6M3eGlem6jNIbDscS49AhAtxkfHOaRMSuH+nBFImPCumd1+oPpdSca
         vb2G3GPvGmkb1+WFRn9rKWdEkM6akQCQQD7npMwfofVj7dA/Bdm7FAVnG4YrUFgtzw4/
         z1usrQ9aGgbXlawchZlcSKc9JvL1mYCg5cHOZZDxj98e7LtlGwhCeYNTqlGrQi4RDsmF
         tMrRZhvBRG62FPkB37mEdLuF9l7zHwulxItp3/vCZFJYKNIzr94E3F/ocYraN5bITDFA
         HXAw==
X-Forwarded-Encrypted: i=1; AJvYcCUB8z+l5lEFLXPs4Jus+BgFpDl/gX22+ji/z5bHvXgl7Ng0uf0uZb1/uWRlUIwaDL1NdkYOr+XIanQ0/XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscwaTP+ktQaABJNLKt8JATooGp5LBEvLEhVOew3S0XbXF3XSl
	0a41hqhYHfr8PeEBOYc7Dl8w6dp4iGf1FvxvBHrZoe9n1AySRB4xDs+C
X-Gm-Gg: ASbGnctuVryz3FLD2svCJe8MEQHsuJEKMvVyq9Y9cJqWHRU6jK0zCYz8vBM7OGDgnsJ
	Qt5HbDxaaejcIrZAqe/Z5/+AdrZU9vEGrqljNSrWrTqma6yXmoHzXkdx8z8vO8KBPOclnWCPcIK
	yfsK2ah6vUfIYaXYKNNnn0qCtJU4qxcjmq3dgolbWoojfACFt0BWtggVqgNnrIK6Ei/WG+tswYV
	019C48At135TkuTH267BPjzsSnJP54ByI4jp7amEYNC1QIOrLFZiHT9h9uuwGWl1I73zkfAl/Hc
	qyrPqkjvTCTwNcdF8QqvBxwzMe/PRW3Sod/tZDzwx/EJtGG4LtFNd4w53qQv/jTUIEABPNIQsPr
	nz2F1QO4DJNwDo8K7VR1vKMNjnhpRyr4C86/cMbZU65f5Bu5cNKk7iQ9IsdUFb4wl3bftCdoSWS
	s9Yx9TZx1Y
X-Google-Smtp-Source: AGHT+IHw6FTIrKKSfth7PvKmf1SMuZvbFzVkENfrJWnCdW+MPXVPvLXcgFlxafJvz3YTvCET4aFGOw==
X-Received: by 2002:a05:6a20:6a20:b0:342:5ba7:df9f with SMTP id adf61e73a8af0-3590b812ac2mr2702896637.55.1762930535537;
        Tue, 11 Nov 2025 22:55:35 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0fab0ef9sm1730250a12.9.2025.11.11.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:35 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:43 -0800
Subject: [PATCH net-next v9 01/14] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-1-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
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
Changes in v9:
- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
- remove spin lock in net->vsock (not used anymore)
- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()

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
 include/net/af_vsock.h      | 41 +++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 17 +++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0dc4aa37d903..15c590a571f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27098,6 +27098,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..f3c3f74355e8 100644
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
@@ -256,4 +258,43 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
+{
+	return READ_ONCE(net->vsock.mode);
+}
+
+static inline bool vsock_net_write_mode(struct net *net, enum vsock_net_mode mode)
+{
+	if (xchg(&net->vsock.mode_locked, true))
+		return false;
+
+	WRITE_ONCE(net->vsock.mode, mode);
+	return true;
+}
+
+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
+ * return false.
+ *
+ * - ns0 and ns1 are the namespaces being checked.
+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
+ *   the vsock objects were created.
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
index 000000000000..21189d7bdd4e
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,17 @@
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
+	enum vsock_net_mode mode;
+	bool mode_locked;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


