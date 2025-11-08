Return-Path: <linux-kernel+bounces-891218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D573AC422B0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930353A40D2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D22874FA;
	Sat,  8 Nov 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcXHwyrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9B285C88
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563098; cv=none; b=arT9Lh4ql8F9KmZI4Nov2t8kh7AkeSd56fe9R6iWRGLURtqMwaWYDrRalk4JZdJtkjJFA463Uear7r9grdxNQcEJohQN1CtcqCsNvJYYD/U8xqP59TnavER0PFK+RmG4EepYWdjjBYop9P3GhWdVdO67YZeP+3kg5pa62wmkWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563098; c=relaxed/simple;
	bh=ylZKoKAG4M109wkBCe4j3unmFhhDKp05GMEno3nSV0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kshCg5BfyGFdiq7XiNinAabc9fel7p3PU/bpFR/jfLeImTsQuVpIJ60dzda+cFRb6blFi4l1hJ2+ZyE8C6H8z+W462pacDVdIA2FBOARWtfwxjTXy850sONtF5/ntWEtJcyWUMYChQ6GogCAKR1LCcdwAHiBr4vD+1TD4/HKv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcXHwyrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D878DC4CEF5;
	Sat,  8 Nov 2025 00:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762563097;
	bh=ylZKoKAG4M109wkBCe4j3unmFhhDKp05GMEno3nSV0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcXHwyrhd+G0Vhs6ZhvFgqm3eTlrt90edylOxtekjv1+H5hBcyrdGoFiCCjl4CB3i
	 JB8mbxQvoudixk8j+X2nlkCrLI00Isb3KFQ5rle+Lw9QiiYf0+iZ7sQGqyUkdyChSK
	 SDbNH1I7FviTOFpLTi2htYYlhlktrcKXikMCvgkrf31w/9nWPd9v0iJn0PzgCF37Ta
	 8KXtFPhuWJwOcNgFjbdVjUkqjyrfT2jXRr05dWHKoDEVJhZtWQw8c7dtWRfb0z0UBG
	 12KJdn3NiawrAo4tVxDBo7UOGQv7GPkf2ZZJi15q2+HFCy6FbcsbHW4wlHkvzfXITR
	 my7ONwKtOtYBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB93A40FC8;
	Sat,  8 Nov 2025 00:51:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc5
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <176256307001.1206494.4691507602998406323.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 00:51:10 +0000
References: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
In-Reply-To: <50a5b4a5-18ae-6dda-bdbd-db67e112bc1b@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (fixes)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 6 Nov 2025 15:52:22 -0700 (MST) you wrote:
> Linus,
> 
> The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:
> 
>   Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V updates for v6.18-rc5
    https://git.kernel.org/riscv/c/225a97d6d454

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



