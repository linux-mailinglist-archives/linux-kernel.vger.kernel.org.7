Return-Path: <linux-kernel+bounces-848630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58875BCE372
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C65D354F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D722B8D0;
	Fri, 10 Oct 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmfrHg51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB12FCC04;
	Fri, 10 Oct 2025 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120720; cv=none; b=eAVW8DWFFv74EsW2vbJwZrYC4MaWCFuknljPtIDD6dzZQL223OFVAv/XiCoVIGHHRr2lxhRO3DRWtIv3TFlGYNqpP3dnLBtMXTeGyA20YShqkeesEsz3NapGzqkmb/alPKMxm7yLkFaNWmhe/rNinhgVHGyOHfsqFuBe2hgjveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120720; c=relaxed/simple;
	bh=TMmYpgnVBIJyMr0u8jVMZds43sE0Ws+ESMdMLTOxg8w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dS1jXTYVRHGcniX6db6bnaIv55Zcc3jKL4do7uiHud/pqIy3Fw8msFRpMoFtrQEiBaONJBAfdGGZfb6U8+q3gLgX7XmX0lnrNt87bvEdIM5Qks9ksLEyVTKBWtqlw+psEi7azhXR3uWJRScuitT6ha2r0KtDHPSt8SZSA0fWcjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmfrHg51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41A4C4CEF1;
	Fri, 10 Oct 2025 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120720;
	bh=TMmYpgnVBIJyMr0u8jVMZds43sE0Ws+ESMdMLTOxg8w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fmfrHg51vTlHG1fIFe7oYPETjer5Wz8lXsx40ogUg2r2XytUwy91lFxeEUuYszVUt
	 q+6hHUWVsgPCcbXlhsd/lAVrHvSYytNlfnDDF64Ob8yb6or2dX9vwTM8QHCkjzeeEI
	 LIqiiUxjcekQbF0DLIse3gkfCw9+1SFfh/Gpag36UrOSAWN0bne851o6porYtNF+XQ
	 iEnCficV+XX9zBC/XPb2jer+i9ktrWVnUpsLSI3cbi7IBD+GXADn9pp1l2ZJ0rKvG+
	 2L1tNYhzq4rnuDkpLDhEEUSFniV79YW3yXbZtXdMp61suREIpYqZbowAjymdZa6dnW
	 q1JtU+1FcXF9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2733809A00;
	Fri, 10 Oct 2025 18:25:08 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and updates for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOkEOBbCvAdGdF5c@p100>
References: <aOkEOBbCvAdGdF5c@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOkEOBbCvAdGdF5c@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc1
X-PR-Tracked-Commit-Id: f4edb5c52c93b1bc676064472fb517566a3e2129
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2
Message-Id: <176012070729.1074429.16299569342844065275.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:25:07 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, John David Anglin <dave.anglin@bell.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Oct 2025 15:03:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cc8ea228c4199482cf087fc6ed2d6e31b7a49e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

