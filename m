Return-Path: <linux-kernel+bounces-836837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2059BAAB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0165B17758D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154491F1302;
	Mon, 29 Sep 2025 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxId//io"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AC1DF968
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759185033; cv=none; b=gegXzDUeCOn1KALOWWbSdkkizGOn0fTSB4nYs2lPw66j/NBo0Ev0Oad7g/Z170Yd0SawaIDC5GuyHPCQAwftOuk4YK2Zy+Il1+H9WxFAchx5+STTkbrEaBIAsTFeie0y5trU0IP4pEZHbfkMuMAC9fxSHRthFjz33LGJ7P8W1CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759185033; c=relaxed/simple;
	bh=gQYDaku1kF/Js+UoZZtUqouT1kwVsGXgv5zZeWdLxJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SEk9x9CcLBT+NQfhhWxYBLnGfH06zBXl0tlZw0rKwBTG+4GOztkZ5R6UV5OJAFBehHx7pvm3Wt3cHdazkAr8d066YdbToiTzymO5/JbKCr5PbyOZG3UPh4rz4iPnVk8TL126JqtJSKq01rKwypteTEeCUwjNymUIiSnCnWGbB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxId//io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0149CC4CEF4;
	Mon, 29 Sep 2025 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759185033;
	bh=gQYDaku1kF/Js+UoZZtUqouT1kwVsGXgv5zZeWdLxJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QxId//ioZ9HbdlO8iF7p5g/kOzQJO6oXtCQNrMJL2arowN1YQzCJ5/ogN3JS0IqqG
	 zF9ayL/lSxTjMshVmWYd/l7pFIvnYTUOrhRhZk/sMqj5GGa1Vf3qwWvFnCx7u3k6Ir
	 myjh0Vpr1t7GVOA8mnNTIU8fybsc1pd5Wd7Eif5xp6gsPMO3eWk2nhvSFCiZAI16DU
	 vGODjGJ852jwxyI+fHcZAnVxqhbojFMOdoAJKEYxY2lt8bV5TgbAZ+DI3ssA6BZMga
	 YvR6Famx1GhG+zi/4trIMh2lkQ1MWhVpb9xztR5TYjEvgJ/r4PkD+56IUFzqdRIrN/
	 2KaEdObQqTaIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB1F39D0C1A;
	Mon, 29 Sep 2025 22:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to truncate first page in error path
 of f2fs_truncate()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175918502620.1733438.7002406299096595747.git-patchwork-notify@kernel.org>
Date: Mon, 29 Sep 2025 22:30:26 +0000
References: <20250910084024.1722790-1-chao@kernel.org>
In-Reply-To: <20250910084024.1722790-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 10 Sep 2025 16:40:24 +0800 you wrote:
> syzbot reports a bug as below:
> 
> loop0: detected capacity change from 0 to 40427
> F2FS-fs (loop0): Wrong SSA boundary, start(3584) end(4096) blocks(3072)
> F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
> F2FS-fs (loop0): invalid crc value
> F2FS-fs (loop0): f2fs_convert_inline_folio: corrupted inline inode ino=3, i_addr[0]:0x1601, run fsck to fix.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to truncate first page in error path of f2fs_truncate()
    https://git.kernel.org/jaegeuk/f2fs/c/9251a9e6e871

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



