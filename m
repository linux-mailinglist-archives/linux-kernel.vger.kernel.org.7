Return-Path: <linux-kernel+bounces-749962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04CB15568
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523F75610F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D8628980D;
	Tue, 29 Jul 2025 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJZRueK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77661224225
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829140; cv=none; b=HbtJb6y2/bfZhN9liTcTJwYlp4qiXNgqCIMjv5YWj4M0BgQzi0XN6VqClQCtVGRnFWmDmlxRenFXPV9TNgH8vnvCtBN7pfubIO1Idwq/XdiyBQ6m4UGPb28cKwUflBpZ7uMSL0uox31EQp9E0K75zA5CMycDXRUgUyZYQuQ4aWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829140; c=relaxed/simple;
	bh=kaAoOwnJl3j2dUK5ULq7DVa8wCAm0enoPE+hstM5ioc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kl5Y10XRAS1yftsxZ1kJ6r9Wz2W2VSrn1uJu0OtdbfvpGu1XOAIRD5rySKIIMFODN6R9a89hWBtzhmvAnMWq1n/tYfDTT50uQCqLiDI3LFKuQ7oxFriitqF0HUHhkEgfmhH64IyC2V5onXNTy5Cm5sbpTi4LFmxl4mqpvczM1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJZRueK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9EFC4CEEF;
	Tue, 29 Jul 2025 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753829140;
	bh=kaAoOwnJl3j2dUK5ULq7DVa8wCAm0enoPE+hstM5ioc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CJZRueK1NsovOniidJizUEkqnJEBomgwz9e7iG2OaPgpDpN8QzVoFnhKj6xzZ6Ko1
	 ZiDRpKHMK7pKd+I4nvQXhxJg+ZTvl9S9VgQ7lTv7V1rN3XsnwEWLPTK9YrYfFzE0N7
	 3IKMGPhqAtrqC/8rg1O7i+iBi3cFOjkNB1wBCpsW8WOG+qvKN9IdRVGYSe5WSsvaGf
	 3JIvKNwu1O4Y7K5H/fPUdFHMl9TwvyBJ9S4w2OUv1hXt3HfAA9klVAKJn72uiV7vo5
	 HYnSICuIvnSzKD3BVEUiXswZTmFk+/pIdhObCVDrCpaq7oX6GpQvxl8vCCEJPC9Gwb
	 nVl6fTInPjJEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC80383BF5F;
	Tue, 29 Jul 2025 22:45:57 +0000 (UTC)
Subject: Re: [GIT pull] locking/futex for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <175377875605.620102.13731137828469256924.tglx@xen13.tec.linutronix.de>
References: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
 <175377875605.620102.13731137828469256924.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <175377875605.620102.13731137828469256924.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-07-29
X-PR-Tracked-Commit-Id: e40892214b454c8734350d82374f46c2e495a4d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f38b1f243ec3babea9d8d9c6240249589853aca2
Message-Id: <175382915630.1670422.8223642119669789146.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 22:45:56 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 10:46:06 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-2025-07-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f38b1f243ec3babea9d8d9c6240249589853aca2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

