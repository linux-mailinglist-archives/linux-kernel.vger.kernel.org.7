Return-Path: <linux-kernel+bounces-751445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C60B169AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D181AA5075
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F52E40E;
	Thu, 31 Jul 2025 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT2Yokkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C541DFFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922102; cv=none; b=Cs4Fi1NKyhfoigRRIZdMK6x202mgwwemvV1UhH8cUPhETDMXbYxiddnak1SlfyvuiGvf/9TJzVdbNlC5o6UUstz4+Z71Snuhzd357QeJ+dHJIzy1iJPVHIpGek/QFEeHG4FtMatRq89pRJ30UTOPfTfL782c396KaczgJtLIxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922102; c=relaxed/simple;
	bh=+pgr6TpcmTos597HJxMcEYQCKRufYlikCaN+wfmoF2w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Okn+tWIrRQUZo7fQkwaNasGNHV9vOMTEzTqZ9lONyN1AYmfswsz6N/rBvcyZACkYrLZIALgRNweTufc6h/ESb29FgAsNp4V/FME6qgaYUby3fwlAKn1XhYFLUQfomr8WXvl0wSqReK+t2OE5VqrLQXYKJZ6XETv4BGbnJ0IsiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT2Yokkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1738EC4CEE3;
	Thu, 31 Jul 2025 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922102;
	bh=+pgr6TpcmTos597HJxMcEYQCKRufYlikCaN+wfmoF2w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tT2YokkvOUPaYdmOhvW4TRkClOzwvRPcCAq7juklD033KGoyICaInGXeAkOWGyQ9u
	 nnYozQSmIbx0emAZHd0kD/UuO+MWclwn8O6b5vsj2y8sUScPS5yD0cLvEUHN4kQaqP
	 FgUtRz6N33wbtDtNWjJ8cw6OkHva3ypMEdZTfyFD2PdCuKP4akc8uy9v8KVGs2c4ZT
	 m9G6aeozgn/EBDH+mu+CQ0Ok913As38Bu5eIWyNnw984+Sma6rXwSFSsHi9GGaLm/z
	 41EW3oVZVSrJqfIhQzE1eGGOU4okOYGal4/k4B7wXIWxIwLzu618Boj79U1x8QlsYJ
	 TM+UCS4JNCALg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE5383BF5F;
	Thu, 31 Jul 2025 00:35:19 +0000 (UTC)
Subject: Re: [GIT PULL] ftrace: Changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729144226.6b72dca7@batman.local.home>
References: <20250729144226.6b72dca7@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729144226.6b72dca7@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.17
X-PR-Tracked-Commit-Id: 4d6d0a6263babf7c43faa55de4fa3c6637dec624
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a871f74b70027779a4f312c0c74b6a89e22412
Message-Id: <175392211771.2556608.8341505467070948860.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:17 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Artem Sadovnikov <a.sadovnikov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 14:42:26 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git ftrace-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a871f74b70027779a4f312c0c74b6a89e22412

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

