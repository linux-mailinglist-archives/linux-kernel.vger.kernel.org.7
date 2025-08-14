Return-Path: <linux-kernel+bounces-769044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561E6B26948
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C23A2839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A0218EA8;
	Thu, 14 Aug 2025 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS/34ryV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD92135D1;
	Thu, 14 Aug 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181121; cv=none; b=R8uo3TQcQBZwvbIT7TSmFZli5bps1x/lf0+TbBQ+VGeOHpTfNL9Bn3c4CNowp76+8rIaCtjjZx3Up0jBkB2W9fNE/lFclr0Y0SACSFpyvsvtw6AXVFxaKdtCebjMda7QE+h9XPPCZh+onvUfIzrRiuiJDsfQXrXT63oyqqZVDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181121; c=relaxed/simple;
	bh=ezT8h19tbrErhEX74K5EDIS1DVgKzjeCE9jYx/GAjfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tNJxXsnp4Oe/+SLv7VR28K0H/otA/0ySdv075M/4sbuFD/qBN6i0rN1k1MFm1lp6mq/Fk44IxWBmT/G8L+4We9e6848d4rUvYQesDi3n8mikfKvirEDdWOPj3VHiEYKXsXUO/3dH1567RE9u+OehaOhLNi8jbef9ZGgkFWyprfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS/34ryV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B0EC4CEEF;
	Thu, 14 Aug 2025 14:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755181120;
	bh=ezT8h19tbrErhEX74K5EDIS1DVgKzjeCE9jYx/GAjfA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YS/34ryVn84cNOohcF2crew00cdL4+AySZDS67orfKzZ6wPYwxb0VXm+90fsXs7wa
	 ro6h1JrAYglyF4hkd8C9yjlSkSPfRn1axNtKDNEefAsGZsDafSLEPwvrXMQnCWCd6e
	 uIl81Ky+eHTwQU6A4WozPX249myuEg4QaD3WPPN5QArwvUFu9q9Zvn1ebIzmeOLNLl
	 NzKiy0gsJyTXbS02VwxHGQBgbQlwOMnpoqbbRBVp6quESoH0IMmriHX1TGOJoHJiWK
	 +skeBwsrltkLQGXOZ8mbi3QBpUWFYCyzkN/+L9SkF7teg6fjKRSFfhAmIddmCyfD96
	 2uWcuvB3zImWg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250814012652.81424-1-shimrrashai@gmail.com>
References: <20250814012652.81424-1-shimrrashai@gmail.com>
Subject: Re: (subset) [PATCH 0/2] ASoC: es8323: Playback enablement for
 Firefly ITX-3588J and similar hardware
Message-Id: <175518111895.47921.9144261888630473273.b4-ty@kernel.org>
Date: Thu, 14 Aug 2025 15:18:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 20:26:49 -0500, Shimrra Shai wrote:
> This small pair of patches is needed to enable the audio output to
> speaker using the ES8323 CODEC on boards like the Firefly ITX-3588J
> that use the right-hand DAC mixer to connect the line out jack. I also
> enable associated DAPM power widgets so that the volume can be
> controlled in the ALSA mixer. This seems sufficient to me to produce
> basic audio functionality on this board and any others that might use
> the same features. I tested it with both ear buds and a pair of
> speakers plugged into the green jack on the back of the board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: es8323: enable DAPM power widgets for playback DAC and output
      commit: 258384d8ce365dddd6c5c15204de8ccd53a7ab0a

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


