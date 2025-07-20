Return-Path: <linux-kernel+bounces-738303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A2B0B6EB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369787AA5A9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FBE2236F0;
	Sun, 20 Jul 2025 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVVtTMkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC935223322;
	Sun, 20 Jul 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753029059; cv=none; b=KAj+weFCJGRBOqpX4CrQhxCFPPKi6ZMDZ0Gh/h6xV61/iR3EkgsGk56+qTmi76NziEvqjwHpUwbLHnX/y09CEtUcex7coP4Y6vcr1EONzVzmHNbf1c/9so+Ilivl1BTHv0sRC05aLp4sX7hi19SMOWlGLsZWhd4fhEbu43RHYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753029059; c=relaxed/simple;
	bh=BZgnzQCRF+dX1IQTscjmrrVZRSe5u8d5lYCLdb+x0mA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b9z4WILSoQj5SAlOyG9PxhnLL9/zgjdBnSdzbs6pQOxO6t4eQAIWku+yOxUjqwAGcM8PuZJqtE8nbDAPxxfGL3691k4u6WmHq6h9zupo7Rn45ibbfG/pBJqf9E4OWNGoNPBNZsQKVDmLOyjmgd6uD+g5lIIrR00SOoGUlE6jhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVVtTMkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DFC4CEE7;
	Sun, 20 Jul 2025 16:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753029058;
	bh=BZgnzQCRF+dX1IQTscjmrrVZRSe5u8d5lYCLdb+x0mA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MVVtTMkYKxbQnJsYcGYVIT94kkeR9X+EoWj1JCokXMTPuCjVPuzkKBb6hDlpoYPVQ
	 DyLlYneRig7V/BPIiM8nuH5U2zm+D7ZLnIseb2+zogSrbBXonG9R2cP2+IIKyD2Z4s
	 38qzR+vnhPn5cptr3h0TZnrRya0ZwsX1gVIv+3LsforGOD4claXQvyCl+0uj5xdodr
	 w4DDQOafbJfgfZBEn8kDDYiJZ2hpusnmGxg56/5eMgDwfWfkZHrdspSFxIMh8KaDmA
	 6T4uSbgwAB5YQ5OlFJY4/l26sB+UUDOeB6RrrgvJSXCGYq1a3KUtlF5VumjWOipK+G
	 1w96zVdGpccCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE6383BF51;
	Sun, 20 Jul 2025 16:31:19 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aHzI-b5Kiy_Nu6l-@kroah.com>
References: <aHzI-b5Kiy_Nu6l-@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aHzI-b5Kiy_Nu6l-@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.16-rc6
X-PR-Tracked-Commit-Id: f2b8ebfb867011ddbefbdf7b04ad62626cbc2afd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b933c72d650abfb833b6ef700c26271d0a252f37
Message-Id: <175302907779.3241589.16616538056268259386.pr-tracker-bot@kernel.org>
Date: Sun, 20 Jul 2025 16:31:17 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Jul 2025 12:46:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b933c72d650abfb833b6ef700c26271d0a252f37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

