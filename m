Return-Path: <linux-kernel+bounces-893204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F5C46C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD2018897BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F3310629;
	Mon, 10 Nov 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vf/otQfw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35892FCC12
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780051; cv=none; b=afXiVIZuVJm+a2EkiajU1bn9/nB8pInRXcC62uzxe4MInPPuJqyWgEEk3SYdYqeg8NwlMCbTWXHE4Ui6YOPoqYCl+MPlk7qnk/MFccb640eMj4sXx7Ebp4v+QkAUuMYXcd83b77OyGu0AS0KvR/lY8lngU5XXg+PPPcYlXMKqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780051; c=relaxed/simple;
	bh=xLE0g0V6VtstEXCgX58na2I3K9PHtFDdOQGN69zLTms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwMtfnrOd7YnFP437sWDo9DFmkFOCj2u+S3iTAv6xgqkeABYNOSxiq4NTirE3MmIbv0qiM1yLPRFvrxNN772irU3tZpEEw0HLbbansG5iH5cWTsvgJpT7uNNKq9PefKKBoWuSyDDwij/0Fw1ckVG2dOJTIowIXPHOZZZJvbgROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vf/otQfw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47721743fd0so14470265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762780048; x=1763384848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4cJaSvdyQCbEMb76mhwbw00KVaPl98c0awaqdZ3M8o=;
        b=vf/otQfwqJttX7Cmx+sZy3Ed8WICcoJ58/hUXTGsHageFxn4m3AQAESc2NMFRZBGSJ
         Xasiu0RwIeVSI1pJ2bnUpy4PtKtU+/r74rWsLn1myMLYuzUd/emun1AHYDYPNq44V1ti
         2t4v7MjAZQAIyHg0mNe8tGhTRCUS/brU1c6R9eJWKmE7Qg3oAbwfcUqCLCv/iMV2Hwr1
         VMcPJhe6ECBZdbzqhfMcuyDjLeZCUkl6/dEAo3ysNHSTcEHj9qiML7bJjW1ukYDTGZuR
         tWWBOBvYtpSnIrNg5PoUcLi1gUFxJe6/C96L5Q0PKweRcR//W8iJFl1z+HsQJgsLC5ud
         okvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780048; x=1763384848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B4cJaSvdyQCbEMb76mhwbw00KVaPl98c0awaqdZ3M8o=;
        b=gQmZDNnasHhw2Bmk+jmYc/o/hdrJXwX2iVTQbAvulLuC0e+r5Y9jIs4Ws4cEJScBWB
         hiIok9j3JMLNlv7axeiUCeD0ubtoSuDbexM/+2c0YrduFpAkwGiFk7oG6/su3+H+QB0A
         /eAA10Spuo2F3eEtJOwExAnihPx/J3GjVH5DqShGGm9UNQZbzQ7cyi9ZMi8u0wkUxM8p
         dcmn5PgiisP+5NHSq3Ov+kRHyQ1tlnVOV2YOVOAFh5yBt8slOSaJoVTTkp1ybk9qZ4Rz
         tm/p4X9vrw6K1ivQD9qyRZa7tBg1afuX8XI/BL/WeCf3pO94xBQ8mkDqUPCOSYwDDAzw
         0egg==
X-Forwarded-Encrypted: i=1; AJvYcCUQNcLes8G8iOtvjuCaO0jh46yoBZuAJa58SiRfIDrttTDNIkW/aXr/8nOsFcINTp7YWlwF+ZcPDmYQzb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywya4et8Q9JagGdWZ3CxpzUo/eypJQDWjfYjy6kUjD+OiFMt15X
	cSuJ+kmJTP1glI7oYzt+S95Rtyd+xWydYK0X0+T0FUma7JCCiV7pbsMzHZ+Gw4ZfDP8=
X-Gm-Gg: ASbGncshFtE53TURZXR92bjVUotargt1xbpw69G348SvSqIcfEvMrUzRT4JPuvfLzOR
	ttbfIRJY0sdjn03/4J5p2rMiBMazHlUv24ziwyPJXrb/HXjz3WfZLyPGZQWQiL8x9b/EdcYsh0X
	dF710CcIDAyt3C2GOPHh9mJ7uta16BiS1p8uaubykXLOra6rgAO/4Bk5oUoJBKDpBv47gWOKVEM
	D1dpES/11VKJosnIYvi/vClrFWvpLwyS26JJeaWsmWHnfr3Et9oEGtbCsgkkmRvVO9bmqfMXTJH
	IlLn+eSwYuEq5/MOnyPD2JOnoWY5s5BarBHWiKabFRIRbjZ4jhhX2U7R+hgA3qfWiAg1g9fWH7c
	KMsY/oeaxIlcNkRD8dBDirWeIRC359TI6eVrRj4N6ZW9fSOEnPGQw0fIUk13gQVOETvvmaxCu2L
	/iBe8S/6tD0QB+SNV/zMtvXkWBFKgafm5/SSyqwIwMzfRYGhOsmecVfoE=
X-Google-Smtp-Source: AGHT+IHcCOONTIlqmfkXgQ46x6qRMAz8cIzqeP6tpBIy8/x9/ya7VMOfAxTxh9tydHHTLgqTp1lvxg==
X-Received: by 2002:a05:600c:3b8d:b0:477:641a:1402 with SMTP id 5b1f17b1804b1-477732308acmr85105745e9.4.1762780047939;
        Mon, 10 Nov 2025 05:07:27 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:2b20:d700:6e9c:533c? ([2a05:6e02:1041:c10:2b20:d700:6e9c:533c])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bd084d4sm252075645e9.14.2025.11.10.05.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:07:27 -0800 (PST)
Message-ID: <adceca49-acbc-4ae6-984c-5a8916aba8be@linaro.org>
Date: Mon, 10 Nov 2025 14:07:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 5/9] thermal/drivers/mediatek/lvts: Add
 lvts_temp_to_raw variant
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
 <20251016142158.740242-6-laura.nao@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251016142158.740242-6-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/16/25 16:21, Laura Nao wrote:
> MT8196/MT6991 require a different version of lvts_temp_to_raw(),
> specifically the multiplicative inverse of the existing implementation.
> Introduce a variant of the function with inverted calculation logic to
> match this requirement.
> 
> This ensures accurate raw value generation for temperature
> thresholds, avoiding spurious thermal interrupts or unintended hardware
> resets on MT8196/MT6991.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index df1c0f059ad0..31796a5b8858 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -300,6 +300,18 @@ static u32 lvts_temp_to_raw(int temperature, int temp_factor)
>   	return div_s64(raw_temp, -temp_factor);
>   }
>   
> +static u32 lvts_temp_to_raw_v2(int temperature, int temp_factor)

Same comment as the previous patch ... _v2 ...




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

