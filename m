Return-Path: <linux-kernel+bounces-797289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F39B40E78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4563A8948
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF93451CC;
	Tue,  2 Sep 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKJDGi4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469031DDBB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844403; cv=none; b=kfkRaKAFDemyXR0l1QJIYI8QKFaaabKo7/3OaWL4GJGEGQmsQOUkf6U/Ti0Djp/Bb5g/nGnm0dZ0G08TC5pp+MqvdRNSrGinWS2BVYfwWDaBo/xvcKUFe3JOLtLTSadD/0yE29r8P/b6+9y4VNk0D1DWBAIH0bD0a84jaN3QN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844403; c=relaxed/simple;
	bh=RQup03V63i7JEJuwQszfY9xKRSyVG3eKOhMwJxz9NC0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oYrAJAWTU6LtdBJZ7ZaJGqftn5R3wGw0bmjiaEsxNBTv61z2od97vLd8qdHY7QfzEzNAyLXIKFONDjjHcAoYVvG/VPB7OJ7V9EdIVDH8qXVwdZuPO7aeoa3j1R6/curvFYQQPrRqjV0m9nzp8zneUVYNu956vBveq/D7j5rH1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKJDGi4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB3EC4CEED;
	Tue,  2 Sep 2025 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756844403;
	bh=RQup03V63i7JEJuwQszfY9xKRSyVG3eKOhMwJxz9NC0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XKJDGi4aRNKN8F3wJFCxTbqydOZbTXfKRa747xXMRHo6j+qAMKYMFbvOtfJjCsvAe
	 6qou6xouMp9nCNhuhwDgEIToRpjDzR/oVfpvcBbsAnW4+F6VzGATvASG6li5ivqzj9
	 prUjAZG3TGnkPpPXNUUoDhFJOUHSY/9FbBbPFQTe6G8D5lgqJ6fsFrnrPk3Y46HNak
	 CUK7yxXp11CKlBdnhzEATEa1730nHHSOfM3+nK85kdxxPSpXZrTMGAvPPEmsqBUy/U
	 4pSf93w5i3D6SOtnUyUzzueyzTGomNcmw5tce5PdDqAGiJOKGfskTMD7ppvxRKX70v
	 4m56yqS+e9HLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6CF383BF64;
	Tue,  2 Sep 2025 20:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on node footer
 for
 non inode dnode
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175684440854.425353.17772733460715458985.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:08 +0000
References: <20250823054534.41037-1-chao@kernel.org>
In-Reply-To: <20250823054534.41037-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+b9c7ffd609c3f09416ab@syzkaller.appspotmail.com,
 stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 23 Aug 2025 13:45:34 +0800 you wrote:
> As syzbot reported below:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/f2fs/file.c:1243!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5354 Comm: syz.0.0 Not tainted 6.17.0-rc1-syzkaller-00211-g90d970cade8e #0 PREEMPT(full)
> RIP: 0010:f2fs_truncate_hole+0x69e/0x6c0 fs/f2fs/file.c:1243
> Call Trace:
>  <TASK>
>  f2fs_punch_hole+0x2db/0x330 fs/f2fs/file.c:1306
>  f2fs_fallocate+0x546/0x990 fs/f2fs/file.c:2018
>  vfs_fallocate+0x666/0x7e0 fs/open.c:342
>  ksys_fallocate fs/open.c:366 [inline]
>  __do_sys_fallocate fs/open.c:371 [inline]
>  __se_sys_fallocate fs/open.c:369 [inline]
>  __x64_sys_fallocate+0xc0/0x110 fs/open.c:369
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f1e65f8ebe9
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check on node footer for non inode dnode
    https://git.kernel.org/jaegeuk/f2fs/c/c18ecd99e0c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



