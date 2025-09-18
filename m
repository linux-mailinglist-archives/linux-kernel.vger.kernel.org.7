Return-Path: <linux-kernel+bounces-814215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1885B550E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7985A6F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155513126BE;
	Fri, 12 Sep 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIeJEpVu"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DE2FDC4E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686819; cv=none; b=uZB0lMMB98SYxIFS51IyMNCpu3t0JtMJakIXS4ANJrsA0804Xme3PqRj6X1HyqOu3UkCFtHDtLyOYTDhNZtVrRNKcLR4wsH14J/2oDWSdkeukNDjARjsRNfkI6UcLobUqIRbb7jwZtHXsMyGEEmGt+RyNzBCu2kq/12i66K6HgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686819; c=relaxed/simple;
	bh=EVbOp99sPb6YaiW0/j7yT/7PlojN9LZSWPvpHmas4ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRQ/kHJaRw+S+5K4Im+TxSjLc7n7d7NzD0cw/tGVZqIwa6KvJOFuKhPxLJg+/UlowrP3l3+GwIfKM21FBttK7if3+/fhs6kTh6wic6CGzQIwzks44jkU0gVXcU+ywFk4DBIVIHLnEcONfzVUY79AIGQg82h0snxzmkh+QYVkIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIeJEpVu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so17719595e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757686813; x=1758291613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo6qWVc0jZZmv8jDaeRnPGtja64w2ge7orZf47CFJn8=;
        b=AIeJEpVuhdfEU02IC7XuGXzI037Wc9g59ptXd5n5XQxKAR6P8FZ3WxxvDiiRyPccM3
         95+zGxtWVQPAcyt39cCFlJwgTksIQr7tB6cc0XKMAEatPNNfErY2YHKFxnyIKUzxe4rc
         WdJdlJusv5CZt/I4+VBaJ//EwCEFE9Y0S5kXu9764DjiONUXV1iR8lzzRy+zptbkKIY5
         KESI3BvUIvlL9Ch7i5JFRCrluQaUTAK6s9WL1VDp7V58SlsfsDOSn4uW2v6+2A/flOQP
         W+7t7NzxGq4LzsqPItg1htrmzTsaQpal5alyeLct40DAQiiQScrUSQUUccCkDmQTFE++
         QHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757686813; x=1758291613;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo6qWVc0jZZmv8jDaeRnPGtja64w2ge7orZf47CFJn8=;
        b=Fui6HKFWTnqcJUsY1dwySPwqIeGAYepQIAO7YliZlAiZmDg6qE8fPlbnwr3JUApKOV
         iB4flQuDDmILwVITRZlINxD3nT2xz2hyEOjFu0xD6uK3KiqyULpFBqGUkYDJ/p89cfHt
         a3cpksrFZNwiHC8p5qk+cWiKjRc+DF0eCgBb3nZ9m5p6/0CIO1G7U21MqUfVHeSnLkyM
         N93O70N6G/fpWqtN11N8dH3KYOYoPw6saoXM3UIIUWAWGONo3uj9gaz6GPd1s9HTO2Bs
         r2QIEPWp3lpZHElPZSTSQBLY53rUWwXXCu02uFOwsaRFFCqym+ALN3yWBY3XmrolMgU9
         ojDw==
X-Forwarded-Encrypted: i=1; AJvYcCVttnQ3SEz9Dw8qnahJ9O5pO/+sMjgFonZoupKiYdRE3yTrcT/SRg+/3n1u4EJqjyIl+AH/OdMbje3LBRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqSVV/b9fMW7LlDwsU5fGr3VamrGAAODhGn2VWOHC2tT5djXS
	e+m2qi5O1NmtVJbj0621SOmbsQhAsXYiaW/zwh8qZdhDb3sD7dTi1H0z
