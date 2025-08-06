Return-Path: <linux-kernel+bounces-757841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A751B1C74E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EB83A1499
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481128CF45;
	Wed,  6 Aug 2025 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLj44YtL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FC28C851;
	Wed,  6 Aug 2025 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489204; cv=none; b=N4SF8d/sLmj6TVJ4NpBKmdH38lY25QDWWi8SCSpeeEO7dzkP/2cizn3s53CPkxs8uNeZcWZ9crVLsw/+pTDTgN7qTepzfWoHY4Hecpc9ANvT1gy8CSaF5piaA6ROBh/5IEMfizL3MLuqtP4i0lQuWHWEaSUVXZd4bST2mmlw+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489204; c=relaxed/simple;
	bh=ulEKMQZnLJDVZefzd0iYEJorUHSvCWrtbRyZF7llS2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VRHnzC89AcdFdjJJw6u/hVmYoIEwnD80uJQjZ9q5F7SsU4Pf/qYk2+InYdMTsX3k6aJzqChgOGcZqn2KiLNLhYeZO+lXRveSIVumPsf+/cYsNeJfcxgZUzCfPPhwmNB4k9pbDADiCfDG0/JeQGXQMZK/d59z9t0Uwd0Lvh3siGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLj44YtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802FDC4CEE7;
	Wed,  6 Aug 2025 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754489204;
	bh=ulEKMQZnLJDVZefzd0iYEJorUHSvCWrtbRyZF7llS2A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NLj44YtL0KYege590nfwGCQGGeHfaDmRsRYVhCVI5Hqp884GG9bqiVxhsauAgYd8U
	 OqN5hU3jFcbft0OKxSFNUrneb68tSNfECL7FmUTJvjc/VxgRbeuGBLshmyKzDFtEK5
	 lkdODMf1l5uM/EqClc//Z41YPxIFY3tt44P924rtoOx/LEaLDONY2X3PHLSlldJNfi
	 X9mGqLkl4I0tbxvr+AzuM3VNSixCkecbfrtQsrbDT6D626tNocfCGaMyn/9Pi/55g0
	 Y646j75ZAcL8Qeh9xFdWwVteCME0TI4bnpiSYKcUQ/+/WIggdTadSz1taVYbDJtNY7
	 6T+PwOLysKuVw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250805160451.4004602-1-arnd@kernel.org>
References: <20250805160451.4004602-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda-sdw-bpt: fix
 SND_SOF_SOF_HDA_SDW_BPT dependencies
Message-Id: <175448920126.71792.1743072623238000933.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 15:06:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 18:04:25 +0200, Arnd Bergmann wrote:
> The hda-sdw-bpt code links against the soundwire driver, but that fails when
> trying to link from built-in code into loadable module:
> 
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_close_stream.isra.0':
> intel_ace2x.c:(.text+0x137a531): undefined reference to `hda_sdw_bpt_close'
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_send_async':
> intel_ace2x.c:(.text+0x137aa45): undefined reference to `hda_sdw_bpt_open'
> x86_64-linux-ld: intel_ace2x.c:(.text+0x137ab67): undefined reference to `hda_sdw_bpt_close'
> x86_64-linux-ld: intel_ace2x.c:(.text+0x137ac30): undefined reference to `hda_sdw_bpt_send_async'
> x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_wait':
> intel_ace2x.c:(.text+0x137aced): undefined reference to `hda_sdw_bpt_wait'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-sdw-bpt: fix SND_SOF_SOF_HDA_SDW_BPT dependencies
      commit: 614d416dd8aee2675fb591c598308a901a660db8

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


