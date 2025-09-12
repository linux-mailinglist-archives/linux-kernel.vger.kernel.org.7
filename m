Return-Path: <linux-kernel+bounces-814565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29363B555A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9601D64EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66706326D60;
	Fri, 12 Sep 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuTtuv7J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F373019BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699349; cv=none; b=J9Q5HvQHlNQuEnUhZQIVvhuslb9d96TKKmnkFoIOIzeLDGF8oE+LEMOpRKXrUKdy90TqHiCciR9TjecjAHixSMxJA280mB3QcseWBm8LlJdcKmMHwsJF5qiTqBMebiunyggWrYuGA3WJwAOA9N6/ARE7keqfahWwhIi9qBCfJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699349; c=relaxed/simple;
	bh=Y3N3CVC4GV5QWmVOOamNa1sfvGeVvIJ++ZM8Dzz0v1E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TwFAROOFmK6X7e/jBq1bppKm6DA7WQO/39IXWhm/QIjzUtxd+ZzGLzK3eLabH+BihHCzpHHeajFoNtI0dLvpLKgqLx52u24duuFWhC34XjUu3ZizzeG8vOFYpf7hx8cN1mGHNgCmlJjVCicZWv2pE4nFaGythfe2nAMHZQ10tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuTtuv7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A57FC4CEF1;
	Fri, 12 Sep 2025 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757699349;
	bh=Y3N3CVC4GV5QWmVOOamNa1sfvGeVvIJ++ZM8Dzz0v1E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YuTtuv7JI7LY9pekHmj7epSB/l7uwiNNkjajCWALSFgVcYqqPWzE2EHmHLlGa0+Wr
	 WFnc0LWJomc+0fJArBCpWaNZl5CJv7RJI5SiANx1VrOtuIbexxRHcYNdBJljHvvotl
	 GdjOjN5SY9oXG65BuErbz520AXj6C92xh5JuZnXB6/X3QlHUC8igzkqGn2Kg5l1H38
	 GhCPoXUN8TWWzP4xdg6ZvnquEjxjz5GN+B2x6Xr3TJs7Yim8/fv+ougfPMUOGPS9UW
	 Qy8Vhji0g3hgh0+iZ4XjJ1hh3YREKT8JO/1FIl82KFmKA442ppAMMjYUqKSYwvOVvH
	 hGn6CGuKCeJlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DD6383BF4E;
	Fri, 12 Sep 2025 17:49:13 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw1QOZSBq+QhAbpyc9UvY7KYTfA+K=JQyo+_u+nBcTdGw@mail.gmail.com>
References: <CAPM=9tw1QOZSBq+QhAbpyc9UvY7KYTfA+K=JQyo+_u+nBcTdGw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tw1QOZSBq+QhAbpyc9UvY7KYTfA+K=JQyo+_u+nBcTdGw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-12
X-PR-Tracked-Commit-Id: 9a3f210737e958c3f45a4ce0d7f1ff330af3965f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 965c995c9a4b395471ff48790a0155ee986ca405
Message-Id: <175769935190.3023336.14398687217530924597.pr-tracker-bot@kernel.org>
Date: Fri, 12 Sep 2025 17:49:11 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Sep 2025 14:24:52 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-09-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/965c995c9a4b395471ff48790a0155ee986ca405

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

