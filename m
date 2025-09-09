Return-Path: <linux-kernel+bounces-808180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B9B4FB88
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006C34E841E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CC0322A16;
	Tue,  9 Sep 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X07IXt6D"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1A33769D;
	Tue,  9 Sep 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421759; cv=none; b=k2XoSo6KMLWdh1PmPfKSGm6+oPaxoEXTnKg6toaVCaxpUitZG5FawOl+Hmbhvk7Cejb9vpgonL0IKDXBiv7yw4A9eI/USQlE4UFqFyFGrolUIYb5XyLQsny84YphjK6RWmlX8dOTw/azmiVcmN2MsddcBxgO0sv6qh0U1lvQQew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421759; c=relaxed/simple;
	bh=nXoj0dHonTEdvyinwR72F9M/rLwnq3XlA+LY69uktvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iie1OqqtPNXjbOKgeayo0Tu8UW5/FOM6JbJG/6/I9HsIVRinqziKrXvBAjOxH4rtmKLrIKx8dIy4TKJxPLsV2HzdaqqWCeVJC2Dgi5qCtcvWvglOcSgvhQYwlc0NncbaMxAxBe9vRk9oSUZeULbEXEJKppyhWG59daVAyrJAPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X07IXt6D; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso49298175e9.2;
        Tue, 09 Sep 2025 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757421756; x=1758026556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ta3EUM01m/eAOgCWnf2NHrrKHrpoLJFvsTPitvIsZAw=;
        b=X07IXt6DbM6Lj99WLLCBrV0HxOC4jEDkFgP5UjB9Yhips5VilnP5R+CMHu0bnL4opU
         hYkeZ28i+YyovJmfpowRhKqhAiCTlo0mxZWnv4TFzPGsCeTyxwRbSa1GUTpS5ghQBMKu
         rmggJz+i5uwGeoadVXXzXsdGC8owBWmxebSUPq54CubuNgs+geIIIxbaS026o8w/Xrkl
         rpl9B8luudYlYlUypB2iLyoN9P26Cr/DViHkg8lRuVUKoMCGiETVn03eetCoIGyo+uA+
         0n5J7fRWPMfC2f/M9W4yC+ZDldiwrQYU9vo3v3IF35L7qZtG2e3Xc3yD5YUv2aLxeDVC
         q62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421756; x=1758026556;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta3EUM01m/eAOgCWnf2NHrrKHrpoLJFvsTPitvIsZAw=;
        b=ZsOSHufGyAhjaVsUOQTjvg8ti+JBNn0SBsHzRUarxgznU3T4JOkbK6eCbGSnmeYc9U
         OaFeO8WLIcfvtmm6Y50sTA13idGj+BfQu5d4Gt7OLdzNz+6mW6o3SKro4D7C43HdNdNf
         ZDq1Ed1XctskGwNuuuCFO7H90cjIZsLLy0MzuOhqBgL8ke86DX+LDiCJGBaBgrU38p3y
         Hm7j04mJ3fYR0gzI79PO1gJvJeis+5fw8yS4ryR0nvjS1q/33YOdXnWv7v3yVe01092W
         Zcsg45xhbdMTnWFtNsJeP/xNDlnfH8cqAK6s4tWKfHQiezN6Ez/kzxrTaGiZqkXauSCb
         D8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyv6ok9gVOPylvYmMSmijYjIcKvu/8XLNuKA2FhR8tORIZXGXhWZQWS75kFImgcl+cfpHdNXihaqTjQ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpPtEO+KrLVF+CgVrN/ek19fKy4vAMp3dUvN8MsYv1Pzv60y8
	5tNqJng4W+pjUgDZDd0vKjFP0e6h7UXJaLoFYBbX2VgMlmRTjsBR5sZ5
X-Gm-Gg: ASbGnctm7neiUtLmUOw4vIQznpO52NpGhe28EDfp8kIhIdaw0C7Tg/r7JBHS8IfDhyw
	27m29lNOsLdHut6k1TE/H/IrEH/qxDpmI9iSvTohwlBLjrbXPaZcRomOyXLzQHihjysiRiSe6Xr
	4BqzwmW22kGpi3HRCvX8Oh7obrv5S6m5z27P3Y0CJBX4xzdntKmb3Nj8EP0G+ikKhzlqgzfqsOl
	FtfGTFdgLq7KhaNJa5iyVQC3gxNgDAyzYRNbYWOl8j1ZPWwk2xftBK1HiNIHBriBBIJsD8/Vnql
	cF/WNLx6ComTYl2Nbd1mgz3eg3qRqOEaPJZJXuzbrWCyjRMRyBPrsH/5e5hcl06RPoec/UV1fKw
	m2nVhbBcrprfgmRnWsim8DT69fnHFNlZfXcHhoMxAI/qlFa2bILIN
