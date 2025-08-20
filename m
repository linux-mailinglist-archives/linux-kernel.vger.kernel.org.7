Return-Path: <linux-kernel+bounces-778670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C95FB2E8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F2FA2279D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3652DF3CC;
	Wed, 20 Aug 2025 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBpP3sYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956D2DE70D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732701; cv=none; b=BSoqvw4eK485eptPIHZHEL0tApLZOHma2ZYQSV5gEXK72smAGbT9Xz+WnDDd0A+AYoobbaRGexG8sCCyRBJMCHjE62D+0jxXdPH1JXUQQjoHHsI2/PkoxV1t+IwZ1HePLPvWF2ZSErdZOxe9Eq04S7TB7AKgERSAFq7+oPbhBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732701; c=relaxed/simple;
	bh=P6MX5K6eWZ+SNe3ZdbVdxwjmztbwPA8uRk7OZiOLNzs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OCX8k0WtS6K1gzHOHkdQ2zicll0ar8a7b/0hovPn6xuG1K9iUR7hMtXbWKlTSrh4QiDKlQa4fWFzFh7jzhCkjyiqdzb0VN1KN1MRpssW8s6pbahL5L4773XvFztq7fZzx+ZxZvQyv8gRspm1/l2Jt6nqXCRk4h5WPuYD+kIJXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBpP3sYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852CFC4CEE7;
	Wed, 20 Aug 2025 23:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732701;
	bh=P6MX5K6eWZ+SNe3ZdbVdxwjmztbwPA8uRk7OZiOLNzs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DBpP3sYJ+iP++810QUFwMf8U0PtJrqXLDIBfyjAgQHNeNJ00nVgcELDIfcAHcl/xS
	 szoLHPs6Da5baUCA5v5piNu2mXlrsA89N2PTn+J3VvXYTwEmTgenupAvcbm0ZfQ9XS
	 eohdrcOsQQ8Siw+2nR8pZe5+l9UAOSCHua2thLhZmhwR3ozxX8TS53gPuTgB3d8ugB
	 XlKQHpkK55JAGZGWZkfaEQxWzhlDelPtU3AEris4TzB/uQ1iHj8RN7YM0qe2zvAhj8
	 rIb5jiKZ6Ej08jzg4lB1AsasIFzk3EXXChl3ElQlrfOpeG2sM0n67HgS+T7OQ0DLtC
	 p1fBDoHUBqtFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F98383BF4E;
	Wed, 20 Aug 2025 23:31:52 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250821082026.9fbbfeaf2952437514b29dc8@kernel.org>
References: <20250821082026.9fbbfeaf2952437514b29dc8@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250821082026.9fbbfeaf2952437514b29dc8@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.17-rc2
X-PR-Tracked-Commit-Id: 729dc340a4ed1267774fc8518284e976e2210bdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43f981b7a72bd39358b876f801ffee463536dea5
Message-Id: <175573271091.413930.2378941071825154393.pr-tracker-bot@kernel.org>
Date: Wed, 20 Aug 2025 23:31:50 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <benh@debian.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 08:20:26 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-fixes-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43f981b7a72bd39358b876f801ffee463536dea5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

