Return-Path: <linux-kernel+bounces-808195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E7B4FBB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4569B5E3181
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DE533A002;
	Tue,  9 Sep 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjMZKqxE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382532CF97;
	Tue,  9 Sep 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422121; cv=none; b=Z7IEeXWsL66r/JhyYiqmI/fA4oXNGukcteJa+wDdgVhtpZIaPL/qeI/QsABUpSo2f4q8Lo3dPhwMUgfoOps40kopSrBdC7TFmPySgKKEv58BNSiEf5lKDSPmYEvgDU26TreP/TkJaqKeJacspbKjtBwBgXAC6JqtOzgXjemiqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422121; c=relaxed/simple;
	bh=8hIcTZHBz4F3M7tpWlkYF9MPt5yTgSEnrTO4tPyBtQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ibNFuhl7IuSJNlTtVyDUm/mW3Ea1yAYJDqr53jWdzS5E8emoz9JKyEPAr74IIrX3Goky4KmEM/FGI4m1ZQZKYPxy6/VXwjts0gvGxIyMGH7eaQoV6TIRGQ/R4CWb9ns4+GLFvcZ9rBTX6Vq0j4YmqCiRFoQ1XifuaAleGKjA7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjMZKqxE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso1655817f8f.0;
        Tue, 09 Sep 2025 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757422117; x=1758026917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SQzA72vB5rb+Qyx2YAgEg4fc6nWWy+sWKxhpGJjN6j0=;
        b=MjMZKqxEvw5xyAuOuUKbdrhO/EwoxgHpnXbYFHtDzuOOIpDF8j4T3bDe9KoHBmAra1
         c8k325QxfcRlbojdbO42pUUofld4yfHwaFzpUvBBingGCkEMzosA+9G212r8FNuViYD6
         boF28ro3UmTdj0ED0VZQIGvhtXhyeYA7UDVrilbzJa3IU526UfUfZC8+CMTt5VqlawKL
         EgJpOwWuM2fa4PZeRsxgGxPi4v67GxRDzYeGWiHt3knsq9OmdnFV1jPF2m5oFPb2itDU
         jPG2REOhjaOKo+wH/u6q1pHgMemYORs1RnNcmSyQG8CHze/uIoCdQKBfrN2Xxy8sxS/x
         QQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757422117; x=1758026917;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQzA72vB5rb+Qyx2YAgEg4fc6nWWy+sWKxhpGJjN6j0=;
        b=QdQN3pUoAD1z3Ydikn39F4Rq5cIGXFSObaqI22TzUuvoipb8vhuVmw7F5YnbEglUUV
         Y63eq3Pde2hBMfJ9u+D+ndqaEWoFtaNOaHSZl2hI1c108SiDvygStz1pezUMMPKH1+BH
         aHEqjFi0KK0i9ODAT8fFclWpUPtZlt9s1C2ByUr3pUhOWM95UT1DPpPONp+GzmOwqVnf
         GB2MUXIuuFdeyXfP+ntW6k3i8HbmU303oC6b1K5JTXiTX0v5erB4gYMyCjRS31g9u2DP
         KeYa9srzNx8I9GlJXfSKekDz+mw3iZllXXzWm5BfQB5zLXm0NKOZh8slcqvij220zf37
         589w==
X-Forwarded-Encrypted: i=1; AJvYcCU7WNWGakmAH3sm/eBPidnOCaTS7ekbOLu1HZWwlDdmVj0H5dEhWp3OUeL5b/NSbbzUvSq9f0EGRWlA7f7L@vger.kernel.org, AJvYcCWJxgaw9hdadvO9P8KjG5wcuB+t9W1SRobSl7upVCh9Twh9Y20klz9ouS1WyKVZwN/chQ0d+IW/H+eN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5qqmRMCp/z0ZZUoKWS45iEGmc+scy+rxDStHUvgwiopnTLx8h
	mv/KQypuk8EpCOQfkyQ0uTpDa6jVJEc/4hw9urLBayuQOZi9dfujXfWI
