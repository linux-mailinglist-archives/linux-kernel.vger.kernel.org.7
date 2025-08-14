Return-Path: <linux-kernel+bounces-768157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711CBB25DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018515C253B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06526B97E;
	Thu, 14 Aug 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="YTxjIOa+"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3626657D;
	Thu, 14 Aug 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156893; cv=pass; b=NX87n2a64W1u7sWupke77cPQJhCzioc2jMkRsbVePcjQC4yodR99KSN0jNooZXjEEMj6helPQzV+uLkXXGAh/Q1ullRnkb7PPhs5nhVeNDkb19WWCUpBvioJe6tPr5mG13YiiNip7LaPA2zBPur2YBj1R0V/tjUtG3LnMW+GAl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156893; c=relaxed/simple;
	bh=BBF/fNwTWPQoevoSy9/Xsh9Ab/dF/DwKsfo7bfTF9mU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jf0rpWys1wmC21Ek81X32KzQmMLJOdt0nD59VB1KkqE7FSKu5q6cxVIfSYcNGOm7g4KDKdlGm902Xxge3UYk2ggCDEzLuzvXEwsW8Z2iIRQ4gqRmKsXS/zsQqjTCWP3/vC+RejjcjnL3WawUzDGGHNfO2WDZIjkM4KgzqSC/DIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=YTxjIOa+; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755156877; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fKqYYQjPovJHaLKPzS6aMLD1+kLkh9LIlox2AxoGF+MspddWxAPB0sAqBg6+y9FHbbczmpy47ifq+t4B0UdjI+u9pKAmIHYlbYQtJ20v7dEuhV2GmFsO36ATd7iYZdctvkLLWPWJc1zb79JmsgBJnqT+s1t4uph234Y8iAFWpAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755156877; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BBF/fNwTWPQoevoSy9/Xsh9Ab/dF/DwKsfo7bfTF9mU=; 
	b=AOl2zvh1w18fLxq83nvbektAwoScb4vXjm9uWrk7IKRtLC57IA3COQtrddRWoiHtd52Y/f9FcHRZAfkW3YCW0MB4mrlj4krrFH8J6L7Q+M+AlVgftSuY6g6yKwGGiNIj5OvzfAl6LiBzeG6J66JuV6a5/Q1l+sUN8qkpqAaG/5I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755156876;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=BBF/fNwTWPQoevoSy9/Xsh9Ab/dF/DwKsfo7bfTF9mU=;
	b=YTxjIOa+R/ZWEyP2av7wGiuW/wSunABQJi955V39p/OKSQs6bPe5qjgNquE3GaU5
	djJPaCxYVnEFtN8bb50ak0yj5fElxPZZLCfY/CMqncU4dQX0/HAN3n9J3FG8PAJrt5F
	DQu1Uspq4QS8tzY1g++DGrnCBS7tHJgRB4WAsrkmcl7//GqeTR+3mnO3LfPINlmbgKV
	A8dHTNvBoiHUpMG1B0TVMwTu4hWdjc/xDmTeGrb/0QbY0QbRwKM3fA7+JzI4aDrIIVq
	McwmRDS3ebam/qvXtyvsepJVibbsINGSiZZ1vZlhyLsCqmcR1o6ERhzeFNJP3jC9OHF
	0NwAJ47fAw==
Received: by mx.zohomail.com with SMTPS id 175515687356673.10959618963886;
	Thu, 14 Aug 2025 00:34:33 -0700 (PDT)
Message-ID: <b4216bc75530702e9e0bb951f566c04e959ac7a6.camel@icenowy.me>
Subject: Re: [RFC PATCH 1/4] dt-bindings: mailbox: thead,th1520-mbox:
 retrofit for other mailboxes
From: Icenowy Zheng <uwu@icenowy.me>
To: Krzysztof Kozlowski <krzk@kernel.org>, Drew Fustini
 <fustini@kernel.org>,  Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>, Yao
 Zi <ziyao@disroot.org>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 15:34:27 +0800
In-Reply-To: <d7278d14-2c7e-4414-9ae6-7639d8f69c94@kernel.org>
References: <20250814070757.2267325-1-uwu@icenowy.me>
	 <20250814070757.2267325-2-uwu@icenowy.me>
	 <d7278d14-2c7e-4414-9ae6-7639d8f69c94@kernel.org>
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
> > The current binding of thead,th1520-mbox can only apply to the
> > C910T
> > mailbox (which has an ID of 0).
> >=20
> > Because of the weird mailbox register mapping practice for world
> > seperation on TH1520, the binding needs some reword, in addition to
> > add
> > a property for mailbox ID, to describe other mailboxes.
> >=20
> > Update the binding, in order to make it suitable to describe other
>=20
> But I do not see any new device being added.

