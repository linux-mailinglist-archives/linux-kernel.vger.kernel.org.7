Return-Path: <linux-kernel+bounces-899357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40029C577C6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DA9E4E4298
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFEB35028E;
	Thu, 13 Nov 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLkdkHW+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B732FFF8B;
	Thu, 13 Nov 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038271; cv=none; b=C8c45Z9C+9GJzYjA35IBnua8Jf8RMB66lqpAG6t5H4antspWNAvRcXvXfu9cBsVfwe8MsMPEuneMJcyGPVGKd5lqEjarDINp2AqK9lNC+7k13xTW+U4m7QYMmNlNRrSx0pQjt6KkS9uesHeYbU7aE8WeVhBO4X5GGWXRYYerrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038271; c=relaxed/simple;
	bh=v8Y6xL6/JEDK8WNjpV1QvjO5CFa5S3nMylBofRMehp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=urYZO29dqEXJpGrbzLNySEh5RShGCuWTVLYJDaqAK9UyMiJwr1elLi3J8jVHzwlGLeFZWgooiRReCJjgrT+d5ydnnXS7/cq9khbhQS0PHcUgxHkLDvkHr2kx/2lIBjKyDZ+5G9h1t1kFYUpwtUdyYDoo6u9Tc1lYtw+DQn1u254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLkdkHW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560C7C4CEF5;
	Thu, 13 Nov 2025 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038269;
	bh=v8Y6xL6/JEDK8WNjpV1QvjO5CFa5S3nMylBofRMehp4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fLkdkHW+LaDv4Oqa0PtjkU4U3UO6C2xR8mkHe1n+5ZN99nW3+H7gLuRxvLyj6P+18
	 lrJZDcuPQKAFRHsFUVac+DKXC8mxYna1Io8ZFGocMfpr+sV1aidKY+7tR9exRYvwbW
	 WpR4iLlFefHxn2FVIx6jYTzp8LHCJgXzwdY2IlQutoi1R6KdKisBkRgEHFsRVfhoMw
	 iFBrWZClH15hfrZWNIWxfmFYIZk1V4OFMDUGpPOrnKdvJT2slJyoO1oPl5Vdw2OrdK
	 D+swH2gAf9H6MI66F//Ib5KOAM6yoaIqISddJmeYqv7XP7JRG5HvREf+6NekZMIkra
	 rKPwhKz1M7u+Q==
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, 
 Liam Girdwood <liam.r.girdwood@linux.intel.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251112202630.6277-1-thorsten.blum@linux.dev>
References: <20251112202630.6277-1-thorsten.blum@linux.dev>
Subject: Re: [PATCH v2] ASoC: Intel: atom: Replace strcpy() with strscpy()
Message-Id: <176303826496.17893.17470205530298717876.b4-ty@kernel.org>
Date: Thu, 13 Nov 2025 12:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 12 Nov 2025 21:26:25 +0100, Thorsten Blum wrote:
> strcpy() is deprecated; use the safer strscpy() instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: atom: Replace strcpy() with strscpy()
      commit: 123cd174a3782307787268adf45f22de4d290128

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


