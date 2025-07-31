Return-Path: <linux-kernel+bounces-751441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ACB169A8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B8F6215DF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614512D023;
	Thu, 31 Jul 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHwlXBDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2825760
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922092; cv=none; b=dT8BjuIwKv8zmpmmmMpZpKOUfBExfOinNBtK+4MVmTwM2OmA1Njdz/MV9t2vBNvW/IuJjIK/FjdtZKtrsbRVtje5VOnKurTrIYAMCLIs4zCH1gVFaj2H8a9GOFNug9OFv6WoWFQvyW9ABMSWPqQYBeJcIKbd2iu/ZrvF/Gr7U2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922092; c=relaxed/simple;
	bh=Wt55UtMbVRyQ/G78HubkFNMB8SGow7TyDvKTfz86VVA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gN6R/ygsiaIqozZqlgMCxOkokK9OyKeoeziHTyv198wwo8dJX/py0pAKsyC9j8B/6W07t2/+DCtxBUfYC4zjGxHe57tkI9VMQkjmhI5D2wDry95WPI2OpQSVLM6Ipz/BytMd0Hw2RnQNnA/NUirpiTlfMyqiqgosErwVLjDkTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHwlXBDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEEFC4CEE3;
	Thu, 31 Jul 2025 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922092;
	bh=Wt55UtMbVRyQ/G78HubkFNMB8SGow7TyDvKTfz86VVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XHwlXBDMj6vzHTcKFgpUUPA4WUSAwplvlkY7F0zxI3x4ND29PT6p75sixqp+cO4CV
	 RsECMvSfwYr6z1cO02nc6K7Qv1hFwy8qJhudr6+HWFaOkbECw/FzQ690ZEIk07w+Wq
	 X1a+eLCyTxOdvnjBi2QBv2FT2qh/AB4cegqjQ0B7JQvgCazt2ZbfK3YzZG1w9lRukj
	 StXJEbLxlx44S181bBTC9OfUKFMUJs1WbFjavJWDIqWLyasAuKI3m3Y6L4sN6w4pki
	 UJ8o+0pePdguQPA4y6515BsEfKf21AvxVe9KrVfah8LqsF3/UMI/3VoQb88lSXUVz1
	 Owo6IBrBh+2Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE001383BF5F;
	Thu, 31 Jul 2025 00:35:09 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728060614.4875-1-jgross@suse.com>
References: <20250728060614.4875-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728060614.4875-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc1-tag
X-PR-Tracked-Commit-Id: 114a2de6fa86d99ed9546cc9113a3cad58beef79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d767a9528f6d203bca5e83faf1b8f2f6af3fc07
Message-Id: <175392210839.2556608.2210035374951503206.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:08 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 08:06:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.17-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d767a9528f6d203bca5e83faf1b8f2f6af3fc07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

