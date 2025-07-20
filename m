Return-Path: <linux-kernel+bounces-738382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E518B0B7B3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B70D1899043
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E45222422A;
	Sun, 20 Jul 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvIyc50W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E225221F04
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036683; cv=none; b=jbY4k+Qrr9LiswzAnikXea78rrw+v2y5s4cXtl2gFVSg4pWqLlkK5FfTBuehcmAiVsYGjxSa/knxyYNz9gKU3R7pUTVI6v7p57AMmAHilY7ym36pmdQDYTlKq7+Mcj551bXJbk9wtzMJ52tq0QtpQ0X7BihDLrxjsyehCCkrj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036683; c=relaxed/simple;
	bh=psYgDkmVmXL0zlyYe2AzHPhMeax27UZk4EPNuYD5eJ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gYz3pp6w1qpx/ZnEdCEV4UMhweSaaM55scZZMy5IOgNsLl2okykrvvOTnF7lPDpc6DJYxEIYGVP1YBvJwimkHIoZUAiP2qTjzgcJCBJPQ1VWRIImIjooohnoNWnH5qvtndbQSOa2czEPDoxrsFUE7c8K1J54CdSimQ70HP4K2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvIyc50W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7CC4CEE7;
	Sun, 20 Jul 2025 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753036682;
	bh=psYgDkmVmXL0zlyYe2AzHPhMeax27UZk4EPNuYD5eJ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DvIyc50WxiMNwVf+nLLRzO64iUvgKKnQtf8Wu5p2CokaQUhHGYbC2ijXb45Xt+5az
	 +1H4SMxk0XCWN1EP88C/CRsjvJr3KQ80YRbXi8CuwXcL3dHmIvhfWqlg5aUpLlrriA
	 cqr0tK/Z0fH/WOzBkV8BbiIkzyERMKbSSxR0NrchPuM18gars2gjqSTJzSxeSHUl/u
	 YkvxJ07VVaoi70GCD5oLBEgNYdQDy2yqsLdKD3y2pQPPYcbdtgYOSzlrWYMmJxjeQS
	 bNlk2rqB2tjdIfB5raXsl8WbTaqeUIQtg8sc/ThuNrCp2TwQ+WmcLfhxRT/otSceNK
	 mmIZmfrrMTP6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B2E383BF51;
	Sun, 20 Jul 2025 18:38:23 +0000 (UTC)
Subject: Re: [GIT pull] sched/urgent for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <175301303716.263023.8607719725649129120.tglx@xen13>
References: <175301303546.263023.1426155806374119244.tglx@xen13> <175301303716.263023.8607719725649129120.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175301303716.263023.8607719725649129120.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-07-20
X-PR-Tracked-Commit-Id: 36569780b0d64de283f9d6c2195fd1a43e221ee8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62347e279092ae704877467abdc8533e914f945e
Message-Id: <175303670180.3266248.10573774616354657500.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 18:38:21 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 14:04:59 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2025-07-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62347e279092ae704877467abdc8533e914f945e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

