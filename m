Return-Path: <linux-kernel+bounces-859222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA6BED0CD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304B319C4599
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325328727B;
	Sat, 18 Oct 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="q+ShW8gb"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9D1BC3F;
	Sat, 18 Oct 2025 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795861; cv=none; b=NXTM09PZUhH5pnJwgs+xvKDa8pMdqs6vAa4iauhC13JiqQ1wd+dTxv5MSU9UV05GEOuTOy0UV0+hp6buEXCLwpBh+V4YVBgnFnzYxflP4cVC9eCpuI6C1eC+8eqmY8S7qmmuFqJ/W83uIER+HB4grdd1EkGN5iaxg5SB+mijgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795861; c=relaxed/simple;
	bh=+PsrH7NEsfuNdrzjcmyWOTRXzpeDJUVdrs97M5RgAZQ=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=tcFYgD/NeMSPWJVZLX0Foh7BkBrmK7PFZ4Ss5H/lqGTu3Z/0o4Ys4Wq7lPh5U8LZ/KzHiig0veuOHQ4J3dlsA6e5lTHdsYvuSp5Syap1Xwkp+sgTLVw8loeBgx/IZ7iAM3vmPiAVVWyj4/LHlg5v41Iw0NquaeNxm2y7zdN+NAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=q+ShW8gb; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 0CBA540A58;
	Sat, 18 Oct 2025 15:57:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760795846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+8Vwrx25FHbbCKskadf35mdBQsNbpuT/QB9T+nEdcx0=;
	b=q+ShW8gbZfu5gfnVK8jFNRS8vnV4Z7AKmeulUm+muBQ29LVoue8E0iN1sxtYiLq7xHn2ui
	2pCS/jVkmcPr1+r642wSQHsBhVUo6wbdkNoD4Axfl/8xP8hmz/aAaW/v+pojVA2q/WoH5y
	Mqoekiyt0ziBJEVcY6On8YPMalEeBqTdvvsl+weeZJgwbe1d3wiTvQrBvuZBJWctZs5SNZ
	QcQ9hiwm15K9fRBjTTkSD7e+irY7ILOJfeXHIlFqNJw4oMZ7q/kSywch6SCx3LZ67h8Ink
	Ga45s9NcNrLeSnQWJOr+Qs5wWZX5ztf6Y/ovekJSfNco5RNWRb/kAYBKxcADLA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com>
 <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
 <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
 <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org> <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
Date: Sat, 18 Oct 2025 15:57:24 +0200
Cc: "Jimmy Hon" <honyuenkwun@gmail.com>, "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Hugh Cole-Baker" <sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <de5e8643-49bb-4e0e-45fd-51b25ecf530d@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Hugh,

On Saturday, October 18, 2025 14:14 CEST, Hugh Cole-Baker <sigmaris@gma=
il.com> wrote:
> On 18/10/2025 09:30, Dragan Simic wrote:
> > On Saturday, October 18, 2025 02:42 CEST, Jimmy Hon <honyuenkwun@gm=
ail.com> wrote:
> >> On Fri, Oct 17, 2025 at 10:15=E2=80=AFAM Dragan Simic <dsimic@manj=
aro.org> wrote:
> >>> On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gma=
il.com> wrote:
> >>>> On 2025/10/17 18:25, Dragan Simic wrote:
> >>>>> On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@g=
mail.com> wrote:
> >>>>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> >>>>>>
> >>>>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O er=
rors and
> >>>>>> corruption when using HS400 mode. Downgrade to HS200 mode to e=
nsure
> >>>>>> stable operation.
> >>>>>
> >>>>> Could you, please, provide more details about the troublesome e=
MMC
> >>>>> chip that gets identified as A3A444, i.e. what's the actual bra=
nd
> >>>>> and model?  Maybe you could send a picture of it?  It might als=
o
> >>>>> help if you'd send the contents of "/sys/class/block/mmcblkX/de=
vice
> >>>>> /manfid" from your board (where "X" should equal two).
> >>>>
> >>>> Unfortunately I don't have this board nor this eMMC chip.
> >>>> I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A=
44,
> >>>> manfid is 0x0000d6.
> >>>
> >>> Thanks for responding and providing the details so quickly!
> >>>
> >>>>> I'm asking for that because I'd like to research it a bit furth=
er,
> >>>>> if possible, because some other eMMC chips that are also found =
on
> >>>>> the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be t=
hat
> >>>>> the A3A444 chip has some issues with the HS400 mode on its own,
> >>>>> i.e. the observed issues may not be caused by the board.
> >>>>
> >>>> Yes, it should be caused by this eMMC chip.
> >>>
> >>> I'd suggest that we move forward by "quirking off" the HS400 mode
> >>> for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> >>> downgrading the speed of the sdhci interface on the NanoPC-T6.
> >>>
> >>> That way, the other similar Foresee eMMC chip that's also found
> >>> on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> >>> the faster HS400 mode, while the troublesome A3A44 variant will
> >>> be downgraded to the HS200 globally for everyone's benefit.  It's
> >>> quite unlikely that the A3A44 variant fails to work reliable in
> >>> HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> >>> drivers should be a sane and safe choice.
> >>>
> >>> If you agree with dropping this patch, I'll be more than happy
> >>> to implement this HS200 quirk in the MMC drivers.
> >>>
> >>> As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> >>> eMMC Support List v1.84, [2] but the evidence says the opposite,
> >>> so we should react appropriately by adding this quirk.
> >>
> >> When adding the quirk for the A3A44, can we lower the max frequenc=
y
> >> and keep the HS400 mode instead?
> >> That's what the Fedora folks found works [3]. There's more test
> >> results in Armbian [4]
> >=20
> > Are there any I/O performance tests that would prove that lowering
> > the HS400 frequency to 150 MHz ends up working significantly faster
> > than dropping the eMMC chip to HS200 mode?
> >=20
> > I'm asking that because lowering the frequency looks much more like
> > there's some issue with the board, rather than the issue being the
> > eMMC chip's support for HS400 mode.  Thus, a quirk that would lower
> > the HS400 mode frequency would likely be frowned upon and rejected,
> > while a quirk that puts the chip into HS200 mode is much cleaner
> > and has much higher chances to be accepted.
>=20
> I also have the NanoPC-T6 with one of the A3A444 eMMCs which suffers
> from I/O errors in the default HS400 mode. These are its details in
> /sys/block/mmcblk0/device/:
> manfid: 0x0000d6
> oemid: 0x0103
> name: A3A444
> fwrev: 0x1100000000000000
> hwrev: 0x0
> rev: 0x8

