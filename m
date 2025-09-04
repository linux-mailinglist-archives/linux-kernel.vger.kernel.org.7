Return-Path: <linux-kernel+bounces-801439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5956B444FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A483BD4E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DC9341677;
	Thu,  4 Sep 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Dd0lqhS5"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E7E1D9663
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009075; cv=none; b=MnsIK8rMn9J4irC7juI/SrQtXuc+EIAR9cYCuKVmjZyHkZZrCUguPsYbKhIcF5WdqNtE0KFAL0qMBDpL+Q5woe/LzklvrAHQ9PMtuhg/8pIrPI5LFjJ6pQDC967LuzjEVwg5mm1A5NAIYo/0C4d5Y+UFPlivj8AkRXJ4Az1uwK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009075; c=relaxed/simple;
	bh=soG+5kK2ekzwIJBwV5ZTPGbfKZHXh6tfpvAmryG58CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka0zwLjhdC+YePgZhOvWSVmrglU+bICCoetxfUtTBgqjpzNT5025vTQ1pyCPJksun3LO4o9p5VjLRayd8yCFVRPnIrJhBPLKnF4vzBydssi/xak7FR2KbzoFzatUs7+hGKH7fkVRJsj/hXhR1bFIWYPkvW0Er7Q56fEYI5hgPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Dd0lqhS5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <45345a77-76aa-42c8-bb25-8b37f27f2495@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oq/uojrYW5csmb0d80Eu12YQJ327C4sZD+phfZR5BpU=;
	b=Dd0lqhS5GnYAQo+oOzuHDTMZK5rBe54PaFnLgPb/H4DZ2B23Lr7BGcvFil7R9foJA/IVUL
	A7+8nbsTNEfPHx5Z4ELu6vjFpQWUAR1ASI67uexK/JDgjDW3txNx2VR4XOFDF5XXG8bocj
	B+cw6r17LWbB4laFbNyPUTVCKFY8POXugoFk1XH2M+nWqwogL3lgQdGZ7gcfmGw8U6Y+vy
	3szhWv7LFSVJmooJxfvW6jPDzeXjbJdUO6+4TwKPMimwp6rE9+IJgJqhGqRjlGnQuWERxW
	KrwGCavKImKiemIkjQn6boLr/CIz0RU1r7nF8f3wGXXZMLRaha8oqubhPUlW6w==
Date: Thu, 4 Sep 2025 20:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 02/10] drm: panel-orientation-quirks: add additional ID
 for Ayaneo 2021
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-3-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-3-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The Ayaneo 2021 has an alternate variant that skips AYA in the
> beginning. Add that as well.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index f5c7275cf026..d724253407af 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -215,6 +215,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AYA NEO 2021"),
>   		},
>   		.driver_data = (void *)&lcd800x1280_rightside_up,
> +	}, {	/* AYA NEO 2021 */
> +		.matches = {
> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO 2021"),
> +		},
> +		.driver_data = (void *)&lcd800x1280_rightside_up,
>   	}, {	/* AYA NEO AIR */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

