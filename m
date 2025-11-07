Return-Path: <linux-kernel+bounces-890063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E101EC3F2E1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D859D188E77C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B393043D7;
	Fri,  7 Nov 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxDD8XJ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC062F6574;
	Fri,  7 Nov 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508063; cv=none; b=s8lprEALasMyQYmyeaLK9xFCVGT+ph1FJX9v5c/VBLbYhNebRLLi2EEXLRsxsZ8a5bRwHlkuqTQ65hb+LtuKDkqgF9MzNkRDOMUsl+oNWV46l3/Jc/Ryy+OURlSvt/mjn1iPTIK5hTRaEZUTZoWGKMggGMpxT7vpf+kU7rBdBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508063; c=relaxed/simple;
	bh=b8R1CDSDpojhuYBWHDM+d1NPiz/Bo7/dWl4kOM7jZfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CdnbymLvlKSBg1AwUQdLnbGwOaT9TQ7VhxgXBOxaOzOaCsgLYcHjJ5r7EJp8VgDSOGA0irkIgY8YSQLBBBFOARLFf35B9c0/e+KvJPmdAPrBOtUaGgJErGpBj2vPOhKy/GHTDB0X7ezMhjMi8iCqawsk6DEs8eXMReg8xH+RKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxDD8XJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B2EC4CEF8;
	Fri,  7 Nov 2025 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762508060;
	bh=b8R1CDSDpojhuYBWHDM+d1NPiz/Bo7/dWl4kOM7jZfc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mxDD8XJ5tfK0QAmAnM+hfakfmYb7I5LqEWpL22jUZZXhSravEg9Apis4S7hrrX1MM
	 Ry9nH+dI2jK+iU56vZU6U0P4+UuKh2CfxrKxLJEIGeW9Rr06yScfN+ro/w9ikNUWEo
	 KQJy3mEjBaJnGBJolu3ufIW1926nnrp2cU886rGBwx00Py44L6jua20TL0VsOX8XfO
	 ZH2/qTTFgqopxmADiYFVxtRPNkaJ4TYFXzDDhNlT6viDr0nSEzcYQ61QZvKcv/3UN7
	 mZmcRVa+CJezDNOjrLjKU3GfeVDsg/QJWCh1iNKPz3QXdRCL6VI5ekYsICe07OyjB+
	 yRdQPUpTHSlHA==
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251106-restricted-pointers-stm-v1-1-7d03eb5020ba@linutronix.de>
References: <20251106-restricted-pointers-stm-v1-1-7d03eb5020ba@linutronix.de>
Subject: Re: [PATCH] ASoC: stm32: dfsdm: don't use %pK through printk
Message-Id: <176250805658.2488867.15310894982146426101.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 09:34:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 15:41:57 +0100, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: dfsdm: don't use %pK through printk
      commit: 4db4ce15706d6423cc4cac4b05114b0469507bad

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


