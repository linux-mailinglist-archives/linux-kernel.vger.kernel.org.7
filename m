Return-Path: <linux-kernel+bounces-826307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 085E2B8E275
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31B9189C775
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335A273D7B;
	Sun, 21 Sep 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwQsDnGV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9772F1A2387
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476651; cv=none; b=cfpfVjybSVus0UAnGFgOLcKq16tzkBWIA1ZDIRUsMlB7kY0tyEzvCmKN11ImGPmj4RtBMz8zx/PQdwxbDR6d7vW15PvdkWWkoNYUBVEvfEhAtPffbMr1Rij/Uuj99yU9Xwm5SY3zgNA0ChtXTRDnWfeGY4JfqfGFQpT6bXYPaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476651; c=relaxed/simple;
	bh=LvT8oGd5u6CH/ESo2P4mkZoxFwFx3wJMIuQOb+wu7tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIOM3PsAiQqPb8imOd6VpQp1WMwVpqXDgnRjmggsIKm8k0mMker/fiahRxtDh9TJI6aiKIPnxFuO4d2z4fuH7fyEO5gZ5XfvxOKLz1icpJQJQ6rT1BairEXeTYO01a4+trVDZXqMwanp1Cmr9Q0cfmhfWY9MibDnKl/6X4HDY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwQsDnGV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ja6bk3OZIOMP0JkRTfcKTdTZycfJVtYVqkigNFQTRI=;
	b=JwQsDnGVZ/dsVZzaMYDwag6Xk2JGaTh4w8SMnhhmjTHhUa3FdydNtmW42yRGszcIvy+sdt
	pSw3VRMUQ1cCY1Tjw1R905RHRZMMmO2CQoyiFYU/IZI5MuKQKqOe8cnoZEv11bVDMqH1U4
	Gv0iGAwkGkEQF+J5j+X5dTwRONwvWN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-7dQDQvHnPKutPo0o4JhoLQ-1; Sun, 21 Sep 2025 13:44:07 -0400
X-MC-Unique: 7dQDQvHnPKutPo0o4JhoLQ-1
X-Mimecast-MFC-AGG-ID: 7dQDQvHnPKutPo0o4JhoLQ_1758476646
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45dd56f0000so39069055e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476645; x=1759081445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ja6bk3OZIOMP0JkRTfcKTdTZycfJVtYVqkigNFQTRI=;
        b=Eb+JfZjukf15T46pKAZd6aIeevZ10vCm3p00TD0IB2YQVX9L8wnFk7/ZLW9EDZ2rg0
         cFB+Z1QY0U8LJdlQcmVfjpHHzlgEzCEjogbKNaQ6g13N5JgTT3fSIROKCQBhGed3sRlk
         KAOikmyMXU6FF0GmEzJJk00nIH0wrmckQ5GsFtDT9eVw7IWAcmVKvVHjl+kapbN4z+c5
         b4D9wC7yuPkZaAYgaIYASo20qHrcVjJX4Gh/NcsDkT82iA05Z09eCP+kJZ0HJocBjR1P
         Peyav0GzOyH8aV0xyOSOYgQZNdRUxSJpY4TT9Z8RiK+TuMEDApuLNtUWC+FlCATdKLME
         RcEg==
X-Forwarded-Encrypted: i=1; AJvYcCXNL3XwSSWn95KPxxdZXNv9/Th3B/ZDy8kZzqsP62eeVNlsJXReZgEyOw00leuMB+rZw2YRsRa1oDO8pPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd9I/x6Hh6TrQ17SI/GGcmLMwR2CYOCuTR9iCw0lzjvkUsYlGa
	Yf0ycD2FbVfq4VLwdkc/tTHmv5eY8kR8u1dUqj4PLA1428hQCHv71yfNj0K/C3ZbpDOs0qN9uPB
	iiq04FHLOiDttj4PK4vbyswf3LikDnybeqdk0H37HWREdMk+n2C0/Z7/8LfXoy7oaBjsdKhA5wg
	==
X-Gm-Gg: ASbGncu0zqRZSuI3hh4XMpUaNaxn80aG0iJ4xsb0aE068DfniPQ/uRXZ9HptenbY6Oz
	JRe5MSP43aAjtkNXWN7x0Cci6vHO/XiT9td9yB285sw/mLeM6jLUb/bOYnHwBEemFfh2XgSF/SY
	ZjNHsurWti1DbpZfWBulyj5w+mvvslCjAxP2jh9dc1dVTts2TDu/IAQ9RgtFj+VsuUrqHFUSDbX
	7hfRl7/pDZA6hz63tXSGUEIrXkBvVXuivIYFwsWJjQCs4zi0w70Uyr4CI/bByaLFh9Nc/l83iPZ
	/Cx0a3qS4BRZcGhzWGLUPRm6kVw0ZmQL5Q8=
X-Received: by 2002:a05:600c:8a16:10b0:468:1a3f:c4c7 with SMTP id 5b1f17b1804b1-4681a3fc4e6mr79590195e9.24.1758476645656;
        Sun, 21 Sep 2025 10:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH0xEwAxiicRk6Wh8us79HfrItFjr2zQbpgO1lL0QPCnZY66TW8UA4iOeJ32MywWIrxn1K+A==
X-Received: by 2002:a05:600c:8a16:10b0:468:1a3f:c4c7 with SMTP id 5b1f17b1804b1-4681a3fc4e6mr79590085e9.24.1758476645311;
        Sun, 21 Sep 2025 10:44:05 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm128532715e9.0.2025.09.21.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:44:04 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:44:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 14/19] virtio_ring: determine descriptor flags at one
 time
Message-ID: <20250921134323-mutt-send-email-mst@kernel.org>
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

How does this make any sense?

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


