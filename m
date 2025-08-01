Return-Path: <linux-kernel+bounces-753710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05858B186C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39316A8750C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5635128D836;
	Fri,  1 Aug 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ON0WxHSS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD728CF7A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069706; cv=none; b=LRuR4BS68+JSDGPyaSUN+o8hHtTv+b0UMoaGelNmrnWNSBJoGBC06wNKNBt8Hg30q8uAhpE5WB/FnM3rmNyOW+DbrWavBpVrZmRVzMhBWDz1j0tb1cSy7XSXkNZ/A63YpxyX65UeBKh+rEGhPoutcCKlBQesY+R0pE3eUBgsqRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069706; c=relaxed/simple;
	bh=/wN00AWKTD048RPq8uXKD1E8C75tYl0CBOBQZvM5SuQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k5zy/3Sapi0OapmwE+n70fKI9esivHV7I9KFG/WfLwhyDteuJ6Lryfr9tO0Av3uQ6UZQX8MwEXFhQj7Pnb9nWU0Ahks0Zxw4Jmjo42I6bNtDM8bJGszojH/Z7uGDxf3I1cD6h0dda0jC1GuA5LB82+5A6Puu627HTBO2l8bYUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ON0WxHSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B368C4CEE7;
	Fri,  1 Aug 2025 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754069706;
	bh=/wN00AWKTD048RPq8uXKD1E8C75tYl0CBOBQZvM5SuQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ON0WxHSSirj36eESQefc6mXftYAwuwJ0Vj9Vep/R3ra141or7SE3cNW59tJMGBS9a
	 9g4JfVekYxgLCwkBHWEv73+/3fAkBvZsHCRNA/kvIf2f5KUM+lgpm68GjBedBcbV22
	 tQMo3cpJD4zU9LzUdcWZ1rruK/8k3qeIYy9zz2T5HuYDrpsCXTmVk/FMdOBifL0tYY
	 WYSV6vq7YfnzxWw7OJ8TxUkYa+k8c6+irEFauRpJHJ/xlsK6fc7q+lbwKN+pX0ieW5
	 DT6R56CxdX/Mdtfg1YI7hJXTA6/wtS/AStA6c7jBl+hE8mkc1WGXIcUhotrXfb6gvp
	 GZ1qVEl9Z4+QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38005383BF63;
	Fri,  1 Aug 2025 17:35:23 +0000 (UTC)
Subject: Re: [GIT PULL] tracing tools: Updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250731104542.0878d70f@gandalf.local.home>
References: <20250731104542.0878d70f@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250731104542.0878d70f@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.17
X-PR-Tracked-Commit-Id: a80db1f85774ae571b94077f65c5cd57467641d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5172a777248e56dbae22b55231d24c7ecc6393f9
Message-Id: <175406972187.4015829.6136997043819349823.pr-tracker-bot@kernel.org>
Date: Fri, 01 Aug 2025 17:35:21 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Clark Williams <williams@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 31 Jul 2025 10:45:42 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-tools-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5172a777248e56dbae22b55231d24c7ecc6393f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

