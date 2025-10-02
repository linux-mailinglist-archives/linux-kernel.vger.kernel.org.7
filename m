Return-Path: <linux-kernel+bounces-839712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6BBB238C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 03:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9068C326EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A75524D1;
	Thu,  2 Oct 2025 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di5fmUP1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341570810;
	Thu,  2 Oct 2025 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759367432; cv=none; b=hIM1pkzLbVSQ66pPvMwarlosSCGl6hB2RTwGE3VBaZMsbAeKrU7sSJjoh0+rX7krYZt7SRr3Yl1yalEEygjSrPChDfj5EWqz7vRdAFhqBVwFTS1M1arwxzQgVIu5eSfk/JtQgnryp5owIeEw3d55SHRdSmybVrZD6MuobigN3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759367432; c=relaxed/simple;
	bh=PLfM420PxrY0mdehQk/ezUm7VWZZHTn8pnpL4XNbs5E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AbgdYnuYHOI/TDtbpDGhjGRcniyYM4xY8BAMw1L5SqIZPIOG4MbMev+c2j+uby2YSi4u82H7/ltLMYeSO39EoBQFWCGBgCFF3QviVh120pKpDwl8wCpZrwDTRwteFzCDK/6eXAoI1h5YQEpIpt0w3xORd5k3TN/EIrKtofGs6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di5fmUP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E9DC4CEF1;
	Thu,  2 Oct 2025 01:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759367432;
	bh=PLfM420PxrY0mdehQk/ezUm7VWZZHTn8pnpL4XNbs5E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Di5fmUP1JABJJ6rsid5r5g8foBFaj7eR9AZWOwYerm/LLyKKipcUzXB5R5deDtcbp
	 evahpPssdnr+CegaOLjwY0Dede0aTMjwRXpc+esASKZenaKOVgsBnfKo3UTwl6YOCy
	 928cAY84NLQ9DFPeZtx+7k+eGlD5+4IBjuL5iQ+gYfQGCl7f2g8CkMHUc/KfjcrDIo
	 sViVqvZPg9alV/p/R44wcWDTE4PTuoASz/Fuqgk7HnFqGGguTxw8Bfn2lY4p2Hlulv
	 GhyiDbHrh4e4x/IGG1JGFi35p0aa9DzREjM12lZRZyHsh0xFA/lpL1kicB6TmqXTQi
	 SuJ/6NbpWjjig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A6F7439EF947;
	Thu,  2 Oct 2025 01:10:25 +0000 (UTC)
Subject: Re: [GIT PULL 2/5] soc: dt changes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com> <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
X-PR-Tracked-List-Id: <soc.lists.linux.dev>
X-PR-Tracked-Message-Id: <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.18
X-PR-Tracked-Commit-Id: 8c0650e0cef283fb31aca5dc7c72b891ff121a88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f048c878ee32a4259dbf28e0ad8fd0b71ee0085
Message-Id: <175936742455.2689671.15689552155579066793.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 01:10:24 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, soc@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 02 Oct 2025 00:26:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f048c878ee32a4259dbf28e0ad8fd0b71ee0085

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

