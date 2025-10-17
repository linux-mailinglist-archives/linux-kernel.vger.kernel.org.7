Return-Path: <linux-kernel+bounces-857842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9EBE80CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA65E1B55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEF31064A;
	Fri, 17 Oct 2025 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kfZagfkT"
Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C362D543A;
	Fri, 17 Oct 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696720; cv=none; b=Hbvgczd9rZaIBP5Fx6U7Gk6OxuYrF8gb7Nn262qlbU1Rc1tLqLVZcSfZE63hVJDiiEMkAfCywmlQSfmzSPEZvJpnV0jfZCkufWGZJYj45FHUkQqxmRTOtCrnfBx8lXrGbCM283EKALH85pfgMEUX6eos8gcoHULggPhLrWOgSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696720; c=relaxed/simple;
	bh=fY+cv5uwh8Az52RkOUwO459fB78TCcBpERmTP6OcLE4=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=b1rWBaJcAsuPhZj362CXpa3AtJnV6FhQTeNffKf+lMWwE5Z/PIrztm11CurfoEv0IXZQPL3H0gQF4S8D6jVLATf6d5a/LpbQ5yJk+O8yPNSthxmfpZsFOWjvlBS7gB2ftHrRSu7B5yWep6erhLf5bclyZlEilTFtsotMu59z2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kfZagfkT; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id C31BB40AB5;
	Fri, 17 Oct 2025 12:25:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1760696710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WBX1XXPozKbB39+0x+/YaeCYQ4Nq3QF5+0oeXCbgTdE=;
	b=kfZagfkTEDuqNuedgWnadskCBrPVOaZ7tFLUl6BKfIDdggV7sfWW5Uw96w2Pk3j18SVw0u
	9CE7L+jqWc44830qtyPcJ3i0hCCUitBa1bWs3zY8oP0ZYs/TS6Z4kY4pI281t8u4QR/WYO
	BORe+kFr6OrFc8GZmyZO4ZfvnMsI7F9EZseLP4J7ol+eO9Wa5Pj3Pa8K0Ysg1yp9WgJ51v
	kAA9e2gaKKketA/KAt1NvEA59iEyKIr70mHhhoKeEtI9uBEiFwiNsX5lYVWVUIIE3AwL9X
	BwE+IXMlKiiWGpraekOKOc3pW77DREOtNDqjLQvsKykELoekEho+g9pZ8zZyUQ==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <20251017073954.130710-1-cnsztl@gmail.com>
Content-Type: text/plain; charset="utf-8"
References: <20251017073954.130710-1-cnsztl@gmail.com>
Date: Fri, 17 Oct 2025 12:25:07 +0200
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Grzegorz Sterniczuk" <grzegorz@sternicz.uk>, "Jonas Karlman" <jonas@kwiboo.se>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Tianling Shen" <cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f0b1747-87eb-0b0b-6fb0-304811a4be21@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= fix eMMC corruption on NanoPC-T6 with A3A444 chips
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Tianling,

On Friday, October 17, 2025 09:39 CEST, Tianling Shen <cnsztl@gmail.com=
> wrote:
> From: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
>=20
> Some NanoPC-T6 boards with A3A444 eMMC chips experience I/O errors an=
d
> corruption when using HS400 mode. Downgrade to HS200 mode to ensure
> stable operation.

Could you, please, provide more details about the troublesome eMMC
chip that gets identified as A3A444, i.e. what's the actual brand
and model?  Maybe you could send a picture of it?  It might also
help if you'd send the contents of "/sys/class/block/mmcblkX/device
/manfid" from your board (where "X" should equal two).

I'm asking for that because I'd like to research it a bit further,
if possible, because some other eMMC chips that are also found on
the NanoPc-T6 seem to work fine in HS400 mode. [1]  It may be that
the A3A444 chip has some issues with the HS400 mode on its own,
i.e. the observed issues may not be caused by the board.

[1] https://github.com/openwrt/openwrt/issues/18844

> Signed-off-by: Grzegorz Sterniczuk <grzegorz@sternicz.uk>
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arc=
h/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> index fafeabe9adf9..5f63f38f7326 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
> @@ -717,8 +717,7 @@ &sdhci {
>  	no-sd;
>  	non-removable;
>  	max-frequency =3D <200000000>;
> -	mmc-hs400-1=5F8v;
> -	mmc-hs400-enhanced-strobe;
> +	mmc-hs200-1=5F8v;
>  	status =3D "okay";
>  };


