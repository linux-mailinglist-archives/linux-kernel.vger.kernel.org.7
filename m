Return-Path: <linux-kernel+bounces-750146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCADB157E1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51333561C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D8191F89;
	Wed, 30 Jul 2025 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wb7KMtAZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755B17AE11
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846763; cv=none; b=nqAWktJEc+6HhnkDNVliQO5xezwbdnqHlAPbtQ/TBAFxno+OX/tL5I1P/LdNib0RJ7LJNUKpeDw5M/4bCicyHB5O34g/SHNCQTE9a/e/lo4l0eUt69CZ3gvwawQRJFl2LzUjcd6DiE2WKD6BLVkIgxRbY5ZWX0921V/jAfciZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846763; c=relaxed/simple;
	bh=s0UqDdD2vcItUS++pbUmt9deNMP4R43V/iHPYRxJBWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IljhzPsxUpPgJ4OV2QVKZrYsC6/ROQEKThaLPfLx0SY+ngrdj7GCD7WOd4lUPNArNHu6v2sO9NDIEUwhwiTq/gs99UhLUEm/G4YoiyyRjbSohroQsnS9z0HTi7mp7cOj+SkoZhx04rTzkfKTgYP/5nfwnwQpyusxcSfioXDk6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wb7KMtAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133EAC4CEE7;
	Wed, 30 Jul 2025 03:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846763;
	bh=s0UqDdD2vcItUS++pbUmt9deNMP4R43V/iHPYRxJBWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wb7KMtAZsVftdc8+nnFiTv+JoYboatXo5SYdcCR+c8p+IsJXWf1HRGKeZYXsBhMpM
	 BZP305arnpPFJqWRI0cR4inSLVH6eMDLuG+1nuxVjFjouu0aTiedSsg4tKYd3jyhJH
	 Jv0rhYjAtHv80cJQubSs0kKkwyVe8GdAJO39n52GNkWRPtSUuF31yGmhZ6cBDEXzZG
	 aYTg+AzntFW2jVhmLi/mYKL+o5NsYAgGUq2WlYFK6iJmV1MTSEYfA2WByAi1DCaQoL
	 H3nnvpL813TIIxZKpE5Y51zZfag4uQ2BZDKaMKbXSKR3eSKkAIzU4BoOQXecj3tSUO
	 QmFAQObU+fiUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAA383BF5F;
	Wed, 30 Jul 2025 03:39:40 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250725143925.1674618-1-catalin.marinas@arm.com>
References: <20250725143925.1674618-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250725143925.1674618-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 5b1ae9de71335865d06ff0e60eadcf368a735edf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fb44438a5e1897a72dd11139274735256be8069
Message-Id: <175384677911.1749338.2052974279366612113.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:39 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <cmarinas@kernel.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 15:39:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fb44438a5e1897a72dd11139274735256be8069

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

