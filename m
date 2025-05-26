Return-Path: <linux-kernel+bounces-663016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37BAC4290
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B3E3B12D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 15:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2321127D;
	Mon, 26 May 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WfZ1TXlu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EB17AE11
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274527; cv=pass; b=qe7iW/S+VF7i5h4tLfb8cFmNfWQqaAxTDDyX9hP6wEndiyl9lnfGT+fS+z39aMwrgvIPIS1rgQG6EfVuZqRmSc6nsBi7hdQ/mrwDRkinIk7eyAB1UJBhEwvmwXnFfI6uT0f4gcvJHunzOXGs/hxBTlR5cGxzO5jwzP9yPy87BVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274527; c=relaxed/simple;
	bh=82GBUa9Nldr58fzW7VM8zNc+/lL2Ued6wFmqFQSfTEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc/dxpyvN6dQK+AHGKrOxS2Y9oLMqmzUlxMFIGNdsKlxYH/jcA0jkfs2QWPDIfPWA+fgsytkmFS/PILUWIgRyofm6IjBHXOlO3HW1ZCiWJwJAr+SWa4CbgRXXiBWjk6zv6cP5Nh2ayvY4FKQEDCfeF7L1ryQLmlyYBIxIWV1vL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WfZ1TXlu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748274499; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=naFkj9zmjJ2xcCm8fV/FlsMk8/dkeMOcl1YwlHmZX7ds/XoeeYF1klyHunWpoq0qG/M+W2tatyAX1Ym4HlpAk0pcX6ydAiQoGV5cziCIKpF8gvpSEECvP0v5OtJi2CwOQMTQR57gedDcVsD0xmPLX4hj6wvfYOSn82k50OoKCbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748274499; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7u8vO7Ws768JnzmKvh2GmG4PF4lJ+CEAJNx0uPhyhQE=; 
	b=PUCvEeiZ+HlRLeM5uZhsKIKqMkZ6GGJs6i5MmTEKThCw+crouqHwC1MTIpAYfYmAHmCyHs6aEEi4WMyF9qcmekXci8tMOHOJxWgsUFTBVovV+AbQEor2AyQMm2fAFuNhViKUyZlcOO0fzlK+tuiLJWEc0A9yX0eRQKSVgDvXHV4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748274499;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7u8vO7Ws768JnzmKvh2GmG4PF4lJ+CEAJNx0uPhyhQE=;
	b=WfZ1TXlusW0K9YtTSApB3YEK7QfvL25+JrmhothPBfSMvMZG06jBawJPNenNuQbA
	FBa6IxiJkTYRgxuBtQndDvVU8npG7NhqrQlfJ/7lUN7ml6WdX6PSnSDnarekr1OjSVb
	rvaaUNot1I4/xqu0jB/ZPyKmB9mSDKxK+LKUt/Iw=
Received: by mx.zohomail.com with SMTPS id 1748274498096817.1869686603382;
	Mon, 26 May 2025 08:48:18 -0700 (PDT)
Message-ID: <28c64a39-1deb-4e0e-a395-2b243019ae70@collabora.com>
Date: Mon, 26 May 2025 18:48:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: implement virtio_gpu_shutdown
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250507082821.2710706-1-kraxel@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250507082821.2710706-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/7/25 11:28, Gerd Hoffmann wrote:
> Calling drm_dev_unplug() is the drm way to say the device
> is gone and can not be accessed any more.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index e32e680c7197..71c6ccad4b99 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>  
>  static void virtio_gpu_shutdown(struct virtio_device *vdev)
>  {
> -	/*
> -	 * drm does its own synchronization on shutdown.
> -	 * Do nothing here, opt out of device reset.
> -	 */
> +	struct drm_device *dev = vdev->priv;
> +
> +	/* stop talking to the device */
> +	drm_dev_unplug(dev);
>  }
>  
>  static void virtio_gpu_config_changed(struct virtio_device *vdev)

Could you please describe whether this patch is fixing a specific
problem or it's a generic improvement for avoiding potential problems on
shutdown.

-- 
Best regards,
Dmitry


