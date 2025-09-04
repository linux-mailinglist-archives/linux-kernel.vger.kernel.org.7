Return-Path: <linux-kernel+bounces-801444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AEFB4450D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343293AAEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96F341669;
	Thu,  4 Sep 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IGmGETWD"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69719305E2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009311; cv=none; b=pdpRyExvBCQC1uLNdT16abYMFJ4poA2RFVm7LZ7IuAQtfL8DMiBxLP+D2GPn+nenILHpwFTQLPVVY1urAGdSLpUU+Ur8cUdK0fRIeg4lMWU+kGUmTyF16zYJcPpT19YYry0TnoL4HcOkUmzIzU51L8d3bcwOeHrEND0O9TNAY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009311; c=relaxed/simple;
	bh=q39dzUNWxjanQVmc5JTEzwFSiLBYW7Yw9Q+XAccvK2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmmpegM+WeVWjPXXgsb7pARgocq3k2XCakx1vhO1HEosQXljHcGIC7bc/ZyMuUvx00KXOKz8xtvtDNoBljbaM4V9BADGsSFacQ6aGlteudCWiL3Hw8OTMd87LFJw9CnCq0Ap859/QKtR19jJIgIRAYIlfuyM495bcijCemOhgDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IGmGETWD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <799e763c-8f1f-4d4b-8aca-94c416871f65@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ESwECSRa5+yZuW0lPSnfO/0go7wcxVcfexfShM/7fac=;
	b=IGmGETWDUVyk5CMfeoP63n9L1QSwAJfr8SosdYjUOnknuJQ3r1Hfd0RkVPXvNxz4+Raa5I
	r0tTMTwnEzV7lJTEdyetXkIoT0GBTqx4GUUKNuoswHrFrPcTKS4ERtjtzlRiWdFctoT+E1
	MGBIO5yzqqvEw8l5gWt075YEqBPzqq0fZAwZJd9HAVsYBfqxyFhCVxEvP4tCAaJoah+xjM
	hBCrnceHSgvw9jofHgcc99Rf2gcqj0p8jViNBB6u2AF9Xp2lRpkfHJMmTvKOturkdA1wGq
	pndXsUMkbY49kHsi0YJ/hwEkG6+2SeG8SbsQ4IakMAm8j57QXtq8tTEYVXXSZQ==
Date: Thu, 4 Sep 2025 20:08:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 04/10] drm: panel-orientation-quirks: Add OneXPlayer X1
 variants
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-5-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-5-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The OneXPlayer X1 series features a 2k 10.95 display with a portrait
> orientation. Add quirks to set the panel orientation to portrait mode
> to the Intel, AMD, and EVA-02 variants.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   .../gpu/drm/drm_panel_orientation_quirks.c    | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 0ea06f928f79..378a3f692952 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -504,6 +504,30 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
>   		},
>   		.driver_data = (void *)&lcd1200x1920_leftside_up,
> +	}, {	/* OneXPlayer X1 AMD */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 A"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1 Intel */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 i"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1 AMD Strix Point */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1Pro EVA variant with Intel */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Pro EVA-02"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>   	}, {	/* OrangePi Neo */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

