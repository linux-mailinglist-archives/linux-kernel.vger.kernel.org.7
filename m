Return-Path: <linux-kernel+bounces-797693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73BB413AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161BA547E5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6052D4812;
	Wed,  3 Sep 2025 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVpUk7x8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0585428726D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875153; cv=none; b=GjzRhsAhgzF0sinHoeXKvOX+9BuHVqLqnkMfxENRSzbhOIAProZrT2igY9kpkfTlMDT7pwLCHKAScv9xTKGIGSSEv6QyIIW09C8k64KwffiBaqg0OiY+pJbg0j1LRjIwG9OnoPyPfHnYMTkWrnjvauk+J6/WYdt8aafymN/IhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875153; c=relaxed/simple;
	bh=BCKzT7TXRkg20i227c4L6NJrd8ors1F/jJQkzbZEMoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qwxQ9Kzro2HDTfNjd9UmTYQgRHISjmsRbY3XcYHqLIPCeOVkWB9AyYx2lNNaoXZtPRzYCTD8m4RSPe9xt2LM1tyBk57FGK/2R0sj+X0FRzCZMApYQ6YTF95mB3TuPKxhyegIgIlkX0ur/T6SNZn0pkckLGJJ4+MWQOptbK3XXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVpUk7x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D852C4CEF0;
	Wed,  3 Sep 2025 04:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756875152;
	bh=BCKzT7TXRkg20i227c4L6NJrd8ors1F/jJQkzbZEMoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tVpUk7x8TMvHeqDGBZb3l6GYd6jNpNDxicfYPVhISAMZ6L11ocOSrJcxDT+FrFMCS
	 sPlgPpHG12BO1uKIt8+1SzpNhJdKufGMhqvqbEbZhnn50nZL53UNQaHfgfqbf/vPBB
	 OPAcFKDG/xaj9oXS3i03gUho4vHcH2vaFbWu991TODMNA7jVvWxGg9nuCL6F0IIAzk
	 URxzG/vGtbY3qFzGAyxD/YvzXZnItGNcy/U4EMvnQ6C3n5VGgjXQTgNDgJebCmYSxh
	 OLW4XMz6zrF2UIUDi1YLR6R62081Gfynb2InIV2jYsSORqD2/cSCRkDhyxwz0eMBBq
	 UOwhPj8L7zI3g==
Message-ID: <588626d9-eb27-4376-8741-a1cc2e2e17cf@kernel.org>
Date: Tue, 2 Sep 2025 23:52:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] drm: panel-backlight-quirks: Log applied panel
 brightness quirks
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 philm@manjaro.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20250829145541.512671-1-lkml@antheas.dev>
 <20250829145541.512671-7-lkml@antheas.dev>
 <CAGwozwHaWPwy6_LTvTy4ybdrN27fEXc-GbhYEt4_cM88_VGYPA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwHaWPwy6_LTvTy4ybdrN27fEXc-GbhYEt4_cM88_VGYPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/2025 10:01 AM, Antheas Kapenekakis wrote:
> On Fri, 29 Aug 2025 at 16:57, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> Currently, when a panel brightness quirk is applied, there is no log
>> indicating that a quirk was applied. Unwrap the drm device on its own
>> and use drm_info() to log when a quirk is applied.
>>
>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 263f15f6fdea..2a3e17d83d6e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -3617,13 +3617,15 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>>          struct drm_connector *conn_base;
>>          struct amdgpu_device *adev;
>>          struct drm_luminance_range_info *luminance_range;
>> +       struct drm_device *drm;
>>
>>          if (aconnector->bl_idx == -1 ||
>>              aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
>>                  return;
>>
>>          conn_base = &aconnector->base;
>> -       adev = drm_to_adev(conn_base->dev);
>> +       drm = conn_base->dev;
>> +       adev = drm_to_adev(drm);
>>
>>          caps = &adev->dm.backlight_caps[aconnector->bl_idx];
>>          caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
>> @@ -3659,12 +3661,20 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>>          panel_backlight_quirk =
>>                  drm_get_panel_backlight_quirk(aconnector->drm_edid);
>>          if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
>> -               if (panel_backlight_quirk->min_brightness)
>> +               if (panel_backlight_quirk->min_brightness) {
>> +                       drm_info(drm,
>> +                                "Applying panel backlight quirk, min_brightness: %d\n",
>> +                                panel_backlight_quirk->min_brightness);
> 
> mmm, needs a -1 here
> 

You may as well re-order it too so that you set caps->min_input_signal 
and access it in this message.

>>                          caps->min_input_signal =
>>                                  panel_backlight_quirk->min_brightness - 1;
>> -               if (panel_backlight_quirk->brightness_mask)
>> +               }
>> +               if (panel_backlight_quirk->brightness_mask) {
>> +                       drm_info(drm,
>> +                                "Applying panel backlight quirk, brightness_mask: 0x%X\n",
>> +                                panel_backlight_quirk->brightness_mask);
>>                          caps->brightness_mask =
>>                                  panel_backlight_quirk->brightness_mask;
>> +               }
>>          }
>>   }
>>
>> --
>> 2.51.0
>>
>>
> 


