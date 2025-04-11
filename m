Return-Path: <linux-kernel+bounces-600591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF7A861C5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 17:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AFD16C6D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466861F418E;
	Fri, 11 Apr 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EBND34/4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A020CCF5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Apr 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385121; cv=none; b=Vo/3135/13//7OFPT+b8UqQMcMbBy8jeXKuaXq7ny8OdyT0eJ5WQeZKGz23RdQvgbCV0SV/fgRZxfWY01Y6r3EUsT6oYfNqymIunKUdhr2S2aF1Li1UNvicJO68AmFCKUb18KMaovgmtffrSlU6O8uMlmN4Wu/Z6WAFmxPeXV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385121; c=relaxed/simple;
	bh=qDJuN3+lVHYYl3Lm2eiBb57L2Jk6ojBS2YiPNAfbfNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdVr/HxxsDrjmcSh7+9oKecj4oLkPDCkndEt+V9+laWVO/iJh9d5kwYpVdTaYBD01G5gdn14Q28cWRJkWUxqOBzfE/LGZDf9wwJpgriTRAL8589RPZIKsINrs14GK7XXks3yAk0t53wX75fIWvn9+sYjudUXsrCCUrlINz7tddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EBND34/4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744385117;
	bh=qDJuN3+lVHYYl3Lm2eiBb57L2Jk6ojBS2YiPNAfbfNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBND34/4Pn0F3OFFPMKZhoby0uOkNIenHRcMRhBmu4he59oJ06fUCFeD51rkJ2xoj
	 ybnIwbCkNDsWG/5Ts/yICJsWODUmOIH/RkOntLGbQlR9IV1e5ZRm7wydRYPzGa0ukt
	 zPx6PPqF41EFpR4nl/nvzQDctgkTX0BkLI7u/nNVZcA3r2i+VvUBglpvxp0UF45F1F
	 kiO73AS/4ZxPpM6wzNCILOtzzVFsp8JQNveQdlQseCPb4uE5Oh0nWaDMEopwDTjDOk
	 09llFTZn3pyEY7srbaxk6lQtSm8WgJc8RCNR9T2Dv+m7iMFEcj6DAMZ0QeMHY4nWgg
	 76PoEXavt9Wwg==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0FA7217E0402;
	Fri, 11 Apr 2025 17:25:17 +0200 (CEST)
Date: Fri, 11 Apr 2025 17:25:13 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Add 64-bit and poll register accessors
Message-ID: <20250411172513.42f0bcc4@collabora.com>
In-Reply-To: <6994d307-17e7-453b-b5b9-99a422f73f66@arm.com>
References: <20250410163546.919749-1-karunika.choo@arm.com>
	<20250410184637.5e0613d2@collabora.com>
	<6994d307-17e7-453b-b5b9-99a422f73f66@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 16:17:56 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> On 10/04/2025 17:46, Boris Brezillon wrote:
