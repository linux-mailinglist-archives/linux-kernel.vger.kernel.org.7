Return-Path: <linux-kernel+bounces-772497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C95B29366
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51FA316CB0B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6EC29B773;
	Sun, 17 Aug 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmYaRjZ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC31FDA7B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755439288; cv=none; b=KmZWxeqoTqfGhtLFlQqiKSFs3oPj7zDfDZSGq8pVjuIa/ZCpW8p0Mhk/hL8hHiLxJaZ0hHYy5Cz3ODd9x1ssUNKYZBpkS1Tt9gFNcnwI1LO/FcdSaTUIsDZt9veABSGGxEe3h+WpI6kT0Rp7bg2ess27hQkiCoPqRo5MS2jAPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755439288; c=relaxed/simple;
	bh=Vb0Ju2WmmS01XHsOPse2ZirmOV5B7qBhQatDDSU7Ozk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=V0yjL3vIYlpJvAiKHL78BCiwfOWGCG9vGAH4rtwiEEw5JUya8mNzNISKzKtOXcI0lHtoHyDnH5itA5ur9aWMJWnsbHTlPZhkKX+KrwS9OstFzOoVp3zBqzdIGFVy5LZE2b2BxE7Z3jCmWYkg6Sfbqr4Rbiqo2cz+Am9xANWO5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmYaRjZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADB5C4CEEB;
	Sun, 17 Aug 2025 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755439288;
	bh=Vb0Ju2WmmS01XHsOPse2ZirmOV5B7qBhQatDDSU7Ozk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fmYaRjZ5hO2xbskdkWjpZ4OsXecxwIDwd3btjr3f17rZQsWom3t64MC4RZJGD9U5J
	 TgcvuLs5f35MwPvMNrWEIdf/qdDmi3N4VQB5lYuvz2VYKfVZ58/um9Njr99DQ/3UEj
	 XwgRCW8Ho3iVCmV2L6LDxMTDlxYcDxH9F/51q4bqWXFpjCld0plIL65fItP1pN/Yb3
	 tGX6auSnZtRxGavB1hleiPdpTkglzHUXnu4RvI7kqt7i4SPMsjxPz3Ocy8wO9CJgrD
	 IjxTB//BtfGGXO5WRUqYLsGwoWTckJWtZVvto6BKMMthfDkvFNmS16FNNnliTX3bv3
	 FNnDx/EhXQFVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0AB39D0C3C;
	Sun, 17 Aug 2025 14:01:39 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250817084235.GAaKGV-7rQHWqTisp3@fat_crate.local>
References: <20250817084235.GAaKGV-7rQHWqTisp3@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250817084235.GAaKGV-7rQHWqTisp3@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc2
X-PR-Tracked-Commit-Id: 21924af67d69d7c9fdaf845be69043cfe75196a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a9ee9ce49a66bfdf12e34130b45fafe170dfc84
Message-Id: <175543929849.1709731.14908119151058689111.pr-tracker-bot@kernel.org>
Date: Sun, 17 Aug 2025 14:01:38 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Aug 2025 10:42:35 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.17_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a9ee9ce49a66bfdf12e34130b45fafe170dfc84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

