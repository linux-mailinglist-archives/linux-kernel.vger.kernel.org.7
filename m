Return-Path: <linux-kernel+bounces-749797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462DB152FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0327A7B29D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311F14884C;
	Tue, 29 Jul 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWx6MhSr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319F029CB4D;
	Tue, 29 Jul 2025 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814440; cv=none; b=A+wg2QcCKPOdpmxbC/WIYWQJmPf5s24t5yoVZyDNABrHG/ZAwduiohv5oNXdWvq7OTK8b0pookPCeSOPRSPoFH99OlrFLwwhy8Ard+3a8wL1f2pwACrZU86NcebDQs3juxQ6AspNKi3GFZbpI4ABhYTVGrDnt6c/K6KYHIdOX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814440; c=relaxed/simple;
	bh=hHIq6JBaZ1osg5OB4jLQoLso6aHha3yhC/7FJ3twmxw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=k49L9BA0KGEQ3QeRtVDW7Q8Mg6V767vWDuW3Gzj3rbXXwUiwjDEL/yonzYbDxsWiJVQm4VOJ0o92KxgLv1mCxrgH4yJWVmDVOPob4zVGVEsBNGozfU93ZmKFU6tzDp+NKauS4wTdG9fck6FjX7kAAdq1PStY/yxdsAcPufiktoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWx6MhSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12197C4CEF6;
	Tue, 29 Jul 2025 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814440;
	bh=hHIq6JBaZ1osg5OB4jLQoLso6aHha3yhC/7FJ3twmxw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EWx6MhSrQhrMV5U2bUGcsq9TdvvzFMIBa1c5PDEDqlON/RUuLTgoTXchhOi8SKb1N
	 xTXzqOVTOo6ynY1EQB8qtnb5JZOBl4RejD7QawXTFEwvJaVMC86+fRcOtQETsKVwoh
	 TZhUs0oaqRDCFnoMpGFE05HTcyqz8Wk7EZSAAG0Cu+ISVO69Y0/iRV48XvQphArRer
	 2P/MBeK8t6oIUHQhgzAFowPUTpmlH27rEjSTTbyqsupOVljbCEpdP0teRnZMidGmNO
	 ZcFC0ra4IQEzlM1XBNKg4H3FojCgqeNmzSczXdbQBr7eOa9gQC9rWpHn75RuGrzs/J
	 cGJ0zq6KK5nzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9D281383BF61;
	Tue, 29 Jul 2025 18:40:57 +0000 (UTC)
Subject: Re: [GIT PULL] SPDX/LICENSES update for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIebqSE7UXDL-jeN@kroah.com>
References: <aIebqSE7UXDL-jeN@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIebqSE7UXDL-jeN@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.17-rc1
X-PR-Tracked-Commit-Id: 06a9a4408697aaf0b4bd88936a3075a9a0b30124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 137177af71cf24a71a9854a5a5efbad6e0c5c5ac
Message-Id: <175381445655.1585410.10937845952573176453.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:56 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 28 Jul 2025 17:47:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/137177af71cf24a71a9854a5a5efbad6e0c5c5ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

