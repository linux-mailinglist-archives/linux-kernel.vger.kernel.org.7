Return-Path: <linux-kernel+bounces-766297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A4B244C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868E07B5608
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF21F2ED15C;
	Wed, 13 Aug 2025 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4dzNawR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3312D63FA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075317; cv=none; b=PlcTMs1EuXJoWUVH5PM9AbFwlb3X0VAoLHI9Px57C0bVePGK8CL2FlDZxNkUIc+DWPPXYI9am//nYE3pY9gIs/Ppc0R8059DxSkmnjzd6s0lney/kQPJjZh0jPl134Gu3GjItYtTmGH21SPpKtrZRDQlqc9G5ty4CqxOhQVEDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075317; c=relaxed/simple;
	bh=nCB+kooX9cTXuIyYi3rGv8iieaD08LtUsDnneagtb6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNbCWae4lUOyZM/z0StGB6OX88JRxL5Zp3pL3tjKWqmPz6cMiKD1RA61mQclI8qM8w2pkQSeYiNzWXE+W/BBQkw79sXXWsZDg/6ToNfwjm+rPwQ+zAe0ke/d/0g7wtlL1jHaY0IbU0RBOFzC/Gq5YDu1E/+YoOxaIAWQjAthlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4dzNawR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755075314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qnUdXYf7scv1gNIJH3rL97NQe3g81AJY/l29fUd9ybE=;
	b=c4dzNawRZWs9+NAiXcmNg0CUe734lJvg4CviRCOfff6AqCi0ZIcew7NMxxUr3CM+SECFNY
	dRjMbGToLB3wtiCXxHzFPjxYQT+mzElt4+f3pkbjA+4ZwpiQVJSNA92FgRoh7HVBxXkvEq
	nUoUo3E/SdGL9+4/rsix7+ymCP7XSnk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-yEsqSwstMEO5RTGgl4RQCQ-1; Wed, 13 Aug 2025 04:55:12 -0400
X-MC-Unique: yEsqSwstMEO5RTGgl4RQCQ-1
X-Mimecast-MFC-AGG-ID: yEsqSwstMEO5RTGgl4RQCQ_1755075312
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a15f10f31so3643165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755075311; x=1755680111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnUdXYf7scv1gNIJH3rL97NQe3g81AJY/l29fUd9ybE=;
        b=nu0DPWzJDu7uLKJuYMGVehD4p+pOI6WvZvnO0K4wsKSu8VakJZIBCOjTyBdsuL1OMf
         niZEzR8HBUUdhrF7Gx9cple+7zWGiNR2KnOpaoO9N6dYuH+rki56DBhzWB9le+tyRm2h
         1fb09pq9kcMS7DH49H6INkrFqo7pO0J4qnyvoBz5bRa9vl14wTiNxexyK/mXHZKkk1Mq
         CTjPcCwlv5OZK+7S+6iX0eSGztN3A5/y987eO8qGoOxrN3NfTR8JpbZpgoJAXZPJvMl1
         xLu/N8AhnQdG9DAGBGk+1Ly0GpfcEW2MWXuXuzxj9/RgbiTWEohH5+PFCPAsPZgB6MU2
         ijTw==
X-Forwarded-Encrypted: i=1; AJvYcCUI9BWtnxlp07sqp4egcDERcYXnYxHh7xosBF6Dd32YCaOcd6kZkutd+DUBSSG21lQ85dolNqsIjCETLmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMqlgkdE04Jil1PY2l4a5XBou/wqqDUC9Dla3AH+pM2MHrJbP
	x/CXNtWBfuV7JuXn6bgb0+JZCnACptF1NZ9u4di/wlSzFd9MChUtMp3R6SoQtKWEw9iqhiYC1XN
	tgzmdr8zNNAglIv9gASi03JOMp643vuehlxFMrjOOrrGtFsd4uKDN22g2TBu708ggjwc7hjV85A
	==
