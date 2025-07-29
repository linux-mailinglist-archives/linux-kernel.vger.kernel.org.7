Return-Path: <linux-kernel+bounces-749793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D21B15301
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B82D3A4362
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165729B221;
	Tue, 29 Jul 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bulPrY77"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24F29551E;
	Tue, 29 Jul 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814419; cv=none; b=XgRXR4soFEVmg9T8WGvXaCA2wQWe6GuADJiuRz4MZuDzQYPTWCVul8/3NIT35N4/Mm8QKvazNt4oOXq/StEwbqfSHwLHX3046yT1xBf4fsUvniX/ysE4ecnEJgBzPgMhyjlsj8SGRLamkazbyZ3Y7fEjDXAZlZB04Qmeu28577I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814419; c=relaxed/simple;
	bh=1dmaPs+FhXJ+7saYTQxgTlhRkjHB2WJxPj19M/N+jCE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=t4J0l4x/EIVG0CiocMx8A/rdiyPQbzhrhiaaIUoufuBSd8FAe+S+mqsYufNRK/bI7SIawrw+zs9IAgKoiPn/XpVGA5y2htXWp1vlTFR5k+fiq/0Tg/bRsiwXMHfqCUBGaoYT85DnIA6HiXk/lS36ghVym4P+3glEgwM73al50Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bulPrY77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1910C4CEF6;
	Tue, 29 Jul 2025 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814418;
	bh=1dmaPs+FhXJ+7saYTQxgTlhRkjHB2WJxPj19M/N+jCE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bulPrY77kGPrqj/hCo7gi8ql5Didf5Oz2elUjF/zVthzKlzKJh2In4iuSC1aiqi9i
	 LnITHoO6Cur882dajCgn/XAg90WFtkGP7qXb1DliDQRMyisSl/Gl17aSbgyI2bhTSe
	 spY6XJsqEx6HcwR5DseGVm0zY1cA1kZZgfHOWM8eQrT4znZdmLtPIuZpps1iZoruwp
	 VMbSPflfwHcOfUNf9uE1U9VvU37pW1vF5GaBzOBeSL4w6D4uK1XqKW14VP/0ze2wls
	 mrr7tBKYYCswkhXJYNik4y7hns24uJfsv6UdJgmZxE8PeQC9hxJwg5DJV0o4iiMukb
	 bNf+XJG6pOazQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73BE5383BF61;
	Tue, 29 Jul 2025 18:40:36 +0000 (UTC)
Subject: Re: [GIT PULL 5/5] soc: arm code changes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <fa83a407-a48b-4a91-8b06-6c9b6074f735@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com> <fa83a407-a48b-4a91-8b06-6c9b6074f735@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <fa83a407-a48b-4a91-8b06-6c9b6074f735@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.17
X-PR-Tracked-Commit-Id: 8c1f5a11dad0a9043c17c4c0240f394e481baca6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0919a5b3b11c699d23bc528df5709f2e3213f6a9
Message-Id: <175381443534.1585410.6519242830135316351.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:35 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 12:32:56 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-arm-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0919a5b3b11c699d23bc528df5709f2e3213f6a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

