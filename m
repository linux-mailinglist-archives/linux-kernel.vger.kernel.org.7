Return-Path: <linux-kernel+bounces-887189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A14C377F8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF94F22B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EBB340A7F;
	Wed,  5 Nov 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jri2REDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37F33E348;
	Wed,  5 Nov 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371225; cv=none; b=fj05C2x9b7KW5//mHubPO7E70/VkIjbRlDOU26480wLLfQmMEOYuDwZvg/a2czuV+D1MzTEpwb4O6lQE/UtxcTJwxXeh4idAbQ9HTIqSwvdn4GVZ+dASTRtb/fqycjk7u6gnQ2jqRoj5iDrq9PCgEXVOUo+5CNfKbI8dnSlFJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371225; c=relaxed/simple;
	bh=o+ehvjx6xMazLwaTTEpM60bcjrwiknNDf+ZNdwbSMCc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jpmYkkg1GdcKZqWm+otJOc9dv7SqsvlMvAje8wGpKIXuzIC9dPRztSpry9wpc5dCnx1C6ix2jnUDc1ZVBk5gbPnBlJrjlxRGoYJUKwIzkho6CzjJhgMvJvYcunzkY1bZNpx0DSvi4GqjaZOcsuM3U1K2vlYG9E5AEtZMobXekAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jri2REDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC69C4CEF5;
	Wed,  5 Nov 2025 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371224;
	bh=o+ehvjx6xMazLwaTTEpM60bcjrwiknNDf+ZNdwbSMCc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jri2REDU3KCqTbj/x4IPG4xvhRKuuavBJOqlTL/IXc6HUeVL5j2TNvQyG5ezbMT39
	 40T+5nl7jqMfXb22gavMH7dmszvgA4FhqH6rNoJhxtrzYWKviwzZHz628LLeI+55Ll
	 dKULsK1sQBDHx8urd3b+Qcl4cZpuZfDpvrnSUR4d2csoeQTwQ3FpnZjZTyRSz7b6np
	 EpnzB6lOVMAQZcoJIa4SyrkwRqZbdOdC29uYgQBuGLC0xu5NlmRbeC+0N64XcoGEpM
	 h2aNqD6VOXARzNuZamv5GfXNeve134MAgUA0MahsHIQTeiRl6TwXtVKqVSK1pQmEaZ
	 xsOj7qNIOTJ1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA4380AADC;
	Wed,  5 Nov 2025 19:33:19 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.18-3
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20251105123705-1390915696@linux.intel.com>
References: <pdx86-pr-20251105123705-1390915696@linux.intel.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20251105123705-1390915696@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-3
X-PR-Tracked-Commit-Id: bd34bf518a5ffeb8eb7c8b9907ba97b606166f7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5624d4c3781673da84e6144c359803ca31b66214
Message-Id: <176237119793.3730612.10491389502619948857.pr-tracker-bot@kernel.org>
Date: Wed, 05 Nov 2025 19:33:17 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 05 Nov 2025 12:37:05 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5624d4c3781673da84e6144c359803ca31b66214

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

