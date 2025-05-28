Return-Path: <linux-kernel+bounces-664805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0439AC609D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 06:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C7B16BB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 04:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EF1EA7C4;
	Wed, 28 May 2025 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnwklXt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E2B35942;
	Wed, 28 May 2025 04:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405892; cv=none; b=hXJobMTXdQaD2DiUWPoJs6KSDk6kxVYdKJJftdEm7uSUetdEpZ08JTkfRn/lMu+HEsajj8pFZnG8UzHzLNeHogU7HaFajvUrGaCLpaLV7I+agFZwxutRfWHNfn7Y015gIHToeE0fxo/Szb3GCKUFelCR6DpiJuMBfkF79r++Vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405892; c=relaxed/simple;
	bh=3oqDe+nZl49bWs1AAjbXlZTd7P0+aP5nhvYs2YK/iJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=upcmQ4yXz+1hpMuyZd7akOLGGfYRW2eI6Hw60RvcTUjRmWxrDflJSAvT4UL6JmBmrgE6Mt7zA0QRWivtYrsa6we00k2+OfbZGYoTwKdSj3GsTlrDJ4/6TnIllm/9VLQbrqbROqbgPdsUmD3sAmnbr3DFNWIbaDaaUcx36y0DBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnwklXt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEBEC4CEE7;
	Wed, 28 May 2025 04:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748405892;
	bh=3oqDe+nZl49bWs1AAjbXlZTd7P0+aP5nhvYs2YK/iJE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UnwklXt7PMZ0XckhLtY5qmdtf7jiHRKWoiseYm0QP5ECwl7f85DXpVYYQrQleZ4/f
	 6JLpbgrYh3aDRvF500oilESuPa0QpQPzW5KOzTUwCZdEeydQ44XNxTRoG0+83NbsZo
	 7Lb58Ua0zr8c0i+FakWfuyObkoBpZ+R/iPHzXQWbCeKOgb0QENzWVl/uvW8AwIr6wj
	 5ZjUxaS2cXtcp1oGAOS0DcfxFQj13h7HFxEi6tCPQ/yP3bOvgAVlB41L+QzqXu4dF+
	 S5NBzvv31vJzOXd1OnfnmLDKAA2F71CstYFF3CSPznelmLR7u8M8wR2Ne9EWyZ8Usz
	 4TAYDRmPRR3Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECB143822D1A;
	Wed, 28 May 2025 04:18:47 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <itvalur2ynrnjc3grs5nk36fbfm52atybcad2nmxidaavkeqap@nlxzuqvygpta>
References: <itvalur2ynrnjc3grs5nk36fbfm52atybcad2nmxidaavkeqap@nlxzuqvygpta>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <itvalur2ynrnjc3grs5nk36fbfm52atybcad2nmxidaavkeqap@nlxzuqvygpta>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.16-rc1
X-PR-Tracked-Commit-Id: 23b8bacf154759ed922d25527dda434fbf57436a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1975e4765e5df2b91d400d4ac25c9243a25e92a
Message-Id: <174840592662.1893196.11610385891138675926.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 04:18:46 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 26 May 2025 08:35:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1975e4765e5df2b91d400d4ac25c9243a25e92a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

