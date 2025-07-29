Return-Path: <linux-kernel+bounces-749861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7DB153D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE35A304E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FCA296160;
	Tue, 29 Jul 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJ38wSM+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5655728D849
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818344; cv=none; b=KmwFL+1m1RozDvLrohqVd6XGvszzFzpWqNZWkbZIK/3u4/digJ+T/Jej6XR5ccJFJY5hQ3vV2p5XX8yWSzGtvtaDsF94z/ItZnRWztuvGFlN18Xv1vTQUyxd8BEcPstMxNEdYIi8SHKyxv0iSw/mZyTU6Pta85dXd00ORrKUNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818344; c=relaxed/simple;
	bh=4EG44KFZdDe4NBcqFgYrZnjeu9GSNazZOx1NHiJnRoA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RgCddn8FeYM50GpDWtJsjX/rKEH4WFIWiZkFCpzGH6FQZFb3UMyoN8i7V4b6u6tZvGQt3LCFF90hRHISLbbOwvUyhbGY7FW9r74oyGNZh9CNJm56L0Xb7AigVlqX+zhCTcMhTw8XJhxYyrp3U39rnwlHWOZDKzs+DEvTO/vl2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJ38wSM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34691C4CEF6;
	Tue, 29 Jul 2025 19:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818344;
	bh=4EG44KFZdDe4NBcqFgYrZnjeu9GSNazZOx1NHiJnRoA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sJ38wSM+C5yitxFhAgW/Q108Ng+rx168fFvE3WBs7tl6PbC6QGlbJBp/lTn++XaYo
	 B6mtgLqT8DE5kIOmjCtFKJcY7q1Xq8LiiIZTHhSREI442W9riv+4CLCz0eRrQmrtM8
	 8rM6jVgXQ73icziLvvGUvt61VmOX8LK16VXWAKOATtjzpyT/raQ0O22RNeHlZQKNaV
	 m2tYPL/RjsTBhJMg8uc9gWVleqYEkl6ZAgOii/FZoa1+Q5R0yx9LI2E6q78EYChie1
	 K0f0C5E+dGG6hAiNoOjbs2F2q1EzHdZshnzamr6rQ3SntW/0mJ+GbPC/jyiuoC54NU
	 RzERDmtSizGFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCE4383BF5F;
	Tue, 29 Jul 2025 19:46:01 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>
References: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <DBOQ1PS4Z00Q.ARCY8VPIY909@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git driver-core-6.17-test-merge
X-PR-Tracked-Commit-Id: 51a486feac0ca002bee6429f03da0a6c206d0dc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22c5696e3fe029f4fc2decbe7cc6663b5d281223
Message-Id: <175381836026.1616007.7502674581133708755.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 19:46:00 +0000
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Miguel
 Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 19:40:15 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git driver-core-6.17-test-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22c5696e3fe029f4fc2decbe7cc6663b5d281223

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

