Return-Path: <linux-kernel+bounces-873957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59467C152BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2FB426808
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A983375DD;
	Tue, 28 Oct 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AieJl+W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F23218845;
	Tue, 28 Oct 2025 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661637; cv=none; b=gligrLst8KRgMKN0lO+l2X9pcFNImxy+gW4tjCPR4AOUoX8EA1rzvQthvloFwlNKR6q9mtzAagpBAwYwjbdOcvdILS/IUBlgPWzhPrROT4yN6RsZdBRLjpn9MrfA1qKkVBLeS5XU6KgeuSjDf/6t6dmQ+N+yrH5GAP+7TGrYk40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661637; c=relaxed/simple;
	bh=ShczIjFONgRVfNlzBrQWzTLdiQoG+N1oAqDWcV7g6SM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l+J2iWSR8iutxrAdLRM/cHm7+NtejDJajjWAxtEwzYXrbG2WoRU6j/IuJTfTSSDrtwFRNhG+viufpY4zOVktTcqy6rDfchGGkuU5mtxfJillr1FbQENMpE7RFiveEJIgipWKnJt9H0MKXMUhd8WqdqVq8yonQUJjVCeCVb7x4Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AieJl+W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1D0C4CEE7;
	Tue, 28 Oct 2025 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761661637;
	bh=ShczIjFONgRVfNlzBrQWzTLdiQoG+N1oAqDWcV7g6SM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AieJl+W4lybtToMBXywZ25N0n1fx6kwTw9cEa3tZ40psF1iKhkQfTtIAXTnRvXztX
	 Zu9UvQ3Qv15njSTETDwh1gZxuit3CdwFL2nIrx122iNF4T9yftIOrRhWdNbb21vsWG
	 zH9rPsopSp27q846j194dy1i3mz9Hw3qglPCUwr4QF55ho1d1Ura+4E5cKfiSgM0AO
	 6UygGgRkoXBDHy0LH/4yja08jilBALDS3l1PJMuywkeJByog0sydxQo8XAvtru7M6A
	 B0PA8vMNdrMCZDmH+PkjZR/QjzPvp7ru4Es7OjHdZ6Gwd0wjJiqOJ/XVJjJnzaGa9G
	 rRqIq/p9i5x/g==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Yixun Lan <dlan@gentoo.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>
References: <20251024-fix-k1-i2s-dai-mem-v1-1-15f5f1ec294a@linux.spacemit.com>
Subject: Re: [PATCH] ASoC: spacemit: add failure check for
 spacemit_i2s_init_dai()
Message-Id: <176166163539.85877.12634117063779900411.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 14:27:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 24 Oct 2025 21:11:01 +0800, Troy Mitchell wrote:
> Add error handling when memory allocation for dai fails in
> spacemit_i2s_init_dai() call.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: spacemit: add failure check for spacemit_i2s_init_dai()
      commit: f034c16a4663eaf3198dc18b201ba50533fb5b81

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


