Return-Path: <linux-kernel+bounces-837503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88EBAC749
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433EA1923ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E12F83C5;
	Tue, 30 Sep 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="mD02cdBe"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB0220F2A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759227744; cv=pass; b=DZRK38VVRvRLnC+YY7lSpTSnX03+QDS8gdX4b/GCZHwBrHrOHTb6gF3yZUl3c5IA1uvaFfOOe/4juX4eQBq9owlVxGNfGtSk7vOG6jQ1FlBWA7+ybblBZx8rEdRm3pIZTFldTGKIg49ngB4lAO4HzuFwEUDHayhdyvoBMpLdrQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759227744; c=relaxed/simple;
	bh=8Nr/irm6d14b2GUWGPpwgaFEBZss9/OEwPRAHeBAZLY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=d9pZRvDjEmIcIwep/wFFZwNH8nD0g02pUJa8rK3bY7UELTyaWgpSSIeWNZvyalbFUEFqX8iIh0dr45L2khUe1SlaWGcan0/2WGphAaBqAGHqIhCsTx8yLP3wt6yPPwp2HkZrt3UUMwosKU4wPrK6Of+2gduzrQMZnLg5cI8MtCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=mD02cdBe; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1759227703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LlUz2r/bnBeW6JRw8nwRoDXZZZY2EL9so/huFHB7BFJdpeR8hTGk/P9D7rYalgA4WSdahkmK5vAQcguzzuA1WEcW1jpZdHNOdTVanpHN1V6FatW9iStSTpko5M4fsvZuDxL8G2/s2ESh7D+Sj1YpnTS8I7lt7VGYU8R5/+G2rRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759227703; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tLYhrHTrMktRJa2eQUYbIC0Lw7PfMae9tloS42iEBd4=; 
	b=eRVYOnkCwdDuJ/12QPgYbD6jgq0U8DwTGErSS6amup25JsGdFe3gXjVm4wZgPIDK9eRS3V3r9rW2RzUFqFEwJBj250hQ0IxYLDBX2tbJuARADuXM+X2M1nULlld/DoHSIOQB6CP9F0Ti30gFXL4HsAAYqY4GhRJfYs/5AO1Kjr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759227703;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=tLYhrHTrMktRJa2eQUYbIC0Lw7PfMae9tloS42iEBd4=;
	b=mD02cdBeevjisSSKTZ8wjjljjrBpsYD/W/QQ57xlYuk6HQRk76Dal5y/vudfV9zc
	K2B1Deu3iLJBcoz8Nend6G8cb6llmuMI0HN2X4E7lolXJ5AKKy+A0efp67GRw4wJdsm
	BVAet2IGC4/T862FuTIhOJWqRsMiv1/XswAHQ2+U=
Received: by mx.zohomail.com with SMTPS id 175922770026256.067032893998885;
	Tue, 30 Sep 2025 03:21:40 -0700 (PDT)
Message-ID: <a1eff492b192bbe68716b46c18cd7152951c6550.camel@rong.moe>
Subject: Re: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained
 among boots
From: Rong Zhang <i@rong.moe>
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Yazen Ghannam	 <yazen.ghannam@amd.com>,
 linux-kernel@vger.kernel.org, Borislav Petkov	 <bp@alien8.de>
In-Reply-To: <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
References: <20250913144245.23237-1-i@rong.moe>
	 <20250916140227.GGaMlt8xSp3eMI8Veu@fat_crate.local>
	 <1e07144c-da10-4817-a2c6-ea11988936ee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Sep 2025 18:18:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-3 
X-ZohoMailClient: External

Hi Mario,

On Sun, 2025-09-28 at 23:01 -0500, Mario Limonciello (AMD) (kernel.org)
wrote:
>=20
> On 9/16/2025 9:02 AM, Borislav Petkov wrote:
> > On Sat, Sep 13, 2025 at 10:42:45PM +0800, Rong Zhang wrote:
> > > The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
> > > However, this could sometimes be misleading and lead to users wasting=
 a
> > > lot of time on meaningless debugging for two reasons:
> > >=20
> > > * Some bits are never cleared by hardware. It's the software's
> > > responsibility to clear them as per the Processor Programming Referen=
ce
> > > (see Link:).
> > >=20
> > > * Some rare hardware-initiated platform resets do not update the
> > > register at all.
> > >=20
> > > In both cases, a previous reboot could leave its trace in the registe=
r,
> > > resulting in users seeing unrelated reboot reasons while debugging
> > > random reboots afterward.
> >=20
> > Just a heads-up: we're figuring out internally what the right thing to =
do here
> > would be.
> >=20
> > Stay tuned.
> >=20
> > Thx.
> >=20
>=20
> The internal conversation points in the direction of your patch makes sen=
se.

Thanks for your effort!

> But I don't really see a lot of value in re-reading and printing a debug=
=20
> message about what was cleared and what's still there.  Do you see a=20
> reason to keep that around?

In order that users don't need an up-to-date documentation, or even
don't need a documentation, to distinguish between reason bits and non-
reason ones.

Let's consider two examples.

(a)

   Previous system reset reason [0x08000800]: an uncorrected error...
                                    ^   ^

A user may feel confused: Two bits are set, but only one reason is
reported. Hmm... Is there a hidden failure?

Unless the user has read the PPR, it's hard to realize BIT(11) is
already set in the reset value. The debug message is here to help:

   Cleared system reset reasons [0x08000800 =3D> 0x00000800]
                                    ^   ^         ^   ^

Now the user realizes that BIT(11) has nothing to do with reboot
reasons.

This was literally the confusion I experienced. I had to take some time
looking for an appropriate public PPR and reading the PPR before
realizing this fact.

(b)

Suppose BIT(7) is defined in the future.

   (nothing is printed to kmsg)

The debug message is here to help:

   Cleared system reset reasons [0x00000880 =3D> 0x00000800]
                                        ^^            ^^

Now the user realizes that BIT(7) represents a new reboot reason.

Thanks,
Rong

