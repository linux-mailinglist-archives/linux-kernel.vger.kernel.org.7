Return-Path: <linux-kernel+bounces-860030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348DEBEF29F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5653E04BD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C829BDAC;
	Mon, 20 Oct 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiHYX4CB"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECE26B75F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930021; cv=none; b=f5TlDHTCZXGd9joX/hfM1IY+09F7/vMnJFSDpCwfbam40V0tTXpre5YPaIPeLbFQFzPEJOt3Oo7LQVMTcZH51xJQCWXlShLNid6TPEtVyJ3U1FxneI/7/Gu4IL07T4jvKNpjModkX9C0qUKAaK+cz7uggw/24ixL9x/Sj5KXfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930021; c=relaxed/simple;
	bh=kdv2StFd9t2aqx8yAzNqjNqEcQrRsIDibVmGkYKB12g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erlAS5kdsCY0tt7wel5X3QsviXjK40tjHMnXjTHXZQy7sunb3kXflJB7E5eFvDoZ1of7lE0N+QpEZYyKcJ0xx9BJPhHbG0p+ZEbjpJRXnyGqLp0SuQiMtlwt9fbEhnSuPOyWtb+usloYEJ4GJhlBEzhrUckC0fPvxnc7r3GXjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiHYX4CB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso4054598a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760930018; x=1761534818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5ZF0nIWQuoX7NVIe6I5+JsT65xxxmpn6kzl5bwhRQw=;
        b=jiHYX4CBMpFpAMpqf4Llbbfbajpj47ozqB9faFl74WVDNXJufbA6CfznmRa3NCrhVm
         szi8bmAyvH0aLA/p5qkD3Pf+hKtCgi1Go//lgeRZ+fCulfRpIS53l+JxsTjT0ZWEaTpl
         Y9vn1/xOhMOm+JDgToRQK22zHd/T5M12B6nEvhc3Y0MgryHLq50OI46FYHj1pZOdSGe4
         4VkmuYG07UkhlbehpBrtxwRzOY4NDJm8OPNzzOGm6P93/fL5ZRpJVG52T6Owycv0F97P
         AH8hlHrzpBct5sQMT9XQvKJxUbwAXfN3o5CY33U5IZcA02BgXvUl8R4HEKegNUQcQK9u
         EPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930018; x=1761534818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5ZF0nIWQuoX7NVIe6I5+JsT65xxxmpn6kzl5bwhRQw=;
        b=Qb2KI7k2xuQ45ovNGmhLaBOQtIpuh1K5UpdXdiXiD6JHOAyJjT8nidBS7VYsZjmWaY
         UCN1eQ1RLG7VCsUIAHaY4TbsfvAiqSsr2nvoDycwme/4MbEx/zxf1I80jwAej7WUPGK1
         mGyIt1QkJ/k9MwSfgNt9Rf9ToDTYVYawCSAd1ahDUXhY5oDmQtf+KKSyPCTLHlPkfNWK
         hmuMGUZyGM01GKuDgchs6/NSD6yVV55A63ZOjdytsNUagzYMyLe1bXseuXeZ2PLCInq9
         0mKovq6a/dldIrNmC/JuiNefHAZm6RNXa2GZs1TawnqnE2YXF35JSu0YYvsdiKzm8Otw
         Qa0A==
X-Forwarded-Encrypted: i=1; AJvYcCUKyofn9ispw/4Ho9bLsV3VMaHkDJF44bsjUS4vWAar8Zq3ZSFRHjye64HPGOKO1UTb04SQj/Ra4uPLTpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZjwkUXtLHMWb710VAIqHH74/Tkw9JXJzi4s7VnizBakPZ4uTq
	fqlAKVCHcYZ4QGMSaBx7T5H8gWCcGlkSJFtBar9tv08Jd/N1iwwtD9hNQxWmXzKDY4PVBEpB/KG
	Hu1c4zJbIWfFzsjvgS8gbQfqznQDgy5c=
X-Gm-Gg: ASbGncsrnr2pC+SWVS/2GCoBFCdkME6z1A/bk3mAp8Hyg/K7Ixfbp1uFLj54UrDleuA
	kiORHQmLNQ+/c0uXNUKazrp63X4hRA6Hn4iPWu/LypsjYReSesHk5rj/uFgu1BwXgPf4r7iyBdL
	otJp80l09xH12pXmE1ixiVUfGuHw1ZzqeMf1eTGAsWSdHOExBXvGKmC4aVwmv/uqMa48Lv6MBNU
	+C8WAgAQ8rKYW7W9J9wzp3AEPkgaKEFEw/Jb8vydht4fVqH9FUVb2VT0pE=
