Return-Path: <linux-kernel+bounces-771189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD1B28407
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F1118884EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB3630E0EB;
	Fri, 15 Aug 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwnxqZd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A1130E0E0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275998; cv=none; b=m8AoRm+C4rZ9gHxPbJiwK1td3tg1/v/oswxspDudEUBNiOrO3nTjUkSQ6tmchHkgklcg9vHlddGWAdZMvFfFNfDVySL7pTtuxab5+FZo5ycKTlHGboR7d11IkQdJVbCxjLIsSbfxx+WtivFGwkWm1GgPMsrWtscKxf1KrztYSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275998; c=relaxed/simple;
	bh=p2Hrk0jNkFpeyIZ+yHC/114UdEbnaXh3w+7d1l+rP1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MatsArCUJQDYwAmT2mfaJY/xxwJ8FpyS8L3OgenueSHpHgknethe2VF+zZ7TQlCd+dpb4jHm5Njcc3/PGxHER8AmH1BE+9iC2UVpEqWYQJatvRYfc1K1lfR10K7qRWCjaMbOm/mCBL9i6r/k+rw58lwi2Fy4CTIBfMM14oYjvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwnxqZd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68238C4CEEB;
	Fri, 15 Aug 2025 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755275997;
	bh=p2Hrk0jNkFpeyIZ+yHC/114UdEbnaXh3w+7d1l+rP1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gwnxqZd9mB57Jng0RG3NpBj7DJFW8UIbTzKj8hRWqcphyDm7+1AbBkhrMD+qOadzs
	 cbDqJOPXXDHL9SEPpnGaG7Zh/2F14xXCRVvgOfSUezsGYpZy9CHET/uWlEEBBrLmR0
	 sqAcNVraxXQDKrp09q+U/71M5TGaDXdPMFlwuwCre7x+aG+CA5ibrmGEtt+nHX0zfA
	 4leLAKJbqvHaJN+fnC2mFVZKKPnihsVzAb6oZn2un3ekJKmTJW1pmzTJDwZvVExAi7
	 bQ3UxOPzE254vIG9FvJFT+08IeFZzNYtJZydTXEaObw+OOoMq84QBqUUqU4k+hlJMl
	 bXYsj7IsegdQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9D39D0C3D;
	Fri, 15 Aug 2025 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to clear unusable_cap for
 checkpoint=enable
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175527600850.1161945.18051756127566725689.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:08 +0000
References: <20250807014836.3780988-1-chao@kernel.org>
In-Reply-To: <20250807014836.3780988-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu,  7 Aug 2025 09:48:35 +0800 you wrote:
> mount -t f2fs -o checkpoint=disable:10% /dev/vdb /mnt/f2fs/
> mount -t f2fs -o remount,checkpoint=enable /dev/vdb /mnt/f2fs/
> 
> kernel log:
> F2FS-fs (vdb): Adjust unusable cap for checkpoint=disable = 204440 / 10%
> 
> If we has assigned checkpoint=enable mount option, unusable_cap{,_perc}
> parameters of checkpoint=disable should be reset, then calculation and
> log print could be avoid in adjust_unusable_cap_perc().
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to clear unusable_cap for checkpoint=enable
    https://git.kernel.org/jaegeuk/f2fs/c/743d13d8a600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



