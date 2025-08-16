Return-Path: <linux-kernel+bounces-772290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FCB290E5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC2A1C26040
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CC23E35B;
	Sat, 16 Aug 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFXKqEt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E91DD0D4;
	Sat, 16 Aug 2025 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755385156; cv=none; b=O3raW7CFxeB1M+SwyhkiNHZGZ3yDy23irFGmzvp5Un2PDSmzoXp/jUZxkjcD90yT7UAIu2AQGsjz+d/3mvbdtx9SdWdSarWvNQ+g64wismWwy2vl5B1mjpu437WAac8ehALgNnAzPpVqu1Rqi71L6/MZy4diOVqZqa3PBiZqr9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755385156; c=relaxed/simple;
	bh=qe6DNb5yjdnToiSTXiYyc0eMnncF7v9EWnoXVZEYaPc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RoUc1hcEVkejAwBl1AS0NzLrVcuPn7QX8S6SazlQSB1EaRApk9zQju7/llVqvq9DPN8bjvLVuqvHHHktsN8vNgY29Zt+TLoxOrdR8aXipLf26YWfG2vDsVsEs5ZN8LAi3QbefquZQcEUkqd1Y0BoNi9FvuFHqPhnsvpnoUXFBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFXKqEt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA1C4CEEF;
	Sat, 16 Aug 2025 22:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755385156;
	bh=qe6DNb5yjdnToiSTXiYyc0eMnncF7v9EWnoXVZEYaPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YFXKqEt2T01KU5I68iljGFShwydYpaAYVAOlkeBVbKjrkzzM1bobGvz7AY8lRgAtR
	 z7ok5/8to1uNC5BjSFUrth8LKSsZs2OGtKRRy3EjBcWO2++c0LKPFOh8SvHoN/chS2
	 27oBPwio3WTZzUSgyV7jszB5U6cTGWx8UcP+ou9D9CTM5LMc0Gh7VehHxn9jU7FPwE
	 TPVa+3Ci4DMxK4eR/x5i3ClyWyx1cj0FgBWVmJqmUSPAyl0ZuC/yGBfcqKiL89ww43
	 iMQfwQhMEvGXWdLXsWQEwst0bVMD234Ioz3XWfjMA36WukF/NF72XLleMdOLJsVGhk
	 keqjVQnuGC4rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA939D0C3C;
	Sat, 16 Aug 2025 22:59:28 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250816214534.2736622-1-ojeda@kernel.org>
References: <20250816214534.2736622-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250816214534.2736622-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17
X-PR-Tracked-Commit-Id: 252fea131e15aba2cd487119d1a8f546471199e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99bade344cfa1577c6dd658e10a3d64b119bddf4
Message-Id: <175538516691.1570424.1799473356754517600.pr-tracker-bot@kernel.org>
Date: Sat, 16 Aug 2025 22:59:26 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 16 Aug 2025 23:45:34 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99bade344cfa1577c6dd658e10a3d64b119bddf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

