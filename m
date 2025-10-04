Return-Path: <linux-kernel+bounces-842185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31745BB92BC
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 01:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA233BF70B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49422580D7;
	Sat,  4 Oct 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6Rf3aJj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1725783B
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759621334; cv=none; b=GNIulRczaVRnuSQsK9WGsoizp8FdTk7h0LugWm9VAjRYbAQtLuvS3i1lWO5mc1hQ3GIaQgk1jn/+wT1rbJr5GNYpm09hijYiR681hsJ6o+14hV4+VrWtusiDeG4slxS8HZHX95Dtnj3RYCmSimEl/2RgDeDREO6Jx+/JiFL01tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759621334; c=relaxed/simple;
	bh=gY0cvACHmwSEWaZABj0UuLQBdT+kWc1MHf38w/O16JE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=osUq4cE4CComaJk6R1bzNMWVJOrfhl4LeoxiO0JUOArvV268dHYtqDNBp8ZQ56JNP1YQ5jg+YXc+KqB7lXplqlHR78mcwBsh/1AmDj5PVstOWNMPqybALZZ5vXOL61wW2+XCaixFnzBt5IKYkjeWySyi6aGFs11XTbORtIZv2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6Rf3aJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3539C4CEF9;
	Sat,  4 Oct 2025 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759621333;
	bh=gY0cvACHmwSEWaZABj0UuLQBdT+kWc1MHf38w/O16JE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L6Rf3aJj3nKzN2HSm+SS4G7cIdvF0fVDO4Mr0dUgUR6lHb7odqMsxLYbaNGBrLxJU
	 +cDwk/xWZG9v1Jt3tSA9gTV/RQ+DF3xw2151EZo7gfUj1wkRmje+YDSqEEAxmRteva
	 ikxEmCTON19j/4+BMyg6kMkw1fYI3uYAVK58vcobGuOO68l8FWRiX1gqxP4W62ild7
	 x836eIXeacL4HJqCWUrage323vd5YqmxG0qL04DSwvq69eFmpbPW037H56WdPQdcl1
	 UXeV3Q9HeXpBoCguY6M9PUOwog2bjspwlDsQTLGRFYFAIaK/LnwgZuBp9uZc/0EhjR
	 uTa6HWmFuSdfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B103039D0C1B;
	Sat,  4 Oct 2025 23:42:05 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 6.18 merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <6avar2v2wzvery2ptlynwdlf43octlt57ue32kykwjqn23kemp@j7vmslpbqwxt>
References: <6avar2v2wzvery2ptlynwdlf43octlt57ue32kykwjqn23kemp@j7vmslpbqwxt>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6avar2v2wzvery2ptlynwdlf43octlt57ue32kykwjqn23kemp@j7vmslpbqwxt>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025093001
X-PR-Tracked-Commit-Id: cd3770675874ae72e4d26dd34f4e02dfc7ed8067
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 54ba6d9b1393a0061600c0e49c8ebef65d60a8b2
Message-Id: <175962132451.472872.14314872833619929210.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 23:42:04 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 17:34:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025093001

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/54ba6d9b1393a0061600c0e49c8ebef65d60a8b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

