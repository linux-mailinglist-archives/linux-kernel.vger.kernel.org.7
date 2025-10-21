Return-Path: <linux-kernel+bounces-863551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C04BF8252
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B3D422133
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A134C83C;
	Tue, 21 Oct 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Gt+gY8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AEB34D904;
	Tue, 21 Oct 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072730; cv=none; b=JSdZ09VK1NMewP21UzpyeHR9BKqNJiaspMXExhw/y6Lhg7eA3r8eZmEZIOYVSG6pVAUd7On18UL6VSQd4R5Mqg9pbPNZv6+CftcO2frCW1A3eg09YbnOxCI/po2NaXNnic22B01erWW6KPXurV6BVFnWuzO0dfFHP6Kp67wwlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072730; c=relaxed/simple;
	bh=ZB/5wKX4GVjMeMhEKGtvplG5a7Ce/5sBVRDkGuxOt3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XA6sQzfFq5ilRQ1JNpZvU4KVSrukL6/GKtEsbxGeVQGMki4NmFf8uTZpLkA/4Fp5mZEaCHzLdsd+EX7BwUPlRFLm7mmed4teMIo8xUxoGXWkoSBC5e33y3pM5ZS7G8LFidolqWepNY+rDJl1NQPaAQI/JUyiFG11NwI/IDW2bt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Gt+gY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF73FC4CEF5;
	Tue, 21 Oct 2025 18:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072729;
	bh=ZB/5wKX4GVjMeMhEKGtvplG5a7Ce/5sBVRDkGuxOt3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A2Gt+gY86NYJ/LAdB+LpKwMh85+yFVerVokAhh3p0IkNdwU7w6s2VqoXIY/5I1DIH
	 pKlY7YgXK6qu080HdHW1QJAti7ZaK5Rz5yelMpcMHi5lyMc7Qe/9KanV/X6dwyeXDr
	 CoJ+iFOutyybefoNFGV+y2AXt3D7lHbh/wIxaylU2HuxrebyZGoJhGvQJOTimZoZzR
	 EEmLzSjjC/YVcryETcytDbImk9aSIFgPCSYV04vJFWE4wX3ezUk/eqfW9+adSEtp43
	 A3UaQYxavho4EsrhPiV0PtRKrTiDMGm+5liHVfpT48cNdptaLf4mIn0W88caG212oB
	 y/Q6jNMWqD78Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jinmei Wei <weijinmei@linux.spacemit.com>
In-Reply-To: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
References: <20251017-k1-i2s-v5-0-401ae3775fcd@linux.spacemit.com>
Subject: Re: [PATCH v5 0/2] ASoC: spacemit: add i2s support to K1 SoC
Message-Id: <176107272657.196841.17126892413935160644.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 19:52:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Fri, 17 Oct 2025 11:16:16 +0800, Troy Mitchell wrote:
> On the K1 SoC, there is a full-duplex I2S controller.
> 
> The I2S is programmable, with the sample width configurable
> to 8, 16, 18, or 32 bits.
> 
> A dedicated FIFO is provided for transmit (TXFIFO) and another
> for receive (RXFIFO). In non-packed mode, both FIFOs are 32
> entries deep and 32 bits wide, giving a total of 32 samples each.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: Add bindings for SpacemiT K1
      commit: 73978d274eba0d9081bc9b5aedebb0bc6abb832c
[2/2] ASoC: spacemit: add i2s support for K1 SoC
      commit: fce217449075d59b29052b8cdac567f0f3e22641

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


