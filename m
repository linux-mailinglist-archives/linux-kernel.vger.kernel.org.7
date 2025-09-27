Return-Path: <linux-kernel+bounces-835058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA095BA6283
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284543A7622
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7844E235057;
	Sat, 27 Sep 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="IH0cT6yu"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D222FDE8;
	Sat, 27 Sep 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997272; cv=none; b=KoD01r146jKYHIn03Mbhq+28HOsLzHh6fQ4bG2UnNpd+GWNJL29mAZ77gUhrGjyVT6YMUs3alvFcF+aofPqgI2pDnoIIndPb8J9Gl0xoXLw9d+MExYxJM5J4Wsa6G667K4H4GI8zlPQ14qcj64o7RXVonQD2KblZkChyJWwIOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997272; c=relaxed/simple;
	bh=iRvUWO14IYrtPSXU7ffsu0elDCkPUwlfmGpY4JndV70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTA4BdMW7ik6ca9+uMPaEXO5LqZSwnTDfkzrTdArAOuBfQVAqmKGtC7S5sTp6u65AD/Wf6jQkYVY/B+uza/b93DEkZu8DY5iQ0zgD21Rk88bTQVKvqZVDOeK05fxECaXQskmttS63NKruGJW0vSO4u5o4L3ztRv/H2rZUBr1ivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=IH0cT6yu; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1758997259; bh=iRvUWO14IYrtPSXU7ffsu0elDCkPUwlfmGpY4JndV70=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=IH0cT6yu6L/lBzS+ceoZgxgILcm/jFJXSYibwG7Gsy4IErnLbYByvodAVXhLBNhdx
	 ef5hpF1xyB0wbPgHSMGm5/q+ahWF/fQcndbkphzzxczYrtBqWa7leMJtssWnSpPHEI
	 r9aqy6/0iTH/2RRrAGwMePlgb5ZRlgO1TDc/yiXg=
Date: Sat, 27 Sep 2025 20:20:59 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?B?QmFsdGF6w6Fy?= Radics <baltazar.radics@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, 
	Andre Przywara <andre.przywara@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: ASoC: sun4i-codec: Missing snd_soc_component_driver names
 causing NULL pointer dereference
Message-ID: <w5dviim2u2kc4enifywag2skacq72qz5enpjk6orica7kyith6@2ukao7sjagj5>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Mark Brown <broonie@kernel.org>, =?utf-8?B?QmFsdGF6w6Fy?= Radics <baltazar.radics@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>, 
	Andre Przywara <andre.przywara@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <ffef657cce57b7bce005b99f9b14dc81c9ae4535.camel@gmail.com>
 <391d0e76-93bb-48a4-a6d5-2938766710a0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <391d0e76-93bb-48a4-a6d5-2938766710a0@sirena.org.uk>

Hi Baltazár,

On Fri, Sep 26, 2025 at 04:31:25PM +0100, Mark Brown wrote:
> On Fri, Sep 26, 2025 at 05:10:30PM +0200, Baltazár Radics wrote:
> > I ran into an issue where the kernel would panic depending on sun4i-
> > codec vs sun8i-codec-analog driver load order. (If both are compiled-
> > in, the default order does reproduce the crash.)If sun4i-codec was
> > loaded before its analog component, snd_soc_register_card would return
> > -EPROBE_DEFER. During cleanup snd_soc_unregister_component_by_driver
> > tries to find components by driver name leading to the following oops:

Your kernel version (6.16.5) does not contain fix for this:

  https://lore.kernel.org/linux-sound/87ect8ysv8.wl-kuninori.morimoto.gx@renesas.com/

Kind regards,
	o.

