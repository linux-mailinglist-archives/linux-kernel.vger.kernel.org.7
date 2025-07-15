Return-Path: <linux-kernel+bounces-731617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EFB05737
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EE33A94E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BC02D5C6B;
	Tue, 15 Jul 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs2qrHe6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B7266568
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573326; cv=none; b=L0CxGp/4jRcDwPM5c1q9LBHhnxFPGjUwsujTVqMNRvps70r7SNbAj1vToULtFsERZSfrKkXiiXZC9cbDKjdxOa/F3hsX4JbmaxUrfo8HDF9gxpMhg1RhHG17bYLtsyrc157IhVwl/lLOzZ/WyliUe+Pta/tMKOBboBkLD7YE7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573326; c=relaxed/simple;
	bh=+amJMGPMe6DvicjWF80SXyO9oVTDL+ida1EY6ELCfas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4ymFQxmg2kROQUeJZ8py9L3fvFfBuLAlik3/tfqUoCNW9tVZSpG/1PR/Ggll5jXYrDu9+mSHboqpmTx9vqw+BvpWIpQS7JJRnaxlR8LWt8/oXjqQ5xdUuWLP5UpwmrKahXPkdsaHDQaSbC/C/XYM4z/hxz5/xolGHjIOqS7QXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs2qrHe6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
	b=gs2qrHe64Y6+qqaB3bH/PEBKwU1gStv65XH66OaR8/t5n4G5kDmlhLVVFKU066g4ln2zTo
	3iFwnKuSND22gdiEWi8Iy4VXNxEh95I682z5sBkI9LW2fM+vhXDC0kZ6Qgp74LZ2McgFH1
	vxSnk1qdGiF++GMhkbcR54Za/2MYgcQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-nT-iWWU4Mr2cLvUdCqGAEg-1; Tue, 15 Jul 2025 05:55:23 -0400
X-MC-Unique: nT-iWWU4Mr2cLvUdCqGAEg-1
X-Mimecast-MFC-AGG-ID: nT-iWWU4Mr2cLvUdCqGAEg_1752573322
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab5d8797ecso44775971cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573322; x=1753178122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKOPJBHf5+FoxYfBH8MZ4lVKlkTlG0XkNAjkThBHE5k=;
        b=qUREK6WQqUz+bxA9g0PTNayMLGlUH1xWXsN6piv0c5rgQCJFTERC1qlwHl/CxAyRM2
         0z+F6ZcWc2zI93rA9j9prmDSegLdQheqgeLM+w1s0yIHwT4b+F30J3z7ku2olb60Oqml
         C0yJtRclzGIk/PVuKxPQ8T/NeZQ2MS9FtBDpOW9GGLrzbclg4/F2OTaI3KVcAX0lSiBi
         yj+6PExC8K8wrgNBabIinJ3Sl1ZCeM/2ax6kjOfItU9Ovw38izyVRrRVNarp5KYwDGSa
         N0KfDfp0IEJ7XHiS088en4cVbPmMctqH+rY0ySbDEOkasRuiYOTgffmY91uPCfJeuKBX
         hE7g==
X-Gm-Message-State: AOJu0YxEgQ+H77IXRF0DLgT7pEMdv0rguuFBdN5+moE+ebHDDvPuL2NI
	Y35vw9l0EY+liaUJ+Om2OGBlYe5AIODQaWVEIURa/JUBpF6HkZqcxwtUBfFFNVmK4U05mLd2dLM
	VuBa8L3w3q7+v+Ij2+ZEGAi8VOBCafOhC9etr/4P+hIls5iV8ynff/LttoR3RCSOMTw==
X-Gm-Gg: ASbGncvIaupDtU/fX6kKQDDLZXjsjwUpFDH1PHT5CeXeHXmJOlRKYZc/tLKmqJyVBs3
	+r1FPIMQVmszfZVF834HNHVtWW/Tsqjwq1zFlwzoRfTA+nwifn65+y68yrUGqKj3p0+y0SoGHjo
	FBZXYJ53QTfxhiG7YmQVCx0YA8+s+E+hSxUnHgH3cSsBeeqs/joB7RFcCt3jcwAQRbdLKDIoAi6
	mSUNSbl+AiTL18p0yiBqwAV3zUcgSl6G01jPbS9hdb1nOI/UbaBX5MY9571Zkiabu5asBQQzvcK
	XEEXVbJDCVcIYWUz4MYOMtDP5vhdBgdYRPdGKZauyg==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393521cf.18.1752573322307;
        Tue, 15 Jul 2025 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeWoRAlpmTeV16PHDRVin9Qf8zLbTd5Snp7dshvSQ6NI7guHEP1XHwoIcK6laQEHjMzcohNg==
X-Received: by 2002:a05:622a:5ca:b0:4ab:7262:893a with SMTP id d75a77b69052e-4ab824a322amr24393191cf.18.1752573321802;
        Tue, 15 Jul 2025 02:55:21 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab75211016sm14135681cf.45.2025.07.15.02.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:55:20 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:55:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 3/9] vsock/virtio: Move length check to callers of
 virtio_vsock_skb_rx_put()
Message-ID: <ho6edx2uqqazyeoe3vm4oruas44ozngsoyhcuilremkzqg7u44@b6xeevkxtlmc>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-4-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-4-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:57PM +0100, Will Deacon wrote:
>virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
>packet header is not zero even though skb_put() handles this case
>gracefully.
>
>Remove the functionally redundant check from virtio_vsock_skb_rx_put()
>and, on the assumption that this is a worthwhile optimisation for
>handling credit messages, augment the existing length checks in
>virtio_transport_rx_work() to elide the call for zero-length payloads.
>Since the callers all have the length, extend virtio_vsock_skb_rx_put()
>to take it as an additional parameter rather than fish it back out of
>the packet header.
>
>Note that the vhost code already has similar logic in
>vhost_vsock_alloc_skb().
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c            | 2 +-
> include/linux/virtio_vsock.h     | 9 ++-------
> net/vmw_vsock/virtio_transport.c | 4 +++-
> 3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 66a0f060770e..4c4a642945eb 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -375,7 +375,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	virtio_vsock_skb_rx_put(skb);
>+	virtio_vsock_skb_rx_put(skb, payload_len);
>
> 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
> 	if (nbytes != payload_len) {
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 36fb3edfa403..97465f378ade 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -47,14 +47,9 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
> 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
> }
>
>-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
>+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> {
>-	u32 len;
>-
>-	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>-
>-	if (len > 0)
>-		skb_put(skb, len);
>+	skb_put(skb, len);
> }
>
> static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index bd2c6aaa1a93..1af7723669cb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -656,7 +656,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				continue;
> 			}
>
>-			virtio_vsock_skb_rx_put(skb);
>+			if (payload_len)
>+				virtio_vsock_skb_rx_put(skb, payload_len);
>+
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
> 		}
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


