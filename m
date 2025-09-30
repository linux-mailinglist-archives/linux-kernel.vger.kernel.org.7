Return-Path: <linux-kernel+bounces-837020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7ABAB1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918FF17BC66
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5421CC47;
	Tue, 30 Sep 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkozg6RN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183E2144C9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200880; cv=none; b=SXIxqhly0gZ/Nzl7YhnjWGe3YScQY89aO2nV68l0si9NNm6KbRZGkSQ8OXM+FPcsdtDAkOGRI1a02pNhWTos/O+HhQXTd1O132s82M9BgmpZE2GN6Pvw96XwDDVVVx+OeHoDIy4IeXHsxcVaH7UDMLMmcBQ0WX+fvYiK0AAbABA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200880; c=relaxed/simple;
	bh=oehZohf/K7J5eHCEI8+BxZ4Qae9BeXnKZEFyQhmY0lw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cUuWV4fssxrRi7lFhd0WigFIVeHjy8mYCILvZsc8dYE8EqkaM0pUSUOBXuP77N34p71czJd3xFNBlNCU5QlJhH982NRUA6qNemIDZJaPj9jo/2Vh15Ew5M+0iKDIalC9iMLRGmbXr/DIcHPZAmS1f4VyN8iOMdsS5O7+nat64to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkozg6RN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C19EC4CEF4;
	Tue, 30 Sep 2025 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200880;
	bh=oehZohf/K7J5eHCEI8+BxZ4Qae9BeXnKZEFyQhmY0lw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gkozg6RNvruMxGaAtx4iAUYUyCVQbH4/wbBfeF8w6RvFVxmyD2SHIBFV/jXJSSfcp
	 8WC8Xc5VVKUzQ5qroUUe+9dDkcRw3LsVe/YVoR6NLdwMG42yHGLrYRBZB/nIi46jXA
	 4y2foJbLhj7iLYfG1N/B6GRS3E0zq+M++Frgl2FXFXOipdG9GNXMBcZUt0+6GBoUb9
	 e+57GDaZTlMnvbChDaL7swnUMFM+D3B7Qx19SsPvgnF3uOSjGbMVO/SVjQx67Y5O2J
	 dotzo8BV4bEF8uotq2LY9kgHqOIUl6vV1Dx+ddKZJ84HyZ4Q/W5ZkzVKdlpyKtQqYo
	 u+gKlqkefkRlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDA39D0C1A;
	Tue, 30 Sep 2025 02:54:34 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNbJ0YiL7Us_eicz@willie-the-truck>
References: <aNbJ0YiL7Us_eicz@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <aNbJ0YiL7Us_eicz@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: ea0b39168d3a2313eabd145fb3440c946ccff4d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: feafee284579d29537a5a56ba8f23894f0463f3d
Message-Id: <175920087330.1805104.2171094738678723423.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:33 +0000
To: Will Deacon <will@kernel.org>
Cc: torvalds@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, brauner@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 18:13:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/feafee284579d29537a5a56ba8f23894f0463f3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

