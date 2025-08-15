Return-Path: <linux-kernel+bounces-771238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B028B2846D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2D99B61930
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406D257820;
	Fri, 15 Aug 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Iw14CfU1"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E652E5D34;
	Fri, 15 Aug 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277002; cv=pass; b=X6zur27wV+sKLcmmRhX3cGNLiOIvNI9KEEfqJWmduMDZ6Q1xv2LE/9n6i+BSpy5pEfrqb90wkk46teMW/MLQd3G/EAHgU62fsQfVkGb9ZHVkUTd4Jxi3IPwcU89y22WPqFi2QiuGJSya/SE3SRlqO9ifR0+S5Py8QlHB31KydeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277002; c=relaxed/simple;
	bh=gC5qM8Cx4LZKmph+qExp4Xp+Dwg1SSgnweE6z3hBj74=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6kqEpSeX18bJ7uG49LL/Euyr3+l4yNKiSHuFPWGYrihYy7v/K0eTQ0Sw4vEBJ+lzolxvOTj0BdxSFWS6isyxLaD5LJ1VCF6d8ZqwaDIiMoHloSiWedRiLAd16E7Ydp4xGkIlkgCpNFz+xo8HdzbRzD1UbhRjC9X2eXJjykxSIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Iw14CfU1; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755276951; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I1KZnk3WfWu1cQ1jxo1VsRmVlsIU6YWwRBnQ+f+2yAaXYuT1GF06HaMm1bYWgIykWQ3ejH8CVF9lxpbJyrekzjd/BMgRd+dyf2MFw2VWhEbBUy282KwR8JwYFjeiC+0XJRWFSrg8d1Lb8Cd/O7596VadBC0dXGsr8HG3IE0iCtc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755276951; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gC5qM8Cx4LZKmph+qExp4Xp+Dwg1SSgnweE6z3hBj74=; 
	b=ECGfifXF8LeZ11Fbrw7CIdhDs13TS94oxcGQIT4lhe+9BLYzR8fdeZzIbaUEfOeHsuniaMFNnBdkD11Em0bqxEYfB+g7+2VV3hfq/WQtT+P1ChgC2RMZazVoO5Mq8lf/zN95INDIm56czekmyvGrFe5sqvHhn8GMLFR1WVJtShg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755276951;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=gC5qM8Cx4LZKmph+qExp4Xp+Dwg1SSgnweE6z3hBj74=;
	b=Iw14CfU1QZEZi+0aTWkSK3gHhPyKKe4IiLXbJYkbjoLfA0MZA2KDOgkOvD7X/b92
	1Cnp7M+S5JGnp1c7BES11OzTUcekZv3zvAkJt5+mv24ERxQWt+/LAu8fGdKT6DBn/2/
	sPoKWxcIAeepUpnklcvR5i0jz/8BHKmzuZWU86Pme78sSmm654pDeDH1SzwjsxSRps1
	0uapNW+dtYwiAxjtklUCNrxPgcu+yUBc6f1HoQ1dK1kOqzOoAaIoZnvCO/2NbX4v/FD
	NioOsiRHXUJe7h3pK9GnM5bulOgMYxsmX4uNnn5d8fzX9w0p5ftvSrH9Kb1CXChmvdw
	QY9Rh5cP1Q==
Received: by mx.zohomail.com with SMTPS id 1755276948014489.74805819275286;
	Fri, 15 Aug 2025 09:55:48 -0700 (PDT)
Message-ID: <d07fa80e65949c4f0a5200cee1daf4783f038e37.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/8] dt-bindings: display: add versilicon,dc
From: Icenowy Zheng <uwu@icenowy.me>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Drew Fustini
 <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>,  Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner
 <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Michal
 Wilczynski <m.wilczynski@samsung.com>, Han Gao <rabenda.cn@gmail.com>, Yao
 Zi <ziyao@disroot.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org
Date: Sat, 16 Aug 2025 00:55:34 +0800
In-Reply-To: <4655d43b17c732947246f0e0deac14265fa07ca1.camel@icenowy.me>
References: <20250814164048.2336043-1-uwu@icenowy.me>
	 <20250814164048.2336043-3-uwu@icenowy.me>
	 <20250814220444.GA3988176-robh@kernel.org>
	 <5af90b60-d65b-4e80-9a27-44938bbd450b@kernel.org>
	 <4655d43b17c732947246f0e0deac14265fa07ca1.camel@icenowy.me>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-08-15=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 17:53 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2025-08-15=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 11:09 +0200=EF=
=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > On 15/08/2025 00:04, Rob Herring wrote:
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Icenowy Zheng <uwu@icenowy.me>
> > > > +
> > > > +properties:
> > > > +=C2=A0 $nodename:
> > > > +=C2=A0=C2=A0=C2=A0 pattern: "^display@[0-9a-f]+$"
> > > > +
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 const: verisilicon,dc
> > >=20
> > > If the clocks or resets varies by platform, then you need an SoC=20
> > > specific compatible still. If these clocks/resets are straight
> > > from
> > > the=20
> > > RTL and any other number of clocks/resets is wrong, then we can
> > > stick=20
> > > with just this compatible.
> >=20
> > Shouldn't we have here always SoC compatible? Can it be ever used
> > alone,
> > outside of given SoC?
> >=20
> > I could imagine now:
> >=20
> > items:
> > =C2=A0 - {}
> > =C2=A0 - const: verisilicon,dc
>=20
> I followed the `vivante,gc` situation here, because the registers
> before 0x1400 (where real display-related things start) seems to
> follow
> the same scheme with GC-series GPUs, including the identification
> registers.

An example here: the customer id (0x0030) register value read out on T-
Head TH1520 is 0x30a, but on StarFive JH6110 it's 0x30e instead.

(Both are DC8200 rev 5720, so the 0x0020 reg is 0x8200 and 0x0024 reg
is 0x5720.)

>=20
> >=20
> >=20
> > Best regards,
> > Krzysztof
>=20


