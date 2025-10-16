Return-Path: <linux-kernel+bounces-856762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCBBE4FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7DC1A61674
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2522DFA4;
	Thu, 16 Oct 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Umb3rAWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBE229B12
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638007; cv=none; b=JDFlA05B+AxypORnLc3yuPw224OR5ntWqhR4LKa/uYbo6Y/OE35IfSrYR9LauzriWFqrsONPvqniEeArdtNJIDyZllnfZ/ShjNUS4XE29VqQ4E4LuJiLRxRafrwU3z8SIj85XbezyRdHmJwC9z+C1VBXPrF+eBJE5oA5DUXdGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638007; c=relaxed/simple;
	bh=NmIJPFoVfA+biPTVKZIu2PbbMkoT83obfU/u/bHal+w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rN20iy3jd4252q1XReALng/AX51X+osL0E+ZXNA4eJUVVWtaD7DaZ+jn1o/PFIgK8RufExEVFe/1ZvyKAo/2SKGltEP/0m8LwQ0kqMExmc7/kphxZIDCYf1mE1EJQ6xngczrkbxkg2CSpTn61QtNtf/tn6QbRsQFQ4RlCZNFkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Umb3rAWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B4DC4CEFB;
	Thu, 16 Oct 2025 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760638007;
	bh=NmIJPFoVfA+biPTVKZIu2PbbMkoT83obfU/u/bHal+w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Umb3rAWRZbdlIgFdW983R8t5kireFSG3dgEUAxSObNshXzb1ETiRSZUbXfZSsHZOY
	 lTCYmkcTm1lqgRvbBxw1WKgZwkF2j1ySziLP2w180M5UaGnCF7A0sNueg3Euuy5WNG
	 dMSwLeydVxSTCwObSZC88dy4sGwE3nUHV0OwNRiTr/2OiL8wk8evjeT4oQbunv10aW
	 TocVWYX1mEYA8gpzEuCFo8eDbfrfOEU57RsT/gkcl1tM70xP+XGjvNZFWywcJMNWce
	 6YIIQLDKl0sOGoCGCOozbf89W9+rGvdGQzkhOZJTAt21uzJk2CyCrDsopNEYbBp0+/
	 geGicbzmrH4iQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB035383C261;
	Thu, 16 Oct 2025 18:06:32 +0000 (UTC)
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPEt2-u8J16L9Xnk@google.com>
References: <aPEt2-u8J16L9Xnk@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <aPEt2-u8J16L9Xnk@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.18-rc2
X-PR-Tracked-Commit-Id: 9d5c4f5c7a2c7677e1b3942772122b032c265aae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
Message-Id: <176063799160.1846882.1529334845631175747.pr-tracker-bot@kernel.org>
Date: Thu, 16 Oct 2025 18:06:31 +0000
To: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Oct 2025 17:39:39 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-fix-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

