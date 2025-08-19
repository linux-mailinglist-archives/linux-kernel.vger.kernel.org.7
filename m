Return-Path: <linux-kernel+bounces-776438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04849B2CD40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268782A49BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38483431E9;
	Tue, 19 Aug 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu7qeIZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833F2EB5DA;
	Tue, 19 Aug 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632837; cv=none; b=BQMm28R5gCSDs7IXxUDr19XKLNBkDVU1/gpAMMSXskIx1Wox/ev7mlA1gDZ+6r+ysv0jDaJhpTrqKhFlcbzTNoT/EPivPoGWY9zrcxCuY9jANQVoOcgfeGnAzEnY0JH8/zY9JOnvxXub5GpqJpuJyUrmqJ/wFy9mGoDCMZuZ/Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632837; c=relaxed/simple;
	bh=Z8qE2F3rmXbSXXoNfWP6xJI7G8PJwKKptIt9dhYBL2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rR0dKz/L5VNi8lGzwoYbY/OYFzh/5VgZb7QvBVZLmEoPcL0yamnwLTva2PGWQ2zKZPm067Dd5atk0LCbgEWWhU5VJPRZ5+Wiu9oz6HT7bjALZC9CKtnjXpCfrIrgVJU1mB/rph77lzArwQtFj/TBP9/aUbHMGIC3qXfBdK4WAfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu7qeIZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5D0C116B1;
	Tue, 19 Aug 2025 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755632836;
	bh=Z8qE2F3rmXbSXXoNfWP6xJI7G8PJwKKptIt9dhYBL2w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Gu7qeIZdyru6IHiUiXz96K8UtZwUP3MQlMjeU+RMVvDbq1WUoZJQq63DE82H53SXd
	 p25GePng99AR6iuQbeyC3cr740xS7RGPejCb3cj+NarIZZBtBAi/2JaVRjqPglLCPu
	 r4Zw+o2oru6G+SOCzWT3Gmo+YcSZo1TFtC/fS/uahovTSMbcqCZRckwcf/2yZPCb2c
	 Zc4hmdu7KIiM4QOI9GO3xeK7R9DIDHrD+t7Yd9ws/8mfPOgPKLkq9LqKQyq52zt9ZC
	 RnoA+hgXDonz52yYwhg9G/TtuGqoX9qhOxdoHT4trrDHewYbgfZb13WQbt7cbe65Bs
	 1Y8ngy/hXE4zA==
From: Mark Brown <broonie@kernel.org>
To: Jeff Chang <jeff_chang@richtek.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aKMc1oK-7yY4cD3K@stanley.mountain>
References: <aKMc1oK-7yY4cD3K@stanley.mountain>
Subject: Re: [PATCH v2 next] regulator: rt5133: Fix IS_ERR() vs NULL bug in
 rt5133_validate_vendor_info()
Message-Id: <175563283571.270234.2902521984259478827.b4-ty@kernel.org>
Date: Tue, 19 Aug 2025 20:47:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 18 Aug 2025 15:30:14 +0300, Dan Carpenter wrote:
> The "priv->cdata" pointer isn't an error pointer; this should be a NULL
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


