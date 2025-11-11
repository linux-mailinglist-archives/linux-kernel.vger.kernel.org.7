Return-Path: <linux-kernel+bounces-896278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9290C50044
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAA343A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D312FF166;
	Tue, 11 Nov 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBNazh2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E542ED168
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901456; cv=none; b=Ku3kprR/zhkwIwdTK7b+qKslS8rNqK6GjupKOk991+7+Yv7IpghwVJRNRvQ4gom5WPPAHCPrOXYC4jtcnlgUy+Odkmoet8VFlHMPFDW25U/muZqDuYn2HFTAI2gSwIChnLVx7i1GHRKvp29MenBb2t5QTdpz0J3ijD8wTPUhHCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901456; c=relaxed/simple;
	bh=/mFXDzsNaVJtc+aBAgRDg4d40EXG5WNptX3dKSYuDSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aRBURniyI47Gele3+cUrt7kQnHvlqbHfCfWnXUbqPGEMpmAWCcLYI3OQzvhyOWgNrdvXPbqwqZX+KE7GhyYkV01qEp7UP5viEPq8R1eqmxBxk+b7CZA8z+apWLRv0f+6KIC1mdMwAFurqSox1V+EpxAeksuglLps1dSxEdkzm58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBNazh2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FECC116B1;
	Tue, 11 Nov 2025 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901455;
	bh=/mFXDzsNaVJtc+aBAgRDg4d40EXG5WNptX3dKSYuDSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBNazh2zQFpk5Gpvm5lnBrCV8vP3ar1uwvW6InWShVyFLdjZdqtoj3v6p+MXtk+zG
	 HlA+tI04C4Mt8qY16ooUzofGK6ekgV6ssaSz7/CBhkdSkiAS1ykQ8SPxViG5Ch/M7+
	 COuyWLjVrX9X/S85TihbZRfW4FnqeENbeV2YutqMh9xUVdQh8NmMpjk6FBDZBDmqa6
	 HSZnRZoK+6p+Hc2+P31pVdRKysd9GQ8kcTlGJIHrWgAsvPhxT1OeNecBUTxBd7w/06
	 fahOFd0s+bYeSfk4k6uoGWSALtIykx3VsJGjapdYKQIViP7f//IFlZvoASfcczlggZ
	 C4E80uzOOa6Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C90380DBCD;
	Tue, 11 Nov 2025 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid updating compression
 context during writeback
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290142599.3596344.15033354145117725938.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:25 +0000
References: <20251022030636.1194244-1-chao@kernel.org>
In-Reply-To: <20251022030636.1194244-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, sjb7183@psu.edu,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 22 Oct 2025 11:06:36 +0800 you wrote:
> Bai, Shuangpeng <sjb7183@psu.edu> reported a bug as below:
> 
> Oops: divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 11441 Comm: syz.0.46 Not tainted 6.17.0 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:f2fs_all_cluster_page_ready+0x106/0x550 fs/f2fs/compress.c:857
> Call Trace:
>  <TASK>
>  f2fs_write_cache_pages fs/f2fs/data.c:3078 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3290 [inline]
>  f2fs_write_data_pages+0x1c19/0x3600 fs/f2fs/data.c:3317
>  do_writepages+0x38e/0x640 mm/page-writeback.c:2634
>  filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
>  __filemap_fdatawrite_range mm/filemap.c:419 [inline]
>  file_write_and_wait_range+0x2ba/0x3e0 mm/filemap.c:794
>  f2fs_do_sync_file+0x6e6/0x1b00 fs/f2fs/file.c:294
>  generic_write_sync include/linux/fs.h:3043 [inline]
>  f2fs_file_write_iter+0x76e/0x2700 fs/f2fs/file.c:5259
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x7e9/0xe00 fs/read_write.c:686
>  ksys_write+0x19d/0x2d0 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf7/0x470 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid updating compression context during writeback
    https://git.kernel.org/jaegeuk/f2fs/c/dc460f40c8f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



