Return-Path: <linux-kernel+bounces-825511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 259D0B8C017
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6981C01FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E82309B3;
	Sat, 20 Sep 2025 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSoZqo65"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C356B67E;
	Sat, 20 Sep 2025 05:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758347724; cv=none; b=OeVbp/59PJ15QyxX5DueQJ7C6WaQwkg8pTzNDUuA/3fkA9Sx8Zag3RDW3jr42lVoVKV59BxdpQ/QBKVvJwTHYO9fwnPeL+5l5x1d0IHTI/5Mng/MLq8zBd+cZkgVVvBQEyuNdOoZcJ5zKP+ccV2EbHnhyzNNIbFZtRfnMHiKRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758347724; c=relaxed/simple;
	bh=eSPIm+5TmCgbXgE5lwwUhgZEGgepcr9yXpb9e2Q4g6E=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=FXwDudxksNjbHwnAYkhzf8m+rnrO7mfV38W1+lrsDfJys+dSy6C2hpLsCpT8ilIQTpHGXHAQKnx+p551ewslr2ZnIKsVrHQV8wGQD8ifvun3a3kakXX1M36lLk6FDerKeePvAphO1G4Tlh/QutaVCIEUX+PBbj/PB+9AHp6302k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSoZqo65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786F2C4CEEB;
	Sat, 20 Sep 2025 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758347723;
	bh=eSPIm+5TmCgbXgE5lwwUhgZEGgepcr9yXpb9e2Q4g6E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WSoZqo65cjmrXgVPnoj1mtMjc/3rDP8Hdwl47hmKURXdhUoeIjESkGd2LTI1uwwwb
	 jSMqr1pKW8JYrdUezAypJvgqMG4McauCg7Wi1EPN1wojwsbp+LCMxtoku34ib7ejdA
	 aKj7JvTrvZ9hlpCaYUxa6Leh2RzjjXN/tVFivcytaj5n6JYUT0Adja1A9xta/fa2D0
	 wPr9iouqRCMtdtDwGpHyjG9Ke1jtdNISR+1vRVa7Q5Aqa6E7jWzjkBGz6XAPDuzUm8
	 Kts6ZN60mdxaxYOQhDWxnPAQ4+S4WfUnw7KD1jQOPtGb/vxCdu1H+vR5FuX9pW/fUk
	 ilJjZ85yqB6ag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250911-k1-clk-i2s-generation-v4-1-cba204a50d48@linux.spacemit.com>
References: <20250911-k1-clk-i2s-generation-v4-0-cba204a50d48@linux.spacemit.com> <20250911-k1-clk-i2s-generation-v4-1-cba204a50d48@linux.spacemit.com>
Subject: Re: [PATCH RESEND v4 1/3] dt-bindings: clock: spacemit: introduce i2s pre-clock to fix i2s clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Jinmei Wei <weijinmei@linux.spacemit.com>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alex Elder <elder@riscstar.com>, Conor Dooley <conor+dt@kernel.org>, Haylen Chu <heylenay@4d2.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Troy Mitchell <troy.mitchell@linux.spacemit.com>, Yixun Lan <dlan@gentoo.org>
Date: Fri, 19 Sep 2025 22:55:21 -0700
Message-ID: <175834772190.4354.14570183719489742202@lazor>
User-Agent: alot/0.11

Quoting Troy Mitchell (2025-09-10 20:34:03)
> Previously, the K1 clock driver did not include the parent clocks of
> the I2S sysclk.
>=20
> Introduce pre-clock to fix I2S clock.
>=20
> Otherwise, the I2S clock may not work as expected.
>=20
> This patch adds their definitions to allow proper registration
> in the driver and usage in the device tree.
>=20
> Fixes: 1b72c59db0add ("clk: spacemit: Add clock support for SpacemiT K1 S=
oC")
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---

Applied to clk-next

