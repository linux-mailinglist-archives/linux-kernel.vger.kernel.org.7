Return-Path: <linux-kernel+bounces-776114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F11C9B2C8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809B618889C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01528750D;
	Tue, 19 Aug 2025 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nC1swosM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0026E707
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618657; cv=none; b=XeFVKV13q0+UNf9dfm8TX+USiD4kzAXnSlcLC8hjNzyPb5XR1heX61wXk1LoCqvmy+KDcjv/6ff2cexaedcAUFkKyjmyL5TNPtU1KzyWLgMn5UHr0yuq6GKY/av4iS/2Pvgj/Rd/2MwtplWf6UtKy8FEzW1ayd117TmE0XvpgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618657; c=relaxed/simple;
	bh=8oW4UFQtycNaw9lp8sdZpMFAIc8C4ZLfUw6PhINERRA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fi9rShofsLzGKVdgcO+BUiZCrTekU3Y3Gosrmu3ZIarqNyIa1Uyk3cLqdAgnvD/2ePGzJVXKwue/mM1dy4oETrav9J0gTZBjySOHUSy/mQuVgDuACAo6mwUDu/LFNnul6v20hukbv2lIFgav0Hscs5bLWVn4sbtWXhElTLy+Wyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nC1swosM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB2C4CEF1;
	Tue, 19 Aug 2025 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755618657;
	bh=8oW4UFQtycNaw9lp8sdZpMFAIc8C4ZLfUw6PhINERRA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=nC1swosMJfFQ8jo7qXKeUaZtGg7ZDGv8nMFaB9NIrfBAev1FrfX/bIQaqbFPhvj09
	 akxc5Slge6WM9xtWAdD/jMpsZlto8+FbcwHgRZ17m47nJLw1DOO69AgclIi0R9YJaG
	 pDg6hEZC5iEVvr1GXgc34A6f4DjUs4XdZEDE6ebshVBxkNOD1UEL+APgPCN15B2PnA
	 TV9oNEVD/4OXXRb8YxCTcxBa+kX76tdd7V3w+dFGiot1kIyEQSplZz0gxVKD3/MTbe
	 LqxzTchvkBk+jrk6tW387ykD8eRe+pTSlWbQ5Pa2xhnByec+ku9qhdxjocWmKXFyGG
	 2hho47qJMl3Hw==
From: Mark Brown <broonie@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250817142327.174531-1-rongqianfeng@vivo.com>
References: <20250817142327.174531-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] regulator: bd718x7: Use kcalloc() instead of kzalloc()
Message-Id: <175561865630.183354.7456857095894517337.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 16:50:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 17 Aug 2025 22:23:27 +0800, Qianfeng Rong wrote:
> Replace calls of 'devm_kzalloc(dev, count * sizeof([type]), flags)'
> with 'devm_kcalloc(dev, count, sizeof([type]), flags)' in
> setup_feedback_loop() for safer memory allocation with built-in
> overflow protection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: bd718x7: Use kcalloc() instead of kzalloc()
      commit: 550bc517e59347b3b1af7d290eac4fb1411a3d4e

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


