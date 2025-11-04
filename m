Return-Path: <linux-kernel+bounces-885144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EDC321A6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C943A9DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E3334395;
	Tue,  4 Nov 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKczijxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E5257836
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274421; cv=none; b=iFbUAEdaj5ojlPmpaeLtSXF6lXDCSDhw6lhJ625rmXD5R0GFL6oXmvDQwk3kRLLSWbWvwxdNOCnMhVbD3j3DJwGKojWtewo38HDkYU13xWQn4mXGKEnP01XPCdwdVU0tl18FKgGZ4775/XrtsP4Zix9w5Z1QO2W0qBiLk6cFXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274421; c=relaxed/simple;
	bh=SwalMgwTsN4drFyR65KfoCUgj32WCsWo/6QcYqpfrEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kw42F689C0g2L9NKrdkn/Tjs5XctVWzyst4AUsy/5M8odgzJrexWEWaJg4gk/n/MqFJ2g8bcm0T9FskKcEE45UJ1ij7jkoFKcWVJW+0yh+DJL4XFlANtHthSisZgMoZh4V2kJKqHJ6XMjvL/fVwFXR13qnQ7sFOzC2o2z+Gv2GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKczijxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87B6C116B1;
	Tue,  4 Nov 2025 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274421;
	bh=SwalMgwTsN4drFyR65KfoCUgj32WCsWo/6QcYqpfrEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hKczijxI27dHyHTKCPA4Gq3RKoD6o7H0Yp8mOZeebImQkLkRFfmy+t1WKA1RUVyLb
	 jPjgZqzOhwDAyHqy12Yv5poQM5EBLphKV6Dxtcq2LEkzVVkdUgAvqoNkLM+8ATKSro
	 mB4GXRs0xVssHQkx7+sT7g6lB/T3UHZom3KGmOGd89Qv7qPAmAuDUEjEhpSYQjENsh
	 RuPkAdkwtHzK0T5obaAWvmG7pFtXRMYhgjRNDPnGJiJuXFOTO1uEqPCz9ZgFYLuuvb
	 jB+mPFgZcoZyNAxy6BInEVti7ofC6gaLHuaBSmfvY9Db20aMLU6Nh4+mZFY2HBBgAy
	 mFuaoYpZI9Wow==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20251103180946.604127-1-andriy.shevchenko@linux.intel.com>
References: <20251103180946.604127-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regmap: i3c: Use ARRAY_SIZE()
Message-Id: <176227441953.2243216.10902481289354105588.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 16:40:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 03 Nov 2025 19:09:46 +0100, Andy Shevchenko wrote:
> Use ARRAY_SIZE() instead of hard coded numbers to show the intention
> and make code robust against potential changes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: i3c: Use ARRAY_SIZE()
      commit: af9c8092d84244ca54ffb590435735f788e7a170

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


