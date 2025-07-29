Return-Path: <linux-kernel+bounces-749794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F14B15305
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78773B86A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5829B793;
	Tue, 29 Jul 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUEdqYUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DD299A9C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814436; cv=none; b=TribmT6xgAh4uM3wYIEbXUVJ3i9sN6kiwarm44/swUqNaXvI5Km3QG/hxGPioASahCjy51Mi/TFxaiK+L/fJ4ucOCMQ1hApfVJLXo/vZnQhcgk6VFkxWdFgNGgJaSCAWkjxWYq/2yyVxk4P6rPyMG0os+EggctcA671jjXDmoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814436; c=relaxed/simple;
	bh=ZBvxqOUmWkuf0UR2wORn4NwXP7a0Vaztc/6ilqFfOBc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OVE/EKCl7lWQKKpXalUkcbLV4890Q1sYGpxjOZmiYWkzzbjmOcdtHHhIXPdM096ul1eDMHnNkH+VpAea32f5TbKdkwNPxgUsg/iD5IdVoyuoC8Pa1mjw8s0sUvoozetKDxPDkHTIhK+u9Ou2R+a6Iz4ph9HKDUd8/+JnT7rp9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUEdqYUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECE5C4CEEF;
	Tue, 29 Jul 2025 18:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814435;
	bh=ZBvxqOUmWkuf0UR2wORn4NwXP7a0Vaztc/6ilqFfOBc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NUEdqYUr9OwIq46sHBWQOX7LcDL88KnyW1MY84Um5gCMWHFe6RTbMydQMzdZgY6ea
	 V6b7+BsMI7/eu9nyZucvxXC+ke0GZLHcnVjUbloGVjd0PFvGxv0Fc/YrjHvPlmlP1Y
	 dAmDj/y1JDgXEZJBArrTYBDM88TNDbd+243VkFNlOUFkuGitAFW1qFNpYP9cX3oTKj
	 JicLE6EhbbaouJuR69tRSFtFVtwh993Yz56v6wrJza/yymhLUgs5yxmxzsyDM+2l/g
	 izqcA+Akontz3hWYGvJcvUYQtdBYBwFT5et34rAFExlnuCZ9XtAXbtR4lLKapXvda3
	 0caPOKMSzeiDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEE383BF5F;
	Tue, 29 Jul 2025 18:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver updates for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIeagbhjBqBFGjj7@kroah.com>
References: <aIeagbhjBqBFGjj7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIeagbhjBqBFGjj7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc1
X-PR-Tracked-Commit-Id: fa3f79e82dce7b04f7b8cf1791268a775b3d6f9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d5ec7919f3747193f051036b2301734a4b5e1d6
Message-Id: <175381445208.1585410.8416146341679423001.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:52 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:42:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d5ec7919f3747193f051036b2301734a4b5e1d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

