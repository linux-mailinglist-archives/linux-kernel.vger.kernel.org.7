Return-Path: <linux-kernel+bounces-738444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C6B0B879
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AFE189848D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBA4226CF9;
	Sun, 20 Jul 2025 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN8nkzVa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A5185E7F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753049994; cv=none; b=gK1wPQwODXE+kVXlJ2BQ7BJKjOcowi23HxquJ+dePJr5B2vZnbjOElO23SJ03/fV3k0TW32Z3FZgQgBb8wiOeHIyxJEd3GyY0E15DIHI9sRNPvz9ZLFvngayptUfat/VekD4HH3dRhJz3KXmBYOJEAbLtRW1gYWAQfeZcrlbvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753049994; c=relaxed/simple;
	bh=RMARtj35StJxsi7TzDbKrTXq19pUxpsWtwASScAN8rE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UNSG67Wa13g5Z9n4KEMPUKFmZXE6PtfLfQM9iCoe4LbnYewu7W/xkfKKrvH2fLod7tlxC0my3HVU6eMRDgr+s5Jp8BmV2hvvsLwMVjmGq1axTJWybB6IrR8g0h1KIGhUuBpMU21vd7Q0OgbdSPNs5DB/1an3zceHrzNG5cIj46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN8nkzVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E407AC4CEE7;
	Sun, 20 Jul 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753049993;
	bh=RMARtj35StJxsi7TzDbKrTXq19pUxpsWtwASScAN8rE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LN8nkzVa7udl6xDP5Kzf3+GkR5GEUE6OPsx5CLJ5Gtp5FDAZ2lu+qq9YdB0OytsBi
	 re+rvv61zw4lQsrU7JMmG5mipWRn4UrwjgsRNikmCTcZIh2q5FOwYT3XrZftVgMhxa
	 0HeiwjmW+/RYRmT24P63zSJnXlFTFfphoH446xJPEPfa3Atjc4U1JfleeiW7d5xMRh
	 PsjkvLJFHcfET9SyLI9WGi8CR68epzAqSMTt+8pdihBEqUVx9gMzKso9Hv/T6WS7IA
	 04akieDFueLumP2nn3tky/pN0k8TrAb7mUTkYESKmszpm2n4psnZE72lS6L9ApzD+O
	 AVpVdY0CABilQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E57383BF51;
	Sun, 20 Jul 2025 22:20:14 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250720145339.5f09ac0f@gandalf.local.home>
References: <20250720145339.5f09ac0f@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250720145339.5f09ac0f@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.16-rc5
X-PR-Tracked-Commit-Id: b5e8acc14dcb314a9b61ff19dcd9fdd0d88f70df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2013e8c2e6fd3a4bdf4ccc658ad20a4469360eff
Message-Id: <175305001270.3302306.16529776327124387095.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 22:20:12 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 14:53:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2013e8c2e6fd3a4bdf4ccc658ad20a4469360eff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

