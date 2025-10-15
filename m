Return-Path: <linux-kernel+bounces-854254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A191BDDECE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B741500238
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D831BC88;
	Wed, 15 Oct 2025 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m0ZZqw7Q"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91619319619;
	Wed, 15 Oct 2025 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523046; cv=none; b=bSN6qFI3idJIMGNF7/PeMDOS1ndTnUScZ4PIv0fHpIiS2bvwuND0O46DRwEJMAJAiaPFK/WM6bhADAt+ZZkaty1nIuh+IgOmfNBKoLdcl25l+CF2OOFO3INYXVgQMapMcU4VEMx5E076Lp/CSifMQHlMNRBndK1zdQd0mdCWVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523046; c=relaxed/simple;
	bh=nMwJtK338awejpYC3YveTpo3oENIWXP/gPoCITzCGGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlPJF8w7qs9mmikh/1vSbuAmobomsKG9YHnIBBQrri88vJ3zGK1qhKtU1nArfz5YHpihNMzUbamW7GJ2/U5s7NXxDDElnGckZXgQdlHT4AbPBWx6aa+GKtgx6kHUrAK26o0oA7iPsngrZwmiSZaJ/vY2ha4on7WAhMLV76TwooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m0ZZqw7Q; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=WziRWtAQDPOgqfcKKpsG/YJDdpUVFZowmRQABd+4UVY=; b=m0ZZqw7QOv1LxvPy6+OiudHA/o
	72d/SeDprr4jod1xW6uBoB5b7acxzePtVNTn+GrZkVkT0ZvJcsXUN9fci5HfTDGoEF8d5NbOpf1YR
	YQrh215wAqbtV1oHp8i5sH0nGbNrDEpqT3qPNXoZZJDWkF/uvHwG/yY85c1SGeiUkndx9lxkKey3T
	cKfZB+6OKPr79BJ4/gdZ1u0+1JLmBmYMgFHHPREiwjoE9k2icQKx2UaZHJ/RLW3k2N+qNTB32iPvc
	hZhCODQElGacGtgBAg0oxvJVTS41Aj+EEajYn40wLJOsOhlbjafPFl+8nZJv4kLnNz25mO2EUXs1U
	1Hmo3Qew==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v8ySo-0006Qp-Ej; Wed, 15 Oct 2025 12:10:34 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 zhangqing@rock-chips.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com
Subject:
 Re: [PATCH v1 1/5] clk: rockchip: Implement rockchip_clk_register_armclk_v2()
Date: Wed, 15 Oct 2025 12:10:33 +0200
Message-ID: <2271625.NgBsaNRSFp@diego>
In-Reply-To: <20251015091325.71333-2-zhangqing@rock-chips.com>
References:
 <20251015091325.71333-1-zhangqing@rock-chips.com>
 <20251015091325.71333-2-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Elaine,

Am Mittwoch, 15. Oktober 2025, 11:13:21 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Elaine Zhang:
> The clock path of CPU may be simplified as follows:
>=20
>     --gpll--|--\
>             |   \
>             |    \
>             |     \
>    --v0pll--| mux |--[gate]--[div]--clk_core--
>             |     /
>             |    /
>    --v1pll--|   /
>             |--/
>=20

when introducing new core concepts, please really try to explain the
concept and also in detail why the old code cannot fullfill the new
requirements.

=46rom what I gathered, the main difference is that on the bigger socs we
have one sort of dedicated PLL for each armclk (i.e. B0PLL, B1PLL, LPLL
on rk3588) with the other parents being used as an interim source while
we adjust the main one.

Here the rv1126b (and rk3506) don't have that, but instead can select
from a number of "equal-but-shared" PLL sources.

Is my reading correct here?


> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-cpu.c | 165 +++++++++++++++++++++++++++++++++
>  drivers/clk/rockchip/clk.c     |  24 +++++
>  drivers/clk/rockchip/clk.h     |  15 +++
>  3 files changed, 204 insertions(+)
>=20
> diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cp=
u.c
> index dcc9dcb597ae..a48628e5c095 100644
> --- a/drivers/clk/rockchip/clk-cpu.c
> +++ b/drivers/clk/rockchip/clk-cpu.c

[...]

> +struct clk *rockchip_clk_register_cpuclk_v2(const char *name,

can we please find a descriptive name instead of "_v2"

I guess if my reading above is correct something like "_multi_pll" or so
might be nice.


Thanks
Heiko



