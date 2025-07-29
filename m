Return-Path: <linux-kernel+bounces-748991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B1DB148AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC1118C1BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C30267F48;
	Tue, 29 Jul 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THFbDso7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E03264630;
	Tue, 29 Jul 2025 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771797; cv=none; b=vFzBdxGZLcafARsfNatNrp5ceOKpwZKSbvYOW5qh5w6q9qnq8aqrp5Pyfc97eiDRMm3Njv8AOSnC0VvbH23srkXR7QhxKPnOkxHLMLp8q8dVFLMsKIuURzxeHLLRddYZVkxSEXERKebal0kaOF/po6cLC4nekIDN14GIfzaC9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771797; c=relaxed/simple;
	bh=ZUZybHL1Bg9QPC7gp7ncK5G2/WkaVW3bZoYjVXzmYms=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mEHFvlO/lSZFkWz4Jp9I8Y8TmyCIiCyQW6wnT2IlXxc+9drNFFBxB2kalYShTcLM5BJ6UviXMgRIKdcYDWXiX6m44sz696OXU9v12QDQbV/02oF1DIRQv8iTzuBHewzPpODcCjFZ6Sqi1whXRnQ4RJvoEV1ssvDnMdpDP7YEItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THFbDso7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E7FC4CEF7;
	Tue, 29 Jul 2025 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771797;
	bh=ZUZybHL1Bg9QPC7gp7ncK5G2/WkaVW3bZoYjVXzmYms=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=THFbDso7AQJ0zS/Ej0rttx0MEUZWmPuWtl40CkPfK6zZyXS96CPSVVt8q9W3kdBPC
	 sNY3dr7B98S+ssB2moLpEiOQkA6qzDhX+71uDfquY5z9XqsQwC0lipkOXmYdrwj8UR
	 ByqEe7JiWyCUO+C+Kbe7VWB1TK+erkDLAnFy693D8fqD5MDAvg4kkOXVBHxSQq/v2n
	 9WPFZoSWGZRxe+ZCDn5prUzBrRgT+RIsrVj0hcW8lEJ4AzpL6JxLnGQguzLDnEHGNH
	 hrxuCrRtytIaK4Gs0DmQ7fWuPnsuOCOFPVKyFtA3m2g1MU2Uh8HFwVC+cTiXEWfifG
	 yMqdjqfKphePA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 29357383BF60;
	Tue, 29 Jul 2025 06:50:15 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <87ecu4idvc.wl-tiwai@suse.de>
References: <87ecu4idvc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ecu4idvc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc1
X-PR-Tracked-Commit-Id: bca53a176f3d46fdab67f9e2fb1a185e0233d98d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 177bf8620cf4ed290ee170a6c5966adc0924b336
Message-Id: <175377181401.1356386.7848144941062977251.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:14 +0000
To: Takashi Iwai <tiwai@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Sound Mailing List <linux-sound@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 15:44:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/177bf8620cf4ed290ee170a6c5966adc0924b336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