X-Google-Smtp-Source: AGHT+IF/XhW1weI5x5faucsv0mz0tu4FaVW5VCx3px/421hL4vs7KawafAXMUyoquGlFZ1GwtiHG1g==
X-Received: by 2002:a05:600c:4514:b0:45d:d9d1:80a3 with SMTP id 5b1f17b1804b1-45dddeed052mr99709395e9.37.1757421755865;
        Tue, 09 Sep 2025 05:42:35 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddf1765e8sm147703695e9.22.2025.09.09.05.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 05:42:34 -0700 (PDT)
Message-ID: <cec6ee57-a32f-478a-8612-09fd334c334e@gmail.com>
Date: Tue, 9 Sep 2025 14:42:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Fix out of range pull
 values
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>, Ben Ho <Ben.Ho@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250722171152.58923-2-robh@kernel.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <20250722171152.58923-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 22/07/2025 19:11, Rob Herring (Arm) wrote:
> A value of 10 is not valid for "mediatek,pull-down-adv" and
> "mediatek,pull-up-adv" properties which have defined values of 0-3. It
> appears the "10" was written as a binary value. The driver only looks at
> the lowest 2 bits, so the value "10" decimal works out the same as if
> "2" was used.
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Queued, thanks

Matthias

> ---
> This is just a few of the warnings related to mt8183-pinctrl... Mediatek
> is #1 for DT warnings on arm64. And by #1, I mean worst. :( It would be
> nice to see some progress on fixing them. Otherwise, seeing new Mediatek
> bindings rather than fixing the existing stuff makes me grumpy.
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi  | 14 +++++++-------
>   arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 14 +++++++-------
>   2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 400c61d11035..fff93e26eb76 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -580,7 +580,7 @@ pins-cmd-dat {
>   		pins-clk {
>   			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins-rst {
> @@ -609,13 +609,13 @@ pins-cmd-dat {
>   		pins-clk {
>   			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins-ds {
>   			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins-rst {
> @@ -633,13 +633,13 @@ pins-cmd-dat {
>   				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
>   				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
>   			input-enable;
> -			mediatek,pull-up-adv = <10>;
> +			mediatek,pull-up-adv = <2>;
>   		};
>   
>   		pins-clk {
>   			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
>   			input-enable;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   	};
>   
> @@ -652,13 +652,13 @@ pins-cmd-dat {
>   				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
>   			drive-strength = <6>;
>   			input-enable;
> -			mediatek,pull-up-adv = <10>;
> +			mediatek,pull-up-adv = <2>;
>   		};
>   
>   		pins-clk {
>   			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
>   			drive-strength = <8>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   			input-enable;
>   		};
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> index dbdee604edab..7c3010889ae7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
> @@ -324,7 +324,7 @@ pins_cmd_dat {
>   		pins_clk {
>   			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins_rst {
> @@ -353,13 +353,13 @@ pins_cmd_dat {
>   		pins_clk {
>   			pinmux = <PINMUX_GPIO124__FUNC_MSDC0_CLK>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins_ds {
>   			pinmux = <PINMUX_GPIO131__FUNC_MSDC0_DSL>;
>   			drive-strength = <MTK_DRIVE_14mA>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins_rst {
> @@ -377,13 +377,13 @@ pins_cmd_dat {
>   				 <PINMUX_GPIO33__FUNC_MSDC1_DAT2>,
>   				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
>   			input-enable;
> -			mediatek,pull-up-adv = <10>;
> +			mediatek,pull-up-adv = <2>;
>   		};
>   
>   		pins_clk {
>   			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
>   			input-enable;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   		};
>   
>   		pins_pmu {
> @@ -401,13 +401,13 @@ pins_cmd_dat {
>   				 <PINMUX_GPIO30__FUNC_MSDC1_DAT3>;
>   			drive-strength = <6>;
>   			input-enable;
> -			mediatek,pull-up-adv = <10>;
> +			mediatek,pull-up-adv = <2>;
>   		};
>   
>   		pins_clk {
>   			pinmux = <PINMUX_GPIO29__FUNC_MSDC1_CLK>;
>   			drive-strength = <8>;
> -			mediatek,pull-down-adv = <10>;
> +			mediatek,pull-down-adv = <2>;
>   			input-enable;
>   		};
>   	};


