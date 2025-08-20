Return-Path: <linux-kernel+bounces-778610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F8B2E7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 479AC4E2D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E48B2DC32D;
	Wed, 20 Aug 2025 22:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq2Bb1tm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6542DAFC1;
	Wed, 20 Aug 2025 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728264; cv=none; b=WSMDNYVJDA+fLSQD5PKjij14lHmxoaClR7Xc/9cuGQjL46tdiJ+WYeEWE4QROU0Nip5JAKXaoCN1fXC95OYGAqnydjpWSa9zT12ltp3kLBMrvi8rN69CRrwT2jf+FDSzf8dMMhw9HctiOd8uMuIOJHMPqRKbiU7CwNFpZVdhuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728264; c=relaxed/simple;
	bh=YF43KGoO2dSFOul1+BCDouHP3wCNucft3cNQlUfcKBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RXETwbdD98F0phUz7IAvbfj1ber+2Av3t7BWl2AH1Td2cOnw86gUQO3nAAqWqBOhSXh1TIbDMPJnJ9hL+OfSAYCsHyixQqHvAPQEW/4+V7/+d0ksLhJzxghfxLBUVtm8Cu3JTz6wlcuMvD5CcAb4Gf9jdMDEVDbNujf51KVm3YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq2Bb1tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7289C4CEED;
	Wed, 20 Aug 2025 22:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728264;
	bh=YF43KGoO2dSFOul1+BCDouHP3wCNucft3cNQlUfcKBs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jq2Bb1tmOuI+mk7eyUv9vuWoGzwQXYvL6zI+eMPRMTEyVXFkpylj1x5IFo115usG4
	 dPtLMtjiR7SOMKXMjhvHiKkC0gKfUGBk9VjOeqwyYaSYeQpRTGmpqkIuhbbBkxjnJw
	 8VybF3qjOfEzBNxny6TV00YBfiPBNLfjJVpeSoLgOp+DMrlhZe4ekuzUvQ8YEb+nvg
	 LllDcnMw/XPTV3OXDKTvSWrmLerK35cOiiL7uAtsosnu2Q8HeWBKxC4q617UBrAGeD
	 wHw2uPyW924A6MvEJUlJ5yAggnDy8JuGQc93o92DXzcPGxAqbyfa2tLVMgledH4b8B
	 J8ZDGMJ/Xmkcw==
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
References: <20250820142209.127575-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v3 0/3] ASoC: cs35l56: Fixes for CS35L63 for production
 silicon
Message-Id: <175572826370.300376.1566951929910497131.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:17:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 20 Aug 2025 15:21:59 +0100, Stefan Binding wrote:
> Production silicon for CS36L63 has some small differences compared to
> pre-production silicon. This requires small fixes in driver.
> Update firmware addresses, tuning algorithm IDs and remove soundwire
> clock workaround as no longer necessary.
> 
> No product was ever released using pre-production silicon, therefore
> there is no need to keep support for it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: cs35l56: Update Firmware Addresses for CS35L63 for production silicon
      commit: f135fb24ef29335b94921077588cae445bc7f099
[2/3] ASoC: cs35l56: Handle new algorithms IDs for CS35L63
      commit: 8dadc11b67d4b83deff45e4889b3b5540b9c0a7f
[3/3] ASoC: cs35l56: Remove SoundWire Clock Divider workaround for CS35L63
      commit: 8d13d1bdb59d0a2c526869ee571ec51a3a887463

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


