Return-Path: <linux-kernel+bounces-766902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1DB24C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634E87B2971
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC32ED144;
	Wed, 13 Aug 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyGEgX4i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD62EBDC7;
	Wed, 13 Aug 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096761; cv=none; b=HWhwKIkAIMcc/mtDNpMMS7+jpYZJr9w+bpgnDRy4zckVqHnky2VJU6Y5qzgVQ3zCcIGJ5H7NCEt4hYrJQPpNDeT53HT49DgwwPzP0ou/UxzwLzwBCxwXqcJ2q8PqGGoSGHTd1w+mZ0KtAYorMY998Oj72KdIkdgkzgx288pUOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096761; c=relaxed/simple;
	bh=W1MMJYOB6Rx7MR8HcE10hp/kPBnLLfMgHsge1n6PciY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W/fCIpPNkqgNe64ZlLHcxDIypl9mL9meHuixozK0v1VW+Wpil27VuP2VmHxwLMYI5nRIL6EDEgzCXQmMfZ/nfEe2RYMRtTgup3BszkksEXtcZPWk732BRP+js4iup71RnIqcoy4gaYE93hrtEDJGzaX2u5VhdMu9gJ56evxOSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyGEgX4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075F7C4CEEB;
	Wed, 13 Aug 2025 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096761;
	bh=W1MMJYOB6Rx7MR8HcE10hp/kPBnLLfMgHsge1n6PciY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fyGEgX4iOkFrB8UgIV9irDO0K00ZAaqgc+PnUKHiIwq7lQoqtY0uwKZSbzQ6uS/8i
	 k3u/HvfLPPVF9n1PGcHXqw8Kv5zSqGrgwOI+UkL8iSQgxlhUbMBMtGr5WGOb973Vey
	 wXEraOj4i6ju1TxMC1/qRCIqDaGxpKcPUYOzCoG5qbGkxFo3l2XLnIPTS7FDXaoiHi
	 C2fIxy4B3rUxToAizViCSzv/EQzeL+wdgRCThZRdLG66rrAh5d7ajZbD+xeZht8B2L
	 amWMuOf0657Ii8/Dx42pEbA6R2taULadoTrj8RovUtmj07TqMBricr0E1UQUr2rd/g
	 o8qoAWyJZzoEg==
From: Mark Brown <broonie@kernel.org>
To: olivier.moysan@foss.st.com, arnaud.pouliquen@foss.st.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729020052.404617-1-sperezglz@gmail.com>
References: <20250729020052.404617-1-sperezglz@gmail.com>
Subject: Re: [PATCH] ASoC: stm: stm32_i2s: Fix calc_clk_div() error
 handling in determine_rate()
Message-Id: <175509675878.70774.11170404842428656670.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 15:52:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 28 Jul 2025 20:00:49 -0600, Sergio Perez Gonzalez wrote:
> calc_clk_div() will only return a non-zero value (-EINVAL)
> in case of error. On the other hand, req->rate is an unsigned long.
> It seems quite odd that req->rate would be assigned a negative value,
> which is clearly not a rate, and success would be returned.
> 
> Reinstate previous logic, which would just return error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm: stm32_i2s: Fix calc_clk_div() error handling in determine_rate()
      commit: 0ebbab41fba1bae6ccd96c0eec17026700ac6534

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


