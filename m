Return-Path: <linux-kernel+bounces-834441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5964DBA4B22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD5E4A28C6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38852FFDFF;
	Fri, 26 Sep 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYaNjdkm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AABB2FFDE2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905002; cv=none; b=aigizl7ufRXzttKT4a5X5DmDFm8ZxP7elUyDiRwATC+DHm+oagO0QU7FJ2cyONUpAG5dsda/bYAmKsVG5tUSr2LpNilI4UiAxPZJdA+G4HuBysEwJxdwPjO+cICTERHJ+qJXSSniNwefhzoNhQOIMh4N3j0PzEC/bwNVENYcjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905002; c=relaxed/simple;
	bh=+Qi6lHi3BWk4h+soVr8AsqrSbtdpevz1/dCL0JiOSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA7M9m6EuBxpXODlNSfKVjae2crE+h9CXoRh/t3SwkgGTSm+SQpLUtq5zBTF29fsgWYLgKKX9y0YdaU9RHpKkkXPn44tMpLzFlEJNPyrnS79IKin+OHj4sIyDRj+PCmhcu6uFNkwx74xdGwtgHg88Q5peEJuZybuAMHdGmkIXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYaNjdkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758904998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0W6XP1kSbzIw7BM2wwEE7uA0WcDIj3WgTXNjhtqbHyE=;
	b=JYaNjdkmSd3KbfZduIu7RtdRa4R3LWctJGW/hgjMNq1BkFWcGkFFxbsi0BfSPVAVJOOxse
	aGDzz4+WDWhyaOJGlH3azwQnXubb5hip72/sxYxjYQIyaDWDwEtTur7BME4AsWm8Id8LEQ
	kWc8Eox8Yl+AeCc81SZvZRzIFUx4WQk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-jcSHIPw3NMaC-aKFcRiGNg-1; Fri, 26 Sep 2025 12:43:15 -0400
X-MC-Unique: jcSHIPw3NMaC-aKFcRiGNg-1
X-Mimecast-MFC-AGG-ID: jcSHIPw3NMaC-aKFcRiGNg_1758904994
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so25671235e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904994; x=1759509794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W6XP1kSbzIw7BM2wwEE7uA0WcDIj3WgTXNjhtqbHyE=;
        b=YStfVE3yIn24ea4iVw/wEAFXHJJn6SoIIn1xcdXyv6TpuGXP1IhxLsVEPFn/i7Alkd
         JpWRiBJzoRstK8dVi86+iTxpD6rjyEOJL42IyAJxoxZaOXBONvrdtfz5uLUsRmPN6crJ
         Bj+e6EqYDdrK9/d1F9RrHNurvOjtq9JM8N/UUrr8AKcX2JYLtZDvSqcfVXoXrMhEq2fu
         bi5tbFOeBXLwZ+pMYoBM3iYL0rDr0UdeKohWfQ3i8E/pBcZOxTe0bgk28QWolm+VxbEU
         8EcPmr/TXF1eK1Nz3sicAfxdzthxTkAopM/1kUMCnsejD2WnrEYzgWpwQc5jwuuLNVqr
         6wgw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYo2mBfaU9XwuRjlKdn6Y2GNjC4CZiDomWS+m4GCvlqbpd0gzufVnOfrpQo7xZELwGEEVc63wqDvydpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrbvqn53ZZ2+I98vYJyrTJaywgN1ulhkfW3d3qQRNKZG+Ao/xx
	ND1KZFA2Fz2tQeSwjyDHQ/noEzYjlAk/4FguH6N/WvCK8GVOLG3Y6FkkdUItJ/qPMr7M6hEez0M
	O9pT0sFWkRFQJ16BS5Wj4EX9uEER0U/alFHORsy5jw69ZSDjn0QdAGouUOCitMl5QaA==
X-Gm-Gg: ASbGncviEZK2z85UQJYQx0AgIL4Fudvpp/wo59nCmJlxa4mbhccJDyrZ5nsQ1Qlesow
	i/OzbZFO4CpQgRpcYC+rwW50hSNKKP/wAfa0MSqZL2EKWKA+mhVic4cYyfRhSNQNJ7wpwlykZye
	xRGWomqGzg09ATmIkQ9Icxl8GQHwT16N2KC40OZuOcFdzKG3XpNsBmn0UKsGysnZBj374tRvn1X
	q7SejzbVKcQ3gFBpbIlTWVdpIVUWhlSI+1ilqTeesHWn8vIrQG0BQYGaC0oryr9kUmkVydUvNM5
	Os+pIUk7GfeNG8mPxtI+t6eBbWQK+YKCKanQ8oXX
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46e330a1a9cmr61704635e9.22.1758904993871;
        Fri, 26 Sep 2025 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQy5MzShEqo4W4mpHSCNBzEP0InFkBO55wUBdI9t6CxMRbrJ2zCQ8i54MhS96fd25/1RMU9g==
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46e330a1a9cmr61704445e9.22.1758904993353;
        Fri, 26 Sep 2025 09:43:13 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm79560515e9.20.2025.09.26.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:43:12 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:43:03 +0200
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
Subject: Re: [PATCH net-next v6 5/9] vsock/virtio: add netns to virtio
 transport common
Message-ID: <jukftp6dcz7padxxistl6ifuqnfhsd45owv46d2l4755t7vhxa@tbpri2oxyfyp>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:49PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add support to the virtio-vsock common code for passing around net
>namespace pointers (tx and rx). The series still requires vhost/virtio
>transport support to be added by future patches.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
> 2 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ea955892488a..165157580cb8 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -196,6 +196,7 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1a9129e33d51..8a08a5103e7c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -316,6 +316,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 					 info->flags,
> 					 zcopy);
>
>+	virtio_vsock_skb_set_net(skb, info->net);
>+
>+	if (vsk)
>+		virtio_vsock_skb_set_orig_net_mode(skb, vsk->orig_net_mode);

If `vsk` is NULL we don't set it, is it right?

I'd add a comment to explain that, because it's not clear.

Thanks,
Stefano

>+
> 	return skb;
> out:
> 	kfree_skb(skb);
>@@ -527,6 +532,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1067,6 +1073,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1082,6 +1089,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1108,6 +1116,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1145,6 +1154,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1165,6 +1175,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+		.net = virtio_vsock_skb_net(skb),
> 	};
> 	struct sk_buff *reply;
>
>@@ -1465,6 +1476,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1578,7 +1590,9 @@ static bool virtio_transport_valid_type(u16 type)
> void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
>+	enum vsock_net_mode orig_net_mode = virtio_vsock_skb_orig_net_mode(skb);
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);
> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
>@@ -1606,9 +1620,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
>+	sk = vsock_find_connected_socket(&src, &dst, net, orig_net_mode);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
>+		sk = vsock_find_bound_socket(&dst, net, orig_net_mode);
> 		if (!sk) {
> 			(void)virtio_transport_reset_no_sock(t, skb);
> 			goto free_pkt;
>
>-- 
>2.47.3
>


