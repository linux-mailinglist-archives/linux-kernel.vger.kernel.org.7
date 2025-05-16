Return-Path: <linux-kernel+bounces-651633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A16EFABA0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8864C162E56
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30351DEFDA;
	Fri, 16 May 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5HuEZPe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406281DB551
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413832; cv=none; b=Fk8ZKZOQWvSgKHOSCZBc7D7GcMrKElJC/fsXxPNAUXHBYiguxEtdqiNhMyS9EW1afBXAJmDo4kVuWJdpFGGTdVS+KF05cZMz4+WLKdC77Mr/ufElpqXiaGYLfsU0DVIg3dM2IQtv9imflZjOM8yMt+7dqSqdCwFDKvcSJC461eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413832; c=relaxed/simple;
	bh=fO/ZaRPoMiycCOi86KDRaBIKhMheuBYditakxp5Ffug=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j/W72GLpzlE/4/KJx18VVjMnCacI77tePwJ6xrrRwnwseSWuaDzoCMUXkAGC00cXLX725koJfAXiE83yJavyow//8ZHnduimHqQwyD6eNPlMO4pwSgXFokB8wNIz5KjyC3SRMUpFoLuEKu9+tryu2T64X08pMbu7eTnbL+LJ09k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5HuEZPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A68BC4CEE4;
	Fri, 16 May 2025 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413832;
	bh=fO/ZaRPoMiycCOi86KDRaBIKhMheuBYditakxp5Ffug=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o5HuEZPeegxv4jZ6196OonnlR0nTgVA+Q5obwz7nXgTsbrQFucxFGk1pf9Dq26ZF0
	 7oHbMRSPTkseq4sBeBQ0CKgy8X+DD6Z1OCCfOR1LdpPVHDmdVMWaP6mBfHLG/ChRpt
	 VFOhAyoZwSqT5oNxdNs1I62pNznkWvFIbE9qDuibGl/ihU5hWQh09fGGGkLgOjhLqA
	 B9c1zcxFumIfnIoKN1TfG1rxEShlyf3Xx5sTYky8qhvcWdZAk+7XZd5tnSL7yx8GxQ
	 spVD/tC1+8/Q4cHUAb0pMHaV71RVEwQqmMWRCeHVkJtE4Kd5m4T4ko8jY+sBNYT6qg
	 d1PMt/7Bnz34A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343B73806659;
	Fri, 16 May 2025 16:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.15-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <98e633a52bdb6705c70a4fd96b2334fa.broonie@kernel.org>
References: <98e633a52bdb6705c70a4fd96b2334fa.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <98e633a52bdb6705c70a4fd96b2334fa.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.15-rc6
X-PR-Tracked-Commit-Id: 6b0cd72757c69bc2d45da42b41023e288d02e772
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8303d1ad7720a3edca0595aabe1a48b828d148d4
Message-Id: <174741386866.3992786.1852530757555014405.pr-tracker-bot@kernel.org>
Date: Fri, 16 May 2025 16:44:28 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 16 May 2025 13:31:26 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8303d1ad7720a3edca0595aabe1a48b828d148d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

