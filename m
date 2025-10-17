Return-Path: <linux-kernel+bounces-858840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE79BEBF9C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F97740DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56FB313E39;
	Fri, 17 Oct 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyu59d4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100922FD1AD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742440; cv=none; b=P7TJiWoDgXa1s0W86xibF65dsS3HIhY+TcTwMQVxtNi9bQmLB7DkKX0+dA0hMdl6XOriDbGXBw8W7IYGfOay/akO1vQsd/A1FCizsg91c7IEjaxaMhTuByVvHMcJMy+4Vw3BUHPpwDYxxBlT7+IDjG5bKnDOfZWsBPvTqQpaymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742440; c=relaxed/simple;
	bh=dTr0x5o6E2zK63uyoPqIfXVySL32t5XiVOYd+YF5seM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cAtL1viXUy+bUkliZqNnpw3c7HOWqAjiAl8tXItOLDt3BqKHszF+dHdSqND75huwiJB216zJJMXOih+s1P1M7cCUsG7PkWBGoF2RozgEuHZDKFROr37SQPG43WAGl2viqC1fiaScEJmRHnDXLV0w1Mr3LZSlgZncq+Z1PWbDGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyu59d4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E504CC4CEE7;
	Fri, 17 Oct 2025 23:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760742439;
	bh=dTr0x5o6E2zK63uyoPqIfXVySL32t5XiVOYd+YF5seM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nyu59d4/BfhNt8iXxdOGevqWE2AnBmpGC/d8vl9zBI4XWYnujOHW2o4Qit2h/xLVk
	 kK24zjwl23Fl1MhEXU/DKjNLsseV8VfCiQY8QWlp1HwA88duDGdPBAH/F8cmh/nMUB
	 BZaNAN24NfIfQ5MwteWMNKztBy3mWsQgatrjOVrdodNE6Gr5MErtxgwpmk+BU8VGOu
	 4izGtgR7sDojyDCbfSUnB5QcK7WieDAP4qa1NKHJAe+tl3cL9m9hHpqFcy9xElz540
	 lE9M8v43oJdlIKUys5vTaYRxv2MEWAa1wjMQDBXIsGU8V+LknGIhkRu4o0LK9rvLp+
	 j8we3QthJNqgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE7839EFA5D;
	Fri, 17 Oct 2025 23:07:04 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPK5qkFphJvpJBkJ@arm.com>
References: <aPK5qkFphJvpJBkJ@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aPK5qkFphJvpJBkJ@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ea0d55ae4b3207c33691a73da3443b1fd379f1d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f406055cb18c6e299c4a783fc1effeb16be41803
Message-Id: <176074242328.2817248.13754921087443545175.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 23:07:03 +0000
To: Catalin Marinas <cmarinas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 22:48:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f406055cb18c6e299c4a783fc1effeb16be41803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

