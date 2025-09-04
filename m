Return-Path: <linux-kernel+bounces-801447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9CB44512
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E67C175CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930A342C8A;
	Thu,  4 Sep 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Zo2m9vfO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9C2305E2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009350; cv=none; b=oloil9MtbuXVfnfxFvULsbp9O31zZ2nrXELDU0S3sAPNkozoqBUHrYWZTeBMwDn+f0C2bD5x3sXJPziJxlyIEQ4k1y5m1fo3Rb1TenVEfgeyHj9dkdXeVjbX7uTk9eGkH6mfhhlpq59ENpyCk1pP4KNKi2bWeBESgNLoyPwf+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009350; c=relaxed/simple;
	bh=vSreGzcx23xp6KdjntY+aolYzIPGQM1mDGj2j9DEMnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5FHb1tDmxuNLIPxj7oQ5h3yWTCv+LesRjFsyhTNWZwYJIlJH6s+dmx3k+G+UHFsFFto9EqnHENU9G3CIdMPpBMVbGus9cGRB0FNeu4RiAjhg2huVbJ6o6g6eCS7WmsJsyk+vsbfDe/Yw1qXVqLu/VPmXrKgHyxftS1vjocWASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Zo2m9vfO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <7e709a39-45ae-499b-bafd-706489e180e9@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1t3DdUHbRL7Z4Mgfcjt/Br8K22doewpd3l5EF3Tt8g=;
	b=Zo2m9vfOCmKZMkOFA97DRsKy/uUVMlZyO1s8ehhyPT44/UNZzdRO384nxe5PUEOCYnU+Hv
	idchhuhBKg6xcAbFtq9OYRqxh8GPUqxEW+ghxwpjF31ehxd4kaTRJpDvp3s/oetvWcTw2Z
	cbqeL6qIhxEKt4fCEdmDMS1D1Wl4nvsD2GVxk9atlhyP75HnU45WAebvTjA2ZjetJ6cQhz
	CPml+HHksowaVuug1IuY7dHwp4uqPvV/K3j1abiKDyGfd2jzTRlWvTIC0VanBeR1j7NKz1
	NmTdOhFktyAZ+VvgC6weTT4Xc0yVZMP9p5GsbLCnHYnd7a9sARwN57AmeZf9mQ==
Date: Thu, 4 Sep 2025 20:09:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 06/10] drm: panel-orientation-quirks: Add OneXPlayer F1
 variants
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-7-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-7-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The OneXPlayer F1Pro has a 144hz 1920x1080 portrait OLED panel.
> Add a quirk to correct the panel portrait orientation. In addition,
> it comes with a red limited edition variant in the Chinese market,
> so add that as well. Then, add the 8840U non-pro variant as well.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 0c0fe66e94ad..6f5ce26a84b7 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -540,6 +540,24 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro EVA-02"),
>   		},
>   		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) LE Red variant */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 EVA-02"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) Hawk Point */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1 OLED"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {	/* OneXPlayer OneXFly F1 Pro (OLED) Strix Point */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1Pro"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>   	}, {	/* OrangePi Neo */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

