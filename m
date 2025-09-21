Return-Path: <linux-kernel+bounces-826310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0AB8E28A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850E71893E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A27254AFF;
	Sun, 21 Sep 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f91aWQiO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EB18EB0
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476836; cv=none; b=rTIf+fyidzn9MrWQECBDFUSdVBIh/zJoRdWa8+q0NHPcJxrBNSBimNe3DbC9mMafJh7Y2P7BFq5YsLua/R00hHa60pLlbQPcl6hUvFClJjdjvc8oeKUV7G4yFtZ+jhkxREG7c9IzKzVncFu6vLR3v5sdMqyIhaWyrmsDjQm8O5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476836; c=relaxed/simple;
	bh=+95EJpfbtm4S9OdNcUzPzqQu+cNcUrTSmKMmlF66Bzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC4ZWmpIztSxkS5c5QvKFmte3MgS8f5DnuWRnZx+AjEW/tUInI6PzSGIKFRo4SivoXUZe4Bn28mx0S7f3Dj1YANj7T3Qew4GplFItGXYmpwuKMibNsPcMJo56h64IM+6XTyzz8JLLoH1AGfmb91e/2pBQFZKGDecZY+cnMSdCYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f91aWQiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWQDJIxZ9xQus8Xy+3Cne3CrBxdggcAgVrBwiy0GpC4=;
	b=f91aWQiO6uAwfR8TJeSEaylk9Dfr88ayMEEeNRobhgwyvbi8QLVcKXpdw8TTLDHLuvRlxu
	GPp+hK+OShgn/yB565mqZAJxpvJfx63Fm92q+HQ4bhj/gGgo71MGOLT41dElMKazRMSf6x
	iZ6WoqRc/F4N+vYxFeXK2NWwHy92bOU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-NBGivEo1NF66Sd-FvNq8zQ-1; Sun, 21 Sep 2025 13:47:06 -0400
X-MC-Unique: NBGivEo1NF66Sd-FvNq8zQ-1
X-Mimecast-MFC-AGG-ID: NBGivEo1NF66Sd-FvNq8zQ_1758476825
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46c6d1a9320so2244345e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476825; x=1759081625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWQDJIxZ9xQus8Xy+3Cne3CrBxdggcAgVrBwiy0GpC4=;
        b=CWRvaER21OEhbY3HTGBqfHpQP/KkAF/l2gWW06zTimGK6Nhb1DyNT4VfzePWYZe5dn
         donryEveuJSyKIWpevYnAnG1OxxjN0suthPbhU/nwLaV7vxbZniaLAmp1FX4rkF/6P03
         /6znUEgdODuINFSawlqQH+FIE+0F6iFhb/Ii5/zfkOIm8nfZHOkDNADfIqTXQ7X9Arm5
         V+CTRJ55y1nL5eAoiMSO+e3+7I43tPG9Z9zNYIlWKsbYjXAPGjpaRM29njvUToSnFRQI
         edxKf+tjKVQWvbBoGJtEq59aMJOW6GRP6o/kz0H9xMj3D/sWaBtN+kYaUeISI0CvMipm
         BEnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsM+bZJkmrmNb2lVP/jKplnizqQheBy1xF5osoLKRL5BH/QdN3zX/XWZHW7U5DZbK5Pn/W862V6Y2Omy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLi3NF401qvLGaFcDRfS23N/ZmcMf0vnUJQE0xv3Z5921BX1Qo
	flvp9/8ykK0Xb5dWFp8/CZOotKCxY5+fSHL5Nmmkr6TD2eLAG/nvZ6T1q1tIiq8tY2ukE9BxtBn
	uo/Se2kR4lGJvDo3y/l/5zlSzSx+2RDh89p5DV9myRSplOwc+2AW8IAeNXB23c8+l7A==
X-Gm-Gg: ASbGncujS1PnFaFNWFVNJ8KEWVnDAzkBZapTvonY9PNd/v5B2RbJnYRJUDx7jMOPtVl
	re3LuKhQZE5lvvV0UWN4Vx3detJyUOlXlUqOStsUbDFAidVqVyEwMmLx35J6myy8BtEN5Fjk0k5
	gse12MC5IO0duYdF64+tlCUY3t9pz11K+KWXJrrPo8cm8qU/wreeH5nl0oNvzfVLwPb/advl2lb
	z5dCAe+UA6f9N6w56/dnmIXGM13zmrEErAQxIqU7fUKOYFa7L0Ob3xLSTO+3ThHELbhF0bYvcC9
	m7iLu6AIGyQ5u//rLpYLmxhPcrZBAtvNDE4=
X-Received: by 2002:a05:600c:4ed1:b0:45f:2940:d186 with SMTP id 5b1f17b1804b1-467efeda4bcmr76869985e9.32.1758476824777;
        Sun, 21 Sep 2025 10:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4VjCQVZf6TthDuRaqyhVdUIeEJi6lt+Y/Gp2dhJjTZmoG1ti5YvU6HiwKPLRgLeOaiCmXIA==
