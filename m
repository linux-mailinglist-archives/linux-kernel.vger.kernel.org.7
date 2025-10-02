Return-Path: <linux-kernel+bounces-840592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7490BB4BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890C6423AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F6245014;
	Thu,  2 Oct 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1trikmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A99199BC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427355; cv=none; b=qNG+ArPaH8QjOZx4MRclNY4cB8rwGhhsxtqnINOqvFtEJQcyV0A3L1Tc3IsYk0xL5kYOBHdl+8rG7495KKvC/XOpR1mx7TMSyNQGxLdCs+ZI0BoTY0BroEIny75Lt6SDhIl1C5pFciotfhCr1E6+QpQAlY3FkeuXjaCzaOivzz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427355; c=relaxed/simple;
	bh=/1KZlPXVeefrhalBsh1biK5BJfPzYKTMmrTfIVCPCzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KPp8LMMi0w/0uljyh/zCMW8h8qrfKtMRF8Riw8xrDX+amo/nj8NS14Ic/WVcwA9WpAC/dHn8W8PgCggta2h5DHg+L1uTS74faXxBql58te0Y8rbGm/KYLGXeRx6v/p9FMn3LZMg7VoUBdp6cUNz0XWGfVk2pVGqgOQ3xWtpMEmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1trikmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1FBC4CEF5;
	Thu,  2 Oct 2025 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759427354;
	bh=/1KZlPXVeefrhalBsh1biK5BJfPzYKTMmrTfIVCPCzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e1trikmAeuI0UPEc5r5dIk2o9uI+zV1s7Oo1b03Tp2Qs3FsSiKYROmN9j0eYYlMoS
	 MINLtPNmiiYgcSbipULsdrG/6RDA+MHwK4WX9q/LZar103gQeUb4RDMKHrzSY9z38g
	 8/tyLyAtmyHdj5jtO9VegG1AD5a7TCPrlyLIOhKShJqgC7hF7TrO1QOJNWeFTK7Ney
	 D5rPtnkM+TZQsO5p3PR8TrdXMR7Dm5ExoytppPwHzNBtkzXEvAGFdj0u5Y2BUzNzIe
	 FYb1WET1Dx3xh38WSD7360KNO0LH4Q1s99bTkMPgk/lNzBDfTAefVspSYc4RS4UJca
	 ifBezAYtGtSeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6BE39D0C1A;
	Thu,  2 Oct 2025 17:49:07 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNpp06-SzK-OOpUt@elver.google.com>
References: <aNpp06-SzK-OOpUt@elver.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNpp06-SzK-OOpUt@elver.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250929-v6.18-rc1
X-PR-Tracked-Commit-Id: 800348aa34b2bc40d558bb17b6719c51fac0b6de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7a018eb761f44f1f48667540185d025354f33b6
Message-Id: <175942734657.3363093.9632543332234597481.pr-tracker-bot@kernel.org>
Date: Thu, 02 Oct 2025 17:49:06 +0000
To: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 13:13:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git tags/kcsan-20250929-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7a018eb761f44f1f48667540185d025354f33b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

