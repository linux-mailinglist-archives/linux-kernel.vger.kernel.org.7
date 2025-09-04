Return-Path: <linux-kernel+bounces-801449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4757B44514
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F325179A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8064341ABA;
	Thu,  4 Sep 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mEgIevQQ"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFF31A56A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009374; cv=none; b=n0AGGwo7mWSMECkII1n14cNL4w2p0n0J1FHIzNG1wT+3RKRaUc/Eh1p956IwTG8vkoUntvEiUNwpbu3KoVaoxAQbpWgojql3XYn8r9RjlA4hKEqyNUBLCdEi0PmIvOxzZ0zk6sVQE+JX+lwrRIm2dWc55bGDNuSNmHWqYBJ0lR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009374; c=relaxed/simple;
	bh=ur53Y+d46jDjzyM8cPKOFjnGDo6KrbP8j9ixzZodym8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkHZWJpJx/5pHZkbk5zaPyUsjt7mJbZaKNfK/MrCo24VbkU7mkJdE+PeNJ5kTISGCkdDgG/nXcToRG+sd4Blt/XbNm2+FYYgUIFtvOTRRMaEbo61wavmcb5KacUvB5CZNA1DBNhU1h9fFI3K8VBP2UfmV44jFNcwHp40wFYBTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mEgIevQQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <5682ab63-d979-4be9-952e-82b00ca9d796@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Euv4No74X68IhkaDokRPif19XB+//dlC/qMiC9ds8aA=;
	b=mEgIevQQx+kvAMKZFLTxqWbBYOC6e3mcwi5MRc5jw45F4V0WAY2DtDU1VuCj9sjYJnfVWN
	vLs6/3kSKvNVsjHriQsdbFoi+tv+hHAfpphkXeL1nT4MHjoxnFMb/lsm8KITAF8XljqYiW
	YrRH3ivCTGglyU/cgoeCX3IfITVL9Y8CPIA4Pn5LNKzDU9KIJ/pwTBUXnSSkimFdZ3fowE
	QB4Tgoke3kUE2WC6/hmP1g+fRJ0mWpyz1yohHD7dNufJ2kGkGoCcdWnwurae5rk48Kd7X0
	1Ugmu4GFC8sWL9Z2uJA+0r22e+Y89+kqSE4ZKbTBY/Du0aYmf6UtW8fI0K4WVw==
Date: Thu, 4 Sep 2025 20:09:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 09/10] drm: panel-orientation-quirks: Add GPD Pocket 4
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-10-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-10-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The GPD Pocket 4 is a mini laptop replacement with a portrait
> 2k panel. Add a quirk for it.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 75a8c4532434..5f896d6e4090 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -388,6 +388,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
>   		},
>   		.driver_data = (void *)&lcd1080x1920_rightside_up,
> +	}, {	/* GPD Pocket 4 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1628-04"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_rightside_up,
>   	}, {	/* I.T.Works TW891 */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

