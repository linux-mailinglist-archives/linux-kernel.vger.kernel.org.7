Return-Path: <linux-kernel+bounces-860970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B3CBF17C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E165E4F5E12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE714A3E;
	Mon, 20 Oct 2025 13:12:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009202FB615
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965968; cv=none; b=LrS/QC8TA2mfhyO6InRy5yelx4kxVkJlIPkslJANvB0nmhfjvDehGSqRv8dNn/Dvd+kaKApnV0Fbjdy9bBfsGKaiQ73WTYKO/gZpCAUWYrq4Az+umlsM3fKpv69/sUWhHMMAlhanR42fOAqsQpeihUQipeGtU1qpVGL1vEObWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965968; c=relaxed/simple;
	bh=Ox8uKHawwpugdsuOAvLpIeHDyzPeM69O8zPikT/c7Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpgFQFMVPo74iP5BBAYTIl6NzYw+htE7ayBOnYIhdf/VwvIZcrHcLILl9ISnXHKULybf7Fw204kdFdkfN60E+ppONQHCWKwYwQWVgfGiN9QIxPqiBSmywYub0VTDVANqc/oQOiTG8G+0IhigrQEf5B476c7Z42ZWQ6GZes3IzAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5565F1007;
	Mon, 20 Oct 2025 06:12:37 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39CBD3F66E;
	Mon, 20 Oct 2025 06:12:43 -0700 (PDT)
Message-ID: <01bb8a05-b756-4bfd-9ac1-72ee16a6e8a9@arm.com>
Date: Mon, 20 Oct 2025 14:12:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/10] drm/panthor: Support 64-bit endpoint_req
 register for Mali-G1
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251014094337.1009601-1-karunika.choo@arm.com>
 <20251014094337.1009601-10-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251014094337.1009601-10-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:43, Karunika Choo wrote:
> Add support for the 64-bit endpoint_req register introduced in CSF v4.0+
> GPUs. Unlike a simple register widening, the 64-bit variant occupies the
> next 64 bits after the original 32-bit field, requiring
> version-dependent access.
> 
> This change introduces helper functions to read, write, and update the
> endpoint_req register based on the CSF interface version, ensuring
> correct handling on both pre-v4.0 and v4.0+ hardware.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c    | 43 ++++++++++++++++++++++---
>  drivers/gpu/drm/panthor/panthor_fw.h    | 20 +++++++++++-
>  drivers/gpu/drm/panthor/panthor_sched.c | 22 +++++++------
>  3 files changed, 70 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 48bbae8931cb..c1b2fba311d8 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -318,6 +318,41 @@ panthor_fw_get_cs_iface(struct panthor_device *ptdev, u32 csg_slot, u32 cs_slot)
>  	return &ptdev->fw->iface.streams[csg_slot][cs_slot];
>  }
>  
> +u64 panthor_fw_csg_endpoint_req_get(struct panthor_device *ptdev, u32 csg_id)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> +
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 0, 0))
> +		return csg_iface->input->endpoint_req2;
> +	else
> +		return csg_iface->input->endpoint_req;
> +}

I'm not sure it's an improvement taking csg_id rather than csg_iface.
csg_slot_sync_priority_locked() does get more simple, but the other
functions already have the csg_iface pointer so this is just repeated work.

We also really want a helper for the version check...

