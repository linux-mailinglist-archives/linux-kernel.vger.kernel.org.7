Return-Path: <linux-kernel+bounces-824426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE05B892D6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74691BC2AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CC13093DE;
	Fri, 19 Sep 2025 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGeLMXoD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF619755B;
	Fri, 19 Sep 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279801; cv=none; b=DEul/z9ycy7bEutv+Ek80TTr8YMt93gT8lWJSTMmQaaQPiSOrsL3bcJ7+i8fUmSU3kE1ztAyvgK/5tfw5fK4XWyb6Jh4vUWEOdJQvlqYGrDLTIUAIXyLuHeuelKsQTGq7+AZNL2ZwniYLJiVF7cVs/ckmBT39lbY99nH1fMNalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279801; c=relaxed/simple;
	bh=/SMfYBD9o53+oBR5Fb0Sh6Q3hjzWJCSrQeWD4NzwKs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KBj6iIwrMk9uFDKb0sDygkwVGrSPs6P3g3ul6vGpTL/JE0++1Zil/qFYYFolWuPo0XJVvCK40bxA0AYL4SFWJ4ouT1fphfyHA9mRvWzL5MZVsWBPy/jf3ICEayr2ZNuevVI1WoKEb+sZhoEq6wLW6OFOjYH6rYKf+0cO4pTfSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGeLMXoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22896C4CEF0;
	Fri, 19 Sep 2025 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279801;
	bh=/SMfYBD9o53+oBR5Fb0Sh6Q3hjzWJCSrQeWD4NzwKs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fGeLMXoDiHe4erpsBlR6ur/37nSbWWsPlYLwtqvvskQug3OBxLs93dRmzJ2p/azvz
	 Iyh1OWok4YsmbWtrktldGqdgVdsYc+XIgz3zsTetyuVRupYXbF2QwY4lnahycDN3CK
	 1S2tG/APIVPKHGhWQrUErsztRSA7GypaWaDYoRIb5TpsS0CKCgusdKn0Y099SXKQdK
	 /4o90AIe1NyXa3h68oPRzR9agELAoDGlUTAOcTU3Pgk+cXG+CXxC4Cl9r5TdGROtGX
	 6o9qH+5wU0dxFtgQ8DaUr1xw+UAcviAZN79XmhnyG8PlTYtjGBEZihdPagL139haW3
	 tCQEG9MC2fnUg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
In-Reply-To: <20250910-v6-12-topic-pcm1754-v2-0-0917dbe73c65@pengutronix.de>
References: <20250910-v6-12-topic-pcm1754-v2-0-0917dbe73c65@pengutronix.de>
Subject: Re: [PATCH v2 0/2] ASoC: codecs: pcm1754: add pcm1754 dac driver
Message-Id: <175827979786.43708.15817637781655085954.b4-ty@kernel.org>
Date: Fri, 19 Sep 2025 12:03:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 10 Sep 2025 11:34:04 +0200, Stefan Kerkmann wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: ti,pcm1754: add binding documentation
      (no commit info)
[2/2] ASoC: codecs: pcm1754: add pcm1754 dac driver
      commit: 5b65120115420b1b7132c2aafbfe1a54120cbfb7

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


