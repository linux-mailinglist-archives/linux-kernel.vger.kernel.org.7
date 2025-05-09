Return-Path: <linux-kernel+bounces-642258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E0AB1C57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC721C23D45
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF03923C51E;
	Fri,  9 May 2025 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qt1vLv2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5692163BD;
	Fri,  9 May 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815425; cv=none; b=HmfauslxBRo/bNx4VdRubcijA/GnLrI3+/QP4i575iTvfMmucnHXZX+rWMd8AzHCPE06vcwShBC5C2K6aMFUEFV+o20pm/6AR2Vh7ab8RnqH+KBorx8WnOF7/gyF6iIiLtRwanNU5zaJ+WFm6PDKwF7wjzl9uznb2tO5Dr+gAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815425; c=relaxed/simple;
	bh=eyudijV92ATWN/C1/x0IdcKPdJPWJbgeClE8iGejXyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G6gZ98wVVAShRLe/f/DAxq33yWwq3Szb/MBe5szcXqV4i5hugar69GGVy0e5kbme8sI3uPZGkxglCQsycSGvhTMYzdu9ob0gxrbdAN4qBsSYI3AE3Tolmpt52HeckXsiIf34nkexfUxVRjkOIZMkxZhXkeUTzxmKxtIgzuCzYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qt1vLv2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2D8C4CEE4;
	Fri,  9 May 2025 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815424;
	bh=eyudijV92ATWN/C1/x0IdcKPdJPWJbgeClE8iGejXyA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Qt1vLv2QQZWH+NCn5unYHIStwyySshSLp+Bh8Sp2zON2pGJR88IEPNIpQ7e7tPRET
	 i9Pfet7Zsj6LwxMWB05M3xk5fluysGM4PXx06MrarIq6NQIh8qpfvVRWcebKTkbUpL
	 jddYWszGThCPFcmHlw+Mi+MTgRGHgWIUsp+r7T3UVJmSMX70tRiWpwe9KkLtdFiEnI
	 jDgDgPLVxzS9uFhtwmLnHUuTqTyFtAMWz1WIAvpCpPUDFlILW7D516VkshBBCqczcI
	 WFP5zkl6/jRTpF1HmZ9YllbkcW2i3aXktAg7jdTenuAvbwRjFx0VYeBgpe44OKlo59
	 b8MB0ihDgQTuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D9E380DBCB;
	Fri,  9 May 2025 18:31:04 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
References: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0e82be0f-a305-4aba-b9ab-79596f595277@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc6
X-PR-Tracked-Commit-Id: a6aeb739974ec73e5217c75a7c008a688d3d5cf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29fe5d50dfa6b61043e2e89206389ae56b5596eb
Message-Id: <174681546282.3713200.4462491147537738643.pr-tracker-bot@kernel.org>
Date: Fri, 09 May 2025 18:31:02 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 9 May 2025 17:09:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29fe5d50dfa6b61043e2e89206389ae56b5596eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

