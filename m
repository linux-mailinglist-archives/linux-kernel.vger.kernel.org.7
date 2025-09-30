Return-Path: <linux-kernel+bounces-836908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24DBAAD90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C42B1922D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D11C84AE;
	Tue, 30 Sep 2025 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+oiogj/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296B1B78F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194801; cv=none; b=OvK7Merj7MF+x5VbaxNTAp4iCoi9XONxUpwFJe+CIVvv37XFDD0Gzb95oITNS0m6xG46yd2Eo5njDNbAzUS+3faU0YLSQbSjT6GP+0c/LlXh1PPGI8UU+j9FwBBo2ouS0zNT9QiyWXO8xxm9k5wubWjyMtB1DFLR48fWngSUIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194801; c=relaxed/simple;
	bh=/Km7aWqIbWdyScndIaOOGW0PRoKjmq/Nj3U7b7ySDUo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jnQ2/7qme58pvqDAq0Jndw7N93N9t03OlVw0dRzw6BIJXNtjkWF9swirWdL41uuuktMbAFX2Y+d/k3ps6xlnml0H1vZHb3clKMpP3e4HofFdWztR8SVmGQSfvLbwo/USzpzBCrFwojRc8U2cfL/SNz1rsqmZ7N/cEyjX27YPsN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+oiogj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A2CC4CEF4;
	Tue, 30 Sep 2025 01:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194800;
	bh=/Km7aWqIbWdyScndIaOOGW0PRoKjmq/Nj3U7b7ySDUo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q+oiogj/rrlfDHg7U2unTjUWlZCrNIBSH23vqqthy7U2gLEYke9EWt+IdAofcpn56
	 qZbJngpk7kfhLtiYViF8vurG2SfuSJeg5IR/S1ofOWRnpwGv1Be5I7Sc67n3ER8eRm
	 k1NqsUwJlhA5KByPNUc2o6PYIXvYQ3eaBhHEhpjMF+yrOy5H/WrzLjoP0QF66SaGKB
	 fZ9Zl/JK2zBmFwMSARD/604vqP7TzRPZgQ9tVpLDR0BUCAhW9DMd0sxfcWhFK6T1Q3
	 fWbGvq9gZTkkN08L7dgNMkJO9hoIio6+7lAwsuj4liLYczc4ON8kVtGeDniJvYRL0p
	 z3uxY8yHVjx4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5A39D0C1A;
	Tue, 30 Sep 2025 01:13:15 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202509291204.89F951B4@keescook>
References: <202509291204.89F951B4@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202509291204.89F951B4@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.18-rc1
X-PR-Tracked-Commit-Id: 8c94db0ae97c72c253a615f990bd466b456e94f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50157eaa0c13bb5aac5cc45330bf055d95d4af57
Message-Id: <175919479410.1773917.16320558870134322821.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 01:13:14 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, Svetlana Parfenova <svetlana.parfenova@syntacore.com>, Xichao Zhao <zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:05:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50157eaa0c13bb5aac5cc45330bf055d95d4af57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

