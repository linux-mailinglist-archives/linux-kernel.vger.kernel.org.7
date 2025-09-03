Return-Path: <linux-kernel+bounces-799283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED686B42985
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21825478D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7453A2D7DD5;
	Wed,  3 Sep 2025 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU67qw+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A520EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926702; cv=none; b=sIrcHt0e+Y4ROvRQ4XiahipQ4K4jukML75tOT5LleA8PNDVl3PgJiquygq0Ab9DDZnRD/YDkQXYIUa+n0OXLteCH1TrtK9CtDdLaoTJYq1yMp+eMNl9urI/tJp2Ddl+R18lwTLAwtlFN0i1G9+TBztGRZPK3TAJH783iEXElJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926702; c=relaxed/simple;
	bh=AEd9ixhgT6JnliqRhVhcl9wbquAnzqK/4X5O0KxpXT0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BEL63K14KsSEeXT123qsRBSbXMl4fju8c1fHKfGkBzVrvYoa2p4aT+qPem8kKpPpvWVjgT0xptekJ1LBl7tD/60OOXDitMH23JV9x2yeAgxYS7Z0Y9biho+7YBIDKG9XR/Yijh9AepHsXdFzouVll5fwJW9cnBh6qi31117UUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU67qw+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599ADC4CEE7;
	Wed,  3 Sep 2025 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756926701;
	bh=AEd9ixhgT6JnliqRhVhcl9wbquAnzqK/4X5O0KxpXT0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mU67qw+Kq/jEUiWOmdNs3jBtHt+gCyvy3nybohXEOlwSf/RuACYdSzzx//aFguaH4
	 bEaiCqRtbbeKBP4IWFQSGJS7iUhx5FHqJGDzXMW0/2cirrgH+xjAYGrwjoa1wJ7551
	 NEWFkUGSZKDFCIYyarcFnSFHABnSi9B1MbGmlSi++NLITl0mWysGVC7cS3et42H+/J
	 KAa+NWXIDw649qAY4xSCfwAKzfbUTJ9hZjC4T2QGZJDA4KbXzWSiI6lHRlU4SLNCWZ
	 snhl0aP4W+kMprm8gnNRC8RDUABHn1+aW/XpRGPw7zWHP70+gI05PGIqQWYStNJEzg
	 8tUy1fSDqu+vQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2C6383C259;
	Wed,  3 Sep 2025 19:11:47 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap fix for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <aLh2-4qZe92l7TwX@yury>
References: <aLh2-4qZe92l7TwX@yury>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aLh2-4qZe92l7TwX@yury>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-for-6.17-rc5
X-PR-Tracked-Commit-Id: 5ebf512f335053a42482ebff91e46c6dc156bf8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec299e4dc21e8cc476c2c848813919db79492dda
Message-Id: <175692670623.1170700.6662303570243062656.pr-tracker-bot@kernel.org>
Date: Wed, 03 Sep 2025 19:11:46 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 3 Sep 2025 13:12:35 -0400:

> https://github.com/norov/linux.git tags/bitmap-for-6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec299e4dc21e8cc476c2c848813919db79492dda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

