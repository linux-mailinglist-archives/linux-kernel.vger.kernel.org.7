Return-Path: <linux-kernel+bounces-830623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14096B9A251
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366731B25D17
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D52135D7;
	Wed, 24 Sep 2025 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY4aQ3NK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF742046BA;
	Wed, 24 Sep 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722664; cv=none; b=Mq2l/UttkGIvUYMnD0+9a0MxRTWV2hNam5vsVlWGpspIu40I/aszDoDC8nVIT8msXXrx/+c6M87P3RFY81DUmv4LAtZvBTg82qdHE848hoV0KOT/tmk70X8aIZ4Bfg/Qvnyn3m3igRv4PhSiORebNeagFofFuAq5IxbdQplAyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722664; c=relaxed/simple;
	bh=MrqkQHwev5x6az3m4ybvyO8LkDyIz2yKDFHci6LAHy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L8dvk/Mlkj6qOv3d1X+DYEKUxfMIOQt6ZMM/mOSqemD6SQpnsBT9/ttjC1NYf59pEveYquhAhVvyopN+4n29J9wYR/ZyKRM5OrPk0PRLKY+l53uGX7r+0Yq7qBhDUql8+R1xPDlpmthio3x909jdO5E5bU7PYuXo/sH1W45h2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY4aQ3NK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7807FC4CEF4;
	Wed, 24 Sep 2025 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758722663;
	bh=MrqkQHwev5x6az3m4ybvyO8LkDyIz2yKDFHci6LAHy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TY4aQ3NKygd2FhLj+XaVsYE/sA/HS0lUiNCIMyaZxYGIJv2/yw8BtKHYyK0AO4Lwv
	 nrKE+0jf1wGGVocEh2HJNqVrL+JzVINj3Y8dAslfp51jYzVEm0kk6NmySoR030iMoj
	 9SuRTZmlIuEwV9JiAN4qurceR9r8ERluiB46rkeGS+P2MxHWDq5ckc3I5pOeznNROB
	 n7tqApHLqDKmNAIig3vDCAEOO6F4djX+8KS+5m9Co1oAf6tsmE+ZX9tIRl0mkasbD1
	 JkI3ZlsMaT+IV8tvBH1DwNtoSMoSHJc8BbUGGAZyLoj01JCNlxPuFTNdllESKApyz1
	 cYHKnHuBTHuYg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Niranjan H Y <niranjan.hy@ti.com>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250923185006.213861-1-colin.i.king@gmail.com>
References: <20250923185006.213861-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoc: tas2783A: Fix spelling mistake
 "Perifpheral" -> "Peripheral"
Message-Id: <175872266014.1250098.134495773386634138.b4-ty@kernel.org>
Date: Wed, 24 Sep 2025 16:04:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 23 Sep 2025 19:50:06 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_dbg debug message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2783A: Fix spelling mistake "Perifpheral" -> "Peripheral"
      commit: 6be988660b474564c77cb6ff60776dafcd850a18

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


