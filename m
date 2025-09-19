Return-Path: <linux-kernel+bounces-825203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC75B8B465
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B180A015D3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6328DB54;
	Fri, 19 Sep 2025 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNWybv6K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92F21CC60;
	Fri, 19 Sep 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316007; cv=none; b=pX7CWswHqezuytphGnbePmiev+3DathlNHlsa8eI0PaVoDyYFJB+LJj9nnYPYpYplL4HXy6G+RJfhUw+XvAla5nXauDzg7ab9LGetS2URODFhrp7GR1L9i2MswbWKUN+95rISaoyLhSQWtpIsfsBETebiIUN8s1tRtxSV2/VdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316007; c=relaxed/simple;
	bh=AZyVB8V6Ey50Gr7OmuBq23KPrawUMGKWsAlF4V2ssKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q76k5/7umwxHLyaWwqFCqa5xsJ1s6uTHBRx+JycajWw5ggFne8UMZfbd3OJe/r6dKmDVnT9Z5u1rE3eVN8NhpPu5IoSJhnI0sVIOKTKUBWBtuIX8Vm1Wbpi3Hg6Lg7Ae/FywfhESpmqZVuSET0QN+Im2N5VPjB4oFa7rf/YicrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNWybv6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A28DC4CEF0;
	Fri, 19 Sep 2025 21:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316006;
	bh=AZyVB8V6Ey50Gr7OmuBq23KPrawUMGKWsAlF4V2ssKg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CNWybv6KN/koR1Nk2/3ZqLBy+tEj6tOo+bUae3egY6K9HPQl/cTEvhkqos2R/MFe9
	 jxE8tivDGfYIIYSsruQfYXZpe4QCs36Jyrt2BTgN+zitvlAwoGkQGk1WQb0VoHlMrx
	 08Q1dqAMhu4oYjnO0UCN/8NLwRyCf7POV1xIIZWHngcWuXFZfiXYGH9cpOG8TPPtOW
	 qJTSbegUxcJntN7pMAXrKi7T+6t4xUN/bUSIdoqp8/y55v7EIzumSUdge+WB2duZCq
	 J7C0JfYC1/kZV5/+bbuD+BfvjB6VmMF26BVEK1Z0wXzdn3jUPCQldIaH4JsluWf+4a
	 Svxybdp9x09HQ==
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, 
 Qiang Zhao <qiang.zhao@nxp.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <cover.1758209158.git.christophe.leroy@csgroup.eu>
References: <cover.1758209158.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH RESEND v3 0/4] ASoC: fsl: fsl_qmc_audio: Reduce amount
 of interrupts
Message-Id: <175831600403.228965.1508351336751078255.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 22:06:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Thu, 18 Sep 2025 17:34:07 +0200, Christophe Leroy wrote:
> This is a RESEND of v3 sent one month ago, see:
> https://lore.kernel.org/all/cover.1754993232.git.christophe.leroy@csgroup.eu/
> 
> This series reduces significantly the amount of interrupts on
> fsl_qmc_audio device.
> 
> Patches 1 and 2 are preparatory patches.
> Patch 3 is the main change
> Patch 4 is a cleanup which is enabled by previous patch
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] soc: fsl: qmc: Only set completion interrupt when needed
      commit: c2a60426e94a56e5329f6c2681c251281f63ab24
[2/4] ASoc: fsl: fsl_qmc_audio: Ensure audio channels are ordered in TDM bus
      commit: fb418fe26d28378700bddc16f5fa3362dda86d1b
[3/4] ASoC: fsl: fsl_qmc_audio: Only request completion on last channel
      commit: 4c5f8c25561f36407cb137d4c350651820068148
[4/4] ASoc: fsl: fsl_qmc_audio: Drop struct qmc_dai_chan
      commit: 2c618f361ae6b9da7fafafc289051728ef4c6ea3

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


