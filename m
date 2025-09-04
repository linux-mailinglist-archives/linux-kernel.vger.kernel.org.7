Return-Path: <linux-kernel+bounces-801446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B4B44510
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959E61CC38CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EC34166D;
	Thu,  4 Sep 2025 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="g2r89ozd"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB243126D2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009321; cv=none; b=lsCUigwwO8j3/ZcL1omBZUhRBqyK+RmfM6gQ+/GUqneKunvGrEvGI4gNBp7s4kw2b1IexAQFSh02Ad1rzn8i62AdjulPb8zt1qV73DpiidQGEx/roSsS8A2Q4RJ0XUEC1WKmGQGh2qYS7L8XekmDCX424i+SYqRtdH/naAJFiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009321; c=relaxed/simple;
	bh=R0OIl88U1OUFm5R5BlqfIfgDuzA/Dr07AULTnWjf2lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjXOIvgoQKTOtoSEcS3Baum14AODMrojZ4dNtEfcvXWgObhKjaHolsyai5KxYy4S6Rx/CVzAAR8hS7Si33PYzP75kSyEzjcTJh0/J5uoir4zqbKO+iPGIY0zyNnduDqU+tmucXpYaaIgQkXQ/BBGpinOyCQDLfsy0w+BoLoonsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=g2r89ozd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <ccd7d35a-df35-4f25-8054-2ec492ed9f41@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0cnBWyJN1QPMITmAyr8Pt/R6PFfcydx2o0hexaY03k=;
	b=g2r89ozdJeOjRNPwVkuX2UBBFbcvCObwiIUrn2ObcOC+4SgjQwNhlcz8c2KpqUefUe7ofl
	Cnce36KDK0NJzKQcHerr/5Kb8l9VGcrC8Ez7dReEWBUTPLjk0+O8PBZQLBcI6bTlVN/mxS
	zLSSXWhLPtlwbqKksG6o/OgWouPNPHjuMGjEH/mx2tm83SvBBKN3tsFYQBoqDT3yk9CZla
	Eb+Nbuoq7CRFyhYxAugmA7l5oci35O1VnbnD+u0xO4pugDRFd7w0Fl1nF2pcC9QU46C2/J
	kt1fQmg/OHh9zBd+zy6yRTjUvWUIpjs59ajUUiN+P14yMGUUoAuury6czbHPTw==
Date: Thu, 4 Sep 2025 20:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 05/10] drm: panel-orientation-quirks: Add OneXPlayer X1
 Mini variants
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-6-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-6-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The OneXPlayer X1 mini features a 2k 8.8 display with a portrait
> orientation. The Pro is a CPU refresh. Add quirks to set the panel
> orientation to portrait mode. There is no Intel variant.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 378a3f692952..0c0fe66e94ad 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -516,6 +516,18 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 i"),
>   		},
>   		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1 mini (AMD) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1 mini"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
> +	}, {	/* OneXPlayer X1 mini pro (AMD Strix Point) */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONEXPLAYER X1Mini Pro"),
> +		},
> +		.driver_data = (void *)&lcd1600x2560_leftside_up,
>   	}, {	/* OneXPlayer X1 AMD Strix Point */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ONE-NETBOOK"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

