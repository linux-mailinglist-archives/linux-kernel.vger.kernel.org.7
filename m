Return-Path: <linux-kernel+bounces-793511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97EB3D47B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47364165DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C827145C;
	Sun, 31 Aug 2025 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncrjzcn4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F2270EDF
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756659071; cv=none; b=IpARkqyJGyISeXTQNVBtF94pTeuyBJ5EWudE6yNmVnTBAc8XlNJ71TTj3yR/YDP7CL1nP0cf6t+0yyYaqggTnMzn80jWmMshVQtNy3oQEqVU97/kinjFbWNe/jMOf+t5rdxG/xaPtAKLYL861kRF0fnj1w/E/AMWR5mcB77rOFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756659071; c=relaxed/simple;
	bh=VrgrY8ZF9IuBfMEAhjS6KO4j8D/+zwQaGVMIKzNRsbo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=db2tbAI/Jy4fPVdtFkBWnf5PKU09DMlRwY5Iajy4MnSOusubQ0eXGNZ78TRzbtkT+fwMgDUrpS5py3+MZFneif+iXM7tUZ/qDJ1ePHd/WYBzF70+0+aglQ+6WCEm6MHFbM2KsZ2yYWK/+FX1kydbUF0S6XuPxZlmOjryxmtFtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncrjzcn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC7DC4CEF6;
	Sun, 31 Aug 2025 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756659070;
	bh=VrgrY8ZF9IuBfMEAhjS6KO4j8D/+zwQaGVMIKzNRsbo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ncrjzcn45z1OLOzSOTtuwqCBcNwL0XniWhXxLG31ibNviqXVd4Nzr07NFu2nqK5jj
	 ZXdQa3AlVyA3Mh3J30oavuRQ5HK1ag3Y7xABP/HMwUqCbEPp4v2PWsygMLwclrv2M4
	 2TJwyRZ5O52/WOlpAKFp5BKOknH4JakP8vq08fIUxHu33TphBIaPgtGfqc1Ej2xZo3
	 0C3Vujc7OCZmnX5puxfBhuP0EtLQJK76Gc7akTKyQYtTxEcSh22T+Kw6tMB5uzI7t4
	 KTCx/LMOW6DDgqcyKnhqbSLpqgT5SrBLT15CozH6hkmwbZr+XxLCRqzoDqaEkgm4J/
	 43gEpL8xPqoTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD13383BF4E;
	Sun, 31 Aug 2025 16:51:17 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <202508301913.69AE63B6D@keescook>
References: <202508301913.69AE63B6D@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202508301913.69AE63B6D@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc4
X-PR-Tracked-Commit-Id: 86a9b1250602d877a393dcbab5f42472f77ac0f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9acd5b8bebea619d414cc6cccc7d13a4e6f02ec2
Message-Id: <175665907658.2726201.3708641544021342867.pr-tracker-bot@kernel.org>
Date: Sun, 31 Aug 2025 16:51:16 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Junhui Pei <paradoxskin233@gmail.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Aug 2025 19:13:40 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9acd5b8bebea619d414cc6cccc7d13a4e6f02ec2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