X-Gm-Gg: ASbGncsbCwaHwYAO2gspb3MtffqusGMPATUzs95mdPH7MSCi2AjoA4FwoqZNGhnZ5cb
	HQ5IFNMtFujik0zgbX37hvDaY208i9VUfs4O7xYn2UZ9XXZ+au9LT6TC0PiTNoaclyAMXuTnUP9
	+5OwVd5ybiyujcKBFKIG+x36Y6EqurR8rIZ/zZ0N0387lVqON0LoP6I4UOQwUTnxzhaLSbAkwwf
	RlrvEUotoQhmg04QttOMQjcwHbrMtOkMTv+Wgt0G4BI3KGpIFsT2Up7icTFuAqPh2snS9wUE9Jo
	6vNvqcp3gboNdMw47w1o24J0rzuW/h+D
X-Received: by 2002:a05:600c:8286:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-45a1701982dmr13034645e9.7.1755075311196;
        Wed, 13 Aug 2025 01:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf7Yff0e0aO1kt2/kQ0qNWE22U6+MfVe0fugCbOj2LgWqlpG9btxUyQFeRTqdS9RvG5ZpuyA==
X-Received: by 2002:a05:600c:8286:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-45a1701982dmr13034305e9.7.1755075310592;
        Wed, 13 Aug 2025 01:55:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16de760fsm21017025e9.17.2025.08.13.01.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:55:09 -0700 (PDT)
Date: Wed, 13 Aug 2025 04:55:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org
Subject: Re: [PATCH V5 4/9] virtio: introduce vring_mapping_token
Message-ID: <20250813043151-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-5-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813054831.25865-5-jasowang@redhat.com>

On Wed, Aug 13, 2025 at 01:48:26PM +0800, Jason Wang wrote:
> Following patch will introduce the mapping operations for virtio
> device. In order to achieve this, besides the dma device, virtio core
> needs to support a transport or device specific mapping token as well.
> So this patch introduces a union container of a dma device and opaque
> mapping token. The idea is the allow the transport layer to pass
> device specific mapping token which will be used as a parameter for
> the virtio mapping operations. For the transport or device that is
> using DMA, dma device is still being used.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 110 ++++++++++++++++++-----------------
>  drivers/virtio/virtio_vdpa.c |   6 +-
>  include/linux/virtio.h       |   7 +++
>  include/linux/virtio_ring.h  |   7 ++-
>  4 files changed, 72 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 482a268af851..fb1d407d5f1b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -210,8 +210,7 @@ struct vring_virtqueue {
>  	/* DMA, allocation, and size information */
>  	bool we_own_ring;
>  
> -	/* Device used for doing DMA */
> -	struct device *dma_dev;
> +	union vring_mapping_token mapping_token;
>  
>  #ifdef DEBUG
>  	/* They're supposed to lock for us. */
> @@ -307,10 +306,10 @@ EXPORT_SYMBOL_GPL(virtio_max_dma_size);
>  
>  static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  			       dma_addr_t *dma_handle, gfp_t flag,
> -			       struct device *dma_dev)
> +			       union vring_mapping_token *mapping_token)

Why are you passing it by pointer? It's just an 8 bit value, pass it
as is.


