Return-Path: <linux-kernel+bounces-826375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FA4B8E5AF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37483189A22F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2E276030;
	Sun, 21 Sep 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uv2teLOv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D22765E8
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488124; cv=none; b=RFiOLZ+xcXq9SW2lBx5Hkvfv4RToh+CCtRlr/pmneR1ImcqugjPxjoCb+iqs52zjTKc5+xLKAqASA093HRqrfUAedgkgDBxh50Cc1++E8QaiSYif3RZJfA9ZoWj5fGpdSimoetHFBTFRl5Xf2fO8axw7Yf93y9Hl3DzTnyXjh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488124; c=relaxed/simple;
	bh=4AlSV5FNl3xfiiNGKpdZkWwOu7672nh7Ock1VENKALQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxbMJrcH6lxtZncutcpamYKGYDO1rEKt/nDW1xSn8K3gDpJnavZl1Of49VAAaS0cNAsSlNOeSbhN051Y7Y0PN6K+mY+ZxypZq/NwQC68mCKIy9cVUqQDFd0JF6v+/Ho9fRsTaS2LcZpMczgaHT+oPvgQQLBGBjCy0tSLCWygdKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uv2teLOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758488121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DGIv2+PY4/cKy7Q6ANJbQSVUVPSAlNn6jUMi82PwLeY=;
	b=Uv2teLOvBYVyNIc2HXc2T0LU43obywiJ7ByN2sJzE4tV26YS7hhGkPi+kaqvEeif4L6TJ7
	wQM2mRuEltoyN4CZjhpMijgv5mLctCsraxFdhfwmDqNTq84miVTxAq4LkOdTT1DcQ/JPXi
	9aGfixxU0oBAY0dlJOQYMTJv3dUWBps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-ny18jl3QMRK4Weg5nFyvGg-1; Sun, 21 Sep 2025 16:55:13 -0400
X-MC-Unique: ny18jl3QMRK4Weg5nFyvGg-1
X-Mimecast-MFC-AGG-ID: ny18jl3QMRK4Weg5nFyvGg_1758488111
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46c84b3b27bso4945855e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488111; x=1759092911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGIv2+PY4/cKy7Q6ANJbQSVUVPSAlNn6jUMi82PwLeY=;
        b=UQ9gwhYStt/F3hWQvpa+UQJtnuj6tHUx26ckQNwfDZwC1bJiYgxZygjhxOk7eHIhKj
         PH8wSkmWMN5pHh4aAy1+hdlN4sjxwfjhmQ/TqROvYgERExatHm9NuuGrseUEL67mV4V5
         Dc+Q0I/MXeh4GRzQcepDdcM4IZjngXdkfv8FkLAjmh+QMCHJu30Obm9lrZGGbHGx/BTl
         AblHozERlEGYnr3EmgWn7iDPURFOM+DQDC6DIc9oCpgK7H0jGNCDQzTeXjw6Gh+rtwJb
         Qj2A6NMdE5fR9NtNKF2lx9ln3VJTF88+BYQXnjiSgraHVyNhNSChKiy7tSUs3eBlk1nR
         nQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyn01PFSDwrsJWH9LOPnKoKPQOaagnpTXy1w0BD7/H9s9p6FX1xpwFKRrMJ32rSw2XeJot7GX3hINd+8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMgt8g1VGbgaxk/DFRYT/8IRBECcyT/DEFDiAAVoVN0BmAtww
	MpRIqoy738ywsEv4q661H9ZDOIt6K0sZUWf06146Ut4hB3lrl/C4aO19LCkKBH3O4xtiTgK8l0b
	0+5lk40e2uDtmsREEwqZsC9SKNpUO/ES8iLTq8tIcUh/cZiGCP3kzNqKMIr6bEM203w==
X-Gm-Gg: ASbGnctyjze4/V5plzQukmO0GC5V5Pz2jZboQnzizmt0IA/4ZUpQrgdj/Eu+YiC8WAD
	nHzLS4FzVwGzoO1yZycMe8FBZFH4kJydSfI7nnPMfkgeSSd1b9qgBTxoInPFRr/qctpTO9DdDQT
	xJxydJoeTsEUQ8EhdoY6fjpSV9hsSZtayDGtcdcoEVVd7wzNqa1uAd5MGmKlCNJkHUMCR6kRi/i
	6iQizc3BtyPiY+Oc5SWCBxUTsDtIfwFs4qO4U9bu1R5w7c3iLTf0o9xHoUenGdi38adX8NWplGT
	KrCDM3GYcad0sunmBkl6eFf4Z9LjnunpY6g=
X-Received: by 2002:a05:600c:4508:b0:468:7a59:ee81 with SMTP id 5b1f17b1804b1-46b01de9a99mr50993535e9.3.1758488111243;
        Sun, 21 Sep 2025 13:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKE7DuLxQdyt3pMfbq/WNgwaNZF/sLVjWIZtLz7RXB3J32i3EvEFA8ob+6ULnHSJU6WHgLMA==
X-Received: by 2002:a05:600c:4508:b0:468:7a59:ee81 with SMTP id 5b1f17b1804b1-46b01de9a99mr50993415e9.3.1758488110751;
        Sun, 21 Sep 2025 13:55:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f5a281f1sm173879565e9.17.2025.09.21.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 13:55:10 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:55:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250921165434-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813054831.25865-2-jasowang@redhat.com>

On Wed, Aug 13, 2025 at 01:48:23PM +0800, Jason Wang wrote:
> This patch consities virtqueue point for DMA helpers.

constifies the virtqueue pointer

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  include/linux/virtio.h       | 12 ++++++------
>  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f5062061c408..103bad8cffff 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
>   *
>   * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
>   */
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
>  					  size_t size,
>  					  enum dma_data_direction dir,
>  					  unsigned long attrs)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api) {
>  		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
> @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
>   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
>   *
>   */
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> +				      dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return;
> @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
>   *
>   * Returns 0 means dma valid. Other means invalid dma address.
>   */
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return 0;
> @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
>   *
>   * return bool
>   */
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (!vq->use_dma_api)
>  		return false;
> @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
>   * the DMA address really needs to be synchronized
>   *
>   */
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
>  					     dma_addr_t addr,
>  					     unsigned long offset, size_t size,
>  					     enum dma_data_direction dir)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct device *dev = vring_dma_dev(vq);
>  
>  	if (!vq->use_dma_api)
> @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
>   * Before calling this function, use virtqueue_dma_need_sync() to confirm that
>   * the DMA address really needs to be synchronized
>   */
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
>  						dma_addr_t addr,
>  						unsigned long offset, size_t size,
>  						enum dma_data_direction dir)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct device *dev = vring_dma_dev(vq);
>  
>  	if (!vq->use_dma_api)
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 8b745ce0cf5f..cf8def717dfd 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  	module_driver(__virtio_driver, register_virtio_driver, \
>  			unregister_virtio_driver)
>  
> -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
> +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
>  					  enum dma_data_direction dir, unsigned long attrs);
> -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
>  				      size_t size, enum dma_data_direction dir,
>  				      unsigned long attrs);
> -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
>  
> -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
> +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
>  					     unsigned long offset, size_t size,
>  					     enum dma_data_direction dir);
> -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
>  						unsigned long offset, size_t size,
>  						enum dma_data_direction dir);
>  
> -- 
> 2.31.1


