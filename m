Return-Path: <linux-kernel+bounces-801457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F3B44529
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DC45846C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF527342CAF;
	Thu,  4 Sep 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z2fRMd3C"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AED342C90
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009711; cv=none; b=JhikN/mOoeatpCmt1KMVbga0aL/5MUoiEjlqWD0Qjx+uhnNAx957frc4m885Cs+0GUT1n/dzTbTsjYQZGsWLPiJgtQHlLpiZbVr5eOIcU4v7wfZ0xwaiC9mvHwZ1cJ4oRorBN3OL+oK46HrXFAAkAeyicRILTMrUckAaaeXAeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009711; c=relaxed/simple;
	bh=Z+VK5U/Oi1LA6fb/D9V1KAbU7wRtydG7tfKSYqBTU7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzS1Uwt2g4v0ikk9Zh7nmz51ahUBXpf1/WOohMKRtd9gjzO/pmf5hwadHeAEHld8+tpXI2JhfOncem6ejWpeSopP1LnYa/tz488pyrTdN6/94iasDUZYLLV6YnFLV/M50glfDyPmgcYbuH6um06wulqvyguy1v2GyArd5kRNVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z2fRMd3C; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <53482f3f-bd87-4980-ada7-c2c771a0c2b2@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYXeUIKu52g0HlpWQIX4EGbvIx92SbpoHy5tYhxk2Sg=;
	b=Z2fRMd3CO9KuuxljJ+Wo6/u+e7sMWhQTl34ciHFHH8JdD68N/r17s4hV6hxOIDx1oPi8nh
	cnQtTJQ1Rfmfxh7daU+otZ/oUA9q/vj5B3x+drnKhNd8QlFS3Hw11TKX0RhdaDaEkNcbuA
	eMqUqGWrUTp1fvqw4Grfxb7FlRQVooCFDLbVnNowYPdJKvl7OBkfEC7rbT89SIEmIKUqK2
	Be4L7HJJPJO2g8GxOh5wL2HcbguI3bCp7EFZYF71ULmb9VCj3as2lrsyP8OsbB8JEuqZyy
	UhHYYHohLeymXo4U3ArxLzkoZatMIFsuzSZ+7DkfkxHdohGuf2bTVsozFikT5A==
Date: Thu, 4 Sep 2025 20:15:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 03/10] drm: panel-orientation-quirks: Add Ayaneo 3
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-4-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The Ayaneo 3 comes with two panels, an OLED right side up 1080p panel
> and an IPS landscape 1080p panel. However, both have the same DMI data.
> This quirk adds support for the portrait OLED panel.
> 
> As the landscape panel is 1920x1080 and the right side up panel is
> 1080x1920, the width and height arguments are used to differentiate
> the panels.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index d724253407af..0ea06f928f79 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -209,6 +209,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_MATCH(DMI_PRODUCT_NAME, "AYANEO 2"),
>   		},
>   		.driver_data = (void *)&lcd1200x1920_rightside_up,
> +	}, {	/* AYANEO 3 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYANEO 3"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_rightside_up,
>   	}, {	/* AYA NEO 2021 */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYADEVICE"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

