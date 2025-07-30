Return-Path: <linux-kernel+bounces-750043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0F4B15662
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8DF18A6586
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3E781732;
	Wed, 30 Jul 2025 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9fCBfu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3378F37
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835033; cv=none; b=Ga/eBHEaELna9nplkwbv7RPWoA/QI06jHM2MKPm4iprtC4yYRsXS+V1U1BE30ipxPgD00lo1FMsSi2XJCKuaqfpS9h8JA12BVNtYx9iNCp5IAXOuRbNvvl8I0aREYAbZ4MxiuL4vnQPjKSce0qqBe5vuZAERz9jAcs1u/0qOQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835033; c=relaxed/simple;
	bh=xDZuoPUi5o+tCm1XqHH5nx9h0OGHjd252iPYsg9u4cI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tfPZanxEEIbelf2raTsAmbADHit5bK/E8LiJ2ygJtLNYTMH+E1osV8pnAcUS5oG/WRxdWzhD8tS8LsE0fFm9ehZg7S7hO4K3HWyvwYBIWYkKVv+ftmG6SnjLSsClFVPiStkOGslaCOjNs4teAOPQH7ZzJKseKoDY1kL/kncHIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9fCBfu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C389DC4CEEF;
	Wed, 30 Jul 2025 00:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835032;
	bh=xDZuoPUi5o+tCm1XqHH5nx9h0OGHjd252iPYsg9u4cI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=n9fCBfu05uZBjbUpSb/q1AxowREI/yMoA7G3fMgkV8dbX+LqQ/PMqTX72k50FQvH9
	 Bg7K8OOA52jo4SyD0ia1j1O7KonTigDkXyKjB9udI8mc4xtsxmaDhdTv78I6fIzUkQ
	 YZ+J6MWomlsiYCPMKHExZAtDenaZcd9ONI8i2oTwSYFIFWqJ4yS2sFX8DVgeYxGxfO
	 ZcWM3iubYz4PHxRcjjFGvoZJYI0hui+xb3RkIW47BMJmQidqz/innWGfHY9siiNboQ
	 AdcrWDawH+6EiulZ2NUd5Cdi4skMP6sZDwYh8hrJl9NcFjEtPi6Ak3KM4sQMg0BTfF
	 jW6NsiAud0jbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A31383BF5F;
	Wed, 30 Jul 2025 00:24:10 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728175024.GAaIe4YLM-e-HL3BvH@fat_crate.local>
References: <20250728175024.GAaIe4YLM-e-HL3BvH@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728175024.GAaIe4YLM-e-HL3BvH@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.17_rc1
X-PR-Tracked-Commit-Id: 4fdc3431e03b9c11803f399f91837fca487029a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb78c145f7f08fda40bcec397939b01be4366c51
Message-Id: <175383504887.1700147.9219910923224924262.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 00:24:08 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 19:50:24 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb78c145f7f08fda40bcec397939b01be4366c51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

