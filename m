Return-Path: <linux-kernel+bounces-764625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2682B22540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08073BDA17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AF2ED17C;
	Tue, 12 Aug 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyNLwKgH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E752C2ED168;
	Tue, 12 Aug 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996715; cv=none; b=IsF+owjQPh3ckbw3HWX9U9GzJ1FMj7yqaTmXAwbSfPLqP5ERIlmMBiL1aI57QPS33atIFD13OkNWnMGTKU1rplu928mrOCQw4GZINrufCOFnhJbQT8ZyhSWr42skTssxL35f6G2b0CJXTeXZBJQSgoP40/anUFawqAZu0Ps9gNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996715; c=relaxed/simple;
	bh=ZtB0xbJwwLQJziWmx00hAhoKzJKKlE5OcUVMmZEcRUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZniWT6cJ8tGjmy6EbK5PvwD4VEHzWGOIn40BRY6Ef+yQkz0OIvYGWRF6XGlVRTSsmRZqWJ50pa16cLK5utXFq39mMY4YeIDCfYPrn4m8BaYRnb1Bc2Vls5luMy7TAYMwgnEKmhnZu6AXW/ijo/C5Vj1tgdHWNk7o4X4RfJiCqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyNLwKgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A32C4CEF6;
	Tue, 12 Aug 2025 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996714;
	bh=ZtB0xbJwwLQJziWmx00hAhoKzJKKlE5OcUVMmZEcRUs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AyNLwKgH8aj3QeUFtKubNi5cEt6PbYcL51a/7lZsMRr8eEO0+tkKUyLKdZUV5lj0n
	 REJ4H4Wk8++tYDu7q7LFoCtrp2a9mDuZHSGFbZSBiYLzZDUFF7P9rm/whSfBxDiZbT
	 NkvxcaHi/riZpo2jSxGvwMAVeLwaV6yBuW5clzsOTD8UP0ELK1GSl0Gq6LyAxZA7DB
	 HjKTZzmG2i9J4q40sVijXi7D/jub5y0u74g7707SOxtUv/lY/zTN3qOOzAVHfpaAtz
	 Xjaw8uv7O+nTv0AJT6blI6yl+6TmAEdvYrvc4hYqf+zvUHafbey5Ypx5ria9Mz1NTB
	 +KQikEMQnHYLg==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808104943.829668-1-colin.i.king@gmail.com>
References: <20250808104943.829668-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: tas2781: Fix spelling mistake "dismatch"
 -> "mismatch"
Message-Id: <175499671247.16031.5935271982543013461.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 11:49:43 +0100, Colin Ian King wrote:
> There is a spelling mistake (or neologism of dis and match) in a
> dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix spelling mistake "dismatch" -> "mismatch"
      commit: b11f2a9745401d9ccc51c91b5482044d2ea936e8

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


