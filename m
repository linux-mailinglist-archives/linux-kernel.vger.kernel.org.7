Return-Path: <linux-kernel+bounces-891104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B8C41D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49100351AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DD274B58;
	Fri,  7 Nov 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsG3/6Xc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54913C3F2;
	Fri,  7 Nov 2025 22:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555538; cv=none; b=V9PGZ3Wthxq1S0k9TsljeCBllkZMEkdTTgbsSduqp5xPvghkBm9vq4U3nayO1+lqtOIawgpdjQJwfO6OiZwV1tbofzUMH12fk6d79yAFItcfA+LxKmjWXUguKLBq8lw1Y2vf/HtetjFdxkFmbrgGjcKJ0U24tEi1YkXl4szj7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555538; c=relaxed/simple;
	bh=4NhVZb6Y4xV1OI1gCriwzDPSSVGfwl3eziXRpOpYORI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EboFVRBSvqibKyyYclYpWrOAFbQ47qrY9qicZsYqv7XiQUb8UcqKlzVZS7V7Ym+H89JSBP92gPMUKFjetHVce7jGR5IqUrc13FOdEsSML07IevFPEi7tjlhlHZ4wh5Lw1f0mJWO0g26Ljcl/nmxPBngMCE6+lU2JEmIgTJZlk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsG3/6Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E40C4CEF7;
	Fri,  7 Nov 2025 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762555537;
	bh=4NhVZb6Y4xV1OI1gCriwzDPSSVGfwl3eziXRpOpYORI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RsG3/6Xcu/5NyljkojM4Jo3lZjmedJemXUOrIsmnt75yqLmg3Y3RpBmaN4tjH393B
	 PSYkR3VUZbfDJrB6AKnc9/ZUVIO3PYrM9l8FNa1xid1azScfY9hkdP4GlG6vidV+vA
	 HzSmiTJ+jT8zTJobnLwJmbAwhha1L01GMMsOX2CVqeQq+hXgF9LVRakDHCmwSKC/hh
	 qxX/+2eE/sPlUQsL/GOVqdG3AtyukzLyiTE/FI2Sj0qOFJHPsxwixPbuc6JHZ8amcn
	 z8Gu04JNUMowQeX513y/AE1FCL4bgJL5bQDJ3wBmZpaZMLkltPOpJid/jtERIuA69V
	 AehlLdI9tfGCg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Yixun Lan <dlan@gentoo.org>, 
 Goko Mell <goku.sonxin626@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20251106-spacemit-i2s-fix-v1-1-ee2cedcdda23@gmail.com>
References: <20251106-spacemit-i2s-fix-v1-1-ee2cedcdda23@gmail.com>
Subject: Re: [PATCH] ASoC: spacemit: fix incorrect error check for sspa
 clock
Message-Id: <176255553448.22450.112199071517900868.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 22:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 00:03:16 +0800, Goko Mell wrote:
> Fix a wrong IS_ERR() check in spacemit_i2s_probe() where `clk` was used
> instead of `i2s->sspa_clk`.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: spacemit: fix incorrect error check for sspa clock
      commit: e32c402533cc68abe20fcf3246b9ff53e1f96021

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


