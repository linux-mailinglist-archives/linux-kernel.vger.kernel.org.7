Return-Path: <linux-kernel+bounces-843333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783DBBEF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F723C4D9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAC2DCBEB;
	Mon,  6 Oct 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYHQ9NYV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3A2DA759
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775345; cv=none; b=aEM+6FMTYwMAK6gK9sGq+AmnweJUqf0hSJCXpWN40NVNNLhoTfg5A58O5sIh+QSmKvDTgQcL7d988QaSY2bqUPvlShahEMOvKY2vQVABktTYotFic98Yr2pLOLsfvWa9vltjuWvHpjMDPno0RXgDdAxOvJCMnKwWyb2KuU9jOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775345; c=relaxed/simple;
	bh=6lrMOSLdNmGXBTbj2QGOPNzWNkvQZgmIY+Cje83W4f8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d0fXDQHogMd2PoAp+08HWoLyn8AdNbtLCMmEITcUhBcS05V4tAw0VkSBZtSfEbDbBVGLc7hQoGXJSHrBBrKymoxWp5AH97K13KtiIbrUxHo5JMDQt8udN0Tcr74Etq2bCVkiKUxf5vuCTRe0S58Z3nEGkbWNdU6REKdsvfOfx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYHQ9NYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BC9C4CEF5;
	Mon,  6 Oct 2025 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775345;
	bh=6lrMOSLdNmGXBTbj2QGOPNzWNkvQZgmIY+Cje83W4f8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oYHQ9NYVp+dB2zSmrbVOXEUlqFfj+mNGxQcWeIp+LO8aUX/L0JgNgXRB/eOxNIfVp
	 hAdQyDO3p+KprBQJz0lKVfuATkxdLqn1k+X8V/LSAID4YSpUTLaumV+GHH3vOfGqrk
	 4sEaQBn6BWTYkixz6A/zYS95bqhHSuVJ9g/U0azV4rGe25cPE3Mfvd46zjBXCX8Ywk
	 6gMv9FqZOKfNMRDyQCBAeXJvrIRHQcVD51b/fwDwEL0d4dsf5S6KnhxaE/kjo3hFeg
	 DBeEpNFyhEqyILXjehUgOKpfNEuD4V+t1TNXoGaZrrxPgPXbWfNcDBxmWaOt0pN6iw
	 k3++2mqe3Rwpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5539D0C1A;
	Mon,  6 Oct 2025 18:28:56 +0000 (UTC)
Subject: Re: [GIT PULL]: dmaengine subsystem updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aONw6q7WavFEm1Ux@vaman>
References: <aONw6q7WavFEm1Ux@vaman>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aONw6q7WavFEm1Ux@vaman>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.18-rc1
X-PR-Tracked-Commit-Id: cc0bacac6de7763a038550cf43cb94634d8be9cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4c0fdd5af4c590ca07880b97e286c6532437658
Message-Id: <175977533504.1510490.847467389845305166.pr-tracker-bot@kernel.org>
Date: Mon, 06 Oct 2025 18:28:55 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 6 Oct 2025 13:04:02 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dmaengine-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4c0fdd5af4c590ca07880b97e286c6532437658

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

