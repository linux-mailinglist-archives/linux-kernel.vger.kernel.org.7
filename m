Return-Path: <linux-kernel+bounces-786866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BDCB36D14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5CD583967
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4D260586;
	Tue, 26 Aug 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="D2XHvLjj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452F237165;
	Tue, 26 Aug 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220283; cv=none; b=K6vLivPQki8xxiRsKQyaQuz8Dp/v5B1feLXwiHEseXwqHUGepq/zy5/n7LvBM7yakYDXCvgK7dP48FaTMsVLwOkMEvWjU77U7T7xlJWWUyDPunsvmcybr3ZUmZ4zd6b2pUrVn2Y9b+p4uHyLDpUcfAccDQD/jVHVad4FM64ZhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220283; c=relaxed/simple;
	bh=aQA0CmFCT8tixLjVwmeK1GH7nsZwmFyUrLjk71BX4DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZtuCKbojBZsO8/MsuYm0JOBe/JmjY7cnYTWY8CwYQYRVTJc4vmfNx8kU/VwG6kxzhwKyT/fyGZhDQbo0FtJEfanaxq6pWnFxg2/vWGo5BZzRu8YfGvHwjwu02OfaR01miwEJTcJE5l92YWaHFlA0/aA1pyPXuc3nUd6SfUFtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=D2XHvLjj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=iTrfIIo2NpXSs0VUQcS4tLNwuwhXMeQFQWFcRoLCwVY=; b=D2XHvLjjqX3PhhxJH6SySYYqgB
	1O9/+hsF1mXfum+scpQEW7fkvGngUSNtC2AEmRJiYeC+WkkdQF/J7Ju63n5qKhNqHRtj/b16BGD5P
	7B0427PHgn6FBjyUm43hrKpg9xaPP5nj26FNASxX1bI8hG+SKRfprtXLUJ+SmytMLdUlYV/hmMCkX
	UfESNgDDTa/reqn3EDauXyxzV6Iv7xUqbKnzpfN9ol/OR7LyeciRfLzh3XUxhfLj9iOoWy6viAd5w
	G4jnOyHlSvK5YiNw3aoPPKr7bNmUtRzjauWPtBP+WEnF/zk1Y5+oFAb4dWB9SNoCiXJ1tRAPTErGt
	qvk0NCpQ==;
Received: from [213.244.170.152] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uqv7C-0000eD-0n; Tue, 26 Aug 2025 16:57:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Hsun Lai <i@chainsx.cn>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Fred Bloggs <f.blogs@napier.co.nz>,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for 100ASK DShanPi A1
Date: Tue, 26 Aug 2025 16:57:37 +0200
Message-ID: <12479023.CDJkKcVGEf@phil>
In-Reply-To: <175621649670.159455.15557432322730951360.robh@kernel.org>
References:
 <20250826030818.3485927-1-i@chainsx.cn>
 <175621649670.159455.15557432322730951360.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 26. August 2025, 15:56:43 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Rob Herring (Arm):
>=20
> On Tue, 26 Aug 2025 11:08:15 +0800, Hsun Lai wrote:
> > This series add support for 100ASK DShanPi A1.
> >=20
> > Info of device can be found at:
> > https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/
> >=20
> > Changes in v2:
> > - Delete the pwm include file (Chukun Pan, v1)
> > - Fix vcc3v3_pcie gpios (Chukun Pan, v1)
> > - Adjust the order of some nodes (Chukun Pan, v1)
> > - Fix sdmmc (Chukun Pan, v1)
> > - Add phy-supply for u2phy0_otg (Chukun Pan, v1)
> >=20
> > Changes in v1:
> > - Add support for 100ASK DShanPi A1
> >=20
> > Hsun Lai (2):
> >   dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
> >   arm64: dts: rockchip: add DTs for 100ASK DShanPi A1
> >=20
> >  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../dts/rockchip/rk3576-100ask-dshanpi-a1.dts | 838 ++++++++++++++++++
> >  3 files changed, 844 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-=
a1.dts
> >=20
> > --
> > 2.34.1
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/v6.17-rc1-22-g7d11b8c260ea (exact match)
>=20
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm64/boot/dts/rockchi=
p/' for 20250826030818.3485927-1-i@chainsx.cn:

both warnings are not the fault of this board addition, but instead
come from "unrelated" sources in the main rk3576 dtsi:


> arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: syscon@2603400=
0 (rockchip,rk3576-dcphy-grf): clocks: False schema does not allow [[21, 49=
2]]
> 	from schema $id: http://devicetree.org/schemas/soc/rockchip/grf.yaml#

I messed up and forgot to add the new syscon to the clocks-required list.
Will fix that shortly.


> arch/arm64/boot/dts/rockchip/rk3576-100ask-dshanpi-a1.dtb: /soc/dsi@27d80=
000: failed to match any schema with compatible: ['rockchip,rk3576-mipi-dsi=
2']

the rk3576 dsi compatible is in drm-misc-next [0], so should
hit linux-next shortly.


[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f05530bdaf42aa0=
e6bb4cde76ba6a081cf473d44



