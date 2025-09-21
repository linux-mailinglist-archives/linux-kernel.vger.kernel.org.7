Return-Path: <linux-kernel+bounces-826334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36215B8E366
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09C717E0FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35F213E9F;
	Sun, 21 Sep 2025 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hI5Nmh/B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4026F287
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480008; cv=none; b=P0bKuFPI3dtGqd4iTrH2UoX7kvVA5zjDib5Dxi9NDKLyrBLUzOCAfwFlGIBz3wJHq+B1r0KFtlNCGfeBsguIZIOsBoWwwpio/icLPNlz25ETgg8GUctAzjnzg20xPImktd3zX+W+7o0SUhqMRp8vUNy5zIyz9qNt1Kk2vgwarvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480008; c=relaxed/simple;
	bh=N2URmMcqqSL9E+49wAyf/0otiSSQtKZ5dw8twXpZWps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2uXCqKJqQtGxw8QrGApTkrqWDnAtm+npFMFXz2GBJUSFa6Ju2xObdhzVQsYMq9gzeyyYleJ2Qy7914Ap3moLm2wLDk6XBzVnisBCwiHdZH2Tn0qQBft0iD1EvYEL0nt2Try17lXCWCZJ9X19YxLWSXS/yK9pC3J7jQe8Y/hR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hI5Nmh/B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758480004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJXH+iEnGEt26c26vQRT9hIQ+xfb73XIUiLB79dbIag=;
	b=hI5Nmh/BYok5oiaARdlijDhluvohHsxinZwvTMft3zf2i/k+piTvyDozg/zDPhUKJIVrNO
	yOOQ0i1FTR8yF/fycJO8u5B31ymJ5r5e/8csQzuzwsHJhgtGzp/Dyx7iQTruK0v+WL3LzZ
	QoGsJLtGjI1EJUYkAA8j3ZQdoTGEeKA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-09DN1mo3PVugZqJJpA2ukw-1; Sun, 21 Sep 2025 14:39:57 -0400
X-MC-Unique: 09DN1mo3PVugZqJJpA2ukw-1
X-Mimecast-MFC-AGG-ID: 09DN1mo3PVugZqJJpA2ukw_1758479996
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f28552927so28716835e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479996; x=1759084796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJXH+iEnGEt26c26vQRT9hIQ+xfb73XIUiLB79dbIag=;
        b=gIhgKY0p4M0mIUliQIDMUMK1zhlkqtVTyuNSlIA2QNEIIA6Ulb9io1UkrybBonFkRH
         hIjTuZTbm60n2OlsXqaHPUZwVzo4+f13LhTbdNKa0gDsB7ugOtvVB917W6ePf5cO7R2X
         y2D4E4s+ryxY/YfLkmD/H+nKohtYYf2szEkw940dI6TPqY/oIOjMcaq3kaUwVZkpwW/u
         r90moMonU29WD2EGj3a3ZqyF7U9fmu171oK+puczi4MGlxvttH260CZ6uN3KQFhjUQQ7
         iOcTm+BhmMZZTVEd+BfpSCbbEdDT3FVBoS016Iz8I+E+3vVkdimfOkNwhx1yA5d63PKY
         dt4A==
X-Forwarded-Encrypted: i=1; AJvYcCU9qSwiHtIqLWlB35YK4LrDy07384ZuE/RiA4Py4lmatuZHtjUeRrmzE+R6ePqgfuKLFttPfV25vn+VD9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGev1ZOerfIlP4hIt0/a4xXYaYn/0HWIZCu7z5161mF1i7695p
	fKoOHapsJnKO1jiL/MBK+bp/Nbl604g3i9QwwC1Z+XHUTjnc/JbA7GSXfETh6nUfFTPDPN5LkNn
	MoFEhXsiFtHOGgXP1GAPUwe3nus0qyE2iCvEFLiPPWhslnr/k6UgMLWOc28xeaN3Kbg==
X-Gm-Gg: ASbGncu9qQ0kJh75Tb9AevKJfU+hDjJ4oUXUAeWLqEJdqAofrNQYLckQ/1VRA3RZMR2
	Ue68mpOeDSIxV1Y+DCIyw4ltlOqkX0GOkVCfVcCWIl3ZV/Y9uL+/m0pkWsB3fG2jtzWbT3p8wF1
	a2vLC12uIpoI32xFEhpTcDTUWlB4PPzGgJQ5bwT4Y84AyPcQT23LGpO9jmu7DFS7hckrWAEwOtt
	asbfNwdCh0PxbeUWExWJsFOskKFXDCPcgm0wmTusNf6hWpembqzhbvVnE23oIjAvVJp470vQ4Df
	s77dgVVxnzJBxf3Ye2is1pU8L3YIdZAl5Fs=
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr95488175e9.1.1758479995821;
        Sun, 21 Sep 2025 11:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1CBCIW++Ueg7vKc5VsvYUAu+SHw7b8hKtcbIM6zE006kbvlAaeQ1o+vByx1lH4SuXnMbMJQ==
X-Received: by 2002:a05:600c:4f42:b0:468:7a5a:725 with SMTP id 5b1f17b1804b1-4687a5a0801mr95488085e9.1.1758479995417;
        Sun, 21 Sep 2025 11:39:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32640f49sm117008595e9.9.2025.09.21.11.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:39:54 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:39:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20250921143758-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-15-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-15-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:49PM +0800, Jason Wang wrote:
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 1045c553ee65..0949675a3d12 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -574,7 +574,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	struct vring_desc_extra *extra;
>  	struct scatterlist *sg;
>  	struct vring_desc *desc;
> -	unsigned int i, n, avail, descs_used, prev, err_idx;
> +	unsigned int i, n, avail, descs_used, err_idx, c = 0;
>  	int head;
>  	bool indirect;
>  
> @@ -631,6 +631,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	}
>  
>  	for (n = 0; n < out_sgs; n++) {
> +		sg = sgs[n];
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			dma_addr_t addr;
>  			u32 len;
> @@ -638,12 +639,12 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
>  				goto unmap_release;
>  
> -			prev = i;
>  			/* Note that we trust indirect descriptor
>  			 * table since it use stream DMA mapping.
>  			 */
>  			i = virtqueue_add_desc_split(vq, desc, extra, i, addr, len,
> -						     VRING_DESC_F_NEXT,
> +						     ++c == total_sg ?
> +						     0 : VRING_DESC_F_NEXT,

I would indent this line a bit more to the right - it is a continuation,
after all.

>  						     premapped);
>  		}
>  	}
> @@ -655,21 +656,15 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
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


