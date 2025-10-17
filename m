Return-Path: <linux-kernel+bounces-858839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3794BEBF99
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574854E11C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA693128CA;
	Fri, 17 Oct 2025 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXe2vwHH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFED2FD1AD
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742436; cv=none; b=EZG58/VKgcca8AjbWHRFsThtqZpn0Pln5ZMRF07Tr1V6/aUJyq2g8N9V1meqBPMiM/eEk5YbeSHBjl0TACu69NuK6flBCW+uBv7Mkb0PD7ul/w5S/3m1f4hbI4o5w0BQ19fzd264Is2mXX+By+1oS7ZGZEel8flUAwRb6jND7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742436; c=relaxed/simple;
	bh=mUv1hB7hSxDM2HNM3x990sJvp7BySywC6rGZb569+S0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u5A4Shs/PACXTSUjxIURg5oo+0UNgws90825gmomJDMM4gi459HP2zbJfAW9A8cUuPRfnL8dypOEk53mW4l/RTgjx3ZNU0tvs7UTHw2jksQrgDUetI1V2YTRGsPQ0soQIhO3FAkQJel71D7YILEQD63CEqHg764bE4S5uPqbpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXe2vwHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAFAC4CEE7;
	Fri, 17 Oct 2025 23:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760742436;
	bh=mUv1hB7hSxDM2HNM3x990sJvp7BySywC6rGZb569+S0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LXe2vwHHbG1rrrIzhCg11tyT/+A/AoQn8Fike0su0o9WDNqcsEcxYO8B39ua9YuBV
	 pC0m1By3xl9k+eeYR7XEt6hOrTzi7q/Mebse7BGKgecoPdiEBMcqncXMn2Bro+3j9/
	 f3aW9JMvO6GNqm9j66YQz2Y/VC59RiqojVb9dldsTHrGNxJTsrR2W2egcpPCEKwp5e
	 4609rOTvUERtYNnrG4koibP9jBbgT8XdWbp7tYO9B5jcnHGb0Wv0IC65LmzY3pfu3U
	 3t9pg2o0LqkvVY0YVlmMNm0B3fay+nK/yEAiQQs9BtADLoRCcbOMTcOOMonqZkOwbs
	 FAaND2QejHI/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB37039EFA5D;
	Fri, 17 Oct 2025 23:07:00 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <f21ca0d7-dd9f-3dc9-34ca-c1444702370a@kernel.org>
References: <f21ca0d7-dd9f-3dc9-34ca-c1444702370a@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <f21ca0d7-dd9f-3dc9-34ca-c1444702370a@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linux-6.18-rc2
X-PR-Tracked-Commit-Id: 852947be66b826c3d0ba328e19a3559fdf7ac726
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe69107ec7d8b946ab413cfe118984dac8f1a0d8
Message-Id: <176074241954.2817248.3901691578387543892.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 23:06:59 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 01:37:24 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linux-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe69107ec7d8b946ab413cfe118984dac8f1a0d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

