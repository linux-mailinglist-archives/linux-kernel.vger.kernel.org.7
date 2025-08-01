Return-Path: <linux-kernel+bounces-753883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F96B1897B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C0A1C24790
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3AD246778;
	Fri,  1 Aug 2025 23:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhuPMOvY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547B238C2D;
	Fri,  1 Aug 2025 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754091011; cv=none; b=lXfZAJkeK+ctWn0Brj9NVC7R2IrbnZB/aDa/XEyG0VfmJqpJAqEKc68XDvk9GAKJkEM9O+mdRy8HogqzWnreabNJbys9iTGjgv+Ju0fBu3bKXIzf2Ruvh4rDGozF3W3lXClGVeknaKE9h2yCGJ4ibyaIu34VSB/xytueRS75am4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754091011; c=relaxed/simple;
	bh=MZkXuNahhRSAJ9AJKbS+99PPGAhtca7lIoFlI1VefhA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jK66Q5cuQGml8yYu/3RGSMRzA/WPNaNiTsmXkfNk0OWRRThA5n9MjXeLGnk+4L2Mvz3Zilv/lV7MdjFB6aIVDGVd2N3Vlns8hbo0syyHNIxt5We/WsQUS0LLjJci/phNL1+ATlKwmVicZhYoreMllxS66gsdGyct5o8g6PpcRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhuPMOvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A8CC4CEE7;
	Fri,  1 Aug 2025 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754091010;
	bh=MZkXuNahhRSAJ9AJKbS+99PPGAhtca7lIoFlI1VefhA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OhuPMOvYsqmyXBVdDE4GIA6aLBYQ6aM7cQUkK4P+jRoBU04Wftb981pxerd7b8SZ7
	 utma7iUlofNP/l/Awoer6xRLHQ7ozTcg6XLZjJktZD7p6vbotXZxS952Y5UwN92DxL
	 GQshllKWEx5Gy4xdwpWOKEk1zLZcXn5O6mv+msgRGCyEkCgXkRsRqsFidB08tbsc4G
	 QamQ9xND/kTt/YrfQyWDOZ8nv9cBj09g7YsXI4aPIBplmerf+mV6YdhCjb8ByP4J8p
	 48lmU62e6/vKIqGQCjqcxFn2hLc00GUiEdCJARoayJGXqqLYzrtx37FrqNtdgeL9J0
	 MGcjbeig+NEAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8F383BF56;
	Fri,  1 Aug 2025 23:30:26 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aI0Aux1I1xTWtp2r@p100>
References: <aI0Aux1I1xTWtp2r@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aI0Aux1I1xTWtp2r@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.17-rc1
X-PR-Tracked-Commit-Id: 89f686a0fb6e473a876a9a60a13aec67a62b9a7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0905809b38bda1fa0b206986c44d846e46f13c1d
Message-Id: <175409102566.4150140.6663292312194396366.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 23:30:25 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 1 Aug 2025 20:00:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0905809b38bda1fa0b206986c44d846e46f13c1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

