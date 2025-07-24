Return-Path: <linux-kernel+bounces-744944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA88B112D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8413A55EC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8792627FC;
	Thu, 24 Jul 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSepwrjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B42EE616;
	Thu, 24 Jul 2025 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391356; cv=none; b=iLWatgp9SbwY9z73cRKF+0cOJMcF2r/Rb5cvo4Y6gQK0WxL/8B/5D4xRUJPsZN6Eq7FhDNZs7gQRHvkrsEMYj7/bVcGY4f1j4PLNN2Y1wCu2f1U+OSyfYDQ3MD42lfxlqIJC7RYl3Dopg8WGwCmG7ov+bPcjU+KPdQbibF7MmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391356; c=relaxed/simple;
	bh=nWp31srlWOly544EzYSydGTw01FUN6i0u3AAl2ah1sE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=moXw8qjVA/aw1GeIaNpUV4KsOMSgH7hYQ1BYgPuDA5L8CBaTXm6zcZnHSvV2TE3nVLgykyaq9+g7fmZrDgtFbtUfL1U5iSyY7wHK3hZv+nhJNNEj4jbMdIbxFzWyb4dBHqLQXiBjYj1VVXh8WgHuf+vYiYIQxqZu99S1wOHpYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSepwrjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BD2C4CEF5;
	Thu, 24 Jul 2025 21:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391356;
	bh=nWp31srlWOly544EzYSydGTw01FUN6i0u3AAl2ah1sE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=gSepwrjYRHTadeORqfLdJJj+3A5uUgVNePHG2U2rxx0RxjUgeRkA8SD5R6E7W0Tqk
	 B0fIKoVSPZZsj9OhUXd4zAFk1438aywHt/cseC0oSCJtKbvB+w5yZMpj6bSZ/7ADMX
	 GhwVrY0Vaod6B4sgsx/UJB1V05XjCWpHcBC8yy3FqpsPdsfNtkIf70TCYrodVxsbLA
	 zsVSZtn0KHqqAneBwN+VztaWKUmybaFZCIZEAQwt3gRECNgvn0DjNg370fAPdc9sAM
	 9NpyUM/m6Bqh+D+IWde95lOIdzaZbOioE92BQicoNFL/C0reV5JHFc8tlsDFM0yHG9
	 P/EQf23ZcC52A==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20250723073725.787844-1-chancel.liu@nxp.com>
References: <20250723073725.787844-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v2] ASoC: imx-card: Add WM8524 support
Message-Id: <175339135330.153218.9643329948012933654.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 22:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 23 Jul 2025 16:37:25 +0900, Chancel Liu wrote:
> WM8524 is a stereo DAC. Add support for this codec in imx-card ASoC
> machine driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-card: Add WM8524 support
      commit: 2260bc6ea8bd57aec92cbda770de9cc95232f64d

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


