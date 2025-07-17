Return-Path: <linux-kernel+bounces-734414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1DB0814B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29293AFA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF746FB9;
	Thu, 17 Jul 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5In3aeS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F62186A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711103; cv=none; b=SVKAyd/fPrSMpQDqDKS13me9g9wmkKuQzxe9pFFpymJ7JIXkIc/GZKDn7I9yp+aihpehZoM/qKweQ9WwjAToTpCRdgnaeDj+uHBH0Y6VK1McYNaDKprlzVwDiDGIozA8wY94j7jMUzE6b+0wsOkQoPy8XjC6zTY4CqxDAesKtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711103; c=relaxed/simple;
	bh=ePzGOJbi2895B9dwQzOtXMOzvPTbPt6pYEstuVGwkUs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r2unQdY3GxX1YhFiIWFIkh07uLro2o9cJqiUfgGN86e0o/cdkBju9Tl498kUK98Ldsmax614KWV6KKWTHgyMAIOb2KyX2kR12taLWPpHGKGSfsLFkJO7JChCzfM3AkahHV/2c+LJ5jlGnBuoV+OVDg5miNqxeK2cYA/SCOMjZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5In3aeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEBAC4CEE7;
	Thu, 17 Jul 2025 00:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752711103;
	bh=ePzGOJbi2895B9dwQzOtXMOzvPTbPt6pYEstuVGwkUs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N5In3aeS32gKuLAi/Ao4DnJ+lrttYiuN4spN6zzeP4yWIFLYs8HydJMzgP4EK1hO8
	 HbNF1W5SrmqPaOHQ9vlf246PWowGHWolKHiWqHVqeSZY+PY5Q5SR+K6pvNGhkKsV87
	 m8mB56Owi4/ZiPBHZCVlxvc9pZjTVGKDGRpIJWWH0xhFKIvgg++mHqmny2hR8GHua3
	 nd4VaoYu5tV5dpG9w6GB/WCSZI/tdKpVHL/2eaitzvnbqeeY6Ww3IAyuBL0mSI9iAm
	 +svT9yTqiTFEQ95cbIi4F0ZL4Gy+CBGiWOPIKUeJ9ozTz3TS6Ijy4OFsEUAWjdrms8
	 xOMMkzKlwAndA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7141E383BA38;
	Thu, 17 Jul 2025 00:12:04 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <gui63ajjn3vv6yvtvo6xcnejeylzltozxgudy537jbp537lrdu@k2qqwl7cgxcz>
References: <gui63ajjn3vv6yvtvo6xcnejeylzltozxgudy537jbp537lrdu@k2qqwl7cgxcz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <gui63ajjn3vv6yvtvo6xcnejeylzltozxgudy537jbp537lrdu@k2qqwl7cgxcz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025071501
X-PR-Tracked-Commit-Id: 3a1d22bd85381c4e358fc3340e776c3a3223a1d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e003ef2cb1de41edda508ea1fdb21974f9f18dfb
Message-Id: <175271112300.1371664.14444647039215869935.pr-tracker-bot@kernel.org>
Date: Thu, 17 Jul 2025 00:12:03 +0000
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 15 Jul 2025 17:25:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025071501

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e003ef2cb1de41edda508ea1fdb21974f9f18dfb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

