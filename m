Return-Path: <linux-kernel+bounces-854225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C12BDDDC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8E519C08BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152E31B81E;
	Wed, 15 Oct 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTeK69x6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A50331B808;
	Wed, 15 Oct 2025 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521793; cv=none; b=F97nRc2GH1FsGwxsKEhkYhi2QliHqI8HAcmR1QbBn40LAD4V+L4gsAE6pIQYY3VF0Id8kIUGFDBBgDc+GeUH9doJjE9IEJVh0ET+RCZjcbc3FH1bpjZ/gWX9YBph+jzZbcJwechmXV1Fzzoo26JT9LiCHRkWltTLbrIuE+y9N9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521793; c=relaxed/simple;
	bh=pBp/QyOGmP5rArjDtS4MzOlQfCPMlfzP91YadPYMuT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A/ZjfVhXYjmAXQzz41CmzGNDNSqhWHDBgkqDWtBysGxCEuKfHITUTx+24nIlFcRHl95D1Z6lwWjKmgpX0GybnwDHKVezsM/ChuInwRx5c6pa71xh1C4iIyCl7hMFNdjszn//vuf5LIpsivnnlcDXj53ySjYFRXqmeX5mpYuH15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTeK69x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C40C4CEFE;
	Wed, 15 Oct 2025 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521793;
	bh=pBp/QyOGmP5rArjDtS4MzOlQfCPMlfzP91YadPYMuT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mTeK69x6/13KL3cFADBj3yurhZkD05UtW1MD+To/Vr8hno5fqvnjwwatQogkjQSHL
	 mg0oRyyOtjrmZ8JgeC32sgKtTLglcMMDUrpc/eY5FjGUCqZeTWybE8EYESDKOi4c1I
	 3YhOBrHh0GcsVFpNB20eshXPaFicyl0hVqjH4TR2DmaLOezHM3Z8CeyNvxWsVTzAeX
	 1ZACRhU/+4p64I1yvp2wpa6cUCFvJgOGyhJN1n7elJz+MKfxDzE5rdyO3wAZXBpo96
	 LrLttBVrsxSpaP2RTzfKqf795WWSHboGbIe0saWJsKXDKMFQJBx7bYsGC7QTFpLr/L
	 UfkAXasHE4O4w==
From: Mark Brown <broonie@kernel.org>
To: shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 tangbinzy <tangbin@cmss.chinamobile.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250930093349.1934-1-tangbin@cmss.chinamobile.com>
References: <20250930093349.1934-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoc: tas2783A: Remove unneeded variable assignment
Message-Id: <176052179120.20166.8951798015757905021.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Tue, 30 Sep 2025 17:33:49 +0800, tangbinzy wrote:
> In the function tas2783_update_calibdata, 'i' to 0 is repeated,
> thus delete one.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2783A: Remove unneeded variable assignment
      commit: 3c89238ca35bfe176ba34bc688541f90f6fa7bdb

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


