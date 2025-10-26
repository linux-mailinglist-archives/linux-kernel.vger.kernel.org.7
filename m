Return-Path: <linux-kernel+bounces-870491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92458C0AF2C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533FF3B45C1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206C2E8E10;
	Sun, 26 Oct 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWFSr6ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80D2E7193
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761500282; cv=none; b=rlWUp+SdUtiHt7+77fShiy8Tbybv/p4aIdlH17vCEZJ7tSc+RFPKf1j+0F8I43MKoF3iC+qrBscmHkDJrOLJ0ix/I1t3LkvzVFZvO7bGq1xlz/6bbK2TUgJ/YN91yafrl6enZUgqnUoFKLuYy13ED3kxEJL8h2FJqcRdHhxlGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761500282; c=relaxed/simple;
	bh=CBNx13mX5dDeIpJgDqjnmBPrHgbpnETdbs3s3obCPMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f7u4xyIzQ47rTDqBmBby58xBo+EdOsNOMdD6Zs2YiPzQyv2RkboisekGuLRvW3R3Lg91RdlI+mIjiOFk0gRjW5/abVuCLxetrDsQ+kKa5JkG96Z5+thDkyxiyCBM33bzr9Gry6GYjooDzAjDhkWYQLQ1F1SxR7voEoYZ+Zdkn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWFSr6ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72575C4CEE7;
	Sun, 26 Oct 2025 17:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761500282;
	bh=CBNx13mX5dDeIpJgDqjnmBPrHgbpnETdbs3s3obCPMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YWFSr6tsjXBelalNibqqMa8YQkQ6MH2QcWZIndCfHG/sBlaYVtBm+Cmt7Y9WtKPTe
	 brMQ2ti9emvGcbnUu9lAIDwW3RDbimvFGDZmQEiijGUa2wxzLJXo1xaBHOqY2KWG5j
	 vPUwLnDmpzuAz8c7XHZ90wBI/yXdqRzqg8DIy6opxUpsDR3QRWhpIivAnHtZyEQyEH
	 aXNPhbr2duxThk2Mg83gWy91+DlFp3lOohmxaVrAb8AM9jUq1QfRDn/LMyPfvUuz4D
	 Gv4qndpbeIoGV29xJBgVXOR4XpYlj6yi9d5bLM7pPKxHGHjAaiehY2Ay8gfyhGX4bv
	 EgtNq2f3dZipg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71220380AA7F;
	Sun, 26 Oct 2025 17:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aP4pevpyQLbffmcy@kroah.com>
References: <aP4pevpyQLbffmcy@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aP4pevpyQLbffmcy@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc3
X-PR-Tracked-Commit-Id: a8cc9e5fcb0e2eef21513a4fec888f5712cb8162
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d
Message-Id: <176150026111.300159.978508220510386049.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:37:41 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 15:00:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

