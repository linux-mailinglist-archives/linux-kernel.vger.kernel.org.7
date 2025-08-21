Return-Path: <linux-kernel+bounces-780639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC3B30756
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8F66451A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E882E88A2;
	Thu, 21 Aug 2025 20:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCwsOo0A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5226A09F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808225; cv=none; b=qYVFQy6X+qpvMwBMKH0xDa7K634SXF2E8B3+letHoM47Pz1zdHB4mioWlfR3CqOePaVJoOHuNwYFvRQYi0tTJRm2D79zFt2BK1aePG82Ux1Ok4wlyXiJA791tv8S7S2LahbNvdU9jlKf4WW5kwp0OMyRnYqOY3c4Tc4Mu7Lf12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808225; c=relaxed/simple;
	bh=P+XWaKl3OZkiCqyDn2NpEquIq2Yzh4Mp2tqtPplqRw4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pGq0ioC9k+EUvGmaATrt9bhco5y/nZjrm+lgGeqCe3SIJLNeC/a52q+3fySGeGJn883ZgFGKNSFIiBSbi4yhe4sUeNBDdYceibupJFY+4GhT7ylpwXVNyjCuIL5YLa/FXhPUoP+ShViR01T4gS68WYgzCXLORgpN1Y2Ej06h0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCwsOo0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836DBC4CEEB;
	Thu, 21 Aug 2025 20:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755808224;
	bh=P+XWaKl3OZkiCqyDn2NpEquIq2Yzh4Mp2tqtPplqRw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dCwsOo0AOWIda3fQcvdVZqj7W/k8YLNXsUZYFt+LyFwKd1mVvKynGgF53FAfcRl2G
	 yZeBJZCULCFSzZDL8wammsrH2bDMXALxY7eJMjjEqFUfHVZZft26X0Sc15ZG/RgC30
	 pBwusXZqvBAx6xCEI0al7au6u5Z3xBNoEA+ZL5f4ZiXgqbeEp+bV7Bw9grVbiSM737
	 0+5Q8Bl03PT5RxqoKe3dfYtBYU2+cerGyIrg4YoJMGCZ/fKGZS29QQd0KfKz24+n6D
	 iNNH6uQ3qzCA9wnIYC7lYAFRaCtxMmFd9yOhsKDNUkPVv3X+oPbgbVRqC+cWUuG7j3
	 +3qA7g1mrBcBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8B8383BF5B;
	Thu, 21 Aug 2025 20:30:34 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a9cdd0f4b5e54e9caecde69764cc7ecc.broonie@kernel.org>
References: <a9cdd0f4b5e54e9caecde69764cc7ecc.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a9cdd0f4b5e54e9caecde69764cc7ecc.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc2
X-PR-Tracked-Commit-Id: 11cd7a5c21db020b8001aedcae27bd3fa9e1e901
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f43e6ba0b45fb486cc7d51be70972395dd3ebea4
Message-Id: <175580823355.1190489.1077644333323512588.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:30:33 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 20:20:48 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f43e6ba0b45fb486cc7d51be70972395dd3ebea4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

