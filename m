Return-Path: <linux-kernel+bounces-840877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06233BB5A36
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C04A1261
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EA29D270;
	Thu,  2 Oct 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr1iDt8N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5732C11E9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449093; cv=none; b=VeCn4yiGMXcFJpcl9zL2sjfVskoKFqTp7oIvjM67vtmsFQZk6/rNXEfUKDy1bwfFbx4bXgkarIdBnAI4DS30SqQcsjCJBAIFxv8XIiS0/igwNh9b6fOO767bBjdxel68TS4GKutD+TN5K9pLt7enllE8HyaF0Tx8ikDYAQ+XBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449093; c=relaxed/simple;
	bh=PV4pc4zNAcoB0ElMSzAin8+W0hA4jIwDrxV+2XGbDng=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EOpcrhtUwAPQhMdKs4XCwduDB6KThJz9qpbO/DcZWkUBNunRJ1lsDwQaHuoq6VGDrJxwLg4SZP7xHQzV6HOx8aSk1scUP1uXYhD4FSdz/g5+6XR2pYeXYux5NxUqn7wen+izMyWeoyUPS/CyfILteOVNdOLMoE5NwPmYDEkAxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr1iDt8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A78AC4CEF4;
	Thu,  2 Oct 2025 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759449093;
	bh=PV4pc4zNAcoB0ElMSzAin8+W0hA4jIwDrxV+2XGbDng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pr1iDt8NloCfAuM2YDMSDtYEtDN44OUw6iJuKpvmxhh44mgBWRzY6Us/7asFpIMdZ
	 ZFesPh//U5x51Boel+ohUzm+ovGaa6dyKng3t10Opn//epTIaPzB+S9YHb6oPHPN1O
	 m7hzNxrlvYy5Ay1mp7sKm4Q8wGsl96RZLQ2gi/RhlsiXGoXz9PZMU83E1KMuM9Oz5d
	 zbFAX1C1rdBLugg5ZtTA9HMEh/HpveZJswYoLKBr93mIFli52H86C0ERgGKrXwLFEJ
	 vzvy+jb72HBODWHZaxSZ4pqe7EyykoyuWfnAA0YOY0D8zz7K17VPJRldf0biqVbWNx
	 nvopX30KagZag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3414F39D0C1A;
	Thu,  2 Oct 2025 23:51:26 +0000 (UTC)
Subject: Re: [GIT PULL] slab updates for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <5dc1b53d-29fb-42f6-9fff-d6b42da17a7f@suse.cz>
References: <5dc1b53d-29fb-42f6-9fff-d6b42da17a7f@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <5dc1b53d-29fb-42f6-9fff-d6b42da17a7f@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18
X-PR-Tracked-Commit-Id: ca74b8cadaad4b179f77f1f4dc3d288be9a580f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24d9e8b3c9c8a6f72c8b4c196a703e144928d919
Message-Id: <175944908504.3515818.10469899338669816557.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 23:51:25 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, Alexei Starovoitov <ast@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 30 Sep 2025 08:29:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24d9e8b3c9c8a6f72c8b4c196a703e144928d919

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

