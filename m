Return-Path: <linux-kernel+bounces-862231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11220BF4BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2933B6F91
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 06:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2902638BC;
	Tue, 21 Oct 2025 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LGzwzcB4"
Received: from mx-relay04-hz1.antispameurope.com (mx-relay04-hz1.antispameurope.com [94.100.132.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64732265298
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761028868; cv=pass; b=vB4W+KbB+eCXwjnajP0GhFkk6uZNy+PnznDsDMorJ76Da2T4FPquXNqtnIBvPdejKT9ifkRdQ6o0bk6UsgfdgMpz1PC71bX78GxYOxf1UKdhhxHQtxAed4iJlpiNPTY/BewkKWV+LDX8+tnkZV4uUjXyG4HhEbluWiwej/6k7us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761028868; c=relaxed/simple;
	bh=SpnaLSUzd6z9CIBy7sLsPvKdsKrn1/W9eLsKA1qBApU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hqqg3QgY+rObbfkzfkK0w2XrRcWqM4EEXRMqu+E5sFtcIbiT0SXr+BJ82KONIwgmNdKPRNKCSsbzd0J2JGK3eu9p6F+rRjgsM2W8U/npbcHxnkKPdRj1RiS3B/hYn//EvegCMeyl2E65yEBy7ovFjljYi6LAqPPj4zJDZkiEA1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=LGzwzcB4; arc=pass smtp.client-ip=94.100.132.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate04-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Z2BoxPYyqOK4bolIbnOAqTEAwN1RnM0dwCy8BYozWgc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761028818;
 b=KrkbDw8Bz4LHxIGZQCbbDeBJJERwo3jijjZ1xVFAaox+GJFJjIXXywmtpgIKh0uE58GwF0FP
 vsPAMJ2w0vTyuiNN59XHzvhSGd6/uNlyUODMErqPguo3R6tnjauIpMfUBVRa3b8shxT+gRFpmMW
 MTaMb3spp5fBZJKGSYa4XixfTusiLxfmoi9WOzJUbtLkLvb4QxYdviYXHZZzQYAHAg8SmZJrxch
 a7sy8Pp8yEuHEpobk9L9DSXGeUiyr0QozdXsjVLH7Ran7Y0eKTPrHnaPGmJ6VkjhL4mCiTuAz9S
 K+rlp8toa8cUoEiy0BPQn1setl1U4ft/PfisceNr5JdhA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761028818;
 b=lonADuj+xmuwZXBefn646De2i5ZnSip+Osud+tD23+c5it26URpsZsaBzxj/c4xeQwXmbLm+
 nnpXWNrpmeh3Mst14wuiSAEvzGbK3XjHm7jGgm7KIWjfA9o4N9rGzbpjzCqxDJU1OsATJOCihaM
 8SIddgXcRQE4FYNitnVOyTWoCA6dVmv9ayzRKZLkJC01ndHXzi9zskQjMjquCcyRYrP6D0eXz11
 /sHO56yCn9QmJfTW/gwFhMYcM9YGN1LbOaNn6Axck/CuTqbUQEwBbbXMtDFKgCOqrLiFPidTBve
 d3HfBXOxExN7Z2f62rdi7UL35S5vyFlj29b3Q0w2SgaQw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay04-hz1.antispameurope.com;
 Tue, 21 Oct 2025 08:40:18 +0200
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 82D03CC0CC7;
	Tue, 21 Oct 2025 08:40:05 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: fsl-ls1028a: fix USB node compatible
Date: Tue, 21 Oct 2025 08:40:05 +0200
Message-ID: <5053235.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
References:
 <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
 <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay04-hz1.antispameurope.com with 4crN2Y6qXhzRjXw
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:fc7bbb2e0881c9dff808c6ef9b35ca67
X-cloud-security:scantime:2.297
DKIM-Signature: a=rsa-sha256;
 bh=Z2BoxPYyqOK4bolIbnOAqTEAwN1RnM0dwCy8BYozWgc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761028817; v=1;
 b=LGzwzcB4/bG4qIvkMW5xKdR+V0hT25oNyQpZqW8rmQbF8jaBuMSw19kx1BZgV5jtmCqrxRF3
 pM4np5REUAtrUonYh397zlDrUSxuwDf9U0Usd8bCRQU0+dDimJ3uGFHL7F1cZd3votet7rdpcLp
 pciehU0ORZLF5qMcZXkjxUyssrv4OeiNVAf8VdYlYsiguGbR9W/3al1hAlhmyR1xgftUFyPdQW8
 38rOJRIxw4Meg1gvnIlivMrOi+01k9SV4HnB4/5ugwx377/WhY+guPkaaqrEfFtMgdvCaIQwacc
 OcbKuhX6+51aXVAOA4Ue8BHePen60Y6JIsBgWzjquZ/Sw==

Hi Frank,

Am Montag, 20. Oktober 2025, 22:11:20 CEST schrieb Frank Li:
> On Mon, Oct 20, 2025 at 03:37:53PM +0200, Alexander Stein wrote:
> > usb/fsl,ls1028a.yaml says the compatible is just a simple
> > 'fsl,ls1028a-dwc3'
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>=20
> Thanks, but it is similar with last patches of
>=20
> https://lore.kernel.org/imx/20250929-ls_dma_coherence-v5-4-2ebee578eb7e@n=
xp.com/
>=20
> Waiting for shanw pick dts part.

Ah, I missed that. Thanks for the link

Best regards
Alexander

>=20
> Frank
>=20
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm6=
4/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 7d172d7e5737c..ddfb007dda920 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -613,7 +613,7 @@ gpio3: gpio@2320000 {
> >  		};
> >
> >  		usb0: usb@3100000 {
> > -			compatible =3D "fsl,ls1028a-dwc3", "snps,dwc3";
> > +			compatible =3D "fsl,ls1028a-dwc3";
> >  			reg =3D <0x0 0x3100000 0x0 0x10000>;
> >  			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> >  			snps,dis_rxdet_inp3_quirk;
> > @@ -623,7 +623,7 @@ usb0: usb@3100000 {
> >  		};
> >
> >  		usb1: usb@3110000 {
> > -			compatible =3D "fsl,ls1028a-dwc3", "snps,dwc3";
> > +			compatible =3D "fsl,ls1028a-dwc3";
> >  			reg =3D <0x0 0x3110000 0x0 0x10000>;
> >  			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> >  			snps,dis_rxdet_inp3_quirk;
> > --
> > 2.43.0
> >
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



