Return-Path: <linux-kernel+bounces-720273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BCAFB964
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7858B3B40F4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16438286422;
	Mon,  7 Jul 2025 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibyI1c9r"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583121CA03;
	Mon,  7 Jul 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907755; cv=none; b=JvqTP4RIXxwLroZdKpOgL8xePBwFybZSfjmmR/hZa4Qj4SBpVBEb0Fw7zA+gasAQEl7Dxp0updfVLM8zHIqWlCwy/u230MkJ9rHTIL/H/loek0Cp5XLKHHJNhhbeZG7cjbdKdyh5cCZkkUzvN4camtutXt/uJPaRw/DOYlT1vmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907755; c=relaxed/simple;
	bh=qEpcMyFiKfiNP7wV30h27bvrbTZ9SYrfEQ5szRtfEgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qbQ6GcGj4Lmi+m3BofnsFE1G3dzWS5PYiVrpkRxmA655YKluTbL8iw3EsnmPVjEsayWoc+IFe1gyfZCDeaEo4GsWdnOn7DaJsYjkBMPfXJxjRW5xVj246TU+WsEy3aUHj4EcPQm++6iBJSQ6Rir6yA/oofEuzIrsoC2XnmGpSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibyI1c9r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2350b1b9129so22348295ad.0;
        Mon, 07 Jul 2025 10:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751907753; x=1752512553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sf7fXWM8cJOpPopwpN8BZiyBh+hJ95cXslAdvwdcSo4=;
        b=ibyI1c9rSxHkZ+wi5j+o2e76Cn7GZ5krh1oQt2aB3BcrCkb8823nRHijTlI543udUy
         VJPiJC2LpYq3j4GnXACVa+XjB6Top3oSjlSUP/+u57Vy0KakdEq2zqJfvRA9BZj407UL
         qeyUU2hTFfJUg4dSCylxLtQoQkozOg1uKENU5anSHmRgTByzVh60MFMHlMV9QXFter4+
         PBBp+YomHob4E9wTmDzvLYlB9FqS5UjB8VrCND9oz0JK/ic5qsqquS/d4GhgDuazO7X2
         PZhCu2aE6ffamUVLaFBT9BnxHVCFOJxEq5jxOU1A13/j487r5GAJuDy1j0loOxeoP7w/
         l6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751907753; x=1752512553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sf7fXWM8cJOpPopwpN8BZiyBh+hJ95cXslAdvwdcSo4=;
        b=B/IsiDPCCOlXiIPCe5TU512alpofe6CL5PkO7ls5zlF6y9ho9ScWA7QS1gcH++fGqR
         wFE4KFSEtf6S/SVV7YiWvEj1iPY+QN73nnkYfmjoelv4nUKL9CSMJOsVU81l+tS17okH
         1tib/CLOMngJMF6k3+So+pB3y+mrwUX8zRFf8HSjDef6mfXlvXYbWk35ev18wJ9ETToV
         tOVQu0QLZtTe19yk5wNCoI7If3TtSpeu6PnjcwBpWX2U0ymOa+FB6Wq/0bhEwm45rOTN
         3SOlWKcAH5egc2FU34Udmx+WrP5QggUQvWa4x0eaHaqZOywB+Egu2w7kviCmRIUPC0ZV
         iGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXz8QdLlZK1LLzWm3gOnnmHp+BpUm6C/I/e1wA0b9X1/Y99Hlm4LI4dklBh0JVgqOZaTNE0zrJJT70BTgu@vger.kernel.org, AJvYcCXkb3qblD7AeM0ZKAZ3w3Yvy8Xcnrdi4i+Wo1HjRJfPWXSXLNeA2L6MjZ8Prfmo5wIw/iJokh38ztM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxz9p8WqENDCbDHIJzIDfmITK9iddv548WCSZPDzMC/BC0xMg
	wGbFhKbdk2O1xG8YzciVSbwQRMjQ99LlXX/zK+NtbxY+ktsm7iuVc1RZ
X-Gm-Gg: ASbGncsUSZLajVfJcz1aZ/xo9FI+3mHEh/F+1EiwhP69kw7vWOEe9gkXv77k2hvCbYO
	zo5mS2WfCImH037fsCeDSnSAHclqIsZrrfTw6wjyz/2vVMzGtFNbwB0baMGiXa/GaXKWkjHS5fB
	Ywmh+Yjwrs4le/Xh4fUrSoe9h/nLZRZXfnnJvmbcaW/3dea6XoMlsMQeXl0WFGdNhFkxnEuefOw
	72pv/MmvBVHLdP4GAtKg9rYkd7Uj6jVDmATWk7xXjsm2+Q7vv8owNm3RKJU4IWol23U47Yq31xT
	coDNg4wtyEcQgCrWSB7wmX1fwAuIqK8csXyH356GTttsX7yA0ADnRDxqXPwpncKo
