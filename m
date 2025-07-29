Return-Path: <linux-kernel+bounces-749960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278AB15567
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B995F560F52
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3466E289355;
	Tue, 29 Jul 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wym0GUzP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89845288CBD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829133; cv=none; b=XXjyEaOst6cp7kE+k1Nc15G5HwUAUFgwFKXFuFbe8HeyEiulmx8xekWTPA3r4ZTzkIvRNXnCbyrxfqX9cdKs1wZtD5kb3z0iATi9+kxWswPmUjMQ1GptLJDcBvzdUkdki52StDYUA33Vf87qZjKtoIvRttQd+Bk26HHfr+pUS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829133; c=relaxed/simple;
	bh=g3UEctboRGfuBOQFAm626fm2y91PYd8QMUQnbaAZCaE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YkkkwE+fnaUri0pk5V5djOGmOQLRaa9ITZi1UnhLX5c5slmT/TUe+Gq37UN/6TR7y/zge35C9URmy3THqn6xuffsDeJsAYXKqpVqWLz4x0Roe/JePIPBRcthQzKC5fuesSwFAy2B/V3AhHD8jRJoDq9dnCCS01UEfJ3Gq16oTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wym0GUzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98CCC4CEF6;
	Tue, 29 Jul 2025 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829132;
	bh=g3UEctboRGfuBOQFAm626fm2y91PYd8QMUQnbaAZCaE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wym0GUzPYtRneTbPyoXiPosH1IBjRja/W+MXAcp7X+eXeccSNvBTCt70j6YGQe1YH
	 TX70MEV6x4zDt93QYL7ujjhAAE9B+NIT0QVJJLX4xQBTHq7LMjfOoJHIVhH6PbGS0g
	 2aR6WrSV9x0MXk/hMQxv8+iQZ3TxWt9gS6C/BpzDsf3o1bFckVXV0a47XIrrenPOse
	 687C+pWLB7K1SMAL2+0JG/HfHluggvoPCyaeHDYTpBJZQAjmPK2/ggxMGV9z8ec9tt
	 YRsMwEYE71GrZxk+fdl9+8vEUsIevyifjJ2iysFSdcGNV3sPWJ/WXwmi0zrtEiic/G
	 Y7e3NG4Np6ANQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB7383BF5F;
	Tue, 29 Jul 2025 22:45:50 +0000 (UTC)
Subject: Re: [GIT pull] timers/ptp for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175365569231.581055.7096435229102369205.tglx@xen13>
References: <175365567943.581055.6806236199247802443.tglx@xen13> <175365569231.581055.7096435229102369205.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175365569231.581055.7096435229102369205.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2025-07-27
X-PR-Tracked-Commit-Id: cd3557a7618bf5c1935e9f66b58a329f1f1f4b27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 02dc9d15d7784afb42ffde0ae3d8156dd09c2ff7
Message-Id: <175382914880.1670422.833851785471011199.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:48 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 00:38:03 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-ptp-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/02dc9d15d7784afb42ffde0ae3d8156dd09c2ff7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

