Return-Path: <linux-kernel+bounces-804439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F83B476EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCAD5A00CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C9292B2E;
	Sat,  6 Sep 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a33Uqv2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB45710E0;
	Sat,  6 Sep 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757188156; cv=none; b=J5WQlLH1tugvnVPUwK061uJgPK3eAWchrBF7l9LC7MgStZIfOQZF7Rwrtjx0XkUF68X3uv0Y7OZ/5dbsXXDOvHoJxessclgmpGodR9/F3KzZ+WZmKAj4gr+gTduNJX1IoETVA66bKpAvrGz/9l1fGp0XOJNjGEW65tLJDAF/w9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757188156; c=relaxed/simple;
	bh=rIiPK07wJbss6Qbgul68MJIwu5jVzOiPI2vWJrjuYkI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A/D7mj0K2J/Te1wBzF4G3LKtR2qDimFsZamjYTsSDW/tmDH88EchxObk8JHrjipwrbyVsFuezDDax7dKguXGiZMJjjoPfw4j7q5UR7QDqwdlK4hT7LN7p5Oz40+ZWw3WNnl6fd5tzbv2eHAI+i4FUlL0nwFWfWSP8CPwOGRSrj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a33Uqv2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522A8C4CEE7;
	Sat,  6 Sep 2025 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757188156;
	bh=rIiPK07wJbss6Qbgul68MJIwu5jVzOiPI2vWJrjuYkI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a33Uqv2Wzd0lgrCj65q/pRfhRj7nSv+GOlFm6isRDXezw3GAI/u+i2iuqoya4MRsQ
	 swoDuDvafs3YDoeejWnQSK4EZgztLuRlNrlYwLYusrrUky60jdMRV8poVAJk6+5pH8
	 U7DUEalcHoakNSs+Pc/oJq4Mcc4k29c5EYykJf5j1HL5ntb2AJ80jlOv4GAxSYLsCz
	 9FlaEc1XER2HE3ykPf0d77H+ahv98Y6iQOn56LKxZObojziSfMilWZ7Y8IFm7bJpuL
	 WPqoYj2GmdZzuWnXfbTp6WG2sC028/jIbLQtWY6X600lzRZkZXiWqGZDQ+Y/lF3lB6
	 o+RbAUMNjeKAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFE7383BF69;
	Sat,  6 Sep 2025 19:49:21 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.17 (2nd)
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250906174901.1244166-1-ojeda@kernel.org>
References: <20250906174901.1244166-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250906174901.1244166-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17-2
X-PR-Tracked-Commit-Id: 8851e27d2cb947ea8bbbe8e812068f7bf5cbd00b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b236920731dd90c3fba8c227aa0c4dee5351a639
Message-Id: <175718816052.2921744.15177006160768320115.pr-tracker-bot@kernel.org>
Date: Sat, 06 Sep 2025 19:49:20 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  6 Sep 2025 19:49:01 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b236920731dd90c3fba8c227aa0c4dee5351a639

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

