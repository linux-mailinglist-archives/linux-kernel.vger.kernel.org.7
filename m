Return-Path: <linux-kernel+bounces-748997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C4B148B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99605445F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB399272E5C;
	Tue, 29 Jul 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQhumNJ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415327280C;
	Tue, 29 Jul 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771810; cv=none; b=rap7TAH/01xRrRPv6tK/AT8cONTuv1D2octI13Ag3/LJqRKX1wwdVf54XaN09Kxrp8QiXHxNn5x2H0WmXI/BitO2Jsn742FZLu4MHuQh8MWCRP8A3OnUT/JXyn6xoW4OAxuTWHCyL17HVoB5IAHkkpRe59lM4MeTqJBsR0XRZfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771810; c=relaxed/simple;
	bh=oWa+4sRFPS2cSETjI9CD5iw/z2VWqXNbWxnDSV2A5Ng=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GAIFeAAa45wJgVM1Vb0Pl71G3jU2RrntAA4gPMDvpAXX9GDbF3Y2r1Ls0SCPCOiI9laZpJ/NYLugsPIvoCMMX6bcOzQXMoN2vpSo7qcIAUvEUN98K47MQY9flZUltVIhnNfqUGyWlASOhbltYC0I4Xy6m/nSNoEwOFbV4qcLdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQhumNJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702EC4CEF5;
	Tue, 29 Jul 2025 06:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771810;
	bh=oWa+4sRFPS2cSETjI9CD5iw/z2VWqXNbWxnDSV2A5Ng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hQhumNJ/9Jg0YSq2smR7upOPHQaYdszDjGFLi2JheteFWNJHbUg5GDE8QL8sAL8To
	 pQnbi8tPPyH/ZKmtMQEZztZ/i967cvsjbd3HF7whiaDw8rI2h0+0atT7YqZvjIdm9m
	 GqlBUYQMTVsupv+QC9zznC8+Y+Qi/RvKoQCVZCNXAr7eY+buWxwg06lXDtRx79X9c0
	 Y5COp3QK9VmKKNZzYvJu7aToKvCyW3poP1MIWjeK3b1pS2hMITBfUAHzz5PY2BRH7C
	 O7J4Rb8yakt1n4ZH/XDVPMxq0CAOBysOxpAyC8nbKPWXMCYASZyL+TMIRETiqOeTys
	 yIQ6e8YBT1oIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B31B7383BF60;
	Tue, 29 Jul 2025 06:50:27 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.17-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250728141420-2408727195@linux.intel.com>
References: <pdx86-pr-20250728141420-2408727195@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250728141420-2408727195@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-1
X-PR-Tracked-Commit-Id: 1798561befd8be1e52feb54f850efcab5a595f43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9669b2499ea377764f8320dd562dd6cd4ea80a5d
Message-Id: <175377182657.1356386.12280157075220710993.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:26 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 14:14:20 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9669b2499ea377764f8320dd562dd6cd4ea80a5d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

