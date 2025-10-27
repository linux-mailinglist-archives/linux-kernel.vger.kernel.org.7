Return-Path: <linux-kernel+bounces-871564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81B8C0DA8F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA849422E85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F592E6CAA;
	Mon, 27 Oct 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiGe9bio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33F2AD32;
	Mon, 27 Oct 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568625; cv=none; b=f7vBqqhtBTJKlSx1mtpVdDLJc2CSbIUpsxdCRWoKIpUGY8Ytawxlpp/4tmQFjsLMO38AEXcsP4LJHUglqIrG29ts02ft+xq8RWXZYm7AltIbhcELLqDCTuC7EoqVI9AkT3QySXL2WDGlGifp9KfUdI3lWA0n5mDkuEGGi4Zie4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568625; c=relaxed/simple;
	bh=redh+vh8l4GMLQmHYsINwMcHjcch2Bk0h1hWDsj/HHc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lz43eubSCJIAHbghV8LGYryHe/wKRtyzcQry5KOS8NtpWq5+6g9ZP5EUf/oZgNl1jShyB652XPuhXxdQrtkq4Bbd0vqbnx6EvKF7tlyo787FNJZh18ksSGHHUIJxY8sQGgzhwR2O0zqv7B3899JAN9kUh92OnuNG75QBgzKO45Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiGe9bio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45DAC4CEF1;
	Mon, 27 Oct 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568623;
	bh=redh+vh8l4GMLQmHYsINwMcHjcch2Bk0h1hWDsj/HHc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=kiGe9bio/BCXg1Mz24lBo+4pYFrQzTCfydQGdSfCxckn8Ix03lFLFb0GoxxgTOXsD
	 NifB3Erz440S0iRhzyKdg7zeQIXzPGE75SnEg0fX1uqDeksklPJzTdhvgw8SpmNSn1
	 aZroYI2BaRy7CI9ZQS4q2FH0qfRg7OTNc7ZL9+rmwet6pi43ORSSrK/9gxc5kDstlK
	 uJ7VGJy7Orx01z9y1mwo9keT7xRnqhkqT7UIlD0Z5BmPHSm/Wz595Bg0fwpjJloO2g
	 gdgThxiHdKR7OHWSlAlK1zxEM9RthfrufIyiIFFF8tT8DsK3IwzIowoLLWJM1Rju47
	 /m7VWp59VEqGg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20251023064538.368850-1-shengjiu.wang@nxp.com>
References: <20251023064538.368850-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl: correct the bit order issue for DSD
Message-Id: <176156862139.24382.1000390767821381636.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 12:37:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 14:45:36 +0800, Shengjiu Wang wrote:
> The DSD little endian format requires the msb first, the previous
> understanding is not correct. The issue is found by testing with
> pipewire.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_sai: fix bit order for DSD format
>   ASoC: fsl_micfil: correct the endian format for DSD
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_sai: fix bit order for DSD format
      commit: d9fbe5b0bf7e2d1e20d53e4e2274f9f61bdcca98
[2/2] ASoC: fsl_micfil: correct the endian format for DSD
      commit: ba3a5e1aeaa01ea67067d725710a839114214fc6

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


