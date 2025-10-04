Return-Path: <linux-kernel+bounces-842146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A908BB9158
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E454E860E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D0285CAB;
	Sat,  4 Oct 2025 19:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPA9eh8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CF286412
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759606207; cv=none; b=d7BlM0Er+4WZ3tOJZvIH4vfoDNBXfuBK4Pk8HbqGUHBXrEJgtcVVZiJ/vzUXc0zIGbMY0g4fkugcmrRpOGtYncDYhJwLjhuJf+ZoKLSB3AzI3pmZzjt0DRkV/kGM4lKOkzSxBHFcIFeLLKFwJ17LF4lyCqlXBnBgYB/RLbJQ8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759606207; c=relaxed/simple;
	bh=TAJE6Hmh3T2fk4TpGHwX9QeIw2ilE10jQ6CrXwHF0sQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ac4w5OmlyyEc4j3BHdZr4SFRK+PXd7/nCO002+1aiNkgwjnLlkrrKi5HtjXpyuztcoF7LzZyrlGYz8j9CtnB+rfIloSWzXwhrUAgVPGyJOk8ZY14I9xMRc8dMyv+2Ye4oInqAbPZLb/LZMkEq9LOdGN0XAybbBNtCp951+eJTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPA9eh8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885B3C4CEF1;
	Sat,  4 Oct 2025 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759606207;
	bh=TAJE6Hmh3T2fk4TpGHwX9QeIw2ilE10jQ6CrXwHF0sQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VPA9eh8A43AZUBQosYysZ1IJgBBdEwzehs76F0oKa88yzvxVKLD3X7Zp1sCh/4KYY
	 A0iQog/o6EJbcRb3LlzT7gPf6VGoUpGXTJE/a7KVkH2XvWxfo4qv+ERXLYLML7aAQF
	 s7q0UBcYX69rQ6zfYyOP3thzRmcuaUQ+CKrRkEdjN3nlKS7a2wTPfmeeiBAPjO/W2I
	 NGNWTUziiGBqZ7gYC+Iynt6MqDyEcFPKAqV0hHumscnkLV+rWPZ5EoJPrYkknr43A2
	 XuTW6j45qDYgaWdqXdKfHitftse5vPb2Vst7tvKdmH93vXVM/G212+9LuLy8E0Lovk
	 Yo+2y85qb+UFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7262A39D0C1A;
	Sat,  4 Oct 2025 19:29:59 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aN5ZxYK9vUfxXyEv@pathway.suse.cz>
References: <aN5ZxYK9vUfxXyEv@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aN5ZxYK9vUfxXyEv@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.18
X-PR-Tracked-Commit-Id: 7a75a5da79ef9006e7f051341b768245c814efa0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48e3694ae7fae347c1193c84f384f4ea41086075
Message-Id: <175960619805.420492.8988738054553274439.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 19:29:58 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 2 Oct 2025 12:53:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48e3694ae7fae347c1193c84f384f4ea41086075

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

