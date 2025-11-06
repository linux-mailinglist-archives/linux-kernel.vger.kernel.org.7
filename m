Return-Path: <linux-kernel+bounces-888977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF8C3C6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5EC350745D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCB34F262;
	Thu,  6 Nov 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4sD0KeC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBG2pp4c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BF34E768
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445803; cv=none; b=QSbkHY0DexokbBGblQ12OiA9Bk4FCdXZVj6+ltUQ+FVkswGOIndgAH478AQsmoPHbfYWPA0eWjNtwifNM1aCW8FJPcoAt2Rds7252go+a51TaaTCpKfMJQOIy8IdrP/e0oWGAEECcGwLEnddz0cd1QgsV5oq8IH3LY5Dzvgs2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445803; c=relaxed/simple;
	bh=i/8NfWeaVmGYtdgwxg3Shw5m6QrRhC9a+10xuDuOASI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXLbPqNuEglLWBfWftJYAz9BLHDqSbI+QjUSXen74w3rGoZy2wHNkfvU7uHce+cO6mZG/pHbQtKhVNTIdTg5OzpQ0OSDwDo9WBsKTsax7I72JuuZFm11yRizbfPycgtHYHbV0sLSuE+S8N3gUzmnGrhqdlWYr8rKCyPXebGSYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4sD0KeC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBG2pp4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkjylwINIU5HSaWdB7FaExTHRZy7q5R+JtVakXkWhYE=;
	b=K4sD0KeCPwUfSi9/cZgpD5r7c2T2SURJzuBqlOJY8QedPY6fx4m6EYHXUZjx0WROSMTQTo
	OYn0uCIi3gIMUnxJpiPyCtrUQJeKdBvDmMnFEEPrechI43pjgNvB5PtmUlLAFEKkRkklH7
	0I6etAlclnLquAookD7tkUHRUuvoieA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-URkIdxwrN7Oa3vLmdQWAVw-1; Thu, 06 Nov 2025 11:16:37 -0500
X-MC-Unique: URkIdxwrN7Oa3vLmdQWAVw-1
X-Mimecast-MFC-AGG-ID: URkIdxwrN7Oa3vLmdQWAVw_1762445796
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47111dc7c5dso8524475e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445796; x=1763050596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkjylwINIU5HSaWdB7FaExTHRZy7q5R+JtVakXkWhYE=;
        b=YBG2pp4cc5INhoMHEJKWGHT0S9wW9A5giiuhnlDBiTNGtzqFvJrO2/8TLKJosk28wU
         kq8ACCwaCdvussTxRHbkQ3ZlQLyVm6tpoe7l78CfhvmezwvOcN3ymnyyVxValid/EWOA
         E1n5EPtT7mJAWU/bMc9NH0zerZqbo7QvkzHyNPfQ8T3YH3gNLPro/tm3cKig/kVWRLbn
         kViI9+ZFt1GPg9fWf0l2/KwllvUBZf1WsabkQuMVvFSCUCenW9g0aHuuyXEkb3L+hwxk
         GGWte6m21wTOoUOzrhGN8W1Twm6hghY1lMZJe+uQf1hpGw38ocRS7moOUhNxya4X3Uw6
         UfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445796; x=1763050596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkjylwINIU5HSaWdB7FaExTHRZy7q5R+JtVakXkWhYE=;
        b=LyRljro9UQsZvEXtlUI1K69M1ThGhC0LRF2yLeS6dZWmLCAEA9OfNixmIhl/NVuLLa
         jVwq+USPn9cpp79s3HSSOmwQG4u2d/xuttrqWjxvgzUoko9Ck1KM52FsxWIZsvtiEXOI
         SeLEcIjzrKrIOMAkQnruvb7CZNUXPTcQtWvzzEZQU6g/y/7/wa16/scAUGk/uyo2OCRe
         InA6OknyPMk88Ukx8jG6Ejon8nG7Lo0GebQl/3W6Rq2E6MXtcoC6JygO3c2nkyxMeoy6
         3IPO+di+QL//a00Xv5nurXxvQw9kFFo2nHwAazLgKOvh4CwOOUhA1mBL0C3K04pwtE+v
         1XyA==
