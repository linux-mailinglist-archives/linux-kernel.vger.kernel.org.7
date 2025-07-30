Return-Path: <linux-kernel+bounces-750042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39086B15661
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151CF17A476
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2272618;
	Wed, 30 Jul 2025 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug/MSsvN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6243AA8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835031; cv=none; b=MZb6oyV0zxAjLif2ysLwmClnCiXIoCW44pAqGGM2EQipbJLn5d4D1C4mbmnFk6HMGN2X3N55NB9/hpC4R8GDkOPOcEX5hRNOq2jzBpEWuAV+i14sJH4ijBhdSm3m+U7+stV9e2p7UrFXQiVX4L2/cT2fl4VuhYo3bgmbR0cOL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835031; c=relaxed/simple;
	bh=vlVyWBkNM1i9bRx/abQ6VMRnQaDDFqsSfPemrbaxh9Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DhHjPPqBHXsE9M72OJAsFkxwqBEPb8Lpd3Of2BP55qvIARee3Eo6KZOxuLQy9/CA+0y47d+s9CyDufNbvAechqyUTkn12kkADxdUlrDwJ1QJSI2N9p+WcOLTpqSsgK0Lj7Glhr97c1jnTaFHb8df/cknHeRfOoPgXVoIUkjX/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug/MSsvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B19C4CEF9;
	Wed, 30 Jul 2025 00:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753835031;
	bh=vlVyWBkNM1i9bRx/abQ6VMRnQaDDFqsSfPemrbaxh9Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ug/MSsvN/p7VCK/kyoBa3HdN7a+Sy4VOpSyohgaGVXYJZIXQTNQHNqFBnbq3PTymw
	 PO8Rh9W+zMwBv7Lfg72A4q8rleiAQCRo21otWy009kOuoF3VjoPXyD+ztOk3/cHnxJ
	 HD2uc5sq+LW3SkEU23TCps6rJkB7ehMwv2VBAr+rC9rRoEn0NBsSQWqGiw9fPrs7lN
	 Deu7WRnWjY40iXS5eB7e8sBUch7OZO2PcatbKyUQiofjG+Z+Q7KqhK8jQ226CzYCEE
	 RCFxhn+nRYun5L6+so3c9hsPJKCYZbIULvFJDjjxf1hs0XYsEHJpcgG8M6XzxN8ehR
	 oO5Szoyk74Drw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A6C383BF5F;
	Wed, 30 Jul 2025 00:24:08 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728145504.GAaIePSCpIIIRnc0U-@fat_crate.local>
References: <20250728145504.GAaIePSCpIIIRnc0U-@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250728145504.GAaIePSCpIIIRnc0U-@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.17_rc1
X-PR-Tracked-Commit-Id: a026dc61cffd98541e048f3c88d3280bcd105bd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04d29e3609b62896b94b60250d475f8f7c15db98
Message-Id: <175383504675.1700147.6105326189905844890.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 00:24:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 16:55:04 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04d29e3609b62896b94b60250d475f8f7c15db98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