See PATCH 3/4 in this patchset.

Or do you mean I need to add new compatibles as I said below?

>=20
> > mailboxes. The example is also updated, with an addition of
> > mbox_c910t
> > label to show that the example describes this specfiic mailbox,
> > mailbox
> > ID added and the register window sizes updated to the values from
> > the
> > manual (previously the remote-icu0 register windows is declared to
> > be
> > overly small that it would never work).
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0.../bindings/mailbox/thead,th1520-mbox.yaml=C2=A0=C2=A0 | 49 ++++=
++++++++++-
> > ----
> > =C2=A01 file changed, 36 insertions(+), 13 deletions(-)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> > b/Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
> > index 0971fb97896ef..5a24d2e8a6a8c 100644
> > --- a/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > mbox.yaml
> > +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > mbox.yaml
> > @@ -12,6 +12,17 @@ description:
> > =C2=A0=C2=A0 through mailbox channels. It also allows one core to signa=
l
> > another processor
> > =C2=A0=C2=A0 using interrupts via the Interrupt Controller Unit (ICU).
> > =C2=A0
> > +=C2=A0 The SoC is divided to two worlds, REE and TEE, although it's
> > currently unknown
> > +=C2=A0 how to enable the seperation between worlds so the seperation
> > does not exist
> > +=C2=A0 yet. However each mailbox is assigned to a certain world, and
> > register windows
> > +=C2=A0 for mailboxes are assigned to different worlds too. In a certai=
n
> > world's
> > +=C2=A0 register windows for mailboxes, only mailboxes assigned to this
> > world will
> > +=C2=A0 have the local ICU part mapped (in addition to the remote ICU
> > part of the
> > +=C2=A0 other same-world mailbox), and mailboxes assigned to the other
> > world have
> > +=C2=A0 only the coressponding remote ICU part mapped to this world. Tw=
o
> > mailboxes
> > +=C2=A0 (C910T and E902) are assigned to the TEE world and two mailboxe=
s
> > (C906 and
> > +=C2=A0 C910R) are assigned to the REE world.
> > +
> > =C2=A0maintainers:
> > =C2=A0=C2=A0 - Michal Wilczynski <m.wilczynski@samsung.com>
> > =C2=A0
> > @@ -22,9 +33,9 @@ properties:
> > =C2=A0=C2=A0 clocks:
> > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the local=
 mailbox
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU 0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU 1
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU 2
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the other mail=
box in the same world
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the first mail=
box in the other
> > world
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the second mai=
lbox in the other
> > world
> > =C2=A0
> > =C2=A0=C2=A0 clock-names:
> > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > @@ -35,10 +46,14 @@ properties:
> > =C2=A0
> > =C2=A0=C2=A0 reg:
> > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Mailbox local base addre=
ss
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 0 base addres=
s
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 1 base addres=
s
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 2 base addres=
s
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Base address of this spe=
cific mailbox
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Base address of the othe=
r mailbox in the same
> > world
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base address of=
 the register window in this world
> > corresponding to the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first other-wor=
ld mailbox.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base address of=
 the register window in this world
> > corresponding to the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second other-wo=
rld mailbox.
>=20
> This feels like ABI change.
>=20
> > =C2=A0
> > =C2=A0=C2=A0 reg-names:
> > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > @@ -50,10 +65,17 @@ properties:
> > =C2=A0=C2=A0 interrupts:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 thead,mbox-id:
> > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ID of this specific mailbox that th=
is device tree node
> > describes. For
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatibility with old device trees, if=
 missing, the ID is
> > default to 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the C910T mailbox.
>=20
> No, you cannot have instance IDs. It's even explicitly documented in
> writing bindings.

The problem is that the mailbox cannot send to itself, so the "sending
to self" slot is redefined to other meaning.

Or should I assign different compatible strings to all 4 mailboxes
because they have different registers in the "sending to self" slot,
which have different offset because of instance ID?

>=20
> > +
> > =C2=A0=C2=A0 '#mbox-cells':
> > =C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The one and only cell describes destina=
tion CPU ID.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The one and only cell describes destina=
tion mailbox ID.
> > =C2=A0
> > =C2=A0required:
> > =C2=A0=C2=A0 - compatible
> > @@ -72,12 +94,12 @@ examples:
> > =C2=A0=C2=A0=C2=A0=C2=A0 soc {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <2>;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <2>;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mailbox@ffffc38000 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mbox_c910t: mailbox@ffffc38000 {
>=20
> No, don't add unused labels. This is not improving the binding.

Sorry.

>=20
>=20
> Best regards,
> Krzysztof


