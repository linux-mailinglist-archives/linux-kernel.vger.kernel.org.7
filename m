Return-Path: <linux-kernel+bounces-838267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B556BAED7F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370CC2A031C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EC2AF03;
	Wed,  1 Oct 2025 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr0bl4QS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EF92A1C7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276954; cv=none; b=nO4J5IdNkbCrERcNBi+JIIIrrCsvLPGbdEnAPAqYYOuoSoRauD6oEyMmusSVLXbT1xwRFzif5XC6EGaLDbBShzcbCLQdjdDeJjeFsoeiOc9vYbMYNoq1dj4lNIEQoSgG32flrFlLr0MxRAAUbjX4mWFrqlgHlKPw2pfDxAICzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276954; c=relaxed/simple;
	bh=NBGVLUna6tSzI/v4ujwYDIgzDI7rGDKeCOZx6QX0b6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nYVsQiqHjKIQqcmVNKuckktlrkTPsvB/mMRKD7jTXfav7dLxlSdjmV+TLOJeiCBhQmOYaKzcI5xuoi3lqoyf6He7TgAKKYqJ53RdZ95LiXU/SlimcD2K8dZY9IxmeU0VVuyRoylYaHxRo7SkhzFeIxujosE0EmRNsayU2ddb8kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr0bl4QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1422AC4CEF0;
	Wed,  1 Oct 2025 00:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276954;
	bh=NBGVLUna6tSzI/v4ujwYDIgzDI7rGDKeCOZx6QX0b6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xr0bl4QS/U1x8gp6a1rOoxqGPkTZfSowRyUD9vPPfVYj9/0rDj5e+zSnHxFqfQrvN
	 BpOysmJNcOh2PSA82qVHc3k8A9Omp0HkQ1QLSAE4idrlW5R9seie0A3wmMZ00f4KDV
	 m5r+y5rKqr1wZ0ur8d9RpwlkVkYoqv81zLYy4F5V29pZ6RG6uQ/3LgqkbzRKA/AS5d
	 pPQlMzDu/R8HNVvvo3wZY4Y/JpGE8veUjgCAndwUXGJl9TQSjBRRHNf1u83tQsFD95
	 8Eg0xWpkALqQKIOfgDJvn0LDvVCNa1id2D7kW7vRsGOqBCr4O3eY1li+h3KfmDQwlR
	 TXlQ9KJm3B+zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2439D0C1A;
	Wed,  1 Oct 2025 00:02:28 +0000 (UTC)
Subject: Re: [GIT pull] core/rseq for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913807782.495041.6352778133429960068.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913807782.495041.6352778133429960068.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913807782.495041.6352778133429960068.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-2025-09-29
X-PR-Tracked-Commit-Id: a001cd248ab244633c5fabe4f7c707e13fc1d1cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d17e808cf2aad182f0eb2ea83e329e4a6795428
Message-Id: <175927694690.2242674.8744640854918694099.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:26 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:28:56 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d17e808cf2aad182f0eb2ea83e329e4a6795428

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

