Return-Path: <linux-kernel+bounces-688729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45258ADB655
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC741885B67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296B286884;
	Mon, 16 Jun 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kojHqGTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140BE285CBF;
	Mon, 16 Jun 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090303; cv=none; b=VYqU5g/uRAB5VbQB5ODstel6y37SXbP7yxzgvZYu8MM3dI9LPiLxugANxNxyCHbzt2YBmjPy5GCp7OaJS1BcwHz1IazYfKDjPEgKUxDlO9W/Ou5V7+97Ay9knoiVjC0UNEAGhLzMcd0AbeahYna36Yju+hdo/Q6azYgVf5vkjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090303; c=relaxed/simple;
	bh=VV/RJXjrr6EQgimHja20h5wop7ng5cwkbPCivBxE4BE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fI3Z4d7Hq4ZtY1CnM7PdH18n6YLnnv+twNSeKeX5w16v+JBD39uPyg9fUGVQJQAHLlwoO6MKSHpJoQr5RPgEew4VbyF+Efz9Ifi4+OG4ZYhQXdTaFNILpgF8SZ4R1aC+ym/cQRqIUjNVyfVzYWqr54ah8slVpbduM5cnWTEw+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kojHqGTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0884C4CEEA;
	Mon, 16 Jun 2025 16:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750090302;
	bh=VV/RJXjrr6EQgimHja20h5wop7ng5cwkbPCivBxE4BE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kojHqGTfw6xd8/f68/sjJfwVeVPb7SACGoRcU6lz0my2rfNf+h5cUxpsJvWsCJtQ2
	 oGRcx0bcKUvpXiRXyFlFAfUeI7fzuPCwXAO6s9oJISpW3CvqsQbjDbAyS1WDuY7uPJ
	 yoDKNIAjw9aLSCieRXfXCzRXJumbd1lm8hsGdGMmvCoPMoyoG1FmeK6q/Cl6Yj55Gy
	 LQOqd+ZfEwE7TSdy3OcCuG9RQaS5xM09+VtuqGJWthebiMOoEVmUzqX904sA3O58ah
	 zxnLcq7nVlwGGlc0FXci4hYuJF3fOgOfQzsC11PdRbTkdx0phaOL8GPIJRPv43caaq
	 /w2RN2N9rGFLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3C38111D8;
	Mon, 16 Jun 2025 16:12:12 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250616-vfs-fixes-c7cd6114f3de@brauner>
References: <20250616-vfs-fixes-c7cd6114f3de@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250616-vfs-fixes-c7cd6114f3de@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc3.fixes
X-PR-Tracked-Commit-Id: dd2d6b7f6f519d078a866a36a625b0297d81c5bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe78e02600f83d81e55f6fc352d82c4f264a2901
Message-Id: <175009033156.2413506.5248155856851419.pr-tracker-bot@kernel.org>
Date: Mon, 16 Jun 2025 16:12:11 +0000
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Jun 2025 10:20:20 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe78e02600f83d81e55f6fc352d82c4f264a2901

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

