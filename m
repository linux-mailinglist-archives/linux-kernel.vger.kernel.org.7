Return-Path: <linux-kernel+bounces-881249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EECC27D28
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59CC40161D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F622F60A3;
	Sat,  1 Nov 2025 11:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vBFn4pnk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91A22222A9;
	Sat,  1 Nov 2025 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761998054; cv=none; b=hHjwIbeXKZddmpUoHMTYUywGRWsV/1ntFxsbXIs1NYgqdD2pAvvxKa7xVKM8zr1xgK0uWp81ci6DN3zlGFWwR8mCxAbQwd8o95UMYGP6KpPULY7yGXxYoCtljV3yhXahgQezUwNIBmpAJdaRkWyOVv0TJZtxzOxuq8fakJeGhEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761998054; c=relaxed/simple;
	bh=WL+lAqdjRGUH6u0s2DbE/zU35W9MorOSZw5iCw0FEC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVo7hHpOcDiMeLntMD5C56rRhxNbLTH1IDDAyMa87BxU75psw7wGhJKpvTuhkbmjQGrXJyO0WygTaVceJRQu4YVOP833GlbZnzH6H3JWkC5ogLQrI/F5ZuhQ4cq1vqbcUbbDsSPZHwzQhT9By5ZKbWbboUio2JNrAUxrT0T5nlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vBFn4pnk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=2/+9Nrg/MBKOyjOA2O+fnXbPaDve8v5ZbqMCiqeCxKE=; b=vBFn4pnkphDuozK5iAz9y8k4E4
	l5Rk/WmLU/cMVmO4oTd5xthvniS2QfDBF5scMKSfVkaPyVEXrUevzYFw8mGUGcPSgdLB6m9vAw7lE
	3yYX1wd/CdVCYJlvwFqodjOgNkWhtfa1rC64UCZG+zqeLKhNZz9QbS7egZdf9ITJJnH/yEg4vVEJx
	1Q6tL++wkVXm5jAoAFl3vHxvhP4IVa/O/i0RCUGOZn4bG++Lw1f/LPUHbX6gU3S3OuA4tgB9gI4JS
	XGzKWfsPt+VkalK0ndUKpt5SZ5RRm22bLwmVaIcTb3cjXXDiY+WbgjuBhv8ZAk+qjzDGHKTmXGaM+
	xhCyyjwg==;
Received: from i53875b80.versanet.de ([83.135.91.128] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vFABL-0008PQ-Jz; Sat, 01 Nov 2025 12:54:07 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Shawn Lin <shawn.lin@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Grzegorz Sterniczuk <grzegorz@sternicz.uk>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: fix eMMC corruption on NanoPC-T6 with
 A3A444 chips
Date: Sat, 01 Nov 2025 12:54:06 +0100
Message-ID: <10751338.nUPlyArG6x@phil>
In-Reply-To: <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com>
References:
 <20251017073954.130710-1-cnsztl@gmail.com>
 <08911ae2-fef3-432d-a236-d820c9cb67ac@gmail.com>
 <5af928c4-4b6e-489c-ad39-26cef3dd7473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 27. Oktober 2025, 18:34:25 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Tianling Shen:
> + Jianfeng
>=20
> On 2025/10/20 12:44, Tianling Shen wrote:
> > Hi Shawn,
> >=20
> > On 2025/10/20 9:53, Shawn Lin wrote:
> >> Hi Tianling
> >>
> >> On 2025/10/17 Friday 15:39, Tianling Shen wrote:
> >>> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> >>>
> >>> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors and
> >>> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
> >>> stable operation.
> >>
> >> May I ask you to test another patch I just posted to see if it fixes
> >> your issue?
> >>
> >> https://patchwork.kernel.org/project/linux-mmc/=20
> >> patch/1760924981-52339-1- git-send-email-shawn.lin@rock-chips.com/
> >=20
> > Thank you for the patch! I will ask my friend to test it but he uses=20
> > this board as a home router, so it may take a few days or weeks to=20
> > report the result.
>=20
> Hi all, sorry for the late. My friend has tested this patch and it works=
=20
> fine after 50 times dd operation. A big thanks to Shawn!

So I guess, we don't need the patch reducing the speed anymore, right?


Thanks
Heiko


> And hi Jianfeng, I found you made a similiar patch[1] for the ROCK 5 ITX=
=20
> board to lower down the mmc speed, could you please check if this patch=20
> also fixes your issue?
>=20
> Thanks,
> Tianling.
>=20
> 1.=20
> https://lore.kernel.org/linux-rockchip/20250228143341.70244-1-liujianfeng=
1994@gmail.com/
>=20
> >=20
> > Thanks,
> > Tianling.
> >=20
> >>
> >>
> >>>
> >>> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>> ---
> >>>   arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
> >>>   1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/=20
> >>> arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>> index fafeabe9adf9..5f63f38f7326 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> >>> @@ -717,8 +717,7 @@ &sdhci {
> >>>       no-sd;
> >>>       non-removable;
> >>>       max-frequency =3D <200000000>;
> >>> -    mmc-hs400-1_8v;
> >>> -    mmc-hs400-enhanced-strobe;
> >>> +    mmc-hs200-1_8v;
> >>>       status =3D "okay";
> >>>   };
> >>
> >=20
>=20
>=20





