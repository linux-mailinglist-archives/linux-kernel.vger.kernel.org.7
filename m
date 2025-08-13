Return-Path: <linux-kernel+bounces-767417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F27B253FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40F67ADFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EF82F99B8;
	Wed, 13 Aug 2025 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giytaB1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135842F999C;
	Wed, 13 Aug 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113692; cv=none; b=TrbBqFbDRV0WkN4/2tqXnpvqN5po+JS/x29007OFp4aPc5JZOXzuwDp5mbiTPdXoNbQh3ZicU2ii2qgfT1mAxcHylFR7VTok+jSZNEOcUVpzc0TaFoOwvi8pC9Hm5ZMmBI+PGH4I8Kxpqb8dv5d+JmbM5vB3LmwfBcaTEmTOG3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113692; c=relaxed/simple;
	bh=Oa/mn1bIvlYCCZjy/9e9Ga8TzPTrAjMEY3+qdBPpnMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c96IY5jJ+k/zbPoG868rjvy5N+uk9WIcXMq67OdxlFRBfvvqvxRN5m5rgEGu39QdT5KQCYGAGZfnTp+nlP4Zru3hL3c5Xw28cAXXBhfjXnIMJdIapRzW/F9os6FUKbMBNUrDJjiAu0ikA7awZq6HxT2AR9gyhXPITHQjU5lyKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giytaB1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132ACC4CEEB;
	Wed, 13 Aug 2025 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755113691;
	bh=Oa/mn1bIvlYCCZjy/9e9Ga8TzPTrAjMEY3+qdBPpnMA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=giytaB1Twi28I0MYrwISILn40Uh/YaH0AH9XaUa2d9BpaocwWypjcDoP1qQTMQJaR
	 K8U3d0bB25f8hpzDR6sqHW38Qo7Ja/YtrY3XO/w1ZrAjaeF2zsfw34uCJ1ZEdcBznS
	 wOV8VqLZh+8C6HAp6BaylYdvyKuX74tE/HcHylr88YM4OjCR6BdzUKoLvbymBs/c5S
	 ycnrMi9NUrIJ8+9smUwFw2ZaRchWU+XXiKC44ZVj3JVZRh264mCIXX9zYWZTIuJQIx
	 Hn8l2BKWDeMd23ypOXc9RA4Ugp8ctbpS8RO2XoXKr5aObb4a70RqQSr9AeN6JiKmkR
	 nuUO8UEh43I0w==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Baojun Xu <baojun.xu@ti.com>
Cc: andriy.shevchenko@linux.intel.com, alsa-devel@alsa-project.org, 
 shenghao-ding@ti.com, 13916275206@139.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250730053236.57643-1-baojun.xu@ti.com>
References: <20250730053236.57643-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Normalize the volume kcontrol name
Message-Id: <175511368980.254480.12270174451313958597.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 20:34:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 30 Jul 2025 13:32:36 +0800, Baojun Xu wrote:
> As more devices become supported, add "tas2781" as a suffix before the
> TLV name, correct the DVC step, and normalize the volume kcontrol name.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Normalize the volume kcontrol name
      commit: 47ed64db8c17eb16541098add865178fb7e68744

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


