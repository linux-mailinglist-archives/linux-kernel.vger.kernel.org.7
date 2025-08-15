Return-Path: <linux-kernel+bounces-771196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBDDB28405
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76171163D41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315D530F81F;
	Fri, 15 Aug 2025 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVHlx27Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909DC30F814
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276007; cv=none; b=QaRSYEas6X0wScMDujoPSjwPHBzZIQek0yeCFDXJB04CwaAaeMYFRWUvKzI3tc7bZMYkijqjq3tM2MyYe1FGJy/s1s+hL4Kf/UOIY0B6H/5MH/4TbbYgYDZ69sGQxxBFeRZgBaJL7LpRo7rLMIkrwqtliq1ierlbzR8py8T6T9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276007; c=relaxed/simple;
	bh=S1ZmvEXjwv258ofLF72c0v+Zz594gSNk95FiMJ1gzP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y1EdupBItlggG4HtWQZ54GjNMhuJMnBu6YgZGyxQkVlNHYkg1QeetVVqlPyQMmi6exI88aRXdSz2eYU7sUyuOwf5lu9J5swTwHf+rGrz8059ska+ng+RvMWtpk5lQuzmGnoh1qyKozKX5cusb60Ja517ixuxXQ3QLBSjjyNYpCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVHlx27Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26736C4CEF7;
	Fri, 15 Aug 2025 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755276007;
	bh=S1ZmvEXjwv258ofLF72c0v+Zz594gSNk95FiMJ1gzP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oVHlx27YHSwXBrpYAcHK3BykupW5vDbkDkVI7BNOc3OCslrC9cKrVlYc29Sh2bpqi
	 oG1k4W0a8eFbGaOFXHCJjPCDZChSWVpgw4urY9sBPhwPjzUDpGlaZYl8sWRNAquf8u
	 5ZutAqcPRz7yxN4ju5rCABm+2Lh3oaHH/b4I/aN2K5nKhNueqkP8Kr2wSw5F+ZSWdS
	 OtidMx9DtTIsV/czyU3SAxMXiDJK56rnbcGQDz4cAIVg9XO+MyObcwYYkHdFVZY87R
	 i5xG1fGW4EVNK9PXCQDJqH60tmBAXqL6lf2CX1eAX98RybwPELT8QhAhb929d47x7u
	 x4AEX9+eMV92w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B9439D0C3D;
	Fri, 15 Aug 2025 16:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix condition in
 __allow_reserved_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527601823.1161945.11181817879105775454.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:18 +0000
References: <20250731060338.1136086-1-chao@kernel.org>
In-Reply-To: <20250731060338.1136086-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 31 Jul 2025 14:03:38 +0800 you wrote:
> If reserve_root mount option is not assigned, __allow_reserved_blocks()
> will return false, it's not correct, fix it.
> 
> Fixes: 7e65be49ed94 ("f2fs: add reserved blocks for root user")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix condition in __allow_reserved_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/e75ce117905d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



