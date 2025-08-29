Return-Path: <linux-kernel+bounces-792162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31475B3C0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C0BA6527D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D301334380;
	Fri, 29 Aug 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nobW7LeH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8783314B7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485568; cv=none; b=txE627BKgW0HhBbIYY6z9pSlXed2jxc2bpMau673UPWJnLdaf9KaqcXQ9se0JveHFx7dCKjj+5BLPa5DaK5++DSlC6CXqgUIa4ERjUSQcug0QNoN2fK1hYp1WAlEY0xS/sFIsmwQPqQbhyE+ld+EXlSJ/ry4PzMk8zGt2ND+aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485568; c=relaxed/simple;
	bh=CpsfS6K6okXUJQ3tecVBkbM/x6ZvzSIUHJiJyXzorDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HvB0YkZOoGpszXoBZgm46Oxuptk5e43sRrnxnie4EvKbX5BxsqLBFf3lf8d+eJuWLge7wWZLR91+Km6LPJFBTilB2JcGdEr5agzAwTxyRO3/gly9g6a17pIynkYVHsKNeEKKE30JYDlDepF+Qt7KQH1MFl9hFsRGsVl2qc7ay8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nobW7LeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B339DC4CEFF;
	Fri, 29 Aug 2025 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485568;
	bh=CpsfS6K6okXUJQ3tecVBkbM/x6ZvzSIUHJiJyXzorDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nobW7LeH6ETDrAHZtoy6Dvm7gMsSb0GGZly4y6gHrgpZNmlIb6w8fwO8bvR3f7NzT
	 I+GAqGUrk4LUuAQiKnny41mvsGpnau3dRSI0MbG1x6WtiRr8N53EaHlVGiiXhIvOJ4
	 cUKM/lH9ULEJO5pJJ/iYxjjRcH4Q5dL7Sen4gdnFR4jJYKnXrguH2G1LwkNOURA9Lz
	 HTw+aLu/irv5+5foBTr6im0cBky+mNGGx1dOrarZgmWD3mksqkhWl2zVWgLScuz6QV
	 0USJA2z9/6NRYb27uYNdayN4Fh8PU6hZLO7gPs7owhJc959BJQZU/Ei1Ki3ZpoqchP
	 DQl5bluWUkFaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6B5383BF75;
	Fri, 29 Aug 2025 16:39:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.17-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <832d6a3f-40b2-4e81-86a0-99d6ad73f1a3@linux.ibm.com>
References: <832d6a3f-40b2-4e81-86a0-99d6ad73f1a3@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <832d6a3f-40b2-4e81-86a0-99d6ad73f1a3@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-3
X-PR-Tracked-Commit-Id: 8763d2257f5231cfdfd8a53594647927dbf8bb06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 606c2cf67b6b8421ec40769f03d8b30759df27c2
Message-Id: <175648557528.2275621.9941916824294659088.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:35 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com, gautam@linux.ibm.com, jirislaby@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, masahiroy@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, zhao.xichao@vivo.com, Christophe Leroy <christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Aug 2025 10:58:49 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/606c2cf67b6b8421ec40769f03d8b30759df27c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

