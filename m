Return-Path: <linux-kernel+bounces-840593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC008BB4BED
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C0F3B8268
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D93273D8F;
	Thu,  2 Oct 2025 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co/+snBW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E1E271451
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427357; cv=none; b=MfHJBkVozN4ZX1IoFGPJc+C3vrfK/Z/M2NY4ZyREcY22528khuuTiJHuD7qES/jsfpN7/XW73VEl349v8nKbNKyWAnXIuCA00s7v2877zVEm5xwShSpot2bWRcXZ2uG4iTICt0wJtd7KHMDO2X5f24KBmwsIlXHdZdQoGfGKbwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427357; c=relaxed/simple;
	bh=a40f9S1gbFCHQs69clI9oX6IAl7S9qa0NHW09a/Z8gU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kdxhCEtDiIam1CuTSr11693zoz73BdKh/H1C8HExokw/nRR27ygWoYpmtG7aisOVxeKdvh7Vu9KHh2tgxdpUUscpfIRUfLQGRzNfUVOeUyQ45NAYNEmQ0c7l0J6/BzrzpafIBPw+2LYKrJ1pyMOndW9SutpeNJ81iwHsZr7lGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co/+snBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A31C4CEF4;
	Thu,  2 Oct 2025 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427356;
	bh=a40f9S1gbFCHQs69clI9oX6IAl7S9qa0NHW09a/Z8gU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Co/+snBWlf5/R3GFSsU3aUPUs5lT8vVakr4kqfsUcHSbPikaymM64mTazv6kixTc9
	 Lu0io3XKGggqIrPC0JCWvyZjnnhvRdU1gIOMp5SukPkLxut8W9oVHhvqgzeAH7JqoM
	 yIbZNRZyPPplsmdzTtDryBVMmSm0K+N8iip/ojJtKnXnl+xBEGmbdwtYHIbMa+QOnk
	 vvK+Z7TCvzxKSOxm6VJYWkRPIpPT1tRjMKBrnsnZZa8JyDGutxT+W+V7ZH6OVI2YCC
	 X8dyglYxDLZ2d5yUEgh+ht6ANhKu146dDqiZzk4nDOF0c+3A4OIwabndUVmQnIU54X
	 z4BnKRsPvufNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5839D0C1A;
	Thu,  2 Oct 2025 17:49:09 +0000 (UTC)
Subject: Re: [GIT PULL] bitmap for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNrm_14uJmGE7MYC@yury>
References: <aNrm_14uJmGE7MYC@yury>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNrm_14uJmGE7MYC@yury>
X-PR-Tracked-Remote: https://github.com/norov/linux.git tags/bitmap-for-6.18
X-PR-Tracked-Commit-Id: 2cdae413cd3ee6aad782cf4bce8c10fdb0f0657c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77633c77eee37ddc160493a4cf6070c166f47dc0
Message-Id: <175942734837.3363093.2034093610240776932.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 17:49:08 +0000
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, NVIDIA <YuryNorovyury.norov@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Jakub Kicinski <kuba@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 16:07:27 -0400:

> https://github.com/norov/linux.git tags/bitmap-for-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77633c77eee37ddc160493a4cf6070c166f47dc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

