Return-Path: <linux-kernel+bounces-724260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F48AFF09A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC00F16DB8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6858241680;
	Wed,  9 Jul 2025 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P74L/i5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB323E33D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084600; cv=none; b=fMPdTpqpayVig+v9q0oeDjfWkU0tNPRDYAkcdWDayGBTfxALMANz8Cd/DWU1OFvIrlvV6BYadMooOc0cnQaY45jdtYHYlSJnMLGPdTeEEDIAA+uWRJbqKD1yZnpAzc/mltKBOAe0fHuZn51iaZX3ulBm+ssNpepXnMUzhRoizKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084600; c=relaxed/simple;
	bh=TToFJF7a6cjpVJcvV/eyMdLrXl8Is6qU2qXyp4GSavQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=diD+NEtl+Fny4y6+4FXq3twILF768QhF4rPM8D1+sZ0BGVZZQYxOdYh/Vk/7XStP7YNt6bQkvYnTz20YpyO1JDVPNfhpmcUDcqzK+aKyL6Z7BNQmJFGb7DtvEkX9yaV6zYPR3DtEeXsS5QkCfa+oD0oAtPoM4LRnltqBH8OfFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P74L/i5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5D0C4CEF4;
	Wed,  9 Jul 2025 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084599;
	bh=TToFJF7a6cjpVJcvV/eyMdLrXl8Is6qU2qXyp4GSavQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P74L/i5PzRxQlIUkWsTC3QCH+cN05KSbq2rbXhsCF+vrrJIy3ZNP5K7aPcQV9vPyM
	 S9kQ+k/lOLrkpwPbd76+XKzuknLVdcqV9+avFj58gOdMmKTzk7CukrOq5a4pxz87df
	 iRAzw6PTjvESV7+7veYM6xvEBtbN1vNjCUcqg2WwfUyG2OnSJ34Iudlfo4hEYoBaQW
	 HwS7Glm9DKJU3jcdnhCw0mlu/BcVROt4zaP0KFIB/2wMUCALaHDohXtG5d2/EIjiCx
	 sbbrhTn0ZqD9nfnOsFgq/DQntwF/Li/+vvmKfUrLzCvmJVfYzmSV6+TZ1ixeAUHT8u
	 2aMDzqxq0M/Vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72196380DBEE;
	Wed,  9 Jul 2025 18:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to avoid UAF in
 f2fs_sync_inode_meta()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175208462203.806926.11617556974013999350.git-patchwork-notify@kernel.org>
Date: Wed, 09 Jul 2025 18:10:22 +0000
References: <20250708095339.3079788-1-chao@kernel.org>
In-Reply-To: <20250708095339.3079788-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  8 Jul 2025 17:53:39 +0800 you wrote:
> syzbot reported an UAF issue as below: [1] [2]
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=16594c60580000
> 
> ==================================================================
> BUG: KASAN: use-after-free in __list_del_entry_valid+0xa6/0x130 lib/list_debug.c:62
> Read of size 8 at addr ffff888100567dc8 by task kworker/u4:0/8
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
    https://git.kernel.org/jaegeuk/f2fs/c/7c30d7993013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



