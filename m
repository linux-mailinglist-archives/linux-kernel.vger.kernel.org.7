Return-Path: <linux-kernel+bounces-890238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05391C3F959
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E4E4EF0F2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B6031B110;
	Fri,  7 Nov 2025 10:50:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404C31AF34
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512646; cv=none; b=URQAGJiYmtHOiGXMJHH1bcYanlbuwLH5IUsOT7cfTXucKCLbCcQtYT5+5BHQztwzUlh9KT9C+DmqZWMRmEDuRSK4Apz2Lfa+3KE+ArljB6Vmz3VTpsipo+tVXB2EL286AxxOo/54NwVaFZR+my8bB1vYezk2nPbIjRv/+00hi1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512646; c=relaxed/simple;
	bh=+/m04TnDfPvyNyXnqPa/HmB4QubNr+ajwU51r3FHblU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V5/7aQ4bkSWb8Nc3MPLhjJY0u7VA/sPcZTUOdJFyNwLB4JxqA+irty16ijFwXos8BFEe5B4kgB1gDF3ASWymcFZGusS1MNk7+oi0AMFikyO2JeOgwd50g9FOTdfeI0fqf1LG+kbH4HKitSvCLTpy0iQMBBH9BjKm3k8IDhJG7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF91E1516;
	Fri,  7 Nov 2025 02:50:35 -0800 (PST)
