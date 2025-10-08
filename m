Return-Path: <linux-kernel+bounces-845793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB10BC61D5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05058188D7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FD29D27E;
	Wed,  8 Oct 2025 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHhTsXmT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3BC20E030
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943051; cv=none; b=W2AVajWue+TJzcp76TF1eCMpmO56HlOe6n9/qv9OjCzau+cFeDgOkowU7T/sPajwJmZ2cxvE96UqpOhsDEQKQx8Qvkfhr/gAi8I5BWFG2LzhFjNkanaWCsbuODSGfT/XVOJKOCfGpk2fNxolgxvF1xWJM2fVsF8KILwOmvhFm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943051; c=relaxed/simple;
	bh=iahh48D7RERH5E+U/K/mzMIQbVc8kAtvaHYWGIzytwo=;
	h=From:To:Cc:Subject:References:Date:Message-ID:MIME-Version:
	 Content-Type; b=TCsONtZ1G9Dlx81yqHR6fXTBQeqoQ+1JodyixAQiYO+/YqsizGTo15x499OQ9Id58B/7XidBow8PpdSj1JzAYa4fHS8hcW2/8xptVulTa2fFBLFXYGbE2bZr7ED/FKUgtC2cawyFyH/T5UUKpzT4Pvq6ZDC/Wj/9xoQDpvsWsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHhTsXmT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57a960fe78fso93585e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759943047; x=1760547847; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uAv6wa5qH1yNLZ/tm/3w2Yzpi611u4yTaGZCwRBfLbA=;
        b=RHhTsXmTNqUqp5lFBxYZ80ECscpxWbpnGzyCF2Tjsza462xVEOpsgU5oq6VDVpe9xc
         b03g9zLe3Fawp6Srg8kC3kSIK045QbiNFeGNGyYPswP/UdrO2/aAqIm+lyY6VV7OIN9l
         fCnNZm0NZ51nwlu6V4K4Hyxk0RnsbQ6YOc0LO3gUtMFqcnZttUpvaeg9t5A9illDL0ve
         q/KGCtSbxCXLK5xitChsDMTfZwn0ym523Ak+nsvQmczJy3u9lOB1endKk+8ccb9Ms+8n
         JDF9XrP4Ink8riSVHRAhbWYjZEFI4bxFwelwFQbcQn9hDAtvVtabVHRhN33f/f7cGIKH
         2y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943047; x=1760547847;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAv6wa5qH1yNLZ/tm/3w2Yzpi611u4yTaGZCwRBfLbA=;
        b=H37P3jIq3hy1/JJaj9+bMSYkASjzOeuB20zA2KHRCm4xidOf+3MnnaXiXI/WogLDRm
         fKdZyXrSt+8kwJx2Auc0aEroC6qu7e+DKoeczinkLFgKlzGMHUCcQo+H+Jm1tXT46nSt
         1TyCO23LSu/n/5Bna/aYpCX1JGJ8/0xBUCqlvoNTU6E73txER/ovCPY76+J//F16wG4A
         BXQlk/3I2pJr0LpqWhvZPB0wajKKf3+Rgbwz0YvYVI3dAZo2VmfXc1VPRiXRCDTxK+BU
         1EHqd1YG4YCfO1Zj8Lh9yKo/Y18pIFgEIwVbeJ2jRcAvBFTIie2mL9Lq6VkdiQP0cuY5
         GvcA==
X-Gm-Message-State: AOJu0YwYAxsl5HrZXj2KyruH7mwdiqAWkJYGYilFQJvaKEkrdtM8yttg
	ErvU1r7S53yDNt+gi74VbHjVw9fC56E3RKfZFGqmsh0+tcy1HDKn8MIg
