Return-Path: <linux-kernel+bounces-815303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F79CB56263
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3259616C5E1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E018207DF7;
	Sat, 13 Sep 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlfepsTT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878F8460;
	Sat, 13 Sep 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757785806; cv=none; b=SnY1eO79Vm738bDyMcIW1+vlcnpHVDbjwtZ9df2BCLS9dQGRPR/arqbx2aEw/ilJQsXCzFofeFBXH6EjlEm+Z4vEKBstcGMqMGbF1OrSK6G4eFv1CSk31TTCTH/YYvkxV6uQH5IBtre9+zXf15PY67uS1DW0+DPM3Grn1s55ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757785806; c=relaxed/simple;
	bh=NJUkX4qJdApSi0mWFjD33fuvXoVp9O0hwKSsheFT/OY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l4uKigURoSZqud5W8Sa/hw2RtOouXDUJ/dcn91+La0pr90SJB1Qj50pSd4XdgV5E7e7HD/fr09XIdHXdVY2WIlSczCJ0qS7rkd7d2bQ3DWuHURJQP2hIh6jhz88xsASyyKSx+1A94ejYF/hBXu3UXlbYd56RuU7DFey9eTlArZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlfepsTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B999C4CEEB;
	Sat, 13 Sep 2025 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757785806;
	bh=NJUkX4qJdApSi0mWFjD33fuvXoVp9O0hwKSsheFT/OY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rlfepsTThJUPgTWwPDREcqOHGrFilduSiE5vmksGXxyYmR9lnZOezm0nT9E7RCLCE
	 7EQaASTyYQNAyFdiD3HyVPKJml3ACiEizj3aUvyvIBhcihu85r/6mCelbtEgHGIMiu
	 CF5AuwF09b2y8phS5NwEyEVQuul7hleYPoEaBexd412hVqoB8JY9nGLSAdjqo25LTt
	 6yL7tYDj/TiKwIvzFqj57L9A1ihON2XhtQmb7sDOVgeAjKGCYDW3JY5r8E0H8+aSgG
	 qmMymxvy6gEcUBrOvAKZfSV8FGQOPaPO6fSe3Y+Nj0k+06Y8TQDUnMFFvkfotipZhY
	 hIkN7tV+mir3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE85383BF4E;
	Sat, 13 Sep 2025 17:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <DCRL0KY7TS19.3SDABYFHZWQ7T@kernel.org>
References: <DCRL0KY7TS19.3SDABYFHZWQ7T@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <DCRL0KY7TS19.3SDABYFHZWQ7T@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.17-rc6
X-PR-Tracked-Commit-Id: f6d2900f2806d584303db689d9e18f0443610514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b891d11b74b447df6e18104199148e420c985ac1
Message-Id: <175778580823.3289187.14747059909385349294.pr-tracker-bot@kernel.org>
Date: Sat, 13 Sep 2025 17:50:08 +0000
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 13 Sep 2025 11:57:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b891d11b74b447df6e18104199148e420c985ac1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

