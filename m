Return-Path: <linux-kernel+bounces-849264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24948BCFAF3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E25CC4E73CE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546D283CBE;
	Sat, 11 Oct 2025 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ62fEAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CB265CAB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207966; cv=none; b=CMW8qFgsrFpPgumzIKEbRcNQ1GZlUraGSa8tYdztZvqSflwS9hKgExbqf7WliLEvD6FJcy6+aKsD73X/uvxnc9AIMgYUh8eRzdZYVC/qvuQkxT+mKUfPXDtAK6voC4Z3BClAR/+wxXyN5JF9ygl7UTIjHHvcwpEsDVLXWV7Hm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207966; c=relaxed/simple;
	bh=ZqT9KEyE99Tmf1IePyiFDRVpKmDwhWDTpYWeRJbgWnw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nGUqzeVxasdrx8vIqdKAupWAAbrXWq5NRnYzh4oPTwBEwNzC0cPBP662eEPEx+Vygp8HFyAeRCrXR8KzliMKIWvjrFwtKVIB3hTOohnCT9B4rfxckidQslShM63x5Sie4sMyCukNKwdpOjB6iUNW1tVc3HsmyXfwC55tvio5jCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ62fEAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F13C4CEF4;
	Sat, 11 Oct 2025 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760207966;
	bh=ZqT9KEyE99Tmf1IePyiFDRVpKmDwhWDTpYWeRJbgWnw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IZ62fEAR99LYceznvWTbhLdKLB+QmL/hp6DsALjapX/evMfnjdUGvtg7JY3jcXBtc
	 REnefCWh842RPMjMjvGC4jXgvPearBjplrtcOLIVc/McJIYdMF+6KsTPR5txoYmu9l
	 ArBVIAeXMF3aPDAmZSeZLB70RCKMUdy+3sfobBrlmbuHLSKSOuyct+FH+KCwB3DnTU
	 Y00Bb2abv3UZdAzpVBx8+reecAZQeQRP1AD/5eFfeSgTGaFQswlM8DTSHniyFW4bVd
	 nbs4TgNg6ONFfPwtv1QzX4dsvXuHpa0hUEq2znyQh6mgZzF9NEpdcrgs9n4Ksc2qw9
	 K0VLh5y8p13qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9E3809A18;
	Sat, 11 Oct 2025 18:39:14 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
References: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251011134629.GAaOpftWmLdD6L7bJn@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.18_rc1
X-PR-Tracked-Commit-Id: 4a1e02b15ac174c3c6d5e358e67c4ba980e7b336
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9591fdb0611dccdeeeeacb99d89f0098737d209b
Message-Id: <176020795332.1422231.1501424763720044341.pr-tracker-bot@kernel.org>
Date: Sat, 11 Oct 2025 18:39:13 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 15:46:29 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_core_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9591fdb0611dccdeeeeacb99d89f0098737d209b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

