Return-Path: <linux-kernel+bounces-858483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A37BEAEC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB55A1B87
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469B62E9741;
	Fri, 17 Oct 2025 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Wzl0nzCc"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067842E0B5D;
	Fri, 17 Oct 2025 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719891; cv=none; b=hcLIYMwdJarlt940t7Q7V+8nLKmkOWrFzn2be0xwAbhFCW0JyfWmWE538i6M4dxHa8U412++IQ9Hiww7RhYCf2heLCfMb7gpy7V1kZqinDO7oAwbazfBFNmmtmlkpiH/QCl7zE8oigvoTuNlSSvW5MLY5oSxERJEYj7w1F0Kj1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719891; c=relaxed/simple;
	bh=HcpzYDt2ea6dpSeuD+MnYPRSiLhn/K8Ncg0zT3bUo/E=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=pXEToCFUP8ec3bz74sjDAvFsI6PX3lhVh/nUzEkv3NoN69MfBSYpHJqfFHVwgQnvyntit11VD+QY+hGkFWug84CXO+axUPPAdGqZj5TgIj124hPA36qxxvr6U2oxOlMz7N0S9gmfsoBksgcpBEM12qFgKnXyBdxlekMsLhs3hV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Wzl0nzCc; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 2307340C82;
	Fri, 17 Oct 2025 18:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760719886; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nB/bTyp49Nap72JujOJtUfZ+5tI4J6RsgjyYLx9LXUQ=;
	b=Wzl0nzCcLl/z4P0GOjFDpmbHR+6G+aVH0OHnBGhUbSkbjshfXgHfQ2IJjlIInaYLToXIMh
	m+59hBOgcFHl/K2XPn4JI4zAitywpCUlBYrIBNBvyKXPervqpM2iT9uVWuybNxrEFBuLfn
	c4KmV7iNkFd084C/gubL4FOT22AmJzrX+Uh5ttoY7d4ArowN+H18sj8m4PSMSso5+4r9fL
	RxnUAfoL9Q8tggxb4KghWSl8ZB+UEvC646hlSbKyvDa9hOW36CYClHoPnx5xBDL059DOEQ
	2G0st35FIsM/gGeNEn4o7dUhQSw5WpZ8y5af90/eSyB7BFAAsr/lIFH7rciKIA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <601cd8dc-afb5-4a67-af63-567814d755a4@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com>
 <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org> <601cd8dc-afb5-4a67-af63-567814d755a4@gmail.com>
Date: Fri, 17 Oct 2025 18:51:24 +0200
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Tianling Shen" <cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <22a424de-4963-0505-51ed-99bca47da619@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Friday, October 17, 2025 18:34 CEST, Tianling Shen <cnsztl@gmail.com=
> wrote:
> On 2025/10/17 23:15, Dragan Simic wrote:
> > On Friday, October 17, 2025 14:08 CEST, Tianling Shen <cnsztl@gmail=
.com> wrote:
> >> On 2025/10/17 18:25, Dragan Simic wrote:
> >>> On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gma=
il.com> wrote:
> >>>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> >>>>
> >>>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O erro=
rs and
> >>>> corruption when using HS400 mode. Downgrade to HS200 mode to ens=
ure
> >>>> stable operation.
> >>>
> >>> Could you, please, provide more details about the troublesome eMM=
C
> >>> chip that gets identified as A3A444, i.e. what's the actual brand
> >>> and model?  Maybe you could send a picture of it?  It might also
> >>> help if you'd send the contents of "/sys/class/block/mmcblkX/devi=
ce
> >>> /manfid" from your board (where "X" should equal two).
> >>
> >> Unfortunately I don't have this board nor this eMMC chip.
> >> I got the chip model from my friend, it's FORESEE FEMDNN256G-A3A44=
,
> >> manfid is 0x0000d6.
> >=20
> > Thanks for responding and providing the details so quickly!
> >=20
> >>> I'm asking for that because I'd like to research it a bit further=
,
> >>> if possible, because some other eMMC chips that are also found on
> >>> the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be tha=
t
> >>> the A3A444 chip has some issues with the HS400 mode on its own,
> >>> i.e. the observed issues may not be caused by the board.
> >>
> >> Yes, it should be caused by this eMMC chip.
> >=20
> > I'd suggest that we move forward by "quirking off" the HS400 mode
> > for the FEMDNN256G-A3A44 eMMC chip in the MMC drivers, instead of
> > downgrading the speed of the sdhci interface on the NanoPC-T6.
> >=20
> > That way, the other similar Foresee eMMC chip that's also found
> > on NanoPC-T6 boards, FEMDNN256G-A3A564, will continue to work in
> > the faster HS400 mode, while the troublesome A3A44 variant will
> > be downgraded to the HS200 globally for everyone's benefit.  It's
> > quite unlikely that the A3A44 variant fails to work reliable in
> > HS400 mode on the NanoPC-T6 only, so quirking it off in the MMC
> > drivers should be a sane and safe choice.
> >=20
> > If you agree with dropping this patch, I'll be more than happy
> > to implement this HS200 quirk in the MMC drivers.
>=20
> Yes for sure, thank you ;)
> The full cid is d6010341334134343411f63ea7208700.

Great, thanks!  I'll start working on the proposed MMC quirk patch
tomorrow or so, and I'll feel free to ask for some more observable
A3A44 chip variant data, if needed.

> > As a note, FEMDNN256G-A3A44 is found in the Rockchip Qualified
> > eMMC Support List v1.84, [2] but the evidence says the opposite,
> > so we should react appropriately by adding this quirk.
> >=20
> > [1] https://github.com/openwrt/openwrt/issues/18844
> > [2] https://dl.radxa.com/rock5/hw/RKeMMCSupportList%20Ver1.84=5F202=
40815.pdf
> >=20
> >>>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> >>>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>>> ---
> >>>>    arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
> >>>>    1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi =
b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>>> index fafeabe9adf9..5f63f38f7326 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>>> @@ -717,8 +717,7 @@ &sdhci {
> >>>>    	no-sd;
> >>>>    	non-removable;
> >>>>    	max-frequency =3D <200000000>;
> >>>> -	mmc-hs400-1=5F8v;
> >>>> -	mmc-hs400-enhanced-strobe;
> >>>> +	mmc-hs200-1=5F8v;
> >>>>    	status =3D "okay";
> >>>>    };


