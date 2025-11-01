Return-Path: <linux-kernel+bounces-881458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D38C283FE
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E12189B7D6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E52FB08F;
	Sat,  1 Nov 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK3kanAr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910822F656A;
	Sat,  1 Nov 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018932; cv=none; b=M+DKmw2TvHj9mVHz4oUfSb5jd34bu2en7ikCzroGJOPSk92BOppNnU3C74/RHCm0wAoGbV+pH/fSyxamwEV5GotmHcmAHVn3uUc7lxdMqdT5JUaEmALsNk+Y+2lOAW2bfhJnvPXQO3FRiK5StrCUlatn0ThbihfVE+wvCv+ZMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018932; c=relaxed/simple;
	bh=EoMJD11QEm5Q9Cm+spOHn6CndGHLjKUXm1ngNfSiSx4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gjp1kvStNWk6k1Y+XW2cx28DtF4phCyprCAGcb7MSsIjGNSYnKwgjtWZZsUkP2Z+ET58SqJlS561aX3gsc64AoPUQ1+0AZV7brqa5N08wIXgphNwVFrLiQ1KcXgwzNvdOd9cNw7ZswtpGG+k23Ui8jiXBCWkNRL/lOe2kNg8yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK3kanAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68933C4CEF1;
	Sat,  1 Nov 2025 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762018932;
	bh=EoMJD11QEm5Q9Cm+spOHn6CndGHLjKUXm1ngNfSiSx4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KK3kanAr/veg7yw1JH074S6CR3IovcxqVCEeT9UfVaaide1ZMuJ94RRJC2VW568sY
	 HmrayB5vMKd2GLh3PzmYKxohLFvfbO3DL9LXJCPEUCLIRbNcfs0eJBw7nA0zHk49ce
	 lxzw1KrZ5EYtPPBNKPahSHv76Jv21qTS21K4C7eYZOQgKel4Ht7NfaO2gJEOvsaMMd
	 HA4cg/2xxAR+E8w0HsBs0SDMOPZTfFdzKTg82PZJf5rXgoLw7rM44KJxHUA7FdN472
	 ukFf4F1YrzErPzDgZHzz07OJTwo1g87i/aI4sTu3KXY4/uaUBMZkh/ZlMos1hLw0yS
	 GH0y216+prmPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D8E3809A1B;
	Sat,  1 Nov 2025 17:41:49 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for 6.18 #2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251101051443.GA3427600@ax162>
References: <20251101051443.GA3427600@ax162>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251101051443.GA3427600@ax162>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-fixes-6.18-2
X-PR-Tracked-Commit-Id: 43c2931a95e6b295bfe9e3b90dbe0f7596933e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb7f9fc3725a11447a4af69dfe8d648e4320acdc
Message-Id: <176201890776.850663.15719289878184848979.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:41:47 +0000
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Nov 2025 01:14:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git tags/kbuild-fixes-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb7f9fc3725a11447a4af69dfe8d648e4320acdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

