Return-Path: <linux-kernel+bounces-832509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FD7B9F8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433D87BBE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436C242D65;
	Thu, 25 Sep 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk+X7fpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF7230BD5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806396; cv=none; b=O0PbnGjWB9aq/X1ZwN/mqcUVzzDnmjmAH2Zs7SD38x3qnVlMb+c9lRC4CPn3uhSXr2TVkLq1ag5kMjltNjT51dhy6wQLkCBnrSryPWDfECmpEN8UL6SkeIWX1cO9GthCVRIEiE1IYOZ0wGfaBdLGb+4douitwB2OIZhng2gT4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806396; c=relaxed/simple;
	bh=LsVI8ehH/npCq5kVzjZEjj4UwNd8svrLYYvGBARdX4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsACccDpFMy3WzSRkylO2AfCTFeLYBgSWcEDmeEpylcPOnwHihzAXhVZiShdntLEPkkqjNTdN0EYSYpXAEaVDSHRyyJYbuoEzz+ekK/4hl+BILkB35HJV1xLYxfsrCl+qWMQnnnuYqCraRJi+zE4N31dQ6TwEiRb8DO0xGn8JBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk+X7fpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF94CC2BC87
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806396;
	bh=LsVI8ehH/npCq5kVzjZEjj4UwNd8svrLYYvGBARdX4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sk+X7fpIAHEy5aPtHwjDjhFIKZDN4Tw8vGC34+pqpkEmrTZsulhoKzRdz+vuwmWOF
	 yjLVLwzQKsfKAwXjExvwqorLPu+h1lNcfF1hCnnxn498rscM0gO3/YxMFYVewXV1Hw
	 H7+akEmncqNt81AHY59hXZ/jqID821BXXuaqstuj4mal313lxwjXrZZPZ8f5/VYipi
	 X4DRH2JKXlKsjL/i74iWCBo1zlAFAESEAyftvsQRAkZi4nZ13dNj2O2I61wEbkzHNH
	 74yBjl+Gz7rhUA2dxquBwhuelV4vpWuV6fJeck92BIloRbvlmL6qeVIsMkMKPycfRz
	 /mn6nY9XRkA8w==
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso753662a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:19:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfuWIklSZ21LW6l3qUqn/T8Sb8Wga11Rugjd0gr2n5YnaZ5PD+4HiJcTJN4XbQ2MgvD6h6jwKmSqFQpik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvMtM+olZkYGJ9FpAx26AqI8Nkwq7+W8zSiVnlhVL17E3vAH7
	yM7PFYOByxP1MA12gzhBBo6hgxl1bjlPYyvQil7hPHXXIDjr+XHhx4TYgdsAgS19oywe1RIcALp
	ybyRJmLFRAnmcSk0z1544PWzcfvGuy+0=
X-Google-Smtp-Source: AGHT+IEkZ/qcM3gWgvoH5Z23lxlGdztAh8GifS0XlFA7H2Bv0O2IQ1fOXZC+rp/hKwkBHo+Sei5HaXsHbiwpkYcWLeE=
X-Received: by 2002:a17:902:c409:b0:275:f156:965c with SMTP id
 d9443c01a7336-27ed4ade26bmr41285845ad.52.1758806396248; Thu, 25 Sep 2025
 06:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com> <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
In-Reply-To: <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 22:19:42 +0900
X-Gmail-Original-Message-ID: <CAJKOXPeFKN+yV4eitGgHPUYibE1h8RH274b6N6ovz_PR5BYw4A@mail.gmail.com>
X-Gm-Features: AS18NWBEzYXM9j8AHrwCm_hkcD1rrIPELcnRoRKDYiPoFbPa_pQtmGl_AKB5sX8
Message-ID: <CAJKOXPeFKN+yV4eitGgHPUYibE1h8RH274b6N6ovz_PR5BYw4A@mail.gmail.com>
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 21:28, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 9/25/25 2:17 AM, Jingyi Wang wrote:
> > From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> >
> > Add device tree support for QUPv3 serial engine protocols on Kaanapali.
> > Kaanapali has 24 QUP serial engines across 4 QUP wrappers, each with
> > support of GPI DMA engines, and it also includes 5 I2C hubs.
> >
> > Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> > Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> > ---
>
> [...]
>
> > +             gpi_dma2: dma-controller@800000 {
> > +                     compatible = "qcom,kaanapali-gpi-dma", "qcom,sm6350-gpi-dma";
> > +                     reg = <0x0 0x00800000 0x0 0x60000>;
> > +
> > +                     interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 850 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 851 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 852 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 853 IRQ_TYPE_LEVEL_HIGH>,
> > +                                     <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>;
>
> odd indentation (on almost all gpi_dma instances)
>
> [...]
>
> > -             remoteproc_soccp: remoteproc-soccp@d00000 {
> > -                     compatible = "qcom,kaanapali-soccp-pas";
> > -                     reg = <0x0 0x00d00000 0x0 0x200000>;
> > +                     i2c22: i2c@1a8c000 {
> > +                             compatible = "qcom,geni-i2c";
> > +                             reg = <0x0 0x01a8c000 0x0 0x4000>;
> >
> > -                     interrupts-extended = <&intc GIC_SPI 167 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 9 IRQ_TYPE_EDGE_RISING>,
> > -                                           <&soccp_smp2p_in 10 IRQ_TYPE_EDGE_RISING>;
> > -                     interrupt-names = "wdog",
> > -                                       "fatal",
> > -                                       "ready",
> > -                                       "handover",
> > -                                       "stop-ack",
> > -                                       "pong",
> > -                                       "wake-ack";
>
> Please try to use git format-patch --patience


Well, maybe it worked help, but I claim the author did not review
their work before sending. If you remove lines you added, you clearly
wrote buggy patches without any sense of proper logical split. It's
not gits fault. It's author's fault.

Best regards,
Krzysztof

