Return-Path: <linux-kernel+bounces-826304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E659DB8E251
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A250C3B383A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5A327280F;
	Sun, 21 Sep 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ti/asw+U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479351DE4F1
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476576; cv=none; b=QodfXwyf+22/RraTyh4s0xoj/afCZ5WY7diOYRU0woqf8aHwowdZFKeDAASWr24z7qAzGYpVlq8qtTVSSC1AgnAM9AKlmZWqsrwFy5S9ZomQc6HP5GBPDt3uCG4L0nDorvMif5JJNlInrn8naNYwHsBYeLP2Vl66g3rvM2M6+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476576; c=relaxed/simple;
	bh=NyKEKr1b2BIcyNy09zsOZ61YBaYjsa5gw1rrHkIXNFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWVT6lMa8PRUF26qsPx+sCCJ3HY25CCdx7NEzXRLNscfdO/XtVQ3f2dTmhR/uTXCIPaRMTbZDQMmvZsZfyHgHOx23tiV2YkfwodAjtzeQ5f5L00ir4yUYYcscLUH86inXy9XlUUNOaBWFPheSy35AV5Tlb8qqN0aDiiU3VzjiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ti/asw+U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki5SNULUk4ovbhFY3JwbvaZTB4gpWhdkwmyhVBSCsGw=;
	b=Ti/asw+UrZomI5TGeo1rAQ6boNG8qwyx0TrLGx30x93Y8vMb8tuRzX3cMOl7n6IjGJPeV0
	QwH/d2eMPmwHWWUeQL2nCR+OubO1dG+jSg3uDQvPMd3ps6U1YXLxdC1kWYcvy3h0XDUNYd
	XoielhdRi4ckP0MI3QOJhAw6JFmWAiQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-c1rlZay8O-2DLqRKDgyA_w-1; Sun, 21 Sep 2025 13:42:51 -0400
X-MC-Unique: c1rlZay8O-2DLqRKDgyA_w-1
X-Mimecast-MFC-AGG-ID: c1rlZay8O-2DLqRKDgyA_w_1758476571
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so22306985e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476571; x=1759081371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki5SNULUk4ovbhFY3JwbvaZTB4gpWhdkwmyhVBSCsGw=;
        b=B0xkciHrzSnsyhVZc5ZC5JLtW/8N1eVGHJLEs3R22ChF9N3igzJIPUsruYHC1NdThN
         QJ6RAfJGbKX2IZm/pNjEPayBZvsed1kOyZjPeF2z0SY9QaDYTtn/sp5FHCgf5Ix1AjMh
         +kik3xmTHSPDzDLpDMGJkvemwF/irhk8zQqMG4vnWAn8mGaT6i5k9WFaSM9HJ2h6Gxql
         ovUNULMqGDxOEsdDWS7DZvUxTFupgiAL/1gYHW8zMpN/0o30OVK4KMVa15aqRIY831mn
         fRdgZxqrfn/KGe7zZ25oSmBaHb+nt1XSHazkE97zdvYOR8MknNC+m5YZxI0tAAvu9Ojh
         qMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe3tajj7QCw416HrOtxsN8h4BnA3kHftbEZkbZQv5SI8uUk1wRd1KxyMxQL5OA+6usK77pSMVH9KJmRzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4yFZfyII2dUp+DHLozMBUg7xM5D+Z9fOunr+hdlzS/aUTnn4
	Qpp0/GvYHmHa/MAdZawt5+X/dcGWLQsEj0PHL21JHrk4HCAxX8o0tvMUkSr+ux+390MXPNqQaI+
	sOS0ABTQubb0PN9UQPrrIoiMypQ4IVBFsabYFBj22jl0xdp3G0FC5EzmvFYWbilZCoQ==
X-Gm-Gg: ASbGncsRPAhvZcguYNgMw1j4y5zf+gdPMDUsEmm0yv6f9D8RlPqJNljx+O3ecaOsnA/
	XsHpTOx1H9j2rPAlCeYpVzF+fcrUQzZsHufvGMtpcwwc0tl1u+5nLZfcfLY2QgR0tlVtROBC5P5
	ym++5m3P9pLbkoJMNfRLBKkaPqBL9RZHJTHIIlEIBgadBQBzvxWrigHmYBDWA6uQuwuw54kmX8E
	+/Z8OVJJvGk2I5mYZpWfzxv7i/OxW+LCTPb7odZ57pde0DTJi27JZ3tyF224ES/oJUXeqgub7IU
	aje62TErn7vvVO5wnJg4vKhZ1H++YywDUCw=
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr95217395e9.37.1758476570632;
        Sun, 21 Sep 2025 10:42:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiD/X8G7MP1jcVbjEIkInBgciEQnAeB2QSMG8GJCmlocmhldDBxHzW7xwz0JStIEtLdCYMSA==
X-Received: by 2002:a05:600c:4fc2:b0:45d:ec9d:5fde with SMTP id 5b1f17b1804b1-467ec46079dmr95217255e9.37.1758476570232;
        Sun, 21 Sep 2025 10:42:50 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm17000435f8f.14.2025.09.21.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:42:49 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:42:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 15/19] virtio_ring: factor out core logic of buffer
 detaching
Message-ID: <20250921134159-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-16-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-16-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:50PM +0800, Jason Wang wrote:
> Factor out core logic of buffer detaching and leave the id population
> to the caller so in order can just call the core logic.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 0949675a3d12..a83d08070e8a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1662,8 +1662,8 @@ static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  	return needs_kick;
>  }
>  
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -			      unsigned int id, void **ctx)
> +static void detach_buf_packed_in_order(struct vring_virtqueue *vq,
> +				       unsigned int id, void **ctx)
>  {
>  	struct vring_desc_state_packed *state = NULL;
>  	struct vring_packed_desc *desc;
> @@ -1674,8 +1674,6 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	/* Clear data ptr. */
>  	state->data = NULL;
>  
> -	vq->packed.desc_extra[state->last].next = vq->free_head;
> -	vq->free_head = id;
>  	vq->vq.num_free += state->num;
>  
>  	if (unlikely(vq->use_map_api)) {
> @@ -1712,6 +1710,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  	}
>  }
>  
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +			      unsigned int id, void **ctx)
> +{
> +	struct vring_desc_state_packed *state = &vq->packed.desc_state[id];
> +
> +	vq->packed.desc_extra[state->last].next = vq->free_head;
> +	vq->free_head = id;
> +
> +	return detach_buf_packed_in_order(vq, id, ctx);
> +}
> +

Wait what? return in a void function?
How does this compile? I'm guessing it's tweaked by a follow
up patch?


>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  				       u16 idx, bool used_wrap_counter)
>  {
> -- 
> 2.31.1


