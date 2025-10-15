Return-Path: <linux-kernel+bounces-854224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAFBDDDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679083BEAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD1531B133;
	Wed, 15 Oct 2025 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECyxHhE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2831AF21;
	Wed, 15 Oct 2025 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521791; cv=none; b=GAPHTNFewb1XFaMh5tDr1Asmy5Xj7NmE/ApS5z+jqvzI3ovsAYNtOzz8sR45XrSgmH/ZcqXUsdohvN5pc0eQJRq6Fv+N4fvLTso+syBFkLjIBgRCHXw07s7fKghLhTd8WtmcLDmTlRCUG1svJVM2xgDGA/oySQep1UUdup1QZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521791; c=relaxed/simple;
	bh=NJZvW+JYKZcvHAok/gYBcGxTybf9PkX3/50tqo3ey38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wl+wesZSwpAVSkuxCXS6QrIx6MPeFEcu2xKmYPAqIc+4RnpwW7xVoTwpXNBZHzxa2Fajr6Wm9uZl5dsJ/VYwK7fV8moEJuP3gSCIQxNbGObk2MZzvSF+WugPo7ST8TtADahvXmuvqxwnRAC+3V+GN0QMjH76RoGUMBL5rmLeyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECyxHhE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C451C4CEF8;
	Wed, 15 Oct 2025 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521791;
	bh=NJZvW+JYKZcvHAok/gYBcGxTybf9PkX3/50tqo3ey38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ECyxHhE2CgnU38zjNUREyLuuvYEny0b2nr81cS0njxwtyESpV/L2UBdbpXrIZQc2U
	 VRIfjrqMS2wcoXDRsM0Sjf9hXWxLGNpn265UNQYd3b/qVScb79TndN+3dJ8iD8ndjQ
	 8m2HKsaKjAWy9wKmj9w6LndxIePCUkP68jAb/xVdnBRa74zhlsSTh50ccHuG5dHUDd
	 4+0emSWU/aVqPQxP+0rBaKxys17Dwlljx9+/al9l8iBPCxEO3pWXfSjj2dU0KbSpAj
	 +w+07O0iajTCTdtkCiGnmWLZ7K1yxVJv2OaWyI906gChGwuHeTKtxqiH4//FAcEpVL
	 pLgoAS+1q3OZA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Baojun Xu <baojun.xu@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, shenghao-ding@ti.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, k-yi@ti.com, 
 henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com, will-wang@ti.com, 
 jim.shil@goertek.com, toastcheng@google.com, chinkaiting@google.com
In-Reply-To: <20251002072925.26242-1-baojun.xu@ti.com>
References: <20251002072925.26242-1-baojun.xu@ti.com>
Subject: Re: [PATCH v4 1/2] ASoC: tas2781: Support more newly-released
 amplifiers tas58xx in the driver
Message-Id: <176052178677.20166.7273787337857943286.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Thu, 02 Oct 2025 15:29:24 +0800, Baojun Xu wrote:
> TAS5802/TAS5815/TAS5828 has on-chip DSP without current/voltage feedback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2781: Support more newly-released amplifiers tas58xx in the driver
      commit: 53a3c6e222836a23e8e0693395584aefc456dca6
[2/2] ASoC: tas2781: Update ti,tas2781.yaml for adding tas58xx
      commit: 7e6cfa3e94cf8278ee3170dc0b81fc6db1287e28

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


