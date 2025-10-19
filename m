Return-Path: <linux-kernel+bounces-859810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA8BEEA7C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98311349176
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFDC1FDE31;
	Sun, 19 Oct 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="feN0m9vz"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B5354AD4;
	Sun, 19 Oct 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893491; cv=none; b=RhhorQEKFNIF0ee8K2jDmSoTNUn1LcYKwaJxSWZHDaLxEAWJQM7/Y1wrFUaL6ZHTDyQWxNnb01LtkBcWKQAgKjBvensupoTOsagcFxm09xyghj5Ow++uSBQgxwARZ+GifrhJkW+UophK7hAz7fiOzXK3Q7WUjc9phzVHjTLFltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893491; c=relaxed/simple;
	bh=tfl+o5MxU6WN5ujGB4yOnO/BWCqJMDK1FJuUP9qbqho=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=QUfP4Aim5cyZHBIiHU8AuXQce8YC0tWvfWMRVj5OCTEt8Nl9i2NcTlYgUnoVqUM15T9g8INZRj4LYOOkZ3tqTIZfWdbNNScr0BDR8rdtvcgYTQWOmQgZhylUKbEZh/hTrnQKhVNP7lrNk2PVbdI8iSa/E7en4tuj9+wq9IxfTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=feN0m9vz; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 798F640D07;
	Sun, 19 Oct 2025 19:04:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760893480; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=89pcnqHw6GeCqqkxoyyYoM031ZknkpS6TyEdPScCLBQ=;
	b=feN0m9vz9xepdNVeyszgt4J9lygxtJJV4M+epGRMOa/A1mU8wSgxMaNeobaWfiG9n32OW0
	0BLpORvYv4TtSZ7ulhp94Crw24Xgj8BDInMP27qsN3RrdY3uaLkakvR9sUOeFvdpBOmT1J
	DEOnZb5bW2C/grjE8ZOajzOxFmkGubtqYxF/p49k4pv749kwBVwu9lX6credP+5/nFPZxy
	Q1U4MX2GYVdyyFyCZyKUibY6+2blN2b/qe0viwN079Bz8wWffKpz5h9wT2tAmya7snNdQm
	CUCSr87CTMvAUoQguQ8FO+I1Wt7UNal84mfHgsD3UZp8bRWTaK2aLofYIWW41w==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CABGV7H_pTkJ_-WQNgVbGE+Ys7jOZaKcRrnMtPr8idfKoYMgKjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org> <CABGV7H_pTkJ_-WQNgVbGE+Ys7jOZaKcRrnMtPr8idfKoYMgKjg@mail.gmail.com>
Date: Sun, 19 Oct 2025 19:04:30 +0200
Cc: "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Grzegorz Sterniczuk" <grzegorz.sterniczuk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f26601b4-c589-5909-5432-378c496e9010@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Grzegorz,

On Sunday, October 19, 2025 12:05 CEST, Grzegorz Sterniczuk <grzegorz.s=
terniczuk@gmail.com> wrote:
> [image: image.png]
> [image: IMG=5F0471.jpeg]

Nice, thanks for the pictures!  BTW, I'm hoping to get the quirk
patch(es) done and submitted to the MLs in the next few days.  Of
course, I'll Cc your and everyone else's email addresses so you
can perform the required testing and provide Tested-by tags.

> On Fri, 17 Oct 2025 at 12:25, Dragan Simic <dsimic@manjaro.org> wrote=
:
> > On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gmail=
.com>
> > wrote:
> > > From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > >
> > > Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O error=
s and
> > > corruption when using HS400 mode. Downgrade to HS200 mode to ensu=
re
> > > stable operation.
> >
> > Could you, please, provide more details about the troublesome eMMC
> > chip that gets identified as A3A444, i.e. what's the actual brand
> > and model?  Maybe you could send a picture of it?  It might also
> > help if you'd send the contents of "/sys/class/block/mmcblkX/device
> > /manfid" from your board (where "X" should equal two).
> >
> > I'm asking for that because I'd like to research it a bit further,
> > if possible, because some other eMMC chips that are also found on
> > the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be that
> > the A3A444 chip has some issues with the HS400 mode on its own,
> > i.e. the observed issues may not be caused by the board.
> >
> > [1] https://github.com/openwrt/openwrt/issues/18844
> >
> > > Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > index fafeabe9adf9..5f63f38f7326 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > > @@ -717,8 +717,7 @@ &sdhci {
> > >       no-sd;
> > >       non-removable;
> > >       max-frequency =3D <200000000>;
> > > -     mmc-hs400-1=5F8v;
> > > -     mmc-hs400-enhanced-strobe;
> > > +     mmc-hs200-1=5F8v;
> > >       status =3D "okay";
> > >  };


