Return-Path: <linux-kernel+bounces-797292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F80B40E82
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0BAD7A33E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7B3570DB;
	Tue,  2 Sep 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfA3IKiu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9662E7BD7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844407; cv=none; b=hteE3BfUEQ98ctHro9bsZQroyfuEFv/e5SraciPJSQbgx+nqqG623cPrEyRVMVhrpKtdJ8K0pyWZnsbS8rIMkOSZEnIf4EC6E70RwEHkIyWgbn+7ZsdG9AwEPv62Gru2HS46D2HJbr/TGCAgy14cbUfvMkDET1/l89mSP/PLT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844407; c=relaxed/simple;
	bh=dYWMczR//YCOS9zBgbUp4tAMn84V2mawXfAbvifUB2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IUcWWbBvtjJtLYNnEURFpf0Pdj23hcf9eL6OfmNyX+tArR53M/Ks1KnRleRvxtXOS19X1PnA9bNGajHfzwOUm/uOGtJIrrLkjiOeQMO5WWCbVSfywk26EqCYFpNKDl/zcrlaMBqINd5zckQ19Y4uLPY4lbymhvboHie91zvEv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfA3IKiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C849C4CEF8;
	Tue,  2 Sep 2025 20:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756844407;
	bh=dYWMczR//YCOS9zBgbUp4tAMn84V2mawXfAbvifUB2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BfA3IKiuAEuc9Xn/ecePZhyebbRQmKblTLutQv0AFSKAYqZHwnC5xPkva9szEW4lu
	 rmDHQ9NZxpZn5vkszZXSlCQvNOeIXSOAcgq8Dl5yyTPqxhsytn4UaFCdJnbonWoM9w
	 FfowdKTUvL8IB+oK2WSr0b4Spd1QPbVBpJEzhg/sidKLCFpbkaSf5SkU//VADDalMs
	 5PSucvbazQRG/5sgl1yzBaKdlXUfI2xIVkNOkgX2dcFhdmW0+5opkePXa17eKUYytT
	 J9iyeoR23ITRvfkFy4eiwgrPkLgK8USrXv+5DnSJTthxJL6pHqG0SBDomyldCBERTU
	 jCEb8KM532ofA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE05383BF64;
	Tue,  2 Sep 2025 20:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: fix to avoid NULL pointer
 dereference
 in f2fs_check_quota_consistency()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175684441250.425353.3302301690844852179.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 20:20:12 +0000
References: <20250818020939.3529802-1-chao@kernel.org>
In-Reply-To: <20250818020939.3529802-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com,
 lihongbo22@huawei.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 18 Aug 2025 10:09:38 +0800 you wrote:
> syzbot reported a f2fs bug as below:
> 
> Oops: gen[  107.736417][ T5848] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 5848 Comm: syz-executor263 Tainted: G        W           6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT_{RT,(full)}
> RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
> Call Trace:
>  <TASK>
>  f2fs_check_quota_consistency fs/f2fs/super.c:1188 [inline]
>  f2fs_check_opt_consistency+0x1378/0x2c10 fs/f2fs/super.c:1436
>  __f2fs_remount fs/f2fs/super.c:2653 [inline]
>  f2fs_reconfigure+0x482/0x1770 fs/f2fs/super.c:5297
>  reconfigure_super+0x224/0x890 fs/super.c:1077
>  do_remount fs/namespace.c:3314 [inline]
>  path_mount+0xd18/0xfe0 fs/namespace.c:4112
>  do_mount fs/namespace.c:4133 [inline]
>  __do_sys_mount fs/namespace.c:4344 [inline]
>  __se_sys_mount+0x317/0x410 fs/namespace.c:4321
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()
    https://git.kernel.org/jaegeuk/f2fs/c/930a9a6ee8e7
  - [f2fs-dev,2/2] f2fs: fix to allow removing qf_name
    https://git.kernel.org/jaegeuk/f2fs/c/ff11d8701b77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



