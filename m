Return-Path: <linux-kernel+bounces-820469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE91B80502
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40677A6152
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B66F246BAA;
	Wed, 17 Sep 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOZlVAcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58522B584;
	Wed, 17 Sep 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104515; cv=none; b=sVKE0B75O/z16Z6FK4/4TJiZ1oE6dzoXp1n2fUSvCFileMx3jH7Hf6AaH6CIDtfZuw4O+aI1VfLjGnpgSYJq2T2yWVGrjmfwqZ3XLMYv+rZm6q1S0A0VoW7l9CwOXSgDx+9oeJAuOwz1RxqLLIq33ekoyO5jX/ORKrsrdBkwEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104515; c=relaxed/simple;
	bh=Nd62Z2iipORCVee+BnJsYeZBwVapMFYaYM4aFFOumw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OdupJymD5tTWzVTRIi6iqTOXtoYGBZD3ap9T8cB9Zl7ovegIQlGfCh8cij9ZZy1RscU5BVtXHB4AnYTHfWTzmDjw08hM08vVCUJgKwY7oy7w9+dcYR0/aE/laAxR3EQl8ix4i1BX4ai04fT+BPsUFU7bSykmW06bkZaDkamWQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOZlVAcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F92C4CEF0;
	Wed, 17 Sep 2025 10:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104515;
	bh=Nd62Z2iipORCVee+BnJsYeZBwVapMFYaYM4aFFOumw4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OOZlVAcBziw9ybaQXQK2QAozQQWFy35iGkwDiqhBIypz32ICC2PFRDIjq5JxwNzXy
	 d+qcRR1eZj8WGe/NGY1ME+RxVX/nMw/puIO9o3x7FkAwqU2aCewkKMtiEhvHzlwpq6
	 PmH4Fomf4fNfdpwMkhqtMrbFGA6C5TIMovO4R1TPv0OV8P70Fj8ohszLZ/f0w9DJR5
	 qsoZWdS8rEFJnO0EEfuDDvb2qTBi/cDhq9t7hNkdKMFWO9lGXfkmEX0C9PqJ0nscGH
	 jyEzQg3tV0z6KV7Rpw/koZMSetQAS/3K0sx4E9gpsaPx+ORx24Cd6NpQBwfBr883dw
	 bDoT3JApEQmEA==
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
Message-Id: <175810451013.38693.6373740804764500004.b4-ty@kernel.org>
Date: Wed, 17 Sep 2025 11:21:50 +0100
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
      commit: 87c0881bd734a2cea12076716d5d9a050789d4b7
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


