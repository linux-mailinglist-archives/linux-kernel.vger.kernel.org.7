Return-Path: <linux-kernel+bounces-842128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34675BB90E1
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23EF24E9E43
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18496286402;
	Sat,  4 Oct 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjRby3OG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DF2853EE
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759601999; cv=none; b=rWkxqgIfNnjNTp+H+z6QG6Tpw5kBzSqXsLoq9/x3GNhwdfRpj9QY9CQ2R8pIj0v7qAFg85uV0ZvidMSwcCPtAV0xPWI6rYLimUKw11cGyaXBNHjXdNvNz3z7MIpJeAEZVWdoEmgauXlHKrzPyXudf+Dx4NCyF0wJfdZjmM+V0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759601999; c=relaxed/simple;
	bh=VD8DWuzujoYDrh4QEC49bZTqjXvWtspFNtearN4zaCs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=My8VOfbnb0xDfmu51brkSENgrQ4WxuhnPXvN0QhWRIS5d4iE/sY/gElvJJEVK4SL6RbTwr8nsTvDDkydronB2C0n25HSv0wNLgceXxAsTETYNR0Ty9IbymQVR4V9i/0Lud9N+1VYBV5uIjre7MEHzHERaE7UhyXMMkUWABSwD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjRby3OG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056EDC4CEF1;
	Sat,  4 Oct 2025 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759601999;
	bh=VD8DWuzujoYDrh4QEC49bZTqjXvWtspFNtearN4zaCs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TjRby3OGQnYVZV9roHilvqDEj9qeWy321gsZHYnwS1J//Dp8iPfdMwySSWwO8Wn6G
	 WUt06wwOlKinYfngR0wRyp6HdSq8XqJRREMoL0BTlQMZrZW3KC9dYSz+8M6/BTJ2VA
	 MVHV0UVV7GRBtakBddcEHQtbBphM4LOMKqVfxd6WzRelKsEZ7PzeaAgfIjvliJShEa
	 a4CtZVZxH+n0eruh6IMeuUiFk0q3/kuAki1r7pFWmDnG1f2R30Ocsk1ybvn+Vi4/Z5
	 XhoSja36b72Ihz51e7dGSi0zSe13iI+pznUKjMfEFuFUY7IdvB5ldHugo8NIOohVHA
	 ejR9/axhQ2J9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFA339D0C1A;
	Sat,  4 Oct 2025 18:19:50 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251001171529.901044-1-dave.hansen@linux.intel.com>
References: <20251001171529.901044-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251001171529.901044-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.18-rc1
X-PR-Tracked-Commit-Id: 86e6815b316ec0ea8c4bb3c16a033219a52b6060
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be786eba12c87dc04ad8eac408dc17369c04ad47
Message-Id: <175960198961.404121.10902744310394647125.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:19:49 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  1 Oct 2025 10:15:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be786eba12c87dc04ad8eac408dc17369c04ad47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

