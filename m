Return-Path: <linux-kernel+bounces-898508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1C2C556ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8988F3B1084
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A442F8BFF;
	Thu, 13 Nov 2025 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKFgZe7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6A29ACD7;
	Thu, 13 Nov 2025 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763000788; cv=none; b=BVdy5yAqX9UNJ/17B0H879K4ZsLZkDhaV9u2iAvy1DKvp1FVNjZ3o2NMF7zFxJ7y2JUWM/gKSEzVlrg0kKQeQ0rYS2zf3S3VKS6rwdpHnJM1WKSC6Z3SyfOJtvMfoq4r7UNKLAthfxhU2B9KYgC+YTr4JQcqjGbO7ILxKQWbKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763000788; c=relaxed/simple;
	bh=3Ar4ULpZxrWOf1Pnq0f5nV1W2hwaxk3K0K2B4Sgafc0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VFn2faLO96XrGTnVgX0EkFspaJeGJTbxaDiuwr5aJh0tTQqvhHuU2BC4PpGsAA683025YdyyhGx2ixnaJiy1+oYdqyPlYCpCtkMr1rky+GuqKVfkwhSSiak4vlyZ2XMeQW0o3UX9WnFyMVAqXmm9wtX9mtNqnYS3Wt0K39JqEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKFgZe7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A76C116B1;
	Thu, 13 Nov 2025 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763000788;
	bh=3Ar4ULpZxrWOf1Pnq0f5nV1W2hwaxk3K0K2B4Sgafc0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dKFgZe7Py+YUK718G5imwZ944v/HkzHomZPusoTgl57zSdzz+kiFHY5b+joZjCTdR
	 S1r+FetpCV3kC80Fnz1IgjW0Pg+O6nqCJW2nk699SzhxHJpkxvlXvJbF4uDdkzlrmr
	 16ubF8hGfflEQrQ0FjCb2kVW7dbH18h7PsOXTAUTkl6MoP5iEpcsbDu3Ho3DP7xjwM
	 w/YJAn4+T1CRTQpF9Ba6SBLTvHZizPM8B7qeMkvp79gq6NOsqIS6iSgoeeGeeXz9A3
	 PxZ6WsNWH+2guZvuQShyRB2n+uRhIzPZK2TEdLE4D7k8P2+kwDljPa11mEOHi0ab0J
	 ian+6lDK0Fkfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F2A3A40FD1;
	Thu, 13 Nov 2025 02:25:59 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251113001116.2758597-1-chenhuacai@loongson.cn>
References: <20251113001116.2758597-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <loongarch.lists.linux.dev>
X-PR-Tracked-Message-Id: <20251113001116.2758597-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-1
X-PR-Tracked-Commit-Id: 237e74bfa261fb0cf75bd08c9be0c5094018ee20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e927c520e1ba6b6a0b2022adf5ba455ee1553fc1
Message-Id: <176300075776.287829.7126649571537535862.pr-tracker-bot@kernel.org>
Date: Thu, 13 Nov 2025 02:25:57 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Nov 2025 08:11:16 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e927c520e1ba6b6a0b2022adf5ba455ee1553fc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

