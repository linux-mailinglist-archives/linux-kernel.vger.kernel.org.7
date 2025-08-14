Return-Path: <linux-kernel+bounces-768211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFDFB25E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161EE176594
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62C2222A7;
	Thu, 14 Aug 2025 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="hxQo3WhH"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EF1A9F89;
	Thu, 14 Aug 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158573; cv=pass; b=hJUH4TWYq6IPCQxKwXIkRrmPkA/lF0Fkr8+VpFxmSEFIFn/9mSGyQ1XsgMFRaLTkgIUjaCRonq6n2mS3WGob0o9O7ROiS/3Z4iHTDqSEV1cV1a2eMrSAVTyIcB0eIpSkAOXcL6bMkD/SAigLinfpqU02YxIbG8TYDLvogf4NSC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158573; c=relaxed/simple;
	bh=f/wKxshUZhaZNar0Zlch7+Twy7pAeN7yogFZWA9yzTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5t2h4/5AZaLMDwliHJxOse7yfDpIeXbVWrJaoy7JcXgsDkxYcYR+uzG/G/aOJtc3Y/HmfjDj+JCzdd9el7HtQuQf3YgPXk5N1CRf1d3JSXBNcdSztSHVxMAchTRMN3yo+t2oSCUeVIS36lU5xA2siyP/G5+zqgODF4jeWKiJYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=hxQo3WhH; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755158558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RHXixHNBdTtrBxOJXA/yYxkQVxqfR19st3YD0phMaoazzsr2SYL0Rbc+bOIRpKjL+7mam3OWtdUWhQtQsBS7oeDA5hWRa/Sp+x4xnHSbQ98URYhwDEl3cLFrKgIMYM3VwRu4K3CelG8p+UPPT99AKkoeMjFT+swrn/FhLZm28XE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755158558; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f/wKxshUZhaZNar0Zlch7+Twy7pAeN7yogFZWA9yzTY=; 
	b=hFBdleHrmRANj/Jk+JaQ+IZwC0cNGJTa8s2apbvVEnhSg/9CR5LmamlobmtsjelYE3e2SKCnY/f2y8M/tOePBj9Td4ZfrfL1RZz5wEkbFF3xuDOoL16ZdRu3lWIHoxI3E3vWxxlj8qJYJPWKMrUxhC/3Ca19AEpibAjOnhoGyyM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755158558;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=f/wKxshUZhaZNar0Zlch7+Twy7pAeN7yogFZWA9yzTY=;
	b=hxQo3WhHcLWjG4/Sp34MDf5LMOtLVC5CjRMuRXPyqNs0d1/Q/+9nM29ShSqNxzPm
	B8Z5cN1RJquJL5TcGVdl3EzNQtPBcuZQ/rvxD8LqbGqimfqE6KSlwxjtndsCwTEIL1Q
	lmPwB17Od520unjr4YYgihaIN4HFyoRUrz4RWSGPnwFS8l15aZQOoE0CcG0iS6zrPOj
	la6mdf6za4TRuww8VN63YIpB9bJy0XywrBwClNwGGvWDrJ1PfDJphd2J+3MSpizCOWu
	IpvUQoqbKhAH4kg9dhuzW6k2PjpBYFbSrnDKJATwUIrosAgID8kmTOm2VjH7ZmtJwyo
	XRLgbPDuaA==
Received: by mx.zohomail.com with SMTPS id 1755158555780524.3523869099616;
	Thu, 14 Aug 2025 01:02:35 -0700 (PDT)
Message-ID: <1b0619dc692308fc5d9b9a89535f9cda2567d1f8.camel@icenowy.me>
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
Date: Thu, 14 Aug 2025 16:02:29 +0800
In-Reply-To: <ad3f03da-696d-4e87-a218-9c9f26f830f7@kernel.org>
References: <20250814070757.2267325-1-uwu@icenowy.me>
	 <20250814070757.2267325-2-uwu@icenowy.me>
	 <d7278d14-2c7e-4414-9ae6-7639d8f69c94@kernel.org>
	 <b4216bc75530702e9e0bb951f566c04e959ac7a6.camel@icenowy.me>
	 <ad3f03da-696d-4e87-a218-9c9f26f830f7@kernel.org>
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

