Return-Path: <linux-kernel+bounces-856200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52677BE3758
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E521A62871
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB44C32E686;
	Thu, 16 Oct 2025 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEBZq8YB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E2332D7F6;
	Thu, 16 Oct 2025 12:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618523; cv=none; b=bMwnn9kL/BfE/SXZEYZ+c+/nEyw80jzhS3o9tVgmbK5jK+Vx2oaGFw/QEKiNsofbstBYR9gjUCE/ohG2xhHa4J5wHp7EuWozUJigqwlKPA6yglzCe2LDmPX3NDYf7PJmDnQ6d+klQjaDp610d56iXAwbkyGAjIOOIXWp9y2w/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618523; c=relaxed/simple;
	bh=Z4aehjljSbpZSl9H+Z3fnbGHiWGdBAMuCfju2SKXtHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RwRFcH+iKyll/Bey3BfMYtsqDNIRFX7lSVFDa5os4haVNOzEAnJzj+geXGou7NDk3DX7giSyDhlaYlyis843uCVP671+GW4HX1kU6CB5t6DaNWI0vUdnEm4FgwswBXjoZGp9hf5HkW5T3IurmWX19oDiGSEuMmKdikt7rx1qQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEBZq8YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1858FC4CEF1;
	Thu, 16 Oct 2025 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618522;
	bh=Z4aehjljSbpZSl9H+Z3fnbGHiWGdBAMuCfju2SKXtHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GEBZq8YB6PBGFEhwRXBGuQ+1J0+wnb29p64QFiTZiJSHkW7aiqm/yNXAyHrepSqsn
	 BRMHiUmwigYxHfZHEGAXpVPcKrLsEONb8DZl4Mz9MAaIch7/m0mq4V+y+AgIT1p+gF
	 RmjDOkcukVOdifcV7AfucxKWC906xaF8uH2DIyKXb+RMRC6WIB78ZsGrsmRmFexKq1
	 zxk5isPX56ia12KV7qNbVFkiXW56YprvFyyyxesStYFbKWnY4yqboo/nujyRWy3SDP
	 trdomttfphjpV6BFCrIS26pw6jFfvEvPepfxJJYD/AB58hMoZCVTjX9p/OWndRmCCI
	 oMFSRWpQzi0lg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Seven Lee <wtli@nuvoton.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
Subject: Re: [PATCH 0/5] ASoC: nau8821: Fix IRQ handling and improve jack
 detection on Steam Deck
Message-Id: <176061852083.55339.15309551722049699564.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 13:42:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Fri, 03 Oct 2025 21:03:22 +0300, Cristian Ciocaltea wrote:
> This patch series addresses a set of issues in the Nuvoton NAU88L21
> audio codec driver related to interrupt handling and jack hotplug
> detection reliability.
> 
> The changes focus on:
> 
> * Eliminating race conditions between jack insertion and ejection events
> * Ensuring interrupts are consistently and correctly cleared before
>   unmasking
> * Introducing a DMI-based quirk to bypass the jack debounce circuit on
>   Valve Steam Deck, improving detection accuracy under stress
> * Improving robustness of the IRQ handler by avoiding unnecessary
>   blocking operations
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: nau8821: Cancel jdet_work before handling jack ejection
      commit: 6e54919cb541fdf1063b16f3254c28d01bc9e5ff
[2/5] ASoC: nau8821: Generalize helper to clear IRQ status
      commit: 9273aa85b35cc02d0953a1ba3b7bd694e5a2c10e
[3/5] ASoC: nau8821: Consistently clear interrupts before unmasking
      commit: a698679fe8b0fec41d1fb9547a53127a85c1be92
[4/5] ASoC: nau8821: Add DMI quirk to bypass jack debounce circuit
      commit: 2b4eda7bf7d8a4e2f7575a98f55d8336dec0f302
[5/5] ASoC: nau8821: Avoid unnecessary blocking in IRQ handler
      commit: ee70bacef1c6050e4836409927294d744dbcfa72

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


