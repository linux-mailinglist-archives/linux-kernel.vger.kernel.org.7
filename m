Return-Path: <linux-kernel+bounces-825176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0ECB8B2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F197566F48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E361280017;
	Fri, 19 Sep 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIa6FaXv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066334BA3C;
	Fri, 19 Sep 2025 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312795; cv=none; b=rJORfailHF2ZCacsgpGQeln3Oe81rscV0mwlru8FlJhWe2HnEdNH2+0zTpUliw1Dx/gOLOuC8d33nmoYdiplyxZG8Zk2rEXpUiAem4gtcGHij4h4kpmWum43HLR803lhJQ/V6jXAwzEqPK7fg4sHKkhCgZ/rjtIPNxeH+crtZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312795; c=relaxed/simple;
	bh=CeAm2YVYgCfV/AWKRkCCEV9SEdR9dJ0dY1Pq89098AA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ss6UyUhSdwJ86R8zWwGQyX9ioRGtIu1Z/vho3L2OqcbRnmUWcNz/v8uRBF12PtkCJVD/3E62Tqy8Ix/CuERhY8QwoLe0n07MyWwn+53LRGSMB3zuXppXwYwk++dWZktB6vJPmKRGEeWJJSOhqFaNBfbpIdtGh6fN6dDhRT2wnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIa6FaXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2350C4CEF0;
	Fri, 19 Sep 2025 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758312795;
	bh=CeAm2YVYgCfV/AWKRkCCEV9SEdR9dJ0dY1Pq89098AA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CIa6FaXv2oWS6KTE9DN2/vrNv7s0NyMOB8+B+uF/i+Tvns+Rc9zIco7bcUk/afMln
	 WMnVQBdo/+hrAZAKnIOpW/gcOtP7Y6EgIfnE84Y/0YVfSz1qVBl5mMz0fBuA85mwaF
	 V+HI51cSt+uT7VGDWDEuygkOh+GbaqHPbxO1OCm8KX88mSpGgspRz2ylqSWxiizLHE
	 a1K6vKQ9j13ffOvy88fRSyYTl1HRbcdpIgIDUzgNT+novzFZBn+reZUlIarjqyXgMQ
	 ucB7MeLcxJuGBBSQ61QbE9bEGZ2HDrEe3c80zosEQjUq30kD3NuHnJreBQaxP+rw+Q
	 /sBIOXuTGD/Zg==
From: Mark Brown <broonie@kernel.org>
To: yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 kai.vehmanen@linux.intel.com, Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250919140235.1071941-1-rf@opensource.cirrus.com>
References: <20250919140235.1071941-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar
 callback
Message-Id: <175831279352.217357.15267982435869404784.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 21:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 19 Sep 2025 15:02:35 +0100, Richard Fitzgerald wrote:
> In create_sdw_dailink() check that sof_end->codec_info->add_sidecar
> is not NULL before calling it.
> 
> The original code assumed that if include_sidecar is true, the codec
> on that link has an add_sidecar callback. But there could be other
> codecs on the same link that do not have an add_sidecar callback.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: Prevent jump to NULL add_sidecar callback
      commit: 87cab86925b7fa4c1c977bc191ac549a3b23f0ea

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


