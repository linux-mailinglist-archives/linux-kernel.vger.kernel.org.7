Return-Path: <linux-kernel+bounces-844704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3ACBC28C5
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC133B9147
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBC4239E7E;
	Tue,  7 Oct 2025 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZtO5O7y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC914212FAA;
	Tue,  7 Oct 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866386; cv=none; b=Ricpi4f1ewxsYO9rL+eRuSZXTp7HqlEdKtUvcGEeoE/D3PKQk6E98aza5kT7ZP9RBgJT9T7Vqz26GW3LHYK1O24p973q0krh9DbesxhlW5BX8mOCvw8jxrHw3hiaCao1LGtnunW6RdyxqI6WONPxwPHBrGyduBYTqiTMmmlQOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866386; c=relaxed/simple;
	bh=IG6nVcPqTSQl/fpYwnC44lOwDIEdEoJcNgH8Sz1GpAI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BSSzyR367epvRd7pWlkdDCoN+jH6dUze05wj/SdWXrCI7SPWFxJBn+R0nTVveHUuaBct7JaLNaxBW1KQELHe+Sl4L5KlG1mhDwBRQUg+SmQH8KXLWb+gyBVSkZvb6trrfdAcW+niztMcFYdEBE3xgwN4pOgdK7TTejFY+uv+2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZtO5O7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AAFC4CEF1;
	Tue,  7 Oct 2025 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759866384;
	bh=IG6nVcPqTSQl/fpYwnC44lOwDIEdEoJcNgH8Sz1GpAI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TZtO5O7yv0XBsqQUW1yh5hr5O8c232I2kuCP5BehNEj7KHzKR3EaIL155nqreoI9R
	 K2/3e/73JiIi5yeRISSX/ADq/eop4haQ2cqb/KeewKf6OUWnW1h8tkAEuMyXD2KSRm
	 YPtakVeldXCrMc7ApDoqPPh6l38svH4WPCeG7ywCu00ZTnDJekFh40BgPF2sUb+9XQ
	 poDfZ3XUujI8+YeXMOfo/5jHuMRklGTi3eFngb6R9AJ0GG2FB9D8+k/69UUwOKnnmT
	 4ZNQyJPvgWNhKfq+EiVoJxvaFIpNWwsyCYT29blDjFVRzUgtIHPkK2R8Ux9TzHk1WK
	 W/nWCGDujkadw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4F39FEB73;
	Tue,  7 Oct 2025 19:46:14 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOUQ6d4me_xFTEwJ@kroah.com>
References: <aOUQ6d4me_xFTEwJ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOUQ6d4me_xFTEwJ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc1-2
X-PR-Tracked-Commit-Id: 82a051e2553b9e297cba82a975d9c538b882c79e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fbd2e22716d30d77a35affd6493f4bd74fe2e961
Message-Id: <175986637336.2756271.11089790843971053314.pr-tracker-bot@kernel.org>
Date: Tue, 07 Oct 2025 19:46:13 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 7 Oct 2025 15:08:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fbd2e22716d30d77a35affd6493f4bd74fe2e961

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

