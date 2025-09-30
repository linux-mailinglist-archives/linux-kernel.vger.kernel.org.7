Return-Path: <linux-kernel+bounces-838167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB1BAE966
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BA11945976
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904329D292;
	Tue, 30 Sep 2025 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ruu+Mrba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5D29CB52
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266196; cv=none; b=kEAIdcAEkQPXpysSEspAqBkWL6IL2NFTp60bxdJavYowZT4idvo1SY3gUtBSPpc+IWNeTXqnWNhwCjCWqjYir/Mz0PiPq1YqDjcVmp3w+hnRUHQB9i8lqbTa2lliBmDtwRPBnmRvhZrZ1wusuSvAJJTZdzDDcPWLT4hTh21G0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266196; c=relaxed/simple;
	bh=LrrADdbfnkn1+9uNMlETLiDQ/oNUQ2/OuAuDpp5eMA4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iwkMTbMSQB9dVE5Huzm1t8KrN3Q4Xdr+AEbOu66L7b2RYXgFz0pKDtokHpFOnqLPDbkXAPLALCoNTFJMeIy3QK4nDB+LxOPYJ9jhD/7ktegehKmdYL26p2KWIri/utABVe9ycWT0skm/3PKR2y5Q3kGOOl8oifSYrH9FqvT/IAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ruu+Mrba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A48C113CF;
	Tue, 30 Sep 2025 21:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266196;
	bh=LrrADdbfnkn1+9uNMlETLiDQ/oNUQ2/OuAuDpp5eMA4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ruu+Mrbaw5CcOpjDCy5ZTStLlH6bgTG1BzXNepSXiCuDx7r4/7kL0QobbVvVtlT/y
	 qTJM1gl7L/3nLjtJ2it1q3bkrSpoKchD9EKvlZJa+brSFF4ZR/Q40JVJ0X3W+Ea+rM
	 3MoZxCbD1Bjp3RPNo9jlW3hidE9PqNxIiZFvtSkYW2izxJd56A+AhvI6oo3zbrGOf6
	 EkdDCFG2+AC4eAmdw8PGSaB7/mG4/TlNGxYht0ZScVM2YZ6WZ8yLahWXgHv/Qh/Pk2
	 6eSSn6ej0PKT3EkRffoLZ3Y4LN2Tyu1dTM8KFwQSDT1I4MKxvoemakgfg8Z+L9awck
	 1RsVClUPKQBkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEE939D0C1A;
	Tue, 30 Sep 2025 21:03:10 +0000 (UTC)
Subject: Re: [GIT PULL] ras/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926100902.GAaNZmPiC7PTIVfWo3@fat_crate.local>
References: <20250926100902.GAaNZmPiC7PTIVfWo3@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926100902.GAaNZmPiC7PTIVfWo3@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 5c6f123c419b6e20f84ac1683089a52f449273aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9c43b6e43643e0c884179fd4598e2003f1a04a3
Message-Id: <175926618966.2146267.875915860691501621.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:09 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:09:02 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9c43b6e43643e0c884179fd4598e2003f1a04a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

