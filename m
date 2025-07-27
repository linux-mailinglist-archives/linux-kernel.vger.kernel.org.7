Return-Path: <linux-kernel+bounces-747175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EFB130B0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23737178580
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BE621C9E4;
	Sun, 27 Jul 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOWNLUqc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2C22045B7
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634291; cv=none; b=ThzfQgGzhns2JiKIpXGVwOg2lEEaQir+Eb6JBWy1TK/ar1aynuQbzg5i+yGqms5kdM//4KLwrwd6WuR69zShw+bnooPHK5qW92QOuiPmC1eP61LiFBTmg4xAJH4QROZ8LDks64rtMnKlGK8ONNxlLWn5MZc/gyXOUgwHW6KCC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634291; c=relaxed/simple;
	bh=OJk8avA6rGrR9aBhgaDXkXF4BspG7Uvnm1aytf1kxW0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uVWnavyLVvle0gOYy9QgqiubSK5rHIc1cJCUgHie9Cc8f5HX41Y9he+Q2b0E4nnrqR+TWSdG9cKUB0X3OdNPBO+A6buSMwpoBPtjvCW4WPhdl4tIgE3UYj35GhblTxI/Zjno3FUQkNR56bhYE0UVK3ARjiG6IXcNYWqLJgLF4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOWNLUqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD21DC4CEEB;
	Sun, 27 Jul 2025 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753634289;
	bh=OJk8avA6rGrR9aBhgaDXkXF4BspG7Uvnm1aytf1kxW0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mOWNLUqcRJLBQ/BRQH/aureTnNFAf2qjeSzyNR2DombN/ow+0joBE18LXCOmD46W7
	 fdGWpqxZ7Vif1AwqMbdq0CDTUomFPXCcm0U/CK0xbcsYsleug27E5yqp16afqoDJGW
	 8fQSlAB3d3o3QIaHtTw4a/fBrtGrBUU9VCO45OxsQ9NSGylALIXu6TSBaWMt2PfyBn
	 XdhAvr1NLJpo4YcooRCkUnt8sp5ZW51yvrlDdlEJTQpypMk5A/ENcnj21UOh98wsxh
	 rGL+y3btU0kl9/1ilRbJ5nP+LvG/VEszJnvGxIQ3N6q1wbjbEb6JMOUIkv0zSmpgBZ
	 qeDOJ8TPhU3tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF96383BF4E;
	Sun, 27 Jul 2025 16:38:27 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <175361748735.557480.6049747546698820190.tglx@xen13>
References: <175361748735.557480.6049747546698820190.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <175361748735.557480.6049747546698820190.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-07-27
X-PR-Tracked-Commit-Id: 67c632b4a7fbd6b76a08b86f4950f0f84de93439
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b711733e89a3f84c8e1e56e2328f9a0fa5facc7c
Message-Id: <175363430656.3903624.12779345152502269707.pr-tracker-bot@kernel.org>
Date: Sun, 27 Jul 2025 16:38:26 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Jul 2025 13:58:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2025-07-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b711733e89a3f84c8e1e56e2328f9a0fa5facc7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

