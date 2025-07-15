Return-Path: <linux-kernel+bounces-731620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672CB0573F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE20A16A0DB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBE42D46AB;
	Tue, 15 Jul 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOzZzbMa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CA4213E7A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573423; cv=none; b=ICkEJcnmnxGmoR9aPC7Cq5SlLoT77wLkS8akT9KkcfVx5OchWL4E+OBeOR669xW8yGlNsK4CVJwrdvBbrK0DeNECMtIjEni40X8nE6JkPFykCIJXso3QWn1h+z1U85CsN+tK1N5CNlveesKahT2RT72lC1A0ojYO0ownGzGqoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573423; c=relaxed/simple;
	bh=GTkmoLyiu/GJjZVIYcBGrKULeDnljvGjgDN6z5K2onc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgzHtGQ81MSVzpLuyJ2qt1ijwa6TnJf1jmFL4lgTrN1TqGmZdo/2jfaesuweX8d5zKVXEH3EUfCY8WfYzA7S6Bi9Q71pYEiUcEJxOjJSPEhDk9UawERAXdTFXiO8MEG+X1yxxDrFPvakgxOMT203EbUs/U/fMsvAjbAFlzPtN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOzZzbMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752573420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
	b=hOzZzbMaQ4Y5jBmTzTiOXyCRtg5cRnir++E2SZONBXdj6nQBZmKwwM/7G1TACI1jo+HnxP
	6Uf3f3MxjKSmYIWM+WE3fArl5DYnfLDy2QsHZBoP+fthX4I0weGPmCguifruoU7ciCLukA
	tiBnK+5cW7/OBLeATLYs30q7metxHlE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-6FEbsk9YMFqc-mzUQTf0zA-1; Tue, 15 Jul 2025 05:56:59 -0400
X-MC-Unique: 6FEbsk9YMFqc-mzUQTf0zA-1
X-Mimecast-MFC-AGG-ID: 6FEbsk9YMFqc-mzUQTf0zA_1752573419
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e207330b6cso476718785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573419; x=1753178219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsjnNQfJ6mAkewo+n/SUTwvK6JE8ja4wWBuZ4cMAwJg=;
        b=dlMoo4nU+oXrN+zltw1CVBS2G2mQ50r/mj0QS1s7jjBsbpXgQAT0w5ycK3Yu1CeU0b
         9vdxZm4Zm4+tbIXpfVsS5qbTLfE94wbqQ1QYSNtO9K8WfSemUGnwp78y1A5CBazIsI5T
         LAGFw0EKL0yYPQI88sjBadjUH91sSyprFvycZrJx6NVWLiCriS1XslGR9MR/1orLOXjM
         bNP7OlnuPMIuebTpJ2jowXo+ZwmYgpyLSDywLeAD89gD6JjP1OTlsr20hnuXrzPMZzJN
         b7vpSaokwLdp0HNiI0RJKrLXfT3tZ5kVINQ6jRkRqpfoAwRiQ6M4N8JU3NENZNZSZk3d
         BAHA==
X-Gm-Message-State: AOJu0YyE6fYKoeNAcWRBV1qJrjHRaQ4NUooks0nu4viJn598X2CffFqX
	z9DJFclSMi9dqktsWyGTljjvpRfQxdyTClhcBEnan/d5Inpi9azazKTafZd7t/laPK4Eg4bHw+N
	0n06+D3f521y6TpWrnudBdOANYsJ4Py3kZPPthoyMJ7+IvZxpTugUkZhmzjelOWXdnQ==
X-Gm-Gg: ASbGncup4K1MeGStzFwuiaBWctuVObJbEXPaadXeSU5px+UP41SzQ35lGsVSPDMNCr4
	gq/I9MsMlm0NFeVATYa8xf3d1sTUKcqIgsddHwVTy2HAkPeuamg5rMzA80ovB2RzX4w+/gAq07P
	RswN6eR2c4EAms3YUAXtgVjoj6vIdmNUO80uk2IAehWg8uWQ3I6k8IpgixLumPItXiG2CwDnN7a
	R5ftZyf+nMg5B+31O0/ygt/aDCmG0Q/uf3Xj/sFiAHPVOaX7jJ94UB1CM2jsuw2fqVborZGkXKh
	HtO4p0zQMBmmVAsaAz+F3lwaPvlTyAF4fej4t5jRjQ==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162301285a.20.1752573418500;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYyKYcEuilw8G0A/GVrUc5/QquW6KQ2Wasy0gXOfk/DlYj91vAPMPzfdBpSrzjF93b3y3YA==
X-Received: by 2002:a05:620a:4544:b0:7d3:8ca0:65c6 with SMTP id af79cd13be357-7ddea60f268mr2162298885a.20.1752573418062;
        Tue, 15 Jul 2025 02:56:58 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e1ddbde3ffsm283891485a.76.2025.07.15.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:56:57 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:56:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vsock/virtio: Rename virtio_vsock_alloc_skb()
Message-ID: <6vknr2ruy4cu3kdxdt2zcigm3jyex5ntxqbqnxe4cbf2uci247@6opbwa5o6rk3>
References: <20250714152103.6949-1-will@kernel.org>
 <20250714152103.6949-6-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250714152103.6949-6-will@kernel.org>

On Mon, Jul 14, 2025 at 04:20:59PM +0100, Will Deacon wrote:
>In preparation for nonlinear allocations for large SKBs, rename
>virtio_vsock_alloc_skb() to virtio_vsock_alloc_linear_skb() to indicate
>that it returns linear SKBs unconditionally and switch all callers over
>to this new interface for now.
>
>No functional change.
>
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> drivers/vhost/vsock.c                   | 2 +-
> include/linux/virtio_vsock.h            | 3 ++-
> net/vmw_vsock/virtio_transport.c        | 2 +-
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 4 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 4c4a642945eb..1ad96613680e 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -348,7 +348,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 		return NULL;
>
> 	/* len contains both payload and hdr */
>-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 879f1dfa7d3a..4504ea29ff82 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -52,7 +52,8 @@ static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
> 	skb_put(skb, len);
> }
>
>-static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
>+static inline struct sk_buff *
>+virtio_vsock_alloc_linear_skb(unsigned int size, gfp_t mask)
> {
> 	struct sk_buff *skb;
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 5416214ae666..c983fd62e37a 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -316,7 +316,7 @@ static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
> 	vq = vsock->vqs[VSOCK_VQ_RX];
>
> 	do {
>-		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>+		skb = virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> 		if (!skb)
> 			break;
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1b5d9896edae..c9eb7f7ac00d 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -261,7 +261,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 	if (!zcopy)
> 		skb_len += payload_len;
>
>-	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>+	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> 	if (!skb)
> 		return NULL;
>
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>


