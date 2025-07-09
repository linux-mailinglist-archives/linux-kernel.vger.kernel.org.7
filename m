Return-Path: <linux-kernel+bounces-724258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F657AFF097
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06DC64834E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6C23816A;
	Wed,  9 Jul 2025 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqhMK6lK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026923E33D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084597; cv=none; b=VBoDyS8fMfEEunOAgsPEL+9Mhqfmt3Q2orR9dENIOrw6lTzHxybTFY78lUpgs6a3vSAcfbdblFtfuOoGDF0YjbzpYfnmwlXqLjf7d8fGfOCvpN5V5bpk8hY1/nWnae0V8FDb0bDS7xM6xDvqJMlUXOYo0teK6iVNbIJvWq7+fBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084597; c=relaxed/simple;
	bh=dNhTV6QpEwHlARJQYMxeWEWzOiLE1Qi9Ucnzl07IARw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nf6h10QuXrTclgkt+E3+Am2f0EMZCtC+sJdi6OowUX6PlC/zs65FPkWiF6bPeEZEv5pAGeecCW2z/mngwcm1aXwPNRkzsSke3INIZOoTxyxJF2t979ZCNtNykJnuC1ZfQipbfbwmqmfwKlPb81WXiamvzffFis7sT6TQTEhBT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqhMK6lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE9CC4CEEF;
	Wed,  9 Jul 2025 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084596;
	bh=dNhTV6QpEwHlARJQYMxeWEWzOiLE1Qi9Ucnzl07IARw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NqhMK6lKBxDXri8kql+WlK0bCWz40Kdp/RqXi2hI8Xf0tdzhOYnacatvsJgovRhv4
	 8mbTM88JVfFieDUQcyBxJ3ytl0wZpolvxcSD0Odm3vJlOP9rlbUmaoQrm8kxkq2HKx
	 xIAzRP4s1PEtWFtR0P0f6m3wkg6n6lDofut74f4ZnCHXLDW8jqA2MiZMR6OHnoTGHW
	 OSoOfkvkrwGNnpHkCFDLDLXzzxWxT1netygjyuvYiyW0X0Ggd3H14SfJowIDgOBs7X
	 JbgxS8ud910+rLCLMhvxYDFdx1kYghZG1Ck4iiykGUb+F/q0HrArzyXpGrEq80HS/h
	 ciHNgY4okK9mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E9380DBEE;
	Wed,  9 Jul 2025 18:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to use f2fs_is_valid_blkaddr_raw()
 in
 do_write_page()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208461925.806926.9116732012355450749.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:19 +0000
References: <20250701092610.511964-1-chao@kernel.org>
In-Reply-To: <20250701092610.511964-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+9201a61c060513d4be38@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  1 Jul 2025 17:26:10 +0800 you wrote:
> As syzbot reported as below:
> 
> F2FS-fs (loop9): inject invalid blkaddr in f2fs_is_valid_blkaddr of do_write_page+0x277/0xb10 fs/f2fs/segment.c:3956
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/segment.c:3957!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 10538 Comm: syz-executor Not tainted 6.16.0-rc3-next-20250627-syzkaller #0 PREEMPT(full)
> Call Trace:
>  <TASK>
>  f2fs_outplace_write_data+0x11a/0x220 fs/f2fs/segment.c:4017
>  f2fs_do_write_data_page+0x12ea/0x1a40 fs/f2fs/data.c:2752
>  f2fs_write_single_data_page+0xa68/0x1680 fs/f2fs/data.c:2851
>  f2fs_write_cache_pages fs/f2fs/data.c:3133 [inline]
>  __f2fs_write_data_pages fs/f2fs/data.c:3282 [inline]
>  f2fs_write_data_pages+0x195b/0x3000 fs/f2fs/data.c:3309
>  do_writepages+0x32b/0x550 mm/page-writeback.c:2636
>  filemap_fdatawrite_wbc mm/filemap.c:386 [inline]
>  __filemap_fdatawrite_range mm/filemap.c:419 [inline]
>  __filemap_fdatawrite mm/filemap.c:425 [inline]
>  filemap_fdatawrite+0x199/0x240 mm/filemap.c:430
>  f2fs_sync_dirty_inodes+0x31f/0x830 fs/f2fs/checkpoint.c:1108
>  block_operations fs/f2fs/checkpoint.c:1247 [inline]
>  f2fs_write_checkpoint+0x95a/0x1df0 fs/f2fs/checkpoint.c:1638
>  kill_f2fs_super+0x2c3/0x6c0 fs/f2fs/super.c:5081
>  deactivate_locked_super+0xb9/0x130 fs/super.c:474
>  cleanup_mnt+0x425/0x4c0 fs/namespace.c:1417
>  task_work_run+0x1d4/0x260 kernel/task_work.c:227
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:114
>  exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
>  syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
>  do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to use f2fs_is_valid_blkaddr_raw() in do_write_page()
    https://git.kernel.org/jaegeuk/f2fs/c/8f4688591d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



