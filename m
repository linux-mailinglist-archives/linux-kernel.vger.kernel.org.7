Return-Path: <linux-kernel+bounces-896272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58021C50038
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1864C3B07B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A52F2915;
	Tue, 11 Nov 2025 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYWlyczZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966F2F533B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901447; cv=none; b=GNrC9rmTCYVWCSnYRAtHWRgOcAXdoB4P4rJRS9k/cjsDHpR809N4m6hbEVECJE2BVK4JEW0rMQHCJC1pgwQbdLOIGuzbK9JzN7BI6eQkp7rUtTAR/ejyOzEPNhhq3mrFNMH/plVF70Mrcz1IsU259T4fd8560hRUdvVuDNB1mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901447; c=relaxed/simple;
	bh=ZqIUy/sw0TbrZF9bJ6CjXw5oR8zyi6SYNa7WHXDShao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JQS/WhFd2N2gX39s19ysi3xMVrqfZUhgrpCWV0J46lCLNPgBrSA6cNJvr/NR+gwS81CMqJCLqkhvtncRJxJEa/4yamDB1SWBqI62U9PAJA+kBOHHXSeNwAif0Ehp4OqcNLaOQtzR8taogPPl1oqnbLfhhaa0ZgmT5J5cxE5Z5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYWlyczZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2AEC4CEFB;
	Tue, 11 Nov 2025 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901447;
	bh=ZqIUy/sw0TbrZF9bJ6CjXw5oR8zyi6SYNa7WHXDShao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DYWlyczZzCXFpt6htUoHmRxJN4xkciT69dZNrKYb2FMJd+VsJ3SNvjsDrHwNeS00U
	 pnrJNnKBQNeukBSFjhOs3WUbn00Bg+moiv4ZEMUkaEswyHk3hyJr7+Rh+LfploilXk
	 3fBQZmUYEILCzRQndlZaUyBwrNVLZ/zhSrBMx+b+VUzzZOt0K2f2GjzxbFKGibHo8I
	 knmmqPmYg/wLJgKYtKFERkg1hSKdeeys6CbjvSbfLQ2iqX/D7/maSSppT6hHr62tGA
	 xmk9ymvFWQC9wBAkgQjciF+JIn9g24kEv/pgyJRFQ1uFBj557DSZzjcBJyUBGyKKIO
	 RIyVWCHQQjG3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE1380DBCD;
	Tue, 11 Nov 2025 22:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid updating zero-sized
 extent
 in extent cache
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141749.3596344.15754105220634232444.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:17 +0000
References: <20251020024213.332873-1-chao@kernel.org>
In-Reply-To: <20251020024213.332873-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+24124df3170c3638b35f@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 20 Oct 2025 10:42:12 +0800 you wrote:
> As syzbot reported:
> 
> F2FS-fs (loop0): __update_extent_tree_range: extent len is zero, type: 0, extent [0, 0, 0], age [0, 0]
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/extent_cache.c:678!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5336 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__update_extent_tree_range+0x13bc/0x1500 fs/f2fs/extent_cache.c:678
> Call Trace:
>  <TASK>
>  f2fs_update_read_extent_cache_range+0x192/0x3e0 fs/f2fs/extent_cache.c:1085
>  f2fs_do_zero_range fs/f2fs/file.c:1657 [inline]
>  f2fs_zero_range+0x10c1/0x1580 fs/f2fs/file.c:1737
>  f2fs_fallocate+0x583/0x990 fs/f2fs/file.c:2030
>  vfs_fallocate+0x669/0x7e0 fs/open.c:342
>  ioctl_preallocate fs/ioctl.c:289 [inline]
>  file_ioctl+0x611/0x780 fs/ioctl.c:-1
>  do_vfs_ioctl+0xb33/0x1430 fs/ioctl.c:576
>  __do_sys_ioctl fs/ioctl.c:595 [inline]
>  __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f07bc58eec9
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid updating zero-sized extent in extent cache
    https://git.kernel.org/jaegeuk/f2fs/c/cbd96c6e304f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



