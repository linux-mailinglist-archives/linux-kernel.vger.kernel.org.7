Return-Path: <linux-kernel+bounces-752912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD03B17C45
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF967A452B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499081DF270;
	Fri,  1 Aug 2025 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3TGv8E1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5771D61B7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754024036; cv=none; b=r11WgiXGnlGn7Pgbe3LUf8sSnP5vwz3v0rjaOHgeYp9YQxKLxg7aBMl/X8UKJEJIBzHmr5a+yPbme6tqJvepKQPHXFJ8YgBYTNRWOLhH6Ucn/lF3SCkJLdgrytNPrQMCc2B/iQJKrgNNQB35X4WXO19oOP40lWakzI9TiFpSDrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754024036; c=relaxed/simple;
	bh=GeRStej5b2g5hr9198TEq39pJ/no0389KueWoKLNWPU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DhSa/6UNwif7629QJ228kAopLC+cdkf0iefcb880Aan7r+rn4bc/+s29m7PDmQOsq42bGGDbEpi0Rd/5oGCjEegu5l1Y/F4VRVBcVXXrlVxeVWnMJCnfxZI6egiDhY9WyIPx4cOJOZWShpimnIbgEnKgWNF2/+Hr24DvFZSZb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3TGv8E1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D68C4CEE7;
	Fri,  1 Aug 2025 04:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754024036;
	bh=GeRStej5b2g5hr9198TEq39pJ/no0389KueWoKLNWPU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=R3TGv8E1uIz5tYFbzuM5fxfH/K0KJxPz9ID3Wivwqfz1Gnm5wr4Pyw1rb3XKfIqrl
	 /g/AtRaiZJjKjrNgXebcUj1M2kBlJSri4E5Dc5wA2Wnh/8Adu9BN4XY6myinsJnB0v
	 nhJA1fiuOr3fk0javqDFyD+WV/ZfN5Dfphxdr4ptqhw+YZITDw2AaBhLq03DbvOgL7
	 Oas+mToLFstuauK1BKpQf6jAKTFD8QIjDHw8mdcJJx3M8zulJx2n3a2DVnNWcjEzB2
	 Mc5BFQ2UM3AiYYXNZ8BvPqln4pznvmxegHkDuRwsFtv7YDMUMKTBl/u629XqqZUuuK
	 n29tXNaWaUOuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC4383BF51;
	Fri,  1 Aug 2025 04:54:13 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.17 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <84155420-3nos-n64p-o8s2-1o6orssponp6@xreary.bet>
References: <84155420-3nos-n64p-o8s2-1o6orssponp6@xreary.bet>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <84155420-3nos-n64p-o8s2-1o6orssponp6@xreary.bet>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025073101
X-PR-Tracked-Commit-Id: c62f87e2b1892fc35ed45597101586e27f70b076
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b80a75cf6999fb79971b41eaec7af2bb4b514714
Message-Id: <175402405188.3436555.3065376446065944980.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 04:54:11 +0000
To: Jiri Kosina <jikos@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 23:07:43 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025073101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b80a75cf6999fb79971b41eaec7af2bb4b514714

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

