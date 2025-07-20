Return-Path: <linux-kernel+bounces-738302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BEFB0B6EA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009623BCBAB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C822258E;
	Sun, 20 Jul 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLcEvjc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF72206B1;
	Sun, 20 Jul 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029057; cv=none; b=SJ8BJIjouMbT2x7V5s9QTvccoRd+RJdgo0uJ5Y4NN1uYe/1x6OmJAAohUc5FBffMWlKH9GET92Si0ihGiuWSXXSM9QbLm4CgyIohLg+W9kR9XvgFzja7UI2l7HTCTSUTFeENMhHhAirezTDwXvKgPfFnKyfeXrGdWdimZQp+X5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029057; c=relaxed/simple;
	bh=Nt424zWvn+E9abzmTkUPUSFrnUmnZ3CzEt9dvh/IA2I=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FL1jzzTIigZquU/cZYqZaoGeB33JP+XhvIoevMj9jx21lznQtqRRoYp8ipk41/v5EI9vvSH/1KaC5iteYdnl5825sqqMCTYlzsTSZcXC6Q60u7MfTEAyqZhsz/WxOCgmWaiq5cxrnzxdDtV2tqFCr9UroPyk8XBbcfvcY8a4Pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLcEvjc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED7C4CEE7;
	Sun, 20 Jul 2025 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029057;
	bh=Nt424zWvn+E9abzmTkUPUSFrnUmnZ3CzEt9dvh/IA2I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PLcEvjc8iutUvoHDqdN+HS78qNySYBIBevdNxIsBdWAZsJa/soHYPTg6r5gd7WPJy
	 e9cfErVA8kpUsCMfGF4cJzo+5Tx7ut6HOGI691SQZ9ZqbdqI3cUL/ElfaZh6afySTi
	 butCCI/KN+6pNXOY4WzDQQe7m5pQqxINZAF5xwIyHi/2Qm70bXsf3QGKRTcN8yYKG0
	 gnXOuzIXjDefRxLqTz6Zu3hpIbRgb7O9HX5y3qjmtbhrNoRvHRC7fjijrfq9MCutwa
	 1j/40eD++7UrH6GOnphj3r/1N0kvy6wU+MxothDWhdBAAw0DbXZyelwhY69yngQWR7
	 Y3keqgzegkeVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCDF383BF51;
	Sun, 20 Jul 2025 16:31:17 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHzI4aFr-UNU6dZX@kroah.com>
References: <aHzI4aFr-UNU6dZX@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHzI4aFr-UNU6dZX@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.16-rc6
X-PR-Tracked-Commit-Id: 2521106fc732b0b75fd3555c689b1ed1d29d273c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f066b189f91622f3a3a231736659f25eb6e30b0
Message-Id: <175302907621.3241589.9356753648255668916.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:16 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 12:45:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f066b189f91622f3a3a231736659f25eb6e30b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

