Return-Path: <linux-kernel+bounces-765245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C228B22D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C387623259
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600152FA0C8;
	Tue, 12 Aug 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp4fASVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6152F8BEF;
	Tue, 12 Aug 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015841; cv=none; b=jH6Unj6ta6p+ejp8wMjYBfxRTBpTt4e37tp3enZ0OCEG130Vj8RXsKgPEooBK8X31Ztluuoe5EV3vbSl2uo8/8W1Csf189qUDC/O8bnvpIup5mA4yuQ4uiGTGN7onCfblt+hRBA+tnGciyO5tZHtaf4zlHGMgNjfAIBsXx9dLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015841; c=relaxed/simple;
	bh=MaZ8xxpsRnmxn0uraPxFI2200TjLgvcQp6f3aJflkgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kFlbFIu58wpLCFk0Ovkw7+JpOJScUTATyT7HvBW9URlEqBB99MQawcI6heMdWXTVM135rzgetA7TjsHGaTq1cMx+Ujk7r1VXpbuWPfGWzTqi0HTLj8GHjrWolgcAtlnc5X8xObf4HSoLHmHJNcihXkw/N5iLL/LLHHGHFLx55Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp4fASVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94512C4CEF8;
	Tue, 12 Aug 2025 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755015841;
	bh=MaZ8xxpsRnmxn0uraPxFI2200TjLgvcQp6f3aJflkgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gp4fASVsccI+2W+hpv6GZtrdwpXf1NgENA4Eptn+jeIBZmX1jiI5DS0V4B44XqyxV
	 sy9KW0tE/Kdk9+jFpIItAr6biTBwdigR8BIXmVZsT5QGUKQ6cf3v7WON0DCbsN3wYg
	 /XB0t1MNr1Y0q5PtzbLnQxn928bh6K+5/s9KTPffH7cOpT+FFW5fP/+U+xsiN0uBNs
	 Ucl2qSnrw1cZ30IwtTYNmRC6Z+invgSmrQjPCnedYrAgTNrV2qKPRr3jN4ByoTouxV
	 x5LQO31pDIZXg+Sl63xI9Hb6FX5Z9aK5K1PmHJiFyX0lcilPk6b0n9D6XWNq4qEOB7
	 C2jqgY682govg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, 
 Nick Li <nick.li@foursemi.com>
Cc: xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com, 
 like.xy@foxmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <EA25BCF08F8BA128+20250811104610.8993-2-nick.li@foursemi.com>
References: <EA25BCF08F8BA128+20250811104610.8993-2-nick.li@foursemi.com>
Subject: Re: [PATCH v6 1/5] dt-bindings: vendor-prefixes: Add Shanghai
 FourSemi Semiconductor Co.,Ltd
Message-Id: <175501583828.192378.16681495842244137315.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 17:23:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 11 Aug 2025 18:46:06 +0800, Nick Li wrote:
> Add vendor prefix for Shanghai FourSemi Semiconductor Co.,Ltd
> Link: https://en.foursemi.com/
> 
> 

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


