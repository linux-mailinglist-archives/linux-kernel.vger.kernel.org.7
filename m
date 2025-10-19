Return-Path: <linux-kernel+bounces-859771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E76BEE83D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 17:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE703A5FC0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC552877D7;
	Sun, 19 Oct 2025 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTLhdVvq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4E1A316E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886349; cv=none; b=Wt01DVq2gZnGjPPvCp7LqdxGlVvMQwsVXYUZfT698O36o/W2SOzhKGJCLVJg1MdKhVBcifKFGrvfnCd7yNdA/pSt+kjcyvtXN2vmb1tjej8FjMYYZCElj03D1WwIS6NGACEkVvYgCLEfwll00x0FhhV7jOHC7kAdTR1IkKAxtpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886349; c=relaxed/simple;
	bh=HwlpuXREul11TzmQJ8Otm1QUFJQKUixoYU6OG4WpDfk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JFAOsCNjLldckWB4OosVQO028oDVm3Ezj3qB6fZyYb04ScNknf2vSRHrmcnui8vWZXC9RuV12Dx3ze3Q7Q+tyn0ZBUECjXjoa2GDVLvVd9L5dllmtxshsJmUC/coGeVPmAia5xo8kC0lMOQYhiDMmzm7Dvt2wiz67LJczjEGVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTLhdVvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4C1C4CEE7;
	Sun, 19 Oct 2025 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760886348;
	bh=HwlpuXREul11TzmQJ8Otm1QUFJQKUixoYU6OG4WpDfk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CTLhdVvqHHaqxmfvoyxiGvOvswvevPlP9KOwWk3rK4FDwg9QOXVYz5B9cS9+UAmue
	 IXUSGV404DPbkthqEsmpnssJt5DrECYZGqlc4fAUX0fHFJmMTGdThTIlD35d5uYmhN
	 z7g/WQbz8gaDfXmtMhhrRwMpXb/fbF/hHYl8LczaNLQmVLGSnttdrGuYNhBge6ZXFB
	 1JWazHriJtPSbHVmChTPCwAA3edDnHA63O3uwerEc1VIp0HxhxRg0TQDAnj+pwJ0Qt
	 ObtLZohyzJ5563JXSbXHjPX8hBT3FlMLN+Eqeahgzn77QTCGJB7H0+kI68cM7hobVf
	 j6tO3xw+tMEZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711F739FEB71;
	Sun, 19 Oct 2025 15:05:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251019110512.GAaPTF6LixGcvVysQ7@fat_crate.local>
References: <20251019110512.GAaPTF6LixGcvVysQ7@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251019110512.GAaPTF6LixGcvVysQ7@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc2
X-PR-Tracked-Commit-Id: e6416c2dfe23c9a6fec881fda22ebb9ae486cfc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7864eeaa4b743bffe4abb396a03b9d4730195fe
Message-Id: <176088633106.3293831.12614204148678438412.pr-tracker-bot@kernel.org>
Date: Sun, 19 Oct 2025 15:05:31 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Oct 2025 13:05:12 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.18_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7864eeaa4b743bffe4abb396a03b9d4730195fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

