Return-Path: <linux-kernel+bounces-897361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F536C52AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E8804F9D95
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2213283CB0;
	Wed, 12 Nov 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6KzZToe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaoUjt4L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CB274B2E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762956828; cv=none; b=Sne/FlxhyrXhkjx3xc6jvAzKQ9WiGv/QA8ilxeCM5Va3Wqq+8mWJIS7zb0gluxG5KDNhlp7HqJ+g6Vdssq6vO9v9fsB3R2d6SxrU4tXS3QJRWOQGZAJ0mCn9r+rlFVmvN2J49lIO8BGnFmQ02nso6ZtT4PF/K9UMQvz4mGrm9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762956828; c=relaxed/simple;
	bh=0efl0X57BhletZnyf/eddvK+jKMzKLs1ot/NC4gKr6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0B/TbwHjfmz6xZui4p9GkflyqSqFWPpYQ9+wLVXDQ5wrjEw1+rExH6YkyOrqU9oYSfJIFWgO+mNMjWOTtCOjL/i3eNw5wtK50bivqtqD7WUDWXQPDJHgY2SrDwSrFs4hFFS1SFChvJN/GSBpMcDWyS5Lv/z73YSjIFNNwXOFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6KzZToe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaoUjt4L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762956824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9EWdL2WpfP4agPf1IrRgcJrlbWTrsDu6O8KsN+miJKM=;
	b=N6KzZToeLqDgldiMJ8vOskVStiyxYpIy1xkuRIkCYNpciqK85e3WMXWwx5R6VIT6YpYOqu
	oCKsMCmPjva69JlxNUFUnOUOWUzc7w81x6vPHmCHO63pZnTszMDz+6NhXXpAiRW2hpgbp3
	w9uRLD8u6PsANbsRrY1WZYsnoqWOwGc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-Wxy5gFWiMy2hKGQHyRLZVA-1; Wed, 12 Nov 2025 09:13:42 -0500
X-MC-Unique: Wxy5gFWiMy2hKGQHyRLZVA-1
X-Mimecast-MFC-AGG-ID: Wxy5gFWiMy2hKGQHyRLZVA_1762956822
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed6466f2baso22256341cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762956822; x=1763561622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EWdL2WpfP4agPf1IrRgcJrlbWTrsDu6O8KsN+miJKM=;
        b=ZaoUjt4LbGisC7sHCt8fYVo7RDIQwON7QQGqtehGQElUOTZ7Yf5RUtbclSHriAICKA
         BS6Uw8ZVUPH0YZII//EzCg39tvZNe7DXmVf0b+c6gZF5m+eSnewkB7Vh6HunVS7p1QMI
         sPvTUf+ASxZ/RUigd2lolnVxnD0q3p8ybGuENH01xozrzVeDPrvHw7KkTE2EhPKUKVRS
         9WdCP9Di5N/P1Ik9t4KTaOJnS8JPpDJ8KoqW69iOlb4IQgHnYQBOtk6QvMoTyohsyI6v
         37AvF8HNap0kjYo5Km8Kks59WlO7aW4sRXjQqEA78vUKoxjCEjf2EEpk0g++PXiHHNAN
         Lu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762956822; x=1763561622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EWdL2WpfP4agPf1IrRgcJrlbWTrsDu6O8KsN+miJKM=;
        b=h1ouSFmN/sUf2CdJDOvOcz/jxGzoWtwwNyyGmXTUDuoVUwhOh8p3R5d8qsLXGtnM99
         L1dK3iFsE5NKJ9k1s7POSSx4l4AnZSFriefteRahXtvg1CWhy6xkdXsSydsYb8BHtc1T
         eQNZv0YMNN+NYvKrm5SiqL+MrT+QnKdtMwv5RQDEYHt7FNhzKROW9aLOlDEgpOrmrXSt
         5jpjS20KUKl5k8gmOctXmIMyqooxPoGf86Rt4LPcvs5YUIOEeuc5TJsCjolk2L2CEQ3F
         AriW+asdsxgql5AnT/ehwdS/d1wqQBvoc9bom+KNwXdhReuT11UF50DIkxGPphXgCR8t
         ylzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFSOO5zvs72mwMbDdJaOyvnbvTecLPSI5yHu1aAXKemnuDAd87fZfxj02ZdcI9/R2mbT7OUc25Cf1PVlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzASvIaWMtkPcElKqh8QTVdWEozTDw/W12ZBfuX1mVP8RHivzQe
	NNx0Iw0hUr45uxWBPehXm2IYc2QYklHfr5rYWaTvK3Hv9/WX8ic1ZhgO0QiSDXEbvcsVEbp4s9R
	qDLOHQe8tpZ+eQ8FVLY1LaKU/HxZAzwkQ1+JeN6q07xoFNLP3fGB/PmlBnuzGMWQ4tw==
