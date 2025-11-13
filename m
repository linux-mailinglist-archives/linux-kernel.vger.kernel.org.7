Return-Path: <linux-kernel+bounces-899683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB591C588B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5A4D36270B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39EA2F5A0A;
	Thu, 13 Nov 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="O+O8RiMb"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71046351FA2;
	Thu, 13 Nov 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048429; cv=pass; b=Vl+ORBaB34V11y6fdm1SOZ1JtmHWZRaJRZ+uG2xMvs2E0O97BBa/E/NNan+5chMS/8++BoqIh92vVzSlwYqJGUE/lq3P6k2ke+gxz3Zs/X0X8+MgRpgwFswmXrMK8IjT/RbkWm4nzOqXDNw9mOe9gsV5CjnOeBiWJU90sA4tPn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048429; c=relaxed/simple;
	bh=4fCKpLICjk4fw3t90InQG4ReeV3U8XAuF/jebYZ0WAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YrpIaZJFb0J24TBEKZl5QkM4Grhx1c8pX2LUV85MFfYvZKCWBdtLAQSvppEcANTMriBPANQyLFhWaul1Dtqc+6CHGyOujdsw8FfgEvUQ1ddjoS0kAizPrdj4R3pcqLI5MQ4TeuYeagpNA/jMN0zC0vi+3BFTEBrIlmuoG2pnfRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=O+O8RiMb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1763048398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UNPr05+3rQh/UX8A79WkVE3XBsOWQP3yPWzrXpjH8uXAO6VYGfco9truRuNCJiU89S6PI8j3C9/faqIDz7XeG9HwC+tQ1tnnJ/NaCZIttRDFg4LPXEgGHwqKkaNiFNLbaZlPabhD1fW6tigFh4GMiB4Zff7puNtdc0+Xb5Us3hA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763048398; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4fCKpLICjk4fw3t90InQG4ReeV3U8XAuF/jebYZ0WAM=; 
	b=Zv74+CsFskvWeG5gxXcFtH16LGVr8oim8hmGWniEh5pXCcv4aZz0/voktwkcg1AU8KR4JaNa/K1oiG7WIzqsIE6CpVFJNBRhYnpRtZ4y0cAHaah/sYMHex/kRSt+xxd+GzrR+btbW0jDkYucLRrYz8BLI/hMT1alT5OAEqtL+QQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763048398;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=4fCKpLICjk4fw3t90InQG4ReeV3U8XAuF/jebYZ0WAM=;
	b=O+O8RiMbN3SSMtvLRz4S4WI6l2OK8qbQtKSMnptUwB+I2GEsR4m4ffWqr+XLIdIZ
	mNWrcRYE2cskC/7zxd1qo/YthVEOWKj+vuzW9HV1SMVfWLsoA1a9fGRKhVHF8aUXrQm
	DoDY8nS53KB4W+93qDMp8OFqNlR1vRvsf223HJ9GUSvW1SHk0rognsKb6yUol9gfSoY
	ZVGYDSakWdmTNHq2egBATXcMbEaooPHUOtfGR4wUoApR/jkEz+IX/PDkSepn8WR2Ckz
	hnEZg5mHgvsPsTr09JRbrDW4WUiVJvCbUH19NMpCRNYf06Tn9V1jtowzUKTd04yEDFB
	sfFdHN3BSA==
Received: by mx.zohomail.com with SMTPS id 1763048395696100.40154822714373;
	Thu, 13 Nov 2025 07:39:55 -0800 (PST)
Message-ID: <af984cf6b76fb4cd30f12fbb9ddd889a5e73d036.camel@icenowy.me>
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: starfive: add Orange Pi RV
 board compatible
From: Icenowy Zheng <uwu@icenowy.me>
To: Emil Renner Berthing <kernel@esmil.dk>, Albert Ou
 <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley
 <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>, E Shattow
 <e@freeshell.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Zhu
 <michael.zhu@starfivetech.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Yao Zi
 <ziyao@disroot.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 13 Nov 2025 23:39:45 +0800
In-Reply-To: <CANBLGcxoD5w7ApN9mNHWym2oo5XscV7B0rrU5MF68wiS52Eecw@mail.gmail.com>
References: <20250930100318.2131968-1-uwu@icenowy.me>
	 <CANBLGcxoD5w7ApN9mNHWym2oo5XscV7B0rrU5MF68wiS52Eecw@mail.gmail.com>
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

=E5=9C=A8 2025-11-13=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 02:55 -0800=EF=BC=
=8CEmil Renner Berthing=E5=86=99=E9=81=93=EF=BC=9A
> Quoting Icenowy Zheng (2025-09-30 12:03:17)
> > Orange Pi RV is a newly released JH7110 board by Xunlong.
> >=20
> > Add a compatible string to the starfive platform DT binding.
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>=20
> Hi Icenowy,
>=20
> Thanks for the patches! Now that E's patch is in Conor's
> riscv-dt-for-next branch
> will you be sending a v3? Also please add a cover letter when you do.

I will do this when I have time.

BTW, your this mail gets DMARC quarantined by my mail provider.

Thanks,
Icenowy

>=20
> /Emil


