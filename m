Return-Path: <linux-kernel+bounces-751221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E977B1668B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE43C16378A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400662E3B10;
	Wed, 30 Jul 2025 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spcRqDQs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9C2E3B14
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901275; cv=none; b=ouP6jFbL7+XB5xcLUrl9AjjlRveR6FvNGFcX9nHK/KFNE9nzRjqHIuE5HGW6Tbs42Mj9KtDlp2IMmdAXYGsicQdQv+xFNpA9CkgOMvKPEZZGcRncbC5KWmVHNP2ZUlwCSYejmH0bw87BJ7vyJmBSjXgZzwZgzb1MQKMhw/5EE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901275; c=relaxed/simple;
	bh=jJvBF/EKdAB2GfxaXeDOikuFXOv9X3Hw00FXBhGGl2A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=E7GND+u91CBvpR67SpiMhKf0l7OYTgEAh4id0uT9OMh2KNA0BCTNOjvkdcHWnzcPTqqaiWU/UXhRiXwETqCL3m+czc1+pe+asXmEuWH3VzdD/3j+C5Kl681/bSEJq3HN4/Wq/VSXTv/P/vlxPzHiVxMRimx5uY9E5o41rmiyN5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spcRqDQs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7350FC4CEEB;
	Wed, 30 Jul 2025 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753901275;
	bh=jJvBF/EKdAB2GfxaXeDOikuFXOv9X3Hw00FXBhGGl2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=spcRqDQsdtQtMPTZmUzH6Fh6CjnPfywN06BCYIoq5ZN42fRGRd0EGVyq1PlWTxTtc
	 1W1trEsTErGmZgHEmc6BF+g0DcyoZeBmzgthI4PfAHURm/iyXKq6l07DRtlAwLmtjK
	 POSoOj/5n1xzUb+APCD8QAxokquSZd4A2HjuEXDmBbsBfe3NATbsGB0yO6PoZDZA1Z
	 QrQOxCpuB3G1EJgN78aQiTarEQ1W00TPBit39y8XJVYvlaK+mUVd/zXc+q5cjkkc1I
	 bI4GJ0mcCY04/JY4TUl2f9nMxb00E7gH6iLbyeauxBclBObU99TdKuSJW2QkU70UCx
	 SmyIzw/4CYikQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB14383BF5F;
	Wed, 30 Jul 2025 18:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aId-o3ijDLf38vtc@elver.google.com>
References: <aId-o3ijDLf38vtc@elver.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aId-o3ijDLf38vtc@elver.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250728-v6.17-rc1
X-PR-Tracked-Commit-Id: 9872916ad1a1a5e7d089e05166c85dbd65e5b0e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7dff275c663178e9a12a0c0038e4b3be2f3edcba
Message-Id: <175390129138.2433575.12004645258274497693.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:48:11 +0000
To: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 15:44:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250728-v6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7dff275c663178e9a12a0c0038e4b3be2f3edcba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

