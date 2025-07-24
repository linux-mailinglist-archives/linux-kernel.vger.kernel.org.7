Return-Path: <linux-kernel+bounces-744906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF7B11257
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C38566493
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE512750E2;
	Thu, 24 Jul 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIhh+KxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DE27381D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388990; cv=none; b=SZKWAG58MX0CFRRR9fJVwAmHeLX0tQZdFVaE3qlSzm+yTeo6vWZi4ZGW2HQKFOWXqaCzmMKwgmiHANe33jQ5nDUyWwK1XwOIdikNuAtoRDhK1HdIQukehA1g83nnXlXexL3dyhqwgbeUxj2mqlDqCoiNtr7zAwHDN/C308ilsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388990; c=relaxed/simple;
	bh=RXhFM63F/0s+hjpp3fkwgqu+rmqBVdFqg8AZd8l2Vxg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q2twlvr1tIXcIUkVofbXJ3dy6oYYrqUn8s1mmZlvG9cbQPlT2EnLz4Og9KOu1xhR3rrOVagImYRdc6piQVmE1De/qaSklp2MXd7oybBC9A4U2i4IS8+iZIMMWx+YToOKR6/QcJtAs+uYWq67SrOx7LGvt6JUxRSzYK00pPrsxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIhh+KxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE1FC4CEED;
	Thu, 24 Jul 2025 20:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753388989;
	bh=RXhFM63F/0s+hjpp3fkwgqu+rmqBVdFqg8AZd8l2Vxg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VIhh+KxDomNKFe9NHoCwgSGdg4FVROCbXJSwkequJkgB5+z4hpgnWiz054lpb1WPB
	 61/cJNA1EXqxaCahEiTWNVEZgpZPmLF2XYdTQmfxBs4pCq0m4Wg59y75XhWQa62kFd
	 LZjxueOmilD9mSQbLjPm9eVHkSOPWeAUQwYAvggJiFOWo4x7R73PmZrYw/b++6ur5y
	 x/c5CGzhlKFFlyBrbrPh2UkzhjMfKqZY5v/IfRGDLI8s5ax2v2J8t41pmZIi1r5JXH
	 tuiSRcPx3PYKGB/KyIL3YN8LBfAXg8HHSYi0pPyOB2sFy125z3DVEnVFxJtkKWrWCZ
	 RrMD1yKOrOgxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFF6383BF4E;
	Thu, 24 Jul 2025 20:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary tracepoint enabled
 check
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175338900751.2519964.9709355114500985822.git-patchwork-notify@kernel.org>
Date: Thu, 24 Jul 2025 20:30:07 +0000
References: <20250723142456.2328461-1-shengyong1@xiaomi.com>
In-Reply-To: <20250723142456.2328461-1-shengyong1@xiaomi.com>
To: Sheng Yong <shengyong2021@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, shengyong1@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 23 Jul 2025 22:24:56 +0800 you wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> There is no extra work before trace_f2fs_[dataread|datawrite]_end(),
> so there is no need to check trace_<tracepoint>_enabled().
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnecessary tracepoint enabled check
    https://git.kernel.org/jaegeuk/f2fs/c/95d7c508b212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