X-Gm-Gg: ASbGncuyQxKWtKQTaJtD/pBg5zq0DOWpCmKQxRYkvt7tQGSmBvDQ4YAy88O8p+dg6OY
	ruxXikj1G9V8905ikzAy2L+/ry4qurgzb/KZy2o7XVAi/zXdanpjpnEqL5pCx2lYTKlfgeLYY2x
	nuQ4N+h0hBqNKo+B/0v3STuzk2Ce5HZU/50kzNtg2qcyrV9NQfScPvpOdnjzRua0E5XBwRpoH82
	KNAgL+bWiLlPSC2efsRx0TqJaBzjeKlSL/proS3jrJHjq0hn296h3r7ZXWFuiKbkvWJ/t0jUA5H
	MO0rpT4a1yFyoWlAGEIwgNCXCfsdQvsu4v0Uc2Dev58yprWz1h6mPoM4RRpgWf0QHyCB0L1NrFt
	zr3XXw6hOcrFMpjoh21nx0aGvVO86as766CEvfCWMhXyUaVbKPQ==
X-Google-Smtp-Source: AGHT+IF+WDxLtZAr0cpCBFj6F2HVd64uf/+ap01Oo616skSDfKtY89Vqb3BXrrghRkGavk8KU/ZfhQ==
X-Received: by 2002:a05:6512:33c3:b0:573:8044:a98c with SMTP id 2adb3069b0e04-5906dc0e1d5mr1084934e87.18.1759943045619;
        Wed, 08 Oct 2025 10:04:05 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb3de9sm163234e87.106.2025.10.08.10.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:04:04 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,  Ulf Hansson <ulf.hansson@linaro.org>,
  Shawn Guo <shawnguo@kernel.org>,  "Rob Herring (Arm)" <robh@kernel.org>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
References: <87v7l03pqe.fsf@osv.gnss.ru>
	<CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
	<CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
	<87o6qjaiz7.fsf@osv.gnss.ru>
	<CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
	<87jz17afpb.fsf@osv.gnss.ru>
	<CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
	<87bjmih0nz.fsf@osv.gnss.ru>
	<CAOMZO5Cmxqq6K4k7_yPjGOtMTOgv7WmpN9O2dZiX+UWies8mow@mail.gmail.com>
Date: Wed, 08 Oct 2025 20:04:04 +0300
Message-ID: <87zfa1z5ob.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fabio Estevam <festevam@gmail.com> writes:

> Hi Sergey,
>
> On Tue, Oct 7, 2025 at 6:17 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Please see attached minimum DTS. Maybe it misses something? Shouldn't
>> DTS describe how eMMC chip is powered, provided it's powered from NXP
>> MMPF0100F6ANES PMIC? I didn't find any hints in other DTS'es.
>
> Yes, the dts should describe the eMMC power supplies.
>
> The properties are: vmmc-supply and vqmmc-supply.
>
> Check arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi for reference.