=E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:48 +0200=EF=BC=
=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> On 14/08/2025 09:34, Icenowy Zheng wrote:
> > =E5=9C=A8 2025-08-14=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 09:18 +0200=EF=
=BC=8CKrzysztof Kozlowski=E5=86=99=E9=81=93=EF=BC=9A
> > > On 14/08/2025 09:07, Icenowy Zheng wrote:
> > > > The current binding of thead,th1520-mbox can only apply to the
> > > > C910T
> > > > mailbox (which has an ID of 0).
> > > >=20
> > > > Because of the weird mailbox register mapping practice for
> > > > world
> > > > seperation on TH1520, the binding needs some reword, in
> > > > addition to
> > > > add
> > > > a property for mailbox ID, to describe other mailboxes.
> > > >=20
> > > > Update the binding, in order to make it suitable to describe
> > > > other
> > >=20
> > > But I do not see any new device being added.
> >=20
> > See PATCH 3/4 in this patchset.
> >=20
> > Or do you mean I need to add new compatibles as I said below?
>=20
> I don't know... you say there are some other mailboxes (I understand
> as
> mailbox controllers) but I don't see anything being added here.
>=20
>=20
> >=20
> > >=20
> > > > mailboxes. The example is also updated, with an addition of
> > > > mbox_c910t
> > > > label to show that the example describes this specfiic mailbox,
> > > > mailbox
> > > > ID added and the register window sizes updated to the values
> > > > from
> > > > the
> > > > manual (previously the remote-icu0 register windows is declared
> > > > to
> > > > be
> > > > overly small that it would never work).
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > > > =C2=A0.../bindings/mailbox/thead,th1520-mbox.yaml=C2=A0=C2=A0 | 49
> > > > ++++++++++++++-
> > > > ----
> > > > =C2=A01 file changed, 36 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > > > mbox.yaml
> > > > b/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > > > mbox.yaml
> > > > index 0971fb97896ef..5a24d2e8a6a8c 100644
> > > > --- a/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > > > mbox.yaml
> > > > +++ b/Documentation/devicetree/bindings/mailbox/thead,th1520-
> > > > mbox.yaml
> > > > @@ -12,6 +12,17 @@ description:
> > > > =C2=A0=C2=A0 through mailbox channels. It also allows one core to s=
ignal
> > > > another processor
> > > > =C2=A0=C2=A0 using interrupts via the Interrupt Controller Unit (IC=
U).
> > > > =C2=A0
> > > > +=C2=A0 The SoC is divided to two worlds, REE and TEE, although it'=
s
> > > > currently unknown
> > > > +=C2=A0 how to enable the seperation between worlds so the
> > > > seperation
> > > > does not exist
> > > > +=C2=A0 yet. However each mailbox is assigned to a certain world,
> > > > and
> > > > register windows
> > > > +=C2=A0 for mailboxes are assigned to different worlds too. In a
> > > > certain
> > > > world's
> > > > +=C2=A0 register windows for mailboxes, only mailboxes assigned to
> > > > this
> > > > world will
> > > > +=C2=A0 have the local ICU part mapped (in addition to the remote
> > > > ICU
> > > > part of the
> > > > +=C2=A0 other same-world mailbox), and mailboxes assigned to the
> > > > other
> > > > world have
> > > > +=C2=A0 only the coressponding remote ICU part mapped to this world=
.
> > > > Two
> > > > mailboxes
> > > > +=C2=A0 (C910T and E902) are assigned to the TEE world and two
> > > > mailboxes
> > > > (C906 and
> > > > +=C2=A0 C910R) are assigned to the REE world.
> > > > +
> > > > =C2=A0maintainers:
> > > > =C2=A0=C2=A0 - Michal Wilczynski <m.wilczynski@samsung.com>
> > > > =C2=A0
> > > > @@ -22,9 +33,9 @@ properties:
> > > > =C2=A0=C2=A0 clocks:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the l=
ocal mailbox
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU=
 0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU=
 1
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for remote ICU=
 2
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the other =
mailbox in the same
> > > > world
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the first =
mailbox in the other
> > > > world
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Clock for the second=
 mailbox in the other
> > > > world
> > > > =C2=A0
> > > > =C2=A0=C2=A0 clock-names:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > @@ -35,10 +46,14 @@ properties:
> > > > =C2=A0
> > > > =C2=A0=C2=A0 reg:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Mailbox local base a=
ddress
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 0 base ad=
dress
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 1 base ad=
dress
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Remote ICU 2 base ad=
dress
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Base address of this=
 specific mailbox
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Base address of the =
other mailbox in the
> > > > same
> > > > world
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base addres=
s of the register window in this world
> > > > corresponding to the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 first other=
-world mailbox.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base addres=
s of the register window in this world
> > > > corresponding to the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 second othe=
r-world mailbox.
> > >=20
> > > This feels like ABI change.
> > >=20
> > > > =C2=A0
> > > > =C2=A0=C2=A0 reg-names:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > > @@ -50,10 +65,17 @@ properties:
> > > > =C2=A0=C2=A0 interrupts:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > =C2=A0
> > > > +=C2=A0 thead,mbox-id:
> > > > +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/uint32
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The ID of this specific mailbox tha=
t this device tree
> > > > node
> > > > describes. For
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatibility with old device trees=
, if missing, the ID
> > > > is
> > > > default to 0,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the C910T mailbox.
> > >=20
> > > No, you cannot have instance IDs. It's even explicitly documented
> > > in
> > > writing bindings.
> >=20
> > The problem is that the mailbox cannot send to itself, so the
> > "sending
> > to self" slot is redefined to other meaning.
>=20
> I don't know what is sending to self...

The first mailbox's definition is {global_control,
receiving_from_mailbox_1, receiving_from_mailbox_2,
receiving_from_mailbox_3}, and the second one's is
{receiving_from_mailbox_0, global_control, receiving_from_mailbox_2,
receiving_from_mailbox_3}, in such a pattern.

The current compatible works for the first mailbox only because it
assumes the mailbox is the first one, thus expecting the 0x0 offset of
receiving end is the global control.

Well, by totally drop the current compatible and write a new one from
scratch, and specify all these ports in reg property (instead writing a
single local-icu register window), all these problems could be solved -
- but in this case even the mailbox consumer will be affected, because
in this case the mailbox channel cell will be correspond to register
zones instead of hardware-based mailbox IDs. (in the current binding
<&mbox 0> is forbidden because it means sending from mailbox 0 to
mailbox 0, an invalid operation; but in the new binding <&mbox 0> will
be sending to the mailbox specified with reg-name "tx-0" instead.)

>=20
> >=20
> > Or should I assign different compatible strings to all 4 mailboxes
> > because they have different registers in the "sending to self"
> > slot,
> > which have different offset because of instance ID?
>=20
> Commit msg is quite vague in describing hardware. It has a lot of
> text
> but no answers to questions. What are the differences? What is the
> hardware?
>=20
> if you have different programming model, then you have different
> compatibles, usually.
>=20
>=20
> Best regards,
> Krzysztof


