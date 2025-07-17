Return-Path: <linux-kernel+bounces-735151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43231B08B82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9676B1AA3988
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD41DE8A3;
	Thu, 17 Jul 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="suuWglo4"
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED721BD01D;
	Thu, 17 Jul 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750307; cv=none; b=pHJerUN4+DVI/YNLEuyiA48qSrlk7Q757NLQV03y8QSBjTjNbRH50hNhsG57DjiKMClb1gOG2Y2c4NOBf9/g6WeUzd4pySZDZ2vUaWKHQLpiqkYoohsu2hRQtl1BBH0vCbJ9zMC6jUQaiFf+tX4FvUcJ9zqz+ahnf9BRAQEqzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750307; c=relaxed/simple;
	bh=A8lVAR8D0EwqtMpOgHr0Ol7tGNrtbmaE5fNl1nxKq5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E6G+lJAIxhD7ttAxcYW4dlJjTjVgDZ4V4/1Q0S6QFeybpo10t3f9SDBIVx7PxlxkKNbNsaN4Lfkg6pcOM4wlokv3pY/w0Wciok1Imu/IFqHAneIPIBHBq+N9CciScoTjPIG98uPLAizK91AGSK5lLsAjbtHcRgkZcXc/ETuKC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (1024-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=suuWglo4; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id E38BB6002C15;
	Thu, 17 Jul 2025 11:58:40 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id aYCewej4zTaz; Thu, 17 Jul 2025 11:58:38 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id D191960029A6;
	Thu, 17 Jul 2025 11:58:37 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail; t=1752749918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKY+FE+Wgvh9peRmK8GsaYN7926ab2iXaTwFJhTqn88=;
	b=suuWglo4cKkF0ZMJhwKAt69jnqanYzI3q2ub+mtUeouIAQR80inOihxc0b7uhxO8EBbh7n
	65Gr8kteF3U+OfJeWHp/8VOQxKzhruNl/vfmgPA8UOEeYon6Zf/KLabH91jJdrPhTO+GW4
	EVqXSYcKipyamShclFV4l7+nRERJhU8=
Received: from [10.78.70.101] (unknown [87.58.94.217])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 94D87360061;
	Thu, 17 Jul 2025 11:58:35 +0100 (WEST)
Message-ID: <a387562c-b35e-4268-ab77-402e87db5567@tecnico.ulisboa.pt>
Date: Thu, 17 Jul 2025 11:58:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/panel: jdi-lpm102a188a: Fix bug and clean up
 driver
To: Brigham Campbell <me@brighamcampbell.com>, dianders@chromium.org,
 tejasvipin76@gmail.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250717065757.246122-1-me@brighamcampbell.com>
 <20250717065757.246122-3-me@brighamcampbell.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <20250717065757.246122-3-me@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brigham, thanks for the patch! The code looks a lot cleaner.
Some review follows.

On 7/17/25 7:57 AM, Brigham Campbell wrote:
> Fix bug in unprepare() which causes the function's return value to be
> that of the last mipi "enter sleep mode" command.
> 
> Update driver to use the "multi" variant of MIPI functions in order to
> facilitate improved error handling and remove the panel's dependency on
> deprecated MIPI functions.
> 
> Use the new mipi_dsi_dual macro to reduce code duplication.
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>   drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 187 ++++++------------
>   1 file changed, 55 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> index 5b5082efb282..b72b6518a090 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> @@ -81,25 +81,25 @@ static int jdi_panel_disable(struct drm_panel *panel)
>   static int jdi_panel_unprepare(struct drm_panel *panel)
>   {
>   	struct jdi_panel *jdi = to_panel_jdi(panel);
> -	int ret;
>   
> -	ret = mipi_dsi_dcs_set_display_off(jdi->link1);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", ret);
> +	/*
> +	 * One context per panel since we'll continue trying to shut down the
> +	 * other panel even if one isn't responding.
> +	 */
> +	struct mipi_dsi_multi_context dsi_ctx1 = { .dsi = jdi->link1 };
> +	struct mipi_dsi_multi_context dsi_ctx2 = { .dsi = jdi->link2 };
>   
> -	ret = mipi_dsi_dcs_set_display_off(jdi->link2);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", ret);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx1);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx2);
>   
>   	/* Specified by JDI @ 50ms, subject to change */
>   	msleep(50);
>   
> -	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link1);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
> -	ret = mipi_dsi_dcs_enter_sleep_mode(jdi->link2);
> -	if (ret < 0)
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", ret);
> +	/* Doesn't hurt to try sleep mode even if display off fails */
> +	dsi_ctx1.accum_err = 0;
> +	dsi_ctx2.accum_err = 0;
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx1);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx2);
>   
>   	/* Specified by JDI @ 150ms, subject to change */
>   	msleep(150);
> @@ -123,72 +123,47 @@ static int jdi_panel_unprepare(struct drm_panel *panel)
>   	/* Specified by JDI @ 20ms, subject to change */
>   	msleep(20);
>   
> -	return ret;
> +	return 0;
>   }
>   
> -static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
> +static void jdi_setup_symmetrical_split(struct mipi_dsi_multi_context *dsi_ctx,
> +				       struct mipi_dsi_device *left,
>   				       struct mipi_dsi_device *right,
>   				       const struct drm_display_mode *mode)

