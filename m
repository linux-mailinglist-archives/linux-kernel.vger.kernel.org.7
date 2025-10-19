Return-Path: <linux-kernel+bounces-859828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A4BEEB2C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 20:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042C53E3CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244672E2F14;
	Sun, 19 Oct 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="VtVGybfY"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553315B971;
	Sun, 19 Oct 2025 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760897413; cv=none; b=g5t1nuK6pDjsTNzDXowNa4a/avYAeokkYP7NojA3pFdfRr0ADBWQ/sY9jy591v88OFl8Qa1w25X5t5+dLmj3oRj4CVO3d5IAzwB6HkMsa0CXq4rjZSF9KRkTdv9E0V5twUeBpWxYKC+9EnMOMryFUBVM9ufc0Ri1Rsk/TEQMAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760897413; c=relaxed/simple;
	bh=WjTcD2YR8AGyqKpV036AzUTE8zrH4rstRTSX0VAYPh8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=A3KgmF/8SJemtSQYT03dLXakXnEZoqsazKZnZfHVyYU4+9EbDLv6p/JZzwrhXddsII3TUb3R05xojhsCTm7QHrnbH9lDdcWdeS8qC5GmMvlKNbamDLbRSkoEwP1qcZTGZgcTNfSMRuzwDKp5JxR1SG7qeVK2V5uiiiPjp9Z6e6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=VtVGybfY; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 4684640A58;
	Sun, 19 Oct 2025 20:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760897402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ERRtoG7bB418wgjyE9jDggkfu2QPAbzjTsBuPu44/cA=;
	b=VtVGybfY5fuB19L+2yb0xkzW1Ddf2ptzniOmXG98nENyurifzlZGRSMOGmOBOcD6SteVZG
	gm7eoN3oiKzyiLIAkrNryM5s2iWKpuLNQoglrmoT2jDE3sx/FNRfXAYU5KckAwevx3G6yR
	pRwplGe3bcp2d30R2QOBIMLcPhVpVTD6dRvS7g9FwvR8DdYSz4+8zv6uhEVCuIhXgs/wS4
	7Kv7iUfw1vhNO7JAfMFvGA0P96U4e2CYvpFNtG0wGCIINxoEkr5/b0bkLn6vSaqzBY/Hkq
	h4Ki5L4PC6QnTmnQiLacZoiWxsBwXAj+I5uroQrE9LvEVAkLx9NggaFoIDIP5w==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <CANAwSgTZa7PXBuyh9EdDOXCNuCTOHGsJz18pSjP6WUN8sOaqTQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com> <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
 <d9d14ce2-2e65-422e-95fb-eb30b128ad90@gmail.com> <41154cde-a447-0707-4387-cd3dca90b97d@manjaro.org>
 <CALWfF7K0=J3E-zr41wV-28+SCFkT_so55Aee8BvQsB4KJZy6YQ@mail.gmail.com>
 <47931e9e-09db-3909-4531-dae6869171d7@manjaro.org> <b22425c3-01e0-4d2e-bf78-5db884d4ec38@gmail.com>
 <de5e8643-49bb-4e0e-45fd-51b25ecf530d@manjaro.org> <CANAwSgTZa7PXBuyh9EdDOXCNuCTOHGsJz18pSjP6WUN8sOaqTQ@mail.gmail.com>
Date: Sun, 19 Oct 2025 20:09:59 +0200
Cc: "Hugh Cole-Baker" <sigmaris@gmail.com>, "Jimmy Hon" <honyuenkwun@gmail.com>, "Tianling Shen" <cnsztl@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Anand Moon" <linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <047fe2b8-0f94-0f0f-5964-b65844834706@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Anand,

On Sunday, October 19, 2025 19:25 CEST, Anand Moon <linux.amoon@gmail.c=
om> wrote:
> Would you consider the following patch?
>=20
> As per the Rockchip RK3588S SoC Technical Reference Manual (TRM) Part=
 1,
> chapter 21.6, Interface Description, the eMMC signals require careful=
 handling
> to ensure signal integrity.
>=20
> I2C2=5FSCL=5FM2 I/O EMMC=5FRSTN/I2C2=5FSCL=5FM2/UART5=5FRTSN=5FM1/GPI=
O2=5FA3=5Fd
> BUS=5FIOC=5FGPIO2A=5FIOMUX=5FSEL=5FL[15:12]=3D0x9
> I2C2=5FSDA=5FM2 I/O EMMC=5FDATA=5FSTROBE/I2C2=5FSDA=5FM2/UART5=5FCTSN=
=5FM1/GPIO2=5FA2=5Fd
> BUS=5FIOC=5FGPIO2A=5FIOMUX=5FSEL=5FL[11:8]=3D0x9
>=20
> $ git diff .
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> index 6584d73660f6..f60a1d8be0ef 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-base-pinctrl.dtsi
> @@ -327,7 +327,7 @@ emmc {
>                 emmc=5Frstnout: emmc-rstnout {
>                         rockchip,pins =3D
>                                 /* emmc=5Frstn */
> -                               <2 RK=5FPA3 1 &pcfg=5Fpull=5Fnone>;
> +                               <2 RK=5FPA3 1 &pcfg=5Fpull=5Fdown=5Fd=
rv=5Flevel=5F2>;
>                 };
>=20
>                 /omit-if-no-ref/
> @@ -369,7 +369,7 @@ emmc=5Fcmd: emmc-cmd {
>                 emmc=5Fdata=5Fstrobe: emmc-data-strobe {
>                         rockchip,pins =3D
>                                 /* emmc=5Fdata=5Fstrobe */
> -                               <2 RK=5FPA2 1 &pcfg=5Fpull=5Fdown>;
> +                               <2 RK=5FPA2 1 &pcfg=5Fpull=5Fdown=5Fd=
rv=5Flevel=5F2>;
>                 };
>         };

Frankly, I'm not really sure how would such changes do something
good regarding the eMMC signal integrity?  In general, signal
integrity depends mostly on the routing of the PCB traces, which
is purely hardware design.  Sure, termination of data lines also
plays a significant role, but that surely isn't at play here.

Moreover, the eMMC RSTn line is already pulled high to VCCIO in
the reference RK3588 design, so pulling it down in the SoC itself
would be pretty much wrong thing to do.


