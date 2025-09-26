Return-Path: <linux-kernel+bounces-834673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2634BA53D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9831C05E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B409283FCB;
	Fri, 26 Sep 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ikh1QBLu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E827703A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923070; cv=none; b=SFc02jpKiAOX8X3A7kaZ02TlohrWlAbXBxr973tMEdvfUyFRXznt7a1JxQz8yKwVtTYyw1KL3zHa/xU0KqcZkf3fCo+3AP3d1FIoNvgKVaEmQbP2W7AJlJMvkcxC00lp1Qxlq0fZ8chg6kWOVVWe8cqHYI8ug6qA2jKXfSuJIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923070; c=relaxed/simple;
	bh=YubfsClXDXXryJDMnUl423aPOiJSxYi4E69I8ijzgNg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=O3vsRBIFS0CdQaXQMrH9lNwMNCa7G2B3z76xO4gECFu1gMJgL+hrxuAYoDm6GVpr/ySG9t6SI97tXa+QMu2kuZ4MlLh3JQL1V5oNPyWD9OmaTBYbkf2P8idb9PFv35UdslxzIHd332bZ7qkXjB6jitKQTTHLyPQj4qVthhsgWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ikh1QBLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBE9C4CEF4;
	Fri, 26 Sep 2025 21:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758923070;
	bh=YubfsClXDXXryJDMnUl423aPOiJSxYi4E69I8ijzgNg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ikh1QBLupbdeSuPQIr45IHKkqRNTWLN1nDR/3h47jDSxeYLYNW9CQ1Hk6YXtNfoZo
	 Vx/EoP05ZjrKI8IVOJ3DBwjh4cAmS6luvY6bXDwUg8ahTYK8UyCnveeTAuDDJ8YMj7
	 uMCFv2adQa0z1y1nx2h/cQk4eZ0/8d2x1dRZNab9+a2mxMi/NoowrsYB5cfcBnEfmp
	 g8q9nHC/A5NhMB/QTaiGvwQsTY4VexpWA+6reS7XJEoB2Ye+6sizjMys1w37lww+VF
	 P1/Vjs88sPi2qX2DLFBuikIoi2DC3HvBsrLbbH7YhMffa4w0W9/PVyxaZtNr10mnFP
	 xGf182U4FNjzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE2539D0C3F;
	Fri, 26 Sep 2025 21:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aNadAaV951IoOgRT@gmail.com>
References: <aNadAaV951IoOgRT@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aNadAaV951IoOgRT@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-26
X-PR-Tracked-Commit-Id: 2066f00e5b2dc061fb6d8c88fadaebc97f11feaa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4df17482e963e5424da63f22010976d1656a4b0
Message-Id: <175892306536.68869.12066778043654557278.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 21:44:25 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 16:02:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4df17482e963e5424da63f22010976d1656a4b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

