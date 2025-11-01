Return-Path: <linux-kernel+bounces-881460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C19C28401
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF2189DF17
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA02FBDE1;
	Sat,  1 Nov 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvw4Daf2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61152FB97F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018936; cv=none; b=fWkbGixU4M9vypgVc+wQTK0kPlXWgu61fXWWqIO6XadraVKOji8KuZ10NmZ6difO9olQnc+9wcSaJ9IAYVMq33+pd6U4enYr+yAkxT43PkIhrz86h4BIfvMuBBQzEFc1Ocui41y7Mus2qaZympGKAoY4akPUK4lDWOrS3n8xVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018936; c=relaxed/simple;
	bh=iaYs2qPQWmWaW+N9F6J2xWXuGZkZAXR4p+FVlJnThT8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XRlpB1jko0ymTLpsvedeAUTh2/VcJyA6U8rWe9uMytcKAihFOqjG20DpEobMHImMmY5Q4cI6/pSokgWL3obN0xN74l+WFhMmjVUoBUAIkgD7AZ/j9049TCjzxjCDyZJxgJUL696Nos7QzShSXnN+cM9flX8R0X8f8lqYRouLUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvw4Daf2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A17BC4CEFB;
	Sat,  1 Nov 2025 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762018935;
	bh=iaYs2qPQWmWaW+N9F6J2xWXuGZkZAXR4p+FVlJnThT8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gvw4Daf2wvUGdvVnfuorm4Ldg9jI+LRp7wY8HzHgD1MFzNGpync0cQJL1iXHJB+Fp
	 BK5rIT8MIl8rd2CYOu7gE7c5AkcOCGIavWH6qbTPwAOQW82pObwEnS+EO/SKZ2BCyG
	 VBKw0JuM4GruT2wP40trabe79yhztxCMfj3STymoeDcvggLehVQSoSq3Loa/Lvcp/+
	 O+K2bFoM//nT09a5i/q3WDMwpccGdwKwAqHrYVoPSxHbr+Y2cm3iiM5fgoxqtJ061v
	 KskXsLYGLqELkwsNFJ2SmNa+wFCbH5YuvD9Yh7lGk3pS+AXGOBB7jYHpDTd5XLtXzc
	 t9dNWN6+Gby+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DA83809A1B;
	Sat,  1 Nov 2025 17:41:52 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQWzIsY-xkIGhnkv@gmail.com>
References: <aQWzIsY-xkIGhnkv@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQWzIsY-xkIGhnkv@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-01
X-PR-Tracked-Commit-Id: f4c12e5cefc8ec2eda93bc17ea734407228449ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9bc8e0912b8f6b1d60608a715a1da575670e038
Message-Id: <176201891079.850663.4630539274503435535.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:41:50 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Nov 2025 08:13:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9bc8e0912b8f6b1d60608a715a1da575670e038

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

