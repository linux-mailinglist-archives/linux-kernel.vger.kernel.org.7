Return-Path: <linux-kernel+bounces-884810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C2C3136E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718913BAD86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E8322A25;
	Tue,  4 Nov 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnCXXcRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC1B2F5A1D;
	Tue,  4 Nov 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262692; cv=none; b=LOwd9Qhb4fxNctC5VqBnbkFuu9XT6IQXwXOYd2wc+XNX079Cq/iKUo0BmnLZARWK0zo0GA1+EaTxq/OrjvN/RiDVKnhuZJt5oklMXLYHYNcnrPQ5rFnt0Sl6I+Bw+0+4iaZuMxR5xs22TxMnhwuHA8j1ESCn7ZPXaph/yVDi5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262692; c=relaxed/simple;
	bh=x/y6OaG9xHkSJZaW7FMFYnfJAOlbtuz3tWlpugfVLqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R7lT+Nsmpbds7GasltVsZe4aVADzEhobm229DA4LEETIz1bUNQZfMeQ+lnVQdD8jHj0N7Lat6BujxvpBgkS1tMXc+fds23KEJ1CGjB7eIeiWffyrwyNWaanu4ReaJToIfQ0PmGYeIto1t6wUf/M/Ccve6DKyLmu/Gm78ofOFZaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnCXXcRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E0CC116C6;
	Tue,  4 Nov 2025 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262692;
	bh=x/y6OaG9xHkSJZaW7FMFYnfJAOlbtuz3tWlpugfVLqs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fnCXXcRVQi0lwsprNaQMabJ6PZlgtJdYWwJWP/MyTKX+M3cYv2yQS9wecYGtDrPbh
	 RMYhW+bMiu9Lxo/npATCv7c/HRkFe5xPc8/Uo0BuuoRWXNCKzQ2CjDCe7xbKNzeXvA
	 R0F/ez+ZKVAsg93W9Fw9wG9/uSV7gK5EN+xYqP2EDY15wxPkBvlRYVzCqgWFa1mwzh
	 qfRW3AhMWBHTOe9Kp4M9e30Y2EuVLiRcGB6HC5Vd65DPy17Vk1RM3lYRovXmmNSSso
	 dODyB1+K+q0ECqG6E6HiIWucfB9N0QuCPhYDuFHoGUzJy2TXvofGAjoQ0bWovoD3DX
	 OHpI3EbGjl92g==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20251103115809.33953-1-rf@opensource.cirrus.com>
References: <20251103115809.33953-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: doc: cs35l56: Update firmware filename
 description for B0 silicon
Message-Id: <176226269039.2215600.18188322802573336046.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:24:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 03 Nov 2025 11:58:09 +0000, Richard Fitzgerald wrote:
> Update the text for firmware file naming to show that the l?u? suffix is
> supported on CS35L56 B0 silicon and ampN was only used on early firmware.
> 
> The previous version of this text only said that B0 silicon used the ampN
> suffix. Since kernel 6.16 the driver supports both the old ampN and
> new l?u? suffix for B0 silicon. New firmwares will use the l?u? suffix.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: doc: cs35l56: Update firmware filename description for B0 silicon
      commit: 8da0efc3da9312b65f5cbf06e57d284f69222b2e

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


