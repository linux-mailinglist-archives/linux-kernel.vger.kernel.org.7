Return-Path: <linux-kernel+bounces-891937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A41C43DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45D874E4FDE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227C82ECD39;
	Sun,  9 Nov 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ud1BvHBs"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03502E975A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762691763; cv=none; b=V/9bYYc7EWjgSeSBT8SljHDtwBERkgq2MEbzB5HMCxUB4AQRm5fDsPgAoCzR5LSfCcibJSYmYKIaE4fr2KMx9uaWyPATVUfYiqEpsofEph8xBl5H9koxMeKEGGzWPG0kx1ZpFBkCN77ApCFkIVQ+EhPS4Evm0XzoizhWv0JaoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762691763; c=relaxed/simple;
	bh=aipiftIL6cxlw0GmgAzYCOHVmHzME3ZaXt6XC5G+Nz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5Jw/OUMtvNRUGREpw/V9u4rxR9jZPn0KZFk7JEh6Ujuwhq6JGASz30WxPzOqYfSdVsu8K83hGjcJt4i+sx28CU35GofZu8qdau2eQoiBmcMCdXvpw1mQ465Pxb2hgotfgtePdoAFXZd7frDQuvHen69/17O8oXH3TAf7aQCYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ud1BvHBs; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4736e043f9so299260966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762691760; x=1763296560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0Qyhz1x92lWHWIws7RgtXksw84DNzrjoWDqoYr7AO8=;
        b=Ud1BvHBsR5QO7ti9xgE1QeFTEurLQz9zSG7HJwoTOX7SsqbZpLllyznQ6nNml4ggQ5
         HLngF89H3jaQzViZw0dyxi2GxgCrrQfTHTdKNFnAhBivADqdM+F0W6D362WwNIt5GIvM
         bv3uQ4ea8cPUIFKOgyeylTbS6y1OegHQ/QAu9rSzOl9I+9EG452b1xPAq2TiljV+Qiwl
         HEEZ4ECN7u3BC2eBeghl1McFiUES+wHR7HSBT/ydfYdhBq1iM3w+Tf+cBtAGZDEiuzFs
         ndnJ0A7uhgpA+InddT4P8/hfn0q2HdKaAhEgEJKygbHC93ghdfnUO8sTfbAUB/oyJb89
         M1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762691760; x=1763296560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0Qyhz1x92lWHWIws7RgtXksw84DNzrjoWDqoYr7AO8=;
        b=ulrfXsZrLARlOS0jNofMda0qNfyH59uPsVfGGavwXFRvLGleKcJoZa3ROKRowPup4O
         n6146YLvVRf+2H9PSJ0vwB0xV9t2z+fUi1W/fZ7br6Lnl87cZOQ22+KwLATaEu5Iz03s
         Y/CHTdHs3/Ap9VF7EyG+TNB54XH18BnbxvAyROdPHm4+rybcZuiBjcsHag0LZI28ZSYg
         i02P/DgOVPNvCnNDM4g8rtizHUI9ieXgKI0K7HDDhOmuA//mfLEXrNTP7GQ/2j6OO/Ie
         JUbgdIxOvr5bblBXgDXyqOjvmzrN9MCDyxzXLv6QHPKOZ3wPsIrLfJhrhgi8ltDbxhoo
         Lb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlxMaptzGWzheWzhZdaLAtNqgM1/mIgom+iPCwNx45LLpcpBcd1VI/yRUEoUXYNqFhi/9kqWgxBiyr5YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5ac7hKk+cezo4QaJCEHUc+BIsNqGM7vuntrPtNczZZMptpo4
	1bTW1P/kxeaBrk7TT9ILN/RQJj5/B3pDBHoZR+TsvP8aU9lYGkxPLYBsmf6z0CebZek=
