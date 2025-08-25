Return-Path: <linux-kernel+bounces-785483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEEBB34B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2612B241E75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E25289E07;
	Mon, 25 Aug 2025 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls/iEHyb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3428D850;
	Mon, 25 Aug 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152275; cv=none; b=TU3fwtOU2IgzoMN+FFFj83v1Vi1jzl7E+TRiqaqGTiDHS/V7BQdUBEaNGCt/cjRgshMZCdofPVoqTg/n2P2IaXFLPebGyIHO+kgZV8wuwcKLFGcmLEa28IbdkTYJaExnq1zSZwXczuYFOau62ep5QqJ6vRW4yVpuLFth8Jw7D3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152275; c=relaxed/simple;
	bh=L14rpLZToW5WCZE/viavkgohrlSDYy1ksdG+9t1IaJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ct/XWU/dQbFxpJORbrDL+RGAdGD5+DrS92UHd4WbhPMBWAXQ1jQxC2DT1m/E9UhLMT6gZLUtCXgytqnmhLrN7oDdyJAlVZ52GTWMagrUtVGkD7skZ9D6X4Fi3B6SGOuybcS+BQ/kH3bJQJVlHZIoBTYfxD6mmBvnzSYbpcoEJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls/iEHyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36920C116B1;
	Mon, 25 Aug 2025 20:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152274;
	bh=L14rpLZToW5WCZE/viavkgohrlSDYy1ksdG+9t1IaJQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ls/iEHybCsoQHIF06BqTo+u9V0vgroIUAPyodc+a8LVY8Qv7PhhBrzRvQv3TJjw2B
	 Tw7Db2XecPgdLzBqhpwjUoQBTjrtKXjAuczMcJm/BJASw2ThV7ygSvctAuiqkPw43k
	 pvaLFxg7UlX6UeaEdSPDAuxM3XyRCKS0nDVEwlNJTHf7cK6OxbjfL7ASnplUqNM9N5
	 xz14ZTQTGCaJ65nZ6z+JOiWGybf0yzRKZKG6gMiykfpdqqTc1ZWAEQDMy+A61EsnOC
	 8KX9xrXATelSJ1+PYO5MclGVudN4uxw/zblUA6TzSg4ahQgmnJyrODHU8uQcCjioQi
	 pxLDvyJaQB7rA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
 daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, Xichao Zhao <zhao.xichao@vivo.com>
Cc: kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev, 
 kernel@pengutronix.de, festevam@gmail.com, linux-sound@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20250819112654.588527-1-zhao.xichao@vivo.com>
References: <20250819112654.588527-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
Message-Id: <175615226835.226187.4626618247051685384.b4-ty@kernel.org>
Date: Mon, 25 Aug 2025 21:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Tue, 19 Aug 2025 19:26:54 +0800, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Remove the use of dev_err_probe()
      commit: f840737d1746398c2993be34bfdc80bdc19ecae2

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


