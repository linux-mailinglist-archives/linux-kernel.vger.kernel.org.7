Return-Path: <linux-kernel+bounces-750188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41BB1585F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE718A2E65
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84451DDC08;
	Wed, 30 Jul 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLSjbRAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA071487E9
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851963; cv=none; b=eEDjC6G+bc/JYrDfyAOn5a3GkpdPHgQ1SY/Cn5Bye0IcAzePeLwuKVyMdjXERPEABoaQiU6rQgk+WKfrcNScghW72zbEsBcsxl4kzwFV8LcnUNqm9uncFNgYTQBIHvbRAhcgEn2rbMZwHqOJ6eR5Q6DarC2equcIjUgZHGgqjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851963; c=relaxed/simple;
	bh=wF0V4BeuugUADu5ElxThnyB2J1gMPaSBZOrKlCoe3EU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OmjSUpPGU9fL4Sx/NfjjuXtkniFMZuRemXdZB8OuQvhCguK4L/kF+GlBHdwszh3qFOFguOiD1kKH7EjowYvKYxhGSmRhbnzjkpIcumVp1F5f64OmLfJv1I/HpO3XLQKxmRQHhes9nAeEmmBfEHjGwYqBNFBMVv9mCZWDgCOSRHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLSjbRAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56E2C4CEE7;
	Wed, 30 Jul 2025 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753851962;
	bh=wF0V4BeuugUADu5ElxThnyB2J1gMPaSBZOrKlCoe3EU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uLSjbRADhFp7vsjwtzk8pWkHNcVuKK3qef+K5YX5WppxAaZar6GldONk2/9GggfJp
	 6dL8Omv0nk0cBTr6ovVccq7JazZKj7zufKLCsHELhDg6wtDFMLoNZFyhfYfWc3IWBU
	 is+ZUtooAgXeUTcHff/wAny/z4OB6TxNHhN9Ulv3KdaSRznnIIS1jlGvI+m0fU1FgH
	 qjbByUlpRs4xXVgdwiTaqum4Ccbf/uS7H+Aj4IUK7KRWR34JVRax+tFM9yR8L3kg5q
	 DfBrX2cG4+sKuGHJdu4Spi7yXySyjuPQzR9JaxDD+FYKEN6OlpukRi3nH3gw2RC3rM
	 49vm/AiScjXjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C5E383BF5F;
	Wed, 30 Jul 2025 05:06:20 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202507291728.51BAA26@keescook>
References: <202507291728.51BAA26@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202507291728.51BAA26@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1-fix1
X-PR-Tracked-Commit-Id: f627b51aaa041cba715b59026cf2d9cb1476c7ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a26321ee4c935a63c29ed6518f27e38826b36e68
Message-Id: <175385197877.1779474.16601468326627018838.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 05:06:18 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Hans de Goede <hansg@kernel.org>, Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>, syzbot+5245cb609175fb6e8122@syzkaller.appspotmail.com, zepta <z3ptaa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 17:29:41 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a26321ee4c935a63c29ed6518f27e38826b36e68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

