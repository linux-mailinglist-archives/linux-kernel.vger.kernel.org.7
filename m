Return-Path: <linux-kernel+bounces-826364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDA2B8E525
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB473BE5D3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785828CF52;
	Sun, 21 Sep 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB96mFzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6A2206A7;
	Sun, 21 Sep 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486257; cv=none; b=pZHO+LIhF4vgxn1WcarUZlVujMdelaQGSl63eDS4lQEcJpl1f4jQ+S7hXv9M/3/nB7PK7ayjLeFQcDFoSzLC5wo/pllbYwfkUwOqYVn42mgiGT+olPqMFusscUMsH0B/FmrV6BLcHAKi5LKhcxLt6jmQCMKz9/wcsoOmA397IQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486257; c=relaxed/simple;
	bh=n42wuk3fRc2TVRisCoqEGhMVO97pJsliEokdZLTtgUI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Ga8dT1m/ha08I+UDrSKac6Q+pWgV4aKCwwuTbvjffYgxJuXu/PuyCNSUZYSejJPaTEvdabWkRoGtX6NvEJVML4572MzStRJ9ZM3WX45YZO1NwzOCUf3cZ+l4UDyiejfSwsUDEMPra/omr+RJ49wEPTYdwym9pt5DMv5ROgErahQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB96mFzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C15AC4CEE7;
	Sun, 21 Sep 2025 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486255;
	bh=n42wuk3fRc2TVRisCoqEGhMVO97pJsliEokdZLTtgUI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=SB96mFzFx1fA+tB5zsjOGmulcvPZ3f7kLIWRwJnPolR+dmBSkVTB37P4bwjml4/nd
	 GpGxSGxIrQoc0zJspuRDGi1+nOkBCXBJ9OG2Wj5SEEH96IrVwfBLeK0s1JDsFStHZr
	 t29ixiUlz/bp0kXVHRFalJVH1bVUSadLBjGCZ2BiWgz/PKsO4MWzevGATRrkUTyWip
	 UFMtEDdNvF8H1BbBNuJfBQPV4AH+eO1JvSWsZRxkpqK6ePAp+H+L9fNCp/mVsQAMYO
	 vmR008DqDTaAZ9wEqa2dOCESo8minO4EvGE7wMKHbjdROq/7AcSXCCWOr6t8mC6m3K
	 Gcp+MH9nKtdpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-2-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-2-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 1/3] dt-bindings: clock: ast2700: modify soc0/1 clock define
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:24:13 -0700
Message-ID: <175848625348.4354.12803484068611642489@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:37)
> -add SOC0_CLK_AHBMUX:
> add SOC0_CLK_AHBMUX for ahb clock source divide.
> mpll->
>       ahb_mux -> div_table -> clk_ahb
> hpll->
>=20
> -new add clock:
>  SOC0_CLK_MPHYSRC: UFS MPHY clock source.
>  SOC0_CLK_U2PHY_REFCLKSRC: USB2.0 phy clock reference source.
>  SOC1_CLK_I3C: I3C clock source.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

