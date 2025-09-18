Return-Path: <linux-kernel+bounces-780661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35AB307B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7137A1D0240B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA32877E0;
	Thu, 21 Aug 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVdp9sGW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33101222564;
	Thu, 21 Aug 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809123; cv=none; b=E/xTrFWo3BwufLHD0bn+DAzcubiIGP2TGXnRPjg1R6VgYWZSBAwTCnIQjkYvXxGawiVcyLnufAAq6s4fll7OEQVyrDlggTRNzhqz6rjxU1uT5B7A6VYAUmyqBDLTkBWVXotZL1IQI9ProVYSgBzpj5VTa2+75UT5oDEqVIev4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809123; c=relaxed/simple;
	bh=/L/78zovmejgOYF50XlH+w5a0fU+/Yp2qKn9R8aQx/o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WPAnyeDDAzVseEyqnZw6F0chocWL222SNQcQjHeZCEfMQKXUuwbPgbLPzdtBQm6JQXT/YP32TPhOpiO5DHwdDZzhhTszADT9vd1ynTUJW/gVtaLrwK4qiyWwx1l6rq2tMhUj2CIchyqRTa/Gg2xFVMWtubAtF/vJI/jWi22obgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVdp9sGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E0C4CEEB;
	Thu, 21 Aug 2025 20:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755809123;
	bh=/L/78zovmejgOYF50XlH+w5a0fU+/Yp2qKn9R8aQx/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eVdp9sGWMS8dFoIn0DfFo6IQ13yykrqREaJ169nSa/IxWZZjb4TSoSecK+49EqJNr
	 u6QCy43YLN5xb1yCbw5ibu8qbRaa80N0+XfSp3kRfnKKUK30GXVDjCGeDMDYZVjW7h
	 H2C9qB2GM0M596IwyH5YBzjJt8uCZLuRyKr/ZDsl/QHBlKF5PWNEf0SxXoGps3MEk8
	 m/X5O+ielLp5a0CwqyVT7f4oaB74tYTcM/t0BJd8ZaelnfCUvNEDuAgax6YZRFjnXy
	 bIDyxCaqfiCNbFSqs0QPo6fyGZczs9PkHqLekrNDpBq68OhbYgfykORhGJ8YaBKnkz
	 KegGoDGEdDbug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714E8383BF5B;
	Thu, 21 Aug 2025 20:45:33 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aKd-G9DuRlPJdQgv@slm.duckdns.org>
References: <aKd-G9DuRlPJdQgv@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aKd-G9DuRlPJdQgv@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc2-fixes
X-PR-Tracked-Commit-Id: 6563623e604e3e235b2cee71190a4972be8f986b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3957a5720157264dcc41415fbec7c51c4000fc2d
Message-Id: <175580913209.1197229.13837000216077258535.pr-tracker-bot@kernel.org>
Date: Thu, 21 Aug 2025 20:45:32 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 10:14:19 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3957a5720157264dcc41415fbec7c51c4000fc2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

