Return-Path: <linux-kernel+bounces-826374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C476B8E5A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCC03BC1E0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD95285CA1;
	Sun, 21 Sep 2025 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQz+m9SE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B6276030
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488065; cv=none; b=jjTL90bykfGXMcwOSLcNajKvVWcoTbfLKz+PSUe3gTLUZsS2OSvqwgRPpFp/D9ePnxjU0tU0J2lmvZdS7fcztyAAOxDVKHXInI1+CpF5/jUO6K3nRzeYV5ebQocTtHS8CS7SDssBBvOWa6YfKsLIWQmpkLk3VFApiT/XTbQiz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488065; c=relaxed/simple;
	bh=uW9UwUN7CZ4teKHcfAn18eLt3QqmBZWjrgXXTqGYGdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0v6dnhlPRJmeQDSCnZ4KVMU96lvaTb4LX/vkRj2TAAgHKkccdGYcdPvXbqIlIE1pPj7W0hdx3jFZ3gn4QaVzTn4U4qoHNV30DJSMSpoXO6UWb4zu+28+l49KIO3B3GUjbeosk3hQzJAqK3f9poam11bWXG4GRHJ04ZmLGh5Ovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQz+m9SE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xBq188AXBSuVVCyB2PFVSgR4xlxI1tenZeY+L8GcOIc=;
	b=aQz+m9SEh/mPHDgRnXLi60K9MsRCtayGGaOqsq5UzJopaq59+WgNYrIpCREXfOkzpSjW0t
	Gdj9Vbop8kdMty3lc3GTCyfC4EXZGnppfwAbufZppU5a5mRl2GM1h1T4uFijvFxor0jBag
	BVX0CzufejFbKHVr+0grS73Oh3nRp4Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-f2oHEPt8MomTMn43bakL0g-1; Sun, 21 Sep 2025 16:54:21 -0400
X-MC-Unique: f2oHEPt8MomTMn43bakL0g-1
X-Mimecast-MFC-AGG-ID: f2oHEPt8MomTMn43bakL0g_1758488060
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so1342459f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488060; x=1759092860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBq188AXBSuVVCyB2PFVSgR4xlxI1tenZeY+L8GcOIc=;
        b=I/od08r0ewzyfwnnE2tW9rP79DwdSDeNHi/udEk+0bqxgNWRYfc0kbhT97F1GIr97d
         IMI4ifJesaER67uft2TE9C/oy22D27TTt/m5RNSm0gv4hNJhQYrMXX7haAGTcUS30aik
         6ftoA+g91Vf+Y8Sz5ioD979vNymcLL0oDNITWdOOglZ++rxOFyHiigsiScl//62oV09m
         bSPpBL64+BBPYgeTUwY3W6Qxcmc6ud0d3pINOpwKYog/IFmgD5ZiTFSANtH2LUdjDkao
         iAOE93nWLDDny8O3OIAaTMyjA5CeSSTun4we00joN6J2DcMqkrLP15G2YjXm6uOzgjoD
         9Gfw==
X-Forwarded-Encrypted: i=1; AJvYcCXmEjjEjaBa3+gXtZAndiqRw4pzOq0R8cpoDaO0kyBej1t2t+2hV27QHus1+nUTkZGAmez+80n5R240jSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3x3N8fpprPjYVP/MP1FJXf9+o/TyeZlaxkY1CjyT45MP4RW8O
	IakmMqfMpsdEZ6dc5DdINtDSxdvaJv90/8FVGk903Q5YYJ/9oYJcaWSjcyjQi92SyvZm3686YDB
	XXu7WsbP7hc6ddMMx2VFofFPCxUtjIF7iSJFGKtUvQjIVvhP9MC2pfJb3iG42WI6dkA==
X-Gm-Gg: ASbGncsUtYG8xhrETCVwfeOrPATySG0xS3OYxpRkeLsvPgu2fLAsYGDNmT0Xh4CV5KE
	+MrT6dZ/4PS4Ln6f1ANe8ZGoLF8Z7HLteFkrCip9toGoKlHJbqbs+PykV0lWvL5BvZIbPd5SNfI
	EL2bleMU2SHKRR4aDwsN9D8sas1C5qc6q89XtJp3M9niq83yEHxq1ZCLuzhBeNIst74vqjwLsCp
	IcCqRPKBaDSHJ6IxMchl0l279QmBGXy3+h9CkQEOVuiCioMaCfob9OZJpkNxjwULJK9aN6im3ax
	8ETNBfwnRJNg1MDrDKW38RVPx54UifJrIsA=
X-Received: by 2002:a05:6000:144c:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ee7c5529e2mr9183490f8f.2.1758488060203;
        Sun, 21 Sep 2025 13:54:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVmqrSeyTyn+vNrblxaFs736hmj/tx3H63IBTr5ZBghyBT0dYb4dU98Nl7befn9KTzwvrdBg==
X-Received: by 2002:a05:6000:144c:b0:3ea:6680:8f97 with SMTP id ffacd0b85a97d-3ee7c5529e2mr9183484f8f.2.1758488059818;
        Sun, 21 Sep 2025 13:54:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7460sm17127896f8f.31.2025.09.21.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:54:19 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:54:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Message-ID: <20250921165408-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-6-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813054831.25865-6-jasowang@redhat.com>

On Wed, Aug 13, 2025 at 01:48:27PM +0800, Jason Wang wrote:
> Following patch will introduce virtio map opreations which means the

operations

> address is not necessarily used for DMA. Let's rename the dma_handle
> to map_handle first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fb1d407d5f1b..94b2a8f3acc2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
>  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>  
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> -			       dma_addr_t *dma_handle, gfp_t flag,
> +			       dma_addr_t *map_handle, gfp_t flag,
>  			       union vring_mapping_token *mapping_token)
>  {
>  	if (vring_use_map_api(vdev)) {
>  		return dma_alloc_coherent(mapping_token->dma_dev, size,
> -					  dma_handle, flag);
> +					  map_handle, flag);
>  	} else {
>  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
>  
>  		if (queue) {
>  			phys_addr_t phys_addr = virt_to_phys(queue);
> -			*dma_handle = (dma_addr_t)phys_addr;
> +			*map_handle = (dma_addr_t)phys_addr;
>  
>  			/*
>  			 * Sanity check: make sure we dind't truncate
> @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			 * warning and abort if we end up with an
>  			 * unrepresentable address.
>  			 */
> -			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> +			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
>  				free_pages_exact(queue, PAGE_ALIGN(size));
>  				return NULL;
>  			}
> @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  }
>  
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> -			     void *queue, dma_addr_t dma_handle,
> +			     void *queue, dma_addr_t map_handle,
>  			     union vring_mapping_token *mapping_token)
>  {
>  	if (vring_use_map_api(vdev))
> -		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
> +		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
>  	else
>  		free_pages_exact(queue, PAGE_ALIGN(size));
>  }
> -- 
> 2.31.1


