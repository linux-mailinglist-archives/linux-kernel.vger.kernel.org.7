Return-Path: <linux-kernel+bounces-736209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1039B09A17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D456D7B7807
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95331B4257;
	Fri, 18 Jul 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="gRGWM4x3"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA701400C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808270; cv=pass; b=akv3+AaO8AA14KDRZDOsTehuJpEr6xGtAVTw2MqIjq5f5L6qWJutp+aK4a+RetMQchYbwE754jA7H9ClXeX3YFKKijKXpWLeDNNaGGd3EsmE/ZLb35q2Jbt48d7DQgrcMABQ0o1fBZMMDcyqI5Fw+9WvQbKLthswjwUFUKHg2eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808270; c=relaxed/simple;
	bh=hG0RDXF60yYjxl8pqljyiEuNg4VZM0Vzu79gV5TgBfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwrXPduQKCAm4bV/ZFFOrHJbhgTRyC9nCANn45IriOoE22kgKuUSJIRIJBpYi6z2jxkCSgzN9twAscEoPiGiPRQEZhIA625vFLQs+UAlktLyLSwt61R7/mkVL9fjb6865CYAJDpWvXdPJJZhpRXbIF6M3Aq6WRJK7MjSLhIWrnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=gRGWM4x3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752808254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F6rsgXt1OFhK9xRWuMcbNlzC/xqrVBmAfa1YMezQAptTkNW96s+mX6RAt28drazGmehiYR7+ePPpVnzRsQU+QFTVzmIUcL/G6KTIIopFZr/lbtIrxq8JRBu6aSXaaBOHyhCv3It37uiUS//FCrsw20ajdhMfjbq/LB6oiIeFqdw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752808254; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cCkGUyMFbvVF1lv3gMiBz+wBa3g8+jZyUZVPLa5Dzl8=; 
	b=GksfS6gHZvmkS7dw76Xq602RJQK8f6y3qWXXdZsUVicCvmQQrzUveHZQqmKr8GUnLj0GGdxlRr+5GsghpNFWMi1NT6UDipFLGIoNuc1Y5wueQhQY1A8WMFsRJxyGlwPWJQ0tAnWjnFII/5iTwvnn0W6BuKHkO5osloxBQPBOrXI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752808254;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cCkGUyMFbvVF1lv3gMiBz+wBa3g8+jZyUZVPLa5Dzl8=;
	b=gRGWM4x36z26U2GkzQB+JzKCsAFbc9gfbAu19naEIVFplqtrpXH8NxAxSz90dNV4
	71j0zfe5zERcSgnq/xISj6wwmzAegCB7T6VYZkWTz/hxnfSoB0tnpK1BKu0wkx58o2P
	F0IWlLdeCFxE9SvOZbj/fjZHpFXuUbZgvqZs0Vuw=
Received: by mx.zohomail.com with SMTPS id 1752808252721460.2044643663314;
	Thu, 17 Jul 2025 20:10:52 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:10:47 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Lukas Zapolskas <lukas.zapolskas@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] drm/panthor: Add panthor perf initialization and
 termination
Message-ID: <i2hdrxnd4whzpfzjsmx4mmcvghqu5t6rzki2tnsrarxewnr76j@clmkf6zyiy4p>
References: <cover.1747148172.git.lukas.zapolskas@arm.com>
 <c53f9e012e148329a437013a812fc688e797a26b.1747148172.git.lukas.zapolskas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c53f9e012e148329a437013a812fc688e797a26b.1747148172.git.lukas.zapolskas@arm.com>

On 16.05.2025 16:49, Lukas Zapolskas wrote:
> Added the panthor_perf system initialization and unplug code to allow
> for the handling of userspace sessions to be added in follow-up
> patches.
>
> Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 +
>  drivers/gpu/drm/panthor/panthor_device.h |  5 +-
>  drivers/gpu/drm/panthor/panthor_perf.c   | 62 +++++++++++++++++++++++-
>  drivers/gpu/drm/panthor/panthor_perf.h   |  1 +
>  4 files changed, 68 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 76b4cf3dc391..7ac985d44655 100644
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
> @@ -277,6 +278,7 @@ int panthor_device_init(struct panthor_device *ptdev)
>
>  err_disable_autosuspend:
>  	pm_runtime_dont_use_autosuspend(ptdev->base.dev);
> +	panthor_perf_unplug(ptdev);
>  	panthor_sched_unplug(ptdev);
>
>  err_unplug_fw:
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 657ccc39568c..818c4d96d448 100644
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
> index 66e9a197ac1f..9365ce9fed04 100644
> --- a/drivers/gpu/drm/panthor/panthor_perf.c
> +++ b/drivers/gpu/drm/panthor/panthor_perf.c
> @@ -9,6 +9,19 @@
>  #include "panthor_fw.h"
>  #include "panthor_perf.h"

You must include "panthor_regs.h" here or else GPU_MEM_FEATURES_L2_SLICES() won't be available.
However, it seems this is something that should be done in the previous patch.

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
> @@ -63,14 +76,61 @@ static void panthor_perf_info_init(struct panthor_device *ptdev)
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

I think this could only happen if someone forces module unload, even
though there might still be processes which haven't yet closed the DRM
file?

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

