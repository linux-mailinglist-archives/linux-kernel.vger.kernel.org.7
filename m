Return-Path: <linux-kernel+bounces-808277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D849B4FD75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE65441DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DFE342CB0;
	Tue,  9 Sep 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olO9ywJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD1342C91;
	Tue,  9 Sep 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424850; cv=none; b=VYtWXNvFryDKmvzkFjnhAQwZVQUIFvsfJLeogqw/bCgiAG6Czc7OT17eqanUOA5JMAqCjE4pIh9tROzHqm2mOOzirqC20aL6fnjUYwflxm1DITWf6zGqb3wapiC3O6XHkJ/wXvd7re76P/mZsQ2Hbpi7uNMW9p7ZdkprDz89mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424850; c=relaxed/simple;
	bh=uDWe5i323HRkm1ttJ/vmDkJ/q2zljilys34SereqCRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LM58vxJxCZsUNftKY1M939V/o3rm6Nef8HmVbhgGJStyCK2p1WY25s7C2i4T8gp7RphF5eE52LmMdEitt4sdJyWnaZ5Lc+T3D2tjsMhuEeajPq7F56KNTEPWvBcVdCPEUOIPnqwRpraYN5Vu9+iRXIyY6RQZMtp8r6RMWZn1zNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olO9ywJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350AAC4CEF4;
	Tue,  9 Sep 2025 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424849;
	bh=uDWe5i323HRkm1ttJ/vmDkJ/q2zljilys34SereqCRs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=olO9ywJGFDBKFMTZaxoqfg70ObRIDdTVWze2NHxc25zyL9zp6NSxt4IslxEy8akZH
	 SEEIO01nvfNttmmTC6eRSdVD3vstBVWIxjsSeMzM/v+wGNgOvyuIKLC6v6bt8Qtw4v
	 AxGcNU0dhksVjqcvJ/YOTHcP9XLZQ74A0QcUSZB6rVEqL2aTH6c5enwCJSnmbfd6Px
	 itNRE8LUb8j3PO0nqty5tvdWrrhL5J6sVIig3iS48YBMl+iz5KIYR5gHmSx7HxLBAL
	 9HgbG7SPl5kP3B3kzDuApasXFsRHiXs4LwO1refUNAgZaYjlaze+ET/RuOSWsUe8HJ
	 hYSOuwGCgsXYA==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andreas Kemnade <akemnade@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
Subject: Re: (subset) [PATCH 0/4] regulator: sy7636a: define and init all
 resources needed
Message-Id: <175742484696.195386.11497376161041416392.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 14:34:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-94e36

On Sat, 06 Sep 2025 11:09:11 +0200, Andreas Kemnade wrote:
> The SY7636A has some pins which can be hardwired or used to have more
> more advanced power management available. As several devices containing
> this regulator have these pins not hardwired, but instead connected to some
> GPIO, enhance the driver to have them defined and initialized.
> Also add the ability to power off the chip completely by defining some
> input power supply.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/4] regulator: sy7636a: fix lifecycle of power good gpio
      commit: c05d0b32eebadc8be6e53196e99c64cf2bed1d99

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


