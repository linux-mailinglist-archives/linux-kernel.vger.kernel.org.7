Return-Path: <linux-kernel+bounces-767405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F0B253E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF821C25FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D22F999F;
	Wed, 13 Aug 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IheAlBBI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2482F9982;
	Wed, 13 Aug 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112958; cv=none; b=sMJ0+YV+HjlhfFDmefpuDjQzBa8vRByoa5U2YdLWixPh2mJei/7twtgQFl33Lmw5rjoR/vUBu0TFbmY2V2q4OtzyiPZbPxuWXE2r8e9TMErNYs8195XBSUrhYU3PTqub6dWIN+pr89FQQAAvhU3fK6WleTBXlVNPBc4AUrEbU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112958; c=relaxed/simple;
	bh=N477yPAUgF8MFDSi5oZ2xy5+NriyaZW/5Ft0lXfFS6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tr4WAUzFhfoJinsmIOntj2KjwKyzFphWT24v2WFxZwDxMC5dCjoNA6Ji7UpANOVI5ri7Om8kjbYgLywkERfmaAZIjZr1lZOnh2f+hAAWxdWccPIOnKQrUdMabK3vgt6ZDTQ65A3WdGeRIkcxFe5D8qEryaBxC6YHmO/Qvvwi2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IheAlBBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577B0C4CEEB;
	Wed, 13 Aug 2025 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755112957;
	bh=N477yPAUgF8MFDSi5oZ2xy5+NriyaZW/5Ft0lXfFS6Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IheAlBBIQ2Bt+CcdnxUFDJSj2gXEDefMs+XsgEE9N6Y7yBu0Nv5mj9qbxNsshF6QQ
	 Y1vQB3DWs+KMaZnajrrrq2CzT6s40dejdd7D9ok5zgISoO7dOBqAlKHY5WArlFW8Mn
	 Rb4xQESpYfHP+rUhzQjpScWPSkgmoaC571N4HTfNCBYaaXn3EqCrRwCEiGcSdpu1Tf
	 akFZy6tccfWufnGlQvXMmfWkIsatrUjjjh/JlFUTUThMpEXzfyOoQUPq1bqI6/p4YI
	 wJVkE8y/Oke8jyVdAfTBBYslChMgHuPBRgCpWNStuJuFgzKykTqzT3q56hRM3fp6DZ
	 mmOdd0TYoKq4Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812203356.735234-1-robh@kernel.org>
References: <20250812203356.735234-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Convert brcm,bcm2835-i2s to DT
 schema
Message-Id: <175511295510.250237.5224980225208974771.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 20:22:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 12 Aug 2025 15:33:55 -0500, Rob Herring (Arm) wrote:
> Convert the Broadcom BCM2835 I2S/PCM binding to DT schema format. It's a
> straightforward conversion.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Convert brcm,bcm2835-i2s to DT schema
      commit: bab4ab484a6ca170847da9bffe86f1fa90df4bbe

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


