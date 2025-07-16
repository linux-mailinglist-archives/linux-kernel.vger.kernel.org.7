Return-Path: <linux-kernel+bounces-733639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0FB0773C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D806D4A4CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF881E7C2D;
	Wed, 16 Jul 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7V9bvsT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A6E1E5B88
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673540; cv=none; b=LOguU9RvMKP37e/fKfDxS6m1EUlvb+8TzbhQ4uVCvUFxSQYXWNIdLYJys5BPEOszw6PQrSV5U8h7df9W3FE+MVwgbSMRbXATU8jxhf8X51fLukjc+ppFWYW4qzFly7aC8VSy8dzOr/ajDuGbE4U8Ldwz6cRyPUj9o2ImADbHSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673540; c=relaxed/simple;
	bh=MPg4EE5I0+tMhvOJhfhmxHTCL0q9r66jTiHCRaj/jH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUT6ar62LICdr/dknQJ5w3ug9RUha71Ff0kXKGzHGj6XIoBI6D4127YMxr9F6YKyjiEMXNEek1uR04HzYfwQUmHIwAEq2Z2rAYmlUCinpQm4x2DY2nTfdTznq4SqOgZEBQRWcPeDwUCWpfYPE8E4Ul8KfBHn2tR4zSw5czIbwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7V9bvsT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752673537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BzG4s6GH/MRwK8y3gbFMVIDxtkMeQaen3c1mJicjw+4=;
	b=U7V9bvsTOQC/mJbXUBjoA6qPAHiZcZketMvOeAv2M1L6MnDxRrBsHzF4AEF+4by2isGNn9
	4pL4lKHi1MzNJKm+7kECduFQa0+apHEwXLaMg3BFEElRDe1hnRgzG/EZWADJmUnt0VrYWr
	cbLN3AgsqXzb4KbSHw28LR3Stkjbyls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-BDWF7nk3Muq5VLOTjimwTA-1; Wed, 16 Jul 2025 09:45:36 -0400
X-MC-Unique: BDWF7nk3Muq5VLOTjimwTA-1
X-Mimecast-MFC-AGG-ID: BDWF7nk3Muq5VLOTjimwTA_1752673535
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f3796779so3173100f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752673534; x=1753278334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzG4s6GH/MRwK8y3gbFMVIDxtkMeQaen3c1mJicjw+4=;
        b=JKUvAHaAMNIDVM8WQkrCCNoZ7Rh4nNqCq1dTSICgupP3kQ4iq46e82FpE+hRb5lDNK
         zL12U4Hsxp0VCkugt282l4st8JuziAO7shOdpYgiUsY7VrjGIwCE5al+LjK+4WYJ9tCf
         dGRf/cvNFYXPLa3fmT2ukcFwyHb05c2mkC7wclSgswjI/qvAcIm9eRDjMuezhSzaAitq
         GnosbEALiJVGlcP4T853CsVnHtbK9DI+0WYa6Qo38Tb4BFaD+oOuKNFFha2MkfZ2MvG6
         VNq4SDLxnUDPVeFAxdKw/Cqf6LjR41JOiZ3Y2keTOulRoMgmr01+H6A8aMDTPodnJSD9
         cVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPZFigHhAQMLCpIkj22nzAKR1z3Plbc4uQ4w++EkcE+t+02KrHez1VCh/UpL/g9ZO0V3BxoyhtDJOEJhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4q1kAgZ6KXqHGczlcnF1rbbzGUOPecVl3hkmmhO8NNe9csfK9
	672SvVvq93ia2BcVOdpNucT6PRHF1p0FWVWUmYXkrJmYMTQWedLG+ZNweqlktCxET/uhY+buYso
	LPR89eQy5nWAfaBOgRjt/L1A2lLmVqDGeWxk7azqIp9WyJetHfnYspSDVoZzaQckPLIaWnOti9g
	==
X-Gm-Gg: ASbGncsAKDUKzVb5eRyxoQrDLtqsaSxHxV2BUd5p8BhC6ic4/pX0NfYvsm/GESBzIvn
	1gMniYjvCoB6uYtba2lvilgxQwGzpBkJn1QJx1xtHcQ2b1agwe9umQcv1WNF1GfKQYMvlwUx30L
	e9j28EBDi2Ht0gmf1GriIl1Kin7rSvNUQvIwiNkfVBVgNbhNgU+FhqJ+z4Hk7glykb2J9NqrejK
	6RG+Ej7G43mdxtlfxPOoTyEzgYGYFJq+01UonHZaWpKyPeSwJpaMhwo7bS1FBP8XmON69duW7wD
	DDHvxEw+cAd+WSkdQuodvS2mGu+SbeBP
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b60dd4fademr2281069f8f.17.1752673534499;
        Wed, 16 Jul 2025 06:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDl23G87l0xWrShlZkzWfmkRE81fr+mwiy+IsaH40FgxN7MhRFtfKraLRaKD+dZPLwNm5OLQ==
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b60dd4fademr2281038f8f.17.1752673534057;
        Wed, 16 Jul 2025 06:45:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26c97sm18146038f8f.90.2025.07.16.06.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:45:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:45:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH] virtio: virtio_dma_buf: fix missing parameter
 documentation
Message-ID: <20250716094357-mutt-send-email-mst@kernel.org>
References: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241C7118259DA110+20250623065210.270237-1-wangyuli@uniontech.com>

On Mon, Jun 23, 2025 at 02:52:10PM +0800, WangYuli wrote:
> Add missing parameter documentation for virtio_dma_buf_attach()
> function to fix kernel-doc warnings:
> 
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'dma_buf' not described in 'virtio_dma_buf_attach'
> Warning: drivers/virtio/virtio_dma_buf.c:41 function parameter 'attach' not described in 'virtio_dma_buf_attach'
> 
> The function documentation was missing descriptions for both the
> 'dma_buf' and 'attach' parameters. Add proper parameter documentation
> following kernel-doc format.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>


Seems to be a subset of:
[PATCH v2] virtio: Update kerneldoc in drivers/virtio/virtio_dma_buf.c

can you pls review that one?

> ---
>  drivers/virtio/virtio_dma_buf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_dma_buf.c b/drivers/virtio/virtio_dma_buf.c
> index 3fe1d03b0645..95c10632f84a 100644
> --- a/drivers/virtio/virtio_dma_buf.c
> +++ b/drivers/virtio/virtio_dma_buf.c
> @@ -36,6 +36,8 @@ EXPORT_SYMBOL(virtio_dma_buf_export);
>  
>  /**
>   * virtio_dma_buf_attach - mandatory attach callback for virtio dma-bufs
> + * @dma_buf: [in] buffer to attach
> + * @attach: [in] attachment structure
>   */
>  int virtio_dma_buf_attach(struct dma_buf *dma_buf,
>  			  struct dma_buf_attachment *attach)
> -- 
> 2.50.0


