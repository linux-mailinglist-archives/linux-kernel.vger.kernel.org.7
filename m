Return-Path: <linux-kernel+bounces-802985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0BB45930
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D104DA64722
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33773570D4;
	Fri,  5 Sep 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/pY9Uon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312D3568F6;
	Fri,  5 Sep 2025 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079136; cv=none; b=KTgO8aJSpC4q6pp/Sk21IBvTDb7oB9PX0nqfJlwWRAyPT1jgbjUl3zQwpJbCMQ9TmgrzMfxTk/3WVaut1TKVccYRbTHec2EBqUh9PZ8fulj+Q9i7OCAU+150RQN4K52xdX+VAluv5U2sc/vwn6QcTTuya3t9f0mVGg61xO7qjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079136; c=relaxed/simple;
	bh=KkrwZDu1pRu7pLhJXpgsAxDu3nkp0f+KHpeyCCJvgR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SifQAoXGnWiRE8IUERGNic54O79LWjp6tjikeNGpC2TisiMbaGjB5YZBVuEHNU5K9CE+lrrWBNNeVqlpjPlgPWsxBF4IGeMtK4YIAhQdYm3E9MdKk6PFohP2H0zhALKO9dUNtGuGwx12LQZ9mPbvxm6rcQXj4CMnHqKGZ6gjMHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/pY9Uon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9E8C4CEF1;
	Fri,  5 Sep 2025 13:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757079135;
	bh=KkrwZDu1pRu7pLhJXpgsAxDu3nkp0f+KHpeyCCJvgR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=X/pY9UonwZj0XCbLcnOfTUAMg1P0UP6XUO2DdnscFTi2KFLAeZxzGGrquXuV39YOO
	 MTpn/CntE3rZ2so3PepY0r10UNFGhsqsR9IzTRSdFqZAQpGPN8+5Lsie4GnC7gJa/R
	 UU1lkRWrUWZgDMIskmOgrAAObghvmNK5iXiEAYYi1w9q+jELu+OLNHHEgejrZ+5YYn
	 B29BZpDFPiyjzazocMLVskpPY7wfUohDVmjwo3afW/K6HsC4SnNzzge2Ygcw0Tef1v
	 GKzCUM5DFRqFGv+5SXWq6yNt4Vfaackc6z4WSlAG/0h/j5IPmmiZ6XoUsJcetm3rBU
	 S6lfyf30fCGMg==
From: Mark Brown <broonie@kernel.org>
To: nick.li@foursemi.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Charles Han <hanchunchao@inspur.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905091845.1559-1-hanchunchao@inspur.com>
References: <20250905091845.1559-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] ASoC: codecs: fs210x: Add NULL check in
 fs210x_register_snd_component
Message-Id: <175707913385.96517.7750852185553922910.b4-ty@kernel.org>
Date: Fri, 05 Sep 2025 14:32:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Fri, 05 Sep 2025 17:18:44 +0800, Charles Han wrote:
> Add check for the return value of devm_kmemdup() to prevent
> potential null pointer dereference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: fs210x: Add NULL check in fs210x_register_snd_component
      commit: be585f7ebc99598edf97c3001d0f8d67954ab376

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


