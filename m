Return-Path: <linux-kernel+bounces-838170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C08DBAE96C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A031945966
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281C2BE7B4;
	Tue, 30 Sep 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slso6HGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192132BEC42
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266202; cv=none; b=eDT0ZxJ8aduQlpn3IZQT6ZqeBZHF8lCxjHMAT0yPflTUmP0jRql5kYkX+UjSWS9fQX+kTjkIIO5HzKxjQqe+i/ZUBwbmyhHGNPRUxO16+R6U1yf/JNglV99CsE/qVZvkTyPdfhIgMnbjCQ4gKQsMjU1pWVtRX8W49tZxJLGPYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266202; c=relaxed/simple;
	bh=vCJ61V5nFHaliNUExR1fyQMNiqP8oapJVm+RVdZXtsg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rHv4X0kd/xm113r8qddOPGwesWuUmjTyIodZ+PWOe3cjHzW0ITtUpOeKdYNzON9aqP+PcgM81zPM3zJ1cgzl9TpUMPPaS6lHfLew2fj0yvuBVEUVo1YSHQz9yQ3B70cAdegw9LFVeiuLSp29o318/hvdrEOjtKBeTEFJZ4pUhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slso6HGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD0C116C6;
	Tue, 30 Sep 2025 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759266202;
	bh=vCJ61V5nFHaliNUExR1fyQMNiqP8oapJVm+RVdZXtsg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Slso6HGpptaF0F+nE5fgPhoAOYMBFfFugg3e6ggEcJx3w+GK/ApLCRO4tWYPYtEzu
	 22vmNQE/UdddHzgVyDwIPgwwA7ZachrJMxpcsv3HLUi5MBp1LIm37FNGTpgp67338d
	 x4tKlYtR0BVPQGEWjJ9vqIerU5vKiE6lNTMwdscyawLK9/+pyl9FrCzH10M0nHdJKY
	 CXXW32nSQFobWm4C2jiirr1eY82zIAlx2nvXEWbgMtnrLkSQicFxbbR6obyLyQzBvn
	 ImCY4G1g0Zq895PZMbSiVwor3hHBtunuwCZaPec7SPlS6ckatPwcNkaeeku0brerAy
	 WF7OFqfG3tPiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9B39D0C1A;
	Tue, 30 Sep 2025 21:03:16 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>
References: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250926101649.GAaNZoEZjRzw1u4p4c@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.18_rc1
X-PR-Tracked-Commit-Id: dd86b69d20fb9fa7e941ed01ff05f1e662fcc3ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cb8eeaf00efc037988910de17ffe592b23941a6
Message-Id: <175926619465.2146267.16239901680869879937.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 21:03:14 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:16:49 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cb8eeaf00efc037988910de17ffe592b23941a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

