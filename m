Return-Path: <linux-kernel+bounces-843331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0BDBBEF43
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4770189BF70
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E46248176;
	Mon,  6 Oct 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW0CDtxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E222A4E9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775341; cv=none; b=IclTCLqXuTXdmPf0uFnuoH0QOAB82ktKtx7rhpmLYHrffPlNM29YwqgGTyt9J0JB3xruvcknK2uSN3znNgTDag7XuI3jjIh3SfoBKYdcr5Vb07ZG7upzHK2cBe03eD/OQyw4Th1omk6+/d5qRpXLTpcJvBFoVVKuePi4AXR/qhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775341; c=relaxed/simple;
	bh=ddH6bjW5n6lqnv/OIXBHRkdTFlzaXpxgy1SGGkZ5EAI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k/8A4r4aStgeBDVai1vhBwS3aWAROKzSX2l7iVR+qKGl9pwgxtUg7DlN6P4/YZLvjd90aJVNVwHSD1/KyuscZtuCC9oXDON76inCAXQj9gxWtHiQXaAiBCoDdmV9bXP+PcR231CLcXaiHNJZthCIcy4d8LxfAyf1pok/HlA3mqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW0CDtxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902F8C4CEF5;
	Mon,  6 Oct 2025 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775341;
	bh=ddH6bjW5n6lqnv/OIXBHRkdTFlzaXpxgy1SGGkZ5EAI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MW0CDtxarutwejMMe3lChYGWLfMn/LXPo//P/QANZLs6lzZM/sKZMovCaMpeu0m2H
	 u3iVqmv+7go6/clc0ei7jiO5vkrVSIVoo2pC4nVEWbWzYvejzgVaMQn+jqV21renKS
	 J4k/VPwINlXqWDJUb+q1EMGZmxjkHAmfgVpzB3y9bIHDiw9n9cyDp6tOq1I+XeZBKF
	 l+owHiUUIdreoQ6m5ZT1swXx4qL4cZoh7tLb5SEPXsb2UzP/F2JN9/N8EldT1OUxrT
	 xb6AJ/BW6JMG8Ny0gaD5RHC8GggXwPmgsBGGLdCPTxtmSyK2U1Bs1Tn1aA/bERAqxM
	 ZPNvQBjmdxtbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7142639D0C1A;
	Mon,  6 Oct 2025 18:28:52 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aONwOOvxYbnygl4U@vaman>
References: <aONwOOvxYbnygl4U@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aONwOOvxYbnygl4U@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.18-rc1
X-PR-Tracked-Commit-Id: 88f5d2a477ec64b12e83b488407490bb4a9298f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58b65f6dccb0497802fad938e479df6ec8684c1f
Message-Id: <175977533102.1510490.8501929070794460857.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 18:28:51 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 6 Oct 2025 13:01:04 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58b65f6dccb0497802fad938e479df6ec8684c1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

