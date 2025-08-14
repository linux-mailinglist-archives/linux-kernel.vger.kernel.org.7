Return-Path: <linux-kernel+bounces-768151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5756B25D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B51C83B51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209D826B747;
	Thu, 14 Aug 2025 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="JY1R47Nf"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC62797B8;
	Thu, 14 Aug 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156640; cv=pass; b=rTxJuwR7MRVksdXwislWTqXJN2/bONiJo4eMwdDlIVPrHE6jaiLsY+stvZkAy9RWzSuclnPJof8jesPuxJZhDdKIP9CfEdARwq2saCDODis96KK5D1wIXU5n7SNu7eDehY7up/kkCphiygI/HY3SIfglRx0o5YOOTdwxw7cwGGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156640; c=relaxed/simple;
	bh=4YKeOCrqfpj59GD3VQlFLFbf1XftNmL9kWn00fco//k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFoGjlMmV8WyPOVwHfGfR3THtcKLxOkUS1gx7rTbQcukaBbHeE2OVGmC5xqCEGTXcg0E0hoyD2y3zAFQHDoECs0EbLHFcPE0nmdwQdgf0lR5q0NLO1NfbmcS7SAxEl5qgU8WxfWwKQ8kXaOdfjJJhKAH4TVrDguQJ3MK/thv03Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=JY1R47Nf; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755156620; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SPunGYyixl+oELVyQ528XgFQeeYb0rvoaJ+Eu2HDDKE5C33LZsDBVEv1P5SDOCd1wTXRhTyKhZfeKml2gTwJMmLHxe482R2MAp3vNRwF92fRoIrgJvBhNa35WtUgYC29n6Nz+PtKRLCN/rE25olvHrZPEHfczpTMhgi4aMdYdRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755156620; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4YKeOCrqfpj59GD3VQlFLFbf1XftNmL9kWn00fco//k=; 
	b=dni2mPhibvReAa3iqkj8KXvzg1rkjJn/AIekKryJPkV65iDi+8nhn0aUW7igXL4pFiryrOZoRy7LFRXEtcI6lIwrdKUDrlb/n2bOiR2p4oPWELAnHbnvutS/oV+QhcGaRvK99LCL28xPOwATd5sTqdvMoptv2Gn2BKHE8APDWnA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755156620;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=4YKeOCrqfpj59GD3VQlFLFbf1XftNmL9kWn00fco//k=;
	b=JY1R47NfTAyWEMgXmq2J4D+EjiVlWXKVAKLmE1REJkFD3s4LCB4bryCRwEJ2uxG8
	IdkDvO/bF2zGxls4Ws4siFLpOGmamOFCTTbRLHKV3jJOEDqa59XtJAjYFq0F4sx63Mv
	dvoGYfhWlwjX39R5fv3sBp/ZQFz+5J7ijAH00roooEUJOzYSgs2C/KnT2CwTupNxkY8
	vg3QgFF0l4QPFAjMTEcRg7YHGwUPpowCrmtr+UZ5ZLo6xlDme1ObMS8XxE2ag7EEWqV
	tZtw35LE7dy/HThdoyBYmdeJTY5TMrVfeLaPMn5YaXzK+DhFQM5pGdYZXYaLU5+3qt1
	LP0fO4UVMw==
Received: by mx.zohomail.com with SMTPS id 1755156617506124.96455839373789;
	Thu, 14 Aug 2025 00:30:17 -0700 (PDT)
Message-ID: <1b63d1872f5b2c89f2fafdf717bda5ec29589b69.camel@icenowy.me>
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
Date: Thu, 14 Aug 2025 15:30:10 +0800
In-Reply-To: <d0d4c9e7-c350-4996-a53b-09b13bdb9409@kernel.org>
References: <20250814070757.2267325-1-uwu@icenowy.me>
	 <20250814070757.2267325-3-uwu@icenowy.me>
	 <d0d4c9e7-c350-4996-a53b-09b13bdb9409@kernel.org>
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

=E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:18 +0200=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 14/08/2025 09:07, Icenowy Zheng wrote:
> > The SBI firmware might want to communicate to the AON firmware too.
> >=20
> > Add a mbox-name item to allow to allocate a mailbox for SBI.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0.../devicetree/bindings/firmware/thead,th1520-aon.yaml=C2=A0=C2=
=A0=C2=A0=C2=A0 | 7
> > ++++---
> > =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> > b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> > index 3365124c7fd47..555465f4aab4e 100644
> > --- a/Documentation/devicetree/bindings/firmware/thead,th1520-
> > aon.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-
> > aon.yaml
> > @@ -26,11 +26,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0 const: thead,th1520-aon
> > =C2=A0
> > =C2=A0=C2=A0 mboxes:
> > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 maxItems: 2
>=20
>=20
> ABI break without explanation why ("allow" is not a reason to affect
> ABI) and its impact.

Is adding items an ABI break?

Or should I explicitly say "minItems: 1" here?

>=20
>=20
> Best regards,
> Krzysztof


