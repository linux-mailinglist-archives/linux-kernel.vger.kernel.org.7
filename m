Return-Path: <linux-kernel+bounces-861316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6215BF25BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9C424F89AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5B2848A0;
	Mon, 20 Oct 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Diu7aiMp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399252874E9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977057; cv=none; b=YjLd2EcyJ+2tbBtGBLwy6gGAC8V0cWmt6SYMqz803C+JRqqzmw6l3TP/noiHGahb5lfAp8AbARXNuig+A9QSkBnd1S/NfgM8aYHxDRUvGy24BEOhp+oEPveR0h+aq7Hv06srKHUGai3YX6mRhH5qEs2+6+x1r1QPkZRwwFvvt0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977057; c=relaxed/simple;
	bh=E6TK0/TeyFkFgP3Og8WhXVAZ/nOXUxj2LcaIiVjCt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJapk4NBQWxJNratknwHWT2S2LHkEysW2J+lfTjrOiJQ7a5v8n2TVWVXmybMRSOE3fLmdHm3P1UTAQ5RbdHCrop/BMOdNDR6g6icjGuJzTAn6Xa7Hj2ZPfhQA06XXTOGLIj1R1WGf3LFFHLWK3vlvWRObwvVDWWhW5I3+8Hzd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Diu7aiMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760977054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwmR8e8wVmFugkcuhatIXbUfJ+2hKp6p73SMPj4eo7s=;
	b=Diu7aiMp1bjkxi9zft6ZZzpEW9Bh0Z4njeK318ol3FZ6BW3FwUnRKJmZ5p10A/eD68QSqj
	tTIJ9B2WuhGdhE7ew7D5mq1AtlHUoFhmZoxLBZ717+Nd6QZeftKFgQn8WdA3PsuwNnVmkK
	u1IMhQniq5tvOFQV062UzTa9o+3cM7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-goAp4tgyM8GRTmbPH2O-cg-1; Mon, 20 Oct 2025 12:17:30 -0400
X-MC-Unique: goAp4tgyM8GRTmbPH2O-cg-1
X-Mimecast-MFC-AGG-ID: goAp4tgyM8GRTmbPH2O-cg_1760977047
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd49f185so37852005e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977047; x=1761581847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwmR8e8wVmFugkcuhatIXbUfJ+2hKp6p73SMPj4eo7s=;
        b=RZALXiordomkGxXweRg4zFP/8SWYPSrYYPkdoBHNPgHqWS0FCphQY2m2WuF/S3Ztan
         lDj9Kk42tf/XOXkfuSfoAa/dNRA+saH/2N1JvY5HWiAn2dGqVyMHy8Rl7cz46j84Yroh
         i0uymDtG0s+w0qm1y6HG01a8nBTW1dlEzowImgvXtqvYJMmBHpBXOhcLq42SaBnEyDeF
         6biLoWvylN4AtnqmRoQbaqrCuR14i0fu+3a+Qok1yvGX9w3UYivo72R02BuX84lGaPAV
         QA9u8Xke66yBzqXLhfhsg6/VEjp4suE7R6WcqE82gcuvRxUSt3OZQ+SyjbpkXKuV9JyJ
         KMVw==
X-Forwarded-Encrypted: i=1; AJvYcCXA3zWuVjOjnrYVr01L9goisD5EezyyWd/7Mwyy51L3objeEXDt6E3dMQNi9VYedVuDRacahtMr5xF8x58=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWcgjrQUf0QlppR/y2XuSFo1nYqvAIZCDqHw31gTqKuMTCPKM
	T+AOlZBuniGivCtyYyEnEmGrgzx2nhOoVjpa8jQ4hceOGHk4pFtcFHEvBFaNlj1ljR5gnHgulgG
	POyKANwISq8i1WyV1BUx3kgEfeW+aqU9vdX9ktUOg03L7o2XPy4wgKvSKfseX6lc4TLY/7U3Lhg
	==
X-Gm-Gg: ASbGncvCtkpNUJNcVGy8LpgXsI3lsGstap8LnNxQM12eylq8z+bWS0CtJFYKTey6oUD
	zLoO8K48Pq9yCj3A0+45TNlYBM1OpUsDwgE4o/53a7CWZ+kpi/RuoECfYfOJBIsTi06KTPc7ABu
	35yP4quhd/hUETavFgGrMc4AvMQwLGxIs678sYQq7ufOvo99MLKTEejsYBUGpoE8s10/yuh2hlZ
	dp/BIKjLdqiUJbwR184dF4oY79Go0nE78CCaXVDkuyA/x7DH0ai15tGkp9njUQdpWHdHuhSuJ9Q
	ad9de6aCUUaZKtyKV64zRCfuKF8ESO/ROWuAcPkaV1AmCv7q9vIp9Gih64nEfjWSAJdH
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr104932005e9.22.1760977046852;
        Mon, 20 Oct 2025 09:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNusilfxfBuyuVngG+GxZ6EUWsDDRXTagDB8NASH7BRocXCsuYYBS7524mf8E8ULXgqGoP8g==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr104931795e9.22.1760977046396;
        Mon, 20 Oct 2025 09:17:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d8b2sm181951825e9.3.2025.10.20.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:17:25 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:17:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect
 detaching logic
Message-ID: <20251020121643-mutt-send-email-mst@kernel.org>
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
> +	struct vring_desc *indir_desc =
> +	       vq->split.desc_state[head].indir_desc;

why split this line?  it's not too long.

> +	unsigned int j;
> +	u32 len, num;
> +


