Return-Path: <linux-kernel+bounces-842127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1748BB90DE
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29BF189F7FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16814217F33;
	Sat,  4 Oct 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAGCu/d0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A51E51EF
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759601997; cv=none; b=FWbWhofUKjU7lbeZNDmurxazyLzuvmBVsVp0vCQZ08B2FhXpW6tEWbYPEqQHsR+TzIz3IwujkbSN3CaXc3kmoDzFgcguwDAGd5/3nG9fHVeIybg5tBxrwIHk91pbmTyMZc39QUu+lcIM8japyutiEDoi8FaBPgE9i9vn1kV0Y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759601997; c=relaxed/simple;
	bh=P/bpuo8hPxOEQDe3cAV/in1vL4vjhNnlkKaXYoloqx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ErDOZB8qH8826c24YngNCm5xQfcnGxcJkdGYMqifl21PMYWdlc05bzgO77ieOMQa5Bz0/biOYRdfXsM9phplNGJ0XR8OYvQYmxJGHNHk+OXsM9tXVOZ4hHjlZscl+uCXHVG9w7PDGcvYsMDz0nqciGZabQ5z6HwLvicnT1JyNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAGCu/d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C17C4CEF1;
	Sat,  4 Oct 2025 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759601997;
	bh=P/bpuo8hPxOEQDe3cAV/in1vL4vjhNnlkKaXYoloqx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dAGCu/d0AzUd16Af903ZyCKOY5rOI2MeaPruiYHxAHVXKfeUFQZYdG4n4mPmeRHPE
	 zkzFjcUkYRXQ/V5lt4UtfurDmPI4JMx/XqqWwv98wpIYpid9r+2k+uF5NHi4oQLzgI
	 6ksDiZHam1JH3K7720TUzMqXKJyIRbdy7Up0xwjqEJ/GdltOpk6lH3KWIlF56kuMEz
	 Nqd+yw39UEgq1wD5+vGz7zRKgfVRAIlHqHK4PTNRK3wOy2072VbOLA7NcMCrXpatji
	 Dpx1DR3ujggajWSninaDPLMwM1TELoHpY7cAMTkFN22g9Pe2WanwLQYT30vxn6MZw6
	 B33CvAMybN7JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBD4439D0C1A;
	Sat,  4 Oct 2025 18:19:48 +0000 (UTC)
Subject: Re: [GIT PULL] x86/tdx for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001171112.899791-1-dave.hansen@linux.intel.com>
References: <20251001171112.899791-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001171112.899791-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.18-rc1
X-PR-Tracked-Commit-Id: e414b1005891d74bb0c3d27684c58dfbfbd1754b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50ac57c3b156e893e34310f0be340a130f36f6db
Message-Id: <175960198751.404121.11839054481178891934.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:19:47 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  1 Oct 2025 10:11:12 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50ac57c3b156e893e34310f0be340a130f36f6db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