X-Gm-Gg: ASbGncv2bFG77XuIuprczS1QlRYAbd2URju5fSJuFWzghxo8KvWV4nst7APtxiCiLnC
	pZJyRCYAHeE5IYEXNWDb0OoPajt0BLScW4w/weV6muXk5GoolBn4s8a9FyyGWKRHEXMrfjmSiJX
	aJdLcyh7OPZOCCPBH9e20hIGMxYibUeqqqJT4bGB7lBQ4SFBMh9nDmuXWklehaBEMKDChAZX4Y6
	X6sHPDPhiYdfvuw6alYSaPReC+WEXRsEuU8OTyP9aUEcFydLleHK2O20uczFiHlJQh7YjEJ2v6e
	DGvgUK1keK9+JeUnoFLWKnqNFldizdofX6rcHMAdaE80l0HJQoUDcffTYRmcna5sHTIRJwWBKSB
	ThmoK5qjHyJVhr/3OGNBwKy5dr0eeKESZ0+CGgwZDxDyamgoG/bVpZsypnsJTCwRvh9hwbzpm7+
	E3SBgWwmeaZbCxHo59cRfOEk/u4W7JAIxwMOppb5Tyr3IVcsT8uUoVxi4mIu5u81ViTZdeSw47/
	A6vFfabMS2UPJcjNaU79tkxuE66Utg792231HzwZZOIRCVq4vVxvsIHDivlZbo3MRL0hbbR3zFo
X-Google-Smtp-Source: AGHT+IHyykZNktMvLQKNtgxSniaCk3u7efAcZ163+WwM1eqdehxI0ewxnn6NYoG1aJsp8Lj9a6zjlA==
X-Received: by 2002:a17:907:2d8d:b0:b72:a899:169f with SMTP id a640c23a62f3a-b72e028a446mr537437266b.4.1762691755219;
        Sun, 09 Nov 2025 04:35:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6? (2001-1c00-3b8a-ea00-4729-b0ef-dcc4-b0b6.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:4729:b0ef:dcc4:b0b6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97ea95sm811509566b.44.2025.11.09.04.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 04:35:54 -0800 (PST)
Message-ID: <f3a5c965-6bf7-4e0a-bccf-f0342928150f@linaro.org>
Date: Sun, 9 Nov 2025 13:35:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] media: qcom: camss: csiphy: Introduce C-PHY
To: david@ixit.cz, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <phodina@protonmail.com>,
 "Dr. Git" <drgitx@gmail.com>
Cc: Joel Selvaraj <foss@joelselvaraj.com>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org
References: <20251109-qcom-cphy-v1-0-165f7e79b0e1@ixit.cz>
 <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251109-qcom-cphy-v1-2-165f7e79b0e1@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 11/9/25 10:39, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Read C-PHY from the device-tree bus-type and save it into the csiphy
> structure for later use.
> 
> For C-PHY, skip clock line configuration, as there is none.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   drivers/media/platform/qcom/camss/camss-csiphy.h | 2 ++
>   drivers/media/platform/qcom/camss/camss.c        | 8 ++++++--
>   2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.h b/drivers/media/platform/qcom/camss/camss-csiphy.h
> index 895f80003c441..8f7d0e4c73075 100644
> --- a/drivers/media/platform/qcom/camss/camss-csiphy.h
> +++ b/drivers/media/platform/qcom/camss/camss-csiphy.h
> @@ -28,11 +28,13 @@ struct csiphy_lane {
>   
>   /**
>    * struct csiphy_lanes_cfg - CSIPHY lanes configuration
> + * @cphy:     true if C-PHY is used, false if D-PHY is used
>    * @num_data: number of data lanes
>    * @data:     data lanes configuration
>    * @clk:      clock lane configuration (only for D-PHY)
>    */
>   struct csiphy_lanes_cfg {
> +	bool cphy;

Bit of a nit, but it would read better to use an enum here I think, then 
one doesn't have to infer that "!lncfg->cphy" means dphy mode.

Kind regards,
Casey (she/they)

>   	int num_data;
>   	struct csiphy_lane *data;
>   	struct csiphy_lane clk;
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index fcc2b2c3cba07..549780f3f948b 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -4055,9 +4055,13 @@ static int camss_of_parse_endpoint_node(struct device *dev,
>   	csd->interface.csiphy_id = vep.base.port;
>   
>   	mipi_csi2 = &vep.bus.mipi_csi2;
> -	lncfg->clk.pos = mipi_csi2->clock_lane;
> -	lncfg->clk.pol = mipi_csi2->lane_polarities[0];
>   	lncfg->num_data = mipi_csi2->num_data_lanes;
> +	lncfg->cphy = vep.bus_type == V4L2_MBUS_CSI2_CPHY;
> +
> +	if (!lncfg->cphy) {
> +		lncfg->clk.pos = mipi_csi2->clock_lane;
> +		lncfg->clk.pol = mipi_csi2->lane_polarities[0];
> +	}
>   
>   	lncfg->data = devm_kcalloc(dev,
>   				   lncfg->num_data, sizeof(*lncfg->data),
> 


