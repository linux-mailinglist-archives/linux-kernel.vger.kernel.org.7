Return-Path: <linux-kernel+bounces-865581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C43C5BFD7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10409563CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD618277CA1;
	Wed, 22 Oct 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r04J1A8a"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5C435B14C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152612; cv=none; b=li0mA0DKL1zEHxsXrIIiyDfP45rC2C/AKO+EZWH9IKazo3o+yNYQD/Zq5qpSTNd3dmWAJ/M22CEIpDDpruO3PrzYNAYRN6eMYXhQztz7GOrX6Q2qsuovfLO7XKCxoUEBzWyj5eQcHRbADwLKez4hRhQ4h2Ofngm84jyrtFIauzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152612; c=relaxed/simple;
	bh=R3kdlrw77LED+wsVg0L5dNH5LTE4fMRX/9gH9I9W4H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQCfUilsF5xuuNnStiQ1p/UXyiHjhH417yiXmj8801Ra557KiejTI0Od/EdE6J54RDZKrO8L2BQLuAi9ruGhNN4cm8BbwCmkK1pFfNCQoeo2O34/KvxV4MDiVA51fpyrLvwIvE889DOo/ivJnWsu/GFBIgm4X7CvyyD+FD4hxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r04J1A8a; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-651c8557bf4so1772504eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761152609; x=1761757409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwfGThHvmVcSe5ARp0+SHwJ01qbi5m3iOi3dL9nhqHg=;
        b=r04J1A8a59Xj7rlpvS+L3pPlkxMNFUB/C4Y0Xc1vO/7KO1Nc2T8PvX06A8nw/iCSCN
         7Be32PV3OQF7BuiY+/fyQ1OgJbnULv2jxiwwGXMrs42V7w81PoQRv09Kwf52OfMpY4WR
         OD2Sl3ymaVWRVdaweDUZlS5Jf0iGlzY/c8Y8+zqkErGM1B7BmExHxU05ksBxSpoxAtYO
         0p5/nMtWw+KZlESuj7iEuB237O85aYPRTL7LvPIMgasXsGhQKTCtvzpFtrzb1oS3SARQ
         +tsuTFlZvRAPgCblis60Obgn93Bt2quDdUqqF56r+okZhfLVfktmb77yYhrMPKKp3Tu1
         uswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761152609; x=1761757409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwfGThHvmVcSe5ARp0+SHwJ01qbi5m3iOi3dL9nhqHg=;
        b=KmpSUQMCFe56FkzaRjsmz9wFGPy9hf31c6OR5VyU+qUhyPuAy/VGLVrvULw1FU1IC1
         ob8eZ0QhlHd9ag3fURj90rgc1jG8Z8SXmsLFIa7O0Lzlm0JIvmxBL6KPyk5rtUDtSE7D
         jcgtmW+KKB7b2UVgKyRtBPhqG9xGE7+dsT1DcBas8Jpk2s6CH+3WrzWy9d3srbuNADn5
         A3XwGSl7EwBEK96S76Fxul1oVFgygQ+Dv20lzCRuaNxpHGAVQRHOuRwGUu6ypRy26tAh
         BEjTIjKvqDJ/awut7IuDPhUjlm3MDvx8Z/GiJEAefjjW8kiRDz2g73OitPwz0h4HpVkq
         3tMg==
X-Forwarded-Encrypted: i=1; AJvYcCVJiVO9qzFiwWXFdgUKzbhm+bB3FwChETT5saJ25i/xTTRXOAxIMiFQZG8BskGasXTaINSO2oFVJ9ZM3Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZCINNZs27sOWs6hWSelD2OBDGetZbHW5mm9AuLcgkdNsoiqr
	WqKLy3dGOAbP2ab+T+1tqr+J1lT1r8clgWtjeiZMOK+mBLMBs7vhe/nd97BRft67SiM=
X-Gm-Gg: ASbGncv2b1U12t5ccUSBOS6AVY3hviUiEQdE+FF8huGjX4+Qk12gJvp4oentnUGkT//
	vxvYlvWQoTZ9uLKwWU3RIzjNyiOotgPTS54eN33YxlDWsS6/aWGLESDhZISscL4iQ/7Ynjqf5ca
	SGkHEbqVS/cLuWmJB9y0tmRphFMDuOZ91CaIbjw8osKDtI2LRUOlHpg18OIodl3ZBcKKOCMN/kg
	sNxsev0S4FaTGjk4XOsQRBDtlAORO+e2EVtdVl3xMXcO8q+pyWN+2fHtyykUtFGLuN7a3n/PoPL
	p/SP7qdHEkomkddbT2uMfjowysI4WI2/ZXGp1GZReDxdgYzJfS6D06yHU+XTESb6klGqYyp72Fr
	kExdwJKCVwVKn60Hr+c4sVboBLOHYNiQjPBtZ7mUUIDWx+FC1bmcRvdVnFWdR2m9bZbklkMu3TT
	rutiYAAQOp6frNZUMARKchONedQx/L4V+kHNPlVZGhAGmZ1J+Bvf1t5VjDZLso
X-Google-Smtp-Source: AGHT+IGYMQZ96Ni70MOY6AUaspj+zxS7uLkggZkCTrutX3cSI3hydzShXPRmiBmHi5D+RoDJHRlsOg==
X-Received: by 2002:a05:6808:189c:b0:43f:5634:29ba with SMTP id 5614622812f47-443a2fb2c78mr9828633b6e.35.1761152609165;
        Wed, 22 Oct 2025 10:03:29 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65368f34be1sm318640eaf.17.2025.10.22.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:03:28 -0700 (PDT)
Message-ID: <0e00bb14-19c7-493a-9629-354bac3a273e@baylibre.com>
Date: Wed, 22 Oct 2025 12:03:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: iio: pressure: Remove vdd-supply and
 vddio-supply from required list
To: Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Antoni Pokusinski <apokusinski01@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Justin Weiss <justin@justinweiss.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20251022164154.2994517-1-Frank.Li@nxp.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251022164154.2994517-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 11:41 AM, Frank Li wrote:
> Some board designs connect vdd and vddio to the system power supply. Remove
> these properties from the required list and make them optional, since
> drivers/iio/pressure/mpl3115.c does not use them.
> 
> Fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx8qm-mek.dtb: pressure-sensor@60 (fsl,mpl3115): 'vdd-supply' is a required property
>         from schema $id: http://devicetree.org/schemas/iio/pressure/fsl,mpl3115.yaml#
> 

Why not just add the required properties to the .dts file?

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> index 2933c2e10695e..04703a01cf7af 100644
> --- a/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> +++ b/Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml
> @@ -47,8 +47,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - vdd-supply
> -  - vddio-supply
>  
>  additionalProperties: false
>  


