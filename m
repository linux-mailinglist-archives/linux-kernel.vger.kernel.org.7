Return-Path: <linux-kernel+bounces-870075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED562C09DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C61064F80B6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7502FFDDA;
	Sat, 25 Oct 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIeL6JtK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6D1C1F02
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412035; cv=none; b=OAkbX2gypHqtsYKL350tAxzcdJW4421r1Mh9tC4+wCPoJOjh3HTfR1e5TegBssT4shmauhteQUNK8POTUlBBE5H3Mimxbm2C0yqpNQ+W1SIliyUum7TXninbOrryUG7HwJ0HteLslC+aenHoxpoaz2I/RT0D73jKX/VcwuYcvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412035; c=relaxed/simple;
	bh=oFDEjQWmXI3lwyCZ0vmIrO8U6dOX+eps2W2pa+wnXZM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CyxJs4dHXedM4KOsejbN2TQOCWanz3GqRgUh0vEvDn8BMX6OEvXO0dzHxmgjZ/PdniioTMK6ICk1J5mB+ezjNBsl7cXzcQCH9p6EhVfiDLaf1FLotNrP7V+rv2WDVPNjlBArui86htnlB1wdXCBa2QVp3302Rf7t5ZNmy92Cvp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIeL6JtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39206C4CEF5;
	Sat, 25 Oct 2025 17:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761412035;
	bh=oFDEjQWmXI3lwyCZ0vmIrO8U6dOX+eps2W2pa+wnXZM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZIeL6JtKu5z7Yd3dxtHdcnXtO4+nQez97rdt/fs9bG/9ild/9ynTeq95S5jC3jL9G
	 wD0wMeF6UqsOWjiF4TdKwsM6IfJTgn7l70hbIUwIHSLuBSLL2OPnZthn6vUoSSQp2A
	 wAWiu3d5UuPTp1BTViQNJvBOowxw5E13BEIpbjfJzJ9z0tM/qdMx/a/Wfxm0r6votY
	 FZhEQPKcqTv7WBFL5zKLjPoML+xxRS53u5hCiT9RqLAQuhGeoIs8zp0MfhH3FcrVrS
	 2DCzbZyB2vpyLQyv1DAYZVV5OUITVtKJD+oHnhJ+uK5lZAHDWvX8JrNXuvwQOocObj
	 TJYc3BAapSdWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB0380AA63;
	Sat, 25 Oct 2025 17:06:55 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <27fed8ce-11d7-cd8c-b0e2-b89b11fa3c5a@kernel.org>
References: <27fed8ce-11d7-cd8c-b0e2-b89b11fa3c5a@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <27fed8ce-11d7-cd8c-b0e2-b89b11fa3c5a@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc3
X-PR-Tracked-Commit-Id: b7776a802f2f80139f96530a489dd00fd7089eda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bb956508c9d94935bedba4f13901fb2b7468e91
Message-Id: <176141201418.82217.572878325720123603.pr-tracker-bot@kernel.org>
Date: Sat, 25 Oct 2025 17:06:54 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 25 Oct 2025 01:04:21 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bb956508c9d94935bedba4f13901fb2b7468e91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

