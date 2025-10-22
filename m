Return-Path: <linux-kernel+bounces-865332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A8FBFCD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD763A63A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FC4333745;
	Wed, 22 Oct 2025 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8xrS+EH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AA202960
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146269; cv=none; b=Bg8PJ5xndk/R82ema7gabpKleBuXS6V65ubkwzc3HWHx1R4eTyoYCebpAtS1XFrUYlzeYWE3zYveiC282d1jT4NY4ZNj+Y7K6kGPn9VwP5AxgmpcptXsDYwkXY1rhDnzZFKc6FpegTmhOV7eNZVfvKqsdyPCUSjd+cjcPDrnBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146269; c=relaxed/simple;
	bh=Xt+lKHQhO5uqz21P3uQZy09wOgF1ujie9GTUJ388NwI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DATpQJEQWTpxxNh85snFDvMJo76V2FJV0pNZgShhOEcCOMr+A8UET0dGwTT8yq5sOhyi/pEkTmcLsfhEeSmK+kGArniNkgsOaV65LZlDlcE/J08rFp6L2jDPoklTQRb0OHmNkWlUZ3bFiX5vH3Q4fWWPvDw/HgCklLqt6aRxT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8xrS+EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7FFC4CEE7;
	Wed, 22 Oct 2025 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146268;
	bh=Xt+lKHQhO5uqz21P3uQZy09wOgF1ujie9GTUJ388NwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G8xrS+EHuFW2JEH2qhgr/uVPrJGDYMgjQvqk9PoKCPZAF4pBQxIAjDAPSrtl0JnNY
	 9m54eHgzJiHiZqy8gIe4pnzeoHdmesynkHbjP7wXcWUvavBFkwzEPjdvNm1y4IN95x
	 5fXZ2h/uhpO1vo/WmrDr6+fy4Ix+imSAt9glP4OnkkCrzF4vRpj29M5hh9oqQLhLgu
	 88ReI9/1qGN4PpAIsW4ERIM+dTQTfSzbqlWX5JRXZqkZaXJV/CuYLW94J/NIx8sYg/
	 sm8W5h+nfihgrSDOVbXHqVwPaEnk8Mor8DdpHSFbnmaYNrUyIGwu/QUZnucP83TTJI
	 Yb9bx4vHWG58g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343873A78A6C;
	Wed, 22 Oct 2025 15:17:30 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aPjpkWvwoMrKHxvc@debian>
References: <aPjpkWvwoMrKHxvc@debian>
X-PR-Tracked-List-Id: <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <aPjpkWvwoMrKHxvc@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes
X-PR-Tracked-Commit-Id: 2a13fc417f493e28bdd368785320dd4c2b3d732e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 250a17e8f9555f5c5207581068ebfa2aa1f540a2
Message-Id: <176114624867.1971781.6453629058093549500.pr-tracker-bot@kernel.org>
Date: Wed, 22 Oct 2025 15:17:28 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Oct 2025 22:26:25 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/250a17e8f9555f5c5207581068ebfa2aa1f540a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

