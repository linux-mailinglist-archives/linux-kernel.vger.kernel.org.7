Return-Path: <linux-kernel+bounces-790174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B54B3A18A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CBB18875E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54063223705;
	Thu, 28 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqlIZZOH"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2E212B0A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391084; cv=none; b=CgMNG3Mna6JHFfSG4zCge2/GT1vBmgfHraLa+yIvQGSkygf8jeSsAvdGJROcvRSsg2Wyvag0aXrEkhwZNRiMKNP1/HvdaZVtdI1UNjzfES1RUdZ5eiy5j3scf9VYXSCO2P3Te7HO/PvZzqvaOZNX0gGI7K8px1gXyhOVU+EtLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391084; c=relaxed/simple;
	bh=/FUZ3GPbSoHCMLnSSqyt2z+YmIiFI7VibbClJvvxduQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QdBA8EPRgFMGizzsYCp4kI180kUyZMMpi8gkf5f2LBNQ1IrFlAOzd7P4lWCSZWO61zMHNGyr5k6YXavyzO2XUETzzxvTk/X8OALK1Z7/svo4SFqMATOduFOOMNBgnYKJMF6sNYfYkF2qrUFytzP6Nal6p5HKsC5WfT2GDoPbvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqlIZZOH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so1327937a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756391081; x=1756995881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zQUneuXaOfUh+xTN94Xip4u0CuKfuimGc68GwyO7co=;
        b=lqlIZZOHTZZ4xnW5Jelr/XU2Km2WfJUvHfQi0emQxM1RN8qSYHX5ZJSsMLfCqfDnwf
         UOMod4sjvwZpd81O/N2etmRRYaOpLPDP1SSMj2g3y82T5ufgvFnDpO7Q53z8DuKtvHI4
         h0o2CGP+gQvZGFUgDG4JI5OEjGKt8knAARZ+NDXoIVQO1vFFb3H122Wx1o5VACwITD8y
         txfvi2kbwdHxwJo2trD2ImvIK+G/2zkmzYfnvsJihtTkjtDT7l7Cc2tda7TcGzvh8TAv
         TZXzzl+bRqR67i3SWJt/pbYx+4eLAMC02yPWqXuAjOs0yC1tfkGOajbCHoYP1EOAYU+/
         RNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756391081; x=1756995881;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zQUneuXaOfUh+xTN94Xip4u0CuKfuimGc68GwyO7co=;
        b=cpJM3Fl63cmuzpyFklwf/seMVZpDqKj5BcBtcDbVz5U+qDKqEZsIYcG3vsN0Fa2e2S
         oRSf5zhrs5tuijrFvtFMT0HSD/405rLPuogM7PU7023uGbAAxiLVjCtOTQmhnONoxXYu
         H3I1d0GcTbQHy/0L36BvnpREQ2VmZoZEzUpOvlSwl2X+gH92Z3zdXFbI+xi3ReJ04Fw5
         uE+iBS+suPRXvE1FJwUY05H90MgKZG5+gVXbpaEEU7DY3s3ENYeOAaho5WenfAvWzznv
         UIZxh06kC3znOb5R6kqGWbiOayiH4R0QeF2dhac0nc7MuzQl35Zr3PgBz6mt5C+8bgdE
         lfkA==
X-Forwarded-Encrypted: i=1; AJvYcCWvHlRTpr+TFbJOBwFcI+T8q02KB+jiKobqlemsWsEi/Yc0ZySW28zEk2a0mLXBxD6/4vEJEpdTpsjLp5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpVNhQlm4Udkrrf7ThDmXvvE7i8lUcUHHXTgrqazhSKRpjklc
	0+18QVLUbPFWB52+EmQyI9IKhypnCjTDf4uVXLt14iPhW4GuDuByrYW/uURIBO8f2Gk=
X-Gm-Gg: ASbGncv6WypO4fvWAGvAJrVpHj6RtOOb6zRs3XyMZbAxteZ6bkIVziAiai1ViOXxItc
	YZ4X5C6MJN/kCFk0PnWU7lucjVy5ZNqGUXTmGjUGnbOz22Cw2dTjJ2ZFb3HxEVALPI+JN5RK1Se
	w5sIfG7U44ViFA74ROGcvnS1K0lFhs9TQKBfeLwla1yn6yRwHRcnny5tg1lRY/WoTEszEaSAFDb
	8iCRLbfgURTiK64ChyAuG/p2KXE6ZFbSbm05iqzsPtVFJfWsNvYOk5sjj0/c3oH3NtJnVa3+bBS
	OXNlbG01hvPVl2QEGnOrEz38sl1h1/Z/zpwsTMf/44eZCNfxAq+Kwjd9ll9EdCgt8IsVksTdAK0
	exu5IaglyfC0GYXa0hJ5PMSPbTYpycpJmeYO3FD00kfEDYAE5CW2CVXvStWlzOVPGeLf+jNDz8E
	5X6A==
X-Google-Smtp-Source: AGHT+IF1vN7HT36zey49ZEbRrWO4fa06Ex/wR33zWhhQXlp86FpsFXiY/mB0hsHLpGg2OthL7HWsng==
X-Received: by 2002:a17:906:478f:b0:af9:8d61:2651 with SMTP id a640c23a62f3a-afe28ec535emr1937046766b.9.1756391081186;
        Thu, 28 Aug 2025 07:24:41 -0700 (PDT)
Received: from [10.41.150.230] ([77.241.232.9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afef7489f8asm44327966b.69.2025.08.28.07.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 07:24:40 -0700 (PDT)
Message-ID: <a9c40b7d-d70d-48fb-b4a0-deb773969936@linaro.org>
Date: Thu, 28 Aug 2025 16:24:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: qcom,sm8550-iris: Do not reference
 legacy venus properties
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250823155349.22344-2-krzysztof.kozlowski@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250823155349.22344-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/2025 17:53, Krzysztof Kozlowski wrote:
> The Qualcomm SoC Iris video codec is an evolution of previous Venus and
> it comes with its own Iris Linux drivers.  These new drivers were
> accepted under condition they actually improve state of afairs, instead
> of duplicating old, legacy solutions.
> 
> Unfortunately binding still references common parts of Venus without
> actual need and benefit.  For example Iris does not use fake
> "video-firmware" device node (fake because there is no actual device
> underlying it and it was added only to work around some Linux issues
> with IOMMU mappings).
> 
> Stop referencing venus-common schema in the new Qualcomm Iris bindings
> and move all necessary properties, except unused "video-firmware" (no
> driver usage, no DTS).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../devicetree/bindings/media/qcom,sm8550-iris.yaml | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> index c79bf2101812..320227f437a1 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
> @@ -26,6 +26,9 @@ properties:
>             - qcom,sm8550-iris
>             - qcom,sm8650-iris
>   
> +  reg:
> +    maxItems: 1
> +
>     power-domains:
>       maxItems: 4
>   
> @@ -45,6 +48,12 @@ properties:
>         - const: core
>         - const: vcodec0_core
>   
> +  firmware-name:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
>     interconnects:
>       maxItems: 2
>   
> @@ -69,6 +78,9 @@ properties:
>   
>     dma-coherent: true
>   
> +  memory-region:
> +    maxItems: 1
> +
>     operating-points-v2: true
>   
>     opp-table:
> @@ -85,7 +97,6 @@ required:
>     - dma-coherent
>   
>   allOf:
> -  - $ref: qcom,venus-common.yaml#
>     - if:
>         properties:
>           compatible:
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>

