Return-Path: <linux-kernel+bounces-889559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 268F4C3DE77
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2C5134E902
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE1B3570B6;
	Thu,  6 Nov 2025 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU/DJAcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD23563FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473266; cv=none; b=e5m7YbQnkEhCGBH0cbQaDwU983A6YqybJAGcHvM2RcoWtAoMfMchqV4mfJEllIJruk5w+9QlxdD3ZyRkWhNZz/7rgukzLI7QM7q5WH+9aVZtJ8xJR2hLENbrm4lgqZYprUaFP039vKbvf2SzNY5VqfhvBTjxB8g8uqyAG7pStWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473266; c=relaxed/simple;
	bh=17wuiMQ0Wz8tvMq96C3IgMgGNA7iqNHbdsOknaX12ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZQ2JudivRpX7u2CP2KlqaR4zJkujKlYSPz+Q7MpO+wJK0lm6yEYHSLNxbL7d8XJhdMwcmOEuwcnQtgIZZRVdkEJn8xMfWeirHYA9dK8VISznHjP1owf2f48C81W8lw0hQAQ1pSvHvMZkgP12qD8SJ90Ff9QQ44fl0xxuwxCyAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU/DJAcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07FBC116C6;
	Thu,  6 Nov 2025 23:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473265;
	bh=17wuiMQ0Wz8tvMq96C3IgMgGNA7iqNHbdsOknaX12ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VU/DJAcjcUstnUWlQYyck9RmqJ7lkKV0h2tWrxw8Vw2emkfuPIM0h11M6mKAmmxbj
	 62aTot5CWuZwc7Y6HCStgwSMsbF0ZPLHzq3oCSbdHviPbDoKBk/xSjpGxzSHsGBlXR
	 5HZPz4w7rEXLO2sAsBE/OLJ0JL2FQvpEwq8b7tjUcyig/DGuFxnFFubD352Ot3R8kk
	 7awMPPB8AlqBrD62fCMPOenYfYWynkEAsFy6isbjAFdZ9moLmFq3XkSUKHvEIS/daf
	 orLdxGW+Z42m3rcO8OaZKpu/QQMuwpKXojSGzBw1BP735tw7C0Pvt6j+6kJYd2ua7S
	 vMNJJto+eXa/w==
From: Mark Brown <broonie@kernel.org>
To: Joy Zou <joy.zou@nxp.com>, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20251106114628.2302762-1-andriy.shevchenko@linux.intel.com>
References: <20251106114628.2302762-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] regulator: pf9453: Fix kernel doc for
 mux_poll()
Message-Id: <176247326348.2483095.9073583896607784960.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Thu, 06 Nov 2025 12:46:28 +0100, Andy Shevchenko wrote:
> The validator is not happy:
> 
> Warning: drivers/regulator/pf9453-regulator.c:303 This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> Update the kernel-doc accordingly.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pf9453: Fix kernel doc for mux_poll()
      commit: 6bd1ad97eb790570c167d4de4ca59fbc9c33722a

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


