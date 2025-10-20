Return-Path: <linux-kernel+bounces-861486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D6BF2DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8624018C15B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C572C0F7F;
	Mon, 20 Oct 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8lNXOv9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15423EAA3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983533; cv=none; b=cHYw9EzUx0e0EBhFRrNG6iQarr/naJFlcH2XNOwnUftGIygyhHkLAT/b4zImUQNyKdmiyilA3jCBKIqK/oRffuz/bKSxMRUTQfisq0zr0oI18YHfUk+q6Ftqj6V1hdtS15qOoLEd5oyo2wCJ9Oi96xkeb4jHl4spDqMwGsEHjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983533; c=relaxed/simple;
	bh=uiD1heCbyfEANV0HzWxufVPtGQSjmgjqtnG/kBnzihg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7N6Csa2ktXF5FAVN3+ANNmt8RX9LiEu2c8o5cRgAbbi0IgGrH/Q5mWXmw1MeY9WLKgd/KCjOmwM6aIxQg5xG1mny4yKJOAsoKBG5DLGrkQy4//lSTs+3cZo1EV3FUxZnPsoR4bumxogmvcpuXM/R0JYtbpY8b+R72nm065y38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8lNXOv9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760983530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36S/ZmC1rovvSywQh09PqWqsI9Syym0VZe1uvVyj7To=;
	b=R8lNXOv9OPBthmC/8aMIxYngBBsCZIM+XhrZbHTPApCiOIxBZsjqDN/isvzJI5RhpeAIKn
	njMK2znTSk3kaow1XpHhXuo2saLT79sn5fvHuAJT9YLHmPK5M/IEV58SD02iK/H0zKo+r2
	PwpPDXfLS/dwcuQMalAbzx3OiECGu2Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-DINA2zOROnKHUNjkOJ3fHg-1; Mon, 20 Oct 2025 14:05:28 -0400
X-MC-Unique: DINA2zOROnKHUNjkOJ3fHg-1
X-Mimecast-MFC-AGG-ID: DINA2zOROnKHUNjkOJ3fHg_1760983527
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47107fcb257so69082165e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983527; x=1761588327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36S/ZmC1rovvSywQh09PqWqsI9Syym0VZe1uvVyj7To=;
        b=aODKbu2liFakILYcbRXh5j8PIuIQy7WNtg64+aguKKmh9yzXgLSzVtL4gQDWxKMrvZ
         W6+O8UdTWYKl/5yh06tQolJyRifQYC5c+XimsYLYTOStIriX3VPuc10W1mpblEjUmuYc
         gqx4GMZzxxExUA3YM6sLWPINJD+2soa8gPhh9xWTZscBTaXK+OgBh6GaMOQkXmHow7cp
         0JXPEsrIDsgnO4XZHYn0uo5SI4yJAdCIW1hT7IEUgT6mo0aC1/HqKqEOFhuuHo5BEKk2
         n9LUSc1sU5sDJ3BnJzK8xj2UlgcfLkj0tojdOIcxtvGND+3bZMUFXA86KCxoaBHavtgW
         iAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjB2m+2S/O8P5O6134xmYCJYDbBe5xZ72cE+7PcFr3GW9LFVdnDbA04PdU3AsQdI8LNv1/YcNYivG52aA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUn46Q1L5ZMl5zi5xiyTDyNAVUM/IGHuF6gpr5l8zUqYO1cDv2
	h2syfI5jpUbeGR0w6oARrBy43sQ00xzPTHhnLlvJpwNVGiJoluo6Chzd73z9Aq5CchjZi3h0afs
	VoqVk39F6fRN289EN0Pz95iAaaLpLDTqh7hBiWfyfR06mjf2qAm7xxsHkJkC/HndcOQ==
X-Gm-Gg: ASbGnctyHgItHbTIy+IZn/OIyCmteopo6BIwezs4gcZR7mqmVJu0ovQhcwAPV7KJZBQ
	+BIo3NrV2Q4t8Y7GI9zrch/Wq0whpkA9FPXL8xAGTimjzK/fC9WNpx/HSsjSa0FTFoHswoBuc+O
	UHj/ONpI2LT1uEMAy7Vbk/1+ZL9zYr3w2s52SDq3YFE6glft1DpRu5c04wqWhm03HwWZY+YrS5e
	ko7rTS0fphuJz48EV7tAf6MxpFkSkGD0eRXohh55/eBqbyYW1a+fEC28PjJ0NnXHYn4LlwWVblx
	kYU34bCXDDnIFAgo5A3VIylR+NAUIij8J/QH6Kte+wAOk0uMSiFfyZjl2KfjyyX4Zmg+
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-47117912b5fmr117275925e9.28.1760983526901;
        Mon, 20 Oct 2025 11:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKOn2rHJXxk1XGL7fh+oZbTp9TC5fyJbTHX01pmlPdHVguxKM1fW81SYnR+boP0ptXFuQoEg==
X-Received: by 2002:a05:600c:8b0c:b0:46e:731b:db0f with SMTP id 5b1f17b1804b1-47117912b5fmr117275635e9.28.1760983526269;
        Mon, 20 Oct 2025 11:05:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm115965645e9.8.2025.10.20.11.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:05:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:05:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20251020140158-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020071003.28834-18-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:10:01PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> allow it to be reused by the in order support.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c59e27e2ad68..0f07a6637acb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +				  unsigned int head)
> +{
> +	struct vring_desc_extra *extra = vq->split.desc_extra;

so extra is initialized here ....

> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;
> +	unsigned int j;
> +	u32 len, num;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (!indir_desc)
> +		return;
> +	len = vq->split.desc_extra[head].len;
> +
> +	BUG_ON(!(vq->split.desc_extra[head].flags &
> +			VRING_DESC_F_INDIRECT));
> +	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +	num = len / sizeof(struct vring_desc);
> +
> +	extra = (struct vring_desc_extra *)&indir_desc[num];


only to be over-written here.

what's up with this?

> +
> +	if (vq->use_map_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}
> +
> +	kfree(indir_desc);
> +	vq->split.desc_state[head].indir_desc = NULL;
> +}
> +




