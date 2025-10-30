Return-Path: <linux-kernel+bounces-878421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CC5C208C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21CBF34F222
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17995259CAF;
	Thu, 30 Oct 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEUB7J2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8B25784A;
	Thu, 30 Oct 2025 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834024; cv=none; b=la0QWnhAbygSj0Grs8SFVndgM1AQZS+ycSG7UQtuHPIaMtRGXjzwdNh0xYKE8kG49iSdUc8J/4npIMkG8X2PZ+cybVbf73He3pqTgRmpL01s1I9SFy/rx2BUM/WIQ5uEbnnJgot4gW7OMMp6XVeJnQ3OZT8UrkoPUN/rTLYw+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834024; c=relaxed/simple;
	bh=IOjpice0XflkTw5OxJ3W9Im5BDF5lTP8In6VcflTIf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ioPs5F72MLUUkldYS+EmAsDFVVzOR87lWrGFFHyoIaguojFEit8/har/sYCC/6N56gn9IB395oGISDxlSMMRs2R21tjvyRU1EHhOyDTjueFZRl8UPFtYwOJpWkhsCCSxZorJ60UEA8+mbupwPptetVzqoctefE7GnxTbuaz5Vtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEUB7J2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D34BC4CEF8;
	Thu, 30 Oct 2025 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834024;
	bh=IOjpice0XflkTw5OxJ3W9Im5BDF5lTP8In6VcflTIf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bEUB7J2WpYpsh0vERTwfbwbWUiQlNCuKnYmYOW94MwWPcnEC2gm25g0hazsVJfY1A
	 CrWmn2SjFcQD2tPMWfqR7Je3bl51jgNL2JWcSFPbq/7+gFBTyp7nqulJT1X1dfLpiG
	 xoJW9sXlEHnruHHPMKOZVXtGYex35Ncz3UfAu+xHO/vTjj4fKFZZFl2MeT6X0o8Zdu
	 aQ5MdaAwetMGeGYYUyrEzJ5Gw2wWR5nswmXLStH03K2KlCWFDsaiUOSfnsyqGN0Bz/
	 iljIAyJnHzwEjv1axZspsRvI8fXgTRi7KECUYLBiin+/KnqdDo+K2WAckPvvueB+rK
	 IlD+XMxMk+Rvw==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Maud Spierings <maudspierings@gocontroll.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
References: <20251030-mini_iv-v3-0-ef56c4d9f219@gocontroll.com>
Subject: Re: (subset) [PATCH v3 0/6] arm64: dts: freescale: add support for
 the GOcontroll Moduline IV/Mini
Message-Id: <176183402126.59922.4908449264520857093.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 14:20:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 30 Oct 2025 07:35:36 +0100, Maud Spierings wrote:
> Add initial support for the Moduline IV and Moduline Mini embedded
> controllers.
> 
> These systems are powered by the Ka-Ro Electronics tx8m-1610 COM, which
> features an imx8mm SoC.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/6] regulator: bd718x7: Fix voltages scaled by resistor divider
      commit: 47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


