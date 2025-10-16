Return-Path: <linux-kernel+bounces-856780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B57BE50CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F3664E9B1A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CFF2367D9;
	Thu, 16 Oct 2025 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb4HYadL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE4235341
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639078; cv=none; b=TZdP32D3kEwd9efXVJGUdd5yrjExkxbgJV7JfInjVd/uef2vPBICbpS9jXeCwNGcngzwpV99xBS3bB+jKwDp54SuPWMXcsjpO/4t2GsoIcUAzE5RBliibuYrpM+yqWCBJ43Qgkaq0RRPavAJHHYUKGdUNiud+Xik4jd6J/jBJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639078; c=relaxed/simple;
	bh=uzY7QbZ8CrzW7pubjL/Qa8fDMy2uC8toqiGjslYwHCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDVuEtfbtZe7g/3cLAoBDJwMkPT7DCzplkasuK3DXWNmqyOtVJBtN2e17tyyrAbg4NNcnirv1keRiKzuelH06ERqoY7LoBnyeOyuy0udaIaK8wJRiynCMOQ0LirzF9gAAvTxbLHFJa/pYqf/okSlBHqmtV88WiD88z5GujrdG/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb4HYadL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A2C4CEFB;
	Thu, 16 Oct 2025 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760639078;
	bh=uzY7QbZ8CrzW7pubjL/Qa8fDMy2uC8toqiGjslYwHCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sb4HYadLP5bflziqd0jzlztvEDxzI3kLxyX5GbpyEnuka4Y98ptacMqBcrhaBcSCO
	 XPRyR++XZMhsyIsa8P/QDkBJHQvrR8ZVfilRwu01NlE6m88wuc0saC+gjmNxYBhm9F
	 IEZLw400CSVcpPtikxtlWA13Rg9/N97ihNISIReE09o0xsbVtB3iSTrEt6T4qoVc9B
	 PpVmjMhS0KXtiQUVBIzMMNJXF2Pi8E2F4Y/vn5I6LCkfXg8ntxaFvADf/suslfCRUm
	 +oU9zKnq6HA6dzPRLZFLpjv6YR8bggMa7BTnX0IWU0Ul4TRzNEz3peFHlRkyYeDOYA
	 /3uSzbgz6j85w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6B39B167A;
	Thu, 16 Oct 2025 18:24:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.18-rc2
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <176063906224.1852182.4367810623044827631.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 18:24:22 +0000
References: <aPEt2-u8J16L9Xnk@google.com>
In-Reply-To: <aPEt2-u8J16L9Xnk@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 16 Oct 2025 17:39:39 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs fix for 6.18-rc2
    https://git.kernel.org/jaegeuk/f2fs/c/98ac9cc4b445

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



