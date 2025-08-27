Return-Path: <linux-kernel+bounces-788451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40530B384C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E50F4E2F53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE5303CB6;
	Wed, 27 Aug 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMoHMgkj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762B729DB6C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304296; cv=none; b=rNgiX6xm5eRatGQyEEZ9FLSnBtFvkuedI5SsSszwKuSRYFPcaeYA0oPU7HJ/Yw6yrRK66cgaDbEA1ivYZtH8ySW3kWbQhlxvkbSJbXDv6kh1E6uo0fJkIFYWJzermMVb3zt3rF6Op4X21e9riWgKNqDae16VhOcfIqvKM3Lacg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304296; c=relaxed/simple;
	bh=mu9kdXzVzXEXxXTYV94o7nB5Eg9FUgA2R0H/Ph/2Lfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xux2uozcKyeUTg97EmZy1zzLVhwQcaNelxfKtbFMRm1HyZ+vkyf3nLxBtom7QUGKPShauG9dvotiTJjcAlBNvRxzhjZ9n9UcmL4uZz2ORNPasoLthDVwFW0MiHEiX3QMS5qFzzo8IAt/Lh2U7cnMz7Lo+02ydpuwgJcmZ4jUcew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMoHMgkj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756304293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sgUfxBOpWvR/1fknE7QCUEeu1XgrhJGIUSMRhQLyKfY=;
	b=bMoHMgkjBglhcgeSXKb2wlCx1CSgeylGbkQ2r0Fypftvoonv32QjVHI5wD4mS+XVo6Hf9x
	sNUyOsBJE3ql7jRc6/WGss1UFh6cjYIYWs0jdf3HqLFrKb834MQfNh8j44IdOpqeYM7a1J
	DoJSZFrtZjineGI8ldWZ1mhz4/+G67c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-jLe3mT-NP2G5mZzgA7Bgkg-1; Wed, 27 Aug 2025 10:18:02 -0400
X-MC-Unique: jLe3mT-NP2G5mZzgA7Bgkg-1
X-Mimecast-MFC-AGG-ID: jLe3mT-NP2G5mZzgA7Bgkg_1756304281
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so47356275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304281; x=1756909081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgUfxBOpWvR/1fknE7QCUEeu1XgrhJGIUSMRhQLyKfY=;
        b=Wyw6tW8cbKa1EjMAGxoHHmJTP7oNhr5JaddwXtCL+JM3ulu8t6O+7Ga8pnKbycwG9N
         0ruMrL7+gUgT9w7e0OA7LwO4YeoVfO0y5IvLhb7M8QXJ0Bnm3+Fcm4m6jKN6YxLAz9sw
         RlK+BkooFm71I+joppB4iUI8FF6Nkm7PlVgryAwrwc016LdtbsGUBq26q4cl0rxAPFr+
         d3kwiCzTH9Q+XHpg6/mjC6lkVwKRUjKs23hQ4HmETzAM+Uedh6Vpz8Z4+VITDsiKHMgr
         Ke/6JDgIsxv56K/5Xt6Y+nrqLpjsGkBVzgFfnTTTuTH3m87n15fd3libhGYsF0ryzo2t
         bC/w==
X-Forwarded-Encrypted: i=1; AJvYcCW5UCujm5d+Z+1CizAz9J6XhzFnuiWUCMmzzjYFv8pv0ewyCP/fEft0+YzAwuyu2AmLUm8gQKvFULz/uj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZghF7KxZ/bhCJo6xRckSgLTHCJTKArJ8YLRqZdB6uBSpIrwv
	eD1wSzAF/x7iznUbAWZzZ80Z8EpuVRA4lTO1sAtvulmeMe6YiB5fJFNawaFJXbsTZjcFd8Fc4MW
	2BmBOlOaVLJIXjlVm7yGYEb2P01606po2mMidlCzVvoeDAcstioeYtHhpkM2D6POXpw==
X-Gm-Gg: ASbGnct78hX3yTWnc+pBof925OB76lqKOtA9quK64zH5FH72wHpgrzDGLseuTdqpmv+
	xDDOkvG3NgapNHJvtJPICHchfADld9fJ/dBPZeRWgb4J0UV4IeRkIcZCM/uL9nnvtuWqgOliWss
	x63dk2vKhZXacX03miYeSDhgQcUKK5MX9MciE71PrVATXzOawPi7x4Ikqon5CQzpozPGS4KJzvb
	SNbNWMshP58pqBw4lU1rS5Hf493Izq54+ru0XJeeh+FgBDZC34EP52Rq4piq8DE5bp+Bh9rJdZR
	ZAJaYPS3CDsYbxawTwyYVTnmDyosEbA=
