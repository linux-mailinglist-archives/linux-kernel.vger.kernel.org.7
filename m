Return-Path: <linux-kernel+bounces-814221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A57B55113
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0D07C6698
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AF131353B;
	Fri, 12 Sep 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfFWlPdb"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228F3176EA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686883; cv=none; b=NOwNxDAOq07nWica1C+HJD1Ls7mVxFO8NP5J4pIAeL83w9ZzvYw+HcBJjjKaRuOi15vTztdjBXbnbX+vIpuzQegsiEJejQET1/FDbi40xP+C+xoU0xnrrWbi+Y7V2Nso3uGcxcRRdl0OZz22RNDPVZczBeUCFkNN+FjpRt94yIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686883; c=relaxed/simple;
	bh=Q4rw3hqD7xfYTz2PjfHUSCWYx6GmHlLphHFHrEZQ64A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emlcb2vfWSvp8h6eBPfBpX6oyTLE8EVr1HdGWn2VUOMhfdO8q3lYbmb0QIkrGCsMNzPnAXfT7l0xs01ug/25WB9wC5bbvXNg6s3AKqB9lq7SqPDUFX0o8CZXoXKUNF/a7PRYuvHmWwJqvjFdU7reXz3vrU1ZqIxQzThYUxfVk08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfFWlPdb; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d44d734cabso1633950f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686879; x=1758291679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vw9oEMKP6t2zJ5WrxPI767ve9Ezi/7LUntIyA8io5Hw=;
        b=JfFWlPdbK/WwrPHrAjJ3XiuBxAouAnn4dsbCo65qQEqBynoU6Ove3ahe9pRLtSdKlY
         EIsyBSc9uq5E4njdOiVmJQi37aQlOS+ZUbeVcscqVZpnjA3Rx6e1oT8loxZDJwBjVnas
         0o+n0Sv+7fDQDuhpmFxWghT2glDVmnXSCscwCmWDaYti3lIXlDLzP32aPqLTZ0WSA3Lo
         +U5MVarVO45uCBwRXNBxOR0DthYROowqXAoy6MmQOBv18jWqLiRbxYzWM3ha+mz+zNs/
         iv6eyWFO8Y3GYxDXahQC6gwGxpqC+AthZsTNozLDV8/XUykMqFDbYdtpLKiEk+0Po0He
         og2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686879; x=1758291679;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw9oEMKP6t2zJ5WrxPI767ve9Ezi/7LUntIyA8io5Hw=;
        b=C477nk8mfHGfRT6mJccHhGwGbjuYK36BiajoeskYRJ4JQzhKe+bE3Iyw2Bq7iqu+yB
         DtdiMxFxGDuI5hjIXfTM2Gpitq750qcJCjpYQvLYbHLpyU9FpgPd7VNZVaUm5PL2i0ZU
         105dY1U95MO32j6KmEL1o4SGei05Du1iGP2uVHbM7RFs1IaPXgVKdINAmSuM1sSVzF1n
         k2e8w2FzrFS2lbVzEQ+/tHZpFFvDbBTNO6j7DQOxhNKi1ywPrIylLOz4zV6wMegVgQLN
         xaGy6tIa3jzXtTsZfiBSAscgpu9mVualivqF//JpGXABXsHpHuy0XirfneIckhp80csq
         V8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/8uFrB4qd+aPDTBOqBVPPhCHo4Ha3kos/LqTuHdlpsATRoQ9gVuawKQWRKHpe1QCCCgB3UhyaKev9AJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1lgeNPXhQBHjSymzdBaUpTdUxYvt74QEAnNVV9ta9jqAt9jCK
	eIJM/RqiglMRBBkatsBFmkD4Dq3hXtRp0rB12J6lvMxuC60TXdeUOziO
X-Gm-Gg: ASbGncvXWa4X5g7DGT7uIFh5dciEHRs8WJyJynMKWdY7g2OpXfTZyt9guHBIzFA6unx
	BVFqMtoDJ8fS6bQze9XXC9/UQ/+P7fkSxLPi8WXlCJlFaXce1rLNAA2dTTPbxr1YXa7SPOjlWA8
	q5S7e1t8tyfub0a8y5lNdEohNbYU00OIwZbfSvhHqxA3RsntFMagNEedtWQqDdELOyBMb1q+5e5
	/1rVhqyEFx/ehxRepcq5jAXv70LgR+M2Bb7cvYoCYZvoP/L1L48dQa5czBlYGr+DYMdnsriXvwB
	Cu16MEWptI5oe4lJRAl94ZhiVdJlMaNCryRsRJsdDekRX2vmdts+ylLVo5gPo7M7S9HEVx6HD7F
	Pm8FnwQPOSTHiL2RN23CduO2U9r87KxTpmLJs+tr+wA==
