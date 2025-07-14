Return-Path: <linux-kernel+bounces-729818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028FBB03BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E15A3B66B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6183D2459E1;
	Mon, 14 Jul 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKQwRRMz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40C24061F;
	Mon, 14 Jul 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489212; cv=none; b=gd7tbvZG88jnpreYjm54+mx7WiT79wEhxy4Oq5QyjKo/D0jApNTNpaT4wwGe4DlKqt0K5t9xSdQyLtGV7F7bLM+/k0pukRXlWG9UT2u0stdVG+KwSvQfdELSgwbv8li2WCSU8XXNwNjO+3QYo26Igydn4w5JZL/+/EaxwsBAiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489212; c=relaxed/simple;
	bh=bMoDE10u69+kJo+CqlUf/1Lk5IoVrtH/MJM88QLo0X8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tEu/qFJngu3/aclhZx6tMP28hyvZW4UmKLPU7Xu9Zs1S47Yh8M9qrcnoOZzGbVvilYAl2knVfrlDoKtVAaLHkSAoeL9MXdGUEwmGTSXus8aqRKLsN25/aaj7+NkF+qw1npZrcAIvRdovM55M+B2ugaAZDE0jdyXBrA3T0/aeZRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKQwRRMz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B3BC4CEED;
	Mon, 14 Jul 2025 10:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489212;
	bh=bMoDE10u69+kJo+CqlUf/1Lk5IoVrtH/MJM88QLo0X8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UKQwRRMzxreim04vlh2nc5bQcynAxieghO6aqhe8IqhE4k9SvCU0yOs0189unXdvY
	 oV1JTpMwRXs3FXgq9NPSl1GSbHjHO1yZkdSrblfIp60SWoRrWyXyLTjDBChq5O+nKe
	 mdgfXtxOFQz6X3rtxz9qhR2JIktwzsGlJlSV/6Li8VuTby7na20b7TUC3qnRK95Tc8
	 ApDsaIpHT6cWzzyxBtUTW3jnpyEvHHAT5hlbWYYbon4IdWkgb+atBSl0kR5eCfJqeT
	 pgLABcRuKfKuaZDFxOwUw1RtzE8fZDI1fpDrenPtXxs42dvyPjcgPCLZ8+9q2JwILs
	 WRsjnqCtMhfRQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250708085318.2563521-1-shengjiu.wang@nxp.com>
References: <20250708085318.2563521-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add sysclk_ratio for calculate
 sysclk frequency
Message-Id: <175248920998.18169.4788818303967179573.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 11:33:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 08 Jul 2025 16:53:17 +0800, Shengjiu Wang wrote:
> The sysclk frequency can be calculated from sample rate multiply ratio.
> When sysclk_freq is not configured, but sysclk_ratio is configured, then
> calculate sysclk frequency according to sysclk_ratio.
> 
> Apply this change for wm8524 codec.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: add sysclk_ratio for calculate sysclk frequency
      commit: af241e3fa4d823f8af899c92fd50d020816a1860

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


