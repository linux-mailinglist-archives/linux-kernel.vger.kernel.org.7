Return-Path: <linux-kernel+bounces-888983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C39C3C6AA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46085667E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840E354ACD;
	Thu,  6 Nov 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix/2r17g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKsVSt5N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAE3351FDB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445859; cv=none; b=eQhjKmhN0dUmip15yzn3SxiSKX6m5usciVZH48roWEjurKVSLdiRXFQq+ZhNc7U41r4gUVljNpE1coQSzcJp4evdyrAiIa+lLO7doVxJcbM+Hx2bmTnx3Su1C5U8CQuLd5mrdGD4v3EoDD6+hq/awMPtv8mvRVoRhRz9vmlLSog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445859; c=relaxed/simple;
	bh=GtjRPF6DweArbtHMO2aemgxvXl0n5TLyq2tqJNlhivM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgCnOlBuAz2gpWSZLq47BC+aib393asTv6aNl0xqaWPpRAYXRc/HxdP5qq8SJ+NXRU8y3xB/1lwd8NM7LaSWUCawcEY1LmcPzK7GC6o3z1O5YLRV3co9nQwJmyLqN9lymF8CO2mFKIg77pek6VvjmMeMAYaf8jsCPeTNQQNRd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ix/2r17g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKsVSt5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
	b=ix/2r17gJms8V7x6nW+8jgYUN8hn5qUrg0UQHbCezJ2Zhn/7OoBXKdBdW/NBv4xV2V2JXS
	II6PzZ4u/eUfoY6xZLjVt22P9Utcv4sE9KIklUGF6OL8uUc7BwxXEuYvM9jbzi11D+YvQw
	GlMhXsnc4+2UO0ibt80RHOKj4xD2vlw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-poQhE_ijOUON0eToGiwDrQ-1; Thu, 06 Nov 2025 11:17:35 -0500
X-MC-Unique: poQhE_ijOUON0eToGiwDrQ-1
X-Mimecast-MFC-AGG-ID: poQhE_ijOUON0eToGiwDrQ_1762445854
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so7684645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445854; x=1763050654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
        b=iKsVSt5Npxh8mfVnPOCQP/U7IHNG73lzYNn5N4BKAHCbGQmx7nrWVsQ6UF3EJ0xQMb
         7SOdi24OrFPjfVgAaH8kcMdVFCoybqVrZ6feGpBiWYFYFeb+ZSeGSwFeblXBxwa1lSQ+
         7KBlTHkdsUqZqBT0tHk+vcVltBbulxH9SGqLCml5Y4FSFRRfbxaFCgothSO8PnPRniq5
         RnuwtTah23BxLYiDLHJu0Zw+0/axKNPJtjkUETBRJ1qhhglw6WQ4QBf4FFEoKdPlsWZg
         J/sFKu1GmtVmJIlg7OmKM0KeuArcPxgrTRh+HU0I2J9/tWqj/vTBzt5Le3bnhfMtc7Rr
         9tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445854; x=1763050654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE8pWaDjxM5gntEvWaYK9FfKJ/5DWKgS7aJeLXUwhc8=;
        b=vSgHcvnz/GMyGRGa+3OYIh9RZMt85A1eL++WVV8IwzKhDZSJZgBZbrMCpr0LBd0ql6
         OJLBIQybZDukZMyfw4JdE70QJwhPj11z+cZePOEMqEm1uJY7zEnpU3z6SmThJ/6BjTQT
         oSLx4Yzm7UBrHftGpgNUmxbLo2/5NAmfE5vz7hhTqFXQt01xSaMPZLAPZi4NIEdY3aMm
         Ks3BoOY6soINs2RXjI0Pkxz2FqVIkDGOw/Co18NeavVMiX5rU8vTFFn9UjvG2Iha+wuN
         QSIh9nrD7melWxpEJqy3Um6n0jTA4dmrDEow6lcwbIEi9qru38I0GO5iPGZ9EC2bTd34
         GjLg==
X-Forwarded-Encrypted: i=1; AJvYcCVNl9I3voGmLdZNLQcB5SohostZPFyvyGa8tI/dVDouqBG1KnLYHUfhq1+6XT6wT0eHyaBgmy8ByeCiR84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+tdjQ6x4QwTt6l/x2D3ftGWMCy4xWCdECHiudqyI9nJfoVL1
	sL6TbwlbFPGZ+VS7dbHYsI8vSJ0AhctOJOTioGinZfL4+r2QL50KeOP6k1x8AAz6TS9kPrllUX9
	AclljyLz9x5tiL98KLXU09OHGVii6XQC2rXZqSMbRq27BzpBtIXYPLWVw6lGlRSQHQA==
