Return-Path: <linux-kernel+bounces-744713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4710B11024
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF281894F08
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73DF2EA758;
	Thu, 24 Jul 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itqFIX4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7471F4C8E;
	Thu, 24 Jul 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376672; cv=none; b=higyQCS5lxHFdT/UpaxMW1OufaMpN3jycWbUYndr7nUFkl+KcxWkEefJ+P/mm8Gj1UBJJVMYs9Ap4Mcc6w/hX04kV5bPYHoPgUinWEgtohmj9wgWvqXavZdYaClUryz2rsm+hEFBXX0UyosMjKcJY5fJt/eGYa0r2xuis+f1/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376672; c=relaxed/simple;
	bh=U+0rvQ84awdqFheOuteiFw5I2gmq5D+RPMO+eWRXsh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BfqfrLIm8Wh7v62ghi0ogYNf1rKhiT+eGRzWNRMZI5pC5TXzxn8ocNtVx+dQBHDv6DaHXDenCZ+K/V+i4JVNMxFotQ2L+hPsFmrzVYHgDEvyQj/kJpLRNUlp9IuZBQ1sGkjKT9ZvEfGDWdNfvBrkDkAqPLkzoonBQx3lS6vkOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itqFIX4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE9DC4CEED;
	Thu, 24 Jul 2025 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376671;
	bh=U+0rvQ84awdqFheOuteiFw5I2gmq5D+RPMO+eWRXsh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=itqFIX4xyeQbvY0RocGmKZUH6o48Jv7V9vuVZEYex5sAV6HESn6hbQlvfJQw3TT+K
	 /qvYaXHbl8y40VTe6qLiyuK6/z9wbcaBXgivrvNCWAAsXbn5lC73FBhMABwl9Eu3IC
	 0atseEvjxoYsbNgqcb46a2QyOmFuk+XNiay2U3azwSHW7EhNY3mhaxZ1JGtsguCmQe
	 qMg7CBpoxkL+NUILMczj9pgTCcZkf5WNMhhIu1eSWQxIanOravX7NWMZ3hBrZKmIqo
	 jB7AsNZZHFfME/AjRc+SV3cGUJtz1uB75/+NFRx7skZ+h1GXGZoJZGMc7qT2IkmkRH
	 B6lIxA0F1eqJQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724113113.143009-1-colin.i.king@gmail.com>
References: <20250724113113.143009-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: Kconfig: Fix spelling mistake
 "regualtor" -> "regulator"
Message-Id: <175337667057.99258.13351649490095530063.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 18:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 24 Jul 2025 12:31:12 +0100, Colin Ian King wrote:
> There is a spelling mistake in the REGULATOR_RT4803 config. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Kconfig: Fix spelling mistake "regualtor" -> "regulator"
      commit: 71d141edbfa3e0a213c537e979790835550270d6

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


