Return-Path: <linux-kernel+bounces-751449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F3B169B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F341AA51BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171442745E;
	Thu, 31 Jul 2025 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8w00Wcb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59DE1ACED5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922110; cv=none; b=N6l0jPlgyA5TSboV+ZdSuGpv9twAvS+lxPJ1jjVqbtFcRuzAox5lX8fgXLpSIjQp1zOG0ttp53KD+5HXaBEzWPz6gKbT/hJX/JlFjfswNM7pDzDX4hwIdS2V4RKxuVIWHqJfmuBgK9iDgFLFMqQ6RSbIPQdCynDm09hkNkwXW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922110; c=relaxed/simple;
	bh=ksHeZjM1V22U+j/4PIMmEWwN1Ds/Ae+a32qSKI4Tdz0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fk/LOfdFv4mRE7U4mL2kLbpn7FYdXczClvmMgBRqKzRRknQMRKCfZjmMzKeMHBHF12WylTxtckVEVZePqfBG0U63pYOzbIjVYTimgebktcevd8XO5Ctm+DcZo7QYZzcIShQr7n2wPhs5u+oo0N5LSXinIAy084Lf8bGvuLqBKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8w00Wcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88504C4CEF5;
	Thu, 31 Jul 2025 00:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922110;
	bh=ksHeZjM1V22U+j/4PIMmEWwN1Ds/Ae+a32qSKI4Tdz0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=B8w00WcbiVOZiD+p5geTcFgxGUUmCoGePYalsuygS2i/SuGJTua/khxuQd75darBu
	 eCr3jn6hHexQ/deiDCPUr0L1wFjflKznqTxSufMkapYls2YmxobSU/Esp9QjrDXgoH
	 +9+N7KdZ27u9pqPgPn/vV2wT7QyFPyIfQ6r0yfnLMGG/oVkf/jemj2DksovRubgfb/
	 /40ti8S9lu2RTNYQYC9E8QinPAQ3oyg6Ym1ZjGEaIF/jUwdBkGXKY2URmcVqCP3A+2
	 V72BHQvpQS6TOy04jT1+VXuTsloThM9AmfIILjjEP7+87TceBuVlYW6Y2w/J/ZljNx
	 sJrpzINjPWcdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD10383BF5F;
	Thu, 31 Jul 2025 00:35:27 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250730174946.6c21cafc03bd295c58cc149f@kernel.org>
References: <20250730174946.6c21cafc03bd295c58cc149f@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250730174946.6c21cafc03bd295c58cc149f@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.17
X-PR-Tracked-Commit-Id: 133c302a0c60bca1f0a2f5f85ef11e7f5e8f1331
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7dbc2e813e00d61e66fc0267599441493774b93
Message-Id: <175392212615.2556608.14129453201969732677.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:26 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peng Jiang <jiang.peng9@zte.com.cn>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 17:49:46 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7dbc2e813e00d61e66fc0267599441493774b93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

