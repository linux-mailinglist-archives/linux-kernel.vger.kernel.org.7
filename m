Return-Path: <linux-kernel+bounces-729817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8AB03BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E947C16F26C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDFC244661;
	Mon, 14 Jul 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2m5SbiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BF4315F;
	Mon, 14 Jul 2025 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489208; cv=none; b=tGAQJDNxjut0ne6J62KAmz4xhmbFGWHgPBRgJPTwPZvlDroIqtDl4Lsf3OD75hDxHQvdJOJ7udHCp1G00bbofIC55bqcMtXeJL8uQZkJ7D7MJZ8U6AZBIKISiyFgi68AkvOYl2rUll6/bwz9bVBfOQ+QRK9C4fS5HkgfC4sF4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489208; c=relaxed/simple;
	bh=OQ2p3jKcw1SpxIvbAkbta1vpmn8VNWiLX6J+OT6oeTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fGJJJN3GMTuTOVPT0rW7/ob5XqfoIFBpFMXzbJ9zySHmc9A8gL7E4ET7tAlGePCNRHQGlLRwGAexGz3beiUpi0+bIGkDx0Dp6WaViFWpVRE5AnE3jmu+ljkgBxs0GWx9Y6eX7r3703tzJlyJulSOCpfqMlFrqKUgLNqPGxphCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2m5SbiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF40CC4CEED;
	Mon, 14 Jul 2025 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489207;
	bh=OQ2p3jKcw1SpxIvbAkbta1vpmn8VNWiLX6J+OT6oeTA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u2m5SbiXivEIONcgn00WFCcw0ILKaP9ndbiF0t8+PLCZio8Pp7kzldgRz3p9+Qwih
	 p2cW0XK5+8F0GaFPg5sT7flfNU2DWsdEyxrmt/x01zzZCWOKa2EiW9sDhoJsYl32lY
	 4nkm6wJd88MWYgW2fQgzGiUyyulwsog+LUKsQvdhnjijviA4/vVBSJcprPR6l5RFy5
	 T0Kl5Ce1532TyAigXY85XlgSqp+qKZ0RGJ2hzXxecWT0D7JwmGWkbaUPI3WETIVbak
	 G1woLELxPGPwBP6000PR1rY6v/uM7RBRNVYiT1X8XD0aLZECWD2uLPJ7+EfqsUUETK
	 9AY4JquGH21xA==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Brent Lu <brent.lu@intel.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Jack Yu <jack.yu@realtek.com>, Helen Koike <koike@igalia.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250709145626.64125-1-arnd@kernel.org>
References: <20250709145626.64125-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix SND_SOC_SOF dependencies
Message-Id: <175248920349.18169.8570920446086956809.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 11:33:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 09 Jul 2025 16:56:07 +0200, Arnd Bergmann wrote:
> It is currently possible to configure a kernel with all Intel SoC
> configs as loadable modules, but the board config as built-in. This
> causes a link failure in the reference to the snd_soc_sof.ko module:
> 
> x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_hw_params':
> sof_rt5682.c:(.text+0x1f9): undefined reference to `sof_dai_get_mclk'
> x86_64-linux-ld: sof_rt5682.c:(.text+0x234): undefined reference to `sof_dai_get_bclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_rt5682.o: in function `sof_rt5682_codec_init':
> sof_rt5682.c:(.text+0x3e0): undefined reference to `sof_dai_get_mclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_cs42l42.o: in function `sof_cs42l42_hw_params':
> sof_cs42l42.c:(.text+0x2a): undefined reference to `sof_dai_get_bclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_nau8825.o: in function `sof_nau8825_hw_params':
> sof_nau8825.c:(.text+0x7f): undefined reference to `sof_dai_get_bclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_da7219.o: in function `da7219_codec_init':
> sof_da7219.c:(.text+0xbf): undefined reference to `sof_dai_get_mclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_maxim_common.o: in function `max_98373_hw_params':
> sof_maxim_common.c:(.text+0x6f9): undefined reference to `sof_dai_get_tdm_slots'
> x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1015_hw_params':
> sof_realtek_common.c:(.text+0x54c): undefined reference to `sof_dai_get_bclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_realtek_common.o: in function `rt1308_hw_params':
> sof_realtek_common.c:(.text+0x702): undefined reference to `sof_dai_get_mclk'
> x86_64-linux-ld: sound/soc/intel/boards/sof_cirrus_common.o: in function `cs35l41_hw_params':
> sof_cirrus_common.c:(.text+0x2f): undefined reference to `sof_dai_get_bclk'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: fix SND_SOC_SOF dependencies
      commit: e837b59f8b411b5baf5e3de7a5aea10b1c545a63

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


