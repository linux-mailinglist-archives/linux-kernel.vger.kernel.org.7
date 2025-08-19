Return-Path: <linux-kernel+bounces-776150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08460B2C93C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA93C5264EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CED2BF3DF;
	Tue, 19 Aug 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="BanKLWnl"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546602C11DF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755619903; cv=none; b=a9XsSCK9QcAEOMvBp7bvvyUZrgp7xOurdkWxFPBz7JPmok+937hZmTF6gjh3orqmjhut1mKRMaedtSRWbzdrtUC3Pn9/t6Wqpj30q4I/H/U8i0H/d2c/aQLu7KbhaxRT+Qwr4HMRCB4gKl5rhan0vAmPTN89cuWWmz3zdI5jtQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755619903; c=relaxed/simple;
	bh=mQJlvDiUEBsg/y30gdLbfnVp5WFEoDCYRfMVK6fuACY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGZg1SH5e/mNicv1tF12RTNZObzOgciMannQm4YlmSpovFeRsTX8qtUtiQSPh5fRpjFA475pqIfcamigtZEPlabTxeR+zBp60eUL+1QXwlIwwlYciLghXnXb9K98uPdmHLh8Bbv4lb1FyyTnJKYpFkb5VnwGsKPSxBkZ8Y5vkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=BanKLWnl; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 692F22FC004A;
	Tue, 19 Aug 2025 18:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1755619583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocZzn9STe9dmiXLwNvbkK95isQkWTQtWXaYugDd7GpM=;
	b=BanKLWnl8G0mfurW6wcu8si6Ytt/7qzwgJa/CghedbQtuPPCN3HybgwM5GzQmGMZ65Y3ze
	c8wwKehkROfDqJE8oLFc/lum6vX0DmXBz0MwzGQHbTGH3jeXMaFtH7T1D/5f5maCNAe87k
	bU7KrhDayCqBX66OtRefxPHq1Eaw+1o=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <70ae970e-4697-4e73-8fa5-45b1d7569454@tuxedocomputers.com>
Date: Tue, 19 Aug 2025 18:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: Add quirk to force backlight type on
 some TUXEDO devices
To: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250409163029.130651-1-wse@tuxedocomputers.com>
 <20250409163029.130651-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20250409163029.130651-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 09.04.25 um 18:27 schrieb Werner Sembach:
> The display backlight on TUXEDO Polaris AMD Gen2 and Gen3 with panels
> BOE 2420 and BOE 2423 must be forced to pwn controlled to be able to
> control the brightness.
>
> This could already be archived via a module parameter, but this patch adds
> a quirk to apply this by default on the mentioned device + panel
> combinations.
Just to let you know: this fix seems to be no longer required, at least with 
6.14 onwards (and maybe before that we didn't test further back)
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 39df45f652b32..2bad6274ad8ff 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1625,11 +1625,13 @@ static bool dm_should_disable_stutter(struct pci_dev *pdev)
>   struct amdgpu_dm_quirks {
>   	bool aux_hpd_discon;
>   	bool support_edp0_on_dp1;
> +	bool boe_2420_2423_bl_force_pwm;
>   };
>   
>   static struct amdgpu_dm_quirks quirk_entries = {
>   	.aux_hpd_discon = false,
> -	.support_edp0_on_dp1 = false
> +	.support_edp0_on_dp1 = false,
> +	.boe_2420_2423_bl_force_pwm = false
>   };
>   
>   static int edp0_on_dp1_callback(const struct dmi_system_id *id)
> @@ -1644,6 +1646,12 @@ static int aux_hpd_discon_callback(const struct dmi_system_id *id)
>   	return 0;
>   }
>   
> +static int boe_2420_2423_bl_force_pwm_callback(const struct dmi_system_id *id)
> +{
> +	quirk_entries.boe_2420_2423_bl_force_pwm = true;
> +	return 0;
> +}
> +
>   static const struct dmi_system_id dmi_quirk_table[] = {
>   	{
>   		.callback = aux_hpd_discon_callback,
> @@ -1722,6 +1730,20 @@ static const struct dmi_system_id dmi_quirk_table[] = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 665 16 inch G11 Notebook PC"),
>   		},
>   	},
> +	{
> +		// TUXEDO Polaris AMD Gen2
> +		.callback = boe_2420_2423_bl_force_pwm_callback,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GMxNGxx"),
> +		},
> +	},
> +	{
> +		// TUXEDO Polaris AMD Gen3
> +		.callback = boe_2420_2423_bl_force_pwm_callback,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_NAME, "GMxZGxx"),
> +		},
> +	},
>   	{}
>   	/* TODO: refactor this from a fixed table to a dynamic option */
>   };
> @@ -3586,6 +3608,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>   	struct amdgpu_device *adev;
>   	struct drm_luminance_range_info *luminance_range;
>   	int min_input_signal_override;
> +	u32 panel;
>   
>   	if (aconnector->bl_idx == -1 ||
>   	    aconnector->dc_link->connector_signal != SIGNAL_TYPE_EDP)
> @@ -3610,6 +3633,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
>   		caps->aux_support = false;
>   	else if (amdgpu_backlight == 1)
>   		caps->aux_support = true;
> +	else if (amdgpu_backlight == -1 &&
> +		 quirk_entries.boe_2420_2423_bl_force_pwm) {
> +		panel = drm_edid_get_panel_id(aconnector->drm_edid);
> +		if (panel == drm_edid_encode_panel_id('B', 'O', 'E', 0x0974) ||
> +		    panel == drm_edid_encode_panel_id('B', 'O', 'E', 0x0977))
> +			caps->aux_support = false;
> +	}
>   	if (caps->aux_support)
>   		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
>   

