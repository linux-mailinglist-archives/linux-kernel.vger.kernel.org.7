Return-Path: <linux-kernel+bounces-836842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBDBAAB37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F47E7A674E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D67264623;
	Mon, 29 Sep 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5FcTmb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE3262FD0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185040; cv=none; b=oNCw7KOWUTUZoeb46fyBxxwZAMMBfj0VMRNv/bpAOzWeealbcUfaMNnjUINwIF6ZqNmact4oi5E03y5l7HacyFLPmznCRh7CDxzEKlhR42oLchHWg7KKb0RxApPNULlxTiSWTKw2mYwoQGusvvUxNnUn1vi2WiSnumhh8m6iPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185040; c=relaxed/simple;
	bh=AIcbCskBdQBLXM9s9cL/7RuDAW5V8Hs8aLASHQLwq+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kqw6TcrH7j797dhaH5gAy8pFFRfeMSKHuJO75IiSmpXr67S8Amax54mzNscTTN/LadRwjxJA69qzNqpoPsKunB+uOil5qCv5Gz2u92e5GvxeBFmxpjbVTHA1RUBbM/Ov3LNs27fN41W9z11mzUY9NAIya2Rfmp1UO6fp6NcsyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5FcTmb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702EEC113D0;
	Mon, 29 Sep 2025 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185039;
	bh=AIcbCskBdQBLXM9s9cL/7RuDAW5V8Hs8aLASHQLwq+o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5FcTmb+cydviXjCgSR4RNiD4Rjp/JAeXL4aLUCWYk/EM7g9O4Xr1Opmlral/azDO
	 U9lsvpXCVctV1qtO6hZ2bFR0Dn9dkYU5xo/Aw6oy38jm+T8JpUKNDVjAqLquN/l5WW
	 k4lCXAV1V+HdXOU9c10LfuS/gDzDrxJ+BWQw5//OMAReFJClux5GHPS5XZpzC/Mt0B
	 JzCPn9xYoFFbaFDb9VzMGlqIY6n9bfic3N+on/NdQjV3/qCCGIPTtDb+dlwEfR57iG
	 0eSVaa2wWx0Qhli7a3rfWkDEtzaAsm3oxmWBaS0h787I/w5FsSnu9RzuKpr1fXAzkl
	 GWPZcxhNuhVUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AF339D0C1A;
	Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix UAF issue in f2fs_merge_page_bio()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918503274.1733438.18125084752996627880.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:32 +0000
References: <20250928102422.300429-1-chao@kernel.org>
In-Reply-To: <20250928102422.300429-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, JY.Ho@mediatek.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 28 Sep 2025 18:24:22 +0800 you wrote:
> As JY reported in bugzilla [1],
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> pc : [0xffffffe51d249484] f2fs_is_cp_guaranteed+0x70/0x98
> lr : [0xffffffe51d24adbc] f2fs_merge_page_bio+0x520/0x6d4
> CPU: 3 UID: 0 PID: 6790 Comm: kworker/u16:3 Tainted: P    B   W  OE      6.12.30-android16-5-maybe-dirty-4k #1 5f7701c9cbf727d1eebe77c89bbbeb3371e895e5
> Tainted: [P]=PROPRIETARY_MODULE, [B]=BAD_PAGE, [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> Workqueue: writeback wb_workfn (flush-254:49)
> Call trace:
>  f2fs_is_cp_guaranteed+0x70/0x98
>  f2fs_inplace_write_data+0x174/0x2f4
>  f2fs_do_write_data_page+0x214/0x81c
>  f2fs_write_single_data_page+0x28c/0x764
>  f2fs_write_data_pages+0x78c/0xce4
>  do_writepages+0xe8/0x2fc
>  __writeback_single_inode+0x4c/0x4b4
>  writeback_sb_inodes+0x314/0x540
>  __writeback_inodes_wb+0xa4/0xf4
>  wb_writeback+0x160/0x448
>  wb_workfn+0x2f0/0x5dc
>  process_scheduled_works+0x1c8/0x458
>  worker_thread+0x334/0x3f0
>  kthread+0x118/0x1ac
>  ret_from_fork+0x10/0x20
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix UAF issue in f2fs_merge_page_bio()
    https://git.kernel.org/jaegeuk/f2fs/c/edf7e9040fc5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



