Return-Path: <linux-kernel+bounces-776437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A528B2CD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDAA681A87
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB9A342C8A;
	Tue, 19 Aug 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUgPkTLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5178246761;
	Tue, 19 Aug 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632837; cv=none; b=gNVBbwpwDwB0MaJT7u9ju9AqlMJpSkNc6wlxza9mb5mGIzkHMmNSdwKQxA7uXUOaw1JVfKby2lqbGG9q5TvQSt0EAHSTadpiLivajVgPzejIq80CRzArGvlQ3u3/EMeCqSmSd4QuICFkMFC2t7p7XGxzCNfLp3WyGE7Vq1kX5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632837; c=relaxed/simple;
	bh=RiZoOTbNQTvUEdVGRrPrO9QAwy/KWTo+SLu1NdYq5AM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NoHJSkUEyqqrXGLBV5qlmHVeoPQ45sTBq3kAF0sGOi5d0na1wP8xH5uUgqO69Lpi2togaShe9+b8v6WIJ4LgUqie3GabttwqAnSPCMHQHJG1nSxlzwbtMXciAoTi+R9AOIjo1JC1+kmeHqmcW/SRw1gzl70+TW5v//oyJJK2PM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUgPkTLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F601C4CEF1;
	Tue, 19 Aug 2025 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632835;
	bh=RiZoOTbNQTvUEdVGRrPrO9QAwy/KWTo+SLu1NdYq5AM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OUgPkTLUY8vxNNnfV7bBrenBJdVINXUkY5iZzsdvpBpE+/xI6Ml9/Sfghyi6Yi729
	 APqToy0ysfMFFGYIHUybGVDgjQUvEU4pXWDxHGX4kXBFAQ9FTCiPTzRAXoEaOZXg7g
	 TqaAWkXDBsJEdWUxQjIkVnPu5PlptgjAy6BWKAGLz9UENNt8rH6X9eFjLvyHpqLqjg
	 Cy23EAvB+fc/DpA1joZXyn21Bg+5iYE7/bC022/wc/9tNo8wnmgPRsmi1fkkDb91+w
	 uDV4s9gjwsBG3r8OPEhqZQdfbNvB3FplmpyXPzPjRghsp4Xx/xl/2Bu1Vm6KDbeB4b
	 NiXJZ2gMsZpGg==
From: Mark Brown <broonie@kernel.org>
To: Jeff Chang <jeff_chang@richtek.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aJ7YivhlWlE6ifw1@stanley.mountain>
References: <aJ7YivhlWlE6ifw1@stanley.mountain>
Subject: Re: [PATCH next] regulator: rt5133: Fix IS_ERR() vs NULL bug in
 rt5133_validate_vendor_info()
Message-Id: <175563283433.270234.3651916456363956419.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 20:47:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 15 Aug 2025 09:49:46 +0300, Dan Carpenter wrote:
> The "priv->cdata" pointer isn't an error pointer, it should be a NULL
> check instead.  Otherwise it leads to a NULL pointer dereference in the
> caller, rt5133_probe().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5133: Fix IS_ERR() vs NULL bug in rt5133_validate_vendor_info()
      commit: f7f804633c91f0fbf03eefbae39eec2205191a82

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


