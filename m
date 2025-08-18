Return-Path: <linux-kernel+bounces-774234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521CCB2B02B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBAA565855
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA92D24BD;
	Mon, 18 Aug 2025 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOILh91y"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F92848B1;
	Mon, 18 Aug 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541462; cv=none; b=TLsXdq/VpVWwbbBKJYbCpA4gGdQ9jEq8n3QHmNlzWGjM27dNZakxD1czJCL1gFmVRtw0sZ5mwb0sHiLbUFsrIIcvhNxT7Ta+r2l5jYAjIzlWHmQ/FtE4E4OUBQ/9VCjqrHJQovrpfQEnooMq48RxC2yxcI4jWkTP4X9Y6B7ixOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541462; c=relaxed/simple;
	bh=5Pb5iHF4x8aSegm+B4xiClg2frbSzO0/VnSMaA8HE+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGezBJvcgHX0LYg6B9e2lZSDC/xerU1SNwGdShERetqhiO46Id86ak7s/7Vz4sjO0VKHzx8yS+XD4W64fDudRWAyK58SFxObuqlwlP9eu4XBi6JlhTsTR/WqWhOXRhGiQ0mRWMQDEWqiWGWkraoZX2wD42iKY2h9gZUUH9FiNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOILh91y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7347e09so716845466b.0;
        Mon, 18 Aug 2025 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755541459; x=1756146259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpNFY2zr1VsygjGbzhz+uBinN58GcwWHwnpY7MGqkVs=;
        b=hOILh91yes9KAzuwYQOf4JuRocfVWrlNfqxyvpe9jRzax9vqwPxHnhpGRR2U05bxdR
         kdsg/9nvdPoydFdSzndVgFcujXL2ZQVY96sBXBb8ddgZpuVXiR5j6RPJf3GvFwkJzWEs
         dIVIw9hCWpab6If5crThpRpkvYUj1p9uK9LnfttXlqLQoOokJO4io5RHzvAp51kuyGv/
         CUlP5pPgraCC3E9fzS937q9AZlo2AW2tVbVRNLCWXrhDAuLcuPmYfpWv2TzetFWj/3/D
         0eoQXuxBqvsaLHV4CHbxjjMeKRFd2G490QcPvnxDgM1TYLhuWy5XuivRjBF+R/fPinr/
         ++gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541459; x=1756146259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpNFY2zr1VsygjGbzhz+uBinN58GcwWHwnpY7MGqkVs=;
        b=ODAFdxCG24DYsekmcZ/nV1zpz/lTFgkkrvNAWZhihQM5ABKD5jMAV2FQnrAb6NvW8r
         NR2sF72/9v2jqQuzoIApnn9VsbTvi9maZG1MW07wC4KBVTT4ubILx915Svf18SLq737u
         Vto8t5LLyV6mMPh09Kx1gplkWtb+Te/eJ2cZGqiXtvbJwgrKzsKWJirNXsMNlv74SFYJ
         n+oHDBLbBBAXgZMmQD5vKG+yAxDFEN1keJyscgEZhdAHTbxp+bgXAU+CEE2lcmeO10+F
         +W7hC+uBIlzYJ9M35xiu45iH9GoriSTOEkqMzXKacRNQyyTuKFtFK6Dcey41VKhbBzyF
         gecA==
X-Forwarded-Encrypted: i=1; AJvYcCWtqhqOiLdvSz6oB1C0CQ5/HY6xEGy+RYUtsKDMS1UEqqVSRGAVnYMJwoEFbmcHTAjK3+lEEM2P/Vhg4dYa@vger.kernel.org, AJvYcCWu/rodghenPZVTPBTfIUgk6KBsqfh6yJwFaznuYSgyxkxbQYpjgktdhdwe3ljwAB80+IbRJDDJs93z@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJjBdnYfphlDbz0XMTyhVqQYDrhfSqV23YXCahMK88J0emyNW
	vcwrbmlX+iCBhariZpVVb06A/NdWJm67Xd/Jc4Ks+xBcGlVEMYjXnqUE2XHR
X-Gm-Gg: ASbGncvApeOj4aPc33Bbt+SntDRBicI8l5mUh3qWip98HXo+GHdmIjZJl7jzjN/USqQ
	UKK8PickMMhkMGejivG7pNxEtv8oKs7MMpu4UneBlujxx8sNOs/1xCcKMEsMpKfBrvYwy2nsRfY
	3V08iR/4IyOsnpCb5qfEdaujlZEVIpn0i8FY4K8iiHYnpArG+yxoMDTqB/snYsjGtOP40z0yXSZ
	4tQdfVSjp2Fyba/Qh1LvnmeHzMZOcvTKh9YuAslKiL673FWP5ziOMWgpAH9Zk2K0AewiRlNbtHc
	3NJAFsAw+lOtEJ4WdJNsBN07CjDQNmir+g6vd+YcKai18xuKPc9TDJ5/Je0F7CJ4lBh/LsnhbSF
	qlUoF09HYkLTDPNEcHJka3aleY2IEuxLYmTaaNhyuvCrCpJErbl0kAfPPOzTV1LMnQSWT
X-Google-Smtp-Source: AGHT+IEP3Kjp2u2J+yPrgUCMTkqSRo7LZ5tDQMH0zZ3JdCM3es1AYojWLj3afepK7WSFanZwbTQU7g==
X-Received: by 2002:a17:906:f5aa:b0:af9:71fc:726 with SMTP id a640c23a62f3a-afdd98e33c4mr44524866b.17.1755541458156;
        Mon, 18 Aug 2025 11:24:18 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:beb0:cc44:a532:3452? ([2a02:810b:f13:8500:beb0:cc44:a532:3452])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcea0ebdsm851063466b.56.2025.08.18.11.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:24:17 -0700 (PDT)
Message-ID: <5593866a-29b2-431b-891b-c15cb2da8361@gmail.com>
Date: Mon, 18 Aug 2025 20:24:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Fix Bluetooth interrupts flag
 on Neardi LBA3368
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Hsun Lai <i@chainsx.cn>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable+noautosel@kernel.org
References: <20250818090445.28112-3-krzysztof.kozlowski@linaro.org>
 <20250818090445.28112-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250818090445.28112-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Am 18.08.25 um 11:04 schrieb Krzysztof Kozlowski:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning: GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE.
>
> Correct the interrupt flags, assuming the author of the code wanted same
> logical behavior behind the name "ACTIVE_xxx", this is:
>    ACTIVE_HIGH  => IRQ_TYPE_LEVEL_HIGH
>
> Fixes: 7b4a8097e58b ("arm64: dts: rockchip: Add Neardi LBA3368 board")
> Cc: <stable+noautosel@kernel.org> # Needs testing, because actual level is just a guess
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Please kindly test... Not cc-ing stable on purpose, because this might
> have impact, so needs actual testing.

Tested-By: Alex Bee <knaerzche@gmail.com>

Thanks,

Alex

> ---
>   arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
> index b99bb0a5f900..b9801a691b48 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-lba3368.dts
> @@ -609,7 +609,7 @@ &uart0 {
>   
>   	bluetooth {
>   		compatible = "brcm,bcm4345c5";
> -		interrupts-extended = <&gpio3 RK_PA7 GPIO_ACTIVE_HIGH>;
> +		interrupts-extended = <&gpio3 RK_PA7 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "host-wakeup";
>   		clocks = <&rk808 RK808_CLKOUT1>;
>   		clock-names = "lpo";

