Return-Path: <linux-kernel+bounces-815423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22760B5640C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 02:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66C32A14AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640819067C;
	Sun, 14 Sep 2025 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+5Lqycv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A362C9D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 00:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757810466; cv=none; b=XnE+BmTi08nOeETLX/olZvfRaIzl1shwfne2YyGhV7Pt0RtG00ZMKvcoR2Ulo9wNSI3LXqU2pqxm9bqIHnjikYXt0X3OmgZyhZofREypDA3/HoAOPmVyji111lIka8RA6uLCUYpMbe9SRMtMnhSVBEiaWX8H1zqIDZ5ulbIRm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757810466; c=relaxed/simple;
	bh=OAUb8ZvYxN36zVsX7xEQ0Pg09I6w5MYWXOCYnHvxvNs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SJfIfnxRmOV3nhdRMksy1AdOQLRfXUFTVnHlT+g0FcWQts/Neog9U7jF7wTYoBsBBqm7U744zh1sFTi1Pn269rSHw2tsZJga77S0c3lHLtNjmN06fdAX+9GOtx9sDZH0uIUXB7yX6qWanwYgMJsTYnUJJ+kikky2DWgt2EYKc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+5Lqycv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7DC4CEF7;
	Sun, 14 Sep 2025 00:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757810465;
	bh=OAUb8ZvYxN36zVsX7xEQ0Pg09I6w5MYWXOCYnHvxvNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B+5LqycvwYenDk0DWunYKipABIPpLnJoz9Mv6/l48ucKT1FIlZ9ryHsP5sJk9KxSn
	 txWhYuB2oEbkElnYIZTBwTUBVU79L5SMphB+IKkpMWk5sRUIeu660AZUJDurSNzZUg
	 B7BtCJMvHuURV7EryaLLoAUicVFGA4pEC+5Fm3rNV13A58R32eKab7S09sAWenYoba
	 JUvFmZB6W/hQ2gffNRoPVU5as9jaDx/HnVOIFsxo7AvM1nU8hC9S9Ql2Y3U6dMhW0u
	 gmnrl2ltPZ1CfMWUS238vase3Hr8xpR2xzm3p8BIjW1SEz8l8HCcjKZu0cBIiLTe80
	 sZnBBwlQ9uWbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9B383BF4E;
	Sun, 14 Sep 2025 00:41:08 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.17-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aMYGn1hQjWaQCaiM@debian>
References: <aMYGn1hQjWaQCaiM@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aMYGn1hQjWaQCaiM@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes
X-PR-Tracked-Commit-Id: 1fcf686def19064a7b5cfaeb28c1f1a119900a2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f83a4f2a4d8c485922fba3018a64fc8f4cfd315f
Message-Id: <175781046727.3349841.6826201067650734287.pr-tracker-bot@kernel.org>
Date: Sun, 14 Sep 2025 00:41:07 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yuezhang Mo <Yuezhang.Mo@sony.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Sep 2025 08:04:47 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f83a4f2a4d8c485922fba3018a64fc8f4cfd315f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

