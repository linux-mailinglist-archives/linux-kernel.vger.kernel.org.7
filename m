Return-Path: <linux-kernel+bounces-891074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112DC41C50
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 22:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B26434DEBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868AF2F60DF;
	Fri,  7 Nov 2025 21:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNlT/0df"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB672F533B;
	Fri,  7 Nov 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550536; cv=none; b=YasYIy3n8fxxmvOkFxci1f8+aQXj1HsddFo+E7cIfeTnQUHqT5uGoSiVbVu5Kr+k0Ow6PfDMqrJlIAxMJtEi1u4qW3vDcz6iAWkClCfVuTLvlFdRLvubjTFMx9I4JDkFr9C70Q80TsHx3GJj/iaSKS4KiUwtqkD31XSevrLZuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550536; c=relaxed/simple;
	bh=5KRscNYg5k+2OsY65KgBZ1/oCsIHV8ODDRWtMMkrS2o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Mt2XfoYJanWcJHvYMU9r691WIj6fHx3smVoANz1FYkcJlV28S1ivXlkyZ3tpgM4qQ7J6h4b/qtfZgFxPIOQVrGwX3udzFuox5PCRpyiuYHFxu9KFkC0fst7v1Rk42xzetbNNuPdTRkwMCeqkak7cDTihzL0TGyXHyU8aphoBfdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNlT/0df; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C025BC4CEF5;
	Fri,  7 Nov 2025 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762550535;
	bh=5KRscNYg5k+2OsY65KgBZ1/oCsIHV8ODDRWtMMkrS2o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cNlT/0dfFaOorZBPTM4RHCT7ilf4h/FH4DY10FBUnIooOo24/bj0Qj4r0A8ZNgHdL
	 ji4A123t1gNFLHeF901tzEJ+K9ZeFP+BlBmSnY4ffa7Xg5/+OthMp7uyy/xg4r2rcC
	 8eHk3bw+V1i3kuwKemmvi5yqVtHclenhgCpv4KMwjjTeq6DcnjFjuoGi49yPS2umC6
	 v0v4KMyK3OQ33dn/uO/Cmz89m0ZD/sXQVbNInKserO9GkrZaOYQHd2/bcC/5OAFFMs
	 8nKaK+JoZPR5Y9Ermb8WOAefeQ4ygmr25BU31po5NUbJUH12G6jRD0hUXnB3w0GsPl
	 3HdB3TKSS6FYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C233A40FC8;
	Fri,  7 Nov 2025 21:21:49 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fix for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQ5KJJJVKWhzoyz-@p100>
References: <aQ5KJJJVKWhzoyz-@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQ5KJJJVKWhzoyz-@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc5
X-PR-Tracked-Commit-Id: fd9f30d1038ee1624baa17a6ff11effe5f7617cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38a2c275c3d3f7d7180d012386cd6fcf87854400
Message-Id: <176255050779.1164216.13742148972087978322.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 21:21:47 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Nov 2025 20:36:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38a2c275c3d3f7d7180d012386cd6fcf87854400

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

