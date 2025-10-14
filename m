Return-Path: <linux-kernel+bounces-853093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B1ABDA9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902D13BA41D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5930274B;
	Tue, 14 Oct 2025 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjKYiVGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD53302157
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459497; cv=none; b=sUyMsDeHRbPf1vdhDATT8+GzZHPhllPkNj29ltOgHyCWzpZfNhIaHivJwkQSIus2zEv3WC6AcKakGRasADhMVCbETzDwZcMAPHsoaVR6Sx4BwF2jhJ2KaSaj62oIS/j4+8rluBHmv8L2pw9gj8UrFvA9vPwmFdggL/AB2BKyHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459497; c=relaxed/simple;
	bh=p2uFuxbWNmwyLUoQ8GrO+NzS5l0VHS0mVzJ9Z/0RaIM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BfZcEYOpxyraxyn3hKgfK/rYw+babBSaji9R4yVXZuQfFwYl+1uGoFMj0unW85NnoDj2Vvfm2Njgu6RT9rzqg8dh/2xEAoNFSMb/JGCH+2BbED5woMzWX8wIssY6q7L/HFsWiLyxfMrpuerMmdlGgbQwZx0hLWtRcFKdiNXnxzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjKYiVGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D3C4CEE7;
	Tue, 14 Oct 2025 16:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760459496;
	bh=p2uFuxbWNmwyLUoQ8GrO+NzS5l0VHS0mVzJ9Z/0RaIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UjKYiVGf0Zt9aBTzr4SH4yqv8EnpL4/d8xtCjtVKMRzLDg423b10ou+BE0QdDhiaO
	 0CpavfrhrscNusfnMC8nH7A9UF3K9huwvLE02qF0H8CsJDoh2lZ9hJte3qmZ/8pyJ9
	 lRAl8hQh/dDrCntH5ki1OhsllriCwg7d6As9CbB+BCO+l3RI5KBqKs9ZVzwtKeSt+M
	 fBUdwcEU0YnCOEpNDzHWSvbKu9InUf5sqMA/4i9cDgSNUFtp9a6z9P5pqmzeYrbRTc
	 fN06aMkDfhs+/zW3YqS+GolpvM1J4u1cDNAVHUU8V8lgo8N8Xxwz/fDUbWsE5IqRuQ
	 9FN+r/Jdg0niA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3407A380AAEA;
	Tue, 14 Oct 2025 16:31:23 +0000 (UTC)
Subject: Re: [GIT PULL] more IPMI bug fixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOzrxmNP1kT0FOxB@mail.minyard.net>
References: <aOzrxmNP1kT0FOxB@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOzrxmNP1kT0FOxB@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-2
X-PR-Tracked-Commit-Id: e2c69490dda5d4c9f1bfbb2898989c8f3530e354
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bd0116d92a7849b12f0b4c8199d53aa80e449bc
Message-Id: <176045948164.10193.4949713951951184632.pr-tracker-bot@kernel.org>
Date: Tue, 14 Oct 2025 16:31:21 +0000
To: Corey Minyard <corey@minyard.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net, Guenter Roeck <linux@roeck-us.net>, Eric Dumazet <edumazet@google.com>, Greg Thelen <gthelen@google.com>, Dan Carpenter <dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Oct 2025 07:08:38 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bd0116d92a7849b12f0b4c8199d53aa80e449bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

