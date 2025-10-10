Return-Path: <linux-kernel+bounces-848641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82E7BCE3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC22188FB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108602FE07E;
	Fri, 10 Oct 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmCt02Nt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168712FD7AA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120799; cv=none; b=JOyC84FizQQY8242Q17jVeIZNiU4np9/YGKWqJ+jOxd1YvOyJzTUnvuAzr2+V2UQuaKoHjqN1UWm+Rop3hs0d4V7sjb0TT3ILMXfX50z/N8aFwOWdpSND6K80Db7hy6Q2F7vSahhgjaiqf9IwfnsiwBxgxd/gbE2tcUt/17YczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120799; c=relaxed/simple;
	bh=eihcW/QjrOICr9EI0nwvrVwf6ShNhD8tussnNc019Dw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ITTkzpokbaP+v0mIpVlEDIgs00+6F9Y2uWNV5wuqbjKxM+011oJZEBYlAl/FBzj58Y4MTrUkaSG2AfA39FJ+n3FsxweCrsPLA6k5g/8XZbe+4y4HassXd+6WtA0Qq+njyGUwFAT3c5w5QhsDLNOeUNGsZJ5GyCTvgehfyEVZWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmCt02Nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7966C4CEF1;
	Fri, 10 Oct 2025 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120796;
	bh=eihcW/QjrOICr9EI0nwvrVwf6ShNhD8tussnNc019Dw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mmCt02Nt6+QMCakzz6XJI1omi8IILCeJmbS7lexIYrKcxbuaA5/URt5NI6nz5GVzW
	 8H6FRY3oERcccT12sSAsToOyhgtx/Kf6iN2bFg//gd+jDbMjapuOgBsDyvY1NBU3eI
	 2V888Pd69Cg7HlUUS11sQHqrPcmd/bg2cnO2usjBUzqT0WFItn9Y9NBbwChFdVLqlt
	 8tZw3aviehINjyILAS2XFO8UXfAR/BkJ2we5iO0UKgbYVhC+cc6JMto+yO5vGsG/LL
	 r9kvANMuiskqwq6wm9m0nb7zzKVXque5dKcJpXc+fUb2NDT+b+lqcUjZi810LCzYXr
	 ++Na+YsgCu+mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ECB3809A00;
	Fri, 10 Oct 2025 18:26:25 +0000 (UTC)
Subject: Re: [PULL 0/2] xtensa updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251010174614.3953574-1-jcmvbkbc@gmail.com>
References: <20251010174614.3953574-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251010174614.3953574-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20251010
X-PR-Tracked-Commit-Id: 4c8bad3ed035ab85ad9b0d247154be43a53ef84d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 917167ed1211b7037534b6e6d7815778b57d310b
Message-Id: <176012078416.1074429.6994484559091074791.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:26:24 +0000
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 10:46:14 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20251010

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/917167ed1211b7037534b6e6d7815778b57d310b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

