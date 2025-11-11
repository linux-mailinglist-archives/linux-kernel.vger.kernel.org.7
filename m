Return-Path: <linux-kernel+bounces-896043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FBC4F8AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A022189D082
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704192E6CC6;
	Tue, 11 Nov 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL/0H+7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4F2E5427
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888246; cv=none; b=Epog4kZA0/pJuoh9M3YasOUVOPTj3zAlZ9qOUIekDrvJ33rr/S7OZ24xyIT/d9mZOTZ0xfKM51vlKvdJp+gfL2gBhQvwDSU9ngG5Ni0cIrznddT5aiWWgtp5I/UEpFWw5vhZfmjtA2LPRwPWKdzpwZR7CQ0mKBiLj9z0vhxaydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888246; c=relaxed/simple;
	bh=z30sYZuweToMSRbZmmjtT/wBIWBGjpziU0vz9SNB8tQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mO5svLH3WDd5GRvOpDNHOtcU/0OoaeWjItv2iU62f/i5bNYTD1UrbZhZjQFLkwip4OhoJP6Wb/GDSl5lhz0sXx8MGsM/MVHgkDDmsOto2h904b9DQSyrgQ9jh+Mhaxsq2Th9rWcUIyjnjRsYTlRjAWOlr8sYhmtz5B6DDim4+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL/0H+7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71497C113D0;
	Tue, 11 Nov 2025 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762888246;
	bh=z30sYZuweToMSRbZmmjtT/wBIWBGjpziU0vz9SNB8tQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cL/0H+7d+gmHkzQbb+2Z6u/gROBjBU1g0hebfv79C0zz0RuLsC9YX8zKJDc83Rtv3
	 mSqb5fscTv86vbXFQOc03c7tSobXXyO4qORvcFutmRHDEbPl7efD2WxGikxTOYg8F7
	 +f306dTsDg7at3J8/EXCqXeh5gHSOb+BRV9cFgG0SwvckKKro4QC8F73c1o6azTZB9
	 UyEEgjX2JHcrJfNqWRL0lxXxYBo7IUUncq83skTmw6iwZP3u1cHIO3qC5mV1DacjyB
	 qVD5Cvsyv9XV8vumnc4GE1Hwa0Eix50QdATv7Sh6I/MOOuV5oVl/+SKkKJLF6sLDI/
	 tfbtx0GfuzrtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1B78380CFEF;
	Tue, 11 Nov 2025 19:10:17 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aRN7fm_q2B5UzQTK@willie-the-truck>
References: <aRN7fm_q2B5UzQTK@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <aRN7fm_q2B5UzQTK@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 8e8ae788964aa2573b4335026db4068540fa6a86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24172e0d79900908cf5ebf366600616d29c9b417
Message-Id: <176288821699.3548512.978499096605838935.pr-tracker-bot@kernel.org>
Date: Tue, 11 Nov 2025 19:10:16 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 11 Nov 2025 18:07:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24172e0d79900908cf5ebf366600616d29c9b417

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

