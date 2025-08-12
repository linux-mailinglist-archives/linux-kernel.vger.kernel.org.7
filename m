Return-Path: <linux-kernel+bounces-764620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287AB22537
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B52502486
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70642EBB9E;
	Tue, 12 Aug 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gklnfuVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DD2E336B;
	Tue, 12 Aug 2025 11:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996697; cv=none; b=jIzjm+/L7Jkg9g3RGvHUbAGhhv2nSJzx6sD8dFT90XkHtywTP6dhQgLgeSOELZU4ZN6ZRAH64wXuR7lTQbdYy+q/X7OB+5VQ9XEQQcwC35JSN+si3uKXKCLHKvCWQsZrbtx3QnhtNUd0yFrE/yfKPkiy1CRy+cElgBLZfUyYG/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996697; c=relaxed/simple;
	bh=RRxOCBSxXivjCJkND/Xi61rfzI5zyvHNSkj8HZo57fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TLI0+VjMJ7vU5agB9k5+sfi5b4xFuuFHbAJTd67KlkD3bxp7Awg/UHjpY5eXkhajKE2H6jZp2OfDtOXv7Exw/YLakztfhmV7pciVCRMvvWcy9efcg03smz2vv+seETXqc09oF7yTh10IHn8X3G/GLwWfKw5Xh36ThAb1Df0djEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gklnfuVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9917C4CEF0;
	Tue, 12 Aug 2025 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996696;
	bh=RRxOCBSxXivjCJkND/Xi61rfzI5zyvHNSkj8HZo57fo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gklnfuVwqJ3+JsA3f24CArOMkooYeMIKHjlDkJqkKeJEt02h/O/5zYiP+K+hFaTko
	 4lzn8pyvTIvMHAZ9+Jh8Y57BGs7xGNhZrvyYaZ0i0R65FJqByZdB0I0u/8LHikGvud
	 53gPJARQMCSzmk/R7C9XsucJFW3ZfXHJLMWr2sr16D7hPsQaBzImrOa7TAagnqQdaa
	 yWoUrhpgyXtbjypMev30B5+Wfutsc0JtPGExclDxBiwXoSH5mod/Wsc31T8HK6P72s
	 aWGYYF6KEB6Vf8FfcPXxZpfuXeLlrSQoNJvCpZxKFIHpUjhq5NwW1H6IZ3L6L4imUG
	 7JniHLhNU2u2w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Terry Cheong <htcheong@chromium.org>
Cc: Baili Deng <bailideng@google.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20250723-mtk-hdmi-v1-1-4ff945eb6136@chromium.org>
References: <20250723-mtk-hdmi-v1-1-4ff945eb6136@chromium.org>
Subject: Re: [PATCH] ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks
Message-Id: <175499669456.16031.8547433353849911809.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:04:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 23 Jul 2025 17:20:11 +0800, Terry Cheong wrote:
> The SND_JACK_AVOUT is a more specific jack type for HDMI and DisplayPort.
> Updatae the MediaTek drivers to use such jack type, allowing system to
> determine the device type based on jack event.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: Use SND_JACK_AVOUT for HDMI/DP jacks
      commit: 8ed2dca4df2297177e0edcb7e0c72ef87f3fd81a

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