Nit: align the indentation of the function arguments, here and in the 
following function.

>   {
> -	int err;
> -
> -	err = mipi_dsi_dcs_set_column_address(left, 0, mode->hdisplay / 2 - 1);
> -	if (err < 0) {
> -		dev_err(&left->dev, "failed to set column address: %d\n", err);
> -		return err;
> -	}
> -
> -	err = mipi_dsi_dcs_set_column_address(right, 0, mode->hdisplay / 2 - 1);
> -	if (err < 0) {
> -		dev_err(&right->dev, "failed to set column address: %d\n", err);
> -		return err;
> -	}
> -
> -	err = mipi_dsi_dcs_set_page_address(left, 0, mode->vdisplay - 1);
> -	if (err < 0) {
> -		dev_err(&left->dev, "failed to set page address: %d\n", err);
> -		return err;
> -	}
> -
> -	err = mipi_dsi_dcs_set_page_address(right, 0, mode->vdisplay - 1);
> -	if (err < 0) {
> -		dev_err(&right->dev, "failed to set page address: %d\n", err);
> -		return err;
> -	}
> -
> -	return 0;
> +	mipi_dsi_dual(mipi_dsi_dcs_set_column_address_multi,
> +			left, right, dsi_ctx,
> +			0, mode->hdisplay / 2 - 1);
> +	mipi_dsi_dual(mipi_dsi_dcs_set_page_address_multi,
> +			left, right, dsi_ctx,
> +			0, mode->vdisplay - 1);

Nit: align the indentation of the function arguments, here and in the 
following function calls.

>   }
>   
> -static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
> +static void jdi_write_dcdc_registers(struct mipi_dsi_multi_context *dsi_ctx,
> +				    struct jdi_panel *jdi)
>   {
>   	/* Clear the manufacturer command access protection */
> -	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
> -				   MCS_CMD_ACS_PROT_OFF);
> -	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
> -				   MCS_CMD_ACS_PROT_OFF);
> +	mipi_dsi_dual(mipi_dsi_generic_write_seq_multi,
> +			jdi->link1, jdi->link2, dsi_ctx,
> +			MCS_CMD_ACS_PROT, MCS_CMD_ACS_PROT_OFF);
>   	/*
> -	 * Change the VGH/VGL divide rations to move the noise generated by the
> +	 * Change the VGH/VGL divide ratios to move the noise generated by the
>   	 * TCONN. This should hopefully avoid interaction with the backlight
>   	 * controller.
>   	 */
> -	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
> -				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
> -				   MCS_PWR_CTRL_PARAM1_DEFAULT,
> -				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
> -				   MCS_PWR_CTRL_PARAM2_DEFAULT);
> -
> -	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
> -				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
> -				   MCS_PWR_CTRL_PARAM1_DEFAULT,
> -				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
> -				   MCS_PWR_CTRL_PARAM2_DEFAULT);
> -
> -	return 0;
> +	mipi_dsi_dual(mipi_dsi_generic_write_seq_multi,
> +			jdi->link1, jdi->link2, dsi_ctx,
> +			MCS_PWR_CTRL_FUNC,
> +			MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
> +			MCS_PWR_CTRL_PARAM1_DEFAULT,
> +			MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
> +			MCS_PWR_CTRL_PARAM2_DEFAULT);
>   }
>   
>   static int jdi_panel_prepare(struct drm_panel *panel)
>   {
>   	struct jdi_panel *jdi = to_panel_jdi(panel);
> +	struct mipi_dsi_multi_context dsi_ctx;

Here we need dsi_ctx = { .accum_err = 0 }; since by not initializing any
field of dsi_ctx we can't rely on accum_error being init'ed to 0.

>   	int err;
>   
>   	/* Disable backlight to avoid showing random pixels
> @@ -231,88 +206,36 @@ static int jdi_panel_prepare(struct drm_panel *panel)
>   	 * put in place to communicate the configuration back to the DSI host
>   	 * controller.
>   	 */
> -	err = jdi_setup_symmetrical_split(jdi->link1, jdi->link2,
> +	jdi_setup_symmetrical_split(&dsi_ctx, jdi->link1, jdi->link2,
>   					  jdi->mode);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set up symmetrical split: %d\n",
> -			err);
> -		goto poweroff;
> -	}
>   
> -	err = mipi_dsi_dcs_set_tear_scanline(jdi->link1,
> -					     jdi->mode->vdisplay - 16);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
> -		goto poweroff;
> -	}
> +	mipi_dsi_dual(mipi_dsi_dcs_set_tear_scanline_multi,
> +			jdi->link1, jdi->link2, &dsi_ctx,
> +			jdi->mode->vdisplay - 16);
>   
> -	err = mipi_dsi_dcs_set_tear_scanline(jdi->link2,
> -					     jdi->mode->vdisplay - 16);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set tear scanline: %d\n", err);
> -		goto poweroff;
> -	}
> +	mipi_dsi_dual(mipi_dsi_dcs_set_tear_on_multi,
> +			jdi->link1, jdi->link2, &dsi_ctx,
> +			MIPI_DSI_DCS_TEAR_MODE_VBLANK);
>   
> -	err = mipi_dsi_dcs_set_tear_on(jdi->link1,
> -				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set tear on: %d\n", err);
> -		goto poweroff;
> -	}
> +	mipi_dsi_dual(mipi_dsi_dcs_set_pixel_format_multi,
> +			jdi->link1, jdi->link2, &dsi_ctx,
> +			MIPI_DCS_PIXEL_FMT_24BIT);
>   
> -	err = mipi_dsi_dcs_set_tear_on(jdi->link2,
> -				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set tear on: %d\n", err);
> -		goto poweroff;
> -	}
> +	mipi_dsi_dual(mipi_dsi_dcs_exit_sleep_mode_multi,
> +			jdi->link1, jdi->link2, &dsi_ctx);
>   
> -	err = mipi_dsi_dcs_set_pixel_format(jdi->link1, MIPI_DCS_PIXEL_FMT_24BIT);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
> -		goto poweroff;
> -	}
> -
> -	err = mipi_dsi_dcs_set_pixel_format(jdi->link2, MIPI_DCS_PIXEL_FMT_24BIT);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set pixel format: %d\n", err);
> -		goto poweroff;
> -	}
> -
> -	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link1);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
> -		goto poweroff;
> -	}
> -
> -	err = mipi_dsi_dcs_exit_sleep_mode(jdi->link2);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to exit sleep mode: %d\n", err);
> -		goto poweroff;
> -	}
> -
> -	err = jdi_write_dcdc_registers(jdi);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to write dcdc registers: %d\n", err);
> -		goto poweroff;
> -	}
> +	jdi_write_dcdc_registers(&dsi_ctx, jdi);
>   	/*
> -	 * We need to wait 150ms between mipi_dsi_dcs_exit_sleep_mode() and
> -	 * mipi_dsi_dcs_set_display_on().
> +	 * We need to wait 150ms between mipi_dsi_dcs_exit_sleep_mode_multi()
> +	 * and mipi_dsi_dcs_set_display_on_multi().
>   	 */
> -	msleep(150);
> +	mipi_dsi_msleep(&dsi_ctx, 150);
>   
> -	err = mipi_dsi_dcs_set_display_on(jdi->link1);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set display on: %d\n", err);
> -		goto poweroff;
> -	}
> +	mipi_dsi_dual(mipi_dsi_dcs_set_display_on_multi,
> +			jdi->link1, jdi->link2, &dsi_ctx);
>   
> -	err = mipi_dsi_dcs_set_display_on(jdi->link2);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to set display on: %d\n", err);
> +	if (dsi_ctx.accum_err < 0)
>   		goto poweroff;
> -	}
>   
>   	jdi->link1->mode_flags &= ~MIPI_DSI_MODE_LPM;
>   	jdi->link2->mode_flags &= ~MIPI_DSI_MODE_LPM;

