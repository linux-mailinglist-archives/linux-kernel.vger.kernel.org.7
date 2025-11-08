Return-Path: <linux-kernel+bounces-891614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A161DC43178
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 18:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9BB3B4727
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2FB258ED8;
	Sat,  8 Nov 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZebTk9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256325784A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622149; cv=none; b=kP/NUajagNfDaNz7+souWgmnlHkg92eaTQXt6/AZ1qi3CU792uSag1FiOsFrxpYDTZxRIuGpVHzYUoGOmJR2Wsr6ThDzhDR+fyvAcuo2P9s7wCnc/OALjp2jT78+D3gDpK54biAZnWSh0imSjYaUkB6Kz5IyQ6OCzMUp1u5+K3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622149; c=relaxed/simple;
	bh=LQocZO8/C53dN8BkK0P3G7/CCoWAzlX7jwvIBOGo3LQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MZwcZXve3/yWsmte4k0NSy5bMAsV8qtbeR8wGE8gEnB9xEZGL94kYLaok9oAns4mDS32J3BVSAT//GJJx9l1LfWhLUhZXhoB+nrolpGdAp7qmoRKiWG9vGEQcufNgdGdIqGCQigcGw2Lp4tCIY+vF174g9AxycSSy6GRF1s2S94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZebTk9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B9EC16AAE;
	Sat,  8 Nov 2025 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762622149;
	bh=LQocZO8/C53dN8BkK0P3G7/CCoWAzlX7jwvIBOGo3LQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VZebTk9UzyTJ0V6ZTMUIU5syh/AOFUWeisOxL80zo+9p0fc/UVcN8PVCv1E/KOCLv
	 xFmf3Mx4NvuH1MN40RGQhSaAFR8Fd20B0IwXzb6I5GYyIR8dRStIP82IZNIu7QiR4x
	 e9sX4JZCg3G4BLPZwrll78NHLfduBPs8xTuxpNs1ZJPZQ/IgxxwgfjKLin5bwxLure
	 xlGtsdNC4MXwvOKpLwIjsGUhdzHt7sXi3iMUJlZYRCdIXLj7OwETzfCEEb8mohbBW/
	 TEIR9I8Kong+pQWTjcCoCqqvkcI8ZbC4pFRPRK1Sr1NPpyHdtqG4BfvmU9uK6C8Pav
	 a4rG5oGr7/gJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C153A40FD5;
	Sat,  8 Nov 2025 17:15:22 +0000 (UTC)
Subject: Re: [GIT PULL] perf events fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQ9ArnO-84XJlCVB@gmail.com>
References: <aQ9ArnO-84XJlCVB@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQ9ArnO-84XJlCVB@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-08
X-PR-Tracked-Commit-Id: eb3182ef0405ff2f6668fd3e5ff9883f60ce8801
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 133262cae98fcc0d36fec97213b69268eb166fd5
Message-Id: <176262212109.1365123.3083266182768405693.pr-tracker-bot@kernel.org>
Date: Sat, 08 Nov 2025 17:15:21 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 8 Nov 2025 14:07:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/133262cae98fcc0d36fec97213b69268eb166fd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