X-Google-Smtp-Source: AGHT+IFlIM9veSfUiCEqCs4cu1zurxwbaOmQwJt6C38o77/S8LVLD6y47Rn4sx8fit0dIc30Wd0JSNIXuLu1cF7zy6g=
X-Received: by 2002:a05:6402:278a:b0:63c:17f5:cc93 with SMTP id
 4fb4d7f45d1cf-63c1f630f4emr10867390a12.8.1760930017243; Sun, 19 Oct 2025
 20:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com> <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
 <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
 <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org> <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
 <de5e8643-49bb-4e0e-45fd-51b25ecf530d@manjaro.org> <CANAwSgTZa7PXBuyh9EdDOXCNuCTOHGsJz18pSjP6WUN8sOaqTQ@mail.gmail.com>
 <047fe2b8-0f94-0f0f-5964-b65844834706@manjaro.org>
In-Reply-To: <047fe2b8-0f94-0f0f-5964-b65844834706@manjaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 20 Oct 2025 08:43:18 +0530
X-Gm-Features: AS18NWCj3sZ27S7v2lVifIDB-bfHc9CGVpcmzR6xkep1HgXpZq9MDT3bZH4TJtE
Message-ID: <CANAwSgRuPhgnGy=2oY6u1jQtDRkQAdPqGv5NUNv8+WDeHq-56Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6
 with A3A444 chips
To: Dragan Simic <dsimic@manjaro.org>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Grzegorz Sterniczuk <grzegorz@sternicz.uk>, Jonas Karlman <jonas@kwiboo.se>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dragan,

On Sun, 19 Oct 2025 at 23:40, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Hello Anand,
>
> On Sunday, October 19, 2025 19:25 CEST, Anand Moon <linux.amoon@gmail.com> wrote:
> > Would you consider the following patch?
> >
> > As per the Rockchip RK3588S SoC Technical Reference Manual (TRM) Part 1,
> > chapter 21.6, Interface Description, the eMMC signals require careful handling
> > to ensure signal integrity.
> >
> > I2C2_SCL_M2 I/O EMMC_RSTN/I2C2_SCL_M2/UART5_RTSN_M1/GPIO2_A3_d
> > BUS_IOC_GPIO2A_IOMUX_SEL_L[15:12]=0x9
> > I2C2_SDA_M2 I/O EMMC_DATA_STROBE/I2C2_SDA_M2/UART5_CTSN_M1/GPIO2_A2_d
> > BUS_IOC_GPIO2A_IOMUX_SEL_L[11:8]=0x9
> >
> > $ git diff .
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > index 6584d73660f6..f60a1d8be0ef 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> > @@ -327,7 +327,7 @@ emmc {
> >                 emmc_rstnout: emmc-rstnout {
> >                         rockchip,pins =
> >                                 /* emmc_rstn */
> > -                               <2 RK_PA3 1 &pcfg_pull_none>;
> > +                               <2 RK_PA3 1 &pcfg_pull_down_drv_level_2>;
> >                 };
> >
> >                 /omit-if-no-ref/
> > @@ -369,7 +369,7 @@ emmc_cmd: emmc-cmd {
> >                 emmc_data_strobe: emmc-data-strobe {
> >                         rockchip,pins =
> >                                 /* emmc_data_strobe */
> > -                               <2 RK_PA2 1 &pcfg_pull_down>;
> > +                               <2 RK_PA2 1 &pcfg_pull_down_drv_level_2>;
> >                 };
> >         };
>
> Frankly, I'm not really sure how would such changes do something
> good regarding the eMMC signal integrity?  In general, signal
> integrity depends mostly on the routing of the PCB traces, which
> is purely hardware design.  Sure, termination of data lines also
> plays a significant role, but that surely isn't at play here.
>
It is necessary to enhance the signal quality from the controller to
the eMMC module

> Moreover, the eMMC RSTn line is already pulled high to VCCIO in
> the reference RK3588 design, so pulling it down in the SoC itself
> would be pretty much wrong thing to do.
>
It is specified in the TRM that this is only applicable during
initialization.as per my understanding.

Thanks
-Anand