X-Google-Smtp-Source: AGHT+IG8yMUXenYEn60fkq7ok6nf8gr6qJOoaMZCKEBtHTYasFnNHGVKtr5hAhaAnpN5pj44sUjrvg==
X-Received: by 2002:a17:902:d512:b0:235:ed02:288b with SMTP id d9443c01a7336-23c85e745c2mr174825445ad.30.1751907753129;
        Mon, 07 Jul 2025 10:02:33 -0700 (PDT)
Received: from [10.0.0.86] ([122.172.85.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8459c6e5sm94885855ad.227.2025.07.07.10.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 10:02:32 -0700 (PDT)
Message-ID: <2529b1e4-390f-4459-b7f4-82a9cd005da3@gmail.com>
Date: Mon, 7 Jul 2025 22:32:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm: panel: Replace usage of deprecated MIPI macro
To: Brigham Campbell <me@brighamcampbell.com>, dianders@chromium.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250707075659.75810-1-me@brighamcampbell.com>
 <20250707075659.75810-2-me@brighamcampbell.com>
Content-Language: en-US
From: Tejas Vipin <tejasvipin76@gmail.com>
In-Reply-To: <20250707075659.75810-2-me@brighamcampbell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/7/25 1:26 PM, Brigham Campbell wrote:
> Replace all usages of the deprecated mipi_dsi_generic_write_seq() with
> mipi_dsi_generic_write_seq_multi().
> 
> This patch's usage of the mipi_dsi_multi_context struct is not
> idiomatic. Rightfully, the struct wasn't designed to cater to the needs
> of panels with multiple MIPI DSI interfaces. This panel is an oddity
> which requires swapping the dsi pointer between calls to
> mipi_dsi_generic_write_seq_multi() in order to preserve the exact
> behavior implemented using the non-multi variant of the macro.
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> index 5b5082efb282..777a8ab3a397 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
> @@ -161,29 +161,35 @@ static int jdi_setup_symmetrical_split(struct mipi_dsi_device *left,
>  
>  static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
>  {
> +	struct mipi_dsi_multi_context dsi_ctx;
> +
>  	/* Clear the manufacturer command access protection */
> -	mipi_dsi_generic_write_seq(jdi->link1, MCS_CMD_ACS_PROT,
> +	dsi_ctx.dsi = jdi->link1;
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
>  				   MCS_CMD_ACS_PROT_OFF);
> -	mipi_dsi_generic_write_seq(jdi->link2, MCS_CMD_ACS_PROT,
> +	dsi_ctx.dsi = jdi->link2;
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_CMD_ACS_PROT,
>  				   MCS_CMD_ACS_PROT_OFF);
>  	/*
> -	 * Change the VGH/VGL divide rations to move the noise generated by the
> +	 * Change the VGH/VGL divide ratios to move the noise generated by the
>  	 * TCONN. This should hopefully avoid interaction with the backlight
>  	 * controller.
>  	 */
> -	mipi_dsi_generic_write_seq(jdi->link1, MCS_PWR_CTRL_FUNC,
> +	dsi_ctx.dsi = jdi->link1;
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_PWR_CTRL_FUNC,
>  				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
>  				   MCS_PWR_CTRL_PARAM1_DEFAULT,
>  				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
>  				   MCS_PWR_CTRL_PARAM2_DEFAULT);
>  
> -	mipi_dsi_generic_write_seq(jdi->link2, MCS_PWR_CTRL_FUNC,
> +	dsi_ctx.dsi = jdi->link2;
> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, MCS_PWR_CTRL_FUNC,
>  				   MCS_PWR_CTRL_PARAM1_VGH_330_DIV |
>  				   MCS_PWR_CTRL_PARAM1_DEFAULT,
>  				   MCS_PWR_CTRL_PARAM2_VGL_410_DIV |
>  				   MCS_PWR_CTRL_PARAM2_DEFAULT);
>  
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }
>  
>  static int jdi_panel_prepare(struct drm_panel *panel)

There's a lot more functions that should be replaced in this panel. You
can get a good idea of which ones by looking for the keyword
"deprecated" in drm_mipi_dsi.c . Here's a good reference for what a
conversion patch usually looks like:
https://lore.kernel.org/all/20250319183106.12613-1-tejasvipin76@gmail.com/

-- 
Tejas Vipin

