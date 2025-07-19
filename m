Return-Path: <linux-kernel+bounces-737859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE22B0B152
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1830FAA6510
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317A72882BD;
	Sat, 19 Jul 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwvgNUlx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A41F956;
	Sat, 19 Jul 2025 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752949728; cv=none; b=mNsm6BKcM2/IHjlG7yFcPvkY4RAQ66KCIFkZasXDD1ZvCLXWYjyciV2c+1kxqdmdIp5To7pGccn1ytLEvnbPPquws3ZVAP7WgAVpp1cgOj5P7wl+pkT4NoAJuIew9DxQMQ8K1YmyoGXYBU/m831VrRYL1dAAWnOmaVy1Og/ag3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752949728; c=relaxed/simple;
	bh=0baM3rnvZJJK5d7rNNbz1rqqCAcObB8p9w1iQ69osvM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uAqoTpIFkC8OnODyeiQg2Sxb2Wpq8hajtDfIoI33B41Hn/UGgBXZjdD2ngFEQvXz8iM0MguqVaNPBG9f6bFJjEEYKDskVEHg2jJlnuhkiPXFewtUFDbp/MNLFpYEu8HpRYorj0fK2E/v9WFMLTputAJMcahiXenyIF7WoIffVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwvgNUlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17758C4CEE3;
	Sat, 19 Jul 2025 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752949728;
	bh=0baM3rnvZJJK5d7rNNbz1rqqCAcObB8p9w1iQ69osvM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZwvgNUlxZ/CQSoXRbCx3FQLzWIy32gCFHZcewsA1/1lF7Tx5sMHEON1SDhbaB9D5O
	 nuu7bel1XZBkYNZZwrij5deyubP7HoZ79EdOHNmofFY8RImh/e/pjDEH6t1X33XSyq
	 BtMuY5aDczmrbUGez5+zuSV8Hxc5+GaMvt0C+MR9w9+cSKItuEbqnl4HSIZRblq28E
	 IlMlFDkvbcyz8i0XYieg8WNuDLXjqbAvWzMQu6MxcfLdJSxl4FAaB3t9Se2exKNuBB
	 3Q6aXgEnX3YrNKS3nqN2shNXyp8nv7EKDBetFnZKnRSnUhEMt8MBhM1AnUSUzA727f
	 NtL7HNR9m1dtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9E383BAC1;
	Sat, 19 Jul 2025 18:29:08 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.16 (2nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250719103109.155136-1-ojeda@kernel.org>
References: <20250719103109.155136-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250719103109.155136-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.16-2
X-PR-Tracked-Commit-Id: 7498159226772d66f150dd406be462d75964a366
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acc0bac1c625972f3622339080194061e28fa243
Message-Id: <175294974723.3026904.14218459787436885325.pr-tracker-bot@kernel.org>
Date: Sat, 19 Jul 2025 18:29:07 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Jul 2025 12:31:09 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acc0bac1c625972f3622339080194061e28fa243

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

