Return-Path: <linux-kernel+bounces-764626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E844FB22542
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501C11666BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342E2ED867;
	Tue, 12 Aug 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ2VPTqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB82ED84A;
	Tue, 12 Aug 2025 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996716; cv=none; b=tob2W4elrWJ9/jeZhhJ8HTepS2PJS6rpQn/G8IYLelkkfzfyomwBmq0v/TNTkaZgbflM4DO21rkfDafgO1e54Us3YqpnQBnDv3VGntdDDN/B8JcXUdQBuuR5CLZhzcpVVEtCrrl7pQ+fMpTcnn5o+bmpXrIQzI7CigZ12odAK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996716; c=relaxed/simple;
	bh=monQS/bBsO+zloi354aBN64+Vd/5AGOSf1IPrG09B3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P0+8rCa6Hj+m53I4dYzhDmm+CzdFNcCgfk1eGYQXqzGGcSdfWesnRhLORR6P3FOezS93DR1cfiecuk8fKI+DYYZD8vchzGDhgv0wH36Uh4We2E5d9TLiuaTbwCKyhC6B3xcBe/My8GXwUIHVz+X6yXNSeLQmtnDBKLgwqOLK02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ2VPTqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9BDC4CEF4;
	Tue, 12 Aug 2025 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996716;
	bh=monQS/bBsO+zloi354aBN64+Vd/5AGOSf1IPrG09B3k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tJ2VPTqwYVSum/d78kBYM9Fjjws8h3KKjTa+BCj3mGHsAbHYTl0sElXUakVZqEwUX
	 kJTw+0GwvEpJl7fjGQxF57TSvcTreWPv2egKoQGaKD92CZqNi/uANQEj6s/q18Karu
	 MbKbblxCJ5o4E7je0ee85lFDfN+b4vnacRP9oH/PrbtoA6moQYFxH+9E8S4tEaK915
	 GbfhGVUNq/5LZN1FECLWQYJ4iL3rYKAv9t3kY5uxMJtgIyZ9U7BVNEl6htJnYWrN+j
	 0jlrENfXsKF+VgPzocVWLriYiC7YEiDIP5wewuVv6BPS1vycy6+5siyvXlA4dRRGq2
	 AAHDbqW96SPwg==
From: Mark Brown <broonie@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808105324.829883-1-colin.i.king@gmail.com>
References: <20250808105324.829883-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: codec: sma1307: replace spelling mistake
 with new error message
Message-Id: <175499671464.16031.7233223998422787112.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 08 Aug 2025 11:53:24 +0100, Colin Ian King wrote:
> There is a spelling mistake in a failure message, replace the
> message with something a little more meaningful.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: sma1307: replace spelling mistake with new error message
      commit: 7cdadac0d2b3614d04651be7104a89a1998efec0

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


