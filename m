Return-Path: <linux-kernel+bounces-801443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A19B4450C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B61683D5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E3341646;
	Thu,  4 Sep 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VHeaIRZ2"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186254654
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009284; cv=none; b=joer0op3+uTUb8BlY1tp4tXenuVEngKSxRjsIroHuN5ItPeaVXRxkzcgb5VZqFRO1alO1DrUHY+6tWj1tRqxvejQ9+fDnjIPsS8K//LnJX2iWXnbSysycMShBc9myxkqisFJzqYh2pfcK1sdlF1PUXfL7Wum2y3eDHtsPJokak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009284; c=relaxed/simple;
	bh=2dWCKoOHUCoM3s1kh7MbXKS3tghiM0oLOQ5Cj+ShhiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qw0u2aASTvDpeVoUDYmD6ZSe8y8rADGH+1zcpWpnV23WlBcBGi4VKbE8T/Kgntin5XKVeo7ebMFMxjuqE3QaHwVA7UzCTDLhPtsUgG5fCUkStFB5BonzjyMTWrqJEC0zvaEC3hbAsNJ9Ex6uMfxNNN2SdwXG3Y+KS1iTfX80l/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VHeaIRZ2; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <066e569a-8cb8-468c-96c7-5742764dec65@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cQqR5RRwwmxd9qAVTIdP+E7Z3N7+9bkJLYuiXvuXbA=;
	b=VHeaIRZ2MJ+dzX6//YP7uSeHkffpaSkU7VN19GnGurdBhCR8Y6k8sB6yyVv01O7FTVaxq5
	LrmhHRuS/xI07Ry0Dqm2qHuxiZAypg+l9VNroO9sNH+ivJLoSTltyFQzCFb7aWGdh9zAz9
	t55SonjlRvrl0zvA7F49dvSQ+xW3ylxCP4du55AXk8ETEEtqpJKX05/2PFJGfjzo7Rs+Cw
	D9acTZbj6drqNVgvO+Xa3LBYzClMKpRjduhv7tY8uQeJ64xl4W5xOO9JuErxaKsZ5PuN8D
	0qhqLPlt8w4Di3ORG046B0AA3RtsOMldv8lsQpen48leFXCVXQ1nnp9E8uRXjw==
Date: Thu, 4 Sep 2025 20:08:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 07/10] drm: panel-orientation-quirks: Add OneXPlayer G1
 variants
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-8-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-8-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> Add quirks for the new clamshell device OneXPlayer G1 for both AMD
> and Intel. The device has a 1600x2560p 144hz LCD panel.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 6f5ce26a84b7..e7a2c5b59d28 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -558,6 +558,18 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER F1Pro"),
>   		},
>   		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {	/* OneXPlayer OneXFly G1 AMD */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER G1 A"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer OneXFly G1 Intel */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER G1 i"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>   	}, {	/* OrangePi Neo */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

