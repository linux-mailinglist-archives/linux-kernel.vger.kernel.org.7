Return-Path: <linux-kernel+bounces-871565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97738C0D989
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F0BE34DE41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CE30E0E3;
	Mon, 27 Oct 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUkKMtA1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB8311C20;
	Mon, 27 Oct 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568628; cv=none; b=ImmS9xvimLXYLcgMJtdVfdt+PZ7jYIzK+zZgUnv2ghgr9eWC6ifFoLPHi5sPLjdJp67nrcoRb8kp/mJK45Hu4Azv16yenPh2UynuOyBaPoN4yPJhxZgGpb03s/EVqfb/QunDiK5uZAsLpioe6z08lm01Fa0kskkXBb+0Slt+HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568628; c=relaxed/simple;
	bh=O7wPv4QpTRw78qivSWIaU96EqkWfkdAYzMszaHVERm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tzlz2j949IR02Y44o0Z2C1u1EDvtzBk9L/KBUPTh3qW8Es6z5+kqFlbj3p+uovUdn3b9bozC5foCj3QSCtF0bdYw+viXulamVbFGbJfaDw95GgSU5KKLRr+InfYqz5k96S9+zd1J1kXcR7J3ZSrtTbAJ6NHJo91Lmr/0Jpdksv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUkKMtA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E2C4CEF1;
	Mon, 27 Oct 2025 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761568627;
	bh=O7wPv4QpTRw78qivSWIaU96EqkWfkdAYzMszaHVERm4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TUkKMtA1UWpAOfIwCQWcAE20v1PJ11TY2O4atvut12Bj3GR9sqpzLjkH0FzI8MTdt
	 6E5zjBvpchZ9HuqQhuwOgF9iRHWOp2TchvnH2lnJLrKbrRrCQajCGIaVBe3hhBi4Ly
	 2uP0bRRMDHO3yYeO5cWxxu9Cxk76joo/rkJ6/QYSCAyKpaKGga0pdNgZV6rW9tq3QF
	 i0hxzOX26y02bMLuu9F1ISjeS19L4w/mn7no23gzPJSbPyo70Yq9K0Igqm00CfJv3e
	 oZlQcHHFkTlmZIO6H9/dYgOK2rTNuXvLSYAN8T+9TKrrtWWf14lSxtlQ6Mr30lFiNE
	 pVYnkRWOdnRIQ==
From: Mark Brown <broonie@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20251020170440.585-1-vulab@iscas.ac.cn>
References: <20251020170440.585-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: mediatek: Fix double pm_runtime_disable in
 remove functions
Message-Id: <176156862550.24382.7526074553836824881.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 12:37:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 21 Oct 2025 01:04:40 +0800, Haotian Zhang wrote:
> Both mt8195-afe-pcm and mt8365-afe-pcm drivers use devm_pm_runtime_enable()
> in probe function, which automatically calls pm_runtime_disable() on device
> removal via devres mechanism. However, the remove callbacks explicitly call
> pm_runtime_disable() again, resulting in double pm_runtime_disable() calls.
> 
> Fix by removing the redundant pm_runtime_disable() calls from remove
> functions, letting the devres framework handle it automatically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Fix double pm_runtime_disable in remove functions
      commit: 79a6f2da168543c0431ade57428f673c19c5b72f

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


