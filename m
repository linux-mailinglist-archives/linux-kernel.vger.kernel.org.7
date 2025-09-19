Return-Path: <linux-kernel+bounces-824846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12ECB8A491
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F311CC0DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222B31961F;
	Fri, 19 Sep 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBMvPajP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CF3195FA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295760; cv=none; b=j1qa6p9KzKtOcZFqrlpq8Ul+DIwaem9dYI4K3lNQZJLTptf8+azZZCvS7ErV0wF1BaB2VSNDQKHeK0qtyVj/UhHq0lcnHTQ93TQZ9rGRu+d0s3lyUT+QllV67pAGZcE8gPxFRuo9T0Iac2/VBdWg2v7Y5lOdaDLXEbuICXWcH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295760; c=relaxed/simple;
	bh=Pq6EHbbwb98eZ9sDtiodWWMphCLSDbXllaF1mBAf+FI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pGqg+npwai+AqX0tJ6dAIK6uN3VxztqZ1od0hGNfXwx7GAqN5U3mQxRzAsR0Qi4a/c6ETl3JSbXck3BaOC+CoE4WBDJ8GHvZABbYEwoqjl+tDDjRzIvwe2FPA+YnjHwfUUp8ZOyzdndwh9gxaC3iaIeD5fUCQO9yfTnNOuKq1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBMvPajP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC49C4CEF0;
	Fri, 19 Sep 2025 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758295760;
	bh=Pq6EHbbwb98eZ9sDtiodWWMphCLSDbXllaF1mBAf+FI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hBMvPajPx8+1pCflyg3x19KrHxuzNJLDeGBUo0tUL14X1DaaL/lcGbV/fwp+sTbtY
	 pD/4t7ET/y8vFMcDpfvsa1/9s+LANFzoiMcuoxNGP5mFB+DjukIJHE5SQvsdTt/jgc
	 JJ9f6YebD2DTgABTGXtnzHzd8Y90peo62dLiFFRhfunwgj0BCbzoORKNQTSkSFRyCK
	 tLnFEeDa7ylVEHX76eKpEqoG18d5jkhiRBKqWv7Z+jQy2P57wyiCM0haVdy9DIkzYN
	 ylwP/FOklly6J6V64T6TdyDM7ytMc2s3/R8nskphuv+D5jnKkcCLT452Rndgc3XKPF
	 aOpxy711HbEKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD339D0C20;
	Fri, 19 Sep 2025 15:29:21 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txMJGoLbbEHXCXKzx4=gYSKbKDpar7z5FOHaBgeLagr6Q@mail.gmail.com>
References: <CAPM=9txMJGoLbbEHXCXKzx4=gYSKbKDpar7z5FOHaBgeLagr6Q@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txMJGoLbbEHXCXKzx4=gYSKbKDpar7z5FOHaBgeLagr6Q@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-19
X-PR-Tracked-Commit-Id: feb96ccb33189244eaa5a7e8064e623976dbbfe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2738f5660f5c48eb9254689b569640091d3674f
Message-Id: <175829575981.3599397.12172364391527265150.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 15:29:19 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 13:32:16 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2738f5660f5c48eb9254689b569640091d3674f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

