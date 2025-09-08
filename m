Return-Path: <linux-kernel+bounces-804996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4AB482D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F16F17C5E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778EB17A30A;
	Mon,  8 Sep 2025 03:17:13 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B232AF0A;
	Mon,  8 Sep 2025 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301433; cv=none; b=Evt6ZPA/1cb0MmShBLw4BQK+iKHF25XzgGKfq6bMzcVSyXkbIovjuzWrBbZVQZl3LB6RaJt9wGjeVFBN9G3uCOI/FbBimKl47OsNhSZZItGEiV2dyVdMXYp/Eh7AwZIcWXg3Bx9/yRpGzZgksWR/niwv+ELbYtImpxB60mowyEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301433; c=relaxed/simple;
	bh=Dl/Fap/h9ht+nyHnj4KOWhTOUmWaKrKMnq3kNcTD/so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zb9hvZfV+h/hm6m1exkqVb4kSmrd6XYGLzrGMBs2gVwtb7xUY1D6iT3JudYQ5oeWiv9A5DHAOZqQZG6HJ57Aufk8jGgl/MMOGEH10x5dEx3ryAWVgEYzW351r2TOv2t83SJQYfuwGXPBkdoBxplmSmSepFkF8XrAJmD7gyIF6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: esmtpgz14t1757301392t1d5f40cd
X-QQ-Originating-IP: ZUOPaUqj2wXqgkX85zS9BenCl9Em07B5jGELAC+KwJc=
Received: from localhost.localdomain ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 08 Sep 2025 11:16:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6945571031618804772
EX-QQ-RecipientCnt: 16
From: Kaison Deng <dkx@t-chip.com.cn>
To: Jimmy Hon <honyuenkwun@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Wayne Chou <zxf@t-chip.com.cn>,
	Kaison Deng <dkx@t-chip.com.cn>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add devicetree for the ROC-RK3588-RT
Date: Mon,  8 Sep 2025 11:16:30 +0800
Message-Id: <20250908031630.1010407-1-dkx@t-chip.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CALWfF7+6dTqLRHYKHL1iBf9YknLQ5yTrwPur8VySmjiy3mzh0Q@mail.gmail.com>
References: <CALWfF7+6dTqLRHYKHL1iBf9YknLQ5yTrwPur8VySmjiy3mzh0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MllZbBbf79Ay+DUzg+d4zuzeoLHHQPbVlLivwkbpSj1KrdewdaEvyyxj
	oZeMXUUZo0eBmKWXxGmzt534XYay8ZBSZ/1XexzR/8+777j8Hdkzh2t2qkTNYyFBn50f9lO
	wEJKCd53K5UT7XtqERKA2cXdn8pzB8fRIYAVpkL1ZNr3qQYWWjnxLSJPA+Vv5+Wc6bFhDVG
	ilidI0OdSZC4A3bvlLXaa8NTvUnuv7MEupuEZ4aVpjjUGCGi+2oEoF+DyFuXfF6EsbP567u
	2qD4mjFnYisafR/IGLWneCDDS81bi4AAIU9klR3nTu1RNmUlsA3LsRG0Bn5qjJtltMAcr3m
	MsHAVX4uniabBD4coejJ8XRdeM8heqra/BcEPBb6peZ0mVMHcL4Kh2/iTKrUcLoEqs2ZsRI
	Ey6oUPlbKZyRII19Noae0zCrn0lf6o/8GRnNGns5y35Obg9o0lRYGXEgXza1ufQcvYun0y/
	J1gGBr94D2VsJsNo3qMa+koRBSudUyMzVUgTYU1EKBCkma+Mm5gPH7H2LwfUCCtYOEK2EjL
	cu1P+sBUu25wnPJtykM5vtXLbDdzSBAiNiWvyasSIDbPWDkS39WUfGb6Fllmycx/vy7L7d+
	/FBfjVe/5K42vU4msuLyw3CEm28vk6e7xnlRdkq2J/Tepu/K+FmXm/A2sLS+eqIkbfnTc9Q
	afX0Xbaewy/0veKfLTXR17m+X7h6UuLHJh7UCCJHQj6wE/ovHf91wxMzeY88TAJbw1gzx19
	Il/TH3ugVyA96SL7z+CeNUjhlV7wkgepuQlMjqYPaa58IdhLvY4bLijPd97FfeiF7iom74k
	VdW5PTuXKx/SaMeBopp7Rnfa6OeP/EcXqrJ++CCSntj++dOSw35i0hFKhjgrxkb4vseJq9a
	TF1rSnIanJozZ2lxU2bMTjBraO15NMU2ALIV3a18kova2ZE1YmT7WOOJi1lzhWK1MCdHTPG
	aoKMKVbQ0VrlxIXmlj4jd0LW/tgbMGWietprcyOqHaojbNEqMpOLnl3pjNR8/nKKmdnxx49
	sA2BG6QefnFdOws1+uOLsh7ghtyllZJk/cNGaT+tlHifnJHb8aoeI1L51gHooOWinqqTZas
	WtVZHJmbDdtX3r2Sz428Sk4ZFEYdgnmAgODd2z+jP/w
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi,

