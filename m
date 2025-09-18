Return-Path: <linux-kernel+bounces-782023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4804B31A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9909A21809
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA3C30E823;
	Fri, 22 Aug 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfmtiu7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD530DD35;
	Fri, 22 Aug 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869788; cv=none; b=hMpjxr5RvkzIAHxH6pjhco1dD2S3jCWums4KlvsxCmaQIFDPIGUN0QRThJOU0J3biHFcTene06kYCIzqQCpAtdmlExB0c6sSynpEKy6qhjFf3IG5jpFbeiW4i0YaBtNVdNzkrVBTOkYiu55PkoJvQP4coaDyy6OmE7HzyJcKwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869788; c=relaxed/simple;
	bh=6y+azjdBlcBYSLx0Z3b6EZT21KQClegof9PdhoPF3Qw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qLsntlKdu/dXrg20sD95dhx+Dl8BkAAc7aA2IwGlOrs/qNgNjP312i3o0boTK5ooXD6oZHFWeOG2e+5dp3B6Istda2ZdX0NN45y+EUu/q+eqVCCTL5wUR8NrG5f4CJfGY9ewlodZEVTxSE2iZKqvwFe+VjrAVFMmApEosBkygVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfmtiu7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E60C113D0;
	Fri, 22 Aug 2025 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869788;
	bh=6y+azjdBlcBYSLx0Z3b6EZT21KQClegof9PdhoPF3Qw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cfmtiu7xjcp6ZYJ0BOAJixv8rDGWS1YoOgcywQCAIf8UQ0owJ7TzQ+AxQ9xs0E7Iq
	 u6KDivHmsihiE8ZLkj8sjumK4PLSTVubIYJwCRwEMQ8YTtiwcIZFZVe1H6jyEkGyev
	 MtWIvSThNwgT5rp1hc0STMCk0hWsF5Z66fnNraa4E3uGzE3c6bAeVss24nfpxA5DV1
	 J2MoK1/xdyZtKPKErtS1NcMLp3aH7p+mHysTlvQ1VX4YMb8W7+gdFzay8XtE7QVCid
	 Ge9kr0uyZKW11MUzYJ58WsVSeSGeDymgrot3qHYtrxoiDv55Yl0TZS9g07rNa9JT1R
	 9hqkOQpcnHqKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71EAE383BF6A;
	Fri, 22 Aug 2025 13:36:38 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250821232412.GA1361976@nvidia.com>
References: <20250821232412.GA1361976@nvidia.com>
X-PR-Tracked-List-Id: <linux-rdma.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250821232412.GA1361976@nvidia.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus
X-PR-Tracked-Commit-Id: fa2e2d31ee3b7212079323b4b09201ef68af3a97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2d324af56f703eb1491a9530c026bad2f700bbb
Message-Id: <175586979698.1831455.4097638096753286687.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:36 +0000
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 20:24:12 -0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2d324af56f703eb1491a9530c026bad2f700bbb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

