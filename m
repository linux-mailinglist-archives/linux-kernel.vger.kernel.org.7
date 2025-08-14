Return-Path: <linux-kernel+bounces-768214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA34B25E48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E719B5C0D50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB32E54AF;
	Thu, 14 Aug 2025 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="RRPD7QhE"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E5275108;
	Thu, 14 Aug 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158691; cv=pass; b=OUiwh7PpOMNAp0eEsOkpWgt/zRVph4jHLrUqw8KFyjHFV9P9Zycj5oWNHj7+L0YAuJkZMBbQR7a1EMc/iAg/aEDoEQ2wozZQewoHS2buSHOR0eTeAvhojcyYHT1FyQ+89bUYGrd21T+pY7K89fCjegd6hv8SrARO0Dj9mvIZ/0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158691; c=relaxed/simple;
	bh=FMmVn36sWG1jpRXXy04zEk9a4w0ZdpUm4kL73V8H7N8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QPFbl0h4bk9iOcbxe917RWlH1eJd9jEraD12Rz+0cS12eq45BWiGFivbaCq4j3r9Z69Vtb7isX1WLV4b2lZiSmXIq+PQHfsl2S6bK4lezvxzx9F46nqhepHKC61+uo1rVoNU0b9eFR+mlsqqltJwt35WGaHPj8TM43aKg+awSR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=RRPD7QhE; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755158675; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rb4ombeV9ei2da0W8tsF5zKnNPD7MkNetzD+zYg2mN0IAMeoia6Fs04cycCTUKm0u2luvT4+b+abw5ZLn9nzOOkj6SAMlJG5pd+PvlL41qxrN7WMSGGAw2p6ayEBi02UTj1KDPiAi5P1f3kaVt+oPof9zL2abCaKA8uZP8TRIrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755158675; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FMmVn36sWG1jpRXXy04zEk9a4w0ZdpUm4kL73V8H7N8=; 
	b=OwtG6yxSMdMQZYm3AgFqgQSs45w8EL8xKkgt1rKTCNrUeou/3QHFDSIldjLfCIIG2zJCIKaQho9YOf4RbPEePlycyda+l/d9zC4iwYSnXgU+wqyfkKo1eodDX4DzF8xw+jrhiK3dn2xwli45+mzY4QGNFxLuBhW7rUQNJ4Jc1fw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755158675;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=FMmVn36sWG1jpRXXy04zEk9a4w0ZdpUm4kL73V8H7N8=;
	b=RRPD7QhEVP4jcWvzvjCWF18xmvpUE+4BpOs5rnpkJc5puWa+up9q2kE1ZGjWrjPZ
	FWW7ZZNHysWowq09w3ToykOEsmWiuZxJm+45pVxLjH0+M9v9s2ouXkUB9Hhm1+g7umN
	In5jJawDo/wEz6mD/4K9zpXcHua3mjCvCwEOJ62526IBokUt8ZC1hR/M+l3Qc3hC9/k
	/FmBFVX1eCetFiZ99YMEJRw9JuLAhUO1Z7FCwPmtZ/x1cSrjgqCxsVdUtmRwi7+gsXj
	D1kdlGUf6A+q7xY955PPWrgc6ttEQrjr420SBSa69hqAVbSMiEHKsaXI2XftjpDaW9i
	grcTDD4wDw==
Received: by mx.zohomail.com with SMTPS id 175515867452093.35323223534306;
	Thu, 14 Aug 2025 01:04:34 -0700 (PDT)
Message-ID: <ec0a7543f9feb5dc096f3030c8b3d73d71834a36.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/4] dt-bindings: firmware: thead,th1520-aon: add a
 mailbox name for SBI
From: Icenowy Zheng <uwu@icenowy.me>
To: Krzysztof Kozlowski <krzk@kernel.org>, Drew Fustini
 <fustini@kernel.org>,  Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>, Yao
 Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 16:04:27 +0800
In-Reply-To: <026419bc-c0f8-4891-a348-311f51cb999f@kernel.org>
References: <20250814070757.2267325-1-uwu@icenowy.me>
	 <20250814070757.2267325-3-uwu@icenowy.me>
	 <d0d4c9e7-c350-4996-a53b-09b13bdb9409@kernel.org>
	 <1b63d1872f5b2c89f2fafdf717bda5ec29589b69.camel@icenowy.me>
	 <026419bc-c0f8-4891-a348-311f51cb999f@kernel.org>
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

=E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:49 +0200=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 14/08/2025 09:30, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:18 +0200=EF=
=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > On 14/08/2025 09:07, Icenowy Zheng wrote:
> > > > The SBI firmware might want to communicate to the AON firmware
> > > > too.
> > > >=20
> > > > Add a mbox-name item to allow to allocate a mailbox for SBI.
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > > > =C2=A0.../devicetree/bindings/firmware/thead,th1520-aon.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0 | 7
> > > > ++++---
> > > > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/firmware/thead,th1520-
> > > > aon.yaml
> > > > b/Documentation/devicetree/bindings/firmware/thead,th1520-
> > > > aon.yaml
> > > > index 3365124c7fd47..555465f4aab4e 100644
> > > > --- a/Documentation/devicetree/bindings/firmware/thead,th1520-
> > > > aon.yaml
> > > > +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-
> > > > aon.yaml
> > > > @@ -26,11 +26,12 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 const: thead,th1520-aon
> > > > =C2=A0
> > > > =C2=A0=C2=A0 mboxes:
> > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > >=20
> > >=20
> > > ABI break without explanation why ("allow" is not a reason to
> > > affect
> > > ABI) and its impact.
> >=20
> > Is adding items an ABI break?
>=20
> Adding required items is ABI break. You can easily test it. Apply
> patch
> #1 and test your DTS. Apply patch #2 and test your DTS. New warnings
> appear, so that's a proof of ABI impact.

Ah sorry I don't mean that item is required.

>=20
>=20
> >=20
> > Or should I explicitly say "minItems: 1" here?
>=20
> Yes, but you should clearly explain the impact. Is it working? Not
> working? Are you fixing something?

The jsonschema draft says "Omitting this keyword has the same behavior
as a value of 0." for minItems. [1]

[1]
https://json-schema.org/draft/2020-12/json-schema-validation#section-6.4.2-=
3

>=20
> Best regards,
> Krzysztof


