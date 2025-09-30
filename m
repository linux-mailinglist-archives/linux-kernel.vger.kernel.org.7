Return-Path: <linux-kernel+bounces-837024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E3BAB1B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208E61C7AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E223B605;
	Tue, 30 Sep 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axick03O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12691239E80
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200896; cv=none; b=RPw9uQrR3NgXHRCEJTL9+31bdrLkAHbt+tspHpNWAZBnM9vAj2jNzUC3+GrjvcqyyDRo/d90GNjHt8//b8A4m5pkLJS0xz9bN1pJDuLkkkXXUweW3RcGnC+bN/j0VsovXbs1u4wwuuP0Rl72eQXMjXdLt0jpDin2NCGw/N5kfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200896; c=relaxed/simple;
	bh=ZicMSjLBT73C6YUEalOykYF8YV7rI2OScVnEegaKNQs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FBnloYQdu6WLVx2N+ilLvYjVBnbYBvLA6jPT47EeqfX8OQ4ZQbnase1EmXVUbB1kuD5caj9KicKw2ajxAHGAP0Mzlhk/lRZRtXqpVUzPaUgNBjlvFhzNyMYfFp9N6bcuQZJzWUeJG8w7uEIvqPJ5h9b1q+30ifEzrEG2S5W7mkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axick03O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF4EC4CEF5;
	Tue, 30 Sep 2025 02:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759200895;
	bh=ZicMSjLBT73C6YUEalOykYF8YV7rI2OScVnEegaKNQs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=axick03OuofZ7jXbDgMt8M2IsVikh+XIs7x3SXQ1NeRjnZPZcBKPC37dBcrDr4AQ+
	 7NiMrtZ0ujfooexr30KtdfcI4Yc45WPAk2pBRB+od7cEesiJMsiwpwEO8Ny5ptsRLG
	 Sw/oc49u1X6+6lVAsIL9Xz2A4PFyptzlHk34qx2NnVN/0fCr8iH2NTIDl+PANQCf7J
	 RDGVG9azio1ylWqPCIBGrZ/o1tDfDM7D+tONbvQCEdY3eUGpWUaLUzjq+mZW5NpAm7
	 jhvPrCA0eQTs8BB4iJhqvAH4AT5bdSSde5n0Ea3eDdlM1I8TBWXFQX3PTYA3h6/0mm
	 N0+AUc5kbL+bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7439D0C1A;
	Tue, 30 Sep 2025 02:54:50 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ef737658-d423-4fb0-9564-484907972e41@monstr.eu>
References: <ef737658-d423-4fb0-9564-484907972e41@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ef737658-d423-4fb0-9564-484907972e41@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.18
X-PR-Tracked-Commit-Id: 438f7cd41765dbe8830009a37f90145b7f05ed39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe68bb2861808ed5c48d399bd7e670ab76829d55
Message-Id: <175920088897.1805104.10482685779429544575.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 02:54:48 +0000
To: Michal Simek <monstr@monstr.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Sep 2025 09:25:42 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe68bb2861808ed5c48d399bd7e670ab76829d55

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

