Return-Path: <linux-kernel+bounces-752725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A07B17A34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D7F1C81BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85928A418;
	Thu, 31 Jul 2025 23:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VongiFoH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817AC28A408
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 23:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005612; cv=none; b=hNzNxSo9dg+45pkchBftaGrjxLHcYoLRzezKjXwOfBa+XPyGTQWAvYXtfYY5raz3g7nZrvRvSXVV5zPvxbA1mb2AK9JpTgOxLQlthMtHxK4asSVlsRh1SeUIHJ5NzDgmTPbLjOrPtNBxZMskjjPo/QMxhhBfwerrIMQtXnQB7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005612; c=relaxed/simple;
	bh=Pb/DY1crPV57RsYF+HpsHCbpMipu3KlBtAmU4kn7XnE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=speEqa93YHVIIJVLUCB9PzT+z4zgUmlXAJKJ9JtuAc5RolSFeHzUcVu5d8Qibqtr093oMbOJ4oimlSfN4sKk4RvkdrPrxB1DyZWM/2wNicaVoGInK439zDoS7k7JNGuda7uG3N91GfnDI2uOue4M51D+Rk8DepuZB1JQffUuxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VongiFoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBAFC4CEEF;
	Thu, 31 Jul 2025 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754005612;
	bh=Pb/DY1crPV57RsYF+HpsHCbpMipu3KlBtAmU4kn7XnE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VongiFoHiwCs9L4mWKZ33WpdRu6BmYLMpQSmNl4s4IizlYtM9VZtIQByDClr7s728
	 YQtv3oiFw5QVO6OkTFAJ0CL5dejI5OZ9VFcCpRuCzGq1J/EIBji3PngY/aAK2c0dcT
	 wtdwUuqBFIZosr5Vq/BPGaZRXcvAVUGPRGTn6G6B8moXUT9gGqWVc5dMDuImv9E5wq
	 FeLJ+Yi8TQJ8LwtDqE0smceBzkMNEQdPA8LJXAE6j20+3o2ZP6ueaysDPnhSMW7q9R
	 0LIfyk18jV2N4FbTyPVUb8fmxOfGLsyiLrfJK24IpL5bOm8QmEtEyqFH8/Sya/82yP
	 tuyitb1BMVpkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3A383BF51;
	Thu, 31 Jul 2025 23:47:09 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue: Changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIqjJFLe9V4w2zLd@slm.duckdns.org>
References: <aIqjJFLe9V4w2zLd@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIqjJFLe9V4w2zLd@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.17
X-PR-Tracked-Commit-Id: df316ab3d4440177e322a2847969d356c29b0eef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af5b2619a89d4f1261ddfc310ffd5d1e630f8fdc
Message-Id: <175400562782.3358753.7255771619787184782.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 23:47:07 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 12:56:36 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af5b2619a89d4f1261ddfc310ffd5d1e630f8fdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