Received: from [10.57.72.216] (unknown [10.57.72.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664863F66E;
	Fri,  7 Nov 2025 02:50:41 -0800 (PST)
Message-ID: <90dd78f8-6128-42bf-9c52-6ea8b600203a@arm.com>
Date: Fri, 7 Nov 2025 10:50:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] drm/panthor: Support GLB_REQ.STATE field for
 Mali-G1 GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251027161334.854650-1-karunika.choo@arm.com>
 <20251027161334.854650-7-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251027161334.854650-7-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 16:13, Karunika Choo wrote:
> Add support for the GLB_REQ.STATE field introduced in CSF v4.1+, which
> replaces the HALT bit to provide finer control over the MCU state. This
> change implements basic handling for transitioning the MCU between
> ACTIVE and HALT states on Mali-G1 GPUs.
> 
> The update introduces new helpers to issue the state change requests,
> poll for MCU halt completion, and restore the MCU to an active state
> after halting.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> v3:
>  * Fixed missed CSF_IFACE_VERSION check with pathor_fw_has_glb_state().
> v2:
>  * Reduced MCU_HALT_TIMEOUT_US to 1 second.
>  * Wrap the CSG_IFACE_VERSION checks for v4.1.0 with
>    panthor_fw_has_glb_state().
>  * Removed use of undefined panthor_fw_csf_version() MACRO.
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 89 +++++++++++++++++++++++-----
>  drivers/gpu/drm/panthor/panthor_fw.h |  7 +++
>  2 files changed, 80 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index e6c39c70d348..fb1f69ef76fb 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -33,6 +33,7 @@
>  #define PROGRESS_TIMEOUT_SCALE_SHIFT		10
>  #define IDLE_HYSTERESIS_US			800
>  #define PWROFF_HYSTERESIS_US			10000
> +#define MCU_HALT_TIMEOUT_US			(1ULL * USEC_PER_SEC)
> 
>  /**
>   * struct panthor_fw_binary_hdr - Firmware binary header.
> @@ -317,6 +318,13 @@ panthor_fw_get_cs_iface(struct panthor_device *ptdev, u32 csg_slot, u32 cs_slot)
>  	return &ptdev->fw->iface.streams[csg_slot][cs_slot];
>  }
> 
> +static bool panthor_fw_has_glb_state(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +
> +	return glb_iface->control->version >= CSF_IFACE_VERSION(4, 1, 0);
> +}
> +
>  /**
>   * panthor_fw_conv_timeout() - Convert a timeout into a cycle-count
>   * @ptdev: Device.
> @@ -996,6 +1004,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  					 GLB_IDLE_EN |
>  					 GLB_IDLE;
> 
> +	if (panthor_fw_has_glb_state(ptdev))
> +		glb_iface->input->ack_irq_mask |= GLB_STATE_MASK;
> +
>  	panthor_fw_update_reqs(glb_iface, req, GLB_IDLE_EN, GLB_IDLE_EN);
>  	panthor_fw_toggle_reqs(glb_iface, req, ack,
>  			       GLB_CFG_ALLOC_EN |
> @@ -1069,6 +1080,54 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
>  		drm_err(&ptdev->base, "Failed to stop MCU");
>  }
> 
> +static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +	bool halted;
> +
> +	halted = gpu_read(ptdev, MCU_STATUS) == MCU_STATUS_HALT;
> +
> +	if (panthor_fw_has_glb_state(ptdev))
> +		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
> +
> +	return halted;
> +}
> +
> +static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +
> +	if (panthor_fw_has_glb_state(ptdev))
> +		panthor_fw_update_reqs(glb_iface, req, GLB_STATE(GLB_STATE_HALT), GLB_STATE_MASK);
> +	else
> +		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
> +
> +	gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> +}
> +
> +static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
> +{
> +	bool halted = false;
> +
> +	if (read_poll_timeout_atomic(panthor_fw_mcu_halted, halted, halted, 10,
> +				     MCU_HALT_TIMEOUT_US, 0, ptdev)) {
> +		drm_warn(&ptdev->base, "Timed out waiting for MCU to halt");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void panthor_fw_mcu_set_active(struct panthor_device *ptdev)
> +{
> +	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> +
> +	if (panthor_fw_has_glb_state(ptdev))
> +		panthor_fw_update_reqs(glb_iface, req, GLB_STATE(GLB_STATE_ACTIVE), GLB_STATE_MASK);
> +	else
> +		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> +}
> +
>  /**
>   * panthor_fw_pre_reset() - Call before a reset.
>   * @ptdev: Device.
> @@ -1085,19 +1144,13 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  	ptdev->reset.fast = false;
> 
>  	if (!on_hang) {
> -		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> -		u32 status;
> -
> -		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
> -		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> -		if (!gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
> -					   status == MCU_STATUS_HALT, 10,
> -					   100000)) {
> -			ptdev->reset.fast = true;
> -		} else {
> +		panthor_fw_halt_mcu(ptdev);
> +		if (!panthor_fw_wait_mcu_halted(ptdev))
>  			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
> -		}
> +		else
> +			ptdev->reset.fast = true;
>  	}
> +	panthor_fw_stop(ptdev);
> 
>  	panthor_job_irq_suspend(&ptdev->fw->irq);
>  }
> @@ -1125,14 +1178,14 @@ int panthor_fw_post_reset(struct panthor_device *ptdev)
>  		 */
>  		panthor_reload_fw_sections(ptdev, true);
>  	} else {
> -		/* The FW detects 0 -> 1 transitions. Make sure we reset
> -		 * the HALT bit before the FW is rebooted.
> +		/*
> +		 * If the FW was previously successfully halted in the pre-reset
> +		 * operation, we need to transition it to active again before
> +		 * the FW is rebooted.
>  		 * This is not needed on a slow reset because FW sections are
>  		 * re-initialized.
>  		 */
> -		struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
> -
> -		panthor_fw_update_reqs(glb_iface, req, 0, GLB_HALT);
> +		panthor_fw_mcu_set_active(ptdev);
>  	}
> 
>  	ret = panthor_fw_start(ptdev);
> @@ -1170,6 +1223,10 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  		if (ptdev->fw->irq.irq)
>  			panthor_job_irq_suspend(&ptdev->fw->irq);
> 
> +		panthor_fw_halt_mcu(ptdev);
> +		if (!panthor_fw_wait_mcu_halted(ptdev))
> +			drm_warn(&ptdev->base, "Failed to halt MCU on unplug");
> +
>  		panthor_fw_stop(ptdev);
>  	}
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
> index 6598d96c6d2a..a19ed48b2d0b 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw.h
> @@ -214,6 +214,13 @@ struct panthor_fw_global_input_iface {
>  #define GLB_FWCFG_UPDATE			BIT(9)
>  #define GLB_IDLE_EN				BIT(10)
>  #define GLB_SLEEP				BIT(12)
> +#define GLB_STATE_MASK				GENMASK(14, 12)
> +#define   GLB_STATE_ACTIVE			0
> +#define   GLB_STATE_HALT			1
> +#define   GLB_STATE_SLEEP			2
> +#define   GLB_STATE_SUSPEND			3
> +#define   GLB_STATE(x)				(((x) << 12) & GLB_STATE_MASK)
> +#define   GLB_STATE_GET(x)			(((x) & GLB_STATE_MASK) >> 12)
>  #define GLB_INACTIVE_COMPUTE			BIT(20)
>  #define GLB_INACTIVE_FRAGMENT			BIT(21)
>  #define GLB_INACTIVE_TILER			BIT(22)
> --
> 2.49.0
> 


