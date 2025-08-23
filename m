Return-Path: <linux-kernel+bounces-783117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F224B3298D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C15247B331F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982D42E7BCD;
	Sat, 23 Aug 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjq6nwiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314912B93;
	Sat, 23 Aug 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963076; cv=none; b=Ouq7ET5MbLkiphG0q2s4TWqJ9v2IQkrXzyATF3NNiw3elGuYtWjoRlG0cWKLQPCaQlsjppiaaozuzFDnnvxbLEG24xSagtBBDlnJU9OgXUpvkq1yC/+vmMy+vMfVCVIP5LMK2DaJvi54ZEkxl7UeLfIS+Xp6W8vpIZvNtpiBOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963076; c=relaxed/simple;
	bh=6TNeY1k4nhWXudoo4/AhaZUU2qelfQ0NxVto+gsMEMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dreo8850FtY78t61R6uLsappodNnVQYplpLOvzrjHi/XrDzeE74Ckt+e3G0PZm6KoUsCaHNfhMFHk3DjRvXcDqQv4/e/pgpwB+z3UNyaIa0K6udAFs3cGVyf1i9k0se3SBOE37NAVoSn4iV+d0cfCX1px5cRwbB3+E/zQWVIVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjq6nwiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40B3C4CEF4;
	Sat, 23 Aug 2025 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963075;
	bh=6TNeY1k4nhWXudoo4/AhaZUU2qelfQ0NxVto+gsMEMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Xjq6nwiCul3ZhSlVllJdQJAcmjcl2dZwgy4GL6ta6VGehPocTqXExbCgYvMTCGMaW
	 FntWC++d60/ndyBNxtCB+HSBvOSvuSM8PxL+nBxnoJ4bf8KqRNQgmIarPF59AUzYjN
	 /EPAO50ZYNCKsvAbXDqzoErUkC4zQE9PrRRI9vQZxs+k7poRxnhEhX6+nkkLXtZSzK
	 DWS/kgWH2KotWlQhoS/hnkVisN9xbgBcbGEIVOlsB4UZ39Fq1f1rHbYikxuXpz7Huo
	 lyGH2XldqDJxvxMA5LYHVC57EP9DDccBEkK4D10ovLz3hp0EQv/oUXi8pqIas0BnIi
	 R3mGbc1zs5jJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE99383BF69;
	Sat, 23 Aug 2025 15:31:25 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aKnT3gmJbnYFoALE@kroah.com>
References: <aKnT3gmJbnYFoALE@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aKnT3gmJbnYFoALE@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc3
X-PR-Tracked-Commit-Id: ff9a09b3e09c7b794b56f2f5858f5ce42ba46cb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8004d08330e1aa7ae797778509e864f7ac3da687
Message-Id: <175596308442.2198696.12368929069651840928.pr-tracker-bot@kernel.org>
Date: Sat, 23 Aug 2025 15:31:24 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Aug 2025 16:44:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8004d08330e1aa7ae797778509e864f7ac3da687

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

