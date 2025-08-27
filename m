Return-Path: <linux-kernel+bounces-788392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94572B383C0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9228D1B235B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8435207F;
	Wed, 27 Aug 2025 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAdQFc/+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C1634A30A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301620; cv=none; b=Ib6mCQcOndQpK5trINSDTx/bjk+p0p5gqXmo71ZR7UxCB7XSSj3bY4yGjK/QGVkNOiUjvTJ8yUafi3k2ce/LA+ja/mHHlhEvuBCeYaz4M53jFpVgelWzmE5Xw+AzNmclz6mglJDHspet1m0izQzhxvCvhb5H3W75pODPSXjGJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301620; c=relaxed/simple;
	bh=chTWJ/zEI6rTbv+YqS2P0SrjG/e7+RT/8QbiIzXP3ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmuk9SXhaOojOQu7FCqnvB3B8rHwoOJh51drTVWsjo3YFDHilRNdIH0MBLUCkLoBkYiez6abwfy/YdoHnWD67p0zzicI4Q50a56kkZEqM7JW2AqyeUTegnTXGnZ2p2D7kUou50vY9+8Qb2KKNtmjOvaLLq38saLrPQ0fMukkmrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAdQFc/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756301616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K8z/3KgzEoz0nXpB3RNGuEeKXFHUG30ORWT5Yv+ILFU=;
	b=XAdQFc/+APj2Ni6OA8YpWcFuFZtMD5MnA7H1+sOHppuLvZK9r5LDJw2GcvaFg2GD59HuIW
	66ASidHiH96Qv0LROw6oZOu+cUraRJWjTifKl0zT8xWL5NliT/NbkFTM099buDRZKRZ5JJ
	zC2DKUHZi1NEPS1zSOKLH8HlcLtleX8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-5AxBASESPZqW7TLdP5WcUQ-1; Wed, 27 Aug 2025 09:33:35 -0400
X-MC-Unique: 5AxBASESPZqW7TLdP5WcUQ-1
X-Mimecast-MFC-AGG-ID: 5AxBASESPZqW7TLdP5WcUQ_1756301613
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3c79f0a57ddso2381590f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756301612; x=1756906412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8z/3KgzEoz0nXpB3RNGuEeKXFHUG30ORWT5Yv+ILFU=;
        b=cN4IMorHGrGFE1iuR+6iLSnuNXTStNUORHK5GEqLzxsMP+Yq4tOvtatW/0N2WDTWw+
         4T6W1pK21z/SaH3Wx0M3QSg6/E2PVQnEWTB3NSfYpWu6TGkM9PgEV2CGG3koh0RCVuTD
         PXZ5cmMALAEXJkTGoRNv8770bt/c5cEAvt8TfKIuDCLF42VkgQYbi7cy0a4lnN6gOtyZ
         WGpdlCG08HhP+FadPkNGturv2d3iU5Ne0my5BflDnr4Co89SYKk3f24791xsy0UXFaWa
         rnlnomyUaptqhYQFTj4oDFO+dlnRdCIOL0EwsIJzllMC0hXMzsaELuCc0sk9CUlgsT4n
         CpKA==
X-Forwarded-Encrypted: i=1; AJvYcCUHB6ojc2wiP2vqaR5/BdZFQCXW/BmtFfBAZbBXF6DA4VVWax3aQl3yt4K+pY5ljCsK2L4QoWwxwVV0uEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD1ze3VDfRMM2YLGbpfABTnf9p56HqPhyZ136CcnFocYBQxivb
	8dIcuHYy5+iB5LFmH3eAyOys4OxirjUpOX5lDpHt0CD5BUmEV7VD03ImMGUAyPVWhaK4GEN5O8a
	ldahmtW8vmiWf1wRzgIt9Eh2zDKrjVp9d38VMGrVk2W0C87h7QEPxsQrK6phAlfBi3A==
