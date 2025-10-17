Return-Path: <linux-kernel+bounces-857944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85229BE84E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90161AA466D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1748339B35;
	Fri, 17 Oct 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3IHctU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25574343D71;
	Fri, 17 Oct 2025 11:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700268; cv=none; b=n+WKVyj03vWRlJauEY5fu9M0DhZlwoMohrgR2F+cQBxX1UW61hWrZkAmPyvRKhfiGmFrbjAAH9u8AVB//A2U6VYul1ak6MA93z81Dd0vyj278+jFTI0FEu16W6AKoaYn8NtAk6bAxtGhSn1fbpMjzlETYXQQQV6CWKjS5kG4yMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700268; c=relaxed/simple;
	bh=uizEfJyKmrp+Hym2bNGCOmbLlAj0EhRNyc4xPm5CS58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=seF++Jy9q2h3n+SCanNSCUB2O6acBQvUmcWb3KE+Mn/6aK/8MKcHSL/RyqxLZcqv2hWTCc2BqGy6vcFJ4DNhU52WkimRbYvF2mThy3Pxk3JmvQF47/A4hnHA4e8s6MEsh+C00pisAdxUXd/liSqW7FDlbSGxuDZP1MJ0BgYkABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3IHctU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8EEC4CEE7;
	Fri, 17 Oct 2025 11:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700267;
	bh=uizEfJyKmrp+Hym2bNGCOmbLlAj0EhRNyc4xPm5CS58=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n3IHctU1fkY35YgudySB6oRO6gocv/D0Mi/hoXDibrlZO7IkVHFaTW1Gq0kEWWamv
	 1LOcbGIizWRtdWQfIMWHdHK7gMKGluLvGqrBiUX1JhTHW4c3m+IGWtTTiWb+Mo8vsY
	 gKkc3R3CiT2DEMTtW2EUS1U7WvKhv4a0FIFKF+9gamazzi3EidR9nyzbXPXzXTDZ5w
	 fSIYGs8NhCySeyWpRscA7rjnEbjVtolR+NC+Dj3s2k7YvdhVUnnpKIc7jaqI1gx4Yo
	 SyZUDzSVTcXL6WKiithTUKNsBu1pYfHHIVfeQJqn8sjFhmuEPAsRqK+9YSNRlvd3rN
	 hJ+YHg33nhKKQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Fabio Estevam <festevam@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Takashi Iwai <tiwai@suse.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org
In-Reply-To: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
References: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
Subject: Re: (subset) [RESEND PATCH 1/3] ASoC: mxs-saif: support usage with
 simple-audio-card
Message-Id: <176070026206.36020.13915370894346909307.b4-ty@kernel.org>
Date: Fri, 17 Oct 2025 12:24:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Wed, 24 Sep 2025 15:07:44 +0200, Dario Binacchi wrote:
> Add support for enabling MCLK output when using the simple-audio-card
> driver. In the sound/soc/mxs/mxs-sgtl5000.c use case, that driver
> handles MCLK enable/disable by calling mxs_saif_get_mclk() and
> mxs_saif_put_mclk() at probe/remove. This does not happen when the
> simple-audio-card driver is used. Extend the mxs-saif driver to enable
> MCLK output in that scenario.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: mxs-saif: support usage with simple-audio-card
      commit: 1e570e77392f43a3cdab2849d1f81535f8a033e2

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


