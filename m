Return-Path: <linux-kernel+bounces-673485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC138ACE1CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7491E1737DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD361D63C7;
	Wed,  4 Jun 2025 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prTlrsWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1B24C7C;
	Wed,  4 Jun 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052568; cv=none; b=BxzYu7AxJq+1hQnKuUpSTjqO2DNKtFcjYokV9vVsepFiUZOMktjJy9vZctXTXAIT8LFQT5/0ffyItisd9HDdGwFr0/8p5HvAl1LbkjysDv7SE3iA41bdLRrHR27aMvDE/MpsoRQ2V1tBNL0EDSs57fDnVlPd0zm5ssGgUM98hoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052568; c=relaxed/simple;
	bh=acLawW878StXvnWA+xjn0w4gxzlzkiefGpw3iDr4dkw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVUr4bNq5GHw4huU5SJliTT2+1Dom2fl5DKjgvFxhOVuIIa05w+6vEIraIykEhZJlTbsAoZonlMq773VRqHyjNYAoxc9A4aIhQLje7VLWiOVtbU39NTBccsAeGm+6K3FoPUf+cxtKjLRaLD/rcMi/OIW/grIN1XvanGSCSthHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prTlrsWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F9C4CEE4;
	Wed,  4 Jun 2025 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749052567;
	bh=acLawW878StXvnWA+xjn0w4gxzlzkiefGpw3iDr4dkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=prTlrsWiHcJqPPXwDnLSeFSH1u1eaZofMsODN2b4qWWr9lvdVJOIvAfnitx4UhVcY
	 VXLHYyg1hEIgdjJPAr9PQQGyslvB3yAXfpiRkDy8nPPPMzzxi2KT0QQqoQmuSJQqji
	 wRkh3SIK73BAoVJ6YuYyw1pTcxZhkRs65TI1zpw5PyRIBaa9jDx3uvWAQzkFNmdguH
	 gcGEBitSnUEhKLrhYAA/5hnLyFS+GtWn4ZrMa1ZXOicI9ztcIU7TG5PCX1LgGrxZdc
	 AVsKDHCGncCvFQrJkFYUOlPrV8mjePvB6QU/Gg6WvwJ4FcnhtDrhqq+dr3zacyZbWn
	 3LJGOcZH2Sk3A==
Received: from [149.88.19.236] (helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uMqTF-003GGp-8I;
	Wed, 04 Jun 2025 16:56:05 +0100
Date: Wed, 04 Jun 2025 16:56:02 +0100
Message-ID: <878qm7ec19.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	andre.przywara@arm.com,
	Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	suzuki.poulose@arm.com
Subject: Re: [PATCH v4 01/26] dt-bindings: interrupt-controller: Add Arm GICv5
In-Reply-To: <aD/0tuak7Hja8k4g@lpieralisi>
References: <20250513-gicv5-host-v4-0-b36e9b15a6c3@kernel.org>
	<20250513-gicv5-host-v4-1-b36e9b15a6c3@kernel.org>
	<aDhWlytLCxONZdF9@lpieralisi>
	<CAFEAcA_3YLMSy+OsSsRayaRciQ1+jjh-dGzEjrh2Wa8BqdmqrA@mail.gmail.com>
	<aD6ouVAXy5qcZtM/@lpieralisi>
	<CAL_JsqJ5N2ZUBeAes=wexq=EstRSZ5=heF1_6crAw76yZ9uXog@mail.gmail.com>
	<CAFEAcA-JrS0BiT66iin-pRVFadrY-pnJZ8TkDNxcjErknSCnUA@mail.gmail.com>
	<CAL_JsqL7x53an2-MaLHP5tfVXb4JxT8ORUMaA8pL-gMsWLJqkA@mail.gmail.com>
	<aD/0tuak7Hja8k4g@lpieralisi>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 149.88.19.236
X-SA-Exim-Rcpt-To: lpieralisi@kernel.org, robh@kernel.org, peter.maydell@linaro.org, krzk+dt@kernel.org, tglx@linutronix.de, conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org, andre.przywara@arm.com, arnd@arndb.de, sascha.bischoff@arm.com, timothy.hayes@arm.com, Liam.Howlett@oracle.com, mark.rutland@arm.com, jirislaby@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, suzuki.poulose@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 04 Jun 2025 08:24:38 +0100,
Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>=20
> On Tue, Jun 03, 2025 at 02:11:34PM -0500, Rob Herring wrote:
> > On Tue, Jun 3, 2025 at 10:37=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > On Tue, 3 Jun 2025 at 16:15, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 3, 2025 at 2:48=E2=80=AFAM Lorenzo Pieralisi <lpieralis=
i@kernel.org> wrote:
> > > > >
> > > > > On Thu, May 29, 2025 at 02:17:26PM +0100, Peter Maydell wrote:
> > > > > > secure.txt says:
> > > > > > # The general principle of the naming scheme for Secure world b=
indings
> > > > > > # is that any property that needs a different value in the Secu=
re world
> > > > > > # can be supported by prefixing the property name with "secure-=
". So for
> > > > > > # instance "secure-foo" would override "foo".
> > > >
> > > > Today I would say a 'secure-' prefix is a mistake. To my knowledge,
> > > > it's never been used anyways. But I don't have much visibility into
> > > > what secure world firmware is doing.
> > >
> > > QEMU uses it for communicating with the secure firmware if
> > > you run secure firmware on the virt board. It's done that
> > > since we introduced that binding. Indeed that use case is *why*
> > > the binding is there. It works fine for the intended purpose,
> > > which is "most devices are visible in both S and NS, but a few
> > > things are S only (UART, a bit of RAM, secure-only flash").
> >=20
> > I meant "secure-" as a prefix allowed on *any* property, not
> > "secure-status" specifically, which is the only thing QEMU uses
> > AFAICT. IOW, I don't think we should be creating secure-reg,
> > secure-interrupts, secure-clocks, etc.
>=20
> Reading secure.txt, what does it mean "device present and usable in
> the secure world" ?
>=20
> So:
>=20
> status =3D "disabled"
> secure-status =3D "okay"
>=20
> basically means that the device in question allows secure-only MMIO
> access, is that what it says ?
>=20
> If that's the case and we really want to have all config frames
> in a single DT, would it be reasonable to have an IRS/ITS DT node
> per-frame ?
>=20
> Then yes, the secure- tag is not enough any longer (because we have to
> cope with 4 interrupt domains) but that's a separate problem - again,
> this would leave the current reviewed bindings unchanged.

No, this is the same problem, and we need a way to address it.
"secure-*" doesn't cut it in a system with FEAT_RME, where resources
are only available to a single Physical Address Space (PAS). So we
need a way to qualify these resources with a PAS.

Either that, or we have to restrict DT to describe the view of a
single PAS. Which Peter will understandably be unhappy about.

Thanks,

	M.

--=20
Jazz isn't dead. It just smells funny.

