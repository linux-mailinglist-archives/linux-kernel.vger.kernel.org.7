Return-Path: <linux-kernel+bounces-859079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B73BEC9F8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CB33AB75D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEA13B58B;
	Sat, 18 Oct 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Lsweb7i7"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9E1339A4;
	Sat, 18 Oct 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760776256; cv=none; b=mFBS3lQpue8Mr1oFaGwuxrMJxCJ6IRNCvzP9/jG/gJd7uTtI3GC9uoXTl5BHES+g50IXy8zQIEnHuvwUAEKwbiNYE8+CZMoAoEPzjA0udjIWIsHwDINI17BTfAfutS8IiR7ZV4QD8LCROyF/2vWjUAmAPaTTfSryqMbHp6tc5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760776256; c=relaxed/simple;
	bh=/GxHKkDcX3OtbRqvDjE7OOd2cfHlsiNuQUMdtpyp/IM=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=OjNPJc0XpR5gXKPPmrBK626SnxS2f3TuMYXitnkQUVVwhgoZ/8NAn4tWpGuNTqvM2uE2zrNn5y9FSnxapGapleSbq2SNJq+nbO6YndVpxN17r6KFQ2Ju69ww4sKsbvG8wk7Wm0BMBA+nVCo8h58KOad+nUOtObV2Hi/T5bDWmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Lsweb7i7; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 7EEC340A58;
	Sat, 18 Oct 2025 10:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760776250; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LHQnif9iYqp+76sOJB03i8X7khKjqjSmR//p2dfPzlE=;
	b=Lsweb7i7JsRok6u3gjJiFlqLb20Rnj0oiNxcsMlQd4j6VCOkFRc3aySSOXbhO68IVhef4j
	+oZEvSXbsoQtu5f1MSuUnIkCuobtnHHzTeOIaVbAShO5wU5Y7sRY/u4fbSL4ometXUXZja
	MKYho3Jjh2UcyCsBRV0wVacC2tghSR5ak+kyHKM260CaFf61sZl/G6/pJWmZ52DyYq7zsS
	ZEi4N03bkyauJrQTevbG7V1G6LPMMdwWHmtr+wSkYzU3pVfSOyw3DRw3z8gphoIYDJEpor
	b3w0vvGM6jAmHnzw9O84RWwx/Quq3jeEYeP0lj8EvKFmKNZr4dZ6Zc7vm0H3bQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com> <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org> <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
Date: Sat, 18 Oct 2025 10:30:49 +0200
Cc: "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Jimmy Hon" <honyuenkwun@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Jimmy,

On Saturday, October 18, 2025 02:42 CEST, Jimmy Hon <honyuenkwun@gmail.=
com> wrote:
> On Fri, Oct 17, 2025 at 10:15=E2=80=AFAM Dragan Simic <dsimic@manjaro=
.org> wrote:
> > On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail=
.com> wrote:
> > > On 2025/10/17 18:25, Dragan Simic wrote:
> > > > On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@g=
mail.com> wrote:
> > > >> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > > >>
> > > >> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O er=
rors and
> > > >> corruption when using HS400 mode. Downgrade to HS200 mode to e=
nsure
> > > >> stable operation.
> > > >
> > > > Could you, please, provide more details about the troublesome e=
MMC
> > > > chip that gets identified as A3A444, i.e. what's the actual bra=
nd
> > > > and model?  Maybe you could send a picture of it?  It might als=
o
> > > > help if you'd send the contents of "/sys/class/block/mmcblkX/de=
vice
> > > > /manfid" from your board (where "X" should equal two).
> > >
> > > Unfortunately I don't have this board nor this eMMC chip.
> > > I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A4=
4,
> > > manfid is 0x0000d6.
> >
> > Thanks for responding and providing the details so quickly!
> >
> > > > I'm asking for that because I'd like to research it a bit furth=
er,
> > > > if possible, because some other eMMC chips that are also found =
on
> > > > the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be t=
hat
> > > > the A3A444 chip has some issues with the HS400 mode on its own,
> > > > i.e. the observed issues may not be caused by the board.
> > >
> > > Yes, it should be caused by this eMMC chip.
> >
> > I'd suggest that we move forward by "quirking off" the HS400 mode
> > for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> > downgrading the speed of the sdhci interface on the NanoPC-T6.
> >
> > That way, the other similar Foresee eMMC chip that's also found
> > on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> > the faster HS400 mode, while the troublesome A3A44 variant will
> > be downgraded to the HS200 globally for everyone's benefit.  It's
> > quite unlikely that the A3A44 variant fails to work reliable in
> > HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> > drivers should be a sane and safe choice.
> >
> > If you agree with dropping this patch, I'll be more than happy
> > to implement this HS200 quirk in the MMC drivers.
> >
> > As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> > eMMC Support List v1.84, [2] but the evidence says the opposite,
> > so we should react appropriately by adding this quirk.
>=20
> When adding the quirk for the A3A44, can we lower the max frequency
> and keep the HS400 mode instead?
> That's what the Fedora folks found works [3]. There's more test
> results in Armbian [4]

Are there any I/O performance tests that would prove that lowering
the HS400 frequency to 150 MHz ends up working significantly faster
than dropping the eMMC chip to HS200 mode?

I'm asking that because lowering the frequency looks much more like
there's some issue with the board, rather than the issue being the
eMMC chip's support for HS400 mode.  Thus, a quirk that would lower
the HS400 mode frequency would likely be frowned upon and rejected,
while a quirk that puts the chip into HS200 mode is much cleaner
and has much higher chances to be accepted.

With all that in mind, if the resulting I/O performance difference
between 150 MHz HS400 and HS200 is within 15-20% or so, I'd highly
recommend that we still go with the HS200 quirk.  It also leaves
us with a nice safety margin, which is always good to have when
such hardware instability issues are worked around in software,
unless detailed eye diagrams, protocol dumps and whatnot can be
pulled and analyzed, in which case the resulting safety margin
can be much slimmer.

Ideally, we'd have a completely different board with the same
Foresee FEMDNN256G-A3A44 eMMC chip to test how reliably its HS400
mode works there, to see is it really up to this eMMC chip or up
to the board design, but I'm afraid we don't have that (easily)
available, so the only remaining option is to work with what's
actually available, which inevitably leads to a certain amount
of guesswork and some compromises.

> > [1] https://github.com/openwrt/openwrt/issues/18844
> > [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84=5F202=
40815.pdf
> [3] https://lists.fedoraproject.org/archives/list/kernel@lists.fedora=
project.org/thread/MCSDYDQVOXS5AZMKA7LLY4QX7JXBWPCA/
> [4] https://github.com/armbian/build/pull/8736#issuecomment-338776053=
6


