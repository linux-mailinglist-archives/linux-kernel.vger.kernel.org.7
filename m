Return-Path: <linux-kernel+bounces-751443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EC2B169AA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD07E1AA4EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54913C82E;
	Thu, 31 Jul 2025 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8TLhAFe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1712B17C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922098; cv=none; b=J/RGwE/nJgWOaWmB3EuSFQkx2fjxYGpXOcbJeFxGaQyUATTwGRLa+1jY4idH8SJM6snCVa54tgwDkBUaxAl3jR/Ym5+Wk7xHVtmqOFvwIDNvKpgg9WX4xCPI4lmH8bpVD0Wc3ZNKU9StN+0EimVmg0sybDP1A0N60Tp6HACmMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922098; c=relaxed/simple;
	bh=BWMl+8zcLEAr384YfUwwyn4wEMhg2psPTYDuPQ7Mpww=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=X2Q77ZdAusIjom8xvY1232nHZiL8hO777Gu3+QyxDUipDcp39XgxF7s3Ljyr2alZDEk7M0ePRjSxXmty5El3FGk5z0PptYTPtnry1W7nCROd8NH8/oM6IVUmHE2dqXe4LSzeW+pZqbZFs+5ADKDAq1+vSntjoYeqEHKz87g3jEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8TLhAFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93AC4CEEB;
	Thu, 31 Jul 2025 00:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922097;
	bh=BWMl+8zcLEAr384YfUwwyn4wEMhg2psPTYDuPQ7Mpww=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=I8TLhAFeaGedR4tZq6JWX6AHw2IB309FeR+pogY7BdDDxzO8/G8WgxsNurWI8SFe+
	 DLTE8Fy4BQIUk6HK6QmvBh0jALPiac0Q8Q60GobR69PD/KBn+lQPdTt2UYttm91daH
	 3dK4EzW6buigqpRBAGcvHuOCHhJQUPDV2b8LGJ/C7eid9SN9eK35fLKJXl5mdImne2
	 GmPytkU/fvJKHrHd2obBRS4/LA/3NTJn0DwSR0inFqRnpLBVJIO14Y1JpEbzGXt5Wj
	 X/exUCm3sFquwdUcLflu1GfKYynUqN/4prp7JGI5y6ti6n2Wus8zqPkao/TloeYxNr
	 rCjkEhQCyMNmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD13383BF5F;
	Thu, 31 Jul 2025 00:35:14 +0000 (UTC)
Subject: Re: [GIT PULL] ktest.pl: Updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729094119.575dd6de@gandalf.local.home>
References: <20250729094119.575dd6de@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729094119.575dd6de@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.17
X-PR-Tracked-Commit-Id: a5e71638ddd7f1dc0b9f3a5ac8ab8bef48b9f0ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2223228bb1c0608f24cf1d67d1177b0137a2f33b
Message-Id: <175392211340.2556608.442582981394726037.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:13 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, John 'Warthog9' Hawley <warthog9@kernel.org>, Dhaval Giani <dhaval.giani@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 09:41:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2223228bb1c0608f24cf1d67d1177b0137a2f33b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

