Return-Path: <linux-kernel+bounces-841776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F56BB8359
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D821B21880
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE38271458;
	Fri,  3 Oct 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2AWTBj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07926F46F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527193; cv=none; b=Vqkxp0Jq1JpyFkJNFZckOw04ADOdXvXKDPW7r34KqPrSG02GgclATalaKnZDjKDu5L1ks/uZdbiw7vSE+1FtgQ5PYhNpBjOHK5s1G4jYJnfNoOhm8ByTIfdavP4FF54MTFsPRUvZLaGa/3UNuBUZmqgyMerStFt7M66hHnKQOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527193; c=relaxed/simple;
	bh=3xSs4RrCNzKxDKmpGZWXuOWngJGzACqZi1M4byX9/fQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ofl7IVbBc1kWI70W3kQqPd1QbXGKhwLKsqVBcLvJL4vACAoAl92gmztA/Xjf7FqxDPGKPuEbxfxciDwnPRR5bEe0xZpUGB7U4bpYvv91FjMx+7rifSwjW9r520TkvH9Q7+WJh6NApb8vBIAqqvBZn3BmWajsmMozLpJDRZxRdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2AWTBj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA99C4CEFC;
	Fri,  3 Oct 2025 21:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527193;
	bh=3xSs4RrCNzKxDKmpGZWXuOWngJGzACqZi1M4byX9/fQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M2AWTBj551SDOPH3drUosPcP0tjtMw5FIBQPxTx9/gZpp9/y1wG+VUViTeolg5UIh
	 F+RYjSTflyWsQw40vIojNeseEh5HN3jfwHT0Gl0BD3A/TNZ4UNlGvakGixomOtZzDU
	 yyDRpG2VB+hZZvL7t3/lCQj3/1bvTj9LhqyjJz94sHyDROUqMQ2rqIK+YUM1Dj/fGo
	 KowXZ3JrsSd30CHsiS6Ni2qwPblmvGKub6S2zGVIXqU1Ux4MHCeJtXEIwt+xwxD1/z
	 MQdvTK7krnaN65txB5vW276jbkC9Vm6hpoTMCswfXAde/hB9yb2R7MdHQbTDzaeqAc
	 9DzV49BxaMk5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB52539D0C1A;
	Fri,  3 Oct 2025 21:33:05 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <5c57a633-af5b-454e-8adf-c28b3e66df12@oracle.com>
References: <5c57a633-af5b-454e-8adf-c28b3e66df12@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c57a633-af5b-454e-8adf-c28b3e66df12@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.18
X-PR-Tracked-Commit-Id: cafc6679824a026998d93e7435f6005f64e515d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cb08b62fb1ecacf886fc0142316b17230e1b3a9
Message-Id: <175952718451.86168.12340283773004903380.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:33:04 +0000
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 1 Oct 2025 10:30:17 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cb08b62fb1ecacf886fc0142316b17230e1b3a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

