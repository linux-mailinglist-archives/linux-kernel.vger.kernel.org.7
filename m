Return-Path: <linux-kernel+bounces-759696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5272B1E140
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7D0628650
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 04:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EFD1E0DE8;
	Fri,  8 Aug 2025 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVVUGL7Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954932E36E2;
	Fri,  8 Aug 2025 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754627451; cv=none; b=Z4USL9LTxEGTUqVFW8Wk0/F0TNwWOn6GlZQ1fkfLz59f+eGO92jBHKi2qX3fUG8fy80UpmJk8F4s3jPspBZhfkksK6DHXvLM/rluJ6bopyy0EQzfipCo4dY+J3Wb+vYg/GL/vWDAN1M/ZaqdfzfCAc1cSWb+r+KascvwWq2SC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754627451; c=relaxed/simple;
	bh=ZueiDdll4ThPz9zm2kJT3uMizo+fj9KaIvQAqiaUacc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mPpfOLbgdwLXIwNh+XMEBc6Kny6I+66Bklya9P/5z5onCr7tFAWObqzMeJDfgIFtVaY6884/D2Mvyr+EQ3l2XsU1EO09A/PmcLbimbUTJkYPRR9ujgmZZ6I8rVRSVjPzAfXCKwE3zA9c9Q9LJhitw1v1RADG4CbM+RRzqv1nHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVVUGL7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C328C4CEF7;
	Fri,  8 Aug 2025 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754627451;
	bh=ZueiDdll4ThPz9zm2kJT3uMizo+fj9KaIvQAqiaUacc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EVVUGL7Ybdkpkc8ZenfyHEsVvp6a3bjElE+wZyImMuvPoWxS3Z9ewC6nPKOrhy0y4
	 zYQ/CTiZ9T1jPl6GSl8EU8/COkPZ8fne1Cn87TSk22DOd9wsLuGEnEsGl9IldgEmAv
	 alveyxNuKv9wrYP0ubfqvFtdNylxIj/JBOvddPl9FtnonKiRpn0ZPL0oUlFBD3olLp
	 PJZ47JbQgR865u3nwYG2QaOwXxP7KUKG1/eMn5tgGZBpsRFQC1aAIQMi4R1Apxn70C
	 vGQr28RXnC3epP3zyIoCw7BPEV4LC0TmWc0Xi1czOzzTMCQBCuThBbOcrW9H+ABiWz
	 uvKIEQr6/rKsA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB65383BF5A;
	Fri,  8 Aug 2025 04:31:05 +0000 (UTC)
Subject: Re: [GIT PULL v2] Networking for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250807144940.830533-1-kuba@kernel.org>
References: <20250807144940.830533-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250807144940.830533-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc1
X-PR-Tracked-Commit-Id: ae633388cae349886f1a3cfb27aa092854b24c1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37816488247ddddbc3de113c78c83572274b1e2e
Message-Id: <175462746418.4027442.14553487983303235394.pr-tracker-bot@kernel.org>
Date: Fri, 08 Aug 2025 04:31:04 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  7 Aug 2025 07:49:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37816488247ddddbc3de113c78c83572274b1e2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

