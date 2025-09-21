Return-Path: <linux-kernel+bounces-826400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB4B8E6B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B002E165337
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31A62C11FC;
	Sun, 21 Sep 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXxE+NPh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231772BE7B2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490939; cv=none; b=M0E2Fw9FDlhOJspqcet4372mEonUokGeSdTR7syoNCpnFF1m1n0xgWpaPNusJPWXBIlF7rIR34LhRq/HK7TSVaCKB8nYdf3QMXJAn1/Jf+yWODuP2jeyFaT1GsRbt/Jeo1PpDvOJqClX1XviQlhcQ+bDACOFNYx9YrLUauC6Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490939; c=relaxed/simple;
	bh=aHOEkzJA7O99geYKwgD7vfUEqI5TGA6J+xW3/dqC7jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX7TI1RfuuQ+cURa9V7LQH7L+HUkooAJSzA9UsOsjJ8TMh5lrIBSiF8Ftu1g4HBHuKBZM9D2RenmyexFYVbJKZZoKbISih9W7SIF4hss7RQPh2X6pid6etUoUy1+7Bu6tRZVebPvDWiBYrZU1M1na3e4yH0xc5NELw8v7APvY14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXxE+NPh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tA2L9oyJbyVq83RbEtZfV+vSBPTFArfNal5zWUCe3Zg=;
	b=DXxE+NPhwRsg3GNNTAkroOE/w3L3yyCSphOQFlOWOG30wRoVWPw2Xpn4Ml+6QfZ8v8Z2uU
	YovrX1u+00Q66Nwb3Uj5mYUvBfIy/GQ02l2fC0x8nplCK7ACiFMq63XSl1Vc40N3UAWd9l
	YpfgiAisiZu8m2o5q/b1AnhPGRpEoYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-V5LEqN4sNIC5mdmLEb1AGw-1; Sun, 21 Sep 2025 17:42:15 -0400
X-MC-Unique: V5LEqN4sNIC5mdmLEb1AGw-1
X-Mimecast-MFC-AGG-ID: V5LEqN4sNIC5mdmLEb1AGw_1758490934
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3fba0d9eb87so156873f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490934; x=1759095734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA2L9oyJbyVq83RbEtZfV+vSBPTFArfNal5zWUCe3Zg=;
        b=SCxJNm38oaAoEsWYtKcJdtOLzX/TUUX/zu/bWlJz3Tzkoy3/QgckgDE6XbZCe5Bm7Z
         bbXmLgrL1O+tDM10J/twet50FG07l8/6hNoUZOrukmlWTBSkNdmRV9X52pvjoOVH36aE
         0gPxVvN6rGLMgY9u1Wd/JoFVzCFim54a0dnmZMOkUgBuuI6gMoZa19GPHhsEJYBhJ+SS
         2pmS/wIJCT2Cb5GY6KrRbOJu/JM8mtPjGOlxt+l+wfhFM9v0k4oXH27F9/mz9eDLvX9w
         B2E2j6oQSWelRgEllk1YDBo4YD7ArwdbeInWMLhkSTaPXoX1ePNy5UmseoCmbHtvXLK8
         SZPA==
X-Forwarded-Encrypted: i=1; AJvYcCWM3uvAipHpw+uVmVl5Iv6LtkD/oStTGUSzuO0eOxZxT30jdveHG29kFWDRTLEU/R1thKd+xdtDoX3N3MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfroj/E94TBG5T90IvGc8xGOAk8Hj0+dHfICgemBt5kOWZDt4k
	Sd8zeZnxK1sCe02XGbSZHSUSoZz6nUVjlb5PqA/qA95rxw4wqiqbS6Fod51xYB15C0RqSwNQTky
	oN3E7VF+zKCag0SiYvtu0X92B+AIfV3wrD8jRl1zxHA5aH7uLQRMAzqA2tLO2n/IuMA==
X-Gm-Gg: ASbGncssLrLIvFtU8hwBCr8d3SnpdwY5Y2nYjkH+7qZ0yC7Q/h2LqHwR/I4YE+ZwQqS
	GEfc8Cs/JxNrW8nMRz4egEG88Cqpft/uZx+tjNVXQI1aakesw9eWUCSo7JfKf5z/8Zo7hDv3mX8
	/zHOaIYrTWfp079oUyIGRO6YY/rRRKMoFmv4gY/9k+jEpXKx47EFIJXdUEKtLXWUIJdYsyw/Cef
	SDPHsYcpgitIoRaXNpC03bgY08Jb61QPc0FkBOKqCZqTkKxhtxLD7VZN31dF5YoR3ITHi2R33ui
	+XK0wiEyoBedbhn2HNhDIzOE5eZ3f+sOOs8=
