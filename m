Return-Path: <linux-kernel+bounces-709761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D8AEE1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7221894C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109E28E59C;
	Mon, 30 Jun 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLuyFsCG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA128DF2F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295964; cv=none; b=gsLqFCQdN0J4VotZuxdNT9TUz3bZJAhUgi/LLjjKvvjFu6Lesz/3ib6pN2Yqx2/M/bs4gBBScIPKJso/NrDZKkTcsZkfQ+Ll5ZYOMAlBwbv+fikaxGR/m2Z63liejGkW5PZujtWJmw9609JM2WEb3dQLS+nO4qUfciNM8igiKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295964; c=relaxed/simple;
	bh=DM7Cen+VO3hjT0Ng92CaFAhg5MInumdpt+vk5L9DKuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=guYa+GtUNoCL5hQ7L27HhZzmCVy2ymoQYskpsxo2dvWFISsYv7FpuZb20fSjaRyO2ig41AuG0avrNiXAUXsPHenTB1GT8NerOQN+1z+xbagJqhypYaqC9U2GPKDEhfweeQ0nZc/0qc2uXU7i5XQwO/dfmmqvbmfcYSNsCY1RQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLuyFsCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44B2C4CEE3;
	Mon, 30 Jun 2025 15:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751295963;
	bh=DM7Cen+VO3hjT0Ng92CaFAhg5MInumdpt+vk5L9DKuw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CLuyFsCGsJpC+2yMaFWljBRZkLj2/znrQXAGlNVY00mEGckEEqJBAtWg9zr1tkQWi
	 gvEk7krho9u6f4DWf+CNpgvS/joS/J6vN9/aQ/G7pmNLtuNpIg11qmX4R5WT4ypdgs
	 Grwys0MvuNs9Dwhy14vwERdEjVd1pTJgEcg9TTx3vjQq4KhZ9xB2m3mnyfTGxpFOc/
	 gHxTayMPam1o+s6mMk/quSwagwZ7DoIs187/Y2+zm39WRxhAgT0fqvPFTN9bTUHMkC
	 QeN7E565dlOHc5NYcdGYzLSFX3Jkd7K+JC9NomsBaLaU4bHSnCs2NlP8R0MhkXwjpV
	 vvxbhd4ws00XQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250629095822.868-1-jszhang@kernel.org>
References: <20250629095822.868-1-jszhang@kernel.org>
Subject: Re: [PATCH] regulator: tps6287x-regulator: Enable REGCACHE_MAPLE
Message-Id: <175129596268.1422008.2958784825814323799.b4-ty@kernel.org>
Date: Mon, 30 Jun 2025 16:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 29 Jun 2025 17:58:22 +0800, Jisheng Zhang wrote:
> Enable regmap cache to reduce i2c transactions and corresponding
> interrupts if regulator is accessed frequently.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6287x-regulator: Enable REGCACHE_MAPLE
      commit: b402dfe84057e376b39c8adadeb65ad51aaffeb4

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