X-Gm-Gg: ASbGnctw+7dhshwg6u5jnXXz9K41kjErG8VatFvEreA9dlXFHOdIjWp3ooYy5ivKr9w
	p4+jKh6oJ+AJJ+u/2s7NtaugTI+RCfrsZJ7zoRDPcgC9It+3cHGm47M9IjaPSlvs2fEXlFLKFwp
	YmPUHaXxlous7XVJAUmAA9XEtdP9aYOIfuRXe+Q+AdLvgPw8MvtCZX149mr0EIHtm8sBkYdDxWF
	ezMIwXKpVyeFsgoLJAYqATy5Q5+vFDUucdHcMXKWYGXNfnWXp6eRx/u0Lca/W4NC08FosUto9H5
	4HncwWOMQxAPeNKh/Fevjm/afUGAAeRTmsHR7aud5cCL1LwrG4c9n0qT2DQX2a0J7ngDHzgm7dw
	lng==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23006145e9.12.1762445854303;
        Thu, 06 Nov 2025 08:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIyTOWs4nIR7QeOKb8n83iy6iz/GaHMuA92Bwhg2oq7+DwP0ugN/AgSAqGuvWOvF3ICA0YJw==
X-Received: by 2002:a05:600c:4ed4:b0:477:63a4:8419 with SMTP id 5b1f17b1804b1-47763a48438mr23005835e9.12.1762445853789;
        Thu, 06 Nov 2025 08:17:33 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fba3esm20572515e9.6.2025.11.06.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:17:32 -0800 (PST)
Date: Thu, 6 Nov 2025 17:17:27 +0100
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
Subject: Re: [PATCH net-next v8 03/14] vsock: add netns to vsock skb cb
Message-ID: <q5w5y5qomj54k2tzztsy4pz2h2zqkvgfzkysjiv3uguoufrqy7@tfz7dj6cssxf>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-3-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:42AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add a net pointer and net_mode to the vsock skb and helpers for
>getting/setting them. When skbs are received the transport needs a way
>to tell the vsock layer and/or virtio common layer which namespace and
>what namespace mode the packet belongs to. This will be used by those
>upper layers for finding the correct socket object. This patch stashes
>these fields in the skb control buffer.
>
>This extends virtio_vsock_skb_cb to 24 bytes:
>
>struct virtio_vsock_skb_cb {
>	struct net *               net;                  /*     0     8 */
>	enum vsock_net_mode        net_mode;        /*     8     4 */
>	u32                        offset;               /*    12     4 */
>	bool                       reply;                /*    16     1 */
>	bool                       tap_delivered;        /*    17     1 */
>
>	/* size: 24, cachelines: 1, members: 5 */
>	/* padding: 6 */
>	/* last cacheline: 24 bytes */
>};
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- rename `orig_net_mode` to `net_mode`
>- update commit message with a more complete explanation of changes
>
>Changes in v5:
>- some diff context change due to rebase to current net-next
>---
> include/linux/virtio_vsock.h | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 87cf4dcac78a..7f334a32133c 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -10,6 +10,8 @@
> #define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
>
> struct virtio_vsock_skb_cb {
>+	struct net *net;
>+	enum vsock_net_mode net_mode;
> 	u32 offset;
> 	bool reply;
> 	bool tap_delivered;
>@@ -130,6 +132,27 @@ static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
> 	return (size_t)(skb_end_pointer(skb) - skb->head);
> }
>
>+static inline struct net *virtio_vsock_skb_net(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net;
>+}
>+
>+static inline void virtio_vsock_skb_set_net(struct sk_buff *skb, struct net *net)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net = net;
>+}
>+
>+static inline enum vsock_net_mode virtio_vsock_skb_net_mode(struct sk_buff *skb)
>+{
>+	return VIRTIO_VSOCK_SKB_CB(skb)->net_mode;
>+}
>+
>+static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
>+						      enum vsock_net_mode net_mode)
>+{
>+	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
>+}
>+
> /* Dimension the RX SKB so that the entire thing fits exactly into
>  * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>  * rounding up to the next page order and also means that we
>
>-- 
>2.47.3
>