X-Google-Smtp-Source: AGHT+IFntwFrj6hvDClo8DDECOvHNBx/ZYTf0W4VlRfdOBkNBdr/e49WdTOHoS9sCIAf2OgrZ1iqXQ==
X-Received: by 2002:a05:6000:2012:b0:3d9:dbe6:e613 with SMTP id ffacd0b85a97d-3e765792841mr3488249f8f.15.1757686878585;
        Fri, 12 Sep 2025 07:21:18 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760787080sm6943265f8f.20.2025.09.12.07.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:21:17 -0700 (PDT)
Message-ID: <52a54697-4b42-4c39-ae42-ae03b4231acc@gmail.com>
Date: Fri, 12 Sep 2025 16:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/38] arm64: dts: mediatek: pumpkin-common: Fix pinctrl
 node names
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-mediatek@lists.infradead.org, robh@kernel.org
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, krzk+dt@kernel.org,
 conor+dt@kernel.org, chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jassisinghbrar@gmail.com,
 mchehab@kernel.org, chunfeng.yun@mediatek.com, vkoul@kernel.org,
 kishon@kernel.org, sean.wang@kernel.org, linus.walleij@linaro.org,
 lgirdwood@gmail.com, broonie@kernel.org, andersson@kernel.org,
 mathieu.poirier@linaro.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
 atenart@kernel.org, jitao.shi@mediatek.com, ck.hu@mediatek.com,
 houlong.wei@mediatek.com, kyrie.wu@mediatek.corp-partner.google.com,
 andy.teng@mediatek.com, tinghan.shen@mediatek.com, jiaxin.yu@mediatek.com,
 shane.chien@mediatek.com, olivia.wen@mediatek.com, granquet@baylibre.com,
 eugen.hristev@linaro.org, arnd@arndb.de, sam.shih@mediatek.com,
 jieyy.yang@mediatek.com, frank-w@public-files.de, mwalle@kernel.org,
 fparent@baylibre.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-sound@vger.kernel.org
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com>
 <20250724083914.61351-31-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250724083914.61351-31-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2025 10:39, AngeloGioacchino Del Regno wrote:
> Fix the pinctrl node names to adhere to the bindings, as the main
> pin node is supposed to be named like "uart0-pins" and the pinmux
> node named like "pins-bus".
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   .../boot/dts/mediatek/pumpkin-common.dtsi      | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index a356db5fcc5f..805fb82138a8 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -198,8 +198,8 @@ &usb_phy {
>   };
>   
>   &pio {
> -	gpio_keys_default: gpiodefault {
> -		pins_cmd_dat {
> +	gpio_keys_default: gpio-keys-pins {
> +		pins-cmd-dat {
>   			pinmux = <MT8516_PIN_42_KPCOL0__FUNC_GPIO42>,
>   				 <MT8516_PIN_43_KPCOL1__FUNC_GPIO43>;
>   			bias-pull-up;
> @@ -207,7 +207,7 @@ pins_cmd_dat {
>   		};
>   	};
>   
> -	i2c0_pins_a: i2c0 {
> +	i2c0_pins_a: i2c0-pins {
>   		pins1 {
>   			pinmux = <MT8516_PIN_58_SDA0__FUNC_SDA0_0>,
>   				 <MT8516_PIN_59_SCL0__FUNC_SCL0_0>;
> @@ -215,7 +215,7 @@ pins1 {
>   		};
>   	};
>   
> -	i2c2_pins_a: i2c2 {
> +	i2c2_pins_a: i2c2-pins {
>   		pins1 {
>   			pinmux = <MT8516_PIN_60_SDA2__FUNC_SDA2_0>,
>   				 <MT8516_PIN_61_SCL2__FUNC_SCL2_0>;
> @@ -223,21 +223,21 @@ pins1 {
>   		};
>   	};
>   
> -	tca6416_pins: pinmux_tca6416_pins {
> -		gpio_mux_rst_n_pin {
> +	tca6416_pins: tca6416-pins {
> +		pins-mux-rstn {
>   			pinmux = <MT8516_PIN_65_UTXD1__FUNC_GPIO65>;
>   			output-high;
>   		};
>   
> -		gpio_mux_int_n_pin {
> +		pins-mux-intn {
>   			pinmux = <MT8516_PIN_64_URXD1__FUNC_GPIO64>;
>   			input-enable;
>   			bias-pull-up;
>   		};
>   	};
>   
> -	ethernet_pins_default: ethernet {
> -		pins_ethernet {
> +	ethernet_pins_default: ethernet-pins {
> +		pins-eth {
>   			pinmux = <MT8516_PIN_0_EINT0__FUNC_EXT_TXD0>,
>   				 <MT8516_PIN_1_EINT1__FUNC_EXT_TXD1>,
>   				 <MT8516_PIN_5_EINT5__FUNC_EXT_RXER>,