Thanks for reporting the same issue with the same board and
increasing our sample size to two. :)

> I wasn't sure if I was just unlucky to get a faulty chip, but seeing
> this thread it seems like a wider issue. On my board, limiting it to
> HS200 mode gets rid of the I/O errors, and it seems that lowering
> the frequency to 150MHz also avoids I/O errors.
>=20
> I did a quick unscientific test with fio; HS400 Enhanced Strobe mode
> with a 150MHz clock gives slightly better performance than HS200:
>=20
> HS200 mode:
> read: IOPS=3D697, BW=3D43.6MiB/s
> write: IOPS=3D697, BW=3D43.6MiB/s
>=20
> HS400 mode with 150MHz clock:
> read: IOPS=3D805, BW=3D50.3MiB/s
> write: IOPS=3D799, BW=3D50.0MiB/s
>=20
> so from my perspective, limiting the frequency would be a better fix
> than disabling HS400 entirely.

Thanks for running these tests!  The measured difference in the
I/O performance is about 15%, which surely isn't insignificant,
but IMHO it makes the proposed lowering of the eMMC chip to HS200
mode fall into the "good safety margin" bracket that I described
earlier.  I think it's better to sacrifice those 15% to stay on
the, hopefully, rock-solid side.

I've been thinking more about the 150 MHz HS400 and HS200 quirks,
and I'm afraid I'm even more sure that the 150 MHz HS400 quirk
would be frowned upon and rejected.  See, it does make it look
like a board-level issue, requiring a board-level fix, instead of
being a chip-level issue, for which a quirk would be fine.  The
acceptably low difference in the measured performance levels just
solidifies such a viewpoint, I'm afraid.

> It could also be of interest that the clock used apparently can't
> provide an exact 200MHz, e.g. in HS200 mode:
>=20
> root@t6:~# cat /sys/kernel/debug/mmc0/ios
> clock:		200000000 Hz
> actual clock:	187500000 Hz
> vdd:		18 (3.0 ~ 3.1 V)
> bus mode:	2 (push-pull)
> chip select:	0 (don't care)
> power mode:	2 (on)
> bus width:	3 (8 bits)
> timing spec:	9 (mmc HS200)
> signal voltage:	1 (1.80 V)
> driver type:	0 (driver type B)

Thanks, that's also something to think about.

> > With all that in mind, if the resulting I/O performance difference
> > between 150 MHz HS400 and HS200 is within 15-20% or so, I'd highly
> > recommend that we still go with the HS200 quirk.  It also leaves
> > us with a nice safety margin, which is always good to have when
> > such hardware instability issues are worked around in software,
> > unless detailed eye diagrams, protocol dumps and whatnot can be
> > pulled and analyzed, in which case the resulting safety margin
> > can be much slimmer.
> >=20
> > Ideally, we'd have a completely different board with the same
> > Foresee FEMDNN256G-A3A44 eMMC chip to test how reliably its HS400
> > mode works there, to see is it really up to this eMMC chip or up
> > to the board design, but I'm afraid we don't have that (easily)
> > available, so the only remaining option is to work with what's
> > actually available, which inevitably leads to a certain amount
> > of guesswork and some compromises.
> >=20
> >>> [1] https://github.com/openwrt/openwrt/issues/18844
> >>> [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84=5F2=
0240815.pdf
> >> [3] https://lists.fedoraproject.org/archives/list/kernel@lists.fed=
oraproject.org/thread/MCSDYDQVOXS5AZMKA7LLY4QX7JXBWPCA/
> >> [4] https://github.com/armbian/build/pull/8736#issuecomment-338776=
0536


