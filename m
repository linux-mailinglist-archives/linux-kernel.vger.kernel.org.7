Return-Path: <linux-kernel+bounces-867538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD8BC02DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A432C3A475F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B634B404;
	Thu, 23 Oct 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obpievaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37962DCF6B;
	Thu, 23 Oct 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243078; cv=none; b=kOgLeBtK4Jh31rf3DAS7BTMBbhtGxbIXRcizVfO/ntJ5+zbjSzDgnz+S8WucLXzKkRhQs/bIsm8b9zWTBM7CBehSA8cJdFlA+lej8Eczy9QPz50hawgnWTZij6S986jYls7GXo1hnYmTNKTZELocbZnJ97b2295DlnulvAx+xkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243078; c=relaxed/simple;
	bh=Ljvetg2fVYvsV5S84YIrfw1dMOgbHyndFwdWVn8d3mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q4aJzDyl3lPogQPM6AVj1TSoC3ewkIW3+PSzFn7KJRttlffs7woznfHjfcEmopzDCD3a2FqyPoqdqlp7glljAJIX2PaUyNsNDb33++pSdKktWy7R/cz+wtPa+5V9EOfZuGIL+2cbN1UYEL4XsnWnE9X4BkooM/ljjO4LgLw6Z7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obpievaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB51C4CEE7;
	Thu, 23 Oct 2025 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761243078;
	bh=Ljvetg2fVYvsV5S84YIrfw1dMOgbHyndFwdWVn8d3mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=obpievaU9n+n1V7vQ0F6oazKXiv1ZS80TBKuAg5G6fn8YWggIqvAl5J3mjkKYS9za
	 49p+KwbKsH3BLuUa/TDT1xByGlhY5eBVebRdXYp2uzRk9e+gG3NmD6t/rHIybTBgdb
	 Trsgi/SIG/B8mC1ScDCAF7bVQsd6pYY39FMYC/RNI+GmjEjMGH1wsI4OKqW33NfM+c
	 KruUcBYQNbV0MTSSxc68D4+MqpEf0al/1alQML6wOkIqKDezPnmvjr3S+l7GnM0614
	 RiZb58kkY62ZvjThqqp4PuNBZnW1x38tH6Gqv4O1+SLiBNUfNffuodoH6Eey3cz5bT
	 gP5DsxskFxPMw==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20251023110824.1587-1-rf@opensource.cirrus.com>
References: <20251023110824.1587-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc_sdw_utils: add cs35l57 support
Message-Id: <176124307698.209591.15766121674653140106.b4-ty@kernel.org>
Date: Thu, 23 Oct 2025 19:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 12:08:24 +0100, Richard Fitzgerald wrote:
> cs35l57 uses the same codec driver as cs35l56.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc_sdw_utils: add cs35l57 support
      commit: 61eb4112a8fbed999e3906a6c35e0731cf688c43

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


