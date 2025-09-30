Return-Path: <linux-kernel+bounces-838168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D07BAE969
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770363C89EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428152BE051;
	Tue, 30 Sep 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/5MxDzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2292BDC05
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266198; cv=none; b=KwBvP5BoUVrDJH6Qg1i5qYTszL6VClbW/at95hOIqxjDnejGhSnpSwbQbJSUdCVNJw8IWbz+9z8IkHtSK4B+KUAK7PR/8y7ST7Tv57hxujHU5DNoLV7dWNxESI+Lt7tjmrZ8srX0yhhJLrxYgnq05atStWM9cijdQowHLIgWt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266198; c=relaxed/simple;
	bh=FAUYrHeXsdhrYJ8cJ9jhR1B7bI5tb1LoTt08bIgrSgY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nBkzuJJIpH/nCS+06AGCF3y3IcndXDyjtRxz8vPRaOx859R6x6CZpwP53AshBeVrKXE/KlEteyCMuNwYD2U+fZKN8nxljgjYILIPnnwYn5JczVXU3MIzrHjWgGwOCK/qCG1RQy5MnaCuyxONQ2b0embyZsFhYGu7LyiXN3N8tZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/5MxDzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C728C4CEF0;
	Tue, 30 Sep 2025 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266198;
	bh=FAUYrHeXsdhrYJ8cJ9jhR1B7bI5tb1LoTt08bIgrSgY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Y/5MxDzx3Qpx4hjHtIsQyt+glphardwTdDv6bqrM2z9i5WXRfsiOT98cSMoqcouL/
	 HERvRelMzWtgyX8O2loMDobO0RhFsBXOKNQqRRjH7SD40WA9ItnfNFtvG1Aq/9/XyV
	 M83GSdMMV24bZ0SUYDllqYHz2IOASH5GjgaDKzIq8kadHW7gOnmOEgUwRs4731OiyX
	 JFBPygDGeCMqS7XVv7SH0aH8Fqc+p8k3lTUH7JOP2zqhZdurEmnzTmOqaBoONBTJyj
	 Ky5s7zsm8iJh/hJfhzRRZT3d5pSC4KT39uYPtzJRooh7g3Z8ESOsk8Tz8aD7vJD/3F
	 R+RCfSRwbIQpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7939D0C1A;
	Tue, 30 Sep 2025 21:03:12 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926101136.GAaNZm2JLV-DqtF1IC@fat_crate.local>
References: <20250926101136.GAaNZm2JLV-DqtF1IC@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926101136.GAaNZm2JLV-DqtF1IC@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 930f2361fe542a00de9ce6070b1b6edb976f1165
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7ec0cf1cd79a74399b53453f9c48acbca7d6fce
Message-Id: <175926619115.2146267.14462265575926904123.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:11 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:11:36 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7ec0cf1cd79a74399b53453f9c48acbca7d6fce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

