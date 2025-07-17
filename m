Return-Path: <linux-kernel+bounces-735591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D86B09152
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155E31AA50C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DD2F94AF;
	Thu, 17 Jul 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B8EiIeeD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561262F8C47
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768452; cv=none; b=aJ8oVT5w2st713ZxYE+IH6w+RVF/i4BgI1DNIWxTvXk7r0V9toIm3HgOZFKMe3QMjF9se6TLKHzl4IIrCwEBftNBNYPOi/+CO2bNE1k/3QVCOiDSnKRGPxe2xJukZzmxNoV72lBoqTd3T1vAs0bIa2rrnh03qE7oSuBepicqaeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768452; c=relaxed/simple;
	bh=HuMkvESuXq2jYyN9U/v45ZQ3yZUvaYoaX0ldJ5jJ7sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0ad2Qrbvt/tbUsatMi4nFGPejJyEfsRCTvlaRLAe/tGO+HLjm2zalwbmIKdClbW8d/MpidH4vCU80pa7a25kTybQaxSwWBsL4/vP+uzxhJ2VjoEyzyvO9UUiU2AKuMiVUlPnI+SO7R82vCIN4piYBVFUdZPBtnVr6G6gZSw5VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B8EiIeeD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso12381895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752768449; x=1753373249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=82OHoUr0Z9aQ08e56ySzE42nN8RW+aLi/MMtZyEhPrU=;
        b=B8EiIeeDTr26ry3siJUDizBLXQuERTbBi0L0M3eiXlxJokCRdq+WEB81viTP5zNbqj
         svvHZo1ZNsnij4qFy6U50K+ylhQ/jvqpeOS0CyFo13k9SWmVtwCqfYzW2f4XDq4URjKV
         RmeN1+qfgW07ScoxhvQVxEm9YugTQOeX0WfZiS2sWpAjzABcHCE3i38DDZgNMLuUVqSj
         vZhVc7Fq87srlpZskaplehSc41Iq6W1kp3orCbl4zP2oudp1Ppsc+nvnQIInEgaFn++0
         WjenNGlUagN9Usyr1xBHOGtsRhpRQGEXdpTDlm+B3YLsohq6z8yYPVgNQS9Rf+vd9/d1
         hAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752768449; x=1753373249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82OHoUr0Z9aQ08e56ySzE42nN8RW+aLi/MMtZyEhPrU=;
        b=HvFpwk+VuDhwuUcER0acosXbGbAJgy5Zvt+8eOE8CctmtJmCe1Ttvpg8CMurrOERGG
         kgcsHwI9h/xfUKfNiQ2H+poF/g7SELa2nOrjl/gUk/noR9ZIcgcH+IhOp9zaH/28kvGf
         d4ds2+cLSeAMp8DboWwtmfBC6sMrihN6y1NEOdRNeyDQ5ouZNWtcaoHVm/anpwwycxJO
         QUhy0Fn2mtgg5oOo6MC/c+bYioEeKtW5yHGpQFKZiMAnDZ0+nj/pcEoA9AOyP2wDRG/t
         E+L0pFb8BVlHhuu473x1Zl4XM3l5hHq2uALqIZ51+Akcx7ZPvU4VH7UXCSTXgNRjabJ0
         UTkA==
X-Forwarded-Encrypted: i=1; AJvYcCUnGzOrIOWiwZyCRF/EPHnHgbBw7XoypFE8FGhTiobtdwelWzzznuTGeFXnBvm5ruwG01IR8RkuToIQopk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LzfZWRmon5awF9r4Zfm9UzURBu9vAFyDFzDRsRULUbK21cGV
	b1erUr/gpqSJekXN9+0Z0fUVUWSJ8gN8Z3EnPVLQEMbBp7CRRTkv2j/ahUzGNiDtNbk=
