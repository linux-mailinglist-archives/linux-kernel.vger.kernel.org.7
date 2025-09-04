Return-Path: <linux-kernel+bounces-801438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A7B444FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB693B9409
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BC33EB0F;
	Thu,  4 Sep 2025 18:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="or71Y3L9"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADCC1D9663
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009069; cv=none; b=s1dh8YTX4O13L8sIi3QrHR7VVjKUBszPc/i0T7F/SP38acdgb9JuqVD3Jx/cGox1TBLrrM2uhLcEdlN9SHOAoGaoG5iKxsf6gql56GP3KTnUaWjWet6mFA64yIkcEyxvAeysPUc1+Trv4/5RRCkNgM+yB7a3ZbNnbalS3tmKET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009069; c=relaxed/simple;
	bh=DIZBWwEho42VtT5JhE7AAeiMpcUkrRGIBo+FRZdRkW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJzDs5ptKegftNM9Pp5yPPj3FvcXGoXCEIBmQpt0dGN2CU/nYP9OVIq1j4plU1v9f9/7n4jW7g4VACkBUgyV5JJ/Tn5LLAMHqdOkbJM8cj7k+TPrLI8R4djutM06IiebcOD61XxrJiqm0niYlAc09vx9RwbJvkDZ7n7UOgcxm/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=or71Y3L9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <3ec43f82-26ad-478d-8470-31ab4719cc2a@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1757009059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqcJUFkw3lfYabmECLa0bCXwkv5VvVIV6gzH7YTUci4=;
	b=or71Y3L9Fo+tKY03r0JQIZNejIO+T7cIUz51B2XLV1xQBqL0/RE/5TPmSmZZf/m/5Mm2BY
	jNhAkntzH5Jtj5tKaH2mOKUSw8kUBfSEMDb5YCJKEnCkwTzwo57Te4yxs9mHTEPPqNQbSG
	0LlZQZaMc0pNsA/BkOcAmJo7bqMr5EC+7BV8fu0ktMa/doMdbkZKp60Xp4d1Y6Q6X35wzh
	CA7r9498ls+XIQgLap+5NknSq22j4TptwSYWELyCspMl7gGvW6r76TGDmToKXT05TyuMSC
	8SpfJBvRi2GyBwWTXw4v8AFbCE3qgKtmN41C8thraW/Xd1SYF9eUYS9Sks+aoA==
Date: Thu, 4 Sep 2025 20:04:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/10] drm: panel-orientation-quirks: Add AOKZOE A1 Pro
To: Antheas Kapenekakis <lkml@antheas.dev>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904175025.3249650-1-lkml@antheas.dev>
 <20250904175025.3249650-2-lkml@antheas.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
In-Reply-To: <20250904175025.3249650-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 9/4/25 19:50, Antheas Kapenekakis wrote:
> The AOKZOE A1 Pro has a portrait 16:10 panel, add a quirk for it.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index 3a218fb592ce..f5c7275cf026 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -179,6 +179,12 @@ static const struct dmi_system_id orientation_data[] = {
>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Win600"),
>   		},
>   		.driver_data = (void *)&lcd720x1280_rightside_up,
> +	}, {	/* AOKZOE A1 Pro */
> +		.matches = {
> +		 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AOKZOE"),
> +		 DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "AOKZOE A1 Pro"),
> +		},
> +		.driver_data = (void *)&lcd1200x1920_leftside_up,
>   	}, {	/* Asus T100HA */
>   		.matches = {
>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),

Reviewed-by: Philip Müller <philm@manjaro.org>

-- 
Best, Philip