X-Received: by 2002:a05:600c:45d4:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-45b5179eb97mr244030725e9.16.1756304280873;
        Wed, 27 Aug 2025 07:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbZR9PVQfnxpyO9iPgY1rrQVw+ltDuzZUlf8dML5LjizH06Bt+gcbs14ArI6vFUc4IVe70XQ==
X-Received: by 2002:a05:600c:45d4:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-45b5179eb97mr244030425e9.16.1756304280434;
        Wed, 27 Aug 2025 07:18:00 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ca6240b4ecsm10592154f8f.43.2025.08.27.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:17:59 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:17:55 -0400
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
Message-ID: <20250827101732-mutt-send-email-mst@kernel.org>
References: <20250827081231.1878248-1-honglei1.huang@amd.com>
 <9ecf015d-d96a-40ac-a7fb-50e46c4f6e00@collabora.com>
 <20250827093320-mutt-send-email-mst@kernel.org>
 <c38fb2bf-15c4-4cee-be0e-59d998cd03ac@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38fb2bf-15c4-4cee-be0e-59d998cd03ac@collabora.com>

On Wed, Aug 27, 2025 at 04:51:37PM +0300, Dmitry Osipenko wrote:
> On 8/27/25 16:33, Michael S. Tsirkin wrote:
> > On Wed, Aug 27, 2025 at 03:52:05PM +0300, Dmitry Osipenko wrote:
> >> On 8/27/25 11:12, Honglei Huang wrote:
> >>> From: Honglei Huang <Honglei1.Huang@amd.com>
> >>>
> >>> Commit 206cc44588f7 ("virtio: reject shm region if length is zero")
> >>> enhanced the validation in virtio_get_shm_region() by adding a check
> >>> for a zero-length shared memory region.
> >>>
> >>> It is performed before the underlying transport's .get_shm_region()
> >>> implementation is called. This creates an issue in the virtio-gpu
> >>> driver, where the `region` struct is part of a larger structure
> >>> that is zero-initialized by drmm_kzalloc().
> >>>
> >>> Consequently, the `len` field is 0 at the time of the check, causing
> >>> virtio_get_shm_region() to return false prematurely. This prevents the
> >>> host visible memory feature from being enabled, even when the device
> >>> supports it.
> >>>
> >>> To resolve this, this patch bypasses the inline helper and calls the
> >>> underlying vdev->config->get_shm_region() function pointer directly.
> >>> This ensures that the region's parameters are checked only after they
> >>> have been populated by the transport, aligning with the intended logic.
> >>>
> >>> Signed-off-by: Honglei Huang <Honglei1.Huang@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/virtio/virtgpu_kms.c | 6 ++++--
> >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >>> index 7dfb2006c561..ed5981248302 100644
> >>> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> >>> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> >>> @@ -174,8 +174,10 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
> >>>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
> >>>  		vgdev->has_resource_blob = true;
> >>>  	}
> >>> -	if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
> >>> -				  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> >>> +	if (vgdev->vdev->config->get_shm_region &&
> >>> +	    vgdev->vdev->config->get_shm_region(
> >>> +		    vgdev->vdev, &vgdev->host_visible_region,
> >>> +		    VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
> >>>  		if (!devm_request_mem_region(&vgdev->vdev->dev,
> >>>  					     vgdev->host_visible_region.addr,
> >>>  					     vgdev->host_visible_region.len,
> >>
> >> Hi, virtio_get_shm_region() change has been reverted by [1]. Don't think
> >> anything else needs to be done.
> >>
> >> [1]
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20250827&id=ced17ee32a9988b8a260628e7c31a100d7dc082e
> >>
> >> +cc Michael Tsirkin
> >>
> >> Might be only good to send a stable kernel PR with that revert. I see
> >> patch available only in linux-next, while stable kernels need to be
> >> fixed sooner.
> > 
> > sooner than what?
> 
> Next 6.17 kernel release. I see patch in the linux-next branch. Often
> there is a -fixes branch for patches that go into RC kernel, but I don't
> see one in your vhost kernel tree. Will the revert land into 6.17-rc4?
> Everything is good if yes.

Should go into rc4 or rc5, yes.


> -- 
> Best regards,
> Dmitry


