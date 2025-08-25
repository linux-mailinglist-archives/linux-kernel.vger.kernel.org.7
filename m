Return-Path: <linux-kernel+bounces-785482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923ECB34B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DD44241F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB72286417;
	Mon, 25 Aug 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRb9+8Gb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E032877C7;
	Mon, 25 Aug 2025 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152269; cv=none; b=LrLKlFoysyHOfiwpqZjqHZUJChd3sLShZDcBV2WJNZBkLQHddLiGU5PYXPdvVjtXol4wYS1pd1/nVhgafC0DxG+OJ8wETx2b9ts91uC5b7/K9Ua/bG4I4c5LSBECimJ8KQk8eTNfH1Zcvot1MMRAW99fYcqyK3jgiU/1rM/GSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152269; c=relaxed/simple;
	bh=OB6kFuj6GvVQGzt10o/kddzzei92yd1h3z6/meVJtoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JbyUo7cUPDk2IEFXcoiKaKnt54Ty09SQ2Fij0HoWh6/oIjpd7mkX/BE+xPmhO9HHHVmn5zE3CcFhOeH4tlQwlZOnIDj+aAvbRRSqbIqd6LLgHsl/xYSjfaxoeiSAZLjijAE1WvcyLBx4niPjBjkoC2pX4MkXWwNtrLLQRXVBHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRb9+8Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D718DC113D0;
	Mon, 25 Aug 2025 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152269;
	bh=OB6kFuj6GvVQGzt10o/kddzzei92yd1h3z6/meVJtoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PRb9+8GbIP12gHXsvaNk4yX9v+MiCQI89IgFxXX3qFzsBC40aCYNMyOI/dTl0pPZJ
	 HJAetTRIuBjwIbAm25ZeKmV8X0YNxLnlYngA97Tt+LuorTSZkdiDErbjdIAlWr8Vb9
	 2WLpqj3hYzCBbEU34Ud+xe4XmW5tbSRcuIGHp/LG2ZJhsn8pIKLTU+x3M/mr7UNUJc
	 4YDdh5t95ZA7NZhpAbyste/3RxfUYqbNtLx2Lqoabriv5p7rs414HTdSIB0lH49g3H
	 9jE2hoyQMW+TBwtXSFnP1xmNeHNmUpwEw8ngQTC8dLi05xWOu7kG5eyg2y6u4zy0Hv
	 UvFtZGHpbK+aA==
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com
In-Reply-To: <20250822-idt821034-v1-1-e2bfffbde56f@uniontech.com>
References: <20250822-idt821034-v1-1-e2bfffbde56f@uniontech.com>
Subject: Re: [PATCH] ASoC: codecs: idt821034: fix wrong log in
 idt821034_chip_direction_output()
Message-Id: <175615226389.226187.9381064853664088480.b4-ty@kernel.org>
Date: Mon, 25 Aug 2025 21:04:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Fri, 22 Aug 2025 18:28:33 +0800, Cryolitia PukNgae wrote:
> Change `dir in` to `dir out`
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: idt821034: fix wrong log in idt821034_chip_direction_output()
      commit: b1c99d5bd24ce0a1193d8476d83bf8c8bc633266

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


