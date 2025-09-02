Return-Path: <linux-kernel+bounces-796311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E177B3FED7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A2616ADEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8144F3002C3;
	Tue,  2 Sep 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWPZ53QN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5313009DC;
	Tue,  2 Sep 2025 11:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813873; cv=none; b=ID4es0Yi/vmnC1a8kzA7HfsbGVAbpmqW/OiSV5dS3/TSTDPtKovs5fwFhnre6s72aqj1PbS4xhms3RbB1x18ZIr0moIn1sL7gZ/RXbeXDKXG2KBC5oUxqP8XBbJCWK7/rihsBtC32ta1assBY9AKTdA2sFJHjwIisHzIwUihnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813873; c=relaxed/simple;
	bh=xbwszAwF5EtwUlULoGHA6xFuTP3hkuTUDEmkG/8psjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2SkJv6z244hXmsVJe+bWdF8o37De5jmePsLbiBlfPY1mrOKtKrIid78tZE5yl84yq1p34HFu5T6qoVucbepGyfQfnj3rNbHtLGMDIZ70Ek2HyKY5oM+Ti4J6/JvvLUvRqbDVApHktPazQBi8zeBObwGMLdYBKvW8EJXvluJOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWPZ53QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5298EC4CEED;
	Tue,  2 Sep 2025 11:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813872;
	bh=xbwszAwF5EtwUlULoGHA6xFuTP3hkuTUDEmkG/8psjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LWPZ53QNI0f91n2vDCuq6Tq/WSJdEx8fcbdOAxOw8uv3+gIR8sWsHlxssleXh2xvK
	 1Rme8UrCQ675NkgMsfaKEAYmWrJPTVtrElLIcaLywabZTUpvSaVbaMUgV0334NdViH
	 c81z5hEHCk5qJEZm6q5Mnjd55H/hRWqhFEhdpEFiyxRzH9rI443tBkNcaMNwe2iAlT
	 icUGEfpeBNUERHI2xJrwPmvrtpowDkmejofrVOyUz3UKJ0g5uzTFXy0NSiGtCq8cgB
	 v8vNF1v+5SloBsygWZro9oWGuPNH/ih+zrv6t3PdTFASeDeJIicgSY6ZmdhGba3ijN
	 J3zgPslzZfMTQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20250821054606.1279178-1-venkataprasad.potturu@amd.com>
References: <20250821054606.1279178-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH v2] ASoC: amd: acp: Adjust pdm gain value
Message-Id: <175681387008.70970.2403265736805266274.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 12:51:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 21 Aug 2025 11:15:47 +0530, Venkata Prasad Potturu wrote:
> Set pdm gain value by setting PDM_MISC_CTRL_MASK value.
> To avoid low pdm gain value.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: Adjust pdm gain value
      commit: f1d0260362d72f9f454dc1f9db2eeb80cb801f28

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


