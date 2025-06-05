Return-Path: <linux-kernel+bounces-674320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13AACED2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 11:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0FA176D86
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 09:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E2212FB0;
	Thu,  5 Jun 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXQAPvZN"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD420E023
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117510; cv=none; b=tbsrVpycwYKyzzfykqjlRqNAWUkY4iP0KpLvczYGyS3vGBMmkJQvwtyvJLUOfwcEpsJ71GK18yvG22ZjBzwyB1EN5lMyJQsVWnPuxzVsc6s01RiZvK1uLwvICbXyQHZA3LR4N8NnJrL7WiqsyAHiLLGGSzDrIqYO/9tTQ7U4uB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117510; c=relaxed/simple;
	bh=o3b2DG8B4UyXxdQJRJfS1yqgkhfWuARiXi72szudhWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKBAoUWUntL7AU2sn2UcUoVps9SbcrQATqqxt2pxeiAI/5GkPoietaHftehaY/MR4LlzVu8EmTITTXBBrfjxazpWYA7OOqHTgfjHAAwbSTcsWjsCfCwpHN/6L2cML2WLMkMVfeDJ8IgJkt5ve42YsgQq6jXC3kntLRgrwSrywTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXQAPvZN; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e812c817de0so791371276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749117507; x=1749722307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zPdTQVDPRTSNl8wo5w6MeNmYmfyR+yoWh8tW6/DZaY=;
        b=OXQAPvZN87sHZi8gqnbDYGQQZz24UuqR7c4C9a8AGpZ9C2nZKrsYg4kkCN7CgyZq2s
         HQTdGRv1uz+8KA9K/jo6kn/Z4fWQLVy7ZfUs7bJvrmiK5LE+Hvcd8aNHxLC5JL9SncUw
         cm6gGw0bnk1nRdTIOeXtW2SFcW8kPXyc9UO7RqnHXBBVqr2xKTFfMF2eIFiDwxcVjRAM
         /KThvg6uHDgEM++NPSMjVjk8qRU37lriULuE/E8iI3u41WzpPgXYOXIAB5fZtXz2wp4O
         5oLl2RqDNcirSP6OPfnjM6x6Gu3Hzcd2IZ/Gw1RmMbEVYYjR8rhAXYfgX+0JhsEH/cve
         wPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749117507; x=1749722307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zPdTQVDPRTSNl8wo5w6MeNmYmfyR+yoWh8tW6/DZaY=;
        b=ccfbGjPv+azYBcvqzls0tVBpjl2fbsEMMPFe5SGm83QWYtOXrHVOjGJjuFFT69I8Wa
         0z7glYgB/5lM0cHFq7hy6yCrFu6rONYLfkTHHmp+FyjlrHypejXYw8TOhHmkt0zKU7hZ
         iMTT45yQLsg1spk2PEpzqX+DJIeJlIIL8W02qJT15AbjmI4+zUT2o1V9VAaJBizN2WIr
         zMCbT8IvhiyYqKJ9UOmKc7tN3FJki4WEmGCaygqBI4KMtbFtXd4y185MfWnX6BJGto/V
         Tfc/FW3kRAZzzBsIGwCdcIbVpYhiiY0QZM14rza/6WXAzj+PD7HW4DNzeL9y3e8V96HQ
         92BA==
X-Forwarded-Encrypted: i=1; AJvYcCXBQh10GXv8ctpjRh/EtHOSyqLO+e0CynfsvAdOck7x4rQZSvBTWdMRs0+QzX9JE9jepHnoKLWe3bgdXuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6f0wjTJHvUeBQRphPXwKQo7EyfETHE9+rmYEYoiwEerD6ncgw
	C1zU/q6fcGe/ruKCUtBlgAdoHYBzZ8cCvCD6cFieD6f63HPubRQ/X2HCqUPp0oZhK2TkXdyGgf3
	kqIaLkgDuDcVYgvTGRZu+2wWOrBc6hXBM9LbNXqAC9Q==
X-Gm-Gg: ASbGnctObV551VcTmfxxM+jM7M43kJMLQ7uF9nXGn72ASv/YRONvUKEb93mcV68vv9H
	fAoBvEoCL34Zq9/82zMQ4RKRfHjeNaQ3mPsmA0Jwcuv/bUl1oef2YQniyibwVujV7GnK0Q80toe
	zABedab1ww7WylCXQkI8vZxFX0/0EBGoyjjQ==
