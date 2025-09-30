Return-Path: <linux-kernel+bounces-838171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C447BAE975
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B24179EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB8428C87D;
	Tue, 30 Sep 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJiLM4Tv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7D2BF01E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266203; cv=none; b=rwY6chJ+leOCU6UMwqNstHKN3BF4gdtFRKWqSgb7RHk9aZA7w8k7dnhiD/Of+4XvM3HcHVyfATLr/2WClNlLo5fGEqfxf23AfY/aQhG6ah+PDGZKVyfLkvFczxmzRoVH/fzlFH890NSzV04lHRlKFoSGgDwPRbiLivDfcBKBTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266203; c=relaxed/simple;
	bh=ehy3vWk2ZpPbV9JjwpFC4nY7vbTtWIDUHBACxTNnjyQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MVjLe4czud3ytCiO5dDOPaMVrCWUqut1OvuFbmLLhy9lNZyjqB/fRQd7Ks6bb2brkwv/mU5NfVI6rAI+/p1C4x4ujP7/2YXn1BlfJ2nkBu947gNpgF5r+y9kUr2OXJHnqw3Hd3l93jq1ykE1qsnff0tTBjiYmguW3iWPc5euj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJiLM4Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D11C4CEF0;
	Tue, 30 Sep 2025 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266203;
	bh=ehy3vWk2ZpPbV9JjwpFC4nY7vbTtWIDUHBACxTNnjyQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LJiLM4Tvjmpx+YxCVOZIRNL0RCJ5s5rNYYsUcvwV9xAcelnA2aEkU9LwuFFbHwCjp
	 iiboFew8xZvJj5xCZ5kaa+SBX6FDfYDPY6fy9nANdwMIBd80Bo+Q0yM/UTzCKEcJa7
	 3kcsePYFq/e58D3usWkKQ7/h+S2ntFCZXK96dYrTQ/ZYE7LAy8JdPWFrimoW1fyqLL
	 GkG0+HsVTTJxTi8qyCzKfVErwpeFD+cWI7IABJbVHMzsNleCltKaNUmZAV1sgFZT/s
	 FJcwVtfcJkLCj4xlB9rGHjW5Js3ObmZEAPlQpbVq4S1EOX8SEI5hWEqfS6gTUyD3sF
	 b9oMBgtHgJw6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEC39D0C1A;
	Tue, 30 Sep 2025 21:03:17 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
References: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926102823.GAaNZqxzXkasrXXFjn@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_apic_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 1f6113ae5ac4927fe80256154ebb0461e670fa85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22bdd6e68bbe270a916233ec5f34a13ae5e80ed9
Message-Id: <175926619642.2146267.15867067380313311821.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:16 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:28:23 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_apic_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22bdd6e68bbe270a916233ec5f34a13ae5e80ed9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

