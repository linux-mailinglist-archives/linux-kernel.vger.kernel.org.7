Return-Path: <linux-kernel+bounces-765243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73AB22D92
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF43620769
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4492F8BEA;
	Tue, 12 Aug 2025 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkUWwKyb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43532F5494;
	Tue, 12 Aug 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015826; cv=none; b=hDw2LvZ1OwuPC0gh4bY+rQsAaJgyA5ADEN2LONsyA7olFfRM1vE2BRohW5GXLU7P0d+yqQJU8rZkSyKr6GWMDSxDZnPV6wwxqWcjCNA/zK2Kogy6j8PYZb7dDQud/gtJACqsIhuxSeX42jS53G8tTUN60/aJdEqHLZwmVPIsP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015826; c=relaxed/simple;
	bh=aCT0NA5XFbhw2WWxBE1dioUETYz3wro3ExCaYb1idqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FoyVBxrY9LIeYPNaQH0zSG5Nb69qFrx0+gwFY65msuP6UCtOtj2mTUH0mL4dpskpMso4350avIOIfElRBoD2HeNmAiS7aHNmQpIdWN3A/3ZBCuRXy5ewN1Ji47abDfwse5WoFSz46P+ZqtMyDBxexWmEBO66p2YyBxcMK9vYkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkUWwKyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D87C4CEF6;
	Tue, 12 Aug 2025 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015826;
	bh=aCT0NA5XFbhw2WWxBE1dioUETYz3wro3ExCaYb1idqE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bkUWwKybhiKKgdZKDbCQtsMsNZNEhzFvXy3HaKYk/SpaVvx8446Si+N7M9EhLQapY
	 3u+KtcSeJFzrbhMeft0SyEK+YFdWjQHAaq/r16XWspDEGYvrmKleFz6kOmqIWXAojO
	 LR+frZYU08PwfKAkHMkbNX6XONbh94ROZe/pijrvDmrLIQ6wL/0mQTLZc9WYkATOxu
	 M5G21/48F212F6/eyZWOoltGTcO1IypMlYJAkePMySl3fmeMhmeSMgLk+kK9Gpsatu
	 zHWyzIRBpVh3bYx20Sgr81/wgKleWPbehMuRqv+mwDIOyHkdGDo7GWbRF+wWNfEFNB
	 gVpltKiqca+Ug==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
 Nick <nick.li@foursemi.com>
Cc: xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, 
 like.xy@foxmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250723090934.480055-1-nick.li@foursemi.com>
References: <20250723090934.480055-1-nick.li@foursemi.com>
Subject: Re: [PATCH v5 0/5] ASoC: codecs: Add support for FourSemi
 FS2104/5S
Message-Id: <175501582409.192378.2510847202564091154.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 17:23:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 23 Jul 2025 17:09:29 +0800, Nick wrote:
> The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
> Digital Input Class-D Power Amplifiers with Enhanced Signal Processing
> FS2104 can deliver 2x15W into 4ohm BTL speaker loads,
> FS2105S can deliver 2x30W into 8ohm BTL speaker loads.
> 
> Most functions have been built and tested on EVB boards:
> ARMv8-A, Linux version 6.16.0-rc6-v8
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] dt-bindings: vendor-prefixes: Add Shanghai FourSemi Semiconductor Co.,Ltd
      commit: 243167e96939630b7d0d7f61be926d327e14a017
[2/5] ASoC: dt-bindings: Add FS2104/5S audio amplifiers
      commit: fd90680da7e2d92e50ad72dfd4ea601098ab3493
[3/5] ASoC: codecs: Add library for FourSemi audio amplifiers
      commit: e0bbbcaceba1cf47751f264d0dbe36206eab0ef0
[4/5] ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
      commit: 75611770177965ae902c87c96eace07542beff07
[5/5] MAINTAINERS: Add entry for FourSemi audio amplifiers
      commit: 2291a2186305faaf8525d57849d8ba12ad63f5e7

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


