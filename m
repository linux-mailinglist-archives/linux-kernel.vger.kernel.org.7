Return-Path: <linux-kernel+bounces-834051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4945FBA3AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E53B9631
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C12F657A;
	Fri, 26 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtiRVpp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EA72EFDA0;
	Fri, 26 Sep 2025 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891004; cv=none; b=As9IvGWbNLUX7vkUR+B+6Whuknpgx5Fveid9NSTIktH9SyAvDPGIGlfU4FHSQr0BINEzy3zan3SLR2uY9VXOQIuphiLiVRsX2I8cqlZdbZgA9A3i2O84R23MIUoYOIujZqG/Pw4pOZgyD5X43QWbPCRwUWQeslRFVl2JupP9hyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891004; c=relaxed/simple;
	bh=RjbujitdK2362M6VjoX/Vi8YOC6p64INvFgMaYUd2xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q2p5PbTn5VUQRKajTNMZzzqDq+IN7TDBZfPOHEdo92KE/ay2bHrwL8gLZvOH+ZINuMDU4Ut0lTLCK5tM3NNjuK8yexO6aXhIIQ9f7xSd81kIoZL3bW8RBf+VhEq1ZjHb4K+ZvzJif0GYZtYcQBkKu55q3ZiudYPnYwtSn82Hqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtiRVpp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E50C113D0;
	Fri, 26 Sep 2025 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891004;
	bh=RjbujitdK2362M6VjoX/Vi8YOC6p64INvFgMaYUd2xs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GtiRVpp8+6rbDjXFfkOn5AN/Xd0ioKPxPkuKYSjX3Jc9Pge9SN9La/nZFOsF8pwXp
	 vJEtNuPnyS/1OwX05KCo4kyFYKrbj4MoiOL9Vv8TFvVie4gcKquaGvnHfcVstzN2Va
	 KEdzbP0twM3evpa/c6MvfKXU0a7Hcw0ZZDfgHcTlAZdYFCb/xyCKVmIMfa1CwjeT4y
	 LARCY6nXWTCF01iR36vakzhx4ZlDnmfHsApHfwG0c7lcpxKOhpvSWC/vgNuoQICsLm
	 SZwx2f/8HEYhj9FWjUI2JjpJLmqBzp0ea1A9/o3CBVNE6wTBicwXu4bjs6qa3QGsHm
	 uCAiPLRhT6tQQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Primoz Fiser <primoz.fiser@norik.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 upstream@lists.phytec.de
In-Reply-To: <20250925085929.2581749-1-primoz.fiser@norik.com>
References: <20250925085929.2581749-1-primoz.fiser@norik.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix class-D initialization for
 tlv320aic3007
Message-Id: <175889100278.84679.9639895115405021343.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 13:50:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 25 Sep 2025 10:59:29 +0200, Primoz Fiser wrote:
> The problem of having class-D initialization sequence in probe using
> regmap_register_patch() is that it will do hardware register writes
> immediately after being called as it bypasses regcache. Afterwards, in
> aic3x_init() we also perform codec soft reset, rendering class-D init
> sequence pointless. This issue is even more apparent when using reset
> GPIO line, since in that case class-D amplifier initialization fails
> with "Failed to init class D: -5" message as codec is already held in
> reset state after requesting the reset GPIO and hence hardware I/O
> fails with -EIO errno.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic3x: Fix class-D initialization for tlv320aic3007
      commit: 733a763dd8b3ac2858dd238a91bb3a2fdff4739e

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


