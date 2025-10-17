Return-Path: <linux-kernel+bounces-857975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8EBE86E8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA85189A96A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F2332EC2;
	Fri, 17 Oct 2025 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woRynFul"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4E332EA4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701208; cv=none; b=IInakAqnFYDpLavRJVA80HobPCa59wBf4xKkhQyILjxVxcyBfvmC0fxK5/S3z+8zH9htv+6gHZpZLQ9p0qfgayGDv26i+7Mcr3XyAbOzxleFpDzQEcSkw9fUfDDXppBTvn52Bs+rrvay7NlJwNWcPhEcvqLDQcHRavpQEfWE5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701208; c=relaxed/simple;
	bh=pBvCaNFbLjL1ajs/K+mrwrVvhl65E2/fbRYjA+GaWuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw4nn1b+whegpSqHb5qcURNyjiUimtKgu+KSp+3KSvIoto0AvP6RVnuwjzJC5Y/bJgWK8fiWvndNVr/209I36EPJtcXVi8ZEhkKE0NC/hPgghhNNWhLoWrU53uwf9zRqv3VPU3ZikpmTel1Wz3zu/oMFmetLHEX7skPTUv+9sR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woRynFul; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4710683a644so17140605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760701202; x=1761306002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zD2JbSDE6RoiAIBCAlIlJSpe5ld/inYGH7z8Pk883Ok=;
        b=woRynFulPYG0Oyk7grDerpZBVFi0OHeYTlxv/VZU+8PE6+QUwKajZzudAaL2CzLuCh
         BgFs4sbqH8kLEZ/Utlk+EIg9ZaR3PXs4vsJPB0JfHMtadstQuhKwBFub9itB86UWlVZ0
         h66HboCFhzyliKKepOgSYgllzOrMyTZ8Rh3SpbyOVOp53odhX337sAjS7nh3RfpqoaBq
         JwGsDhN8yEb7iFkZMdveP5+R+hpBJGOYZpSnQpP1AWaBINDoTIPrYkHQBhtfVIJqZrhL
         XWi/xmDQ3tBDl8p/Hrx8qeE3umfR4d7C13BjImb1+rTFAovtbFJh5NaPrSfdAxJf0Eqt
         5wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701202; x=1761306002;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zD2JbSDE6RoiAIBCAlIlJSpe5ld/inYGH7z8Pk883Ok=;
        b=pXakPAEu+txKWGcARmfVZ/j58Xvg8iNT2zfZZ2cMkXB79Go0J+37mBQvl+7mRPNLnH
         TYUrwQRsx0jltAB5ko+o+p8piP/FvHzFDU29lmbzIGfMuJrhrVZH6QVzWEdyxkRod6Tz
         Qcw+NH36cPkkBWkwhwV7KiCjMz4MKUsvUxZFkr21KO2Dx+PJNFPVML60f1lVy+ow5wma
         ghTyy0XohS/RZ2Oci8YD5Q93dhPlrgHi7hjt+QKEjZ5jHx4cp5t0AYWoopIGxAIt7zzv
         BOgoLyeKLoWEDwZUD0DsVCeQUR8IScJho5k67tbZfSYxGPh7eVO5+i9c32rX7bpgSPGT
         GuKA==
X-Forwarded-Encrypted: i=1; AJvYcCXFuXH3BtM3LFp+ZjcQUPEgE1uK5Krb7hskgWIOv7GM7Va146nzWd1yPhicKPQMtVP2ETsELJDnRuQRztw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC60EDbDQhSZ+0RZ08noCCrro7R9cunK5VNHr5xgHF+GqB1Ve
	aP0S263bbHe+4MkTEnW1xSL7rzA5sHat8Y3hXoX2rbFK3oD+XK0bJknXjXmuQIJUjHg=
X-Gm-Gg: ASbGnctImAAcmeW7qlQDQcgaS1M8Mc4qYbuDrG8+sQcENIE30B+k64IJnj5TJw4feSn
	h8n5DBHJVdudGmQTJIyJ30xC2WCwSaABlWaVhgrY75XDH/KqhYHfUPfYqletnKqRfWqmH0BXtAo
	dAblEUYZeGJwiaszr1XvdCHUhKTg3YIixDFB6MYVFgrFkuuAO4Wr+0A37hLesiLkMVna6tHocNe
	8/vwP14IlliLnaISCvQzdu/aQOe3BFmge6Fo5hzEW33UcYPrMwRbfIBMZCi9d3pUMohHB+GKtHo
	t3GI/u2cAg15csbABwya6Wj5JH0pn5a2srXSr7tK4iK0en0XzTSzDhR5crJk3a621kbtytWITa0
	95j2VI3ngjSLWkZoPI6LwG4q02GB7ckcG5pH1Mb2ma8dSJPjEnXCX8R1QZf+8VVVdpqJ7l1yfGs
	igTcslrVmgR1vgbYgkBhM8U289KSXn1eazFLca8WbIQw==
X-Google-Smtp-Source: AGHT+IE/DIOgsfLCWQQMCTsozZIv5WTDmox6lYMK+/kj99Jcq4cHsKuIYoT1ShbMmlzr64nB2z1jRQ==
X-Received: by 2002:a05:600c:6290:b0:46f:b42e:e38f with SMTP id 5b1f17b1804b1-47117345ffdmr32045745e9.19.1760701201703;
        Fri, 17 Oct 2025 04:40:01 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426fb279857sm11190319f8f.20.2025.10.17.04.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:40:01 -0700 (PDT)
Message-ID: <ecf63295-e92d-426e-933f-4efbc667b9af@linaro.org>
Date: Fri, 17 Oct 2025 12:40:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: venus: drop bogus probe deferrals
To: Johan Hovold <johan@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <iRhdXfjORNkpF-OnZ5iafGKrZq5VC_n5X3M_wEBMSzbXpgAoQxgdKIfdAWbBt_oC7p_b1pa226Awh5cp-kR95w==@protonmail.internalid>
 <20251017055809.8037-1-johan@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017055809.8037-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2025 06:58, Johan Hovold wrote:
> The encoder and decoder platform devices are registered by the venus
> driver as children of the venus device, but even if someone were to mess
> this up no amount of probe deferring is going to conjure up a parent.
> 
> Relatedly, the venus driver sets its driver data before registering the
> child devices and if this ever breaks we want to learn about it by
> failing probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 5 +----
>   drivers/media/platform/qcom/venus/venc.c | 5 +----
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 55c27345b7d8..2d822ad86dce 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1778,12 +1778,9 @@ static int vdec_probe(struct platform_device *pdev)
>   	struct venus_core *core;
>   	int ret;
> 
> -	if (!dev->parent)
> -		return -EPROBE_DEFER;
> -
>   	core = dev_get_drvdata(dev->parent);
>   	if (!core)
> -		return -EPROBE_DEFER;
> +		return -EINVAL;
> 
>   	platform_set_drvdata(pdev, core);
> 
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index fba07557a399..f1abd2bdce6b 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1560,12 +1560,9 @@ static int venc_probe(struct platform_device *pdev)
>   	struct venus_core *core;
>   	int ret;
> 
> -	if (!dev->parent)
> -		return -EPROBE_DEFER;
> -
>   	core = dev_get_drvdata(dev->parent);
>   	if (!core)
> -		return -EPROBE_DEFER;
> +		return -EINVAL;
> 
>   	platform_set_drvdata(pdev, core);
> 
> --
> 2.49.1
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

