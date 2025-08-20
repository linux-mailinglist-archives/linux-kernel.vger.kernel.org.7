Return-Path: <linux-kernel+bounces-778607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614BB2E7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8A77B0DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B27277C96;
	Wed, 20 Aug 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deFp5pNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E61DDA18;
	Wed, 20 Aug 2025 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728260; cv=none; b=lenc5tJRsG+UlXp8cjKoDmw3i1uJd8tduBrV2QO3yPwNy3NS9RJjQ/jcvp0PAJNVttVtTAsgAYeUOXgikHU6G424ufB80LhqiHZDeIEc/L7QG5tpy6MEcHXPidjXYgLvh4mFxQxdLa9CSOa2M9b0Sa/FvQ2wczkRISk8yZDF+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728260; c=relaxed/simple;
	bh=eDu8QR5kIr07udxsRmoFGBACAqMZM7dZomdO2wR2NFw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=js8kGisaOEnKd8+jex+aFGfzoBrzvtpZW3tJCJnVEmmv3AzM8rix+Xw5/7EJNM8ee6gfr8ZSnGLC0bgICmhARpdxZC9xw8bP99oScy9CLGNlBN0vXtNP6YlKU6zgaNr++qkjkYhGIH1TkojKyzlsxv+qK+RvfCsqZYFCML5J1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deFp5pNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F05CC4CEE7;
	Wed, 20 Aug 2025 22:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728260;
	bh=eDu8QR5kIr07udxsRmoFGBACAqMZM7dZomdO2wR2NFw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=deFp5pNHdK9Cn8YK/W/UKn93sLyXcRafl7AIdHn4ca4HS+VyBIBvZhfkU3SqZkqOO
	 Pd+zHaWlLPUw9NZEkK4FY+bWmjAHkgnjdA5JAvuXVx1pH5myfGRuY0j0skW6VlEXxI
	 jxb/FIxaydITafislJLf9s9gY+BR4oKz8S2VhPZV0/4uuYIy34UFhnOYig6d7eXaZH
	 7J92rop1Ic+bftYa4Dk3KrEIO30AfYuVx3el0WAoMB189W8Ie5xcPZTEvKfjUpOXnj
	 MKTiK92pD2q/dfi1duF3KTjvCWSK8t3AJKSMHSwWvL76SzEIOE/fiyKLJ47YDlXWFL
	 KansHdGD6Jxog==
From: Mark Brown <broonie@kernel.org>
To: Nick Li <nick.li@foursemi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Andrew Davis <afd@ti.com>, Chen Ni <nichen@iscas.ac.cn>, 
 Linus Walleij <linus.walleij@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250820123423.470486-1-rongqianfeng@vivo.com>
References: <20250820123423.470486-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH 0/3] ASoC: Use kcalloc() instead of kzalloc()
Message-Id: <175572825608.300376.7595587079585456413.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:17:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 20 Aug 2025 20:34:17 +0800, Qianfeng Rong wrote:
> Replace devm_kzalloc() with devm_kcalloc() in sound/soc.  As noted in the
> kernel documentation [1], open-coded multiplication in allocator arguments
> is discouraged because it can lead to integer overflow.
> 
> Using devm_kcalloc() provides built-in overflow protection, making the
> memory allocation safer when calculating the allocation size compared
> to explicit multiplication.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: Use kcalloc() instead of kzalloc()
      commit: 45441b933cdfb7a018674049f269d7a1bc1688df
[2/3] ASoC: fsl: Use kcalloc() instead of kzalloc()
      commit: 3b6f4bd6cda2797b0d999a129376c112d41604f4
[3/3] ASoC: test-component: Use kcalloc() instead of kzalloc()
      commit: 96bcb34df55f7fee99795127c796315950c94fed

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


