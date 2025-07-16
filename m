Return-Path: <linux-kernel+bounces-733905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21063B07A73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87098189B165
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A52F5326;
	Wed, 16 Jul 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV+FeyVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A92F530F;
	Wed, 16 Jul 2025 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681414; cv=none; b=DhfE4GWNasq6vs/6bkU6FF0/tz0jetr05nBHAigqr6sHvZYdY2tW87SJHq85WssszTsnjrsjx5IPSKZo1zyd5WvaQ1lw9IsjPsRRNfMY+V/nLC5ROryzqT5mXL84r6iysC/H/mfZymMTS658kkaNEP10rI1kHEx9DemNewuRfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681414; c=relaxed/simple;
	bh=ZbPIlnCHb3kljSiCjkbaqr4lhfzIekyU+AVe5oNS84s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VRsEGT6ChqbXMvmr+XWPvCJsp3LU4IfagQnytmvQES5zPF31rFJl0dPIL4nBGUN0EVZ1KmtDV4w56QKginUwUe1JzT1agggDaRs5MRZf4JTZmh2OSVOSpQ2lt8oX+cmlXeHm6EmG6tcIxodbBq7rGxJbMOnqkmPsSRp9ddripkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV+FeyVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19FFC4CEF0;
	Wed, 16 Jul 2025 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752681414;
	bh=ZbPIlnCHb3kljSiCjkbaqr4lhfzIekyU+AVe5oNS84s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eV+FeyVg5v2RXXrTPxEhCRsQy2aNMDhlg05iYatMKzjziP5TYcYJ1wL2ZEtcTr8ds
	 Ht3gAMG7j3woFJgXo5dwdxgms+R6fbMVOVhMQ/8vOAd2MYaUrak2Qy0FOfEh7FcFBn
	 UB5gpDKyXrIpK4wu/yOKapqvKGVn5cd9hSffnvVpKAcKxfWTyaPrM+Km0xKV2YX9Nf
	 gA6XJ6xpWiu8Wpsk6tpAlGTqGVKCuKwBCIvEW2FNhCZrdb8FO0VtG/DJfmXHhjYfbi
	 hq3Z/us+aUzbAEvWc86aqPd0UDtnzc5F/ws/MJ6SWCWpXpL1VIzKpvXRKG2uaE0EXC
	 49Uc7nhucFmtA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250716065708.4041153-1-alexander.stein@ew.tq-group.com>
References: <20250716065708.4041153-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
Message-Id: <175268141172.726552.8180184869044144609.b4-ty@kernel.org>
Date: Wed, 16 Jul 2025 16:56:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 16 Jul 2025 08:57:07 +0200, Alexander Stein wrote:
> rstn_gpio being a GPIO descriptor the check is wrong (inverted) for
> releasing the reset of the codec.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
      commit: 8778837f0a5b7c1bc5dbf0cccd7619fec6981588

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


