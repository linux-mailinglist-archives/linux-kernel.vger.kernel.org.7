Return-Path: <linux-kernel+bounces-896269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6EC50023
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA04189AA55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B392F2617;
	Tue, 11 Nov 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4GKc0Fr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41792F1FF5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901443; cv=none; b=n8WeriwbyankXtto1TkJ2NGuvtXfsQAdHtGnDe3V6uStj+xDItbVYUAM8Yg8G4mOXuDGwiX8JW1u/YJYLcjKXRZlzOT1ohGAuqojJBpLnvdQmX3Aqip8wH20ZR2e0vPEPPiWJTB+RfRI1klm2F7AhcfTjPcrxHSAOtEo2drZ0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901443; c=relaxed/simple;
	bh=lih0+RXTcTkySeeNC8FObDIyhadckjqvtxvgziMdxKM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEWaAqLT3SKfBuXgjtOynr/EuNWfhVIj8z2f0fFcM99/FsRqd7SEa0YLqnEb4SPHjEZlqZyytO29YBpaYrSm8CkVePY/+rUcpvbrobTRhJtiEatuqPpDJ/+dmFnwk2ceOBWY2gXl0NwgdBe5N6o5h9/ezN5dka6qfhnI55Wim/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4GKc0Fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74829C4CEFB;
	Tue, 11 Nov 2025 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762901443;
	bh=lih0+RXTcTkySeeNC8FObDIyhadckjqvtxvgziMdxKM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P4GKc0FrEEmjyGjVA8TrDBvlLo0hVhDxj5alX1V3SBgjjgT7QU14ioqnUwnNInx1V
	 11fof0S7M2jKqRFSJB0vlBvXjMqdVLExDAGb/LlFoel2OOfwcE5wQqYjsEDusCmhx2
	 +e/feemJkd3tOMP9Zn2UjizjcnLqd0EqnFO/NvcAjDA+5Y+6IOR4NOLPYvBSk9GXpk
	 NUwdhjKHIvHxsJDNowiokwdmJXs223EH7k6Bl2IIGhmAIfv/QycwySt2EVpdQI1lWq
	 5o4hA1vo94WTLKYozONfOVGg/Ksj9iAzt5/Sd05BSxl44YHNEtrVFzdJIFcmRw8ZWC
	 j5JuKkr5o1CLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C5F27380DBCD;
	Tue, 11 Nov 2025 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use global inline_xattr_slab instead
 of
 per-sb slab cache
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176290141374.3596344.17459931762153462182.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 22:50:13 +0000
References: <20251021034856.739272-1-chao@kernel.org>
In-Reply-To: <20251021034856.739272-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org,
 yhong@link.cuhk.edu.hk, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Oct 2025 11:48:56 +0800 you wrote:
> As Hong Yun reported in mailing list:
> 
> loop7: detected capacity change from 0 to 131072
> ------------[ cut here ]------------
> kmem_cache of name 'f2fs_xattr_entry-7:7' already exists
> WARNING: CPU: 0 PID: 24426 at mm/slab_common.c:110 kmem_cache_sanity_check mm/slab_common.c:109 [inline]
> WARNING: CPU: 0 PID: 24426 at mm/slab_common.c:110 __kmem_cache_create_args+0xa6/0x320 mm/slab_common.c:307
> CPU: 0 UID: 0 PID: 24426 Comm: syz.7.1370 Not tainted 6.17.0-rc4 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:kmem_cache_sanity_check mm/slab_common.c:109 [inline]
> RIP: 0010:__kmem_cache_create_args+0xa6/0x320 mm/slab_common.c:307
> Call Trace:
>  __kmem_cache_create include/linux/slab.h:353 [inline]
>  f2fs_kmem_cache_create fs/f2fs/f2fs.h:2943 [inline]
>  f2fs_init_xattr_caches+0xa5/0xe0 fs/f2fs/xattr.c:843
>  f2fs_fill_super+0x1645/0x2620 fs/f2fs/super.c:4918
>  get_tree_bdev_flags+0x1fb/0x260 fs/super.c:1692
>  vfs_get_tree+0x43/0x140 fs/super.c:1815
>  do_new_mount+0x201/0x550 fs/namespace.c:3808
>  do_mount fs/namespace.c:4136 [inline]
>  __do_sys_mount fs/namespace.c:4347 [inline]
>  __se_sys_mount+0x298/0x2f0 fs/namespace.c:4324
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x8e/0x3a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: use global inline_xattr_slab instead of per-sb slab cache
    https://git.kernel.org/jaegeuk/f2fs/c/670b676d8343

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



