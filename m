Return-Path: <linux-kernel+bounces-861203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985CBF20DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F244F6E30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BD2627F9;
	Mon, 20 Oct 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EomVYDqA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA341F461A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973506; cv=none; b=RRMKvqTDzIf1t/UlS1+fN+PBzuNoLRITeLeDaPESsyKWPeU84XvmM9D9ikzCRjuKvGTFqTCAC2i1I4a9/6h9ERixNT3PB5nadk0S8yz+d+KQ/a+YggSMF4M7rGkKqQ9NMzwT/hDNCDYKTlSIJfPnIrrPOYEow0p/F7kFWZdRmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973506; c=relaxed/simple;
	bh=vxeZU8BIk7yt5+gefMlL/GNoEVo0y7v8NbR4bXP2d6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0z02MZ005Ik7ZXlxWOsilKw7i2ZQNvMPtYNrldKtYXy+EGb7s5EusTSg+bjDdI3Zy/pQ4gRSd92hMAalW8/AUM7MtEOOdetoY7iLXcZTlzaN3fn565BcKUDnEGABUTfWzq2ZeeHQ6+hiKVmu4uP73xVBviAiYRjvIVIC3fwDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EomVYDqA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760973504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=376JEJXXuhTvk7uwIbwEp0J9xIBggDxY0JbNoKssPdI=;
	b=EomVYDqAmKLyV8pm+NHzq4YWOnMpiI37iPRmM7T6OyYeWgpxMVoMFVIIfXdAZHx5TtEKOv
	KT7ztxm+e0xziVO5JjiajdxrR6+kPiA5TMI9baQgHBb/HNXOqDdcRSwJI8BawkKwuoXSXd
	1zPDqyiqYv3JanRruP+EPYSJz4Hf7oo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-SPLa6nX0MqG6BDyiQWw_SQ-1; Mon, 20 Oct 2025 11:18:22 -0400
X-MC-Unique: SPLa6nX0MqG6BDyiQWw_SQ-1
X-Mimecast-MFC-AGG-ID: SPLa6nX0MqG6BDyiQWw_SQ_1760973501
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47105bfcf15so24641295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973501; x=1761578301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=376JEJXXuhTvk7uwIbwEp0J9xIBggDxY0JbNoKssPdI=;
        b=wKwoQHUY1Ddvo3odKJCFVXc1y+LFR+yLn8xtsVPLnyNrGYimiBSJYvDAz2DUJGTNR1
         J4tTae/5Pug22pcOdJDViMRR/Aob93qtb1snX45/a2i4mq9Yl4ILYTSQvrtQza3zVEc0
         +T2FOsc//Ba54ydjyTlRpy0qauTB3wGjEGWeN9LDJW+HK43RXMKICAOiuPFJW7abgBMD
         +5IyBIbzV3XYw6yI//P4jOv/14k7A7EA8lhrlr/RJODCOj2NxXngIQ2hFlJJkEuDDgvZ
         ETHw26KPagf+frx9IByy80Zgb3+XYKSeNmsb8wlIBhTKdK/ztzIdpGQZAhbvNzVtxbaG
         wlOg==
X-Forwarded-Encrypted: i=1; AJvYcCX5CYXT+CERfrUYPfR1edH08ZFLOPnOHb60H4y5Ga+yz/zz0lBN8Sl5OODCJQUxhtV/oNNq1opu08qpJNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOu/9dQKFrL5N/5ieRdcBSeoaHOTO/I2Hj7f1J3dzbfXeLgAh/
	8ySARBp7wDdIw+8hjJMaG85YtUCD7UkUYtV5jxX0u+B6LIdRmqW7YQDXlIvDhTEK9lidIfZuMHy
	2kKxUiyfvKdVC0mDF2GT1xuqrzVxSO4+qitRtYwvDccS//jEyhkNhwJRIEySGGScmLWh0UTo0NQ
	==
X-Gm-Gg: ASbGncvuCfh8M5GDWwJVORhm1Ri4HJFchRsQrIC+7ODBS/IDXjGEEZ0OOAQDkJLQo6J
	cdWJLoq9AX4ikU9RJVEfrrNo/ZjrKHPqIKxRDdK3FBcs4EImLXHd5kQ40ZYLZXVTQnCUPe9ZrX5
	Sewn0PumksznByNa4YfYpN8pV+D5rrVyznAyhcTcReIBmO2eNSJQf8PZF7MbDeH1ffm7fiblwC2
	3FnuJNLwYDZ7NfyNHh0UQdnvLjU0H5M8GKqQyD2HOnHePCEyvElst0U5294hkJ8Sxm9PZ5qS5IK
	sUJKRuZzHrM86IJWVztunsoilS3O+w51cOEE4UlFGyi94SqM0lTOAddz7MyzxQ7Rt6PM
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr111618955e9.6.1760973501154;
        Mon, 20 Oct 2025 08:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLd9da+Ou77Y8StkQ2q014OfnaoUD42+rUXfxhJ8RF6vKnDc5lJ9/jBhXf+wCuZ6ndVoZBw==
X-Received: by 2002:a05:600c:3f08:b0:470:ffd1:782d with SMTP id 5b1f17b1804b1-47117876a19mr111618715e9.6.1760973500619;
        Mon, 20 Oct 2025 08:18:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471553f8a3asm174428685e9.16.2025.10.20.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:18:20 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:18:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20251020110341-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020071003.28834-15-jasowang@redhat.com>

On Mon, Oct 20, 2025 at 03:09:58PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 37b16ef906a4..20bc48b1241e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -575,7 +575,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, err_idx, c = 0;
>  	int head;
>  	bool indirect;
>  

c is not a great variable name. Maybe sg_count?

same in patch 19 actually.


> @@ -639,12 +639,11 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> +						     ++c == total_sg ? 0 : VRING_DESC_F_NEXT,
>  						     premapped);
>  		}
>  	}
> @@ -656,21 +655,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT |
> -						     VRING_DESC_F_WRITE,
> -						     premapped);
> +			i = virtqueue_add_desc_split(vq, desc, extra,
> +				i, addr, len,
> +				(++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
> +				VRING_DESC_F_WRITE, premapped);

this continuation line should be indented more,
and maybe premapped on a line by itself.
Alternatively use a variable for flags.

>  		}
>  	}
> -	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
> -	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> -		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
> -			~VRING_DESC_F_NEXT;
>  
>  	if (indirect) {
>  		/* Now that the indirect table is filled in, map it. */
> -- 
> 2.31.1


