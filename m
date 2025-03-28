Return-Path: <linux-kernel+bounces-580410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7245A75192
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 21:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9930B3B0C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 20:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681B41F3B96;
	Fri, 28 Mar 2025 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1nIMT+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37381F2382;
	Fri, 28 Mar 2025 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743194459; cv=none; b=Rm5DQPO2F/e70mDApu3Jx3T2XRfDVOCHy5IxStjLOWvgtmzSNGWCcqXsTEVOVacY4dTolWZGQfm7z0JKV1U/M9BV2ctyFJo0XIDc49xhRzzb2/ULVyMsmz+ffJYrslLzsODtqazjtt8zLspPT7UtZdnej9O9vwBrPWfXEERf0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743194459; c=relaxed/simple;
	bh=TnIDRkuv9FaqxOkdC5jajRWt4NtdOKeZ99XiqaZvL/4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U3PdbvPVFy9Gp7Af/IHquye9M4wvIKyrmixz06/CwOvigm46lnYT99WX3IRaQ0SpGZP2+ahJKalu1WWyjLnL4Nng0LbjzHRBJixel5LMvfAQjLXeQlqiuIhEW7GaJLj3xyYUgjtP8+I0Wt4tc3pL9Y4DA2m6bVvorfbo/IuHYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1nIMT+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E976C4CEE8;
	Fri, 28 Mar 2025 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743194459;
	bh=TnIDRkuv9FaqxOkdC5jajRWt4NtdOKeZ99XiqaZvL/4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U1nIMT+fPwyAkY0fXX9OoPq3dxcWH3ARpC/wLNHCyy1J5SHqZYbYzEhOOZZxaSSzN
	 4CSW9IXNRJ6uiqEr/nUU1cly5+YrTcoXyE/hrzOLBiqgkmMh9tfjj8xB2yzfv8Vwq+
	 D8xXv9TKITFNggIPTMZl1CVBKgr5FgjIoLhpS1+GU1QyvNLdy8tL2IvrvT7y/a6vPk
	 b35qBLe+HSXqTJFiOHVzpgyVa8p7CgQbNY693LZN4EGR/Z+Jl55jFFcro6zd5WpvLS
	 jmyENW12Uloyx+b79J7WTKVqgWvFzkbZkVwFnVzxp6CZVdKIybLpxxbctqmprP1SUy
	 6wFCveTxlO60g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7E3805D89;
	Fri, 28 Mar 2025 20:41:37 +0000 (UTC)
Subject: Re: [GIT PULL] CRC fixes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250328163821.GA148488@sol.localdomain>
References: <20250328163821.GA148488@sol.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250328163821.GA148488@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/crc-for-linus
X-PR-Tracked-Commit-Id: d48b663f410f8b35b8ba9bd597bafaa00f53293b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8a4eba343cafc7e9ec11e45f53eddb88f90e397
Message-Id: <174319449575.2953471.4593699582683604847.pr-tracker-bot@kernel.org>
Date: Fri, 28 Mar 2025 20:41:35 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, David Binderman <dcb314@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 09:38:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/crc-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8a4eba343cafc7e9ec11e45f53eddb88f90e397

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

