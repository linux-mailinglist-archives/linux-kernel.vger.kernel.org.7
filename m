Return-Path: <linux-kernel+bounces-836907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03622BAAD8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E161C0082
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130101A8412;
	Tue, 30 Sep 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stINhdSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED5748F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194799; cv=none; b=nG3WebunSeMLVKkUpi/dliBjya5sKq3wDrvp6o+2k4gLoEzS2Yli2hG5zi0jbu8Ju48qs9gwhIhl9YmyDhjlxnIcUkfXtR4mb4LiZGR3mQZgLLBeE8WFqhoDEeZ0Fbod7rG8yNRwR7H9UunW2xEWtSt8YDBy4MthvDiGy9ntBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194799; c=relaxed/simple;
	bh=dVJvFROJVwfRcF44oACyRSk7S/v6UnOctJZSuIkqFo0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C3lhtRnj+OFvqA0cKFtR+lLNlpeSclJFdBGQxHEzrCRm8GTSqNBcGaIndXbxCLb3oUzhFSRFXEXpohSn/PiJZMgCwdz7ilPVdnInbfFf8jUUm/TbAANgJdT+0njQABfAP/+yTa1HsO2e4EI3L6Ii3auyTByOV2hMc2g1vMacTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stINhdSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FC2C4CEF4;
	Tue, 30 Sep 2025 01:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194799;
	bh=dVJvFROJVwfRcF44oACyRSk7S/v6UnOctJZSuIkqFo0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=stINhdSNJRSETrpKQTBvARIb289Q1fVoaBS3GKYFsM/2P2/djzpKmJda3Y7Z1b/8o
	 6lemEdS9qM9tIhtH5lrJMI3WnSO//TkKkeLBoBajm/dGwtFqSm6pNVNHmDGitOzUxu
	 si7XVQbNlMtqn+TuA+ZhL+myVzIosPCfyLfO/QELZJZ8eCKiTF437uKPr9JPax63Rf
	 xxYr3E7s+LwmNSg0nucpmd4iCXD4CpaR8uyYwxE6dgtE2iJF3I/e7813nPX2oCfSZk
	 r3sFMdRSunNRQ1Z9rN/IY3zsZ9z4i9rvm/QxZ+FRR3OI4uGcv8df9sazP3KRW2bv6L
	 JeBaE8v68tfdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00939D0C1A;
	Tue, 30 Sep 2025 01:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] ffs-const update for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202509291157.2B1EA74A21@keescook>
References: <202509291157.2B1EA74A21@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202509291157.2B1EA74A21@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/ffs-const-v6.18-rc1
X-PR-Tracked-Commit-Id: 95719dfa323709c06ec34cc96e73e0788e19934f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1ed3021883f5e49f74dfb41ce0a24e5d07fdf0
Message-Id: <175919479261.1773917.17073345039631695771.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 01:13:12 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Kees Cook <kees@kernel.org>, Linux Kernel Functional Testing <lkft@linaro.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Stafford Horne <shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:02:45 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/ffs-const-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1ed3021883f5e49f74dfb41ce0a24e5d07fdf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

