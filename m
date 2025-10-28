Return-Path: <linux-kernel+bounces-874277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B998AC15EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0510D1A609D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F337345745;
	Tue, 28 Oct 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGz1sjsP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B36D33C528;
	Tue, 28 Oct 2025 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669760; cv=none; b=rc4bpDvLKMpjXS+qtd3sRzMjx/rd4LytqdP1JmxxyJnPbOHxQ4zF2DMR63k6K9ClmjMzDQQ0mrAcYbmHgwBIgbN/aAVzw0shHyTVYrmINgvwy4gTSkEW1OIGgTsEt9PscHLd1UmfjJn8yuGkaV+Ds7VyjAnyPKEMw6P9pZT6H5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669760; c=relaxed/simple;
	bh=hZ3gnF5i4eT8ptp4+qQqGEWxVx7X7XqSJUbf0+1+MjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S2KynwGbxgXDbukGgwaeJ1tciE7TUow8YDt+3lQrRtFo+1wQl7eb9OgPka8Qp4j6o81DqziLgEXQzLbumiAtEbE/b2baAru4+6KNF10uB7kQmnmBIaCVwbqInlDPv8HN2ZOlZcCNMs5JsFjOYanwtQhexvpQJiMLprFMiOGo/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGz1sjsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E651AC4CEE7;
	Tue, 28 Oct 2025 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761669760;
	bh=hZ3gnF5i4eT8ptp4+qQqGEWxVx7X7XqSJUbf0+1+MjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KGz1sjsPJdGZeaXD2tDxhhqsJW194IcRDCErKAPdaYC2a+LgWeruZPsql3j/Qey/r
	 GY71GEOdnxbWDZdKvMhlrvaVbfBAMObvtg+7bffBGLxfQ4cJOE4YP9Tg0SHRqUE/gB
	 67FEP/nUSS7WAIHSTPSrj4Y4qLu6SPkcKV8JY2I+vWxfvoDdDxOM0X4MfKnhHJnLGe
	 oY1FPp4J2ExmluTsIq/46gNwboL+JWt0SAtMmwpYk6SrGAxvbSOL40P8rAnjOAILWM
	 xcGpRmcacGRls66gLE3tzIJtEijttMME/SL5Fo6ukxzuvxYEk0yJK2khM2IkTH32Am
	 JEM7Vg9Biq6lQ==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Zidan Wang <zidan.wang@freescale.com>, 
 Maarten Zanders <maarten@zanders.be>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024135716.584265-1-maarten@zanders.be>
References: <20251024135716.584265-1-maarten@zanders.be>
Subject: Re: [PATCH] ASoC: fsl_sai: Fix sync error in consumer mode
Message-Id: <176166975766.152863.14270477182475254035.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 16:42:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Fri, 24 Oct 2025 15:57:15 +0200, Maarten Zanders wrote:
> When configured for default synchronisation (Rx syncs to Tx) and the
> SAI operates in consumer mode (clocks provided externally to Tx), a
> synchronisation error occurs on Tx on the first attempt after device
> initialisation when the playback stream is started while a capture
> stream is already active. This results in channel shift/swap on the
> playback stream.
> Subsequent streams (ie after that first failing one) always work
> correctly, no matter the order, with or without the other stream active.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Fix sync error in consumer mode
      commit: b2dd1d0d322dce5f331961c927e775b84014d5ab

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


