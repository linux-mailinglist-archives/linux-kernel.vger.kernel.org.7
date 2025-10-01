Return-Path: <linux-kernel+bounces-839385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE4BB1866
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590194C30CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7E2D5C8B;
	Wed,  1 Oct 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWrexVhI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F1253F03;
	Wed,  1 Oct 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759344161; cv=none; b=c5Lj9OBZOAH7598fbEg1Jc0OI6jCcWQwTHSfZwHnY1e04AaoUp+UWPZfHrJE2aQBSUR/sr/9NdDsI8C5cbvT6a1wZUE+LNcdVA+olgc1arMd0JGQii+/GBqmE/dqzCyI5G2BrSMmCii8UZMb3yhs3ImnMJq65dKM4zzEj1Aum3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759344161; c=relaxed/simple;
	bh=Xpz59ba4Aa5zWBDEyp33avm7wQNDiu78F8XIenapZDw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WQsx54NyGi1dZoK7UrsHy2CSJ4FDoW07O8MFELSUCbcORYBzE5+BZB64OVIWj7CUJ+Yvv2n9ipRyHBmbpd8PSkK4CE5YIhcnt+vq/otWgnMVASEOEPtlmdefJ6aYnyJ1ircixY/l3Nbm15ACz1wqwOu2EmQIoRSxV1iDyFY141g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWrexVhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C0C4CEF1;
	Wed,  1 Oct 2025 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759344161;
	bh=Xpz59ba4Aa5zWBDEyp33avm7wQNDiu78F8XIenapZDw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qWrexVhIbAKN/MGp6ME2HK4Nadr9PSO9iyiTQ7p2CO17WUDCHcN1vvXeP2mHv/JOy
	 6/Mlf29mr2sofQUCjqO1Ayd1TR/r/WvJcRFSQSVOAy29cnzixJ8DtZ2FrG/M3XpLs7
	 cxhv6HV8s9rb+WwDhhyJOB2COTQikkVPFQlhBgz9FaDgcF5EESmhrl9QTXxkBqs1X1
	 me6DuM/KPNnvLMjy8vqwJHF9pD0fFlnSlzyIOP0+juG7L9yStpCuetTpxy+VKaF1Lu
	 RqcnHUI8/BU+81B+1l7Gm0l49TPDYwbP8WisZKVAl3J+TUPRcmtlEaK02JBJLdsFex
	 QX38s752bQSag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB17939D0C3F;
	Wed,  1 Oct 2025 18:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <DD4OZ2NDSZ6E.2KDADLOEY69TI@kernel.org>
References: <DD4OZ2NDSZ6E.2KDADLOEY69TI@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <DD4OZ2NDSZ6E.2KDADLOEY69TI@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.18-rc1
X-PR-Tracked-Commit-Id: 6d97171ac6585de698df019b0bfea3f123fd8385
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb3289fc474f74105e0627bf508e3f9742fd3b63
Message-Id: <175934415349.2574344.9735092221232368913.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 18:42:33 +0000
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 21:48:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb3289fc474f74105e0627bf508e3f9742fd3b63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

