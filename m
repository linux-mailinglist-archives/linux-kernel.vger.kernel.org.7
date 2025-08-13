Return-Path: <linux-kernel+bounces-767365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D28CB25360
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C1F9A1FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB702FF16E;
	Wed, 13 Aug 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdlaPt5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD062C032E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111324; cv=none; b=IjwA9UsjKQeSb9G9uaFPY5DCYm7szpiAbfJHmS5cNKa6SbfDkaCEHY3TweZoSpAmLt/GCpbgwod0BAXaYsZJkrKC2i2vWljAuQRzLrhdVJmi+oeVUj+nUCyGyPkWoicMUlzcEcwAUHIdTeRky6WI4cTHgQQtXLJWZwhG2/rW7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111324; c=relaxed/simple;
	bh=pTGCk3bS3OknouKmVzlKeIj5BTjrRJrgUL/s3EauJ3k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BiPMr1jdX4J1PZMpApFcLVMXn9340wyAa02JqFbTqTek9W7u0Ld2YZeNs3uEvv9thiFFdbXeC6GRMmztqeD7kr1HhLMQ9udur3Ofy845NwjSH6z0LP3n/A22Ompb+atc5TBrNh7ak4+EXcX+YfAahOAs3buTdzHcLtDmVQJ9B0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdlaPt5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8179C4CEEB;
	Wed, 13 Aug 2025 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755111323;
	bh=pTGCk3bS3OknouKmVzlKeIj5BTjrRJrgUL/s3EauJ3k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tdlaPt5OM+sM5GH+5ANMMX4JoAc6fO0/98FtNY8di9SFHIoG8to71rvF2Gr25OQLh
	 sVb8P4vGTALh8MWP6O/muLL/QcjNnOobOM6sUmkEGZNHjoYoaVB0759TRJcsHY775C
	 w2ZVCrHVjFJ8QFqZerC5IO7niO31hsZ+rXEryhnl9g61r6eOAIEBPkl5sfkTU+OB19
	 ua3Ov1h+97a7UyrV3sYBqcvCP3blNbkzEpqI7txSpvIggKnLyRSC3qFpnp9xztTBa0
	 MiV25g10nuXBIKkmZSvWLbeFvSztNqdGVD1ur5xghogGoQV9t3SQTjEsdsqp6FKNsX
	 8r3CW/e0GiRmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3C4139D0C37;
	Wed, 13 Aug 2025 18:55:36 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJzUQt58S0ZEv0zn@debian>
References: <aJzUQt58S0ZEv0zn@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJzUQt58S0ZEv0zn@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes
X-PR-Tracked-Commit-Id: 0b96d9bed324a1c1b7d02bfb9596351ef178428d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
Message-Id: <175511133541.3709535.13181225643804638997.pr-tracker-bot@kernel.org>
Date: Wed, 13 Aug 2025 18:55:35 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Yuezhang Mo <Yuezhang.Mo@sony.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Junli Liu <liujunli@lixiang.com>, Chao Yu <chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 14 Aug 2025 02:06:58 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.17-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfc0f6373094dd88e1eaf76c44f2ff01b65db851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

