Return-Path: <linux-kernel+bounces-750023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353FB15602
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4A9561C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE2288C02;
	Tue, 29 Jul 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzEuRTDt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D528851E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831819; cv=none; b=WNwaSlfH+8hLj85aO3NroqroLdflJPt4abJxLVvNLsAv1I/HbCtuSfaUz3Z6wPGxucbIqNB/gcAiqpGTWaq8ey+vytuZSFXIWzflX9YTXIXuyGWvDDNWEXzlTcE0jD+hoTCn7KLOvcqjKWFyYfe9WFjwv21JtTQJfsgA7w6d/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831819; c=relaxed/simple;
	bh=uPkiYxVz+wmDGuzqxTGBTTOVEBbzjR7oqwtuvhnC2rw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=M4ED2IZ3BBSfkC6iyey3hSAzbGQoVCMtK9SjOlO12/6mt88U3uBXf86TNdPaxbQCixS8G6ILe1q6mXtyT1T5aWtxsvGKFGsGMS3Vznx8MpL5Gt2gkh8QX2zqJya4ynATUmQz38VArBTFIsllBtnTtlR5ILohLe6lSgq2sv9rabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzEuRTDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3CFC4CEEF;
	Tue, 29 Jul 2025 23:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831816;
	bh=uPkiYxVz+wmDGuzqxTGBTTOVEBbzjR7oqwtuvhnC2rw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HzEuRTDtMOGFw/tAbViiI3nZVfYRR62X37ohKNFi66QDWByr31xXQ7XLs7RqoKyAk
	 d52+ymV4oYoAOAJy7i8ifPmaIq0ilUjy8FLHHk/hoYCIXhr8jgtOqvWYF8ZILEng1r
	 1285PKuG3dQFT/khhT1Qm3XtvGWY5xW0OmtfX2yF+saX2Bz7PctkMq1mTWPGXV8Snu
	 UtlaQRQfyKpSKzJ82yX0CM+Xf80Z1FsSt7z5g2TJY1US32dpOXp8CTPpFbCUUaqg9D
	 W80jUc/P1v/3UxI4AeRsq01FgVKW3elPAdrNG7fb+kQ7eWeMBCPii3mDCtAXcAiFIX
	 JEKGHCsOGT7sw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB58383BF5F;
	Tue, 29 Jul 2025 23:30:33 +0000 (UTC)
Subject: Re: [GIT PULL] Rate-limit changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <6a4a7b55-6fa2-4f28-99f7-c65135c69aa1@paulmck-laptop>
References: <6a4a7b55-6fa2-4f28-99f7-c65135c69aa1@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6a4a7b55-6fa2-4f28-99f7-c65135c69aa1@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/ratelimit.2025.07.23a
X-PR-Tracked-Commit-Id: 5c23ce0cb897b491a12667e3c15288eb03f8928d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0561bd5692d12d0c52e149e5922e32321f25981d
Message-Id: <175383183234.1684216.12898638460673771089.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 23:30:32 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, haakon.bugge@oracle.com, pmladek@suse.com, akpm@linux-foundation.org, john.ogness@linutronix.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 17:01:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/ratelimit.2025.07.23a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0561bd5692d12d0c52e149e5922e32321f25981d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