X-Received: by 2002:a05:600c:4ed1:b0:45f:2940:d186 with SMTP id 5b1f17b1804b1-467efeda4bcmr76869895e9.32.1758476824343;
        Sun, 21 Sep 2025 10:47:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f1549285c9sm9585991f8f.52.2025.09.21.10.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:47:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:47:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 06/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_add variants
Message-ID: <20250921134601-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-7-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-7-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:41PM +0800, Jason Wang wrote:
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 40 +++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index aadeab66e57c..93c36314b5e7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -476,7 +476,7 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  	return extra->next;
>  }
>  
> -static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
>  					       unsigned int total_sg,
>  					       gfp_t gfp)
>  {
> @@ -505,7 +505,7 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
>  	return desc;
>  }
>  
> -static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
> +static inline unsigned int virtqueue_add_desc_split(struct vring_virtqueue *vq,
>  						    struct vring_desc *desc,
>  						    struct vring_desc_extra *extra,
>  						    unsigned int i,
> @@ -513,11 +513,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
>  						    unsigned int len,
>  						    u16 flags, bool premapped)
>  {
> +	struct virtio_device *vdev = vq->vq.vdev;
>  	u16 next;
>  
> -	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
> -	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
> -	desc[i].len = cpu_to_virtio32(vq->vdev, len);
> +	desc[i].flags = cpu_to_virtio16(vdev, flags);
> +	desc[i].addr = cpu_to_virtio64(vdev, addr);
> +	desc[i].len = cpu_to_virtio32(vdev, len);
>  
>  	extra[i].addr = premapped ? DMA_MAPPING_ERROR : addr;
>  	extra[i].len = len;
> @@ -525,12 +526,12 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
>  
>  	next = extra[i].next;
>  
> -	desc[i].next = cpu_to_virtio16(vq->vdev, next);
> +	desc[i].next = cpu_to_virtio16(vdev, next);
>  
>  	return next;
>  }
>  
> -static inline int virtqueue_add_split(struct virtqueue *_vq,
> +static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				      struct scatterlist *sgs[],
>  				      unsigned int total_sg,
>  				      unsigned int out_sgs,
> @@ -540,7 +541,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  				      bool premapped,
>  				      gfp_t gfp)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> @@ -565,7 +565,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	head = vq->free_head;
>  
>  	if (virtqueue_use_indirect(vq, total_sg))
> -		desc = alloc_indirect_split(_vq, total_sg, gfp);
> +		desc = alloc_indirect_split(vq, total_sg, gfp);
>  	else {
>  		desc = NULL;
>  		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> @@ -612,7 +612,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>  						     VRING_DESC_F_NEXT,
>  						     premapped);
>  		}
> @@ -629,14 +629,14 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
> -			i = virtqueue_add_desc_split(_vq, desc, extra, i, addr, len,
> +			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     premapped);
>  		}
>  	}
>  	/* Last one doesn't continue. */
> -	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> +	desc[prev].flags &= cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_NEXT);
>  	if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
>  		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>  			~VRING_DESC_F_NEXT;
> @@ -649,7 +649,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		if (vring_mapping_error(vq, addr))
>  			goto unmap_release;
>  
> -		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
> +		virtqueue_add_desc_split(vq, vq->split.vring.desc,
>  					 vq->split.desc_extra,
>  					 head, addr,
>  					 total_sg * sizeof(struct vring_desc),
> @@ -675,13 +675,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> -	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
> +	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(vq->vq.vdev, head);
>  
>  	/* Descriptors and available array need to be set before we expose the
>  	 * new available array entries. */
>  	virtio_wmb(vq->weak_barriers);
>  	vq->split.avail_idx_shadow++;
> -	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
> +	vq->split.vring.avail->idx = cpu_to_virtio16(vq->vq.vdev,
>  						vq->split.avail_idx_shadow);
>  	vq->num_added++;
>  
> @@ -691,7 +691,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	/* This is very unlikely, but theoretically possible.  Kick
>  	 * just in case. */
>  	if (unlikely(vq->num_added == (1 << 16) - 1))
> -		virtqueue_kick(_vq);
> +		virtqueue_kick(&vq->vq);
>  
>  	return 0;
>  
> @@ -706,7 +706,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -
>  		i = vring_unmap_one_split(vq, &extra[i]);
>  	}
>

can't say I like this, error handling is better separated visually from
good path.
  
> @@ -1440,7 +1439,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	return -ENOMEM;
>  }
>  
> -static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  				       struct scatterlist *sgs[],
>  				       unsigned int total_sg,
>  				       unsigned int out_sgs,
> @@ -1450,7 +1449,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  				       bool premapped,
>  				       gfp_t gfp)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, c, descs_used, err_idx, len;
> @@ -2262,9 +2260,9 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
> +	return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
>  					out_sgs, in_sgs, data, ctx, premapped, gfp) :
> -				 virtqueue_add_split(_vq, sgs, total_sg,
> +				 virtqueue_add_split(vq, sgs, total_sg,
>  					out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }
>  
> -- 
> 2.31.1


