Return-Path: <linux-kernel+bounces-798981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A60B42581
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C60F3BD0AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D97C2417E6;
	Wed,  3 Sep 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJkHJfIl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64481240611
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913370; cv=none; b=lcSTrAVEWNS2qyfC+/snHf4mSqCZ/nG5wEYwmpO5hdKUu2VuPmOdb6lOFq9n+80BvIIw24gvKTVOhhxUpq6a7nZpVK4TA62XgLmsNXG6wkUkUoQt026M5XJbMWEmHE8bQSLaQTD4Jat6cPps2H0rZOjECjOSHDl/d5UlVpChLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913370; c=relaxed/simple;
	bh=ztrictOOXdKIOkZOv0vYw2oH6HTP2dFEhJNp2iYtftY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb9PbSrGaqbMGS5e8G2TVHamdyavkB1ZPy+VczOE04ddY4CcRztDdPblHMQBmQpySafTmqpHHHKtKdEiVdP3g6N7RkBn59p+pi8ypgBilFlbbmk6zfEsHQmH4BGrTRhabk5R+pPhdJwp6Yvg8TyWgesTrVNNlWDMeFLw/JHKuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJkHJfIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59403C4CEE7;
	Wed,  3 Sep 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913369;
	bh=ztrictOOXdKIOkZOv0vYw2oH6HTP2dFEhJNp2iYtftY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tJkHJfIlL+zKnBEtSDv4HCm/ViYjPOBC8zlDC7w2Srb3VZIA2c0Z8ev4XTcN+TfnW
	 IGYL3t7dn+F4Uj+pUrzRnJDy5QnsYQKS9bLPSppvDTFwjCrTdEt7g/6pdIp5OXOaMt
	 bk1d2aniL4RBlyGafV3k5qOQsm+JcXMrhtpS+ZrqvrYgzHy1/OLBX3RXzUF9kieg4/
	 v92qiGfbvefKM1DRSFR/Fxm8t6UczfgA75Hyd9/fjHi+XAmUhteNhsLVh/Sk8RcFBI
	 FcuxaSxKaKvTZZq3YzxVXgmOo1f/sHCbeJGvRcmbYfjP4JT7xJFdv7DvFSAvMC9DHk
	 0iXpPf8wd6TOw==
Message-ID: <f5581961-2e47-4cd4-86e9-47ec37f71c06@kernel.org>
Date: Wed, 3 Sep 2025 10:29:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] drm: panel-backlight-quirks: Log applied panel
 brightness quirks
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "philm@manjaro.org" <philm@manjaro.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20250829145541.512671-1-lkml@antheas.dev>
 <20250829145541.512671-7-lkml@antheas.dev>
 <CAGwozwHaWPwy6_LTvTy4ybdrN27fEXc-GbhYEt4_cM88_VGYPA@mail.gmail.com>
 <588626d9-eb27-4376-8741-a1cc2e2e17cf@kernel.org>
 <BL1PR12MB5144E131D87B8B6584CF297DF701A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <BL1PR12MB5144E131D87B8B6584CF297DF701A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/25 10:03 AM, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Mario Limonciello <superm1@kernel.org>
>> Sent: Wednesday, September 3, 2025 12:53 AM
>> To: Antheas Kapenekakis <lkml@antheas.dev>; amd-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org;
>> philm@manjaro.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
>> Christian <Christian.Koenig@amd.com>; Robert Beckett
>> <bob.beckett@collabora.com>
>> Subject: Re: [PATCH v3 6/6] drm: panel-backlight-quirks: Log applied panel
>> brightness quirks
>>
>> On 8/29/2025 10:01 AM, Antheas Kapenekakis wrote:
>>> On Fri, 29 Aug 2025 at 16:57, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>
>>>> Currently, when a panel brightness quirk is applied, there is no log
>>>> indicating that a quirk was applied. Unwrap the drm device on its own
>>>> and use drm_info() to log when a quirk is applied.
>>>>
>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Besides the one thing you identified this looks fine to me.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>>>> ---
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++++---
>>>>    1 file changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 263f15f6fdea..2a3e17d83d6e 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -3617,13 +3617,15 @@ static void update_connector_ext_caps(struct
>> amdgpu_dm_connector *aconnector)
>>>>           struct drm_connector *conn_base;
>>>>           struct amdgpu_device *adev;
>>>>           struct drm_luminance_range_info *luminance_range;
>>>> +       struct drm_device *drm;
>>>>
>>>>           if (aconnector->bl_idx == -1 ||
>>>>               aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
>>>>                   return;
>>>>
>>>>           conn_base = &aconnector->base;
>>>> -       adev = drm_to_adev(conn_base->dev);
>>>> +       drm = conn_base->dev;
>>>> +       adev = drm_to_adev(drm);
>>>>
>>>>           caps = &adev->dm.backlight_caps[aconnector->bl_idx];
>>>>           caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
>>>> @@ -3659,12 +3661,20 @@ static void update_connector_ext_caps(struct
>> amdgpu_dm_connector *aconnector)
>>>>           panel_backlight_quirk =
>>>>                   drm_get_panel_backlight_quirk(aconnector->drm_edid);
>>>>           if (!IS_ERR_OR_NULL(panel_backlight_quirk)) {
>>>> -               if (panel_backlight_quirk->min_brightness)
>>>> +               if (panel_backlight_quirk->min_brightness) {
>>>> +                       drm_info(drm,
>>>> +                                "Applying panel backlight quirk, min_brightness: %d\n",
>>>> +
>>>> + panel_backlight_quirk->min_brightness);
>>>
>>> mmm, needs a -1 here
>>>
>>
>> You may as well re-order it too so that you set caps->min_input_signal and access
>> it in this message.
>>
> 
> With that fixed up, the series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> 

I've added a manual fixup for that change in the last patch and pushed 
the series to drm-misc-next.

a3ae3384be770 (HEAD -> drm-misc-next, drm-misc/for-linux-next, 
drm-misc/drm-misc-next) drm: panel-backlight-quirks: Log applied panel 
brightness quirks
bf0365b005d9a drm: panel-backlight-quirks: Add Steam Deck brightness quirk
aef10b1138e99 drm: panel-backlight-quirks: Add brightness mask quirk
f7033fab81d82 drm: panel-backlight-quirks: Add secondary DMI match
6eee1ef9e5985 drm: panel-backlight-quirks: Convert brightness quirk to 
generic structure
9931e4be11f21 drm: panel-backlight-quirks: Make EDID match optional