> +
> +void panthor_fw_csg_endpoint_req_set(struct panthor_device *ptdev, u32 csg_id, u64 value)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> +
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 0, 0))
> +		csg_iface->input->endpoint_req2 = value;
> +	else
> +		csg_iface->input->endpoint_req = lower_32_bits(value);
> +}
> +
> +void panthor_fw_csg_endpoint_req_update(struct panthor_device *ptdev, u32 csg_id, u64 value,
> +					u64 mask)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> +
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 0, 0))
> +		panthor_fw_update_reqs64(csg_iface, endpoint_req2, value, mask);
> +	else
> +		panthor_fw_update_reqs(csg_iface, endpoint_req, lower_32_bits(value),
> +				       lower_32_bits(mask));
> +}
> +
>  /**
>   * panthor_fw_conv_timeout() - Convert a timeout into a cycle-count
>   * @ptdev: Device.
> @@ -997,7 +1032,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  					 GLB_IDLE_EN |
>  					 GLB_IDLE;
>  
> -	if (panthor_fw_csf_version(ptdev) >= CSF_IFACE_VERSION(4, 1, 0))
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0))

These should be in the previous patch.

>  		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
>  
>  	panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN, GLB_IDLE_EN);
> @@ -1080,7 +1115,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
>  
>  	halted = gpu_read(ptdev, MCU_STATUS) == MCU_STATUS_HALT;
>  
> -	if (panthor_fw_csf_version(ptdev) >= CSF_IFACE_VERSION(4, 1, 0))
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0))
>  		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
>  
>  	return halted;
> @@ -1090,7 +1125,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  
> -	if (panthor_fw_csf_version(ptdev) >= CSF_IFACE_VERSION(4, 1, 0))
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0))
>  		panthor_fw_update_reqs(glb_iface, req, GLB_STATE(GLB_STATE_HALT), GLB_STATE_MASK);
>  	else
>  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
> @@ -1115,7 +1150,7 @@ static void panthor_fw_mcu_set_active(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  
> -	if (panthor_fw_csf_version(ptdev) >= CSF_IFACE_VERSION(4, 1, 0))
> +	if (glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0))
>  		panthor_fw_update_reqs(glb_iface, req, GLB_STATE(GLB_STATE_ACTIVE), GLB_STATE_MASK);
>  	else
>  		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index a19ed48b2d0b..25ebf0d31d0d 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -168,9 +168,10 @@ struct panthor_fw_csg_input_iface {
>  #define CSG_EP_REQ_EXCL_COMPUTE			BIT(20)
>  #define CSG_EP_REQ_EXCL_FRAGMENT		BIT(21)
>  #define CSG_EP_REQ_PRIORITY(x)			(((x) << 28) & GENMASK(31, 28))
> +#define CSG_EP_REQ_PRIORITY_GET(x)		(((x) & GENMASK(31, 28)) >> 28)
>  #define CSG_EP_REQ_PRIORITY_MASK		GENMASK(31, 28)

NIT: if we reorder then we can avoid repeating GENMASK(31, 28).

>  	u32 endpoint_req;
> -	u32 reserved2[2];
> +	u64 endpoint_req2;
>  	u64 suspend_buf;
>  	u64 protm_suspend_buf;
>  	u32 config;
> @@ -464,6 +465,16 @@ struct panthor_fw_global_iface {
>  		spin_unlock(&(__iface)->lock); \
>  	} while (0)
>  
> +#define panthor_fw_update_reqs64(__iface, __in_reg, __val, __mask) \
> +	do { \
> +		u64 __cur_val, __new_val; \
> +		spin_lock(&(__iface)->lock); \
> +		__cur_val = READ_ONCE((__iface)->input->__in_reg); \
> +		__new_val = (__cur_val & ~(__mask)) | ((__val) & (__mask)); \
> +		WRITE_ONCE((__iface)->input->__in_reg, __new_val); \
> +		spin_unlock(&(__iface)->lock); \
> +	} while (0)
> +
>  struct panthor_fw_global_iface *
>  panthor_fw_get_glb_iface(struct panthor_device *ptdev);
>  
> @@ -473,6 +484,13 @@ panthor_fw_get_csg_iface(struct panthor_device *ptdev, u32 csg_slot);
>  struct panthor_fw_cs_iface *
>  panthor_fw_get_cs_iface(struct panthor_device *ptdev, u32 csg_slot, u32 cs_slot);
>  
> +u64 panthor_fw_csg_endpoint_req_get(struct panthor_device *ptdev, u32 csg_id);
> +
> +void panthor_fw_csg_endpoint_req_set(struct panthor_device *ptdev, u32 csg_id, u64 value);
> +
> +void panthor_fw_csg_endpoint_req_update(struct panthor_device *ptdev, u32 csg_id, u64 value,
> +					u64 mask);
> +
>  int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_id, u32 req_mask,
>  			     u32 *acked, u32 timeout_ms);
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0cc9055f4ee5..25663de62b8e 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1138,12 +1138,11 @@ static void
>  csg_slot_sync_priority_locked(struct panthor_device *ptdev, u32 csg_id)
>  {
>  	struct panthor_csg_slot *csg_slot = &ptdev->scheduler->csg_slots[csg_id];
> -	struct panthor_fw_csg_iface *csg_iface;
>  
>  	lockdep_assert_held(&ptdev->scheduler->lock);
>  
> -	csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
> -	csg_slot->priority = (csg_iface->input->endpoint_req & CSG_EP_REQ_PRIORITY_MASK) >> 28;
> +	csg_slot->priority =
> +		CSG_EP_REQ_PRIORITY_GET(panthor_fw_csg_endpoint_req_get(ptdev, csg_id));

NIT: This is a useful refactor, but it's best to avoid refactoring at
the same time as making other changes as it's then harder to review (and
regressions are harder to pin down).

I also think a local variable would help with the line length:

  u64 endpoint_req = panthor_fw_csg_endpoint_req_get(ptdev, csg_id);

  csg_slot->priority = CSG_EP_REQ_PRIORITY_GET(endpoint_req);

>  }
>  
>  /**
> @@ -1303,6 +1302,7 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
>  	struct panthor_csg_slot *csg_slot;
>  	struct panthor_group *group;
>  	u32 queue_mask = 0, i;
> +	u32 endpoint_req = 0;

No need to initialise (and doing so hides compiler warnings if this is
used when it shouldn't be).

It won't actually make any difference, but this should also be u64 to
match the new wider register.

Thanks,
Steve

>  
>  	lockdep_assert_held(&ptdev->scheduler->lock);
>  
> @@ -1329,10 +1329,12 @@ csg_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 priority)
>  	csg_iface->input->allow_compute = group->compute_core_mask;
>  	csg_iface->input->allow_fragment = group->fragment_core_mask;
>  	csg_iface->input->allow_other = group->tiler_core_mask;
> -	csg_iface->input->endpoint_req = CSG_EP_REQ_COMPUTE(group->max_compute_cores) |
> -					 CSG_EP_REQ_FRAGMENT(group->max_fragment_cores) |
> -					 CSG_EP_REQ_TILER(group->max_tiler_cores) |
> -					 CSG_EP_REQ_PRIORITY(priority);
> +	endpoint_req = CSG_EP_REQ_COMPUTE(group->max_compute_cores) |
> +		       CSG_EP_REQ_FRAGMENT(group->max_fragment_cores) |
> +		       CSG_EP_REQ_TILER(group->max_tiler_cores) |
> +		       CSG_EP_REQ_PRIORITY(priority);
> +	panthor_fw_csg_endpoint_req_set(ptdev, csg_id, endpoint_req);
> +
>  	csg_iface->input->config = panthor_vm_as(group->vm);
>  
>  	if (group->suspend_buf)
> @@ -2230,9 +2232,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  				continue;
>  			}
>  
> -			panthor_fw_update_reqs(csg_iface, endpoint_req,
> -					       CSG_EP_REQ_PRIORITY(new_csg_prio),
> -					       CSG_EP_REQ_PRIORITY_MASK);
> +			panthor_fw_csg_endpoint_req_update(ptdev, csg_id,
> +							   CSG_EP_REQ_PRIORITY(new_csg_prio),
> +							   CSG_EP_REQ_PRIORITY_MASK);
>  			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
>  						csg_iface->output->ack ^ CSG_ENDPOINT_CONFIG,
>  						CSG_ENDPOINT_CONFIG);


