Return-Path: <linux-kernel+bounces-863045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82626BF6DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C1318A2070
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA60733892A;
	Tue, 21 Oct 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Mlh89lu7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233126E6F4;
	Tue, 21 Oct 2025 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054442; cv=none; b=t+idbib8/yLYzWmjQpdQbUvJFYpOKHYPNub0nsJ6+P1Ko01eblb8c0+APikhCWuSzVtOe4PSbbPFvoamxuvYgEhBeCLLvA2Z7uCt61aqPhxGGRChmp0yNh/AEGeqiWUREWwAOZ/l/1hrSqFc+0X3lqyhxAZ19mlrs62187Qi3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054442; c=relaxed/simple;
	bh=neT4o96+sfJPtM07jwlTFJkt0YWT2tPvX9k+nMmP5RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1KP6tNwOZTvs/2dbcZF0RxHhCuPQtjzHSMFscVxJiOM+qzQi11k/WcnQ/OoIZqhRY4oINf5wiA3MfpcqcQSSEnGWDSkE4wAXsZlPf9GBAEXBkJbiJwiLei1kayBD/J3DmYXbTDp7CLr+BelvAzemmPcQNBOBLdf+WdP4foireA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Mlh89lu7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=aok4Q7VCeJwiry1qOMn1QTGAWgJx8h8keP6SSm7tHlQ=; b=Mlh89lu7wtQLx4mdH9MuwJQYFv
	XjIltf3atCUoXi+p5e7lCcYpM4UyPbUFJm+8eFFY+UGuhKQeQyluZp0Rp4Gf4KwNQsQVqVsmdQKY+
	QfyOik/etf8+aeNaxMM/M03AgFlf+oK63yjolN12SLXGnWrPaev6B6BdbNe2fOhTph+snLAMKMkhY
	tcRNX0V96K6d+lekXsAm4R1AqXuq0oeJ40GsiSjyl8xqwkVAVmp1V1ul5J5fikDlL9QxhJDmoJg67
	DL6D3FDSRj9khpecMAgByuCCTkYyfhzqrDg4gHSGMBAQLBa3rTWPA0cNDLF1L2DZ2nEzDHOmZ2UG1
	ltdW8tjw==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBChk-0003Zt-HY; Tue, 21 Oct 2025 15:47:12 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 zhangqing@rock-chips.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com
Subject: Re: [PATCH v4 5/7] clk: rockchip: add support for pvtpll clk
Date: Tue, 21 Oct 2025 15:47:11 +0200
Message-ID: <13871591.dW097sEU6C@phil>
In-Reply-To: <20251021065232.2201500-6-zhangqing@rock-chips.com>
References:
 <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-6-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 21. Oktober 2025, 08:52:30 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Elaine Zhang:
> Support to adjust pvtpll by volt-sel and otp.
> Support calibrate pvtpll init frequency.
>=20
> PVTPLL is used to monitor the chip performance variance caused by chip
> process, voltage and temperature, and generate a set of reference signals
> for adjusting the voltage of the chip.
>=20
> PVTPLL supports the following features:
>=20
> 1. A clock oscillation ring is integrated and used to generate a clock
> like signal (osc_clk),the frequency of this clock is determined
> by the cell delay value of clock oscillation ring circuit
>=20
> 2. A frequency counter(osc_cnt) is used to measure the frequency of osc_c=
lk.
>=20
> 3. A externally input clock (ref_clk) is used as a reference clock for
> detecting the frequency of osc_clk.
>=20
> 4. A calculation counter uses ref_clk to generate a configurable
> periodic timing window.
>=20
> 5. Two clock counters are used to measure the frequency of the clock
> generated by OSC_WRAPPER?
>=20
> 6. Support for dividing the ref_clk and osc_clk
>=20
> 7. Support for configuring the effective polarity of the voltage
> regulator signal 'OUT'
>=20
> The clock path of cpu used pvtpll:
>=20
>     --gpll--|--\
>             |   \                                 | \
>             |    \                                |  \
>             |     \                               |   \
>    --v0pll--| mux |--[gate]--[div]--clk_core_src--|mux |--clk_core
>             |     /                               |   /
>             |    /   --ref_clk--[div]-cpu_pvtpll--|  /
>    --v1pll--|   /                                 | /
>             |--/
>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

[...]

> +	pvtpll->regmap_cru =3D syscon_regmap_lookup_by_phandle_optional(np, "ro=
ckchip,cru");

Not convinced about that :-) .

(1) the cru itself already ioremaps the CRU memory, so having a syscon
    there would ioremap that memory a second time.
(2) we should definitly not expose the whole CRU io-memory to other
    drivers to write "random" stuff to. This will just invited further
    hacks, where people want to take shortcuts with clock settings.

Also this seems highly specific to the rv1126b.

Looking at the registers, this is a clk-mux between that deepslow clock
and the actual pvtpll output and the config function really only
reparents to the pvtpll in all cases.

So I believe this should in the worst case just be mux clock, but also
I see that the "correct" setting will already be set by the

        /* pvtpll src init */
        writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_CORECLKSEL=
_CON(0));
        writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_NPUCLKSEL_=
CON(0));
        writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VICLKSEL_C=
ON(0));
        writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VEPUCLKSEL=
_CON(0));
        writel_relaxed(PVTPLL_SRC_SEL_PVTPLL, reg_base + RV1126B_VCPCLKSEL_=
CON(0));

in the rv1126b clock driver?

So that whole mode setting should not be necessary at all maybe?

Thanks
Heiko



