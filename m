Return-Path: <linux-kernel+bounces-785484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A715AB34B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563F617AEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2FC2F39A4;
	Mon, 25 Aug 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYIb/7F6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B15233D85;
	Mon, 25 Aug 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152280; cv=none; b=GuaIVv5SmFd13GQZ2RVBB/7ZbQW++1F0fEZgz7s4Jc+e1LXDwWpMYorsxJ1Wt00rWKfxQ8qIKL6Ht5eKNonwKJo9b+Paauv40MMq4YyjiNmD0QPcy1w62zsPfkNc0UGssgxSlNceZID0YENzihjz3P2YA705JZJ0bAweEhiGePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152280; c=relaxed/simple;
	bh=zfoEC0qVaIxne+Ih7GOFCCmslaPPL3pdBZesCwuWO18=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YkNSNXkJeGq9VqoqsZsqR26zIn72tKSPiJ+x2SuHjXzffc1ibmRtrIWnDGZuzy5jYN4EPR+EmA668fYh+Dxw2f6XKalhcT/uL9LHfiXHDuJ+36SA9fLKx4GeCIS6jIF0cM+885E1tSBKmvCp4i63DGraY4DS8XW0Am3JffPCvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYIb/7F6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D1BC113D0;
	Mon, 25 Aug 2025 20:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152280;
	bh=zfoEC0qVaIxne+Ih7GOFCCmslaPPL3pdBZesCwuWO18=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UYIb/7F6z/p/GP+mdnt7Qx6lRuw0WvsBXI59wavEe3ebR/bxsPORopOj2TBtdkrO3
	 1x5T+pNYfTV7UoELqXsNXLibUw79tmZp1JXZaU6KsedmkosfIeKceywPs0oVL6voR/
	 viiCgSO5Bzv8k4xGWc4y5Z6Pl2t3vpRH+saJmQvB208Dy3ZHzng0Zx7296ldDhbYfI
	 X/eplYSnaj7E41O8x3oj8XRJ8JmcmpI6L3rzNeOTYzGzd09XmXeIOQY1ZQWpz0mi21
	 TM2nRNgx56k1T3a79aMuEpP0RhsM5WXibX5PQJkdd4XSSKqs3FK1waqkPLVLRWeWcN
	 cXkWhCa1T2paw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250820031641.2158261-1-shengjiu.wang@nxp.com>
References: <20250820031641.2158261-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: remove cpu_pdev related code
Message-Id: <175615227355.226187.1520162312481432148.b4-ty@kernel.org>
Date: Mon, 25 Aug 2025 21:04:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Wed, 20 Aug 2025 11:16:41 +0800, Shengjiu Wang wrote:
> If a defer probe happens for the cpu device, the return value for
> cpu_pdev "ret = -EINVAL" breaks defer probe. As the cpus->dai_name
> can be replaced by cpus->of_node, to simplify the code, remove related
> code for cpu_pdev.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-hdmi: remove cpu_pdev related code
      commit: bc017f28b1c6c3d44c3631f8f6d152b7e703e990

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


