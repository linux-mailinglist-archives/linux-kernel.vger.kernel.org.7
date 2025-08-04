Return-Path: <linux-kernel+bounces-754618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FBCB19A21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4923B4C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA691F152D;
	Mon,  4 Aug 2025 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjxTeM5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7232E371F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 02:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754273925; cv=none; b=fTakkJ10vWH3gSCZ/GspjQFShP7oCbBPCZgEGvc7Ele9XmSXNgBf6/S2ZhjjeSXxoNiAs3NVasdLEt9rWLMPw23FE037rzxpenNuxmUMO+pPOnxV5P+A3GPcgmx6nxBMGWmGq/q3Fajj+f+SqXjijmnrFsI8dXKWp24xQbp8/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754273925; c=relaxed/simple;
	bh=xvrL03XVtT1uRfIlXkMCWbpAdmjMleDH3xLX7av3QpU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PCz2QgIpbv+Lkwl68I+Vy0HxtgFNxvTqjUjbg38P/UXnA99enY631h+GNP8Vskz8zXC1cIFfDryXZ5tyccIVJGywsARmnjsmTKT2d+MeJCVE5bHocVavtuLg77jwoYqYYjISmlkx6T2aDpP7iRjhRzLfDPSGnk6Ufp56ufgloQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjxTeM5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69CBC4CEEB;
	Mon,  4 Aug 2025 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754273922;
	bh=xvrL03XVtT1uRfIlXkMCWbpAdmjMleDH3xLX7av3QpU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XjxTeM5OcdLsH5IEmpFyhdBjKNSRrCaQuGabbKvHPh0967vwvptKSr7w8HFsI2T+5
	 T5UVTvM0eP79vD2tdTq7+42fWRVts3DP1YySDv/6bBrysoy/EmBoWzOdehyw0jgsZ0
	 r1R1HUZj19DcxSk9Aox/tP3j1ara+O4szASrMFOiYxgUtiGIt97h2igSAY2QjfbbYu
	 cBjmxNmajmwVhpOnPlR6HSsDWkAXbKjNL2KP18liZFefk30LAbcz30dDEQ+kbQ9OB4
	 tyDaS8Wz4sDBPF3e5hxt4Gj0qO8BY/2OkBqpadpjYXKDbu5z1gkTw1x9hBKhedIwxn
	 5CTWQauBWQidQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71096383BF56;
	Mon,  4 Aug 2025 02:18:58 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.17-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <9c2b1303-bc28-41c3-b87b-e8640960fcd1@linux.ibm.com>
References: <9c2b1303-bc28-41c3-b87b-e8640960fcd1@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <9c2b1303-bc28-41c3-b87b-e8640960fcd1@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-2
X-PR-Tracked-Commit-Id: cf2a6de32cabbf84a889e24a9ee7c51dee4a1f70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 806381e1a24c6eec2b431cbba2ba1b81e518fea8
Message-Id: <175427393711.614779.15118827673980406029.pr-tracker-bot@kernel.org>
Date: Mon, 04 Aug 2025 02:18:57 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, puranjay@kernel.org, tpearson@raptorengineering.com, vishistriker@gmail.com, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 4 Aug 2025 07:15:29 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/806381e1a24c6eec2b431cbba2ba1b81e518fea8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

