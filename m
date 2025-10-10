Return-Path: <linux-kernel+bounces-848795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85ABCE953
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7879E354554
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DB3302174;
	Fri, 10 Oct 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU+7G6z4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB43019DA
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130580; cv=none; b=kxIXIROtzCR+wSpDysksoKtX/HQGz7nHHX66zS9l0wPKbkv+MUL7WiKh/ggnsj+p0+vNxzlY2fiV0SqIoZ3sP3BENBuqtihQvyEd3zO2FLQIneLOlaWAp9WUaON1+MMz2cVb/+kmPAclvzRLv7FmkR6VvQnRwf87WJ/ZddsMvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130580; c=relaxed/simple;
	bh=zDupfuPZlmxliVGys9b7iXmLHMvnwVmLabeZFUVqcpY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HhKPWPxyGGOUzZL1T5CyT0M5qdLgTOR4VmYTF10x2qRt7VVDTu6ywyG0Bh16prS1VOMmQUj8vNlf+kZhBiDKsWmmg6uq11hEikVZyX4aq8YeLBFiqT7tdtRk9sx/0NM6WocWpEQ51kpO/AoKneVwdub2/EETS/W9AEkdpRidWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU+7G6z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4CCC4CEF5;
	Fri, 10 Oct 2025 21:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760130580;
	bh=zDupfuPZlmxliVGys9b7iXmLHMvnwVmLabeZFUVqcpY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AU+7G6z4WrLUr2ThW2TTJFYMTaPQhmnx10DKKmBlptcBFXJq8oEpmoPYld/HOyxJd
	 1MMwQAdy0Iyxdap2OGxDaXkSzOVlqea6IXJVxL7jPRYCuOrqgACYiW3OEAeSgCp/GG
	 jp1ZjBVe5tWKD1dUW9JmQMv186kvElIM3sFtPghfn+MJNU6fiIpaNM86cBm4dpGPFT
	 YWyMSvOtnj13GmjNClaR7KwHqZIcmY4dkPxYjMHa6voiVu1EYKkLgzHJhAv31hKLo6
	 UITOo1MVpx3o2IcFVOsFLLf7yd026wGVyRGShtAkxcyTG/SuOlUhiHNMWZu/n3KDx9
	 3bHVDgXlZS9mA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BB13809A07;
	Fri, 10 Oct 2025 21:09:29 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx8Hiozxaf+0WkOH3GrXKhCr_ccqVtd1v7WkP_V9DmeJQ@mail.gmail.com>
References: <CAPM=9tx8Hiozxaf+0WkOH3GrXKhCr_ccqVtd1v7WkP_V9DmeJQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx8Hiozxaf+0WkOH3GrXKhCr_ccqVtd1v7WkP_V9DmeJQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-11
X-PR-Tracked-Commit-Id: 5ca5f00a167cdd28bcfeeae6ddd370b13ac00a2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e5d41b981bc550f41b198706e259a45686f3b5a
Message-Id: <176013056782.1128757.6763550721097758946.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 21:09:27 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 06:22:34 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e5d41b981bc550f41b198706e259a45686f3b5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

