Return-Path: <linux-kernel+bounces-783071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3306B3290F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455683B2DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B541ADC7E;
	Sat, 23 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/vfda1r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077D54652
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755958795; cv=none; b=ZMgusS2QsGJGYjNH/cZnLWfLkeLEA789BYx2+f0Pi+38KdUFAYqwrboUyVc5uD3oDbTwTQoxhR/9t8E1+5VED8T7/0w4JI5e5DZrK/w1Xn2ud6HSp2ZFVtbwFoWlmQ5Oatznk71Q5Zn74MlB2p5+pyxeHdig4Gs/Ul3gBSUHEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755958795; c=relaxed/simple;
	bh=EAQF/n47irEN2pu2O5GAD5GyfMbrkdKsdWrTOxChBhg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Pifqls0T7kMx2C4UW1nhImMLWYBUCeArirJqeHfEH8QpEAg+Gy7UzoGFAV5NhUx9EC3oAT98na+TC9ZVqgjstzUv2WVnC0ZUP2thtNO+SgxdAVuKQ1rymBdfonM9pmNIBTjR5AOM/4ezY3wGq1Afd8yXC56OIOuQQPEebma4I7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/vfda1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817D4C4CEE7;
	Sat, 23 Aug 2025 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755958795;
	bh=EAQF/n47irEN2pu2O5GAD5GyfMbrkdKsdWrTOxChBhg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s/vfda1reQ4A0ljaOwu6VkDLL+Bxm5JLC3kAZTDstjzhqeUL0enDauJUKoH3EJKRf
	 +LtEcs3Hx5vuLNZkgL5HC/U+Ff9ZaeMcRSUTbKAnVJNnE5J5eIgq5uFcIOvT5ZGSOt
	 dqNYKi6J7xCixcKZVAxvxLRmPq0DML/HZnY36WPWrnmhcORUhPZCKc0zoLOBQIUgnn
	 6glj1g/cHKmYwg3sQ0vMs2mBHjOFT2+HTdsKuQspPn46t9MYieHqleq+m/P5cBWkMq
	 fmu2NEW7aVxMwRD01l7ZOiXgjmtbzR6fRF32rkaJsXAx5bnG2uDvnUu5vkR0c2G6eE
	 bNslmZnaNgxeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 48AD7383BF69;
	Sat, 23 Aug 2025 14:20:05 +0000 (UTC)
Subject: Re: [GIT PULL v2] tracing: Fixes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250823092444.3c0c207c@batman.local.home>
References: <20250823092444.3c0c207c@batman.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250823092444.3c0c207c@batman.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc2-2
X-PR-Tracked-Commit-Id: bfb336cf97df7b37b2b2edec0f69773e06d11955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1d8f9ccb24ecd969fb1062886b20200acc60009
Message-Id: <175595880502.2183026.543933165699922932.pr-tracker-bot@kernel.org>
Date: Sat, 23 Aug 2025 14:20:05 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Liao Yuanhong <liaoyuanhong@vivo.com>, Pu Lehui <pulehui@huawei.com>, Tao Chen <chen.dylane@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, Ye Weihua <yeweihua4@huawei.com>, Nathan Chancellor <nathan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Aug 2025 09:24:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.17-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1d8f9ccb24ecd969fb1062886b20200acc60009

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

