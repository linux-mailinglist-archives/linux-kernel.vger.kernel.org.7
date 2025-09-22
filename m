Return-Path: <linux-kernel+bounces-827727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A53B928BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188957AD54E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055D318146;
	Mon, 22 Sep 2025 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/6klFCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C8317711
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564294; cv=none; b=ZJMgfd0fR4oPp3eGo8PcYYllMo+Doqw5vvSP7FOFXfMXX9FEXc5z+fZxm+6d7ow10NZk97/4RH7/InhY6YZh95rb3OU4wZEvjL1KF6bH5ufKIjHo0Su60F8tNHS3lviC2nBidnHVDnjcLq7pyjckuMb5wK9sDSs7dVL/dpKlzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564294; c=relaxed/simple;
	bh=ZcbXM+5e+GsU8AjbnbjjPBN+NNimotbCSyTeHZqcbn4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LwjlFY0aK5VsFpe5jXKav8QHy+dhE6BJ5222+5u2LARlZO6rHQoSodE2vJ7JEc4kwUOtd2Dm4D8PKLQg4mjIMnNg6Nh4y6TixGulW58S/euNkNbKT+oja+7Cl+eQSRMjLbUfAOEBeBjb1innF49xMhOScN+Mlo4auNPeiL9vDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/6klFCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD6BC4CEF0;
	Mon, 22 Sep 2025 18:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758564293;
	bh=ZcbXM+5e+GsU8AjbnbjjPBN+NNimotbCSyTeHZqcbn4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=t/6klFCXgRIXow/u1Iyan8rjN1hiW0u5isVgPTZh7V0LYbbi6eYtKcNibskd5EBac
	 f6OWG7Dvjv78HawetLQacV1XtKxhfc3kbi2xjfhsuT3OkVhzrTiBkkNlpSAwVwx3p2
	 Z76D3C7KF96CQjcQhgSgLWq53E/eU6NyuQZrs494VMZ64CGqXdJGamA/VGnKg9r4fO
	 XfNsyG8QLVyQx87YALscabM0QaoVBcn+prgecPkh2YVpWCjWJfEY0+nXPKiV3jaWfk
	 Ab5RRwDvSIFqCUUD9hvvqluevOXc4PN3N4tcg5AYR1s6Oay0Ewy4/J5X63LTX8+pGi
	 r/hBCRV13H2KQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7D39D0C20;
	Mon, 22 Sep 2025 18:04:52 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes for 6.17-final
From: pr-tracker-bot@kernel.org
In-Reply-To: <7rq81spn-on10-rn3p-03so-825s85486ps1@xreary.bet>
References: <7rq81spn-on10-rn3p-03so-825s85486ps1@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7rq81spn-on10-rn3p-03so-825s85486ps1@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025092201
X-PR-Tracked-Commit-Id: bba920e6f803138587248079de47ad3464a396f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32d27cf535ead3b10e926c76dc5b6301920328b0
Message-Id: <175856429109.1104153.7900672615347273934.pr-tracker-bot@kernel.org>
Date: Mon, 22 Sep 2025 18:04:51 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Sep 2025 11:11:33 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025092201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32d27cf535ead3b10e926c76dc5b6301920328b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

