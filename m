Return-Path: <linux-kernel+bounces-839623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C0BB208E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F6D1899E02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 23:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B3829BDA5;
	Wed,  1 Oct 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owm3cWIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E728CF6D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359626; cv=none; b=G72/XOVnClU4fe7zNToeq6yFJ1bDNN+rRkLxUz09QCo0apg+MpeqfCyyM6s8lEVPoH+QFAiu4MPN+qhwyrHE39NtludcUKAG6Rd/OT4zy4GuOKvBkrE6TM5lbyo31lgY7aYnYzDeVeYjMbPDNubgliE1R/Hv7EPDGRDCnVfgDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359626; c=relaxed/simple;
	bh=i90knxaXnEPVb578K729UTeo7FrmYq8EJoHVfsHfHic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q1fngGdj9rq3nWenX8aQlOzod5FAK/ycAMn9m+NWh0incqfzEINgoxtURUCrdkopSu79Vo4Tu+myZUkmMC+KHWp0FNS1FGljFI2LE6XaN/+358YgAZRcJ+QC8crbCnNfatjgNGkykzOHJy/j5eLSjOB7eNjaNn0eZbwLMLRmLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owm3cWIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A0DC4CEF1;
	Wed,  1 Oct 2025 23:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759359626;
	bh=i90knxaXnEPVb578K729UTeo7FrmYq8EJoHVfsHfHic=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Owm3cWIClHgdwvrB82cq+yXkS9rIZ3yyAt2ojJ8F2qAXFRfNgialTwQsATbga7i7C
	 XKLxIZFbjBdOAo4udsKu+uf1Yk6FuB8ZPIq0XocQVFVsiCkCaxrCf2maf0uI64Y7QM
	 kM21O5AB16DDodJGZkdgufQrPemc//1+7c5EjN2Bcfy9hC7S5IqtfoExLfKkxEoojm
	 r/bM72J0di4XL6yeQVVfZS1gUA6fRGY0vyTU8Njgpc4NzHlQYxCDELLr+Tj56lAwr6
	 xzqiFUB3nJBLJ1YEZ9kXgXdJfAs5bdxuD8jLVKiVnWRmr+SRbGGEgIynHfivWv5wvw
	 vBlWmJHu9kXwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF2939EF947;
	Wed,  1 Oct 2025 23:00:19 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <2025100121394906389990@mail.local>
References: <2025100121394906389990@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <2025100121394906389990@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.18
X-PR-Tracked-Commit-Id: d6ddd9beb1a5c32acb9b80f5c2cd8b17f41371d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 080ffb4bec4d49cdedca11810395f8cad812471e
Message-Id: <175935961826.2651312.93069349055499467.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 23:00:18 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 23:39:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/080ffb4bec4d49cdedca11810395f8cad812471e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