X-Forwarded-Encrypted: i=1; AJvYcCXA1cFQ3sKvSz5tkT8Z2+j9Q5FDWnm+s3wsimBwZX4SHYTTX1J27c9YrX4gtgJZA7GrDc3ZAr9RdOtcps8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPpq4jHkxB3nIIVdaeqmZjg2DQeRBIn1N59S8lLZ+4zo4VhNya
	mmr5cIQvuRMm+ZKF0c9gI4HkX5eDRczLqh/JeSybazQRiZ5SBaH2pAKUw6r/d2l5PKlkqkxpsSU
	w3ijEZKmxa8nPBSfWIbxRzDwZVzmRmpz9o9IWID8fqsBP3fOLRY+sE9a8sXDHpfX7ig==
X-Gm-Gg: ASbGncvIIsM6mb18fhvym8rxnsEmxnOvNK5AKOwWSbgg1z1d5QnLH4qCPXXYmdEQ3M6
	8WsL/7Xtl5yI4JqprltRRNIhtJvVpWeL7zvttSgY3jDKCBReDCDjypnW3UVGZ7GtOMVxmg5378+
	TeqYOdV8P4F7HRaimuSj67QskHgmds5raqfa+qVG/n5IJLmn+3sVgKxR+7HUlUEMlEZh4pQew7k
	fH86Dl9wiFLUmmLpzXuqPUxetw2oPpzlLCBpVxHKcYx80naP8CzKu2r02OrsmH4NwyBmanFmgm6
	wTexsOkViuNPD9Pqp58gVhnEpR0FDHUY0uJ95Me0tsmy2NRxkNNcFfkpIV961cxYQuXHP4PvqV6
	UKg==
X-Received: by 2002:a05:600c:a319:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-47761ffd202mr31399315e9.3.1762445795596;
        Thu, 06 Nov 2025 08:16:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcQXC4YnwE/PQ+ijTNkyoOSX9UsN25PfogCPhapdwJBghlV/xWhyJogBVKmUHMWkthlmL/Gw==
X-Received: by 2002:a05:600c:a319:b0:471:611:c1e2 with SMTP id 5b1f17b1804b1-47761ffd202mr31399015e9.3.1762445795119;
        Thu, 06 Nov 2025 08:16:35 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329afsm110992465e9.16.2025.11.06.08.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:34 -0800 (PST)
