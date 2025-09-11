Return-Path: <linux-kernel+bounces-812385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD1B53779
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED41A7BB627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66635085B;
	Thu, 11 Sep 2025 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="TnxtUmxm"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9033203B4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757603921; cv=none; b=npLd5nOHMz+UOlQRvYGxvTroT2gUBPyaDXbgseBgZ5KM7AAeFi4U1VQ627uzj8FJD/E8q/7XkaSZ9dWusRpz6riK3X8dJ5UmPsXkXgYbG2RnAUX2PHjbjo4mresveFtRJkmWStPHxc/931tsFOYrF0BTm4fYTOUMTOuB9Cgt8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757603921; c=relaxed/simple;
	bh=hc3dUcHCaVL6mfc+FqBmuvBNY/4uYw4lI6GvjoLkpE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLjIEslM0qJVmziAfTsRIe3L+s4kaJqbpLeCj6hOF4Ouv5W0l3ezcUGdF5YsJFGhn86Wia7isSTbWRe1Tas1yXARD9HmHyVNHxGI3LhYkYzip8N2NSZRDrK+jcV4qB5nKF9422kyzpmW4bjes0vxvbePViQEPIAQvCw+nzRjJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=TnxtUmxm; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 0B280240101
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1757603482; bh=Ffc678fQhzI/pdu+hLX+ARqrXJLZH6TSQWiX1NPHrZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=TnxtUmxm72N0S5hLUeZoPl+SgtgB7gCg2c6AyfSQ1/KRdEH3USSX6lP9cGj7yHwND
	 hGU4uiIZBAEtb2hyK3DZkJS1Ru3vYnq/vOrm0lEImjlvbpzC96XtFaytQijHy6zz2B
	 o+rzTOCnLhwBhFVTe+fUCUDkCqdgcqybmsKlvrglJvrU+PAcGQkLq5Z4o/lKUmjGt6
	 TEfrKXgRCORHorps+nbrxO/18DlGgujQCGenDnZ8ebERLtNCbBsJXDBg/Fmg72cfbl
	 FHZ0ObAE6FsNr/Yfn8yBKziLprr+sFb504/4SN9Ek8C4NMVtiThLPwTOZDDi9LO8I8
	 du5l12wAQYDkQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cN1Gt4zm0z6v15;
	Thu, 11 Sep 2025 17:11:18 +0200 (CEST)
Date: Thu, 11 Sep 2025 15:11:21 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Chen-Yu Tsai <wens@csie.org>
Cc: j.ne@posteo.net, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ARM: dts: allwinner: orangepi-zero2: Add default
 audio routing
Message-ID: <aMLmlsZimgKVeiUF@probook>
References: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
 <20250809-opz-audio-v2-2-f4fd15552a82@posteo.net>
 <CAGb2v671xTaWkRD0xVPsgGWvykAwPESXuBLgDz-oo4ywOJ=5Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v671xTaWkRD0xVPsgGWvykAwPESXuBLgDz-oo4ywOJ=5Xg@mail.gmail.com>

On Wed, Sep 10, 2025 at 08:58:49PM +0800, Chen-Yu Tsai wrote:
> On Sun, Aug 10, 2025 at 12:18 AM J. Neuschäfer via B4 Relay
> <devnull+j.ne.posteo.net@kernel.org> wrote:
> >
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> 
> The subject is misleading. The Orange Pi Zero2 is a different board with
> the H616 SoC.

Oh, indeed. I got confused. Thank you for catching this error!

J. Neuschäfer

> 
> ChenYu
> 
> > The Orange Pi Zero Plus 2 has the same pinout[1] as the Orange Pi
> > Zero[2] (with the possible exception of line-out left/right being
> > swapped), and the Orange Pi Zero Interface Board is sold[3] as
> > compatible with both of them. We can thus use the same audio routing.
> >
> > [1]: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
> > [2]: https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
> > [3]: https://orangepi.com/index.php?route=product/product&product_id=871
> >
> > Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> > ---
> >
> > v2:
> > - new patch
> > ---
> >  .../boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts    | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> > index 7a6444a10e2534458b7380882ea4fd42bd54fea8..97a3565ac7a819be6b18d324fa6f65d0d1d2b2ad 100644
> > --- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> > +++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
> > @@ -99,6 +99,20 @@ wifi_pwrseq: pwrseq {
> >         };
> >  };
> >
> > +/*
> > + * Audio input/output is exposed on the 13-pin header and can't be used for
> > + * anything else. However, adapter boards may use different audio routing.
> > + * - http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
> > + * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
> > + */
> > +&codec {
> > +       allwinner,audio-routing =
> > +               "Line Out", "LINEOUT",
> > +               "MIC1", "Mic",
> > +               "Mic",  "MBIAS";
> > +       status = "disabled";
> > +};
> > +
> >  &de {
> >         status = "okay";
> >  };
> >
> > --
> > 2.48.0.rc1.219.gb6b6757d772
> >
> >
> >

