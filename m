Return-Path: <linux-kernel+bounces-844557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35261BC2363
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8D4E59D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA12E8897;
	Tue,  7 Oct 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ0EwbfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84628F5;
	Tue,  7 Oct 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856602; cv=none; b=VrVZWdAEAWVxKBXLbU9U0aLXzVDzCvdQxAouw/4OsMdOe34eLrc+0wt8XdKP9wRoquCliWcC/EJ4AV15rUovaAohHd3nb+WWElaXDzcHMycGEgC9MkyyE4QNyXi3RLmUYEJgNfVC4+XTHwiNi8CxNUcx++EeYfkmtwFkHieM+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856602; c=relaxed/simple;
	bh=/pSQNfp/NoybqW59QlXQrWZnpCKQXoNs3vgFg+pkIaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pjaVLVDx54lEdmjqVWCF1p4Qw4hzADcn1hB33SqamWXyDI6JBxu1XeFD/QqQjTUgnFPOcWmpN4zue7lmPXy2K5ZfmlhQX586mHhsoggDElwvKsfI8/7fhYTbwD/jVZHCqC0ATIcABB38Ngv/8RdIDD1a02YGkG5ZKyw60yrNB20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ0EwbfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9B5C4CEF7;
	Tue,  7 Oct 2025 17:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759856602;
	bh=/pSQNfp/NoybqW59QlXQrWZnpCKQXoNs3vgFg+pkIaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kJ0EwbfZh6hA4LkGyNhay0l2/t3gpMYISrJvJOXSwiCYtGyauST1J4a8Fh2rmVqQp
	 wTbaUcG0VjlIphJVstEii87typHLD4ne3Jj/sMTxos/potZRu2dr6bm+jhFxNQhamm
	 1cANhRm63DawqftB+Hz2DjK6gmvslPkzm3xawjzUxcw37tEIMFEUuG1hLW5NH+Qt8+
	 RY8ZQUNMDpgEMJnkPi0WZcmoL50ra6rbB46E3ChCiTckzfBgYV90AzfUra1Jj3CeR8
	 I1WAfwHvnDFvNLdqt8rGRJUEoCoQyUrZMR3UTZWH68SaDS8IosFAFJSCgemR4U/U8D
	 DgKIlQk8gBM8w==
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Valerio Setti <vsetti@baylibre.com>
Cc: linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251007-fix-i2s-polarity-v1-1-86704d9cda10@baylibre.com>
References: <20251007-fix-i2s-polarity-v1-1-86704d9cda10@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: aiu-encoder-i2s: fix bit clock polarity
Message-Id: <175985659977.122025.13786700969734596641.b4-ty@kernel.org>
Date: Tue, 07 Oct 2025 18:03:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 07 Oct 2025 00:12:19 +0200, Valerio Setti wrote:
> According to I2S specs audio data is sampled on the rising edge of the
> clock and it can change on the falling one. When operating in normal mode
> this SoC behaves the opposite so a clock polarity inversion is required
> in this case.
> 
> This was tested on an OdroidC2 (Amlogic S905 SoC) board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: aiu-encoder-i2s: fix bit clock polarity
      commit: 4c4ed5e073a923fb3323022e1131cb51ad8df7a0

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


