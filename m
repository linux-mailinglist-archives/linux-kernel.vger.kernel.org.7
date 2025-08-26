Return-Path: <linux-kernel+bounces-786615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9291B35F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B4F7B4E12
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600ED334396;
	Tue, 26 Aug 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PrLTcrFF"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23101321457
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756211391; cv=none; b=XXMxHByixLmc1XxYl3ED5YXHv8gYoSh2Ufevu3TDn8GxYIV37tkaJ8iJ/JvdtW58GO3dxXaWXnxyb6Xuuae5x9eCtcjmKMETHYvYfp25yximvEFU3V6KeouRsDLuq9TSaxUnMukQi7cjPwjOoJbSazuHC25wNvE9JBmFfUXgRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756211391; c=relaxed/simple;
	bh=ORPSoxH4ZScQluSg2BnSC/BtlZAT+ISG4Y8PGfXE5gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV1cO1zSzyiAB+dT+sR+MVPoz6IMUVqHrZJbiry/MxzX7hvnXapgcdsOdruudVZTDCek7CUrdx9gmMZlrVa7lUjVCvMmlMWNn+XCaUIP82hkhZ6d8ctv++6ETfDcfr74WRyl7rPSGg9gXtDAUCRY/ZuT08Pz52bb3seLNVbz9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PrLTcrFF; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <b7cb3882-b04a-4f1e-a849-956a4df6ff6b@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1756211388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEfvanppTrxEsqSn0RrWuJbP/yMWdRGbToB8V5ydIGg=;
	b=PrLTcrFFlEFV41vGbnVZRMznQyrAOhvzJo7cEudTI1814MU5SkfediNE9+7fIn/eTn/mv1
	osU5LsVO54sj1WPp2ggS2gXSaxmr//xhdmwxyAd/stOmeT/SYhzvLvaaRjmcHxJSjjo6wV
	8+U7td5a3QtL/BjxW89VuxUh6TavRrou1XK4qIzxlb2OaE8R+D/jicn6CchyleiAJj2eGC
	1xR/bPw5CghWoobZhVgVq25FVzF7NZR06fRsgpqvcC3eUwSh0lA+7D5o8bJH0pnL5ta8bH
	SWi92MOGP6gZpRuUmaKS6xJ2/EfBIbSDOI5qEN7zfnRdJy8wqx8voIzJtiEjzA==
Date: Tue, 26 Aug 2025 14:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/5] drm: panel-backlight-quirks: Add secondary DMI
 match
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250824200202.1744335-1-lkml@antheas.dev>
 <20250824200202.1744335-4-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250824200202.1744335-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 8/24/25 22:02, Antheas Kapenekakis wrote:
> Using a single DMI match only allows matching per manufacturer.
> Introduce a second optional match to allow matching make/model.
> In addition, make DMI optional to allow matching only by EDID.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_backlight_quirks.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> index 702726c20ccc..3d386a96e50e 100644
> --- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
> @@ -8,11 +8,14 @@
>   #include <drm/drm_edid.h>
>   #include <drm/drm_utils.h>
>   
> +struct drm_panel_match {
> +	enum dmi_field field;
> +	const char * const value;
> +};
> +
>   struct drm_get_panel_backlight_quirk {
> -	struct {
> -		enum dmi_field field;
> -		const char * const value;
> -	} dmi_match;
> +	struct drm_panel_match dmi_match;
> +	struct drm_panel_match dmi_match_other;
>   	struct drm_edid_ident ident;
>   	struct drm_panel_backlight_quirk quirk;
>   };
> @@ -48,7 +51,13 @@ static bool drm_panel_min_backlight_quirk_matches(
>   	const struct drm_get_panel_backlight_quirk *quirk,
>   	const struct drm_edid *edid)
>   {
> -	if (!dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
> +	if (quirk->dmi_match.field &&
> +	    !dmi_match(quirk->dmi_match.field, quirk->dmi_match.value))
> +		return false;
> +
> +	if (quirk->dmi_match_other.field &&
> +	    !dmi_match(quirk->dmi_match_other.field,
> +		       quirk->dmi_match_other.value))
>   		return false;
>   
>   	if (quirk->ident.panel_id && !drm_edid_match(edid, &quirk->ident))

Tested-by: Philip Müller <philm@manjaro.org>

