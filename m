Return-Path: <linux-kernel+bounces-801452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EE9B44517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788AA5A6877
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54A343D64;
	Thu,  4 Sep 2025 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="haD/vaqX"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01AA343215
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009389; cv=none; b=rKGJ/ShZUCT/jQtX3vptbnePpZh5IXj7UD2IYkc9FyIjxztCz69163jyyXzskypv9RkxCFZoj0Jwkm3SyqfjjWbgagfBH8eg8dLuj91Y07PtsFhq/5GTLGX2rOFWiXjYU42QddhaH2NugvCclX4sV7KD1fOnZCQduEdl3VqCnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009389; c=relaxed/simple;
	bh=3KSJJAYyDX+C/LcZzvoM4PG5ORu5Eyu29dHs5AK/SwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsOgMRB3u0bPm3767FPmXYYUbU/hYnCxKvzVrdx4k62hSWiwJ4X17ivwPQLMRaiGbYkHtof1tCCt073+Vn0RKd9vfF/gFlafRreby54KmmIhlY08LHD3dpa01bRc6xBgq4YVvi/wWBTgYWlRxAcHxTa4Jk6M4iiQ+NTT3r2yEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=haD/vaqX; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <4b29a3d0-c1b4-4a59-8c51-66dd2513257c@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=njoucinG9fuQB8MatP08sKlyuCvmD+sj97bdY637AAQ=;
	b=haD/vaqXFva8QVdel8TMrGGNI1Qcj5WWCWWb94nxFPSlDxyz1utDg8s1I7JDH5Di46p56v
	NxXBGhx7tSoplBwkzbPdb2+9yw1n91ozwLuQu6YAczT0PdKmrazh3HJd33tkJ2pBM7qamO
	5fN+ZggefXhOzlXBdrNEZaQ5aFoGz1xElAfyQ5nx1W3DT/ZDkdfS4LPRyGn5bDOp6OCffS
	oTgLzaoEMZwcP6uWyrRKQ93drJeRuuTt/sjOeIwmIpAK79o5x/JEnt06oue55Ih7MPKpc5
	G5DmllBMDjB8HJ/rtZ5qYKlfApoXhzeKCv54tOXuqnBkVxcwX7N+uwQWnIeVPg==
Date: Thu, 4 Sep 2025 20:09:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 10/10] drm: panel-orientation-quirks: Add Zeenix Lite
 and Pro
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-11-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-11-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> Add quirks for two Zeenix handhelds, the Lite and the Pro.
> They are identical to the Ayn Loki and the Ayn Loki Pro respectively.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 5f896d6e4090..201e5349f3ac 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -594,6 +594,18 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Galaxy Book 10.6"),
>   		},
>   		.driver_data = (void *)&lcd1280x1920_rightside_up,
> +	}, {    /* Tectoy Zeenix Lite */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Tectoy"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Zeenix Lite"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
> +	}, {    /* Tectoy Zeenix Pro */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Tectoy"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Zeenix Pro"),
> +		},
> +		.driver_data = (void *)&lcd1080x1920_leftside_up,
>   	}, {	/* Valve Steam Deck (Jupiter) */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Valve"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

