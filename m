Return-Path: <linux-kernel+bounces-750145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CAFB157E0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0106162E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEEA1B0413;
	Wed, 30 Jul 2025 03:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNdEovXj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C517AE11
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846746; cv=none; b=Ubn6+fNR2iVeduhEINNxPsjIWPllPF/75Wb1Nyw/+H+MggqdtiiUXoisWHAwBzyDB3+YxVuvy28XrrWoOqINhEefqpI0U4WIOw/s24+ZkUN+N1qtlK65ulr/mlE4AVcHVfL9vk+hLW5d0vkK7I5sa7KZUXiI7D3hEF0RDhRBEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846746; c=relaxed/simple;
	bh=wQKKUpA2/sjAPD4tKuYgbwFWtnRL2nW9PjAZAjBNGQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GE3g5gQFIJ5VZjMYG3zVXYxGH3J4/tc6TC0bC1jrcku8gxZb1+Dv+pImDyW++GUwyqS92FVKFOuu6it2FCfCNJMm0GRISknCqJE0AGPOh3y4Pp5LAV8tvNjU0/mM89X0ADqeW128D9mKxvLG6FF1edDrf8eP51DI/qMkbeaVrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNdEovXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5E7C4CEEB;
	Wed, 30 Jul 2025 03:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753846746;
	bh=wQKKUpA2/sjAPD4tKuYgbwFWtnRL2nW9PjAZAjBNGQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oNdEovXjlvZMUU7QRzebNqnL5nl+E+HSoJZpFpEgZKuK8Y8HK5X9vm44MydgL9Ze2
	 pB6gSbqoai9trStRsGgSI3WA4l9TmeCkDLPO+JLlA9jfVi4g4UG/2vQkxQtq67AxlT
	 tFd8XCI03jDU8EpAyZMEPAedO3h2WPKTdregIVtNI1fu4Y1RpRZGTNXm0j0phabt/l
	 MPoXzWpEmRraFHpVxsJjN2teRN7ZWgfrVbMaF82lDWkwjMwkLpAozrzUt3AjWnVInt
	 RGnXW1YznSfZ7RN3tYJiuqyMKEjw/xKbq3YXnuozY+ewnPcepdZtZRvs/GXjX3fo4b
	 ZWkFXh7U8DFzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC8B2383BF5F;
	Wed, 30 Jul 2025 03:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.17-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <dc911086-ea2d-477f-8f07-7df19e37e61d@linux.ibm.com>
References: <dc911086-ea2d-477f-8f07-7df19e37e61d@linux.ibm.com>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <dc911086-ea2d-477f-8f07-7df19e37e61d@linux.ibm.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-1
X-PR-Tracked-Commit-Id: da30705c4621fc82d68483f114f5a395a5f472d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f5c9952b33cb4e8d25c70ef29f7a45cd26b6a9b
Message-Id: <175384676244.1749338.15980677472630181285.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 03:39:22 +0000
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com, ankitchauhan2065@gmail.com, christophe.leroy@csgroup.eu, donettom@linux.ibm.com, fourier.thomas@gmail.com, gautam@linux.ibm.com, haren@linux.ibm.com, johan.korsnes@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org, segher@kernel.crashing.org, sshegde@linux.ibm.com, ssrish@linux.ibm.com, thomas.weissschuh@linutronix.de, thuth@redhat.com, vineethr@linux.ibm.com, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 08:18:45 +0530:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f5c9952b33cb4e8d25c70ef29f7a45cd26b6a9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

