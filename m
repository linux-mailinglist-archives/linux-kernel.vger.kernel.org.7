Return-Path: <linux-kernel+bounces-786612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5579B35F18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5377A5480
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239EA322A1E;
	Tue, 26 Aug 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="YfPqyL7O"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA73F9CB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211302; cv=none; b=LV19wkMJo/oVe9oe/7X9srm4KKIcZiLk3nFWPII0QcLghlvCrVTs1uWmddkIVW3QR8K/hdLe6QQFdy+jeQrs4ZeQ+JNcJf/Mchv2dUvc3FRLuHkQDxyjFu8j8fYoKNrQsCpMIQxydIaN23lOG2qNd76gpv0THyFL21Z73X026LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211302; c=relaxed/simple;
	bh=Y133KrGcj/pdCk41XYuYo8MbJHiVfeckcg9eEcUJd34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5rCtJ2mQY19o9XKBZKMQWP4t0B3t9GWPfJM1qw9OHpGHH2B3wqq96ubF6dkVdCVWMvlaoV08CneEsbcoYTaQLL8i9ZMiEKs2x5jh+KgcAGGgjTerLeb2RpNDHnLWYmed6dF8YuLxVfyDZs050V6JN/qcQXVSNUndS9dkiTAueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=YfPqyL7O; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <a23c8b0b-ec62-437b-b876-3143f132a901@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1756211291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jfzo9ajTl5pL+DzKVsWq0bNdp3fhVYkJzPkksOiabvA=;
	b=YfPqyL7Oilke1+Ney2mpRJsYsjvaN741LVUQjgnlVsbJBlJk7SPiSixCkqJYQhRTraBpc+
	QBCGVgxQb78/gHIl2aP1aPGesM2BwcKRg0MuxMLMeOdU0j49xn+nmj5TDQB3vjtCwYG6L7
	KY/6wumMLuxwcmwvJlEYb80quSRrMMgkiApm8Ym7FbxPm6m9vi8xRBP1HR/FyFi0fvpCHO
	PNO9Jrc3uHaA3OxSuSUNyaR6s/3G2sG1g9fLjSI5fYmqpplwttXL2A0hdJ8FlI+oFqHkOf
	v4vRG7ZKfixmP1mlAva3wsoR0HE3yGs/to5nY/ZEbB8Tb5BMlbfX+N9CE2p8RQ==
Date: Tue, 26 Aug 2025 14:28:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/5] drm: panel-backlight-quirks: Add brightness mask
 quirk
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250824200202.1744335-1-lkml@antheas.dev>
 <20250824200202.1744335-5-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250824200202.1744335-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 8/24/25 22:02, Antheas Kapenekakis wrote:
> Certain OLED devices malfunction on specific brightness levels.
> Specifically, when DP_SOURCE_BACKLIGHT_LEVEL is written to with
> the first byte being 0x00 and sometimes 0x01, the panel forcibly
> turns off until the device sleeps again.
> 
> Below are some examples. This was found by iterating over brighness
> ranges while printing DP_SOURCE_BACKLIGHT_LEVEL. It was found that
> the screen would malfunction on specific values, and some of them
> were collected. Summary examples are found below.
> 
> This quirk was tested by removing the workarounds and iterating
> from 0 to 50_000 value ranges with a cadence of 0.2s/it. The
> range of the panel is 1000...400_000, so the values were slightly
> interpolated during testing. The custom brightness curve added on
> 6.15 was disabled.
> 
>   86016:  10101000000000000
>   86272:  10101000100000000
>   87808:  10101011100000000
> 251648: 111101011100000000
> 251649: 111101011100000001
> 
>   86144:  10101000010000000
>   87809:  10101011100000001
> 251650: 111101011100000010
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3803
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
>   drivers/gpu/drm/drm_panel_backlight_quirks.c  | 29 +++++++++++++++++++
>   include/drm/drm_utils.h                       |  1 +
>   4 files changed, 43 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4ad80ae615a2..156f2aae6828 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3662,6 +3662,9 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>   		if (panel_backlight_quirk->min_brightness)
>   			caps->min_input_signal =
>   				panel_backlight_quirk->min_brightness - 1;
> +		if (panel_backlight_quirk->brightness_mask)
> +			caps->brightness_mask =
> +				panel_backlight_quirk->brightness_mask;
>   	}
>   }
>   
> @@ -4862,6 +4865,10 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
>   	link = (struct dc_link *)dm->backlight_link[bl_idx];
>   
> +	/* Apply brightness quirk */
> +	if (caps->brightness_mask)
> +		brightness |= caps->brightness_mask;
> +
>   	/* Change brightness based on AUX property */
>   	mutex_lock(&dm->dc_lock);
>   	if (dm->dc->caps.ips_support && dm->dc->ctx->dmub_srv->idle_allowed) {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index b937da0a4e4a..340f9b5f68eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -200,6 +200,12 @@ struct amdgpu_dm_backlight_caps {
>   	 * @aux_support: Describes if the display supports AUX backlight.
>   	 */
>   	bool aux_support;
> +	/**
> +	 * @brightness_mask: After deriving brightness, or it with this mask.
> +	 * This is used to workaround panels that have issues with certain
> +	 * brightness values.
> +	 */
> +	u32 brightness_mask;
>   	/**
>   	 * @ac_level: the default brightness if booted on AC
>   	 */
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index 3d386a96e50e..78c430b07d6a 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -45,6 +45,35 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
>   		.ident.name = "NE135A1M-NY1",
>   		.quirk = { .min_brightness = 1, },
>   	},
> +	/* Have OLED Panels with brightness issue when last byte is 0/1 */
> +	{
> +		.dmi_match.field = DMI_SYS_VENDOR,
> +		.dmi_match.value = "AYANEO",
> +		.dmi_match_other.field = DMI_PRODUCT_NAME,
> +		.dmi_match_other.value = "AYANEO 3",
> +		.quirk = { .brightness_mask = 3, },
> +	},
> +	{
> +		.dmi_match.field = DMI_SYS_VENDOR,
> +		.dmi_match.value = "ZOTAC",
> +		.dmi_match_other.field = DMI_BOARD_NAME,
> +		.dmi_match_other.value = "G0A1W",
> +		.quirk = { .brightness_mask = 3, },
> +	},
> +	{
> +		.dmi_match.field = DMI_SYS_VENDOR,
> +		.dmi_match.value = "ONE-NETBOOK",
> +		.dmi_match_other.field = DMI_PRODUCT_NAME,
> +		.dmi_match_other.value = "ONEXPLAYER F1Pro",
> +		.quirk = { .brightness_mask = 3, },
> +	},
> +	{
> +		.dmi_match.field = DMI_SYS_VENDOR,
> +		.dmi_match.value = "ONE-NETBOOK",
> +		.dmi_match_other.field = DMI_PRODUCT_NAME,
> +		.dmi_match_other.value = "ONEXPLAYER F1 EVA-02",
> +		.quirk = { .brightness_mask = 3, },
> +	}
>   };
>   
>   static bool drm_panel_min_backlight_quirk_matches(
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 82eeee4a58ab..6a46f755daba 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -18,6 +18,7 @@ int drm_get_panel_orientation_quirk(int width, int height);
>   
>   struct drm_panel_backlight_quirk {
>   	u16 min_brightness;
> +	u32 brightness_mask;
>   };
>   
>   const struct drm_panel_backlight_quirk *

Tested-by: Philip Müller <philm@manjaro.org>

