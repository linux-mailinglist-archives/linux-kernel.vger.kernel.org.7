Return-Path: <linux-kernel+bounces-834672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F03CBA53D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8B87A5888
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E227FB2F;
	Fri, 26 Sep 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMzexQKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0423C51D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923057; cv=none; b=fk9kyJ1LwUMjl9LpICh0UXD/4WjjJSa132ATokdqm1IEIN06QG2YFGGOwhvrHPUElSR9i5VT2o7M6LRJufFp2BLSxntmo+uImiVyqd2ljRSH50nLh3V5+yQIt8/sLMLPHhBPok97CJSIPTfgkeKeVVADl6wd84m3jpsPztHKVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923057; c=relaxed/simple;
	bh=S1fAAapAfp1lEZtCVll0Xx7svNEJjn7DXQZSbHsy0OU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RVsDbjuNky3Gq8SaRaydXDyE35CPxq0KPyCg+NgBg1U5/1oiQ6CFoU9pEE0oelVEMo51OpDKlGqbtkZVrsJJDg9lwGzAvidOtvRzwUHSSOe2x8I7mF8nbdxM2ggR9mQq2J9UOiVncu0Ki6CxW8W/jgd5AHOldsP2iWEHb7Ta+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMzexQKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0465AC4CEF4;
	Fri, 26 Sep 2025 21:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923057;
	bh=S1fAAapAfp1lEZtCVll0Xx7svNEJjn7DXQZSbHsy0OU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YMzexQKXEyXYtGC7pdVIFnMqgs+qhU7fels5pTTmW3KdYcGkku44SQsM/HxwBFx14
	 aXCzgouf4Pe98UVBjpwLckmcXvHBdWUm7OA6yEUP14QsqqlpcXz5h3h2aqKDMtrJzj
	 a48y/3QstghSvyAdQ9EM6wIDaYstYKIr6+iX+b50yjAQuMVrltfwGBPHX8O7FYWklM
	 7gbwE361nzYDbkkgS1n/K/HLqGNhHVGZgxQnC2S4pi2XtT4wJywpzuW8N6QQaYUzCJ
	 8o4Vm6jgntuYeM1KPLtCQ4JbCeZY7CYsDVuin8PUoPrtf92GQV6Ir5UA1XCxsjj1K+
	 C0FHWM2mHITtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC339D0C3F;
	Fri, 26 Sep 2025 21:44:13 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V updates for v6.17-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <c6ef1683-9c29-cb02-4498-31fce8934d9e@kernel.org>
References: <c6ef1683-9c29-cb02-4498-31fce8934d9e@kernel.org>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <c6ef1683-9c29-cb02-4498-31fce8934d9e@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-v6.17-rc8
X-PR-Tracked-Commit-Id: e24108012ce9662d90093f91d5ffebcbf78da7de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fec734e8d564d55fb6bd4909ae2e68814d21d0a1
Message-Id: <175892305195.68869.1244548316108368501.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 21:44:11 +0000
To: Paul Walmsley <pjw@kernel.org>
Cc: torvalds@linux-foundation.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 12:33:10 -0600 (MDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-v6.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fec734e8d564d55fb6bd4909ae2e68814d21d0a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