>  {
>  	if (vring_use_map_api(vdev)) {
> -		return dma_alloc_coherent(dma_dev, size,
> +		return dma_alloc_coherent(mapping_token->dma_dev, size,
>  					  dma_handle, flag);
>  	} else {
>  		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
> @@ -341,22 +340,22 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
>  
>  static void vring_free_queue(struct virtio_device *vdev, size_t size,
>  			     void *queue, dma_addr_t dma_handle,
> -			     struct device *dma_dev)
> +			     union vring_mapping_token *mapping_token)
>  {
>  	if (vring_use_map_api(vdev))
> -		dma_free_coherent(dma_dev, size, queue, dma_handle);
> +		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
>  	else
>  		free_pages_exact(queue, PAGE_ALIGN(size));
>  }
>  
>  /*
> - * The DMA ops on various arches are rather gnarly right now, and
> - * making all of the arch DMA ops work on the vring device itself
> + * The map ops on various arches are rather gnarly right now, and


how does this make sense?

> + * making all of the arch map ops work on the vring device itself
>   * is a mess.
>   */
>  static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
>  {
> -	return vq->dma_dev;
> +	return vq->mapping_token.dma_dev;
>  }
>  
>  /* Map one sg entry. */
> @@ -1056,12 +1055,13 @@ static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_spl
>  }
>  
>  static void vring_free_split(struct vring_virtqueue_split *vring_split,
> -			     struct virtio_device *vdev, struct device *dma_dev)
> +			     struct virtio_device *vdev,
> +			     union vring_mapping_token *mapping_token)
>  {
>  	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
>  			 vring_split->vring.desc,
>  			 vring_split->queue_dma_addr,
> -			 dma_dev);
> +			 mapping_token);
>  
>  	kfree(vring_split->desc_state);
>  	kfree(vring_split->desc_extra);
> @@ -1072,7 +1072,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  				   u32 num,
>  				   unsigned int vring_align,
>  				   bool may_reduce_num,
> -				   struct device *dma_dev)
> +				   union vring_mapping_token *mapping_token)
>  {
>  	void *queue = NULL;
>  	dma_addr_t dma_addr;
> @@ -1088,7 +1088,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
>  					  &dma_addr,
>  					  GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> -					  dma_dev);
> +					  mapping_token);
>  		if (queue)
>  			break;
>  		if (!may_reduce_num)
> @@ -1102,7 +1102,7 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  		/* Try to get a single page. You are my only hope! */
>  		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
>  					  &dma_addr, GFP_KERNEL | __GFP_ZERO,
> -					  dma_dev);
> +					  mapping_token);
>  	}
>  	if (!queue)
>  		return -ENOMEM;
> @@ -1126,7 +1126,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       bool (*notify)(struct virtqueue *),
>  					       void (*callback)(struct virtqueue *),
>  					       const char *name,
> -					       struct device *dma_dev)
> +					       union vring_mapping_token *mapping_token)
>  {
>  	struct vring_virtqueue *vq;
>  	int err;
> @@ -1149,7 +1149,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  #else
>  	vq->broken = false;
>  #endif
> -	vq->dma_dev = dma_dev;
> +	vq->mapping_token = *mapping_token;
>  	vq->use_map_api = vring_use_map_api(vdev);
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> @@ -1187,21 +1187,21 @@ static struct virtqueue *vring_create_virtqueue_split(
>  	bool (*notify)(struct virtqueue *),
>  	void (*callback)(struct virtqueue *),
>  	const char *name,
> -	struct device *dma_dev)
> +	union vring_mapping_token *mapping_token)
>  {
>  	struct vring_virtqueue_split vring_split = {};
>  	struct virtqueue *vq;
>  	int err;
>  
>  	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
> -				      may_reduce_num, dma_dev);
> +				      may_reduce_num, mapping_token);
>  	if (err)
>  		return NULL;
>  
>  	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> -				   context, notify, callback, name, dma_dev);
> +				   context, notify, callback, name, mapping_token);
>  	if (!vq) {
> -		vring_free_split(&vring_split, vdev, dma_dev);
> +		vring_free_split(&vring_split, vdev, mapping_token);
>  		return NULL;
>  	}
>  
> @@ -1220,7 +1220,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  	err = vring_alloc_queue_split(&vring_split, vdev, num,
>  				      vq->split.vring_align,
>  				      vq->split.may_reduce_num,
> -				      vring_dma_dev(vq));
> +				      &vq->mapping_token);
>  	if (err)
>  		goto err;
>  
> @@ -1238,7 +1238,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>  	return 0;
>  
>  err_state_extra:
> -	vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
> +	vring_free_split(&vring_split, vdev, &vq->mapping_token);
>  err:
>  	virtqueue_reinit_split(vq);
>  	return -ENOMEM;
> @@ -1947,25 +1947,25 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
>  
>  static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
>  			      struct virtio_device *vdev,
> -			      struct device *dma_dev)
> +			      union vring_mapping_token *mapping_token)
>  {
>  	if (vring_packed->vring.desc)
>  		vring_free_queue(vdev, vring_packed->ring_size_in_bytes,
>  				 vring_packed->vring.desc,
>  				 vring_packed->ring_dma_addr,
> -				 dma_dev);
> +				 mapping_token);
>  
>  	if (vring_packed->vring.driver)
>  		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
>  				 vring_packed->vring.driver,
>  				 vring_packed->driver_event_dma_addr,
> -				 dma_dev);
> +				 mapping_token);
>  
>  	if (vring_packed->vring.device)
>  		vring_free_queue(vdev, vring_packed->event_size_in_bytes,
>  				 vring_packed->vring.device,
>  				 vring_packed->device_event_dma_addr,
> -				 dma_dev);
> +				 mapping_token);
>  
>  	kfree(vring_packed->desc_state);
>  	kfree(vring_packed->desc_extra);
> @@ -1973,7 +1973,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
>  
>  static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  				    struct virtio_device *vdev,
> -				    u32 num, struct device *dma_dev)
> +				    u32 num, union vring_mapping_token *mapping_token)
>  {
>  	struct vring_packed_desc *ring;
>  	struct vring_packed_desc_event *driver, *device;
> @@ -1985,7 +1985,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
>  				 &ring_dma_addr,
>  				 GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> -				 dma_dev);
> +				 mapping_token);
>  	if (!ring)
>  		goto err;
>  
> @@ -1998,7 +1998,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  	driver = vring_alloc_queue(vdev, event_size_in_bytes,
>  				   &driver_event_dma_addr,
>  				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> -				   dma_dev);
> +				   mapping_token);
>  	if (!driver)
>  		goto err;
>  
> @@ -2009,7 +2009,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  	device = vring_alloc_queue(vdev, event_size_in_bytes,
>  				   &device_event_dma_addr,
>  				   GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO,
> -				   dma_dev);
> +				   mapping_token);
>  	if (!device)
>  		goto err;
>  
> @@ -2021,7 +2021,7 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  	return 0;
>  
>  err:
> -	vring_free_packed(vring_packed, vdev, dma_dev);
> +	vring_free_packed(vring_packed, vdev, mapping_token);
>  	return -ENOMEM;
>  }
>  
> @@ -2097,7 +2097,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  					       bool (*notify)(struct virtqueue *),
>  					       void (*callback)(struct virtqueue *),
>  					       const char *name,
> -					       struct device *dma_dev)
> +					       union vring_mapping_token *mapping_token)
>  {
>  	struct vring_virtqueue *vq;
>  	int err;
> @@ -2120,7 +2120,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>  	vq->broken = false;
>  #endif
>  	vq->packed_ring = true;
> -	vq->dma_dev = dma_dev;
> +	vq->mapping_token = *mapping_token;
>  	vq->use_map_api = vring_use_map_api(vdev);
>  
>  	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> @@ -2158,18 +2158,18 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	bool (*notify)(struct virtqueue *),
>  	void (*callback)(struct virtqueue *),
>  	const char *name,
> -	struct device *dma_dev)
> +	union vring_mapping_token *mapping_token)
>  {
>  	struct vring_virtqueue_packed vring_packed = {};
>  	struct virtqueue *vq;
>  
> -	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
> +	if (vring_alloc_queue_packed(&vring_packed, vdev, num, mapping_token))
>  		return NULL;
>  
>  	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
> -					context, notify, callback, name, dma_dev);
> +					context, notify, callback, name, mapping_token);
>  	if (!vq) {
> -		vring_free_packed(&vring_packed, vdev, dma_dev);
> +		vring_free_packed(&vring_packed, vdev, mapping_token);
>  		return NULL;
>  	}
>  
> @@ -2185,7 +2185,8 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>  	struct virtio_device *vdev = _vq->vdev;
>  	int err;
>  
> -	if (vring_alloc_queue_packed(&vring_packed, vdev, num, vring_dma_dev(vq)))
> +	if (vring_alloc_queue_packed(&vring_packed, vdev,
> +				     num, &vq->mapping_token))
>  		goto err_ring;
>  
>  	err = vring_alloc_state_extra_packed(&vring_packed);
> @@ -2202,7 +2203,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>  	return 0;
>  
>  err_state_extra:
> -	vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
> +	vring_free_packed(&vring_packed, vdev, &vq->mapping_token);
>  err_ring:
>  	virtqueue_reinit_packed(vq);
>  	return -ENOMEM;
> @@ -2423,6 +2424,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
>  
> +
>  /**
>   * virtqueue_dma_dev - get the dma dev
>   * @_vq: the struct virtqueue we're talking about.


and this?

> @@ -2434,7 +2436,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  	if (vq->use_map_api)
> -		return vring_dma_dev(vq);
> +		return vq->mapping_token.dma_dev;
>  	else
>  		return NULL;
>  }
> @@ -2719,19 +2721,20 @@ struct virtqueue *vring_create_virtqueue(
>  	void (*callback)(struct virtqueue *),
>  	const char *name)
>  {
> +	union vring_mapping_token mapping_token = {.dma_dev = vdev->dev.parent};
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>  		return vring_create_virtqueue_packed(index, num, vring_align,
>  				vdev, weak_barriers, may_reduce_num,
> -				context, notify, callback, name, vdev->dev.parent);
> +				context, notify, callback, name, &mapping_token);
>  
>  	return vring_create_virtqueue_split(index, num, vring_align,
>  			vdev, weak_barriers, may_reduce_num,
> -			context, notify, callback, name, vdev->dev.parent);
> +			context, notify, callback, name, &mapping_token);
>  }
>  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
>  
> -struct virtqueue *vring_create_virtqueue_dma(
> +struct virtqueue *vring_create_virtqueue_map(
>  	unsigned int index,
>  	unsigned int num,
>  	unsigned int vring_align,
> @@ -2742,19 +2745,19 @@ struct virtqueue *vring_create_virtqueue_dma(
>  	bool (*notify)(struct virtqueue *),
>  	void (*callback)(struct virtqueue *),
>  	const char *name,
> -	struct device *dma_dev)
> +	union vring_mapping_token *mapping_token)
>  {
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>  		return vring_create_virtqueue_packed(index, num, vring_align,
>  				vdev, weak_barriers, may_reduce_num,
> -				context, notify, callback, name, dma_dev);
> +				context, notify, callback, name, mapping_token);
>  
>  	return vring_create_virtqueue_split(index, num, vring_align,
>  			vdev, weak_barriers, may_reduce_num,
> -			context, notify, callback, name, dma_dev);
> +			context, notify, callback, name, mapping_token);
>  }
> -EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
> +EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
>  
>  /**
>   * virtqueue_resize - resize the vring of vq
> @@ -2865,6 +2868,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      const char *name)
>  {
>  	struct vring_virtqueue_split vring_split = {};
> +	union vring_mapping_token mapping_token = {.dma_dev = vdev->dev.parent};
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>  		struct vring_virtqueue_packed vring_packed = {};
> @@ -2874,13 +2878,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  		return __vring_new_virtqueue_packed(index, &vring_packed,
>  						    vdev, weak_barriers,
>  						    context, notify, callback,
> -						    name, vdev->dev.parent);
> +						    name, &mapping_token);
>  	}
>  
>  	vring_init(&vring_split.vring, num, pages, vring_align);
>  	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				     context, notify, callback, name,
> -				     vdev->dev.parent);
> +				     &mapping_token);
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>  
> @@ -2894,19 +2898,19 @@ static void vring_free(struct virtqueue *_vq)
>  					 vq->packed.ring_size_in_bytes,
>  					 vq->packed.vring.desc,
>  					 vq->packed.ring_dma_addr,
> -					 vring_dma_dev(vq));
> +					 &vq->mapping_token);
>  
>  			vring_free_queue(vq->vq.vdev,
>  					 vq->packed.event_size_in_bytes,
>  					 vq->packed.vring.driver,
>  					 vq->packed.driver_event_dma_addr,
> -					 vring_dma_dev(vq));
> +					 &vq->mapping_token);
>  
>  			vring_free_queue(vq->vq.vdev,
>  					 vq->packed.event_size_in_bytes,
>  					 vq->packed.vring.device,
>  					 vq->packed.device_event_dma_addr,
> -					 vring_dma_dev(vq));
> +					 &vq->mapping_token);
>  
>  			kfree(vq->packed.desc_state);
>  			kfree(vq->packed.desc_extra);
> @@ -2915,7 +2919,7 @@ static void vring_free(struct virtqueue *_vq)
>  					 vq->split.queue_size_in_bytes,
>  					 vq->split.vring.desc,
>  					 vq->split.queue_dma_addr,
> -					 vring_dma_dev(vq));
> +					 &vq->mapping_token);
>  		}
>  	}
>  	if (!vq->packed_ring) {
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e25610e3393a..acea98ab08ee 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -139,6 +139,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	struct vdpa_callback cb;
>  	struct virtqueue *vq;
>  	u64 desc_addr, driver_addr, device_addr;
> +	union vring_mapping_token mapping_token = {0};
>  	/* Assume split virtqueue, switch to packed if necessary */
>  	struct vdpa_vq_state state = {0};
>  	u32 align, max_num, min_num = 1;
> @@ -185,9 +186,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  		dma_dev = ops->get_vq_dma_dev(vdpa, index);
>  	else
>  		dma_dev = vdpa_get_dma_dev(vdpa);
> -	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
> +	mapping_token.dma_dev = dma_dev;
> +	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
>  					true, may_reduce_num, ctx,
> -					notify, callback, name, dma_dev);
> +					notify, callback, name, &mapping_token);
>  	if (!vq) {
>  		err = -ENOMEM;
>  		goto error_new_virtqueue;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index addbc209275a..37029df94aaf 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -40,6 +40,13 @@ struct virtqueue {
>  	void *priv;
>  };
>  
> +union vring_mapping_token {
> +	/* Device that performs DMA */
> +	struct device *dma_dev;
> +	/* Transport specific token used for doing map */
> +	void *opaque;

Please just declare whatever structure you want it to be.

> +};
> +
>  int virtqueue_add_outbuf(struct virtqueue *vq,
>  			 struct scatterlist sg[], unsigned int num,
>  			 void *data,
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index 9b33df741b63..fd997178da2a 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_RING_H
>  
>  #include <asm/barrier.h>
> +#include <linux/virtio.h>
>  #include <linux/irqreturn.h>
>  #include <uapi/linux/virtio_ring.h>
>  
> @@ -79,9 +80,9 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
>  
>  /*
>   * Creates a virtqueue and allocates the descriptor ring with per
> - * virtqueue DMA device.
> + * virtqueue mapping operations.
>   */
> -struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
> +struct virtqueue *vring_create_virtqueue_map(unsigned int index,
>  					     unsigned int num,
>  					     unsigned int vring_align,
>  					     struct virtio_device *vdev,
> @@ -91,7 +92,7 @@ struct virtqueue *vring_create_virtqueue_dma(unsigned int index,
>  					     bool (*notify)(struct virtqueue *vq),
>  					     void (*callback)(struct virtqueue *vq),
>  					     const char *name,
> -					     struct device *dma_dev);
> +					     union vring_mapping_token *mapping_token);
>  
>  /*
>   * Creates a virtqueue with a standard layout but a caller-allocated
> -- 
> 2.31.1


