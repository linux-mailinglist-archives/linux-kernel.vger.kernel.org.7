Return-Path: <linux-kernel+bounces-893160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B968C46AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD008188C804
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3691DED7B;
	Mon, 10 Nov 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHLzUCQC"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A24430E0F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778532; cv=none; b=uQQLI/U1hORiMm19k9P/q42fN1YKBNgQGaAgT2Q5InozEOFCtPkQjYaF4v3Bc/oTKjJZ2ooEi5N8/z2KsZYCF5s0MH1rUkMmIS5VLaLpkXhX5r39DYqlYyNTDK38L0nMu57sIwN3x1YY64xEGLDG+j+GKyJihHcF3I8FKAtvNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778532; c=relaxed/simple;
	bh=4nBpBSOWAyXa5p1SawHF2Z0qXdpStWEQvCVLK9Q7K1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfaJR8aUoYnI+Yyt5vD2DCiL+Comk1SuMH8qD6wPdxyOUx04ShB+q0Cum7/03q1K6iHfxew49umhtgAhyEP2XYzlnq0uiLIVYgR6jtk5KjcA+kQnCkIOz/ZeMEnV6YtnP5YMS+Ow4gxvKB+Nn2oLJbN7qfa4CzbbqOLNZbgT8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHLzUCQC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2dc17965so1523823f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762778529; x=1763383329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+N76mxcxihAP3O+FLFRElIM/tYwXLZuPej3Jupgfxo=;
        b=EHLzUCQCD5gFoTvKy93z7IU4JqD+GHBwYv/S5azIk/i00QOrGSts7QsevsAkL65Oyk
         6RFfQNdWYjFBYWDjQ8HIm+R21g7CN5gBijLAGxH5OpPxb5jN4xtz+wyJiLUQxamd/cW1
         XwfQ9BTF5GjBTgvQXw+QLfIUyVhhqbsRsAn2LBeJuU3DDSoJ5jry183MMjWGYds8WHDU
         MvsxDRPBBeqojK4U9mSwOVEdfRwUkWSJqC2DuP9lj/ols8OmU1XmNhu4rqr6u/B3FRdo
         dNUFjrkdAjpR8qaljyyTI0b0qCtuCa6HlzKTqExCjce9b45sN1jQxD/HTCS1nAqdRFzz
         6gXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778529; x=1763383329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+N76mxcxihAP3O+FLFRElIM/tYwXLZuPej3Jupgfxo=;
        b=N+Qmdt2DbqOgLBSYksM8ko/ryFl81KHyOdPlqv/FyKJJIqmbcK55iXhvWql+NHHKCd
         0OwEG5ni6s+FGM29L9GiGrgqMtszVg6RuSx7ye2aV9UfIbdBku7HNBP0WvPhDO/JEIjh
         G7MIQQDALO54IBae+RyhSu0GD+CqlBEoeFZf7zAf6Ub5RT/qqjNejfCcYZnrJjgU6SEL
         +7uxlCT8MDj3iAZ3KMut+PSWkqqOLYO6pLvZ5SZZA2ahWodOj1dj4lM8Cq+vti5JG0fD
         PA8siaYBm867wqV3TbbhLcZ9EKb23aCVM8tttwBSJAJOtRmJ1LRO8KqwC0Pnmy/UkzkN
         8Saw==
X-Forwarded-Encrypted: i=1; AJvYcCW/2Yk7MgeZyPWoaBdXbMtCsPlWKlv9qCW2Bq93Q2gIR2nINye1DdphQAXaff7YGEB770lSrNaQdz4oXyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmoo/v9mEygk0NH55oM+DY2uLqhTiOSZHwoWZ86tsf3G/snP3f
	tJqNCn8HokmX0xHvN2QRzdF3CfXWVce3g103bcq4Hv5LvypWblml4+1wq9Lo+76wyXE=
X-Gm-Gg: ASbGnctyv0AGxOCss3vd/CHj+dwW8dpKhy01BKzD/euNn6zTNCr+QxMMLS8Q9NosgOC
	0cPPCBGww34TWoZCrIs6DmOUDlSuk97LibOw7OL+hwxxoof1GXNkc9n2BqFKgn71mmS8XJqmeRR
	DG4fQmnOMHwGv6OF9Z5D4LQkmUZOS1qpBLoU5j20B+d/Knp4nb7ZvI241vOq3z/4aFqClFkscGx
	NmSVW+NLJcmXBGQDpKYqvUIGf7SAq22/ESSkdfNxNNsAQfrJHhiOzH4Cvo0QXu3jkqbfcTIPJev
	ec1uIxtx6Z1uJzsbKsvKSdD/Aq0jEgphradUnO08SIQC5w7/Wkkbi04mo+p4UOe03PTjpiVZWjG
	TWnE7hseId0+J5pfjIW5FNDZm4RkvLk/QpZxJIwCAL5bWDU2HjAYN2uWwP/F05YDE3pOfWTjeLR
	SWA2X0nbtPsifU5I51r8sXD4RVYuRhppz4K5aQNKbwcP9pl5ZFLCcdvtC4e49PGZSL9A==
X-Google-Smtp-Source: AGHT+IGNKo1M31mUDoARlNl8zibaXqZMwervmekEB8cz3HVAafXXSH8iFrMG/LkjJqzdboVDP9+/mg==
X-Received: by 2002:a5d:5d81:0:b0:42b:2c54:d9ba with SMTP id ffacd0b85a97d-42b2dc1e51bmr6642107f8f.20.1762778528609;
        Mon, 10 Nov 2025 04:42:08 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b35ad7c16sm9213468f8f.15.2025.11.10.04.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:42:07 -0800 (PST)
Message-ID: <84b9fd00-ce75-43bf-a53b-48818628f7e2@linaro.org>
Date: Mon, 10 Nov 2025 13:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/9] thermal/drivers/mediatek/lvts: Guard
 against zero temp_factor in lvts_raw_to_temp
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>, Fei Shao <fshao@chromium.org>
References: <20251016142158.740242-1-laura.nao@collabora.com>
 <20251016142158.740242-4-laura.nao@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251016142158.740242-4-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 16:21, Laura Nao wrote:
> Add a guard against zero temp_factor in lvts_raw_to_temp() to prevent
> division by zero and ensure safe conversion.

Is the temp_factor something else than a ro data statically initialized 
by the lvts_data structure ?

It is pointless to handle the case where the temp_factor is zero. If we 
read the temperature the kernel crashes immediately (which means it was 
not tested).

The temp_factor is an internal value of the driver. If the temp_factor 
is zero, the driver is buggy and should be fixed.


> Fixes: 6725a29321e4 ("thermal/drivers/mediatek/lvts_thermal: Make coeff configurable")
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1c54d0b75b1a..4ef549386add 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -284,11 +284,14 @@ static int lvts_raw_to_temp(u32 raw_temp, int temp_factor)
>   
>   static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>   {
> -	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
> +	u32 raw_temp;
>   
> -	raw_temp = div_s64(raw_temp, -temp_factor);
> +	if (temp_factor == 0)
> +		return temperature;
>   
> -	return raw_temp;
> +	raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
> +
> +	return div_s64(raw_temp, -temp_factor);
>   }
>   
>   static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
> @@ -1346,6 +1349,9 @@ static int lvts_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	if (!lvts_data->temp_factor)
> +		dev_warn(dev, "temp_factor should never be zero; check platform data.\n");
> +
>   	golden_temp_offset = lvts_data->temp_offset;
>   
>   	ret = lvts_domain_init(dev, lvts_td, lvts_data);
If





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

