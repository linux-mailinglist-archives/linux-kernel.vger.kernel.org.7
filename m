Return-Path: <linux-kernel+bounces-750020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CAB155FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668321893F58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45128540B;
	Tue, 29 Jul 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpRjJ937"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE21D001;
	Tue, 29 Jul 2025 23:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831784; cv=none; b=T091KIKD7aKdwBVFatA2EHcxcgn5Yy/noDFbCh0uphwHDS5YecB1i3DEYlEDdVLfrLlB36Xa78hWw8SykFnP3tEUAfoFKINaK60td311dGuiQYUixrq+6fWRmTyKRCGslpIlibY7qcn5vjMmMNeyvoKP5Wp/MmsF/nAlG8e2J1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831784; c=relaxed/simple;
	bh=fqH7Seg4htMeGwd1dAQ9V0+v0+ut4Ff/vxsKXxrKxXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U1n48rDbzWofBocvOFIwdvM+4DEdskB1ez6bzsql39P4PUcHzV0E1XajMjMsNforMRfHFgVR06Q8IeBpTSbdkok74N311UzKOEZFt/XbdDtskrG+tjya3SF7gBz9kHHRlskwMU4Q1o9EJl2gNpTQHsHJ4GmybkPxR4fiulr6fPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpRjJ937; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F53C4CEEF;
	Tue, 29 Jul 2025 23:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831784;
	bh=fqH7Seg4htMeGwd1dAQ9V0+v0+ut4Ff/vxsKXxrKxXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CpRjJ937jZ7GMk29kvX4zxxzbS1LpUnCwDxKqNjhguSP7sLTZ4/5yFrnOXHahOXUB
	 MlfXSIgkwKdXWIuMUw0YYLHVW30zY2I9HSqrKB0S0RtrRlWjTbdDvhMmNbc7bB07n3
	 pJjlH46l/Jm0phYLhe0OFB4w+stQywFzDfZXX2fxQnuSUlgvtEX5MV0z70rCBXqTf1
	 yo7MAT9DMek4v5o2YxWFQaI2Y7YI5IpxEjmT2tg5oz/e8xm3kwn0kV9rBo0DHq+WKc
	 L8kSKo3ghMVUKF8vYz+WsatM7I/ljTaM3Kb/H9M59igZB0hgdrUNKYaxtKCsOhaK3G
	 LmRBJO0fowukw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 721A1383BF5F;
	Tue, 29 Jul 2025 23:30:01 +0000 (UTC)
Subject: Re: [GIT PULL] LKMM changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <788e1aaa-73f5-4e04-a7f4-bab4f1075c46@paulmck-laptop>
References: <788e1aaa-73f5-4e04-a7f4-bab4f1075c46@paulmck-laptop>
X-PR-Tracked-List-Id: <lkmm.lists.linux.dev>
X-PR-Tracked-Message-Id: <788e1aaa-73f5-4e04-a7f4-bab4f1075c46@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2025.07.23a
X-PR-Tracked-Commit-Id: 88172700423c27c0123fdb05b8c4a62444cfcba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93942645c44f1ed4e834d162ae5ad9fb7ef07213
Message-Id: <175383180000.1684090.18219611364933929789.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 23:30:00 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, kernel-team@meta.com, haakon.bugge@oracle.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 16:56:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2025.07.23a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93942645c44f1ed4e834d162ae5ad9fb7ef07213

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