> Copying in some of the people who work on sunxi.  It seems clear that we
> should handle missing names more gracefully here.
> 
> > 
> > [    0.841199] 8<--- cut here ---
> > [    0.844315] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
> > [    0.853268] [00000000] *pgd=00000000
> > [    0.856885] Internal error: Oops: 5 [#1] SMP ARM
> > [    0.861507] Modules linked in:
> > [    0.864569] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.5 #1 NONE 
> > [    0.871617] Hardware name: Allwinner sun8i Family
> > [    0.876316] PC is at strcmp+0x0/0x34
> > [    0.879911] LR is at snd_soc_lookup_component_nolocked+0x64/0xa4
> > [    0.885923] pc : [<c08e8824>]    lr : [<c075679c>]    psr: 00000013
> > [    0.892184] sp : e0821de0  ip : 00000000  fp : c0c615e8
> > [    0.897404] r10: 00000006  r9 : c0c49854  r8 : 0000001b
> > [    0.902624] r7 : c0b04de8  r6 : c125b010  r5 : c0dde7e8  r4 : c1a95a40
> > [    0.909146] r3 : c09b1d50  r2 : 0000006e  r1 : c0b04de8  r0 : 00000000
> > [    0.915669] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [    0.922802] Control: 10c5387d  Table: 4000406a  DAC: 00000051
> > [    0.928541] Register r0 information: NULL pointer
> > [    0.933250] Register r1 information: non-slab/vmalloc memory
> > [    0.938908] Register r2 information: non-paged memory
> > [    0.943958] Register r3 information: non-slab/vmalloc memory
> > [    0.949615] Register r4 information: slab kmalloc-256 start c1a95a00 pointer offset 64 size 256
> > [    0.958327] Register r5 information: non-slab/vmalloc memory
> > [    0.963984] Register r6 information: slab kmalloc-1k start c125b000 pointer offset 16 size 1024
> > [    0.972693] Register r7 information: non-slab/vmalloc memory
> > [    0.978350] Register r8 information: non-paged memory
> > [    0.983400] Register r9 information: non-slab/vmalloc memory
> > [    0.989057] Register r10 information: non-paged memory
> > [    0.994193] Register r11 information: non-slab/vmalloc memory
> > [    0.999937] Register r12 information: NULL pointer
> > [    1.004726] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> > [    1.010730] Stack: (0xe0821de0 to 0xe0822000)
> > [    1.015091] 1de0: c0b04de8 c125b010 c125b010 e0821e18 0000001b c0758f20 c1a95c0c c125b010
> > [    1.023264] 1e00: c125b010 c076c86c c1a9bc00 c1a9bc80 c125b010 c058804c c112b780 c1a95d00
> > [    1.031436] 1e20: 00000007 75b58edd c125b010 00000205 c0ddec6c 00000000 c1a9b3b8 c05821b0
> > [    1.039608] 1e40: c125b010 c0582960 c125b010 c0ddec6c c125b010 00000000 c1a9b3b8 c0582a90
> > [    1.047781] 1e60: 60000013 c0c49854 c0e25818 c0ddec6c c125b010 00000000 c1a9b3b8 c0582c74
> > [    1.055953] 1e80: c125b010 c0ddec6c c125b054 c1016000 c1a9b3b8 c0582eec 00000000 c0ddec6c
> > [    1.064126] 1ea0: c0582e5c c0580950 c1016000 c1016058 c10f7234 75b58edd c1016000 c0ddec6c
> > [    1.072298] 1ec0: c1a9b380 00000000 c1016000 c0581b74 c0b0534c 00000000 c0ddec6c c1050000
> > [    1.080471] 1ee0: 00000000 c0deb000 c0deb000 c0583bf8 c0c2ddd8 c1050000 00000000 c010e26c
> > [    1.088643] 1f00: 000004bf 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.096814] 1f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.104986] 1f40: 00000000 00000000 00000000 75b58edd c11a6200 000000f3 c11a6200 c0c49834
> > [    1.113158] 1f60: c0deb000 c0b14140 c0c49854 c0c01264 00000006 00000006 00000000 c0c004d0
> > [    1.121331] 1f80: c08f37a8 c0d04e80 c08f37a8 00000000 00000000 00000000 00000000 00000000
> > [    1.129503] 1fa0: 00000000 c08f37c4 00000000 c010014c 00000000 00000000 00000000 00000000
> > [    1.137674] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.145846] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> > [    1.154014] Call trace: 
> > [    1.154030]  strcmp from snd_soc_lookup_component_nolocked+0x64/0xa4
> > [    1.162926]  snd_soc_lookup_component_nolocked from snd_soc_unregister_component_by_driver+0x2c/0x44
> > [    1.172065]  snd_soc_unregister_component_by_driver from snd_dmaengine_pcm_unregister+0x28/0x64
> > [    1.180773]  snd_dmaengine_pcm_unregister from devres_release_all+0x98/0xfc
> > [    1.187749]  devres_release_all from device_unbind_cleanup+0xc/0x60
> > [    1.194028]  device_unbind_cleanup from really_probe+0x220/0x2c8
> > [    1.200046]  really_probe from __driver_probe_device+0x88/0x1a0
> > [    1.205977]  __driver_probe_device from driver_probe_device+0x30/0x110
> > [    1.212515]  driver_probe_device from __driver_attach+0x90/0x178
> > [    1.218533]  __driver_attach from bus_for_each_dev+0x7c/0xcc
> > [    1.224203]  bus_for_each_dev from bus_add_driver+0xcc/0x1ec
> > [    1.229871]  bus_add_driver from driver_register+0x80/0x11c
> > [    1.235457]  driver_register from do_one_initcall+0x58/0x23c
> > [    1.241134]  do_one_initcall from kernel_init_freeable+0x1dc/0x238
> > [    1.247324]  kernel_init_freeable from kernel_init+0x1c/0x12c
> > [    1.253079]  kernel_init from ret_from_fork+0x14/0x28
> > [    1.258137] Exception stack(0xe0821fb0 to 0xe0821ff8)
> > [    1.263187] 1fa0:                                     00000000 00000000 00000000 00000000
> > [    1.271359] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.279530] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > [    1.286145] Code: e5e32001 e3520000 1afffffb e12fff1e (e4d03001) 
> > [    1.292290] ---[ end trace 0000000000000000 ]---
> > 
> > The specific hardware in my case is a FriendlyARM NanoPi Duo2. Note
> > that the current device tree has the relevant node disabled, so I'm
> > running with the following patch applied:
> > 
> > ---
> > arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
> > index 2b0566d4b386..6301b1a78301 100644
> > --- a/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
> > +++ b/arch/arm/boot/dts/allwinner/sun8i-h3-nanopi-duo2.dts
> > @@ -137,6 +137,14 @@ &reg_usb0_vbus {
> >  	status = "okay";
> >  };
> >  
> > +&codec {
> > +	status = "okay";
> > +	allwinner,audio-routing =
> > +	       "Line Out", "LINEOUT",
> > +	       "MIC1", "Mic",
> > +	       "Mic", "MBIAS";
> > +};
> > +
> >  &uart0 {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&uart0_pa_pins>;
> > --
> > 
> > 
> > I'm not sure if it's the correct solution, but setting the names of
> > these snd_soc_component_driver instances does seem to fix my issue:
> > 
> > ---
> >  sound/soc/sunxi/sun4i-codec.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> > index 93733ff2e32a..f00537f7f97d 100644
> > --- a/sound/soc/sunxi/sun4i-codec.c
> > +++ b/sound/soc/sunxi/sun4i-codec.c
> > @@ -959,6 +959,7 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
> >  };
> >  
> >  static const struct snd_soc_component_driver sun4i_codec_codec = {
> > +	.name			= "sun4i-codec-codec",
> >  	.controls		= sun4i_codec_controls,
> >  	.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
> >  	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
> > @@ -971,6 +972,7 @@ static const struct snd_soc_component_driver sun4i_codec_codec = {
> >  };
> >  
> >  static const struct snd_soc_component_driver sun7i_codec_codec = {
> > +	.name			= "sun7i-codec-codec",
> >  	.controls		= sun7i_codec_controls,
> >  	.num_controls		= ARRAY_SIZE(sun7i_codec_controls),
> >  	.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
> > @@ -1278,6 +1280,7 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
> >  };
> >  
> >  static const struct snd_soc_component_driver sun6i_codec_codec = {
> > +	.name			= "sun6i-codec-codec",
> >  	.controls		= sun6i_codec_codec_widgets,
> >  	.num_controls		= ARRAY_SIZE(sun6i_codec_codec_widgets),
> >  	.dapm_widgets		= sun6i_codec_codec_dapm_widgets,
> > @@ -1307,6 +1310,7 @@ static const struct snd_soc_dapm_widget sun8i_a23_codec_codec_widgets[] = {
> >  };
> >  
> >  static const struct snd_soc_component_driver sun8i_a23_codec_codec = {
> > +	.name			= "sun8i-a23-codec-codec",
> >  	.controls		= sun8i_a23_codec_codec_controls,
> >  	.num_controls		= ARRAY_SIZE(sun8i_a23_codec_codec_controls),
> >  	.dapm_widgets		= sun8i_a23_codec_codec_widgets,
> > @@ -1527,6 +1531,7 @@ static const struct snd_soc_dapm_route suniv_codec_codec_dapm_routes[] = {
> >  };
> >  
> >  static const struct snd_soc_component_driver suniv_codec_codec = {
> > +	.name			= "suniv-codec-codec",
> >  	.controls		= suniv_codec_codec_widgets,
> >  	.num_controls		= ARRAY_SIZE(suniv_codec_codec_widgets),
> >  	.dapm_widgets		= suniv_codec_codec_dapm_widgets,
> > @@ -1952,6 +1957,7 @@ static const struct snd_soc_dapm_widget sun50i_h616_codec_codec_widgets[] = {
> >  };
> >  
> >  static const struct snd_soc_component_driver sun50i_h616_codec_codec = {
> > +	.name       = "sun50i-h616-codec-codec",
> >  	.controls   = sun50i_h616_codec_codec_controls,
> >  	.num_controls   = ARRAY_SIZE(sun50i_h616_codec_codec_controls),
> >  	.dapm_widgets   = sun50i_h616_codec_codec_widgets,
> > -- 
> > 2.51.0