This uses:

        pmic: pmic@8 {                                                                                
                compatible = "fsl,pfuze100";                                                          

that doesn't look like the one I need, and I don't see anything among
Documentation/devicetree/bindings/regulator/* for the NXP MMPF0100F6ANES
PMIC that is used on my board.

Does it mean that this regulator is unsupported? If so, doesn't it mean
that kernel simply won't touch it, and thus it can't be the cause of the
hang?

Anyway, I added naive fixed regulators (see attached modified DTS), but
it didn't change the outcome.

>
>> The point of hang is not entirely deterministic either, that suggests
>> it's some power problem indeed. It may hang after random line among the
>> following depending on exact build and sometimes even from run-to-run:
>>
>> ...
>> mmc0: SDHCI controller on 219c000.mmc [219c000.mmc] using ADMA
>> Loading compiled-in X.509 certificates
>> clk: Disabling unused clocks
>> PM: genpd: Disabling unused power domains
>
> Does it hang if you pass "pm_genpd_ignore_unused" and
> "clk_ignore_unused" in the kernel command line?

Yep, it still hangs (it's pd_ignore_unused, not pm_genpd_ignore_unused,
btw):

clk: Not disabling unused clocks                   
PM: genpd: Not disabling unused power domains      
check access for rdinit=/init failed: -2, ignoring 
Waiting for root device /dev/mmcblk0p3...

and I recall I've already tried it first thing to disable this right in
the code to no avail either.

>
>> check access for rdinit=/init failed: -2, ignoring
>> Waiting for root device /dev/mmcblk0p2...
>>
>> Also, I just tried to compile entire kernel with -DDEBUG, and it starts
>> to see the eMMC, though still hangs not ever mounting the root FS:
>
> I saw Ulf's response about a potential regression in 6.17.
>
> Do you see the hang with 6.16?

Yep, 6.16 still hangs for me the same way.

-- Sergey Organov


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=javad-minimum.dts
Content-Description: troublesome minimum dts

/dts-v1/;

#include "../imx6sx.dtsi"

/ {
	compatible = "javad,imx6sx", "fsl,imx6sx";

	chosen {
		stdout-path = &uart1;
	};

	aliases {
		mmc0 = &usdhc4;
		mmc1 = &usdhc3;
		mmc2 = &usdhc2;
		mmc3 = &usdhc1;
	};

	memory@80000000 {
		device_type = "memory";
		reg = <0x80000000 0x40000000>;
	};

	reg_module_3v3: regulator-module-3v3 {
		compatible = "regulator-fixed";
		regulator-name = "+V3.3";
		regulator-min-microvolt = <3300000>;
		regulator-max-microvolt = <3300000>;
		regulator-always-on;
	};

	reg_module_1v8: regulator-module-1v8 {
		compatible = "regulator-fixed";
		regulator-name = "+V1.8";
		regulator-min-microvolt = <1800000>;
		regulator-max-microvolt = <1800000>;
		regulator-always-on;
	};

};

&usdhc4 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_usdhc4>;
	bus-width = <8>;
	non-removable;
	keep-power-in-suspend;
	vmmc-supply = <&reg_module_3v3>;
	vqmmc-supply = <&reg_module_1v8>;
	status = "okay";
};

&uart1 {
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_uart1>;
	dma-names = "";
	uart-has-rtscts;
	status = "okay";
};

&iomuxc {
	pinctrl-names = "default";
	imx6x-sdb {
		pinctrl_usdhc4: usdhc4grp {
			fsl,pins = <
				MX6SX_PAD_SD4_CLK__USDHC4_CLK		0x10059
				MX6SX_PAD_SD4_CMD__USDHC4_CMD		0x17059
				MX6SX_PAD_SD4_DATA0__USDHC4_DATA0	0x17059
				MX6SX_PAD_SD4_DATA1__USDHC4_DATA1	0x17059
				MX6SX_PAD_SD4_DATA2__USDHC4_DATA2	0x17059
				MX6SX_PAD_SD4_DATA3__USDHC4_DATA3	0x17059
				MX6SX_PAD_SD4_DATA4__USDHC4_DATA4	0x17059
				MX6SX_PAD_SD4_DATA5__USDHC4_DATA5	0x17059
				MX6SX_PAD_SD4_DATA6__USDHC4_DATA6	0x17059
				MX6SX_PAD_SD4_DATA7__USDHC4_DATA7	0x17059
				MX6SX_PAD_SD4_RESET_B__USDHC4_RESET_B	0x17068
			>;
		};
		pinctrl_uart1: uart1grp {
			fsl,pins = <
				MX6SX_PAD_ENET2_CRS__UART1_TX		0x1b0b1
				MX6SX_PAD_ENET2_COL__UART1_RX		0x1b0b1
				MX6SX_PAD_ENET2_TX_CLK__UART1_CTS_B	0x1b0b1
				MX6SX_PAD_ENET2_RX_CLK__UART1_RTS_B	0x1b0b1
			>;
		};
	};
};

--=-=-=--

