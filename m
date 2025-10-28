Return-Path: <linux-kernel+bounces-873863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42DC14F63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB75D464EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9F3328F8;
	Tue, 28 Oct 2025 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HGrqsDy1"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901D2AD32;
	Tue, 28 Oct 2025 13:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659043; cv=none; b=EE2481xmDFj6tQBRHLyLoyjqaqA3P5Di6rp+0faCuNZVOUA64m2ovELhsQpUO4lfvC5lgUtH20Vib0cabfZ6Ifsiolfx33MULJ7316XZX0575zA1kVY8Ai4KIi7J9cA/n3qqVRccv3fEZW9DJspRWOVSa9za3V2yIrzvDfxpq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659043; c=relaxed/simple;
	bh=0eCX2hzh9/rOQP2c5dwLPKKJYD0q5MTnLSDk5aNZX9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQOQmU58spKc+AtA23aun0dKZHQgVYV2WzPCmz9IKQx8KEwJwwGvumj0XLuuBD4fQUMqUxUWb63zirx863I1BtLhbG2unzC1IJTQ2R841Oin7SBilZ88/q8offsyrZBMuxZxSRHz/GrrSuT9+aeBBfALZJG8nbuzo3Md9KgbSTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HGrqsDy1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5A36925E06;
	Tue, 28 Oct 2025 14:43:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9W7edxZGJM9z; Tue, 28 Oct 2025 14:43:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761659031; bh=0eCX2hzh9/rOQP2c5dwLPKKJYD0q5MTnLSDk5aNZX9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HGrqsDy1K11pC3XvY+UZFFi197y53VLfS+CJS6xLRum+crvECeY6OPwkQBtfYtcOh
	 GcPYq9q3DZX6yTZZlQTTMfFQngnCXPBt3Gndm3D17Ns4SK64RSz5lQuv4KfcQ/cwAO
	 ewuXsBpwxr603WwRlQQi6qNeB5mGGgbmOkCLu1RuoEIEmLx6d+Kxr2qfvGWc/cTtps
	 ILwYJgqk1ezpSICZbqnfp8pXh6+sjSBiX/UL4eZb3fDxOKejmXkTKMEC2s9NISpLzw
	 EcF1oXDYcUunXpNHckT5wCMczVYYVo5OU9viNmHQ/pZi2ZK7vpg1Mh/8RKClDwDUR9
	 lJEs4Dq+2yUeQ==
Date: Tue, 28 Oct 2025 13:42:44 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>,
	linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, Fu Wei <wefu@redhat.com>
Subject: Re: [PATCH v3 5/5] riscv: dts: thead: Add reset controllers of more
 subsystems for TH1520
Message-ID: <aQDIVJNX0fOTbp7p@pie>
References: <20251014131032.49616-1-ziyao@disroot.org>
 <20251014131032.49616-6-ziyao@disroot.org>
 <aP9d3-deezGtCbHr@gen8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP9d3-deezGtCbHr@gen8>

On Mon, Oct 27, 2025 at 11:56:15AM +0000, Drew Fustini wrote:
> On Tue, Oct 14, 2025 at 01:10:32PM +0000, Yao Zi wrote:
> > Describe reset controllers for VI, MISC, AP, DSP and AO subsystems. The
> > one for AO subsystem is marked as reserved, since it may be used by AON
> > firmware.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  arch/riscv/boot/dts/thead/th1520.dtsi | 37 +++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> > index e680d1a7c821..15d64eaea89f 100644
> > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > @@ -277,6 +277,12 @@ clint: timer@ffdc000000 {
> >  					      <&cpu3_intc 3>, <&cpu3_intc 7>;
> >  		};
> >  
> > +		rst_vi: reset-controller@ffe4040100 {
> > +			compatible = "thead,th1520-reset-vi";
> > +			reg = <0xff 0xe4040100 0x0 0x8>;
> 
> Is this intentional so that the first VI_SUBSYS register, VISYS_SW_RST
> at offset 0x100, will have an offset of 0 from the thead,th1520-reset-vi
> reg in the driver?

Yes, it's intentional for both VI and DSP subsystem. As you could see,
excluding these TEE-only shadows, the first reset-related register in
VI_SUBSYS is at offset 0x100. For DSP subsystem, it's at offset 0x28
(and is the only reset-related register).

I want to keep the first 0x100 bytes in VI_SUBSYS, and first 0x24 bytes
in DSP_SUBSYS free, because they're clock-related registers, and should
be reserved for clock driver introduced in the future.

In TH1520 SoC, only AON and AP subsystems have strictly separated reset
and clock register regions. For all other subsystems like VI, VO, VP,
MISC and DSP, reset and clock registers tightly follow each other, but
they don't interleave.

This series follows the way in which VO clock/reset controllers are
modeled in devicetree, where the subsystem region is split into two
nodes, one for clock and one for reset. This will lead to less regular
address/size values like what you noticed, as the registers do stay very
close.

> [snip]
> > +		rst_dsp: reset-controller@ffef040028 {
> > +			compatible = "thead,th1520-reset-dsp";
> > +			reg = <0xff 0xef040028 0x0 0x4>;
> 
> Similar to rst_vi, is this intentional so that the first register,
> DSPSYS_SW_RST at offset 0x28, will have an offset of 0 in the driver?
> 
> Thanks,
> Drew

Best regards,
Yao Zi

