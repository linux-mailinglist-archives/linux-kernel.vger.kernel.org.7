Return-Path: <linux-kernel+bounces-869016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EACC8C06B87
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CF5A35C6B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B691318151;
	Fri, 24 Oct 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jkmbi0Gs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4F31771B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316501; cv=none; b=TKlgyWCYR3upZ1qRJpWkGb5urH3yBMvRI3eD7HdPCBkJKWqZkVPfSobrD3COY7X1Gu3WtL1Y5by0mKPc1/8N4+FHZjPBYUJ8g6kYrZI4masXruORxncAJu22AKeB5ymUWWGM5ZyMuCmaAfwMiLUNxmEaCLNh36H0oN9ORlHpd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316501; c=relaxed/simple;
	bh=cZiRxDrNwEOcmt6Os8c8zNYJDvlxkJD6GM2iEEMtVnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzlZbwLcKZHCaVSY5224wS+MgWoqTbOkO1UDrIe6+rIo6AyPEp8GCumpFSGoHM3v3+UzXQbm8fGkjh2rmYNKjqB2A02qVsVNDjy7+mxQwf4F/IJMJPJVW/KanBh//sxOmRQZt3HVvM5/VtGz3gX93S1EJxJbw7072EfysBUvVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jkmbi0Gs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761316497;
	bh=cZiRxDrNwEOcmt6Os8c8zNYJDvlxkJD6GM2iEEMtVnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jkmbi0Gs9Q2MR2t/4IXh2InVzQZ400j3rSu8Szixs0QFzWXLObKOFIq1jkwekd5y1
	 6kiXVSA+nL6QL1yrhUe/up9rhAUhTF5gdQ8oJ0kvoyRs4VB34GiVUO2BWReCwrduWx
	 4LINmRjEdtnnleWOvZDAqRSPDK9b2aJ4h5uGSHyPOcghgW/FcGlsKPu/K9p9UZVDIJ
	 f08KcsnfKLJQmqIeiLdf+lAodzuMmoDdQVy49/UFMEU3k2aTdLROITtdvqq9q32ula
	 KBLlNoc2ChrY6caE9Ts6kIJrvQv4hjQub0JpJwcpOgviFP1+Yh/bs7NE0bhAECYy7I
	 Uz32RG7Zx2kGQ==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 28C9617E00AC;
	Fri, 24 Oct 2025 16:34:57 +0200 (CEST)
Date: Fri, 24 Oct 2025 16:34:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix race with suspend during unplug
Message-ID: <20251024163451.14a7042c@fedora>
In-Reply-To: <20251022103242.1083311-1-ketil.johnsen@arm.com>
References: <20251022103242.1083311-1-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:32:41 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> There is a race between panthor_device_unplug() and
> panthor_device_suspend() which can lead to IRQ handlers running on a
> powered down GPU. This is how it can happen:
> - unplug routine calls drm_dev_unplug()
> - panthor_device_suspend() can now execute, and will skip a lot of
>   important work because the device is currently marked as unplugged.
> - IRQs will remain active in this case and IRQ handlers can therefore
>   try to access a powered down GPU.
> 
> The fix is simply to take the PM ref in panthor_device_unplug() a
> little bit earlier, before drm_dev_unplug().
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Fixes: 5fe909cae118a ("drm/panthor: Add the device logical block")

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 81df49880bd87..962a10e00848e 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -83,6 +83,8 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  		return;
>  	}
>  
> +	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> +
>  	/* Call drm_dev_unplug() so any access to HW blocks happening after
>  	 * that point get rejected.
>  	 */
> @@ -93,8 +95,6 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	 */
>  	mutex_unlock(&ptdev->unplug.lock);
>  
> -	drm_WARN_ON(&ptdev->base, pm_runtime_get_sync(ptdev->base.dev) < 0);
> -
>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */


