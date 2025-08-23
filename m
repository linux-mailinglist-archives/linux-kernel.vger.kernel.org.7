Return-Path: <linux-kernel+bounces-783053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6155B328CD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1CC47BBB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD821A43D;
	Sat, 23 Aug 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXzqQ0Zl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD62628C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955801; cv=none; b=sGILAwEYM8Asm4ah0l260cQ0gBm2NJjL0rz03wRQiKT0/vr7AjN2bNhtrE78wS4AVzOeU9eDz4C0p7Tmzw3CJueSwKwV7aW1skh3CKpB+Vi50giLF5ZnAEii5B6flo2a2uB7iD5l4szQ/yIzmmWNb3cuaMAQyiT/dMkk6foNsdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955801; c=relaxed/simple;
	bh=3rm1uZV87ZZygOv8r8tHX9GgiIUWECYlM8iO525TFn4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HyH6Vgqo2EoCEHJzXzfGH3gHlq3Clu1D42bDXvXTDW+XMwQaqJeieYy9En3z/awu0jCpeoD2Gi6T0VTHfQ8ysH1RBwJA1Wt/fMXPCcJyaqZSqU7+FaqGG5nlvhrmm38SRIUXtvFrG+YKOqmzdGsnZTrjuxAXTGft98MyPK+YEds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXzqQ0Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB567C4CEE7;
	Sat, 23 Aug 2025 13:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755955800;
	bh=3rm1uZV87ZZygOv8r8tHX9GgiIUWECYlM8iO525TFn4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hXzqQ0ZlUfespEzIEITw9Oa8phi+r7QhfsgFwNVBDDXWnPx/7WK5+XPOIdonOS+yv
	 NM2rKbotMC40krmQh5mjMLvL6zCNkr2lJ0fAs1O+aWG/rM38/tAeHqB9DisritCkjB
	 kSjg5GIxRJg9/wed5J18C1IbjiFhM7uP3VpovsOnndNufbqP18EOpDNbQ61L4e/7EJ
	 FRMYg29onNUGNkrzsBaa05xJRO0fQaD543zYdNpH0cTikJw4dsJdjubuqr3UI+NtcU
	 L8sXC849op4fRbtbbFDzHFKAskoOMpSntgW5ejjC/FGL2kseiSL62SIz1UvjbmYbwQ
	 ZjMhUMTWF7Lng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F18383BF69;
	Sat, 23 Aug 2025 13:30:10 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <DC9RN9QVWOSM.1RH74QYO0EI73@kernel.org>
References: <DC9RN9QVWOSM.1RH74QYO0EI73@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <DC9RN9QVWOSM.1RH74QYO0EI73@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.17-rc3
X-PR-Tracked-Commit-Id: 3a68841d1d9b6eb32b2652bbb83acd17d5eb9135
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52025b8fc992972168128be40bffee7eafa532b5
Message-Id: <175595580885.2173883.510005520183259782.pr-tracker-bot@kernel.org>
Date: Sat, 23 Aug 2025 13:30:08 +0000
To: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Aug 2025 13:21:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git tags/driver-core-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52025b8fc992972168128be40bffee7eafa532b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