X-Received: by 2002:a05:6000:186f:b0:3e5:6dbd:2114 with SMTP id ffacd0b85a97d-3ee875101c4mr9729689f8f.59.1758490934380;
        Sun, 21 Sep 2025 14:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOf6Xd/ib6Qk5AuxiP/gcSHWrjecYFCzIwGgc4RUQ/GENU+tpLMM4iOB1+zibgYBEvPDrkSw==
X-Received: by 2002:a05:6000:186f:b0:3e5:6dbd:2114 with SMTP id ffacd0b85a97d-3ee875101c4mr9729679f8f.59.1758490933990;
        Sun, 21 Sep 2025 14:42:13 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm17183107f8f.3.2025.09.21.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:42:13 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:42:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V5 1/9] virtio_ring: constify virtqueue pointer for DMA
 helpers
Message-ID: <20250921174203-mutt-send-email-mst@kernel.org>
References: <20250813054831.25865-1-jasowang@redhat.com>
 <20250813054831.25865-2-jasowang@redhat.com>
 <20250921165434-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165434-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:55:10PM -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 13, 2025 at 01:48:23PM +0800, Jason Wang wrote:
> > This patch consities virtqueue point for DMA helpers.
> 
> constifies the virtqueue pointer

note that i fixed it for now

> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
> >  include/linux/virtio.h       | 12 ++++++------
> >  2 files changed, 19 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index f5062061c408..103bad8cffff 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3149,12 +3149,12 @@ EXPORT_SYMBOL_GPL(virtqueue_get_vring);
> >   *
> >   * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
> >   */
> > -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
> > +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr,
> >  					  size_t size,
> >  					  enum dma_data_direction dir,
> >  					  unsigned long attrs)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api) {
> >  		kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
> > @@ -3176,11 +3176,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
> >   * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
> >   *
> >   */
> > -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq,
> > +				      dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return;
> > @@ -3196,9 +3197,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
> >   *
> >   * Returns 0 means dma valid. Other means invalid dma address.
> >   */
> > -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
> > +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return 0;
> > @@ -3217,9 +3218,9 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
> >   *
> >   * return bool
> >   */
> > -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
> > +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> >  	if (!vq->use_dma_api)
> >  		return false;
> > @@ -3240,12 +3241,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
> >   * the DMA address really needs to be synchronized
> >   *
> >   */
> > -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
> > +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq,
> >  					     dma_addr_t addr,
> >  					     unsigned long offset, size_t size,
> >  					     enum dma_data_direction dir)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  	struct device *dev = vring_dma_dev(vq);
> >  
> >  	if (!vq->use_dma_api)
> > @@ -3266,12 +3267,12 @@ EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
> >   * Before calling this function, use virtqueue_dma_need_sync() to confirm that
> >   * the DMA address really needs to be synchronized
> >   */
> > -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
> > +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq,
> >  						dma_addr_t addr,
> >  						unsigned long offset, size_t size,
> >  						enum dma_data_direction dir)
> >  {
> > -	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	const struct vring_virtqueue *vq = to_vvq(_vq);
> >  	struct device *dev = vring_dma_dev(vq);
> >  
> >  	if (!vq->use_dma_api)
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index 8b745ce0cf5f..cf8def717dfd 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -259,18 +259,18 @@ void unregister_virtio_driver(struct virtio_driver *drv);
> >  	module_driver(__virtio_driver, register_virtio_driver, \
> >  			unregister_virtio_driver)
> >  
> > -dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
> > +dma_addr_t virtqueue_dma_map_single_attrs(const struct virtqueue *_vq, void *ptr, size_t size,
> >  					  enum dma_data_direction dir, unsigned long attrs);
> > -void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_unmap_single_attrs(const struct virtqueue *_vq, dma_addr_t addr,
> >  				      size_t size, enum dma_data_direction dir,
> >  				      unsigned long attrs);
> > -int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
> > +int virtqueue_dma_mapping_error(const struct virtqueue *_vq, dma_addr_t addr);
> >  
> > -bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
> > -void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
> > +bool virtqueue_dma_need_sync(const struct virtqueue *_vq, dma_addr_t addr);
> > +void virtqueue_dma_sync_single_range_for_cpu(const struct virtqueue *_vq, dma_addr_t addr,
> >  					     unsigned long offset, size_t size,
> >  					     enum dma_data_direction dir);
> > -void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
> > +void virtqueue_dma_sync_single_range_for_device(const struct virtqueue *_vq, dma_addr_t addr,
> >  						unsigned long offset, size_t size,
> >  						enum dma_data_direction dir);
> >  
> > -- 
> > 2.31.1


