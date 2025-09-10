Return-Path: <linux-kernel+bounces-811082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E25B52433
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015281BC37AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB98C30CDA8;
	Wed, 10 Sep 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="diTC0lNO"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908123D7C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542994; cv=none; b=VzaPLC2qApcSok7n7FpJ1zykCYxOXBWMBfbLj0/apc810So3/x/bBaJZvyQiv1WM+5rtRCQrxHGZEXtAJeCtMvcUvFmnJ+3uAjU2Z8EwVb/2PPsWwLoH5gE+yPcB0MNdptCz5vVJlggEM3bHeEnDpiXe+DxpiDD46zqrs7rOJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542994; c=relaxed/simple;
	bh=WMQf/PXVNCa8gtyHFsidYdJgCyhdFn6cIr/sgeWExM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD1TWkqj5FHcW6oKPVIFeiBaMF5FUjZ22PXhOeI3kAJQiTrnbAFADhm3uFTAJEM3VfLlg/tdBJVDqJjnkMejrTkiqDzolQzBWam8yo6IvwqdYxmTijXd+JKLHID3+PDP5EXoMcqJz0gNkMNHSf8EjLp6Nq9Es7hX5KdUBR6X5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=diTC0lNO; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <236b2370-4aef-48bc-9f8b-0e37a72f65ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757542989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWQDILI3uBc7hyjxz9WTSmjBYV9NZwtCUxZRwM7aSvw=;
	b=diTC0lNOV4WhltK0jGUCzN8O8l8TtVsaMShDXIR/j+MbNjKgZFFg+pxQe7irLySrKwrzmo
	7HQmy1lfetYjYMpzvvMkaHtb6tlhyzbJGRmq/P0uxEmcOTpoEcfeLCD+ql7xTfT6OkI91k
	rrCNXzWMnXzIWGiIYFYP/uEKhIqz7NU=
Date: Wed, 10 Sep 2025 15:23:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume
To: Mario Limonciello <mario.limonciello@amd.com>, chiahsuan.chung@amd.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, simona@ffwll.ch,
 airlied@gmail.com, sunpeng.li@amd.com
Cc: amd-gfx@lists.freedesktop.org, zaeem.mohamed@amd.com, misyl@froggi.es,
 linux-kernel@vger.kernel.org
References: <20250910212753.3167295-1-matthew.schwartz@linux.dev>
 <53e5cc5d-f220-4e4c-8ee4-159a7d8f329a@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <53e5cc5d-f220-4e4c-8ee4-159a7d8f329a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/10/25 2:32 PM, Mario Limonciello wrote:
> On 9/10/25 4:27 PM, Matthew Schwartz wrote:
>> On clients that utilize AMD_PRIVATE_COLOR properties for HDR support,
>> brightness sliders can include a hardware controlled portion and a
>> gamma-based portion. This is the case on the Steam Deck OLED when using
>> gamescope with Steam as a client.
>>
>> When a user sets a brightness level while HDR is active, the gamma-based
>> portion and/or hardware portion are adjusted to achieve the desired
>> brightness. However, when a modeset takes place while the gamma-based
>> portion is in-use, restoring the hardware brightness level overrides the
>> user's overall brightness level and results in a mismatch between what
>> the slider reports and the display's current brightness.
>>
>> To avoid overriding gamma-based brightness, only restore HW backlight
>> level after boot or resume. This ensures that the backlight level is
>> set correctly after the DC layer resets it while avoiding interference
>> with subsequent modesets.
>>
>> Fixes: 7875afafba84 ("drm/amd/display: Fix brightness level not retained over reboot")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4551
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++--
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 7808a647a306c..3651315760759 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -2037,6 +2037,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>>         dc_hardware_init(adev->dm.dc);
>>   +    adev->dm.restore_backlight = true;
>> +
>>       adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
>>       if (!adev->dm.hpd_rx_offload_wq) {
>>           drm_err(adev_to_drm(adev), "failed to create hpd rx offload workqueue.\n");
>> @@ -3407,6 +3409,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>>           dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>>             dc_resume(dm->dc);
>> +        adev->dm.restore_backlight = true;
>>             amdgpu_dm_irq_resume_early(adev);
>>   @@ -9922,7 +9925,8 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>               acrtc->hw_mode = new_crtc_state->mode;
>>               crtc->hwmode = new_crtc_state->mode;
>>               mode_set_reset_required = true;
>> -            set_backlight_level = true;
>> +            if (dm->restore_backlight)
>> +                set_backlight_level = true;
>>           } else if (modereset_required(new_crtc_state)) {
>>               drm_dbg_atomic(dev,
>>                          "Atomic commit: RESET. crtc id %d:[%p]\n",
>> @@ -9979,13 +9983,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
>>        * to fix a flicker issue.
>>        * It will cause the dm->actual_brightness is not the current panel brightness
>>        * level. (the dm->brightness is the correct panel level)
>> -     * So we set the backlight level with dm->brightness value after set mode
>> +     * So we set the backlight level with dm->brightness value after initial
>> +     * set mode. Use restore_backlight flag to avoid setting backlight level
>> +     * for every subsequent mode set.
>>        */
>>       if (set_backlight_level) {
> 
> Is there really still a need for the local variable in this function 'set_backlight_level'?
> 

No, you're correct and it's a bit cleaner that way. I'll fix this in v2.

> It seems to me with this change you can just use dm->restore_backlight for state tracking at all times.
>>           for (i = 0; i < dm->num_of_edps; i++) {
>>               if (dm->backlight_dev[i])
>>                   amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>>           }
>> +        dm->restore_backlight = false;
>>       }
>>   }
>>   diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index b937da0a4e4a0..6aae51c1beb36 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -610,6 +610,13 @@ struct amdgpu_display_manager {
>>        */
>>       u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>>   +    /**
>> +     * @restore_backlight:
>> +     *
>> +     * Flag to indicate whether to restore backlight after modeset.
>> +     */
>> +    bool restore_backlight;
>> +
>>       /**
>>        * @aux_hpd_discon_quirk:
>>        *
> 


