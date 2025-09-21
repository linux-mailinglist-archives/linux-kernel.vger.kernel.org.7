Return-Path: <linux-kernel+bounces-826326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BEAB8E32E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9490D7A8ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCBE274B3B;
	Sun, 21 Sep 2025 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSYi9caj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4A275B15
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479400; cv=none; b=fDfGMA30/bgH1RoJc9g0/fpsV2YX5AG++8leimgznKfyCpI4EXN2+FmuLAUdpzbpOG8ihcU4XY7daoLv+ekKW3zWjMsNwtp/LpXU8h7s5NYCYzjb0oaL69mvdxSnksfNV+XwFIOTPZLvkeu5Jd6zW7eTtD2dutn2UAaIJP/Rf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479400; c=relaxed/simple;
	bh=pMyxOGeb5oVjj4fEP0W1iI+2iew8pDxqBbAOsvbwy1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYWzjQrz2aBqs55pbZy2cSOfRA/EnF3kOLSwpBWz77wxk2ffQ+3wu0i2ONfOr/fXrKP9Ead7duinWINTCGVnoe6+GTzd9CCfRVovjyCdFJGJmNNtFUGYP6Ijn7x6Z70pSn5lA3kjSc0zGFTggRBeUq7RP5Lwh9wIpX2R/KqNxcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XSYi9caj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758479396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xi3Q36Umb1ocjAnnL+rb74WQIv9fN4aAewp/7ADKp5s=;
	b=XSYi9cajJ+otuUsHNtOZ8M2svfPwVT9CMJ/1TpTESOrarnzsEqJOwp3qHUK7tlZHWgUn8c
	499y4fFCvEPNWGPyVh+m38sd4Us1kZR7gRvnNsv/gV8A5lFLxhnGyMAJGRsgLlP3RyJjky
	nSEikPm6heja9YaIx6cSi6zoWajTPjs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-wShiSCCzMhODe4muSVhQgQ-1; Sun, 21 Sep 2025 14:29:48 -0400
X-MC-Unique: wShiSCCzMhODe4muSVhQgQ-1
X-Mimecast-MFC-AGG-ID: wShiSCCzMhODe4muSVhQgQ_1758479388
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f42b54d159so910073f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758479387; x=1759084187;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi3Q36Umb1ocjAnnL+rb74WQIv9fN4aAewp/7ADKp5s=;
        b=Q+7ITZUZQP6FWxcAIJnPiKFGSe+Wvy8CMzx8ZpmGg1hB64oDDTxWHukaPNIWYJZifs
         /4q6RLVFoMZ/o5nP8Ca3HsxWq1VfLtrJijoka4Q5Z0ubJj5rhFM6exDAwaz3lWEmVuCc
         tGQ8rK6BeJ+dM2Va2j7K7pRY/5EF2vSTt2emZwGzcJlJCZ9Vr9taOgR7NbI5UI6Mk3av
         SQr9q27U8PBVZZ7mSQgPTY4etbKzwAbnds3c4EQutIXfND1K34B1QTh9qwIOmWMVs4BP
         wF7w88TSStpXs3cZwlUiWi6FdMhHE/qIcBHfbleNUnZ/JLJg3n9LOqyoxMY6vm9I5F3g
         zIEw==
X-Forwarded-Encrypted: i=1; AJvYcCUO30FP9Y9p5Bqn8JeDE3YwiPM/xhIfLcBsr/vL643JAM9EHC4IXVWkQexpVvZrkC/ljM8v8gl9tEiwRbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwonOQcxGgfbZQrC3S7t59OGreaElWL4gl95mP621idB+mMXDNR
	agXJ0YwJdrcwDMNHHxouO0DIlj0EyfGIkBGCql10W9e6GZiZmEALT8k+5I8yzaXb2CDh9rAHReN
	5yoUSVIt9qdGDhxtI/Ncr3JGPLLBvcVA/dCsTpC2Lrbrhd/3YK3cKIiU4V1VKiJTUczOTNirP4A
	==
