Return-Path: <linux-kernel+bounces-836910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A2BAAD96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D823B7A1260
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F11E3DCF;
	Tue, 30 Sep 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNnn6e3P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C01E0DFE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194804; cv=none; b=JPx0sM64HIJLGju5y6Zus9tGpK+z82y/wJl0QsKZ7g9BMLeudGjHavboWXeO8ivhHI6Y6WcPeh+rIKIjJ05EZrm2HcEn0KUrynmBpHyFszVucGgwFGOnJUGdOYiR0S7jwEfcBt/vyIdLqiKGDcsnbvMbXa3rPuXdjKP+pB+ph1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194804; c=relaxed/simple;
	bh=+7CO6vDv29/Tp+gwuJmodSsD3o2r/SOiGTj+Tka1bi8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gzfBwBWrHZxh2jRCG9ozPJrv9ZAukrNGF8cxJhnmrW3cFvVzo+CFjGpdab2b6I1dlW027XYJ/Ei1rVqM87wbR5j2oXOuzMINI6PfXaBBzvS8N9sBd62qxwBL0TxhEsL87mwl+6zwhrcUuKnKE4WkfnQdUrn6x9Bk2yGQk1C3sKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNnn6e3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C16C4CEF4;
	Tue, 30 Sep 2025 01:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759194804;
	bh=+7CO6vDv29/Tp+gwuJmodSsD3o2r/SOiGTj+Tka1bi8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KNnn6e3P3bnVfYdrpXxzQv9NQxE0pr2GFWvkc9/SaBxlk7n5S4XfKKCnmZZLj5Wyr
	 HK3mRVzH+MKjqx4tHJ/L/HfxIT5KMpaCQ1IeQoE4fk5BlQiiy4ie1iPcBtw1P9Ybie
	 db0FpHBNhT6Q4hKZS4PSanBQLyjG7O3UNCpsO3jS+pTAxPJ2OoQTbohxHTg/9kPDlz
	 q6GxIweoK6aGrrrE2oRfH365dS6yDc6qElBB01HSSQz2Tm1JWQTFxOgATY9LoDlZCN
	 dMWspfUkhq83vgROKbLktjCYLjQHIDWK32oWR4zL91g4wylQd4q2ZOlZaU3d/wJyuc
	 GclSGrdPk0BOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6F39D0C1A;
	Tue, 30 Sep 2025 01:13:18 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202509291210.9BBE978@keescook>
References: <202509291210.9BBE978@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202509291210.9BBE978@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.18-rc1
X-PR-Tracked-Commit-Id: d679c2e1e8d96f71f85e2ef3877407d264212cc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e129e479f2e444eaccd822717d418119d39d3d5c
Message-Id: <175919479714.1773917.13213004377653722727.pr-tracker-bot@kernel.org>
Date: Tue, 30 Sep 2025 01:13:17 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Eugen Hristev <eugen.hristev@linaro.org>, Kees Cook <kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:10:24 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e129e479f2e444eaccd822717d418119d39d3d5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

