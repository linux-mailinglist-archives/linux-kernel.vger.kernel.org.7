Return-Path: <linux-kernel+bounces-762621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E173B2090E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C63518829D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E082D372F;
	Mon, 11 Aug 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="QqFifrMh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84EDF6C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916181; cv=pass; b=u+aoMnZ3cRq18BIgEOReMtn2W6KhSnCgpzDfvoJrqYMPLJlIv8w1wY5lVVuSCAoJoGyTldyZUzi+aFIhKep4XJhkQT7aVITu9d7FynEd8mB0WyqAhjsUbfwuiha5S5F8ZxQr+IvQboGQZ0bCzGnrPXldKDJ9M+zxXAsRXkw982Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916181; c=relaxed/simple;
	bh=XYlL/uFKP1jiqy7HabIgJdyqWkrXMgZlapz7/iuOg2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOXs0g9gIxFxqAImfgdrrdu4/wUxPoNrqupUzkGBImPelQ9SdaH+f6uHVil1Rp2s6OUEhLQNOWtNXS0D68IdHukOtXAdH7mb+n71ea6y+nhYLneU6msHv9FX5Xv/F5ueP6/eU2DWz5tg89Uwxr95iLUA+Euo9hXX55enSMW3wuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=QqFifrMh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754916167; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OrxeoxHqn7SbJYoeowFkaXUqiOvowmRdNvDsl6n5Qm5cXa6SWoif00qhR+t/ziPiDUerQAHMUSABpol1cN+IJvmFddHQyE0bTxn/Fkdi50qrTSvotZ4mOetgtTl5Qdlwb4pbGyYjHWYznfaF6/1yGT9knG9plHG7qpa2ApR3Qrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754916167; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F3kVqB/vWxEWDbBQ8Q6U07Ve3BBXfdiR4PHBdfR+t98=; 
	b=Xc8pkdatySKG3E+jygVjyZM2XadU2ZD8moBcmiXMcOLNP7rX8GlJrL1CAlvRFaSLbz0O1y4iBHW/l2DInCWIJO2f0aaUA5w7IUj4xbvxYYa7Cs7cO72WED1jll8NZD/IFn0sfBHx07JlBDP2wYe1CXjbGNlPgz4ywlXQdiqc6DY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754916167;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=F3kVqB/vWxEWDbBQ8Q6U07Ve3BBXfdiR4PHBdfR+t98=;
	b=QqFifrMhRLMMwbCcyYq1PKus6mj+EDjLl3M1rJrV2PQ6y+7TQXYoaz/igjk7WzAZ
	lrzaD8Q8hlwJX0CBet3lkQuOJC/LpQkZJqXJKYW4H7C8uc9pwM+p286ExBPccBz6Eo0
	u4W6r+GfePPzrjWS8uiY3c2EvMgvpO8HpbgiPiyk=
Received: by mx.zohomail.com with SMTPS id 1754916165966977.3418279049838;
	Mon, 11 Aug 2025 05:42:45 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:42:41 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] drm/panthor: Add panthor perf initialization and
 termination
Message-ID: <qrchlyyic3bezb77ai7gfe7yvthlhiftpkcyd5b2eswmcdxivm@ssvlq5hgh437>
References: <cover.1753449448.git.lukas.zapolskas@arm.com>
 <7674845a8c23b379c67b5aa279a29b3963489d26.1753449448.git.lukas.zapolskas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7674845a8c23b379c67b5aa279a29b3963489d26.1753449448.git.lukas.zapolskas@arm.com>

