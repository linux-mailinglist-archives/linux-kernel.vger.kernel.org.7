Return-Path: <linux-kernel+bounces-881461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5BAC28404
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CEF3B8E7D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC002FBE0F;
	Sat,  1 Nov 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmCeFQ1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFD2FBDEC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018936; cv=none; b=dYrTtz0S8kJJ5oC9frNT121Hf+PxZ1xD89ox4bkahSJkJxiOaXeWMPaTnFE3ATfc/cVJjRidTk9gioVZqUlgfWIaHozbDAR1x4EW7Rif5+rBzoMp1bJn6L1oF/JSK7B7yciWIjmMksxHeATcfFQPkQKcRKdKgGoW1FMhrwSv9O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018936; c=relaxed/simple;
	bh=bJxLNNWF9X/RPpZDKftuaWyan6nKdoQU79rA3ptlfik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r7b0fF9KO45z7wMj1ejLj9sUFX5T+Lh/zR+/tIErxkbN9890rfi/hVk+Gy/4sArLXyJsPl3uJXQvyHyJvSL0ZOrJmge1P2tBU3wpFq90243mjnkkvXvFzgNkwPTnOAmcTPaG9FHoBj1xTS+at+PLnHalg4j8eCy7VpPV1P9fX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmCeFQ1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDC2C4AF09;
	Sat,  1 Nov 2025 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762018936;
	bh=bJxLNNWF9X/RPpZDKftuaWyan6nKdoQU79rA3ptlfik=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CmCeFQ1tGeOrAgFt4dU0OKcZLCXXLeG5aiGwoxDdYt1XJhf8IBmAVuvAQrniVtlQ/
	 x2gFo0qi4WmLI88b+WJulazHj8QQ/Xn304FUJ3QzNOpk+/h6jAXClgDNqgcImqCCIY
	 An9e9osMmlNZezZazalgbZ9PDKJWHJAJRNCfLBPu6jyxnZHXn/CmbREANUN6zPmkzF
	 BPqJqAjmpHqwLqDi6+5yHCqLaK/lxbA76r76yuGqiMhtXGaLW9QnlVG5nOQ75d1h6L
	 Q4zK0cRttA+Ipm3+BpwoAGvyXpGf2XpYgvwBX+HO1I/5muAstaN4pG/n9O92WyxuPl
	 1wC8cA2ZpL+wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BA43809A1B;
	Sat,  1 Nov 2025 17:41:53 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <aQW2Imsfgixz_jBc@gmail.com>
References: <aQW2Imsfgixz_jBc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aQW2Imsfgixz_jBc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-01
X-PR-Tracked-Commit-Id: 9b041a4b66b3b62c30251e700b5688324cf66625
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3e0141d3dc55eb71792dd703e3f726cc29a6430
Message-Id: <176201891230.850663.10425138192802003438.pr-tracker-bot@kernel.org>
Date: Sat, 01 Nov 2025 17:41:52 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 1 Nov 2025 08:26:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2025-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3e0141d3dc55eb71792dd703e3f726cc29a6430

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

