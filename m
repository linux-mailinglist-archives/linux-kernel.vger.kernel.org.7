Return-Path: <linux-kernel+bounces-764108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB94B21E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674701903B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BAF2E2DF4;
	Tue, 12 Aug 2025 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="KlxyIJFT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="VOm5I74O"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD82DF3F8;
	Tue, 12 Aug 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979282; cv=none; b=rQfnXpAMHiv8WgCaHpBl7EioKwFNWBa8oeH3JIWFf0fDj8nJAKIHJ24gsUnLSS35yJQrF140LT21GtVHmjfvatNitLsuQ4siYT5ryZrzElPoq7BAcTRArPmX4+eO3VzF/R3XwvIv/+dncR7d7+If/CymrPL6LD2KidWDhQuNC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979282; c=relaxed/simple;
	bh=4n7r1OIpw6fzOoFrlrKeD7qcewHqoXmWCm7O/kfW/KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhCFmeRiukZAWYQn28KAdaGSHRhag7A/DMCWXqPShYf31woIqLh1OR2NB/LYqSrehucvpT88h+CH2YVor7M+6jkG66Qznanrf2JzTpz+wyH/ZtuxXh+rFEn0PdL1G7AhCiUfSA2lmWBQsLqRRNmH+xzvqS/kPKAYt2seByV7rkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=KlxyIJFT; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=VOm5I74O reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1754979279; x=1786515279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kDMXkiqwspte3OFxiCO5uJIctYbcK6fSwBNuY8L+04=;
  b=KlxyIJFTDi8jkKZ96RCseLFLY+6kx8l9LbtZmWglSXEM/6ABSGiWab7k
   DArQ6Buart7k/y5qx55d8bJxE2Hh0+eYyaR6ZmNE37wkDuqTtQZekTG9E
   gJmqalSsajXSOB3WTljXubGE91yMaGIPYewTtytz+kRyOAxCw/dQWTH2+
   q5TKMZ7PFkSgWxlt1csosldTpMGn/54icmBLxvb+oEfHpVwSDMM5Bb+IJ
   yH3SPYtpjRgGV2hjWCgK462Y59PP3LG6WKGKsufH6T8B4M5XYOmmdgZKj
   k98CQ//gwbaDnebmXd+7iuFwNyeLN4aSypbhFDvlrZoo8507Vc1CCxrSW
   w==;
X-CSE-ConnectionGUID: B4ffp1ALSjKWb0uJfw2sUg==
X-CSE-MsgGUID: 0MqoVO07Ql6hiYkpsM+9JA==
X-IronPort-AV: E=Sophos;i="6.17,284,1747692000"; 
   d="scan'208";a="45692356"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2025 08:14:30 +0200
X-CheckPoint: {689ADBC6-33-AD8F5F64-F0EACAA5}
X-MAIL-CPID: 742ED08D02BE758A2A1B26C8759E02E3_1
X-Control-Analysis: str=0001.0A002104.689ADBC7.002A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AFFA16835C;
	Tue, 12 Aug 2025 08:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1754979266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kDMXkiqwspte3OFxiCO5uJIctYbcK6fSwBNuY8L+04=;
	b=VOm5I74Oo5znWlaXmN6u8OJRm5q/YOa+tu/QK1DPY5JPD+J7KZGpK5JP+DU17ptUV0Hb3E
	zH0KCm5pUcm6jc+JsrDLMmMdfbkLdqmuDZgGcNI/xvacXZt35YOmrj5rS/9qA01yQEkhMJ
	qehK313US2ohYsMtXl+5cbLNmpe9CNMuB0qhy/HsC7aaAqu2XMQP6PVnkDcsIvmCJYaCfC
	WjOI/fho5sWWLpFhNWOR9IAwC/vgZ4/7MJ2OQsWnx0gS9ILCSyIHS9ec+va7ZwIFDbnqM0
	D2KA/TaS1pwf8V1K4T/3Ax/ptch+2mCRXDQ/5g5cJwC/31mROSUCp/lNkZNCXQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: fsl: fsl,
 rcpm: Add #power-domain-cells
Date: Tue, 12 Aug 2025 08:14:24 +0200
Message-ID: <2799138.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <aIv+CgkePusUoT6Q@lizhi-Precision-Tower-5810>
References:
 <20250731055806.2265628-1-alexander.stein@ew.tq-group.com>
 <20250731-funky-crab-of-defense-7cd658@kuoka>
 <aIv+CgkePusUoT6Q@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

Am Freitag, 1. August 2025, 01:36:42 CEST schrieb Frank Li:
> On Thu, Jul 31, 2025 at 08:32:57AM +0200, Krzysztof Kozlowski wrote:
> > On Thu, Jul 31, 2025 at 07:58:04AM +0200, Alexander Stein wrote:
> > > dtbs_check for ls1021.dtsi warns about unsupported property:
> > >  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' d=
oes not match any of the regexes: '^pinctrl-[0-9]+$'
> > >
> > > But if removed the check warns about missing property:
> > >  power-controller@1ee2140 (fsl,ls1021a-rcpm): '#power-domain-cells' i=
s a required property
> >
> >
> > And if any other warning says something, are you going to do that as
> > well?
> >
> > >
> > > Given commit 8bcf67b8d893b ("ARM: dts: ls1021a: add #power-domain-cel=
ls
> > > for power-controller node") explicitly added that property, add it
> > > to the expected property list as well.
> >
> > No, commit does not explain why! It's one of this NXP commits without
> > explanation, doing random things.
> >
> > No, explain why do you think this is a power domain provider - fast
> > look told me that it is NOT.
>=20
> It is not power controller. rcpm controller enable wakeup source.
>=20
> In arm64, use below patch to fix warning
>=20
> commit e39f567e1c38c29629962ab327f0ad1a288dcab2
> Author: Frank Li <Frank.Li@nxp.com>
> Date:   Mon Jul 29 14:59:24 2024 -0400
>=20
>     arm64: dts: layerscape: rename rcpm as wakeup-control from power-cont=
rol
>=20
>     Invoke power-domain.yaml if node name as 'power-control'.
>=20
>     Rcpm actually are not power domain controller. It just control wakeup
>     capability. So rename it as wakeup-control. Fix below CHECK_DTBS warn=
ing.
>=20
>     power-controller@1ee2140: '#power-domain-cells' is a required property
>             from schema $id: http://devicetree.org/schemas/power/power-do=
main.yaml#
>=20
>     Signed-off-by: Frank Li <Frank.Li@nxp.com>
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>=20

Thanks for the link. I've applied a similar change to ls1021 instead of thi=
s patch.

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