Date: Thu, 6 Nov 2025 17:16:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 01/14] vsock: a per-net vsock NS mode state
Message-ID: <iiakzdk7n7onhu5sncjd7poh5sk34nrtvusbiulsel5uswuekv@p2yzmblg6xx7>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-1-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:40AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add the per-net vsock NS mode state. This only adds the structure for
>holding the mode and some of the functions for setting/getting and
>checking the mode, but does not integrate the functionality yet.
>
>A "net_mode" field is added to vsock_sock to store the mode of the
>namespace when the vsock_sock was created. In order to evaluate
>namespace mode rules we need to know both a) which namespace the
>endpoints are in, and b) what mode that namespace had when the endpoints
>were created. This allows us to handle the changing of modes from global
>to local *after* a socket has been created by remembering that the mode
>was global when the socket was created. If we were to use the current
>net's mode instead, then the lookup would fail and the socket would
>break.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- clarify vsock_net_check_mode() comments
>- change to `orig_net_mode == VSOCK_NET_MODE_GLOBAL && orig_net_mode == vsk->orig_net_mode`
>- remove extraneous explanation of `orig_net_mode`
>- rename `written` to `mode_locked`
>- rename `vsock_hdr` to `sysctl_hdr`
>- change `orig_net_mode` to `net_mode`
>- make vsock_net_check_mode() more generic by taking just net pointers
>  and modes, instead of a vsock_sock ptr, for reuse by transports
>  (e.g., vhost_vsock)
>
>Changes in v6:
>- add orig_net_mode to store mode at creation time which will be used to
>  avoid breakage when namespace changes mode during socket/VM lifespan
>
>Changes in v5:
>- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>- change from net->vsock.ns_mode to net->vsock.mode
>- change vsock_net_set_mode() to vsock_net_write_mode()
>- vsock_net_write_mode() returns bool for write success to avoid
>  need to use vsock_net_mode_can_set()
>- remove vsock_net_mode_can_set()
>---
> MAINTAINERS                 |  1 +
> include/net/af_vsock.h      | 56 +++++++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 20 ++++++++++++++++
> 4 files changed, 81 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index ea72b3bd2248..dd765bbf79ab 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27070,6 +27070,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..bce5389ef742 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -10,6 +10,7 @@
>
> #include <linux/kernel.h>
> #include <linux/workqueue.h>
>+#include <net/netns/vsock.h>
> #include <net/sock.h>
> #include <uapi/linux/vm_sockets.h>
>
>@@ -65,6 +66,7 @@ struct vsock_sock {
> 	u32 peer_shutdown;
> 	bool sent_request;
> 	bool ignore_connecting_rst;
>+	enum vsock_net_mode net_mode;
>
> 	/* Protected by lock_sock(sk) */
> 	u64 buffer_size;
>@@ -256,4 +258,58 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	enum vsock_net_mode ret;
>+
>+	spin_lock_bh(&net->vsock.lock);
>+	ret = net->vsock.mode;

Do we really need a spin_lock just to set/get a variable?
What about WRITE_ONCE/READ_ONCE and/or atomic ?

Not a strong opinion, just to check if we can do something like this:

static inline enum vsock_net_mode vsock_net_mode(struct net *net)
{
     return READ_ONCE(net->vsock.mode);
}

static inline bool vsock_net_write_mode(struct net *net, u8 mode)
{
     // Or using test_and_set_bit() if you prefer
     if (xchg(&net->vsock.mode_locked, true))
         return false;

     WRITE_ONCE(net->vsock.mode, mode);
     return true;
}

Thanks,
Stefano

>+	spin_unlock_bh(&net->vsock.lock);
>+	return ret;
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
>+{
>+	bool ret;
>+
>+	spin_lock_bh(&net->vsock.lock);
>+
>+	if (net->vsock.mode_locked) {
>+		ret = false;
>+		goto skip;
>+	}
>+
>+	net->vsock.mode = mode;
>+	net->vsock.mode_locked = true;
>+	ret = true;
>+
>+skip:
>+	spin_unlock_bh(&net->vsock.lock);
>+	return ret;
>+}
>+
>+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
>+ * return false.
>+ *
>+ * ns0 and ns1 are the namespaces being checked.
>+ * mode0 and mode1 are the vsock namespace modes of ns0 and ns1.
>+ *
>+ * Read more about modes in the comment header of net/vmw_vsock/af_vsock.c.
>+ */
>+static inline bool vsock_net_check_mode(struct net *ns0, enum vsock_net_mode mode0,
>+					struct net *ns1, enum vsock_net_mode mode1)
>+{
>+	/* Any vsocks within the same network namespace are always reachable,
>+	 * regardless of the mode.
>+	 */
>+	if (net_eq(ns0, ns1))
>+		return true;
>+
>+	/*
>+	 * If the network namespaces differ, vsocks are only reachable if both
>+	 * were created in VSOCK_NET_MODE_GLOBAL mode.
>+	 */
>+	return mode0 == VSOCK_NET_MODE_GLOBAL && mode0 == mode1;
>+}
> #endif /* __AF_VSOCK_H__ */
>diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>index cb664f6e3558..66d3de1d935f 100644
>--- a/include/net/net_namespace.h
>+++ b/include/net/net_namespace.h
>@@ -37,6 +37,7 @@
> #include <net/netns/smc.h>
> #include <net/netns/bpf.h>
> #include <net/netns/mctp.h>
>+#include <net/netns/vsock.h>
> #include <net/net_trackers.h>
> #include <linux/ns_common.h>
> #include <linux/idr.h>
>@@ -196,6 +197,9 @@ struct net {
> 	/* Move to a better place when the config guard is removed. */
> 	struct mutex		rtnl_mutex;
> #endif
>+#if IS_ENABLED(CONFIG_VSOCKETS)
>+	struct netns_vsock	vsock;
>+#endif
> } __randomize_layout;
>
> #include <linux/seq_file_net.h>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>new file mode 100644
>index 000000000000..c9a438ad52f2
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,20 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#ifndef __NET_NET_NAMESPACE_VSOCK_H
>+#define __NET_NET_NAMESPACE_VSOCK_H
>+
>+#include <linux/types.h>
>+
>+enum vsock_net_mode {
>+	VSOCK_NET_MODE_GLOBAL,
>+	VSOCK_NET_MODE_LOCAL,
>+};
>+
>+struct netns_vsock {
>+	struct ctl_table_header *sysctl_hdr;
>+	spinlock_t lock;
>+
>+	/* protected by lock */
>+	enum vsock_net_mode mode;
>+	bool mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>


