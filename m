Return-Path: <linux-kernel+bounces-730476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BEB04526
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067DD1614BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB48C25EFBE;
	Mon, 14 Jul 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btYkjM46"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562825E471
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509599; cv=none; b=WNWqBbUfZonXSSrVFSVqDDDlqffH6HsiVyNIIMkcnrujYV2msyOd4lv2G7PEValhgRxLiMkrv0Vs/L2HELoUYsDgt5S54rQOJvcVXkTQRCpwMVmHdKVRVxzi6ZFc+4LkPAlEYkQrC+VhKozMIEnJRbqQCv38Iv8Dagr0YxjFyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509599; c=relaxed/simple;
	bh=whDrHFZg7roQ59lJBP+H1enkqi9grGeXVUzZCFdey6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MJHMoAHQzYqY82UqIIacYckbKIrbiNn2ioW73zZFwhKBGIrj/+RHne02DGo7zmoIg5slgTFJHgmEbSnsWSrleUS/tuXidfug2mvyD3tr0HFhBLxn26Sgy5hMfnfxw5vhTOxhtyby0qVFTjkQ7XQnkLPN240ArwQtzCiIlM1bIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btYkjM46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2550AC4CEED;
	Mon, 14 Jul 2025 16:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752509598;
	bh=whDrHFZg7roQ59lJBP+H1enkqi9grGeXVUzZCFdey6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=btYkjM46hlpcnbgtAx3rR3Cz5oq6BoacT8ne7bAXV1mOe3YMIqYzsTegnCC2f/xGx
	 Z1Pt5+Bp4FdbmILUY1Pn1FIyxPGI7h+bODYOSnuYw07yTyp3p2AVig0Sai6+QdWK8i
	 gJCRoBuizgDgm9eCRw+4KjT1T7/Og25XkmlRxdnQmAriNecv79qgNSASN0nbSCWk4n
	 GpnVrom75XYkh9pf68oj2yyvIeyd9WuAkO+t/LIksTFQ5M9Y16ybZ6cfYVsMW+xrxd
	 j+vdO5ht0j5aSEV5184bSHi+C6L+wX55QmvRLiwhwsAFJUB14t+WFDV3NZTLAiaO9i
	 Kulx7BsgxYbmg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250714010456.4906-1-jszhang@kernel.org>
References: <20250714010456.4906-1-jszhang@kernel.org>
Subject: Re: [PATCH] regulator: tps6286x-regulator: Fix a copy & paste
 error
Message-Id: <175250959788.84665.14847100283670238303.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 17:13:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 14 Jul 2025 09:04:56 +0800, Jisheng Zhang wrote:
> The volatile_reg function is named as tps6287x_volatile_reg by mistake
> when enabing the REGCACHE_MAPLE support.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: tps6286x-regulator: Fix a copy & paste error
      commit: 43728a6434f9eca0385fd180d8452a5071678a5b

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


