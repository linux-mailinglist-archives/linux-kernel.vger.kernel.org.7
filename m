Return-Path: <linux-kernel+bounces-767297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE360B2527D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9083A169B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F02F284B37;
	Wed, 13 Aug 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHnN5cWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B85663CB;
	Wed, 13 Aug 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107460; cv=none; b=bXJM18POZeXTRmMYINgmHCC50j7pr4yGox10DPk9fl0VIpcPRwZ1c8/zOr2mPcrNhCYZk4ug3cOL5PRiY6GsQwPdWsLoHQ34TLxIamKHfnzZ/SS6uVimnxuiwxrQNdZCP8y/p8+FxN3n0kxlabmVKGzKKSWnSdTkZ5pWchTQICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107460; c=relaxed/simple;
	bh=l+3B3qZ/fs5xlEzmXButFC90RvVzWdE6ki9Ufz+8wfI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NU/f+QQ7OBks7TO5YbLbLg1th7p1vNF8ffTBcb4KKqzfbtJdvCt94jBHE8CNnXlg/vZMa0gjhpdzYFqQTWZtR+ZA6L7r0gr1gTvf/zq06Uc1ypyVge7RP6h9pwLansm8GLkXQrC9zWZi1xPDM5889crxTI3RGxy/9z9RjgctGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHnN5cWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CA2C4CEEB;
	Wed, 13 Aug 2025 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755107460;
	bh=l+3B3qZ/fs5xlEzmXButFC90RvVzWdE6ki9Ufz+8wfI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iHnN5cWNtGZRjmDFwBltNPrA1XQIOjYoyCyYJCYTt5t499CoKo2WmYsCzj6eztcmk
	 +QP1mDKTuABNiLZbnojbM6kyv0tV3sUWDiHvQ25j3VnDkWToIdUbrdXeSorCkfO21f
	 lrR4lZBBLm6Pf5rhnqb5rEGXe6U2xAtsamNWFjw96dc1QawsYbCHlaLflTuk940Pa6
	 QolcLQmLKx0vPhWqfJYAQf8wEVHBp1JyCuGvzfGLpLZZ88ijCg69KaPH9a2r5T2w3F
	 /WHQb5TmPuHxO2eRyHygqZIbbl+6p0BaExIxLjbuFPEPz1cZ8Kh216KhZDNwxEiOp0
	 SFnltpuvdf5fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA139D0C37;
	Wed, 13 Aug 2025 17:51:13 +0000 (UTC)
Subject: Re: [GIT PULL] RCU fix for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250813160340.GA3357@neeraj.linux>
References: <20250813160340.GA3357@neeraj.linux>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250813160340.GA3357@neeraj.linux>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.17
X-PR-Tracked-Commit-Id: 61399e0c5410567ef60cb1cda34cca42903842e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a4a0367c9f45b025ec57e1ba492512d5479d361
Message-Id: <175510747172.3688691.66279513410537071.pr-tracker-bot@kernel.org>
Date: Wed, 13 Aug 2025 17:51:11 +0000
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: torvalds@linux-foundation.org, paulmck@kernel.org, joelagnelf@nvidia.com, frederic@kernel.org, boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 13 Aug 2025 21:33:40 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu.fixes.6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a4a0367c9f45b025ec57e1ba492512d5479d361

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

