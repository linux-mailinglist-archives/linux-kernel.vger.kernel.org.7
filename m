Return-Path: <linux-kernel+bounces-737331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC89B0AB06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E941C23DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460221A92F;
	Fri, 18 Jul 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwB9od/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427511712
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869986; cv=none; b=MwRf7Ha1y9FRnBVUFobf+CjM9lgEW/c3NKsDaI6kT/hwsGy/evhZqrsqV8Wlt+nJUwSMWzAAhGr4pmpaJl+oDmOD2BNwp/stwM9OSrQ5dqqbe57+k+/20hiZRZG5q8mEo/qPG+aPuLv+y828QZDeABUCQDIGDWoYocz2TobuWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869986; c=relaxed/simple;
	bh=XWmDS6JXJ6Es21ByrYmiuMAoDYE5NCGc//PkQjiLRhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nU7vm/Pwj2TuamOW4s4bl4xuD3kj3Rf9TToRFuUg+NK52GNUuTj2cHxorAI7KDNROfx0SI13z/VD47/qSh3KUmYiZooIWaByv6D+esjv/xlJ9ZbKIm/t5eT8fOhruG8QIC7tWqdQwi4xhs0Mi7ULo+QrH894uM2PoMO6mPCicMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwB9od/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A0C4CEEB;
	Fri, 18 Jul 2025 20:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752869985;
	bh=XWmDS6JXJ6Es21ByrYmiuMAoDYE5NCGc//PkQjiLRhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cwB9od/t5oWHuMhPz2qvea0NQZ/GHlnmBHeqzMXSkDBGWOS0W0zzMVDPQX2I6PN+P
	 7yKb2h3IJqbucI7FU+UMpTUH9URFiE2Y48OUZY3vUxzP1LT26UujM1lxCdDGef7beL
	 i33+PKHdDr9yc71Q7i27ukzGk/r/5Q8KGREefEqZfsadZ6MXudnjZiCmEG1Ao5Cuht
	 jVa3GothQFPnEensyAgr02eOl29pufm0sg1M7bU0lHdWkOBibtpYV/caWB29ttlacq
	 0X6izL2PZoH08SVV9GlUIrFnVf9bdcyVGl2og/tJY7fckXe6ky1WbTel5GknT0jndw
	 ZFhTiRSFc4IFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC05383BA3C;
	Fri, 18 Jul 2025 20:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-boundary access in
 dnode page
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175287000476.2782346.18225378290339645502.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 20:20:04 +0000
References: <20250717132633.1339965-1-chao@kernel.org>
In-Reply-To: <20250717132633.1339965-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, r772577952@gmail.com, stable@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 17 Jul 2025 21:26:33 +0800 you wrote:
> As Jiaming Zhang reported:
> 
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x17e/0x800 mm/kasan/report.c:480
>  kasan_report+0x147/0x180 mm/kasan/report.c:593
>  data_blkaddr fs/f2fs/f2fs.h:3053 [inline]
>  f2fs_data_blkaddr fs/f2fs/f2fs.h:3058 [inline]
>  f2fs_get_dnode_of_data+0x1a09/0x1c40 fs/f2fs/node.c:855
>  f2fs_reserve_block+0x53/0x310 fs/f2fs/data.c:1195
>  prepare_write_begin fs/f2fs/data.c:3395 [inline]
>  f2fs_write_begin+0xf39/0x2190 fs/f2fs/data.c:3594
>  generic_perform_write+0x2c7/0x910 mm/filemap.c:4112
>  f2fs_buffered_write_iter fs/f2fs/file.c:4988 [inline]
>  f2fs_file_write_iter+0x1ec8/0x2410 fs/f2fs/file.c:5216
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x546/0xa90 fs/read_write.c:686
>  ksys_write+0x149/0x250 fs/read_write.c:738
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xf3/0x3d0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid out-of-boundary access in dnode page
    https://git.kernel.org/jaegeuk/f2fs/c/026e81230291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