On Fri, 2025-09-05 at 20:50 -0500, Jimmy Hon wrote:
> On Fri, Sep 5, 2025 at 9:32 AM Kaison Deng <dkx@t-chip.com.cn> wrote:
> > The Firefly ROC-RK3588-RT is RK3588 based SBC featuring:
> >
> > - TF card slot
> > - NVME 2242 socket
> Could you update the commit description to match device tree. It
> looks
> like the M.2 2242 socket is configured as a SATA (i.e. "sata2")
> instead of NVME.
>
> Is the M.2 slot also wired for NVME operation? If so, will you be
> providing a DT overlay to use it in that mode?
>
> https://wiki.t-firefly.com/en/ROC-RK3588-RT/usage_sata.html#software-configuration
>
The default is sata, I will update the commit description to match the device tree.

> > - 1x USB 3.0 Port, 1x USB 2.0 Port, 1x Typec Port
> > - 1x HDMI 2.1 out, 1x HDMI 2.0 out
> > - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> > - M.2 E-KEY for Extended WiFI and Bluetoolh
> > - ES8388 on-board sound codec - jack in/out
> > - RTC
> > - LED: WORK, DIY
> > - BTB connector for PCie, UART, USB, CAN, SARADC, GPIO
> >
> > Signed-off-by: Kaison Deng <dkx@t-chip.com.cn>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
> >  .../arm64/boot/dts/rockchip/rk3588-roc-rt.dts | 1120
> > +++++++++++++++++
> >  2 files changed, 1121 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile
> > b/arch/arm64/boot/dts/rockchip/Makefile
> > index 9d56d4146b20..ad684e3831bc 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -181,6 +181,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-
> > 5-max.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-plus.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-ultra.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-quartzpro64.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-roc-rt.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5-itx.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtbo
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
> > b/arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
> > new file mode 100644
> > index 000000000000..1d50009d3153
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-roc-rt.dts
>
> [snip]
>
> > +
> > +&hdmi0 {
> > +       status = "okay";
> > +};
> > +
> > +&hdmi0_in {
> > +       hdmi0_in_vp0: endpoint {
> > +               remote-endpoint = <&vp0_out_hdmi0>;
> > +       };
> > +};
> > +
> > +&hdmi0_out {
> > +       hdmi0_out_con: endpoint {
> > +               remote-endpoint = <&hdmi0_con_in>;
> > +       };
> > +};
> Does the board support hdmi0_sound and hdmi1_sound (and the
> corresponding i2s5_8ch and i2s6_8ch)?
>
Thanks to remind, the board support hdmi0_sound and hdmi1_sound, I'll add them.

> > +
> > +&hdmi1 {
> > +       status = "okay";
> > +};
>
> [snip]
>
> > +
> > +&sdhci {
> > +       bus-width = <8>;
> > +       no-sdio;
> > +       no-sd;
> > +       non-removable;
> > +       max-frequency = <200000000>;
> > +       mmc-hs400-1_8v;
> > +       mmc-hs400-enhanced-strobe;
> These properties should be in alphabetical order.
>
I will adjust the attributes to arrange them in alphabetical order.

> > +       status = "okay";
> > +};
> > +
> > +&sdmmc {
> > +       bus-width = <4>;
> > +       cap-sd-highspeed;
> > +       disable-wp;
> > +       max-frequency = <150000000>;
> > +       no-sdio;
> > +       no-mmc;
> > +       sd-uhs-sdr104;
> > +       vmmc-supply = <&vcc3v3_sd_s0>;
> > +       vqmmc-supply = <&vccio_sd_s0>;
> > +       status = "okay";
> > +};
>
> Jimmy
>

Kaison