X-Google-Smtp-Source: AGHT+IEs9z2qDMjfH7cC75fVmmSjHZHDht5i6D5bKkcjTo5PY949JkkRdQafZEhuxNNXbWaU8JI1NrPxlkNCttr89yg=
X-Received: by 2002:a05:6902:1006:b0:e81:89b9:f7fb with SMTP id
 3f1490d57ef6-e8189b9fd46mr2688470276.20.1749117507589; Thu, 05 Jun 2025
 02:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250529222410eucas1p2e1d41a2fc717caef1aed51367a7db944@eucas1p2.samsung.com>
 <20250530-apr_14_for_sending-v3-0-83d5744d997c@samsung.com>
 <20250530-apr_14_for_sending-v3-7-83d5744d997c@samsung.com>
 <CAPDyKFpYfZNthdRN=pCv4FEdFCzrKEH4aFBy4ew-xLKtpbJ5Tg@mail.gmail.com> <e39c6748-59aa-4c4a-98f3-263751a120c1@imgtec.com>
In-Reply-To: <e39c6748-59aa-4c4a-98f3-263751a120c1@imgtec.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Jun 2025 11:57:51 +0200
X-Gm-Features: AX0GCFs9t2KTNaikDlvnZamDB-7XXtdndYPeCom5IA-jJ40VSGgqWKBlwED7Z-4
Message-ID: <CAPDyKFrxqp30RWGoudVsy2NR7dSUoKwxc=nk3Bqp9RVZGZ6_vQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] riscv: dts: thead: th1520: Add IMG BXM-4-64 GPU node
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <Frank.Binns@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 18:48, Matt Coster <Matt.Coster@imgtec.com> wrote:
>
> On 03/06/2025 13:27, Ulf Hansson wrote:
> > On Fri, 30 May 2025 at 00:24, Michal Wilczynski
> > <m.wilczynski@samsung.com> wrote:
> >>
> >> Add a device tree node for the IMG BXM-4-64 GPU present in the T-HEAD
> >> TH1520 SoC used by the Lichee Pi 4A board. This node enables support for
> >> the GPU using the drm/imagination driver.
> >>
> >> By adding this node, the kernel can recognize and initialize the GPU,
> >> providing graphics acceleration capabilities on the Lichee Pi 4A and
> >> other boards based on the TH1520 SoC.
> >>
> >> Add fixed clock gpu_mem_clk, as the MEM clock on the T-HEAD SoC can't be
> >> controlled programatically.
> >>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  arch/riscv/boot/dts/thead/th1520.dtsi | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> index 6170eec79e919b606a2046ac8f52db07e47ef441..ee937bbdb7c08439a70306f035b1cc82ddb4bae2 100644
> >> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> >> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> @@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
> >>                 #clock-cells = <0>;
> >>         };
> >>
> >> +       gpu_mem_clk: mem-clk {
> >> +               compatible = "fixed-clock";
> >> +               clock-frequency = <0>;
> >> +               clock-output-names = "gpu_mem_clk";
> >> +               #clock-cells = <0>;
> >> +       };
> >> +
> >>         stmmac_axi_config: stmmac-axi-config {
> >>                 snps,wr_osr_lmt = <15>;
> >>                 snps,rd_osr_lmt = <15>;
> >> @@ -504,6 +511,21 @@ clk: clock-controller@ffef010000 {
> >>                         #clock-cells = <1>;
> >>                 };
> >>
> >> +               gpu: gpu@ffef400000 {
> >> +                       compatible = "thead,th1520-gpu", "img,img-bxm-4-64",
> >> +                                    "img,img-rogue";
> >> +                       reg = <0xff 0xef400000 0x0 0x100000>;
> >> +                       interrupt-parent = <&plic>;
> >> +                       interrupts = <102 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       clocks = <&clk_vo CLK_GPU_CORE>,
> >> +                                <&gpu_mem_clk>,
> >> +                                <&clk_vo CLK_GPU_CFG_ACLK>;
> >> +                       clock-names = "core", "mem", "sys";
> >> +                       power-domains = <&aon TH1520_GPU_PD>;
> >> +                       power-domain-names = "a";
> >
> > If the power-domain-names are really needed, please pick a
> > useful/descriptive name.
>
> This isn't the first time our unfortunate power domain names have come
> up [1][2]. Sadly, we're stuck with them for Rogue.

Wow, that's really crazy.

BTW, are there any reasons why you can't rely on attaching them by
index instead, via dev_pm_domain_attach_by_id() for example? Thus
entirely drop the names in the DT docs?

It sounds like the names don't really have a meaning, or do they?

>
> Matt
>
> [1]: https://lore.kernel.org/r/ff4e96e4-ebc2-4c50-9715-82ba3d7b8612@imgtec.com/
> [2]: https://lore.kernel.org/r/cc6a19b3-ba35-465c-9fa6-a764df7c01c1@imgtec.com/
>
> >

[...]

Kind regards
Uffe

