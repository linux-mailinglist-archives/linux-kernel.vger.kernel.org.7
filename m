Return-Path: <linux-kernel+bounces-842132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608FFBB90ED
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A4719C04B9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CB2874F8;
	Sat,  4 Oct 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNu/o3V/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE6286420
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602019; cv=none; b=eucFUv+Z8DewSZyYxSZ7TiuBrlITjYZPUveb432KUbUffKW8JJ1Gj8SlexuTQdU7onHMafSa8Qq2vcc9ydcyOrK8QTREsDgeITLWph15YVcEMiv7Dzm3nCvtPT8fEveD6SApAdPVbezIXxlOSM8Y/EAfTmpFV7boGCECcHB4TZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602019; c=relaxed/simple;
	bh=3Ao1DqyqkA1i/m8PKQMR3M/c5dL4R4NHTfcO1XN4SRw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eH6hxeSTCvSYBYTklJN+jGdymuDOnZFjCM6qSPLlu3CZehxAF57kPtCsgClEdwQiuyHDZfbtuHUmy3hR4uWOzgyB+T0zlRgwqsynEBeSgs3C7N+U1ToCdEIFLJzBF0NRKOIzc36O8e+p1mwnUtBkclkbw7DAqmLzlzri/IjzlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNu/o3V/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008A4C4CEF1;
	Sat,  4 Oct 2025 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759602019;
	bh=3Ao1DqyqkA1i/m8PKQMR3M/c5dL4R4NHTfcO1XN4SRw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jNu/o3V/1RyXAV+QzUBoujOAK/I1pG7TK86i2pNpkmhGI3uxNgtByaPu/CeluxFX0
	 kmnoJM5y6gXV29g3t6Z5Y7xheQJ/U36FWsqbDkdKoZducqVe9p1DCdXUCMn5StWpX6
	 PXGhPbgXBuZ1D51iWPXWIRbKUOk1gJM7zzPrjTzIrOK3QTzO+ZPHF54Gl6fpM99xNN
	 NrzRJQF77BtzGnkRxKfbMI5B9dPjPT0OnYnXEyuc/B2/S1fOiMFJXrnI9AEovdjjLG
	 DcLQqULAcghYIStpaGd582X4gJneY1EgTbEJxKClmbM8DPwgj2N5EptpHDVXi7zedP
	 oHeeIjqrxpkTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8A39D0C1A;
	Sat,  4 Oct 2025 18:20:10 +0000 (UTC)
Subject: Re: [GIT PULL] mm/mm_init: simplify deferred initialization of struct
 pages
From: pr-tracker-bot@kernel.org
In-Reply-To: <aODmrlNys5x2LVtl@kernel.org>
References: <aODmrlNys5x2LVtl@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aODmrlNys5x2LVtl@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.18-rc1
X-PR-Tracked-Commit-Id: e68f150bc11d0a05cbe984a4e5c0f72a95cae07d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b41048485ee395edbbb69fc83491d314268f7bdb
Message-Id: <175960200955.404121.9390868499394906575.pr-tracker-bot@kernel.org>
Date: Sat, 04 Oct 2025 18:20:09 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 4 Oct 2025 11:19:42 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b41048485ee395edbbb69fc83491d314268f7bdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

