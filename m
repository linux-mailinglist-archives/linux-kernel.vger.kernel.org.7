Return-Path: <linux-kernel+bounces-899376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62CC579B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8728242336B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B0352FA2;
	Thu, 13 Nov 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTEs9ZhB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DF352F9A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039123; cv=none; b=JN+XqbB4YzgwdbMsMTEsGpfjQY1sJzB85eygrnuNPhb4do8XZhbUUntVDzGpVBtSoT0em7G0y4OhO+/9+KVjMAyPUrJZk743+p26/vg60buW+rfh1AZJ2hohoWVGfxByxoIXK02kPlhjeuOf5ppgTXROVB3yWspC+/nNMvZZkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039123; c=relaxed/simple;
	bh=WSE8IWfi37i2v8p8N47uXB4pJyyoZ47u+xWx9rOeJMI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CG7glZtwE0pJUEXm7K+6U2uP40cRQyOfVUZ+Vi1VQBkHdWxCN4SzCydRMWZpW8zvc/uuU6VKXNEn8ZonFvdRHsymX7SaOiWpe5i/fEi7IeFWXVwVFnJGDFTpkp2khfhKkR42u3qx+GzpltTABDU60dYshc56N/FaIZa+Qd1Fijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTEs9ZhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EB2C4CEF8;
	Thu, 13 Nov 2025 13:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039123;
	bh=WSE8IWfi37i2v8p8N47uXB4pJyyoZ47u+xWx9rOeJMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oTEs9ZhB0hQeIN64TvWgMlob7Xrb60KxnVO4hkpGc31ikk+JmH9l3kewvv5WhYA8N
	 6xLax9WVyAWuE/NY18XJRPFwtJ4cHU6/M4NrAGTewUutIisOd4caqydg4CWYyyQ0T3
	 LQa07lZeBuClM364DW7t4ypewj7m0ytlgi0onenNIsKulj3HZtdow5AKatJ64g0R3m
	 KodM9rrn1ijbDynsTaPaJepficLUQtXNUy8cd3Xc4+bAnwWkvzsFUYDTJLPRl8giMN
	 PvPa19b7+jsqe25me2ivTwbDzSgnNgshh8Or9Blui5hubRExKLHe6GZfkCOJ/BJ4HB
	 oKkhKknyZXGgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC53A41034;
	Thu, 13 Nov 2025 13:04:53 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aRXHkO5ema3SJwzG@debian>
References: <aRXHkO5ema3SJwzG@debian>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aRXHkO5ema3SJwzG@debian>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes
X-PR-Tracked-Commit-Id: f2a12cc3b97f062186568a7b94ddb7aa2ef68140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ccec5944606ee1389abc7ee41986825c6ceb574
Message-Id: <176303909244.842124.11811051251466879893.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 13:04:52 +0000
To: Gao Xiang <xiang@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Robert Morris <rtm@csail.mit.edu>, Chao Yu <chao@kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 19:57:04 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.18-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ccec5944606ee1389abc7ee41986825c6ceb574

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

