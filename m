Return-Path: <linux-kernel+bounces-750044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A50B15665
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC65A1CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7A15199A;
	Wed, 30 Jul 2025 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcWGUpUR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4088C142E67
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835035; cv=none; b=CVXRypJoAV1lCZa5TDn3Oizg3nGEYV2rybqU0ebtFGtepVWPf/a3DPM6sBD3yd4vV6Ge31qC0tyUfBYdQnOov8hNGRsnTjj6RMnCPwpHt2PPCZ8jpCXZZCPMwLVK9xktB1SGtqUJeOba03BJy0ZuwmJHSBt0I8hNxRT4vtkhiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835035; c=relaxed/simple;
	bh=0yYoua9ehupZazDvzxngVyOEyBC7mL2+QVyOQ9JSde8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j2ZMbFcWtFWQQkLKyAj2VDU6J6mBuhSSWLDYHREau/lT9yOFU0oXOZIS8OxECPGVdR1HoLqBobfY9EDvToKF63mFMRNAtiaYwchZCT0cq04ka2vByCfDO0eqcgnxreeXbnoIWh9lWBPXjwmAiYNob1g0JVpzxXq+A9VrAf0Yfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcWGUpUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96A7C4CEF5;
	Wed, 30 Jul 2025 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835034;
	bh=0yYoua9ehupZazDvzxngVyOEyBC7mL2+QVyOQ9JSde8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NcWGUpURO7YdBO0X8yxebxUVXZVntEQpJ1WXkTaXTw47XWvc/4qXWyh3c2wi3hnIq
	 4R3IcWZ1nSAs59LbkMCuFpz/CNggX9A0aykRUnlyvcQIc0KePojwvNDisjJ7ptas+l
	 SQgLT7FKhdMXurGGKuFeH2QSwFrWXL8KtY+Q44ymHz9DPRrIxM68m7GsDXhTyIFlG0
	 7wGDiVxrTg+v95GuWxzYgq6Zg6iKIiTQpztmoeCia85FUn+LOSVJ5O0KdhlHlB6Jnk
	 qSKefCKegwlHnynwQDAlRzbVanoiZKyihmh8vnGwIkr4f7Ojuxc3DO/z3ClEJbDejL
	 qtoomfCfbnUsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A7C383BF5F;
	Wed, 30 Jul 2025 00:24:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728192031.GAaIfNf-ebodTlXs2j@fat_crate.local>
References: <20250728192031.GAaIfNf-ebodTlXs2j@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728192031.GAaIfNf-ebodTlXs2j@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.17_rc1
X-PR-Tracked-Commit-Id: 9b355cdb63b1e43434d7ac57430d3e68de58338d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01fce21e1a890462ba1f37b577fc96c10753c608
Message-Id: <175383505087.1700147.3018491270766250359.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 00:24:10 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 21:20:31 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_microcode_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01fce21e1a890462ba1f37b577fc96c10753c608

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

