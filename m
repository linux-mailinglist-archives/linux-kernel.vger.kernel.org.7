Return-Path: <linux-kernel+bounces-764628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2F8B22545
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28ECF1687A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619FB2ECE99;
	Tue, 12 Aug 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKoo5LFt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF55F2ECD18;
	Tue, 12 Aug 2025 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996724; cv=none; b=SBGu1Ha/WYKQ+g9hgWI5J5F1JYNVWUe5JbP56tRg8amlDvbNOOJX+mAyQ+Gtay9WdfZK3w5vZeCNw1ein/4ykvC8LZ3e8JpNPJYPaHBgs0hm/AtGEvemXLNdn3ykVcCur1XpxFL4YWBigILqp87ZGOpoWAJyL7DKoKDZOnRnuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996724; c=relaxed/simple;
	bh=QfGgwTzP83ZX04O2sV0iEiI+g52ltK9raJ2JLLA7n6c=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=seqfimU6boO463wKTFw4wH5KIb5SZ+bfi6ITjYCm93PJ0z5fyer63omQfwR+paN5X9/t0+aT/D8hOGf2Z/iaSqbx3EvR8UWZGLa6DA4L9DYYiMZi0N16fr0Zb4+3a4bJ0oBYbdbWbRzy2BLMX4TavlQOnwDx9FABq3Gn7fofcuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKoo5LFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F5EC4CEF4;
	Tue, 12 Aug 2025 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996724;
	bh=QfGgwTzP83ZX04O2sV0iEiI+g52ltK9raJ2JLLA7n6c=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OKoo5LFt7ltr5FV+pV7UyR42ShOPI8Ic5Yn9CJi0KnCNJfc8tXbMo9gDd+oxupQvw
	 6x4sJCPT9/27njkbVxz9otEaW4ybmtLyC45UqBeDqn3EJUSxDolDru+4khIBWaPTm/
	 330cfYJeAgbhmOOLenE6cENtUq09pXrPizmLwG1tg9tD9KnNKxqkgnY7o8ii6lCYJY
	 Y6H0tikWV3jD9GwoI4TSiiNZ9csAG+YsIWE+t6+ZIdlzp7kuEtR266wTzCqIQqAtQu
	 COYWYI1JBsC1lQAi7W+AWY9s3LYYVXyOYx+eTFCALcPPPO8PUJMXvL5lOLqLRaid+k
	 N+8jb1/f9v7MQ==
From: Mark Brown <broonie@kernel.org>
To: lars@metafoo.de, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20250808061741.187414-1-chancel.liu@nxp.com>
References: <20250808061741.187414-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Add port_window_size to DAI dma
 data struct
Message-Id: <175499672288.16031.6836246064105850327.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 15:17:41 +0900, Chancel Liu wrote:
> The port_window_size is a struct member of dma slave channel runtime
> config. It's the length of the register area in words the data need to
> be accessed on the device side. It is only used for devices which is
> using an area instead of a single register to send or receive the data.
> Typically the DMA loops in this area in order to transfer the data.
> 
> It's useful for cases that reading/writing multiple registers in DMA
> transactions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dmaengine_pcm: Add port_window_size to DAI dma data struct
      commit: 32dffd4c3e3129e3d9bb378af8d80bb57dc3038b

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


