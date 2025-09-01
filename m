Return-Path: <linux-kernel+bounces-795369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF5B3F0E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AA0206C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B44284892;
	Mon,  1 Sep 2025 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzSkoxwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C627F017;
	Mon,  1 Sep 2025 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764917; cv=none; b=tcaPzBvj1/ZSBPOL6FeJflwGso2+c9zbJAIRB0IdPXXBCjw0vTzZq6IE1pKNaX+HzZ+OsAxWK6DkgPrORpZSFflYuj1fZg52KtNWo+hBFTEDp/6hnjkUlKmCE/wvu/BwvxQFBf5OFT50bArHwvRKxZ9bAWr2MUASsT9mLVJ5EeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764917; c=relaxed/simple;
	bh=8uAKWbLvP1JhsUUPjrpM3S120Et8nLPU32AZnH1mpuw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EHTdGTS1CeSst3WvAiZgxDnHOZIFi5FHFuwLhRGfeONuGtthnzvBB9sm0OpbK8nHNvOqEUS8TqjjhWh0qtSxRk1yWiUnA7dPcoTPPeI6H0Kii9/GAGDgodgDvlB3U/XHtA8sfxx++QntfjxwKpIbH90G/2pBaXEZiHSWi1/vjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzSkoxwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710C6C4CEF0;
	Mon,  1 Sep 2025 22:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756764917;
	bh=8uAKWbLvP1JhsUUPjrpM3S120Et8nLPU32AZnH1mpuw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=TzSkoxwZfGvW1SDB4X8VCWoZN5VQVEks9sWvRhg3kaR83tYDuOrwBuoHLkjGeo5kF
	 /aTaGkLYjkRtxFKzdijJ3UHxkBXMclitlaOpini/sjpH44cW/qVD8gic5ncADQlFIm
	 Spe7agkHqvjipAU33fA7wVFBZQZ2KyVDPFC/T5RogjKylCNc2sdeQSNQ1BRZwzFJ9W
	 +8RWGGeF+bL/eGD7rdnFneFE9H8bW2Bt1pmS1RF2HNxJSMoV81EtkoVvfSsF0cUz3N
	 joZSd4cX2iiad/TNVYkdRJakTuojDnEUpvo9FAtx55o3FN2zmhx/6oY3oI2g17p2ks
	 nyxo6OvdrsLEA==
From: Mark Brown <broonie@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250829101411.625214-1-rongqianfeng@vivo.com>
References: <20250829101411.625214-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] regulator: scmi: Use int type to store negative error
 codes
Message-Id: <175676491502.901001.14592841978206903121.b4-ty@kernel.org>
Date: Mon, 01 Sep 2025 23:15:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 29 Aug 2025 18:14:11 +0800, Qianfeng Rong wrote:
> Change the 'ret' variable from u32 to int to store negative error codes or
> zero returned by of_property_read_u32().
> 
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but it's ugly as pants. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
> flag is enabled.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: scmi: Use int type to store negative error codes
      commit: 9d35d068fb138160709e04e3ee97fe29a6f8615b

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


