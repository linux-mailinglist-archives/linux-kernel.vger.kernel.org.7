Return-Path: <linux-kernel+bounces-834050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29698BA3AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454463B1D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA252F616B;
	Fri, 26 Sep 2025 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiakMvoM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D182EC0AB;
	Fri, 26 Sep 2025 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891003; cv=none; b=TXLUom4b5fPYMcIr2cLl7IRygDgrNP5iAXazeECaH9u/W+HDVyCZGTNM42kIWI2O8oCq/N8KwPCo0E0KgLK5VwJSIQKqdfx8qiYjUPeU17OrZx9cvChJvjzQuEOx9DBStdIKYUC8NL/wGOL/krstJCaaGQmPT5yGzxxfTM0EllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891003; c=relaxed/simple;
	bh=+FntD5D+phS0YBxPxU6QJWpFdofG4rmVfhVcOMJIEYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HzURsxXnKBx6VaCq4yn4I/8pwGSlLzqvm/a31DXgjjh7irCy7UgCcWIt4zUveUe+iMFYoACH4AVjIwx9n5FkIA5q/UVnK+r94zYsveoeZwadTelR0oLdS62F/IIUvy7S2cF3A2lF8BKl7WiJ4LuleZ42iZF3gBH79iruSvsBUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiakMvoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FAC4CEF4;
	Fri, 26 Sep 2025 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891002;
	bh=+FntD5D+phS0YBxPxU6QJWpFdofG4rmVfhVcOMJIEYg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KiakMvoMejz3dsRFw2z5k9c0tYclLKa+ETP8FAog0cK1Rlvt9MtPHWM7CzhcpgQpJ
	 WG5ZthXXSiKP/Y6djv/m3AmCBQt1mjIz/DxbkmRAqv42w9zmPwrwCUgda/dJ5C6DA0
	 R/BphdHlL9qR2L3zy24pEWTeWV7FTVKb6HqGCmk5lqfoKjuW1y4XojGG7BKNgE1LbB
	 tQY0rTpOoQLBXL5+ffSbSTwhYr3Bu+/OsstAEYsn244WUOaQotvuhC8S24ZKyALJ7a
	 AmgIQFfiW33t35ko4+ZU+ar5gfu+WZ4SqGQ5Mq4dIyGTaSEMSK79Tbot/LaoocgbTe
	 TqAVe6OG91/7A==
From: Mark Brown <broonie@kernel.org>
To: kuninori.morimoto.gx@renesas.com, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250916123118.84175-1-olivier.moysan@foss.st.com>
References: <20250916123118.84175-1-olivier.moysan@foss.st.com>
Subject: Re: [PATCH] ASoC: stm32: sai: manage context in set_sysclk
 callback
Message-Id: <175889100028.84679.2534810503622402862.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 13:50:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 16 Sep 2025 14:31:18 +0200, Olivier Moysan wrote:
> The mclk direction now needs to be specified in endpoint node with
> "system-clock-direction-out" property. However some calls to the
> set_sysclk callback, related to CPU DAI clock, result in unbalanced
> calls to clock API.
> The set_sysclk callback in STM32 SAI driver is intended only for mclk
> management. So it is relevant to ensure that calls to set_sysclk are
> related to mclk only.
> Since the master clock is handled only at runtime, skip the calls to
> set_sysclk in the initialization phase.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stm32: sai: manage context in set_sysclk callback
      commit: 27fa1a8b2803dfd88c39f03b0969c55f667cdc43

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


