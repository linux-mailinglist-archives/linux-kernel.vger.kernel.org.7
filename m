Return-Path: <linux-kernel+bounces-748753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2EB145AB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618EE5432B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908D1DFD8B;
	Tue, 29 Jul 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwXwKhqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93151B2186
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753751530; cv=none; b=c7RuDu33Loj4vT9ch6nNZyWBNi1D4UuN1fwH5lBJWX3E+aD/WYsLwnNBBkxEiGsYazzQygzYHQFZVzFfGMH5IjVn3VDlGOo8jxCVDrnO0L0p34QvZYlQxnt4YNPSvpi0O7g7cXkvnd2wT4llUgtSk4AVwIN1hNMNRN+ndHa5LLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753751530; c=relaxed/simple;
	bh=1nXeQSSRTFhN+0hZAdEDkSBzNvSk30tZU55D5tyeEt0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EAnZ37YiSq+SujFSckpDJ96DP16WdqbsDHbmJxDx36APzD66ftolF6kFM1K+vlAUX+LPLSG/6h00eKZxHLCqo2LCUNXTZwcJmcLTBgFwHSiC4hVToJLi9hbl97omOsJm5sWgwrSPGIZ9deUXfTvAaY11LQ5aJtYJuB1fx/b1xC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwXwKhqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398F7C4CEEF;
	Tue, 29 Jul 2025 01:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753751530;
	bh=1nXeQSSRTFhN+0hZAdEDkSBzNvSk30tZU55D5tyeEt0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cwXwKhqpN0CYQp1Iw5E7AeeuEmCdOSsHeETCVoHUfh9nniLe5njyqsWePetR+Zds7
	 ZDs3qHfc6k+BDQMXTgjxGpiNAkoPGq2t8etKh2hlHuLoCdoUHDp/sHmDsUOL6F4kDE
	 3hoYC7MqjM9CnXhDf/iEM1qtePRc3YU9VtEO3vZASvb90RuqOjxKbSUCDtoHQOSuna
	 t8jtJBDM3Z9YZFN/e5fhnQMMuQqev8H9yK8aAqq2KmRnmftFUeg5GiTvKY4hpzjC7Q
	 DnlkhyydGyJyYrMkFhCjz9o9hl5AmlV7tLttfeJuff5/vkSvC79l13069tBOfeEsAk
	 MC+5V3HOQ6QmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE96383BF5F;
	Tue, 29 Jul 2025 01:12:27 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202507281251.8989493D@keescook>
References: <202507281251.8989493D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202507281251.8989493D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1
X-PR-Tracked-Commit-Id: 32e42ab9fc88a884435c27527a433f61c4d2b61b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e736a2eeaf261213b4557778e015699da1e1c8c
Message-Id: <175375154648.918485.15593899954916969515.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 01:12:26 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, David Gow <davidgow@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@loongson.cn>, Ingo Molnar <mingo@kernel.org>, Jannik =?iso-8859-1?Q?Gl=FCckert?= <jannik.glueckert@gmail.com>, Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>, Lee Jones <lee@kernel.org>, Linux Kernel Functional Testing <lkft@linaro.org>, Marco Elver <elver@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <n.schier@avm.de>, Nishanth Menon <nm@ti.com>, Ritesh Harjani <ritesh.list@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, Youling Tang <tangyouling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:01:33 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e736a2eeaf261213b4557778e015699da1e1c8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

