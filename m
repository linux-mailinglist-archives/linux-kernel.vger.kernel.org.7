Return-Path: <linux-kernel+bounces-750021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06827B15600
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B917560453
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458402853F8;
	Tue, 29 Jul 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIC8N1TU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D82202F67
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831812; cv=none; b=PUkLVWTOGGbSqKpLqEd1b2xPTvIdzZl+kBQjXLScdC1HWi+JuKe2yb4VGR6aJhfd2gt698f8R/uVACnyCqCXBJ3fLvXJCbXEiRJ9MphPDxMcsSjQGaUb8n25g73SW1HHSj+YSyPZos5wRGUgc3p+vzJszACpnHR1Efm7r/jogIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831812; c=relaxed/simple;
	bh=+aOnLCRR1jpOPF6SmcY2C07m7/VZe7nEWuvc0//TUzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OdFNmI+r8rN84ozzUQIxQvNMGS0SK0zKvU+CLHaRySgRM0dTUw5fqHta+qUOle3+EXmJxg8KapbHDPR7vvlqeuHHkq81oNq3e5uCkvsfh/0WmoELMws0+RdlrEROumVavPDaC/n7+34/UGRZ7S13G+FKYw2ctZQN7xpKS5Cp0Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIC8N1TU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79706C4CEEF;
	Tue, 29 Jul 2025 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831812;
	bh=+aOnLCRR1jpOPF6SmcY2C07m7/VZe7nEWuvc0//TUzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fIC8N1TUkrE36GBINGq5VKs/Pf70WKZl2lifb5YREkmMWQUT49JuQ5wiX6uGaNBFp
	 KCAept4gdvBIjpi/w+J7lo2rAxpSxNc4wb0hxX+4uGZmJ/2nb7j/cJn9nExV8MAwQP
	 CY0pEKT8RJBMdB/zdUcYXa6gZ7odyMBom1nBxxGTk0KgKbZbyxZH0t9WK4c+wixZmC
	 TAB7ERhe1RTq1NZrOdzh0pUik9Nb3NWaMSEH4hi6YUBieqrGaN/7Ht9WgaQjU9dK5g
	 qs1Bz63SREPHj74JVeyfioxjUZmZTe6LrNGNl5oK0tcW16h0FJouf68ZwWhsOG7s/z
	 8LDxYHzwUFG4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04F383BF5F;
	Tue, 29 Jul 2025 23:30:29 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <bfffee49-850a-447b-9c22-b08ad6f885f7@t-8ch.de>
References: <bfffee49-850a-447b-9c22-b08ad6f885f7@t-8ch.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bfffee49-850a-447b-9c22-b08ad6f885f7@t-8ch.de>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ tags/nolibc-20250724-for-6.17-1
X-PR-Tracked-Commit-Id: b9e50363178a40c76bebaf2f00faa2b0b6baf8d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1c21075d30c40762750be0cded9822791df422b
Message-Id: <175383182842.1684216.4215772395299605599.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 23:30:28 +0000
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 00:01:04 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ tags/nolibc-20250724-for-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1c21075d30c40762750be0cded9822791df422b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