X-Gm-Gg: ASbGnctn0mRYNOgJcREoEwACuPZx9ulNo05kYkNZdnR5o5MvMUjndijADgCM8UB18mw
	z5tITHw1ILqJYY51ycprd6ou4C3rE6q4rV/sAy/PxlOWmmLSM7w/0rdWdFryTTKxkUFtB+Sp7wj
	pmYWO5ghEvnQiKUK74dhIy7sVZ0NwR+Y9jrHKqTba5sjDRpHT1KWOGK7n2EWHJmaVnFydHPVmgk
	nvbl/28LA4yT07M13TYGbe4GMEb6NJqRPhXdFMwfi7Nx+UZ7b4opfb0YPJNbD+X9UA9yuD1mQyx
	XTWlyM9/jzINTffOEUFflxswILfPa44NWHvrqS/5TgWPRG4MLW7cmIHfSmp0zMa+x6+jJ7MgwbK
	azGQ9wRyZ65YbyJPuPYVNbdmYiKohLd3B7d9jFYfHcQ==
X-Google-Smtp-Source: AGHT+IFnpIPMqhgwAmc24Yjj3C6LPW1OFkzAg5gcGHa9lijQlbcwkpw/dFtSXTnJD8l3anSqWnsPkQ==
X-Received: by 2002:a05:6000:2f81:b0:3de:78c8:1218 with SMTP id ffacd0b85a97d-3e6356751ecmr10315792f8f.30.1757422117298;
        Tue, 09 Sep 2025 05:48:37 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521be57esm2557253f8f.2.2025.09.09.05.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:48:36 -0700 (PDT)
Message-ID: <1f4cdb18-39bc-4c30-bf6c-29b4f70641ec@gmail.com>
Date: Tue, 9 Sep 2025 14:48:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] arm64: dts: mediatek: add thermal sensor support
 on mt7981
To: Aleksander Jan Bajkowski <olek2@wp.pl>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250907111742.23195-1-olek2@wp.pl>
 <20250907111742.23195-2-olek2@wp.pl>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250907111742.23195-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/09/2025 13:15, Aleksander Jan Bajkowski wrote:
> The temperature sensor in the MT7981 is same as in the MT7986.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Queued, thanks.
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt7981b.dtsi | 31 ++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> index 5cbea9cd411f..277c11247c13 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7981b.dtsi
> @@ -76,7 +76,7 @@ watchdog: watchdog@1001c000 {
>   			#reset-cells = <1>;
>   		};
>   
> -		clock-controller@1001e000 {
> +		apmixedsys: clock-controller@1001e000 {
>   			compatible = "mediatek,mt7981-apmixedsys";
>   			reg = <0 0x1001e000 0 0x1000>;
>   			#clock-cells = <1>;
> @@ -184,6 +184,31 @@ spi@1100b000 {
>   			status = "disabled";
>   		};
>   
> +		thermal@1100c800 {
> +			compatible = "mediatek,mt7981-thermal",
> +				     "mediatek,mt7986-thermal";
> +			reg = <0 0x1100c800 0 0x800>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&infracfg CLK_INFRA_THERM_CK>,
> +				 <&infracfg CLK_INFRA_ADC_26M_CK>;
> +			clock-names = "therm", "auxadc";
> +			nvmem-cells = <&thermal_calibration>;
> +			nvmem-cell-names = "calibration-data";
> +			#thermal-sensor-cells = <1>;
> +			mediatek,auxadc = <&auxadc>;
> +			mediatek,apmixedsys = <&apmixedsys>;
> +		};
> +
> +		auxadc: adc@1100d000 {
> +			compatible = "mediatek,mt7981-auxadc",
> +				     "mediatek,mt7986-auxadc";
> +			reg = <0 0x1100d000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_ADC_26M_CK>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
> +
>   		pio: pinctrl@11d00000 {
>   			compatible = "mediatek,mt7981-pinctrl";
>   			reg = <0 0x11d00000 0 0x1000>,
> @@ -211,6 +236,10 @@ efuse@11f20000 {
>   			reg = <0 0x11f20000 0 0x1000>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +
> +			thermal_calibration: thermal-calib@274 {
> +				reg = <0x274 0xc>;
> +			};
>   		};
>   
>   		clock-controller@15000000 {