X-Gm-Gg: ASbGncsWS3VohnqDGxORS356i4lTCXcSoZkXKWFmNUeoCEQeAzZFUJX/6D9l+MvRPzt
	xl7VxxSwtZfahMI9vT8ZSZYx7bsT8/70ceGRyIy/U0d7c8b+IbNKVjqXOlicobzgXrni1nCg8Tv
	+4shrV5WOWoZgG4CDADscWG9W7KH8Ede2lhs1FezAjD6Ijklp7DQWfjw6WwDq+WdqbGFTtZvwUl
	M7mJzTGas5Q73axXIvjDFFUo4/u6/CtaNAcw/ieXvjwiuUJMImn3qJgVCFnqosZXk55XUk3etTz
	lQsnnAn4fJ97JtF1sDMHZThbFqQbfONul9aqGqOK6QPGcGRwL3OphZba/4iTB2rwzluiAnn1/Uu
	bSmgVqN8UasO+IQrcqElwTlbc6XYaxIU=
X-Google-Smtp-Source: AGHT+IEYiPOKWB+0nvhix6TOxrJpFoMyLdNoRjDPkAz1Qots2CwSj1hz+7mDLBhL/v2fign1H2JEQQ==
X-Received: by 2002:a05:600c:6610:b0:45d:cfa4:ce10 with SMTP id 5b1f17b1804b1-45f2128d4c1mr29424165e9.10.1757686813242;
        Fri, 12 Sep 2025 07:20:13 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm63475385e9.9.2025.09.12.07.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 07:20:12 -0700 (PDT)
Message-ID: <bde30144-0c57-4d34-b6cd-2a53dc099bdf@gmail.com>
Date: Fri, 12 Sep 2025 16:12:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/38] arm64: dts: mediatek: mt6795-sony-xperia-m5: Add
 pinctrl for mmc1/mmc2
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
 <20250724083914.61351-22-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250724083914.61351-22-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2025 10:38, AngeloGioacchino Del Regno wrote:
> Add pinctrl nodes for the MicroSD slot on mmc1 and SDIO Controller
> on mmc2 and assign those to the respective controller nodes.
> This makes sure that all of the pins are muxed in the right state
> and with the right pullup/down(s) before trying to use the mmc
> controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   .../dts/mediatek/mt6795-sony-xperia-m5.dts    | 38 +++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index 03cc48321a3f..fccb948cfa45 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -227,6 +227,8 @@ &mmc0 {
>   
>   &mmc1 {
>   	/* MicroSD card slot */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins_default>;
>   	vmmc-supply = <&mt6331_vmc_reg>;
>   	vqmmc-supply = <&mt6331_vmch_reg>;
>   	status = "okay";
> @@ -234,6 +236,8 @@ &mmc1 {
>   
>   &mmc2 {
>   	/* SDIO WiFi on MMC2 */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_pins_default>;
>   	vmmc-supply = <&mt6331_vmc_reg>;
>   	vqmmc-supply = <&mt6331_vmch_reg>;
>   	status = "okay";
> @@ -311,6 +315,40 @@ pins-ds {
>   		};
>   	};
>   
> +	mmc1_pins_default: microsd-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO171__FUNC_MSDC1_DAT0>,
> +				 <PINMUX_GPIO172__FUNC_MSDC1_DAT1>,
> +				 <PINMUX_GPIO173__FUNC_MSDC1_DAT2>,
> +				 <PINMUX_GPIO174__FUNC_MSDC1_DAT3>,
> +				 <PINMUX_GPIO170__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO175__FUNC_MSDC1_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
> +	mmc2_pins_default: sdio-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO100__FUNC_MSDC2_DAT0>,
> +				 <PINMUX_GPIO101__FUNC_MSDC2_DAT1>,
> +				 <PINMUX_GPIO102__FUNC_MSDC2_DAT2>,
> +				 <PINMUX_GPIO103__FUNC_MSDC2_DAT3>,
> +				 <PINMUX_GPIO105__FUNC_MSDC2_CMD>;
> +			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins-clk {
> +			pinmux = <PINMUX_GPIO104__FUNC_MSDC2_CLK>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
>   	nfc_pins: nfc-pins {
>   		pins-irq {
>   			pinmux = <PINMUX_GPIO3__FUNC_GPIO3>;


