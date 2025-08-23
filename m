Return-Path: <linux-kernel+bounces-783118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C905CB3298E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943C71B664EB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A99D2E88BE;
	Sat, 23 Aug 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhZMwFEj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B502E888B
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963080; cv=none; b=bcPlEQS2+OBfw94estsouTDpoBMLXnC6+4WEz89oLK9mKufE7+JsBcrPT05BO4/+Bd0hBC7AMmxM7GODKYiqeTJi6AE/5ACISeebi20CMC1D0Sgv2kIOQOU35RrALP+VaVxtIR012Mee70r3QKd7lEbR3MIu96p3h2b7OMc6t3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963080; c=relaxed/simple;
	bh=KOIrI9Ufn+YwnqLipPLg5e0NaKniB4FSz3gspqX7wXY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QGMcvFV0xxHHaKtn9ZIZUADvDganXcv7dUsm5vnWTHLUR5aI+TheNV+3+nPJ0NE9ilawo8xmIT4yDRhbLUcDlf31bDJzYovMIOhDWNyJs7MRyVN1zNMmmmx1bISltfJOHLpd8l2FnwTVPzMpSc1iw07NaFEIJWi3tuUUhllAxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhZMwFEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46400C4CEF4;
	Sat, 23 Aug 2025 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755963077;
	bh=KOIrI9Ufn+YwnqLipPLg5e0NaKniB4FSz3gspqX7wXY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YhZMwFEjgbHFwhuHq1qXVBAn/FSpbkCMxDh3G1eTX7YYfBvM75Mdb4lOISBAocNW5
	 BA7PIsZ8mkfzhMTOHtT19myB8GPC5n6pny9gM/ThIO0sJs2js7OIv9N5TztFdYM7MZ
	 V1PHO3GhvnLBi9jMKMHMaGQgvHbWDIQaNfjKYLTnbN6gbiO+vjF80/a65lwYrgOCcX
	 UxpEl3K3GbtkR4eU9C2ez1UIky7vfU02MbQoTypPPLqYlQSRNlgPuihNyB6/2s4I2V
	 LMU2Vx9BzkSQgJH3cW1NjLdxZX8kWAScYFXvf9jg4rRNLUBSPwUqKyM3OP9fv+KvVL
	 N2ajl1F79AJ8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ADE383BF69;
	Sat, 23 Aug 2025 15:31:27 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aKnT9goiCOPLVeZe@kroah.com>
References: <aKnT9goiCOPLVeZe@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aKnT9goiCOPLVeZe@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc3
X-PR-Tracked-Commit-Id: fe85261d7d554f54693f205898260ef1d44cbd8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d245acc1e884e89f0808f64d6af3fc91d4903a0
Message-Id: <175596308580.2198696.11163170330161806100.pr-tracker-bot@kernel.org>
Date: Sat, 23 Aug 2025 15:31:25 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 23 Aug 2025 16:45:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.17-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d245acc1e884e89f0808f64d6af3fc91d4903a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

