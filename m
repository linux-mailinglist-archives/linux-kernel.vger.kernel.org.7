Return-Path: <linux-kernel+bounces-734415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B3B0814C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1816F386
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE241400C;
	Thu, 17 Jul 2025 00:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxcZ7acK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF516DDAB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711105; cv=none; b=Zj3XtEfy1ze0UE8mzh7tunT2Xveuve7AaVLZgetXPoRmrI074Yk7T1Ogpv8KfpaJ94IDoJEI+noQISA/mEKIwlGl3xCNr1vQE4nxZMg1+MRXdjOpRqR5wRD7I0CvQOn1FcIvHzUuzDiFQXLM4dSfURNiljMCVpiXbETOr64IWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711105; c=relaxed/simple;
	bh=XNpT4Ymf68w323tTyeC04Gybxy6wIFHkcQ31p7on5rQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=e3xvPj3GajL2jvZfcpffKzKuV1ePJD4rJ3IkC+V16l9dJ/3tX68QbEu8Gfa2Z1hr67M78gtZrKyTrHMEa2LRJec2ZeslX32rBMh8cVZshGIOGVSGU1/+fFh7VO/V/AbdzvggXYODoX95/f6QO+B/97NWfJMTRTL9qPyIHFRWoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxcZ7acK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73728C4CEE7;
	Thu, 17 Jul 2025 00:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752711104;
	bh=XNpT4Ymf68w323tTyeC04Gybxy6wIFHkcQ31p7on5rQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FxcZ7acKj4coWhi9gTKQg5TOgxHUYoLsQOGo8ZFSYFBycN8S6rxcKvWggXEV+jWAm
	 7r8vz6g3xP01gMgSqnjUrOc6c0hCbe8BQqtnvm2fIS8JWB5KftzOpdYayyIMmBXQMy
	 EAUjHQ/rAZL7qbq0EWY4NNZOjwuwKdpdKy5DUTqLbbn8MPV1xfo41s5JY1g72X8J04
	 UzdUw0FylGhOyWZunmmY/nD3UXX8x0Qb12AXHtClvAiphQgya21hTBtaWB2qCqFdyo
	 8+AjJY+jE7ECZFvX7lqKCGKnsZJ0tIqLRXMwf2VdMfX1unaTdAkDsHUEgyR7izUAeM
	 Tn3yAqf0e6eJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADC5383BA38;
	Thu, 17 Jul 2025 00:12:05 +0000 (UTC)
Subject: Re: [GIT PULL] probes: fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250716152201.58f9402c011e18f8b0c904ac@kernel.org>
References: <20250716152201.58f9402c011e18f8b0c904ac@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250716152201.58f9402c011e18f8b0c904ac@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.16-rc6
X-PR-Tracked-Commit-Id: 1ed171a3afe81531b3ace96bd151a372dda3ee25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2291551827fe5d2d3758c435c191d32b6d1350e
Message-Id: <175271112453.1371664.16910030975243946819.pr-tracker-bot@kernel.org>
Date: Thu, 17 Jul 2025 00:12:04 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 16 Jul 2025 15:22:01 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2291551827fe5d2d3758c435c191d32b6d1350e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