X-Gm-Gg: ASbGncv2QG/WU9dBYRJmzXe8UT/OkMemI8FjLTFS970BFfEu/nSO2uE0mkzjkJfVRVe
	6x6I0B9sibaPcloyW67OcvgCE0C2hCSZmwv6P+fQIHkwXwGUCZNd4yyEAwKbNmVma1i41dm7gLN
	uCOwMuc6OpAbl7eRfwvj+7fkMFReUecdOH8Mdd78cNbiZxkgtjbSQ0QvPYtwVZ03fxg4OEKLsj0
	bEwbAUTi0F7A414BlmC07olweIMEgYGbvbgtZR+m6PZHlIDamuQJ1g/kiairQyHwetWf5g+5Rsr
	e7k5IlvdJNfObS7lE4uOFTnkXktHR14mDLfpaybDwEZT4mHVg3suro7mXQV/oML5u5eYJmK1yLy
	5fwQLhx8Borqra3MnulPXtuKLvquZgN27ePbYOKpmnCdCWiB00U8=
X-Received: by 2002:ac8:59c9:0:b0:4ed:6fe8:1396 with SMTP id d75a77b69052e-4eddbdd6d1amr37245981cf.77.1762956822187;
        Wed, 12 Nov 2025 06:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDn3sUGixjKRYmWarO18Beo8/5b+a9+r56tGzTb/AmMIrdVHA0QqmPP6HV3IfDjsUZ1ypKuA==
X-Received: by 2002:ac8:59c9:0:b0:4ed:6fe8:1396 with SMTP id d75a77b69052e-4eddbdd6d1amr37245241cf.77.1762956821641;
        Wed, 12 Nov 2025 06:13:41 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda578532csm86211281cf.19.2025.11.12.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:13:41 -0800 (PST)
Date: Wed, 12 Nov 2025 15:13:34 +0100
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
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 01/14] vsock: a per-net vsock NS mode state
Message-ID: <fr76vx3j47n3nfh753z2stwyu6k4lfdkx7zoisusdbiu27azjr@hygsraaern74>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-1-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-1-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:43PM -0800, Bobby Eshleman wrote:
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
>Changes in v9:
>- use xchg(), WRITE_ONCE(), READ_ONCE() for mode and mode_locked (Stefano)
>- clarify mode0/mode1 meaning in vsock_net_check_mode() comment
>- remove spin lock in net->vsock (not used anymore)
>- change mode from u8 to enum vsock_net_mode in vsock_net_write_mode()
>
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
> include/net/af_vsock.h      | 41 +++++++++++++++++++++++++++++++++++++++++
> include/net/net_namespace.h |  4 ++++
> include/net/netns/vsock.h   | 17 +++++++++++++++++
> 4 files changed, 63 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 0dc4aa37d903..15c590a571f2 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -27098,6 +27098,7 @@ L:	netdev@vger.kernel.org
> S:	Maintained
> F:	drivers/vhost/vsock.c
> F:	include/linux/virtio_vsock.h
>+F:	include/net/netns/vsock.h
> F:	include/uapi/linux/virtio_vsock.h
> F:	net/vmw_vsock/virtio_transport.c
> F:	net/vmw_vsock/virtio_transport_common.c
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index d40e978126e3..f3c3f74355e8 100644
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
>@@ -256,4 +258,43 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
> {
> 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
> }
>+
>+static inline enum vsock_net_mode vsock_net_mode(struct net *net)
>+{
>+	return READ_ONCE(net->vsock.mode);
>+}
>+
>+static inline bool vsock_net_write_mode(struct net *net, enum vsock_net_mode mode)
>+{
>+	if (xchg(&net->vsock.mode_locked, true))

LGTM, but it seems that some architecture doesn't support xchg on 1 
byte, e.g. see commit d66a65b7f5d2 ("scsi: elx: efct: Fix link error for 
_bad_cmpxchg")

So maybe we just need to change the type of mode_locked to int.

The rest LGTM.

Stefano

>+		return false;
>+
>+	WRITE_ONCE(net->vsock.mode, mode);
>+	return true;
>+}
>+
>+/* Return true if two namespaces and modes pass the mode rules. Otherwise,
>+ * return false.
>+ *
>+ * - ns0 and ns1 are the namespaces being checked.
>+ * - mode0 and mode1 are the vsock namespace modes of ns0 and ns1 at the time
>+ *   the vsock objects were created.
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
>index 000000000000..21189d7bdd4e
>--- /dev/null
>+++ b/include/net/netns/vsock.h
>@@ -0,0 +1,17 @@
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
>+	enum vsock_net_mode mode;
>+	bool mode_locked;
>+};
>+#endif /* __NET_NET_NAMESPACE_VSOCK_H */
>
>-- 
>2.47.3
>