X-Gm-Gg: ASbGncs8xGKLcknnLvaM6Jq6Dx5eTptmQYmjs1dAv2sDWassLVHfeZJmkhAFMv265RP
	c3pEvs5VYVbl35OHWTYp2xPlnmFfDx5RKnRWEO1f82qk8lMXxTP68/u4PrEtEtPCsUrtrW/DVNR
	YSJ/YjSUoHODltXi5pVUVHvTQDTEfxOUjjbz9mHvpkgvTq1sYh4Xmu8MWyzCLxnt6NBhj+UPPVb
	9K7PDXthkORn6Gk35PXuSGzNxCKhCAx62AtGlmgOX3JEH8aEAdiGmZQ2JFZhrML2v04i8Uzw5yR
	eToYWzWj4ek+LEcxCSXaWMTAdOj2WHAghvdylbebE08J1XPEu8O41MQ8EtbdE0WhQCV3yo7gQqS
	Uh7BrHnqjGHqcKNudHIXXaqU=
X-Google-Smtp-Source: AGHT+IHzm2I/lhPKbGUV5CyURK1Tn69rc/pQKbI+7FTppM+fvafp7RbqiJF9UaoOuE40qre4CBuyNw==
X-Received: by 2002:a05:600c:4f4f:b0:456:2cd9:fc41 with SMTP id 5b1f17b1804b1-4562e3b9937mr64319855e9.20.1752768448653;
        Thu, 17 Jul 2025 09:07:28 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f4c34dsm26799925e9.6.2025.07.17.09.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:07:28 -0700 (PDT)
Message-ID: <27025862-dc2c-438d-8413-d61ddff01a44@suse.com>
Date: Thu, 17 Jul 2025 18:07:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: s32g3: Fix whitespace issue in device
 tree
To: Dan Carpenter <dan.carpenter@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1752703107.git.dan.carpenter@linaro.org>
 <52960eb1-4432-436b-89aa-d50fc7da2c3a@sabinyo.mountain>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <52960eb1-4432-436b-89aa-d50fc7da2c3a@sabinyo.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/07/2025 00:46, Dan Carpenter wrote:
> Checkpatch points out that this should use spaces instead of tabs.
> "ERROR: code indent should use tabs where possible".
> 
> Reported-by: Xu Yang <xu.yang_2@nxp.com>
> Closes: https://lore.kernel.org/all/u7glt7mn33lbdeskbr4ily6tjjifvffy64llwpi5b2rrhx5tnv@y2h2y3oz3xc4/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm64/boot/dts/freescale/s32g3.dtsi | 32 ++++++++++++------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index 68c11ebd405f..e80144e33efb 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -489,22 +489,22 @@ usbmisc: usbmisc@44064200 {
>   			reg = <0x44064200 0x200>;
>   		};
>   
> -                usbotg: usb@44064000 {
> -                        compatible = "nxp,s32g3-usb", "nxp,s32g2-usb";
> -                        reg = <0x44064000 0x200>;
> -                        interrupt-parent = <&gic>;
> -                        interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>, /* OTG Core */
> -                                     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>; /* OTG Wakeup */
> -                        clocks = <&clks 94>, <&clks 95>;
> -                        fsl,usbmisc = <&usbmisc 0>;
> -                        ahb-burst-config = <0x3>;
> -                        tx-burst-size-dword = <0x10>;
> -                        rx-burst-size-dword = <0x10>;
> -                        phy_type = "ulpi";
> -                        dr_mode = "host";
> -                        maximum-speed = "high-speed";
> -                        status = "disabled";
> -                };
> +		usbotg: usb@44064000 {
> +			compatible = "nxp,s32g3-usb", "nxp,s32g2-usb";
> +			reg = <0x44064000 0x200>;
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>, /* OTG Core */
> +				     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>; /* OTG Wakeup */
> +			clocks = <&clks 94>, <&clks 95>;
> +			fsl,usbmisc = <&usbmisc 0>;
> +			ahb-burst-config = <0x3>;
> +			tx-burst-size-dword = <0x10>;
> +			rx-burst-size-dword = <0x10>;
> +			phy_type = "ulpi";
> +			dr_mode = "host";
> +			maximum-speed = "high-speed";
> +			status = "disabled";
> +		};
>   
>   		i2c0: i2c@401e4000 {
>   			compatible = "nxp,s32g3-i2c",


