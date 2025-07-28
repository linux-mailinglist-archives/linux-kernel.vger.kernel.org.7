Return-Path: <linux-kernel+bounces-748706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F035B144FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3AD1AA1A87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57D289E05;
	Mon, 28 Jul 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRC3aYnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5E23507F;
	Mon, 28 Jul 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753746062; cv=none; b=W27kCfp8zDH0Hz7hncwaaPUMW65w+VX7FnCaXnfBA8W3+jUyctiGoNJotYwH+mhbnU6FSejBow9q3Oi17ib8Hk8mYyXmISDuM3ECvt6dWI4Kr7tBiScZuOaLyzbrPE25mfoYk5Ru65UNDH6vCmpa5R50QZFyH3OsVUpLNISMZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753746062; c=relaxed/simple;
	bh=ifXug7yhRRlmqTnJ+wsAx2wn/EA+T4qe9kmhWaXBcuA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ndq/JI8qYMxMbhD8y4PNb77cpjxD2xdHo6KlwIldlTaZFwYVCry6ZefZWfUadGdEZdnjVhMV4kAoeJjc7aZuBt4EryBQiUQZoAB7OhL2+DViX1l68ifepBmaTdankfaHpx/VoyjSgj7dautvGpQNgWoIhlUjQKKbkZmfCOl/mUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRC3aYnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BCDC4CEE7;
	Mon, 28 Jul 2025 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753746061;
	bh=ifXug7yhRRlmqTnJ+wsAx2wn/EA+T4qe9kmhWaXBcuA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LRC3aYnMbfv3KPmymSXq9/LZZoHwUBEXGa/Av0ADlLCcxH2skxDHiZIPVtidSr7pc
	 dRZBUDALqRWkRFLOwAvRlm1pOdJU6JlRrTbSgv9uuhK6RhcbHHV6db0OUtEtbsJW71
	 4kNPh/iYRCKK6JxE3CPYwWEf7uF58bvUTDKUoZcZf76If00pX/P70kHhvM7c6mAw8A
	 l9BssMJ5KkqtzdQltX/y7mMxIK57PjwYBhAs2SmgvmcPSOzO8Cfbnz6yFfKpNGhPhi
	 dnsp9Ty541XlzoAJg945LSEQqX730W3cCoMA5gYoQXZ6uAR4frbPJJ+y/y485pttD3
	 2xPAViLtsHmGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5E383BF5F;
	Mon, 28 Jul 2025 23:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250728143837.137302-1-agruenba@redhat.com>
References: <20250728143837.137302-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20250728143837.137302-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.17
X-PR-Tracked-Commit-Id: deb016c1669002e48c431d6fd32ea1c20ef41756
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a90f1b6ad6649d553c9d76f50a42e4ba5783164b
Message-Id: <175374607837.885311.5912375172971075300.pr-tracker-bot@kernel.org>
Date: Mon, 28 Jul 2025 23:41:18 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 16:38:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a90f1b6ad6649d553c9d76f50a42e4ba5783164b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

