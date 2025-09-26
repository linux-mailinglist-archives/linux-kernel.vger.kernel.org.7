Return-Path: <linux-kernel+bounces-834625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1ABA51FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203233AA93D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5FA30E840;
	Fri, 26 Sep 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8lytGrD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607830CDBA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919474; cv=none; b=bhli3UhnQSrS03q9e9T5KjIqEyqYZNiA5iDTUCUDkDVI55ZJv049wcSSNnKf9DesCJzh4ZZ1hPvV08r+/qdL0vLtVAIROq7g8N6iLNRsZlCNfRjmLPAjv6Hr7abHCyCNA+vmIC3QpGvsg9JEUupCqv1oR3v+Kvyfz7CFJlqi9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919474; c=relaxed/simple;
	bh=IcXL48m+exi/PCJGLOpVf+dFrDtBUzc8u09Kxoasm3E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gdc6t9GnFOsf3qlDJzZE2trWH7zol3a6Zff7Gid91mpjvotcSjSqqEdiOYVaCsZSHZJ6nviarQMrPfgWm78YUpEudVz6UXy3E7BqlY64Yikl7TiEEMbVQiHJNeDQdV6CwdcQLNSKbbHPMzfSXC/qETea26ib/KhIN+q0Nylyo70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8lytGrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726B7C4CEF4;
	Fri, 26 Sep 2025 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919474;
	bh=IcXL48m+exi/PCJGLOpVf+dFrDtBUzc8u09Kxoasm3E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=b8lytGrD4FvefvxaRCI9NpVbmYhQKDRGOnYRQUWW+puWUgglskGdOqnZUHpI+RSWP
	 Y93/QwyFT3qwjQOSlMUz/CMhN3wG5M8V1pgs3QV6AhYlU+0QAVKVwJztfqSKLpNREo
	 BUEjVza3XdsvW4JRJuGMueh6FR3/8n3hClClhIyiQvO/QNt4F2RLu6d/In5HQPja0O
	 EVCDlQLPegWJq4rIK2jgGUqYMKflk3aeDtXXhxAcOomQYREKe/ybPhDNpQz558hZkr
	 HdyqioUCA+xLV2S1zTX49GqMN8lUTrwI+1hDRWMNM9R5dm7otjBKWBYhvzWZuD7KQw
	 FEzwjWx2R+qig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4639D0C3F;
	Fri, 26 Sep 2025 20:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] core/urgent fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNaXicdHkJpTu6-P@gmail.com>
References: <aNaXicdHkJpTu6-P@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNaXicdHkJpTu6-P@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-09-26
X-PR-Tracked-Commit-Id: e2ffa15b9baa447e444d654ffd47123ba6443ae4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b07f74c23a0890977a5ae3c0b2c105d7ac3b584
Message-Id: <175891946953.51956.15378549620311347015.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:29 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 15:39:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b07f74c23a0890977a5ae3c0b2c105d7ac3b584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

