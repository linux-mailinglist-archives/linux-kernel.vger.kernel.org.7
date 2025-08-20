Return-Path: <linux-kernel+bounces-778608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CAB2E800
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00925561BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373DF2857CB;
	Wed, 20 Aug 2025 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbhnqGdu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BE27E1D0;
	Wed, 20 Aug 2025 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728261; cv=none; b=g8TETcY0bLMlhX2d5BXwgK9i3LmeCc+/zRri7ytzEjHvV4lkCvRnIe2Kk1SHOIIy+mUm0QDSsVLIAp3QRtGJPx6SVZi7qwJFIV5R9ZpHS+5gOiUlehUxmrKLM7NIPyjQSfBknjXEiCM60dDsZdxCVHp1ToILJfjvDB0ilIDBA54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728261; c=relaxed/simple;
	bh=UX1fZLzE5Pm1purSADVCo6FhgjblRhhECKxHJjrguXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NRSR6H43C7vDlAxB5Z5mLHXO3ub/gZ3UvZ1a8c8068j/zOXLF3YlGmVnKePkn204aKKQpuBo3YKR3ZkQTFdSplcpez+tPTRGJRPI1ZMHR1v9iJPWEsbmbm1dKmESiGnpuO28J0aLuP0j1A2wTF4Ub2Z4NRH42mkDpYzTLTy8mTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbhnqGdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651D2C113D0;
	Wed, 20 Aug 2025 22:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728261;
	bh=UX1fZLzE5Pm1purSADVCo6FhgjblRhhECKxHJjrguXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KbhnqGduYrvu1Y0MlxyGNdNnPhwUCPdM9bGZD8PbuQzp9rDGqAkQ8rsqnUwzX32Gu
	 VhZKng1e3LHEvfEVAgBUULD4XRpTPug56B3s7z7xjKOo7Gwgvo8hIlxI59VhBXMn6h
	 1OKd684ypIE8095RwVcD6cUPrZPrk6yG/jQWYFGQFCA5ohwFnJW5eI9Mg8VFyd/w/h
	 sxTkhEoPIhaamS72/H7bs+2saB54CDGkcqDCsDyBN6iULzDnQJeeN1icM4GhpsCQKo
	 lTVB0nDNFlDSH0G/vOXRzaYWOzK+MFji0yTnAQD8V3yDDACJ7fxq4KyZXzaD5xh6Aw
	 /UtpNcgkx1nOQ==
From: Mark Brown <broonie@kernel.org>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
References: <20250820125045.117740-1-sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v2 0/3] ASoC: cs35l56: Fixes for CS35L63 for production
 silicon
Message-Id: <175572826017.300376.15142884398551755377.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:17:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 20 Aug 2025 13:50:33 +0100, Stefan Binding wrote:
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


