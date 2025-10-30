Return-Path: <linux-kernel+bounces-878713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C702C2151A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2127561C47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81842741AC;
	Thu, 30 Oct 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6qVH5W5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B9264F9C;
	Thu, 30 Oct 2025 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843012; cv=none; b=PamIKfj9MGeQce/QwPaSa897Ykh0w1GyIXaqo8k8MM59DfEbzFuRefHPK2wd3VN0DRbk1L3/uA09moLS7t3/0Ch2cwESS5FQMj6FXvHE1VPboqCeptvcz9IVMxlEra3BR5olq/2oQ5nrmIEpy8FqhTMPhQolvWeOpgzqB0hi1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843012; c=relaxed/simple;
	bh=2AgScSgFG6KmiHrgMKTGpPXiiYnevIIc9U4Q25rTP9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o38tCV3LUkoh2fVVIzbFjJNaFgT8eOOu1pomX+RjpCNtXVWWVJtsNFvP8n33VoKQ17WgINGo+E2DFNvh7BX4qFJxqAtB1Ylzo18tPvgUAzQyL4yz8xwyW58ULwKVs3/hyEcmsbrO3b3SUg1g1UbOBw6Yq/kgu5R28s1fk4IqpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6qVH5W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B0DC4CEF1;
	Thu, 30 Oct 2025 16:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761843011;
	bh=2AgScSgFG6KmiHrgMKTGpPXiiYnevIIc9U4Q25rTP9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h6qVH5W5vYLUQDpex+WP8aa3elxFOZ/pMFQRACcr8YqVvfQF42fTV+kZRY2GtQTbG
	 2HsODoHVhydin98rNGobOTPkyt/cQGCgjxhkfDD83QTbmzNfEII83SKUw4dV6eE0Ky
	 mmaZ87HWaRpqp+wHeZxLfP6AyE4V18YJwkw/06/iJZf71ylXS47VLy7cbHdIfZKg8z
	 y/VAcr3H7QgU3NTXHdoUmDJvmqN5LYWPwbNdEv+/XVySnh0Fyulf54SrHBjDvvOsEg
	 RR0Z0MTQCpcolhN1aAWUkLFk47wbn/ipemYmrDdJRz73jFDAiVuzs3IFqRyubWo9zq
	 BCyVIhaPypN2Q==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, Axel Lin <axel.lin@ingics.com>, 
 Brian Austin <brian.austin@cirrus.com>, 
 Herve Codina <herve.codina@bootlin.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20251029093921.624088-1-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
Subject: Re: (subset) [PATCH v2 0/4] Add support for an external Master
 Clock in the Cirrus CS4271 codec
Message-Id: <176184300823.119935.16469243761262240818.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 16:50:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 29 Oct 2025 10:39:16 +0100, Herve Codina wrote:
> The Cirrus CS4271 codec can have its Master Clock provided by an
> external clock when no crystal is used.
> 
> This series adds support for this external Master clock.
> 
> The first patch in the series is not related to the clock but fixes an
> issue related to module loading and MODULE_DEVICE_TABLE() due to a
> driver split between i2c part and spi part.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/4] ASoC: cs4271: Disable regulators in component_probe() error path
      commit: 1e5351ba60f5355809f30c61bbd27e97611d2be9
[3/4] ASoC: dt-bindings: cirrus,cs4271: Document mclk clock
      commit: 3cd523ba270665861647304aa30500f238ebf26e
[4/4] ASoC: cs4271: Add support for the external mclk
      commit: cf6bf51b53252284bafc7377a4d8dbf10f048b4d

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


