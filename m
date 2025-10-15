Return-Path: <linux-kernel+bounces-854897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDECBDFB48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762D33BEBD7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFD02FB098;
	Wed, 15 Oct 2025 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq8/8mmE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA562253F14
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546406; cv=none; b=ATDr8M3EgP3DnMQ0hm4VU4yJyEAD8eyeRNa+elnuXCi5Z1Ew9Y2MBKekCTOwOlkznglyhEinY0PtoK/5HlgOyezQJY46WWdtqULi6wntTgtfoJyVKYiLaUmzKUtuVVEIYAHo3JA8rGILA36XAjMpdCqWO8Qu+d56HTFEQdJH7KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546406; c=relaxed/simple;
	bh=RGrLB4M6JbBT3ph1NWp3S9rTfWUqtEHjK409g4SkFMQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gt5eroVSDjj52N/MZu3+HVcN7WtlvzIx/vybAPO/A5KVC3APX11PKDMBmi37H6EaE4BH5jFy3UUk/aplSpjbEQny7WaYpF1aq+IGhpL/qOm+gQxNoBjqshC+jY8YfxwFUOmCl5eIQAphsnr6Q7lULXQzXmT2hi/AOsdT9IJJqoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq8/8mmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48107C4CEF8;
	Wed, 15 Oct 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546405;
	bh=RGrLB4M6JbBT3ph1NWp3S9rTfWUqtEHjK409g4SkFMQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zq8/8mmE+HoDSXLQOyOK7VUL+LfH/OJ293bBPjXyCC3YWLq/P50kgEsjQyWbmJD7W
	 5iCAAC9/Du2ZBC+K8zbh1jMvha1M3cw8eBpZxvT4LSdEvlQ6FzkYWuij0NKQPMkkLe
	 zQvNzFcEx9Y0k8V8CZ+Kse69CuX7SBfBlxStmg1LFKmML8jCkINQF+WKZ0b5cIF80d
	 GX/78QXlZr/gRwZctLN/BnAAg2YVIdw72t25KkgEPoSajigG+LtlDX+zr8ur3FUFkW
	 jkHJ6G2cUKqudvhskU5DgAIb4SRayjRQZYm7RUTWgP7NavBOD22MU4tMai1lDCO1PP
	 /FZUx92i92abw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34322380DBCA;
	Wed, 15 Oct 2025 16:39:51 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aO_AAQBzqMkrGiry@yury>
References: <aO_AAQBzqMkrGiry@yury>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aO_AAQBzqMkrGiry@yury>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-for-v6.18-rc2
X-PR-Tracked-Commit-Id: 7e85ac9da1acc591bd5269f2b890ed1994c42e96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a6f65d1502551f84c158789e5d89299c78907c7
Message-Id: <176054638969.953032.16371572077824438146.pr-tracker-bot@kernel.org>
Date: Wed, 15 Oct 2025 16:39:49 +0000
To: yury.norov@gmail.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Yury Norov <yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 15 Oct 2025 11:38:41 -0400:

> https://github.com/norov/linux.git tags/bitmap-for-v6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a6f65d1502551f84c158789e5d89299c78907c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

