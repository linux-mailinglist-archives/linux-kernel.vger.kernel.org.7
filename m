Return-Path: <linux-kernel+bounces-881280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B51C27E56
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F74C400C73
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2659288C34;
	Sat,  1 Nov 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bzkZ44vf"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42E34D397;
	Sat,  1 Nov 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001475; cv=none; b=c/L0KSqQ7+m96D2PTEI8GFbY3l5UozV0vUrchC1GeKca7vvlXPzQqFW/GWA4PoT7WWQN7lIrrbDFft2cwmYbgxwvS1awysWhRfEnSmo6H2Mu1cHU6NUPM98rFrjpqO64+J+r7sA5Bf2detAdbpiHMp3g21BXVahGwQeoAsoqlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001475; c=relaxed/simple;
	bh=exBJA7nbMEZeZZpabcc2P8rsMbPKLfh9sPnBN8lg9J8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=UjCvNTJwNECMVEiPiKodA9KoFBsMgk3uLopTdZaj6Wg6WteC6Vv3P/nvMz3lY5sGTIqxyHk0STQXpqhXPLO/+cyOOx84czuG4RiXpjPN1iOwiWWr1aoAcRTs+2KyHhDMEovrMTTF6003YZnVuOeN36hiLYbwzLRdWzUIAw1NyDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bzkZ44vf; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id CBA4340E0A;
	Sat,  1 Nov 2025 13:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1762001463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fQvbdhiXZZph0YAYJiNdm8OJtzwwngVKL/B8nmm12Vc=;
	b=bzkZ44vfgDZOcAzzR08beda9GaadarJtptSNqvAwy8aIv4HWsvMPJ2+iZS/50wypTQTy7g
	dNeURtHLT34G9vAf6hfv7SShnBj8ghs//nLo74Cojy+jm/gqQw3fWIACg+7caq5tPVhLbD
	w7yLteKmYySaEdjZeHK58xpNH4WUX6aMQUqAr6ueN0efIfjSiwMWkZVQzAdlftiynd5/hx
	uALokfjnoBno9fktxvRo+cSv/lY6xL831ktF5Dt6rbtaTCl5hKaaN5eVQvJBcAMzu2vrL9
	4Yk1UFSJq4jovHfYGj78G3rOS+BQ5+1on/cmmcnIJOmIMcaSuAIy/dCr2LATEw==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <10751338.nUPlyArG6x@phil>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com>
 <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
 <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com> <10751338.nUPlyArG6x@phil>
Date: Sat, 01 Nov 2025 13:50:59 +0100
Cc: "Shawn Lin" <shawn.lin@rock-chips.com>, "Tianling Shen" <cnsztl@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, "Jianfeng Liu" <liujianfeng1994@gmail.com>
To: "Heiko Stuebner" <heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e52de2b5-bf10-ce0e-66b7-66b1c46525f3@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Heiko,

On Saturday, November 01, 2025 12:54 CET, Heiko Stuebner <heiko@sntech.=
de> wrote:
> Am Montag, 27. Oktober 2025, 18:34:25 Mitteleurop=C3=A4ische Normalze=
it schrieb Tianling Shen:
> > On 2025/10/20 12:44, Tianling Shen wrote:
> > > On 2025/10/20 9:53, Shawn Lin wrote:
> > >> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
> > >>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > >>>
> > >>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O err=
ors and
> > >>> corruption when using HS400 mode. Downgrade to HS200 mode to en=
sure
> > >>> stable operation.
> > >>
> > >> May I ask you to test another patch I just posted to see if it f=
ixes
> > >> your issue?
> > >>
> > >> https://patchwork.kernel.org/project/linux-mmc/=20
> > >> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.co=
m/
> > >=20
> > > Thank you for the patch! I will ask my friend to test it but he u=
ses=20
> > > this board as a home router, so it may take a few days or weeks t=
o=20
> > > report the result.
> >=20
> > Hi all, sorry for the late. My friend has tested this patch and it =
works=20
> > fine after 50 times dd operation. A big thanks to Shawn!
>=20
> So I guess, we don't need the patch reducing the speed anymore, right=
?

Exactly, the approach of lowering the speed of eMMC to improve
its reliability is no longer needed, thanks to Shawn correcting
the DLL=5FSTRBIN=5FTAPNUM=5FDEFAULT value in the above-linked patch.

We just need to test does HS400 work on the ROCK 5 ITX reliably
as well, so the previous lowering to HS200 in commit b36402e4a077
("arm64: dts: rockchip: slow down emmc freq for rock 5 itx", 2025-
02-28) could be reverted as no longer needed.

> > And hi Jianfeng, I found you made a similiar patch[1] for the ROCK =
5 ITX=20
> > board to lower down the mmc speed, could you please check if this p=
atch=20
> > also fixes your issue?
> >=20
> > [1] https://lore.kernel.org/linux-rockchip/20250228143341.70244-1-l=
iujianfeng1994@gmail.com/
> >=20
> > >>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> > >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> > >>> ---
> > >>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
> > >>>   1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi=
 b/=20
> > >>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > >>> index fafeabe9adf9..5f63f38f7326 100644
> > >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> > >>> @@ -717,8 +717,7 @@ &sdhci {
> > >>>       no-sd;
> > >>>       non-removable;
> > >>>       max-frequency =3D <200000000>;
> > >>> -    mmc-hs400-1=5F8v;
> > >>> -    mmc-hs400-enhanced-strobe;
> > >>> +    mmc-hs200-1=5F8v;
> > >>>       status =3D "okay";
> > >>>   };