> > On Thu, 10 Apr 2025 17:35:46 +0100
> > Karunika Choo <karunika.choo@arm.com> wrote:
> >   
> >> This patch adds 64-bit register accessors to simplify register access in
> >> Panthor. It also adds 32-bit and 64-bit variants for read_poll_timeout.
> >>
> >> This patch also updates Panthor to use the new 64-bit accessors and poll
> >> functions.
> >>
> >> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> >> ---
> >>  drivers/gpu/drm/panthor/panthor_device.h |  71 ++++++++++++
> >>  drivers/gpu/drm/panthor/panthor_fw.c     |   9 +-
> >>  drivers/gpu/drm/panthor/panthor_gpu.c    | 142 ++++++-----------------
> >>  drivers/gpu/drm/panthor/panthor_mmu.c    |  34 ++----
> >>  drivers/gpu/drm/panthor/panthor_regs.h   |   6 -
> >>  5 files changed, 124 insertions(+), 138 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> >> index da6574021664..5028e25f5e0d 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_device.h
> >> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> >> @@ -428,4 +428,75 @@ static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
> >>  
> >>  extern struct workqueue_struct *panthor_cleanup_wq;
> >>  
> >> +static inline void gpu_write(struct panthor_device *ptdev, u32 reg, u32 data)
> >> +{
> >> +	writel(data, ptdev->iomem + reg);
> >> +}
> >> +
> >> +static inline u32 gpu_read(struct panthor_device *ptdev, u32 reg)
> >> +{
> >> +	return readl(ptdev->iomem + reg);
> >> +}
> >> +
> >> +static inline u32 gpu_read_relaxed(struct panthor_device *ptdev, u32 reg)
> >> +{
> >> +	return readl_relaxed(ptdev->iomem + reg);
> >> +}
> >> +
> >> +static inline void gpu_write64(struct panthor_device *ptdev, u32 reg, u64 data)
> >> +{
> >> +	gpu_write(ptdev, reg, lower_32_bits(data));
> >> +	gpu_write(ptdev, reg + 4, upper_32_bits(data));
> >> +}
> >> +
> >> +static inline u64 gpu_read64(struct panthor_device *ptdev, u32 reg)
> >> +{
> >> +	return (gpu_read(ptdev, reg) | ((u64)gpu_read(ptdev, reg + 4) << 32));
> >> +}
> >> +
> >> +static inline u64 gpu_read64_relaxed(struct panthor_device *ptdev, u32 reg)
> >> +{
> >> +	return (gpu_read_relaxed(ptdev, reg) |
> >> +		((u64)gpu_read_relaxed(ptdev, reg + 4) << 32));
> >> +}
> >> +
> >> +static inline u64 gpu_read64_counter(struct panthor_device *ptdev, u32 reg)
> >> +{
> >> +	u32 lo, hi1, hi2;
> >> +	do {
> >> +		hi1 = gpu_read(ptdev, reg + 4);
> >> +		lo = gpu_read(ptdev, reg);
> >> +		hi2 = gpu_read(ptdev, reg + 4);
> >> +	} while (hi1 != hi2);
> >> +	return lo | ((u64)hi2 << 32);
> >> +}
> >> +
> >> +#define gpu_read_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
> >> +	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false, \
> >> +			  dev, reg)  
> > 
> > nit: can use use tabs to pad till the '\' at the end of the line so we
> > can have a consistent formatting across these definitions?
> >   
> >> +
> >> +#define gpu_read_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
> >> +				     timeout_us)                            \
> >> +	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us, \
> >> +				 false, dev, reg)
> >> +
> >> +#define gpu_read64_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)    \
> >> +	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false, \
> >> +			  dev, reg)
> >> +
> >> +#define gpu_read64_poll_timeout_atomic(dev, reg, val, cond, delay_us,         \
> >> +				       timeout_us)                            \
> >> +	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us, \
> >> +				 false, dev, reg)
> >> +
> >> +#define gpu_read_relaxed_poll_timeout_atomic(dev, reg, val, cond, delay_us, \
> >> +					     timeout_us)                    \
> >> +	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,     \
> >> +				 timeout_us, false, dev, reg)
> >> +
> >> +#define gpu_read64_relaxed_poll_timeout(dev, reg, val, cond, delay_us,         \
> >> +					timeout_us)                            \
> >> +	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us, \
> >> +			  false, dev, reg)
> >> +
> >>  #endif
> >> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> >> index 0f52766a3120..ecfbe0456f89 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> >> @@ -1059,8 +1059,8 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
> >>  	u32 status;
> >>  
> >>  	gpu_write(ptdev, MCU_CONTROL, MCU_CONTROL_DISABLE);
> >> -	if (readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> >> -			       status == MCU_STATUS_DISABLED, 10, 100000))
> >> +	if (gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
> >> +				  status == MCU_STATUS_DISABLED, 10, 100000))
> >>  		drm_err(&ptdev->base, "Failed to stop MCU");
> >>  }
> >>  
> >> @@ -1085,8 +1085,9 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
> >>  
> >>  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
> >>  		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> >> -		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> >> -					status == MCU_STATUS_HALT, 10, 100000)) {
> >> +		if (!gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
> >> +					   status == MCU_STATUS_HALT, 10,
> >> +					   100000)) {
> >>  			ptdev->reset.fast = true;
> >>  		} else {
> >>  			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
> >> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> >> index 671049020afa..fd09f0928019 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> >> @@ -108,14 +108,9 @@ static void panthor_gpu_init_info(struct panthor_device *ptdev)
> >>  
> >>  	ptdev->gpu_info.as_present = gpu_read(ptdev, GPU_AS_PRESENT);
> >>  
> >> -	ptdev->gpu_info.shader_present = gpu_read(ptdev, GPU_SHADER_PRESENT_LO);
> >> -	ptdev->gpu_info.shader_present |= (u64)gpu_read(ptdev, GPU_SHADER_PRESENT_HI) << 32;
> >> -
> >> -	ptdev->gpu_info.tiler_present = gpu_read(ptdev, GPU_TILER_PRESENT_LO);
> >> -	ptdev->gpu_info.tiler_present |= (u64)gpu_read(ptdev, GPU_TILER_PRESENT_HI) << 32;
> >> -
> >> -	ptdev->gpu_info.l2_present = gpu_read(ptdev, GPU_L2_PRESENT_LO);
> >> -	ptdev->gpu_info.l2_present |= (u64)gpu_read(ptdev, GPU_L2_PRESENT_HI) << 32;
> >> +	ptdev->gpu_info.shader_present = gpu_read64(ptdev, GPU_SHADER_PRESENT_LO);
> >> +	ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT_LO);
> >> +	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);  
> > 
> > Now that we have proper 64-bit accessors, I think I would drop the
> > _LO/_HI definitions and just go a single def per register that replaces
> > the _LO one.  
> 
> Hello, 
> 
> please find a link to v2 below that addresses your comments.
> 
> - https://lore.kernel.org/dri-devel/20250411151140.1815435-1-karunika.choo@arm.com/

Looks all good now.

Thanks!

Boris

