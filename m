Return-Path: <linux-kernel+bounces-838272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB3BAED8E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679797A0F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E821E834E;
	Wed,  1 Oct 2025 00:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIL4OExg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8311E1DE9
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759276962; cv=none; b=sMitIwQzFWFsqu8K8g6aK8uy0HYx8sWzrpAeJ1RZJvPG0Tn6eszcXbjL8uOpiFOB0fLbelS8aq2i+yunds9vjyK//nugtWU456tb3l+HdDmJZm3xTi/SXhLPigjoiusIF/m5NQA3mE/BseKZft29bcN25nVFal+molScWNzOJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759276962; c=relaxed/simple;
	bh=PmCp4OXLllNkswynj2U+xTdxJtKJyILN5q1IJvKoE5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=psM2x6KvgVH3/J+RkODmwrnoSSZk4pr3Y4YXD/QFivsI5KXGL26nP7TLyNJrEvRwzjB3BkCoKxcTCJ4LnfSbrvyjvDSXuWCn+Bp4DEuv1+B3IKqfyHAalDgr71Z9qeTBqeBBs4SS6nToCOel1luZqF6N1qTnqQsdXb334RMoDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIL4OExg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA218C116C6;
	Wed,  1 Oct 2025 00:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759276961;
	bh=PmCp4OXLllNkswynj2U+xTdxJtKJyILN5q1IJvKoE5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MIL4OExguysB2/jgHUOJdg87fVGx+mEOW9VklpKyX1lGAWxW63w+J6n/Hm7EikSju
	 YeczPCUWYZUtcAoRUfMoz7JTz1etVgKdfEPxFuFNy1XrMm+pxoDjBlkTbfRcpK8/8+
	 vHv0QKKXaHfUc+5MX63KzqfvOiW1TmurL07HeNWUZy1nbAN/jdjS4pagS47VnE0kQT
	 DgiuUZxMKtF9h9lHXmSKxKwj/BHZ+X7rTB9/zAq/uDHDfLNPwnSZ+WSgnxcuqw2gpy
	 DGuQbNdq8ExdGy93O8uGmKO2dcQ7ulfaYJ4utXTyICS0QPb43wwBF9YMkdnj2yd8Cn
	 8lWhWL/I/E2DA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACB439D0C1A;
	Wed,  1 Oct 2025 00:02:35 +0000 (UTC)
Subject: Re: [GIT pull] irq/drivers for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <175913808134.495041.9905645262400358240.tglx@xen13>
References: <175913807599.495041.10251515322736195577.tglx@xen13> <175913808134.495041.9905645262400358240.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175913808134.495041.9905645262400358240.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-09-29
X-PR-Tracked-Commit-Id: c33c43f71bda362b292a6e57ac41b64342dc87b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03a53e09cd723295ac1ddd16d9908d1680e7a1bf
Message-Id: <175927695465.2242674.6159429605719862821.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 00:02:34 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 11:29:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-drivers-2025-09-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03a53e09cd723295ac1ddd16d9908d1680e7a1bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

