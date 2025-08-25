Return-Path: <linux-kernel+bounces-785652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D3B34F11
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C2B16D71B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3978522128B;
	Mon, 25 Aug 2025 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rR//IVir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F422BD59C;
	Mon, 25 Aug 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161072; cv=none; b=UB7uL5ic8+wIcHCnQmDJAKNegHJMhJZKxEMkgemdcxQm27bkEqtysQ8eBHoEOHZjIiXssuayliox4nSqVkTdRD7/VMJRC6njiff/hxSOV9DsEh1El0W+56r6h/soLkxbMRK/wU2pzpkwFDjn3nBk3YZAmgNiSWN9+i7BS9lJLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161072; c=relaxed/simple;
	bh=K1DkR1nYObRfAayoPYDMGwSRljtof412ye+04a+YIf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RCQbjjYsEX3TwFN/G3FI9LN0RuJMk2+259Ci1+x9X+sZnR2D4MegziJXW2fiSo+zyh6nwLzjUvlBSDXXmNuVJSkea0hCTxf8qf3ITOnjsfVLPi4YOmKNLkxqQO8ECbSM9KWke0gIlKj+3N5fMQFf2ZecYaqANdizeiO8+9jQZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rR//IVir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34040C4CEED;
	Mon, 25 Aug 2025 22:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756161071;
	bh=K1DkR1nYObRfAayoPYDMGwSRljtof412ye+04a+YIf4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rR//IVirdMjmQr0o2wYCPpGz44IsQz1DB1lmxB0IXz5ygGgkmCC0FStU0bxDlF0DF
	 q8IbeFayMfgnRjqtuOEeWluNS4Zwmfz9vGw1RXzd240KHmDgG1BhdpKUsXVChiioUS
	 S0f9Ssf68Hb6dVIGfynPesdzbZ4XRu5DhkArgTDuXPGj8kzuiAO3e1QnOtUXlpc06t
	 sf/YFdK1d8r605jxsNr/cCWhwaS1xkerolzBNQZKo1FK2ASMDSF6UaFg+CpjTezcbG
	 NSs8NcVva/n9fS+dRtn7tYo24vip+fmNojbOMysnV4kGmb1D9zYaMjzlFVhELlNzWW
	 TJph4TKu61MzQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825121139.2150099-1-alexander.stein@ew.tq-group.com>
References: <20250825121139.2150099-1-alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 1/1] ASoC: tlv320aic32x4: use dev_err_probe() for
 regulators
Message-Id: <175616106888.240045.14722462456328491850.b4-ty@kernel.org>
Date: Mon, 25 Aug 2025 23:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Mon, 25 Aug 2025 14:11:38 +0200, Alexander Stein wrote:
> Avoid error messages like the following when the regulators have not
> been probed yet:
> 
>     tlv320aic32x4 0-0018: Missing supply 'iov'
>     tlv320aic32x4 0-0018: Failed to setup regulators
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic32x4: use dev_err_probe() for regulators
      commit: a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c

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


