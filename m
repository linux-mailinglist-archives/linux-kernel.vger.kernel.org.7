Return-Path: <linux-kernel+bounces-835059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ABDBA6289
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F2417E938
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1348235354;
	Sat, 27 Sep 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmxFj8bA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48896231858
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997536; cv=none; b=Hk/StTsV9OxLkagaxiVqRpKLJqvpjZzpbYcABZzcvP/IZH8ipJPtyagbJd6s0f4+7dD3mpPyZV0drCga7Xxg+Cd+fVhX8DTKv6oRnvTCwaehNGfSpvjZLPRy2XUQEOTomnbHjIszi55S96vSD4k4UhTaxFNVjrda6WR7wHdQwvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997536; c=relaxed/simple;
	bh=rJBq/bYBek5ume+c6ShI3RjT5GWCZ8Jdhvsj4G6tNc0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k3rqpfaF2CoGQlYBNHNG4nnjQ71Dc7eVR+bAtIaJtKcBlZwhD/hVUuHNYCAU+3aPF9/Idagb9YqGlpywNJb6xCs5qk2VZQef/ABFmDpGNf7uPkNbQ71jIYi1v+uUBUEhYUUukxn30EL4CSDY6Z4K2IOusMxbI+nFgTc/IDp5vLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmxFj8bA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AB7C4CEE7;
	Sat, 27 Sep 2025 18:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758997535;
	bh=rJBq/bYBek5ume+c6ShI3RjT5GWCZ8Jdhvsj4G6tNc0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TmxFj8bAGkQdXX9rRCwSq1b66UgUz6kBQxRDgCVrZHzjELfN2w2ojj0HQU2cYxIMx
	 qSfhc7LbpbXUtjjKTvHwsGtJ549U2kYScFFpmsxUsfOT1CxlAJb3246CMymgDhNshM
	 YJiQvbyICatLyb7OIDMrTT/xXqFdDekLv4EaL5DwF9/BA1QhDTYjb7IxP0A68U26ri
	 65lB+sGihLM3iB0rfiRt/tZntXXFCov7C8pqwlbKj9JFFFAp0JJ2oZFdoABDGwX/KB
	 Em2Zp8UCN5Y/3sF+xzPmnhqvk4YkdAm0fxEOhW3BPXILGW+SBsWnPBqkUMW3GE5Eo2
	 43tMxu/zVykFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE19C39D0C3F;
	Sat, 27 Sep 2025 18:25:31 +0000 (UTC)
Subject: Re: [GIT PULL] rtla: Couple of fixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250927085234.6a46c0a2@batman.local.home>
References: <20250927085234.6a46c0a2@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250927085234.6a46c0a2@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.17-rc5
X-PR-Tracked-Commit-Id: 2227f273b7dc25a791ae6b152550098aa6934b2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51a24b7deaae5c3561965f5b4b27bb9d686add1c
Message-Id: <175899753020.307650.15305016214755686884.pr-tracker-bot@kernel.org>
Date: Sat, 27 Sep 2025 18:25:30 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ivan Pravdin <ipravdin.official@gmail.com>, Wander Lairson Costa <wander@redhat.com>, Tomas Glozar <tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Sep 2025 08:52:34 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51a24b7deaae5c3561965f5b4b27bb9d686add1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

