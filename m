Return-Path: <linux-kernel+bounces-810866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AC1B520DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A731E1C807B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B32D6E4A;
	Wed, 10 Sep 2025 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Zg95o4qd"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22692D46A9;
	Wed, 10 Sep 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532088; cv=none; b=Gf5Rx7JMG0exKuebi3dE6IbkZXtAdHYx8fuCzMeTUMby5GGe+IGIleU4jmezU9et1Oh500IyWJRKdb+etnqg/g20RBmmZB5kvyNW21DNBGkhOdoVh4XoNWu42caR++emLGCUnA0MlqR7V0yT7HQO58Q191+K9VaTrGlblaSMh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532088; c=relaxed/simple;
	bh=n0xFBIOnBhEtYm96QIlAYZ1gCC1TVIO7etk/8VacZrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1TucaX2E7Xy/WL9uw29sC9UFpOG9RytaEnzZtdtbyCMtnvbrdjY8EruHmnWQAGw0ngmjIHcRGPv7A4QpmsctEqdKoEYHj0CglFKdMg+OZ6KaOQKQvhLf72xG7eGck1tR7sU/daxEiemYVoFgyvgo/9y61aheMDw+8mrmnmY12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Zg95o4qd; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=uhFI9oI1xsX/5VketVeksgJo6o20zmCCJbkUrT20l+4=; b=Zg95o4qdhQ3n5T72uj5V2eaTxd
	VbPPVM1DcFUw4tMgnKoPHVlb0k+AZnZmGRS51s0Wnh5SGPnQo5N8OZKxcMeK+ggYYA55asJBryyPA
	LMTUVzjI7nOygkIJM6AHGAnADS8cbzoUK8SgKF3g6PM41ibsclMNJiFouUQaScYlVIou8iadwnEaB
	oysIgeMbqjDsnStF/iIe/B/zaVxOeBi6O3YjSTAWHZhBck6On3L4zUooO0wUCUrMR5nG5ht9Yv7lE
	orCYm7q2L5QFLHmHJhlOieOS4GXp3ZoMAlUvsVYhWL6nX7JOv0/fk3meEy9Ybv5hfsOy3kGawWqgL
	ojyrPRKw==;
Received: from i53875b8a.versanet.de ([83.135.91.138] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwQNM-0003mh-8i; Wed, 10 Sep 2025 21:21:04 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Collabora Kernel Team <kernel@collabora.com>,
 Michael Riesch <michael.riesch@collabora.com>, Vinod Koul <vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, stable@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: (subset) [PATCH v4 0/7] phy: rockchip: phy-rockchip-inno-csidphy: add
 support for rk3588 variant
Date: Wed, 10 Sep 2025 21:21:03 +0200
Message-ID: <2070639.PIDvDuAF1L@diego>
In-Reply-To: <175752285211.484319.18097786132863236205.b4-ty@kernel.org>
References:
 <20250616-rk3588-csi-dphy-v4-0-a4f340a7f0cf@collabora.com>
 <175752285211.484319.18097786132863236205.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Vinod,

Am Mittwoch, 10. September 2025, 18:47:32 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Vinod Koul:
>=20
> On Wed, 03 Sep 2025 19:04:48 +0200, Michael Riesch wrote:
> > Habidere,
> >=20
> > The Rockchip RK3588 features two MIPI CSI-2 DPHYs (not to be confused w=
ith
> > the two combo MIPI DSI/CSI CPHY/DPHY blocks). The CSI-2 DPHYs can be
> > supported using the existing phy-rockchip-inno-csidphy driver, the nota=
ble
> > differences being
> >  - the control bits in the GRF
> >  - the additional reset line
> > This patch series adds support for this variant.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make power-domains non-re=
quired
>       commit: c254815b02673cc77a84103c4c0d6197bd90c0ef
> [3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add rk3588 variant
>       commit: 5072b8e98eef4685a5a9a8bae56072cb65a2ef69
> [4/7] phy: rockchip: phy-rockchip-inno-csidphy: allow writes to grf regis=
ter 0
>       commit: 8c7c19466c854fa86b82d2148eaa9bf0e6531423
> [5/7] phy: rockchip: phy-rockchip-inno-csidphy: allow for different reset=
 lines
>       commit: 260435153c90c8e90553e456ec43578834a14a71

question, what happened to patch 6?
  [PATCH v4 6/7] phy: rockchip: phy-rockchip-inno-csidphy: add support for =
rk3588 variant

or is it just missing from this mail?

Thanks
Heiko