X-Gm-Gg: ASbGnctCeVJWHeQTWag7wPl9MwoH6cqbAnVBRd3PAUmeEP8ybJ4gp5skf+O6B28t4M2
	7bXpLpHGStncnUZ+IKswpZxn6zY9TCRK0btxnerfifGsodsyD1PaAbdW1ytnrPAz2jPjNnwhmU3
	mT3YWHvDlHxTq5i2+/z+0omQma9P3DU3VlgDlJRVY4Hz/cs2aFp3UCKVk1SmAcEYO5mFP0y7WSM
	ko2ByaCBhg+9wz1EY9yCYfUPCMyA25UofOlvlJqD2kJiZf1WEh6iWmqLnwSclxnbkE7i/b9Jsua
	qvXSreZlUg5IwvqLc95FAq3Dbd+Rrtw=
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id ffacd0b85a97d-3cd4ff9c926mr847040f8f.45.1756301612371;
        Wed, 27 Aug 2025 06:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpXWIRKQBLCST7L7FbqSdMsqrTEd8mC9YrfacqJgmW7hhmhY+MtE22/oJUnVDrsWnKorEEVQ==
X-Received: by 2002:a05:6000:2281:b0:3cd:4ff9:c487 with SMTP id ffacd0b85a97d-3cd4ff9c926mr847017f8f.45.1756301611871;
        Wed, 27 Aug 2025 06:33:31 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ccac1b892bsm2973545f8f.67.2025.08.27.06.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:33:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:33:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Honglei Huang <honglei1.huang@amd.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: fix host visible memory detection in
 virtio-gpu
Message-ID: <20250827093320-mutt-send-email-mst@kernel.org>
References: <20250827081231.1878248-1-honglei1.huang@amd.com>
 <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>

On Wed, Aug 27, 2025 at 03:52:05PM +0300, Dmitry Osipenko wrote:
> On 8/27/25 11:12, Honglei Huang wrote:
> > From: Honglei Huang <Honglei1.Huang@amd.com>
> > 
> > Commit 206cc44588f7 ("virtio: reject shm region if length is zero")
> > enhanced the validation in virtio_get_shm_region() by adding a check
> > for a zero-length shared memory region.
> > 
> > It is performed before the underlying transport's .get_shm_region()
> > implementation is called. This creates an issue in the virtio-gpu
> > driver, where the `region` struct is part of a larger structure
> > that is zero-initialized by drmm_kzalloc().
> > 
> > Consequently, the `len` field is 0 at the time of the check, causing
> > virtio_get_shm_region() to return false prematurely. This prevents the
> > host visible memory feature from being enabled, even when the device
> > supports it.
> > 
> > To resolve this, this patch bypasses the inline helper and calls the
> > underlying vdev->config->get_shm_region() function pointer directly.
> > This ensures that the region's parameters are checked only after they
> > have been populated by the transport, aligning with the intended logic.
> > 
> > Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_kms.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > index 7dfb2006c561..ed5981248302 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> > @@ -174,8 +174,10 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
> >  		vgdev->has_resource_blob = true;
> >  	}
> > -	if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
> > -				  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> > +	if (vgdev->vdev->config->get_shm_region &&
> > +	    vgdev->vdev->config->get_shm_region(
> > +		    vgdev->vdev, &vgdev->host_visible_region,
> > +		    VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> >  		if (!devm_request_mem_region(&vgdev->vdev->dev,
> >  					     vgdev->host_visible_region.addr,
> >  					     vgdev->host_visible_region.len,
> 
> Hi, virtio_get_shm_region() change has been reverted by [1]. Don't think
> anything else needs to be done.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250827&id=ced17ee32a9988b8a260628e7c31a100d7dc082e
> 
> +cc Michael Tsirkin
> 
> Might be only good to send a stable kernel PR with that revert. I see
> patch available only in linux-next, while stable kernels need to be
> fixed sooner.

sooner than what?