On 25.07.2025 15:57, Lukas Zapolskas wrote:
> Added the panthor_perf system initialization and unplug code to allow
> for the handling of userspace sessions to be added in follow-up
> patches.
>
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 +
>  drivers/gpu/drm/panthor/panthor_device.h |  5 +-
>  drivers/gpu/drm/panthor/panthor_perf.c   | 62 +++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_perf.h   |  1 +
>  4 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 15ab329722cc..ab3e65cc17bd 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -98,6 +98,7 @@ void panthor_device_unplug(struct panthor_device *ptdev)
>  	/* Now, try to cleanly shutdown the GPU before the device resources
>  	 * get reclaimed.
>  	 */
> +	panthor_perf_unplug(ptdev);
>  	panthor_sched_unplug(ptdev);
>  	panthor_fw_unplug(ptdev);
>  	panthor_mmu_unplug(ptdev);
> @@ -282,6 +283,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>
>  err_disable_autosuspend:
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> +	panthor_perf_unplug(ptdev);
>
>  err_unplug_sched:
>  	panthor_sched_unplug(ptdev);
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 720d39b9e783..a31dbc1919c8 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -27,7 +27,7 @@ struct panthor_heap_pool;
>  struct panthor_job;
>  struct panthor_mmu;
>  struct panthor_fw;
> -struct panthor_perfcnt;
> +struct panthor_perf;
>  struct panthor_vm;
>  struct panthor_vm_pool;
>
> @@ -138,6 +138,9 @@ struct panthor_device {
>  	/** @devfreq: Device frequency scaling management data. */
>  	struct panthor_devfreq *devfreq;
>
> +	/** @perf: Performance counter management data. */
> +	struct panthor_perf *perf;
> +
>  	/** @unplug: Device unplug related fields. */
>  	struct {
>  		/** @lock: Lock used to serialize unplug operations. */
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.c b/drivers/gpu/drm/panthor/panthor_perf.c
> index e58a62ad7988..af1c58e70a78 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -10,6 +10,19 @@
>  #include "panthor_perf.h"
>  #include "panthor_regs.h"
>
> +struct panthor_perf {
> +	/** @next_session: The ID of the next session. */
> +	u32 next_session;
> +
> +	/** @session_range: The number of sessions supported at a time. */
> +	struct xa_limit session_range;
> +
> +	/**
> +	 * @sessions: Global map of sessions, accessed by their ID.
> +	 */
> +	struct xarray sessions;
> +};
> +
>  struct panthor_perf_counter_block {
>  	struct drm_panthor_perf_block_header header;
>  	u64 counters[];
> @@ -64,14 +77,61 @@ static void panthor_perf_info_init(struct panthor_device *const ptdev)
>   * panthor_perf_init - Initialize the performance counter subsystem.
>   * @ptdev: Panthor device
>   *
> + * The performance counters require the FW interface to be available to setup the
> + * sampling ringbuffers, so this must be called only after FW is initialized.
> + *
>   * Return: 0 on success, negative error code on failure.
>   */
>  int panthor_perf_init(struct panthor_device *ptdev)
>  {
> +	struct panthor_perf *perf __free(kfree) = NULL;
> +	int ret = 0;
> +
>  	if (!ptdev)
>  		return -EINVAL;
>
>  	panthor_perf_info_init(ptdev);
>
> -	return 0;
> +	perf = kzalloc(sizeof(*perf), GFP_KERNEL);
> +	if (ZERO_OR_NULL_PTR(perf))
> +		return -ENOMEM;
> +
> +	xa_init_flags(&perf->sessions, XA_FLAGS_ALLOC);
> +
> +	perf->session_range = (struct xa_limit) {
> +		.min = 0,
> +		.max = 1,
> +	};
> +
> +	drm_info(&ptdev->base, "Performance counter subsystem initialized");
> +
> +	ptdev->perf = no_free_ptr(perf);
> +
> +	return ret;
> +}
> +
> +/**
> + * panthor_perf_unplug - Terminate the performance counter subsystem.
> + * @ptdev: Panthor device.
> + *
> + * This function will terminate the performance counter control structures and any remaining
> + * sessions, after waiting for any pending interrupts.
> + */
> +void panthor_perf_unplug(struct panthor_device *ptdev)
> +{
> +	struct panthor_perf *perf = ptdev->perf;
> +
> +	if (!perf)
> +		return;
> +
> +	if (!xa_empty(&perf->sessions)) {
> +		drm_err(&ptdev->base,
> +			"Performance counter sessions active when unplugging the driver!");
> +	}
> +
> +	xa_destroy(&perf->sessions);
> +
> +	kfree(ptdev->perf);
> +
> +	ptdev->perf = NULL;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_perf.h b/drivers/gpu/drm/panthor/panthor_perf.h
> index 3c32c24c164c..e4805727b9e7 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.h
> +++ b/drivers/gpu/drm/panthor/panthor_perf.h
> @@ -10,6 +10,7 @@
>  struct panthor_device;
>
>  int panthor_perf_init(struct panthor_device *ptdev);
> +void panthor_perf_unplug(struct panthor_device *ptdev);
>
>  #endif /* __PANTHOR_PERF_H__ */
>
> --
> 2.33.0.dirty


Adrian Larumbe

