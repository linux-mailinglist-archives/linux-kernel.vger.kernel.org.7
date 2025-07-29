Return-Path: <linux-kernel+bounces-748799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6642CB1461F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39761AA1D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD420E032;
	Tue, 29 Jul 2025 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMT+L/Kv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3C2080C4;
	Tue, 29 Jul 2025 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753755861; cv=none; b=V3YpZ8CdrothWTgDzdvzuZ2Gdy1KkVZI5daAImZmMjoIp5+XNEUWaqflWeis+pCce+VffA2F/GMx93qPFG7uUCph1J1xzDh9QGqLPrUdlYxwEgJYtR6K2Z6uTETkUb08MglljLJn/ZkyO2VFKc04Rjn/FZ6HcUqOFn7RR75dEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753755861; c=relaxed/simple;
	bh=UxIcKKZoXzc+XxOR3q0eKe5YGEWD2+jitj9uR4rsLVc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rNYvq/ocNiB8Ikqsmykm+WrIj/7V7u2jSIPbknnYoEbmNNJ7p1AblGdhFKgRLV2OGM3ZV5gyowZSi9RhvNqJRKDBkKa/QstMTkppPTF2bZKHS7ovOcIOBGVwnnPDtuvZdTrMGqR5ukO/FtkY9AAI/sk/qews8qSF0oYRgd1aXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMT+L/Kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF61CC4CEEF;
	Tue, 29 Jul 2025 02:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753755861;
	bh=UxIcKKZoXzc+XxOR3q0eKe5YGEWD2+jitj9uR4rsLVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=gMT+L/Kv1ksMmxm/xNg8J/cyhIF51nvA94X3pcmqvkYXP8mChZ/ahAkLGfAe+HbXc
	 xLtXK/W5nF/uEY60kujm1ROtNBeBN3Uyi5ghzeS3KRIwWKGvb0/e1+r0XeVRdF/+n7
	 l5D12I8v/q8GsAF5ADdBFkdp2zzWRHe3fcgyju3zU/Qr7zbF5GL24i1rpHyKOEUctM
	 /SUjlOSyvdXyCyoDSDjx/Zo8yN0Jpgi9wlLMuEW9v9HjJ8fxb6FiJ2D0csCGAYj7Fw
	 dnQtNYGANAzVRBib9j9cjU+XX91LB9Ua43UVJ+K3dXE/WnHsK9QqQV7ey4VH3nxxzj
	 6QkLO+4vooZBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF55383BF5F;
	Tue, 29 Jul 2025 02:24:38 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20250725
From: pr-tracker-bot@kernel.org
In-Reply-To: <a981f40c12a45fe974beb197fa7b86dc@paul-moore.com>
References: <a981f40c12a45fe974beb197fa7b86dc@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a981f40c12a45fe974beb197fa7b86dc@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250725
X-PR-Tracked-Commit-Id: 5d8b97c946777118930e1cfb075cab59a139ca7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30b9dcae9815ae7e752fe3aa00aa283fadf16c6a
Message-Id: <175375587734.935612.14303295904159178400.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 02:24:37 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 25 Jul 2025 16:49:02 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250725

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30b9dcae9815ae7e752fe3aa00aa283fadf16c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

