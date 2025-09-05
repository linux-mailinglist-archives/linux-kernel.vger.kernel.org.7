Return-Path: <linux-kernel+bounces-803739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21195B4647E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8530EA020D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09F2472A4;
	Fri,  5 Sep 2025 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPjNSm3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851B21B905;
	Fri,  5 Sep 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103434; cv=none; b=fNA4Kwn8WwDARGRDF8fKwdbei+En1ey3WI5oJz0UKs9+17Qnqo1RuzNJSqGZ6gcrPxswy+DoVhV9A5HRl6daQmBaRv5MA7Opp5Ah6a2vFr7WX5XKqlAfXJqlpkJlsI3LsTp2q+wLVAm3p2esdNqZig/XWbXXryZHR3MiVun/FWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103434; c=relaxed/simple;
	bh=ekyjU1ZF52CKsc6/Q8IdwdcbR1u4Vhda27yNIqXOc3s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CtrxQsl1KdiIzDlt+4PtzHMErIqeRAUCw68ReGMWkaJpb62fI5DBHaP3gXW7ygPGLZcQ4h+OSzwY4IALSOS1Sz1OuT/DNCwRvilcTGIyfOWIufhxFBzNuD0rpS+gsjlEZxSds7Zj5b6HXy7BFzblYJXm3hQ2Cqn0G+h4t0+Qhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPjNSm3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D3DC4CEF1;
	Fri,  5 Sep 2025 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757103433;
	bh=ekyjU1ZF52CKsc6/Q8IdwdcbR1u4Vhda27yNIqXOc3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kPjNSm3rGhs1LKI6ZYgTuDFCf/AZ2OiRKq8C+w6dt1KNXEaaZWte5maKxz/3rB03i
	 PfNxlObBLhEYC+JwNpssiypHJZe6x72weopt0G20U3knt2DTwNLxsP2ek8Use2AH2y
	 SvqdzPgINLrV5WeQfmGFoOWYGY/W/QG/xRsmT1xi5rLLXKCqNouBXJldYRKJSB5MVn
	 /c2Q5N5ojVKJPaYrE6Xh2E6HFaO1BMZoqsny/0saBu5uXMRrVOF+5Hd0z5eLJeAQe3
	 gbl7Ss953FwRDW/5s1Gs6p2D1ZbWquRfaDBkejImYRMl/3nRDKfwGDv/jcl5BGN5fe
	 qVC1C+s01BbDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 355E0383BF69;
	Fri,  5 Sep 2025 20:17:19 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250905165835.1653373-1-linux@roeck-us.net>
References: <20250905165835.1653373-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-hwmon.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250905165835.1653373-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17-rc5
X-PR-Tracked-Commit-Id: c2623573178bab32990695fb729e9b69710ed66d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 260aa8d5f0e6c858b985b0813091f3a270619983
Message-Id: <175710343782.2676293.13687736166156141722.pr-tracker-bot@kernel.org>
Date: Fri, 05 Sep 2025 20:17:17 +0000
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  5 Sep 2025 09:58:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/260aa8d5f0e6c858b985b0813091f3a270619983

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

