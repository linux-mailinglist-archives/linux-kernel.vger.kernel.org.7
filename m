Return-Path: <linux-kernel+bounces-826399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB8B8E6B5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C9C166A39
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6712C2349;
	Sun, 21 Sep 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdkxZB7V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091741798F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490924; cv=none; b=m5E3T0J9J8H93Yc+/YkkmBJphFIBMFS/JXq/nnPLncmDQSrEKd0Iy8ja3PZBrzFoGt5a6hwt0VHi5xZzD5i3Aa06QFFyBJTUiKu0DnmVsfFtfKS/sEXM8Ew2jrO/tHUiq5oflZ9mJ22T8zEYL9+p5Rc8JHL2BKOc9xrnJX2bwxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490924; c=relaxed/simple;
	bh=NsJb4st6T99WMlBu/ChJ8MnGDssz57Eubv5GG90Wdek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOGRCOGYxENJwpuqMR/k4trUw1FS5IHQCbxVcrwB0oy8qtEg1iT3zZrR8tX5pO+v1d2zv6u4tqHCPHe8voCFLHLud6m664WwIQIaL7dYYIxfBp3aFrdwK70c6r+Nm4GWLjW5JgKJrkxGsCku6fr/bkGfcyRCWPNf5PmNS9/7OgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdkxZB7V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IXbaHpfhyIqU48t3D/0byoBr9VRqYAJB99Dj7IEd2W0=;
	b=QdkxZB7V8ReHxNV4RRpYIAi5jcqgOAguX/aPCG1DOfRxLKAkIuIuMkeprx/DRgL/1HKUkr
	UTMi53rcgb9TyNjz7ID3BaMNJHFw7QJsOEoJhUyvE5o9fz4z1BfWWTgZzgUVm6Sj+b2JJ/
	ZY422N8mb6FqE418VAm60xEeaPbi8QU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-QU_FyNNqM8ac_MGGEe63Og-1; Sun, 21 Sep 2025 17:41:59 -0400
X-MC-Unique: QU_FyNNqM8ac_MGGEe63Og-1
X-Mimecast-MFC-AGG-ID: QU_FyNNqM8ac_MGGEe63Og_1758490919
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46c84b3b27bso5052215e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490919; x=1759095719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXbaHpfhyIqU48t3D/0byoBr9VRqYAJB99Dj7IEd2W0=;
        b=hJ/3HEdkibHOeAyDLnKHd0rldrqlUPtDA0dDpOWU/xZ998sDdcmfsUt5VG+6w6u+Fv
         9ShMw/Rho0+Xv02GQQkL1LxVENsgboLKhrYFP0O9WPnxxwjDcFX49I+YwPtOJYrfb3gR
         sir86BqfbeZoE2NQLvp4h2qrIX/wsGsiOLZJNKGldsKwfXVGSLfvUALJe9bqtcjQ6/ca
         iwC9gRBy/X3whQ6THbDO8uGaOlEEvtWwIt0jWpmNBHxEcyRrRsMRJlnX9/fVvLGbMzxk
         6AG97Sskq1bK7SKe5xqDQZC4pl+JQu9xrJ77/PkWRma4BSbM33pA6oBeeuxoubXbEZtr
         v2+A==
X-Forwarded-Encrypted: i=1; AJvYcCUPHhDZpwVLGDbtYHfpQr5fi/YZCH2z/1H54yxiODKHAL1UxWZzehqFzxWZf5dWRSkBI1eyU2PigzD30Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU61xqmfZW6ZQEe63dwGvWIrwYlVlsLASyk+DSnIyWiE8Al7w3
	QbYOnnj40a76SOn+qeOllBn+Fs2K8Ln3sLNa/yr3pzvakOyJvhnv4qTOH1fMAoY5gG7RYKTXmx6
	ubk9EJj1JImDZz2cqwfG5jsVbTHUtbbtgnr1C5c9u7oeEB6EXZAfXLdvgFpgx3+YI+Q==
X-Gm-Gg: ASbGncuhhyVqoU96PB/8uXa8j6bZzHx0Kbqi7fND72lpNrk0KYfeUQPgF0+I4jaSy9m
	015QHH+vYUkGE6Mcj1DxgPQuGxQTuISM1tpLN07s0ZWMyk3LUYV7z7x8KQIUiDEM8AzROHnQc4u
	WLn3J+z6z0/ADilKo14/UizM8EDY/2ixgKfhlZJ1iVFxEBfhQLg2JH6HTfWBLe4ljJWr0wrn5e0
	FFLfgXADA2DvmsJ0OJ3ty48whlZ+pBUfT02xRvfLGIl+v5vy16+1+WnzehSUfDrk7EM9jdCkKyN
	jVuu2x8TQiexP9of+j+KxyqmG1RuyVbiiv0=
X-Received: by 2002:a05:600c:3593:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-467eed8f53amr130731625e9.10.1758490918673;
        Sun, 21 Sep 2025 14:41:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP8mWhdXShjZD0e5Xi7FTGL9vfgfRfQHQVeAIFxmMdoNRpcK/uKJpXqqR5BGPpb4ADjBQBLA==
X-Received: by 2002:a05:600c:3593:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-467eed8f53amr130731455e9.10.1758490918213;
        Sun, 21 Sep 2025 14:41:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07412111sm16881566f8f.28.2025.09.21.14.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:41:57 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:41:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Message-ID: <20250921174143-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-6-jasowang@redhat.com>
 <20250921165408-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165408-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:54:19PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 13, 2025 at 01:48:27PM +0800, Jason Wang wrote:
> > Following patch will introduce virtio map opreations which means the
> 
> operations

note that i fixed it for now

> > address is not necessarily used for DMA. Let's rename the dma_handle
> > to map_handle first.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index fb1d407d5f1b..94b2a8f3acc2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
> >  EXPORT_SYMBOL_GPL(virtio_max_dma_size);
> >  
> >  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> > -			       dma_addr_t *dma_handle, gfp_t flag,
> > +			       dma_addr_t *map_handle, gfp_t flag,
> >  			       union vring_mapping_token *mapping_token)
> >  {
> >  	if (vring_use_map_api(vdev)) {
> >  		return dma_alloc_coherent(mapping_token->dma_dev, size,
> > -					  dma_handle, flag);
> > +					  map_handle, flag);
> >  	} else {
> >  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> >  
> >  		if (queue) {
> >  			phys_addr_t phys_addr = virt_to_phys(queue);
> > -			*dma_handle = (dma_addr_t)phys_addr;
> > +			*map_handle = (dma_addr_t)phys_addr;
> >  
> >  			/*
> >  			 * Sanity check: make sure we dind't truncate
> > @@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> >  			 * warning and abort if we end up with an
> >  			 * unrepresentable address.
> >  			 */
> > -			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
> > +			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
> >  				free_pages_exact(queue, PAGE_ALIGN(size));
> >  				return NULL;
> >  			}
> > @@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
> >  }
> >  
> >  static void vring_free_queue(struct virtio_device *vdev, size_t size,
> > -			     void *queue, dma_addr_t dma_handle,
> > +			     void *queue, dma_addr_t map_handle,
> >  			     union vring_mapping_token *mapping_token)
> >  {
> >  	if (vring_use_map_api(vdev))
> > -		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
> > +		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
> >  	else
> >  		free_pages_exact(queue, PAGE_ALIGN(size));
> >  }
> > -- 
> > 2.31.1