X-Gm-Gg: ASbGncukKiiCpVjbI/uN2qo68Yzks6xi8NGj57LH/2K+76vDOWMIpp8LA/uS2sAGwqE
	tZKPuGm2F8aPuEkRXCpX9k5ODn4zvxygQ57XzGtkOkRFgWGSrVoZ+cNXrYInp95ksHdVfVEx3qF
	Pyzeu0v0o1P6XKa7CRne8Sl1CM+ZhOF1dvDUGByUAq4w9l3eMhF4hHEeNJ4K0AYhaeQY1oqpF7k
	8ZdnMbqImEJzT6SRfU1WniZrCkhZ4r7eVCNsv7Cx5w2ojshWtJ/MabBs9HWeSUKdnwrlVFwNhu/
	DyDvUpl8foYmmOlAVZl61+hoKRdHAhvbyR8=
X-Received: by 2002:a05:6000:1885:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-3ee7c5542dcmr7437647f8f.6.1758479387338;
        Sun, 21 Sep 2025 11:29:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu+sBvIt0LD21VK9jjeR773Ft05O6meMKTSw+bHki1OLH+aCrewOi3MGKyVBlQ1Z0xCPojyQ==
X-Received: by 2002:a05:6000:1885:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-3ee7c5542dcmr7437632f8f.6.1758479386938;
        Sun, 21 Sep 2025 11:29:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f95c5cdaaesm4751670f8f.4.2025.09.21.11.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:29:46 -0700 (PDT)
Date: Sun, 21 Sep 2025 14:29:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20250921142505-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-18-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919073154.49278-18-jasowang@redhat.com>

On Fri, Sep 19, 2025 at 03:31:52PM +0800, Jason Wang wrote:
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)


it is just a refactoring but the code can be prettified a bit. see
below. you can make it a separate patch if you prefer but i think
it is ok to do here.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f376f717c8e4..5aa0cd785362 100644
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
> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;

We no longer need to split this.
It was like this because it was indented.
By itself  it fits under 80 chars even without and
that is no longer a hard limit.

> +	unsigned int j;
> +	u32 len, num;
> +
> +	/* Free the indirect table, if any, now that it's unmapped. */
> +	if (!indir_desc)
> +		return;


en empty line won't hurt here.

> +	len = vq->split.desc_extra[head].len;
> +
> +	BUG_ON(!(vq->split.desc_extra[head].flags &
> +			VRING_DESC_F_INDIRECT));

same thing here. no need to wrap anymore.


> +	BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +	num = len / sizeof(struct vring_desc);
> +
> +	extra = (struct vring_desc_extra *)&indir_desc[num];
> +
> +	if (vq->use_map_api) {
> +		for (j = 0; j < num; j++)
> +			vring_unmap_one_split(vq, &extra[j]);
> +	}

use of {} questionable. we can keep it if you prefer though.

> +
> +	kfree(indir_desc);
> +	vq->split.desc_state[head].indir_desc = NULL;
> +}
> +
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  			     void **ctx)
>  {
>  	struct vring_desc_extra *extra;
> -	unsigned int i, j;
> +	unsigned int i;
>  	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
>  
>  	/* Clear data ptr. */
> @@ -799,34 +830,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
>  
> -	if (vq->indirect) {
> -		struct vring_desc *indir_desc =
> -				vq->split.desc_state[head].indir_desc;
> -		u32 len, num;
> -
> -		/* Free the indirect table, if any, now that it's unmapped. */
> -		if (!indir_desc)
> -			return;
> -		len = vq->split.desc_extra[head].len;
> -
> -		BUG_ON(!(vq->split.desc_extra[head].flags &
> -				VRING_DESC_F_INDIRECT));
> -		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> -
> -		num = len / sizeof(struct vring_desc);
> -
> -		extra = (struct vring_desc_extra *)&indir_desc[num];
> -
> -		if (vq->use_map_api) {
> -			for (j = 0; j < num; j++)
> -				vring_unmap_one_split(vq, &extra[j]);
> -		}
> -
> -		kfree(indir_desc);
> -		vq->split.desc_state[head].indir_desc = NULL;
> -	} else if (ctx) {
> +	if (vq->indirect)
> +		detach_indirect_split(vq, head);
> +	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> -	}
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.31.1


