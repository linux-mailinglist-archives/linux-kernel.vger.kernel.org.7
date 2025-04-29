Return-Path: <linux-kernel+bounces-625894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CBAA3B90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 00:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD5B67AB256
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26494276026;
	Tue, 29 Apr 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGvx6ljn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335B275118
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745966133; cv=none; b=h7bp9yyT40D9/bmL4ILAXHkuzS6hhAERLA+tyMf/lAqlGDkaZsYLBM0KYuNDDbt45jUp79GuRNX3qCOevG/1gGWfKXkGOcK8ejzwknB438eAQxbIcYfT456OdDSuQPsXyc+b9lasueRjbyR3iE8wMoOSfKvHRvjhOOHYZqe7oBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745966133; c=relaxed/simple;
	bh=0GmEEqILo3WJxOLDr1XzUI8qU6pKLiPuUgR1FAjlSco=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C/iQUzLErQ945ahU09PFOY1fuITH6okzI40m13KBhxwxytTUwK6w6R8v53v9nJblJiFMfdV5UQF+dFdXlhtizfp+mWW+2Q02BeT0nzjkmnHHd8hEzCR+sQosFU5eteJdLObJ/Z6Rete6MpQ5kqXUWf66mLESLnw9y/wUpsqDZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGvx6ljn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38D9C4CEE3;
	Tue, 29 Apr 2025 22:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745966133;
	bh=0GmEEqILo3WJxOLDr1XzUI8qU6pKLiPuUgR1FAjlSco=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bGvx6ljntFYnsoc/xLDLoZCe8g0VOBQEBvIev6TVzWq9GsTyxEZqIKem4FezJ3ggk
	 RghGjR7z1SFJVHQZXAeUjZr6Txd9VNrgFWtOHuzm/qSgLMwbdIBnx2hoMzOe4DOJK5
	 Mzatk3ALnG8sg+wHbk5TRJZ1JisVEFugbEjsYeyYbe+AHkUJRG7DclFw9xmXcePdop
	 PucA8vfihzrPcS345vGSXSyTv0Rcny8qozUflTKxdYy1VLDh3eQNZbb+YqK5fCrY00
	 a3jS7pCXIUfPaMHCXN0RWU+0Iy3KHhBWhAEjYCuPBOfI8WFKz1E7faPi1z4d7AsaiQ
	 srjY0jvgeBIIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C813822D4E;
	Tue, 29 Apr 2025 22:36:13 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: fixes for nid setting in
 memmap_init_reserved_pages()
From: pr-tracker-bot@kernel.org
In-Reply-To: <aBBxHaHCu8qyO3E-@kernel.org>
References: <aBBxHaHCu8qyO3E-@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <aBBxHaHCu8qyO3E-@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2025-04-29
X-PR-Tracked-Commit-Id: 3b394dff15e14550a26b133fc7b556b5b526f6a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b5256f990046d479d87f90382dea36c55539c44
Message-Id: <174596617174.1816670.11800328123528857672.pr-tracker-bot@kernel.org>
Date: Tue, 29 Apr 2025 22:36:11 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Apr 2025 09:26:37 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2025-04-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b5256f990046d479d87f90382dea36c55539c44

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

