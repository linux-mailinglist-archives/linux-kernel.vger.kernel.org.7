Return-Path: <linux-kernel+bounces-761169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518F3B1F534
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52798189FBD2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763292BE7AD;
	Sat,  9 Aug 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgdLF+zE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B59286438;
	Sat,  9 Aug 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752817; cv=none; b=jhlFRZy2Jcz1Icc+KYpHcplouhOzbPVMBKAxBQf8VUruv8/TKQ5QPpsA2OCeEDFZBfiF8fIAUFttMojxZ/wTuwiu6vGmJ+BNlXOmi8v5u5LKCZqj8gXxDXMwqZNLpHP2QVXDeqGxJ9JLAJNC0NTBMC/0TuzLLzIENQhdZAJte1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752817; c=relaxed/simple;
	bh=GMn3gmt3OOgPQZvpdpCMXWfZQk1eAOd981gLGn/PLeE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WRFEmbvbjmYiG9cN8o+LDWXGUFVlESHpQFqYG/IlD3UmYdwq88odxETUjqWzo1QaLE1blznY2NB+sbOhHOPqZcoxkgQRKf+UMlc6nMcNJhRxi8BnSplUMDaa7oWAOGFdYjxys19CG6yhXbXhYaX6vNIMZpJ/hojFLuhZcOT2cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgdLF+zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CDEC4CEE7;
	Sat,  9 Aug 2025 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754752817;
	bh=GMn3gmt3OOgPQZvpdpCMXWfZQk1eAOd981gLGn/PLeE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KgdLF+zEoRwSTDrFsC2cavrhmlJyxroC8ZN9vlNpTZX1atwokoN4qkxFpgvUNGUiB
	 iQ38ETzUv+u2N/HhbByXrD6dcIipWjRxniNByKeGTVGwj/cmopjxRPf3ULrr1rRvYR
	 sWq7aV7zP4pluDP5z5xqXKGvJHPuBKQgRnzif481kC8OYpT0RP11082GS6WYV4LxUV
	 FG66L8AfsPbaDND+lF4eSsWffGJhJcLNFW95ppRW31Qj+hYuDMbBOpK4omlKmPA0zK
	 yveXTx4IK/u6glNFx6KQ6/L3JjsVk30/d8GdHwk9a3R7ZGADvPzqrU1OZyw1IrpKNj
	 Ga6gT1PwERrbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFCC383BF5A;
	Sat,  9 Aug 2025 15:20:31 +0000 (UTC)
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJdf0rAZ5x5klUhX@kroah.com>
References: <aJdf0rAZ5x5klUhX@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJdf0rAZ5x5klUhX@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1-2
X-PR-Tracked-Commit-Id: 55a984928bfa30c7877e28f16910e6de1c170f1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 561c80369df0733ba0574882a1635287b20f9de2
Message-Id: <175475283048.507787.15264559436011835894.pr-tracker-bot@kernel.org>
Date: Sat, 09 Aug 2025 15:20:30 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 9 Aug 2025 16:48:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/561c80369df0733ba0574882a1635287b20f9de2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

