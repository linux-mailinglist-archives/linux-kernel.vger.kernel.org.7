Return-Path: <linux-kernel+bounces-816745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A137B577DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6403BDEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602C418A6CF;
	Mon, 15 Sep 2025 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="D2h/Heah"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FAEAF9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934983; cv=none; b=D8Y8rY3bm0v+KrhyrBbPpLNX1dg8xupTqCdmIx1Gfnx9+uZ7UQezvJnqBiM8vxMY2TNVBLwJDGs0kPsQ3T2ujD9FKKzomiEeKabJF1yUXEx0GvH6VX/s4UTp/Pjg7ScWTC/i8T18QiWfUfUCmVfvgupkprw7nTiifgxxq8vwXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934983; c=relaxed/simple;
	bh=F9mIgF95+g7qxIu51oprAqeiRAaBYGZLzrOrNew79ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERTu0/eTtHpe7LU1GuC+gOTJWavIYWmezDUkgEUrRlEw0BDZilc2dTaONBbbo3Ag3QFlLHGNiFNrWGWfRW3evPkhOz9G43sgitcoL/VxAdFYgUPbOh5+wGbk0RoOuKArHyxe1PSXaTRnKVxgYVHs+OnnCI4a/wNEa3jma9Efo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=D2h/Heah; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 52270240104
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:16:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757934980; bh=ohvDP8osKuunTpp4VuXEGFMj1lvZubJde5NjZIldsbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=D2h/HeahBUJoV9e7i6ZjabjYV9YkJLUI08L7wunHCU2gdYWjIqt3KOCaUQeaNq6vB
	 MwUjSY21HeZorgKxCuL0LZI1SCq1BOBF5xefM+Orkpx0WbFT9pj3D4bfoUEmgXkZgo
	 1afrMT2ZEJcIYnEZjuzDCzFB5InUp3VxIuIQik1gpVPVbeOIbK77XCvK2ekY286TTp
	 TtzGzoQA3bE0GhPXRl9BTlgRnqXvMglZ+19AzlTtUXeJ30MVQhWdO/mSeM0HkLcESG
	 wHtr1BBG71epZ61Kk0pH50jXl4vh2z4R2U9spFYrM6hLUTuylUtmtkbiN/wuhbQsb1
	 lobUgdruberiA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cQMst0r15z6twB;
	Mon, 15 Sep 2025 13:16:17 +0200 (CEST)
Date: Mon, 15 Sep 2025 11:16:19 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h313: Add Amediatech X96Q
Message-ID: <aMf1gYbEfWerO7_J@probook>
References: <20250912-x96q-v1-0-8471daaf39db@posteo.net>
 <20250912-x96q-v1-2-8471daaf39db@posteo.net>
 <aMPftsaf4x61-bGY@probook>
 <CAGb2v66khAeP5pCq6RCrPUwQr=tDqJ6O6cs0gokbMNjpTejuvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66khAeP5pCq6RCrPUwQr=tDqJ6O6cs0gokbMNjpTejuvw@mail.gmail.com>

On Fri, Sep 12, 2025 at 04:56:36PM +0800, Chen-Yu Tsai wrote:
> On Fri, Sep 12, 2025 at 4:54 PM J. Neuschäfer <j.ne@posteo.net> wrote:
> >
> > On Fri, Sep 12, 2025 at 01:52:10AM +0200, J. Neuschäfer via B4 Relay wrote:
> > > From: "J. Neuschäfer" <j.ne@posteo.net>
> > >
> > > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > > output, and infrared input.
> > >
> > >   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
> > [...]
> > > +&gpu {
> > > +     mali-supply = <&reg_dcdcc>;
> > > +     status = "okay";
> > > +};
> >
> > Note for v2: The GPU gets stuck in probe deferral, and I forgot to
> > investigate why.
> 
> You are probably missing the GPU power domain driver?

Indeed, with CONFIG_SUN50I_H6_PRCM_PPU=y the GPU probes successfully:

[    1.396826] panfrost 1800000.gpu: clock rate = 432000000
[    1.396859] panfrost 1800000.gpu: bus_clock rate = 200000000
[    1.400125] panfrost 1800000.gpu: clock rate = 432000000
[    1.400158] panfrost 1800000.gpu: bus_clock rate = 200000000
[    1.403263] panfrost 1800000.gpu: clock rate = 432000000
[    1.403297] panfrost 1800000.gpu: bus_clock rate = 200000000
[    1.406582] panfrost 1800000.gpu: clock rate = 432000000
[    1.428046] panfrost 1800000.gpu: bus_clock rate = 200000000
[    1.442411] panfrost 1800000.gpu: clock rate = 432000000
[    1.455175] panfrost 1800000.gpu: bus_clock rate = 200000000
[    1.466484] panfrost 1800000.gpu: mali-g31 id 0x7093 major 0x0 minor 0x0 status 0x0
[    1.476828] panfrost 1800000.gpu: features: 00000000,000027f7, issues: 00000000,00000400
[    1.493284] panfrost 1800000.gpu: Features: L2:0x07100206 Shader:0x00000000 Tiler:0x00000209 Mem:0x1 MMU:0x00002821 AS:0xff JS:0x7
[    1.493297] panfrost 1800000.gpu: shader_present=0x1 l2_present=0x1
[    1.506114] [drm] Initialized panfrost 1.4.0 for 1800000.gpu on minor 0


Thanks,
J. Neuschäfer

