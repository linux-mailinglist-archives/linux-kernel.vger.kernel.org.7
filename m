Return-Path: <linux-kernel+bounces-887188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74720C377DA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0849D18C7784
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301D0340D87;
	Wed,  5 Nov 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyKPW/Vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AFA33E348;
	Wed,  5 Nov 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371221; cv=none; b=jk0LsoodivevS4IAq6VFIlg0riXRpPaNlboLbTxo2W8QDtdIK5Jw8noEAVnug4xM+R6/OMtYhTULqT8/gdG0jXmQv/F3sbqH+BK7BzzSxP6fsMqCKn/eZIfgrJLyHqRLVj/amQKnf0vKcwFv4icLgFK4cdgiyqE1PIzXUhdO+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371221; c=relaxed/simple;
	bh=uSOZqXqFyaISzuupQjs4sLi49Ldhekf3TgJItJ0PTwk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CMj5ZHdV5ILfW7tjsjFPEUA1yONIAb7vcAyUonZRNCagSLI8trcDaR31zwnAh82tXBqGVG3ZGRurxkDxTMz8C6laTkyEY1SSrAxNN0ODgUqxwpunRPijbK6ECeixfghc0q5YfWIpGApraIYdz4eEb+Rz+eiSjufQDIda78Q8rBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyKPW/Vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA7C116B1;
	Wed,  5 Nov 2025 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762371221;
	bh=uSOZqXqFyaISzuupQjs4sLi49Ldhekf3TgJItJ0PTwk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QyKPW/ViPZTR/sCKoN+8L9FEpY1wz86bI0twQXsMwoJSGaP8yEOuq2X1LxbiJYcLn
	 zO8WAAktuT+75I21Xmbg7Zhqm27h3ofPUD9zmhezkfNRKRX8VnwAPZ4HMJnXQ83Lxx
	 5x6akKenTcLFqfS2RG5oZBiG9KWxz9K3bxqmbwfR05v+sm2RJoGWcW06/pAuwxZEFq
	 JvQbFIFaGuvSfRuFu/JsVw8iImwyxzI6VvNgGXdI/mCL2gQLIMR9RaK1cCIX6pVOkv
	 zOdYv71I3QRDmieO9jKTWETOIu2V3ZpSgkjflUnfznhPpHYTv9yWO6k5X5S9iGpmai
	 tvjDT4FMX7PGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF1D380AADC;
	Wed,  5 Nov 2025 19:33:15 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251105145406.33929-1-ojeda@kernel.org>
References: <20251105145406.33929-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251105145406.33929-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.18
X-PR-Tracked-Commit-Id: 789521b4717fd6bd85164ba5c131f621a79c9736
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc77806cf3b4788d328fddf245e86c5b529f31a2
Message-Id: <176237119431.3730612.10184572114611108364.pr-tracker-bot@kernel.org>
Date: Wed, 05 Nov 2025 19:33:14 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  5 Nov 2025 15:54:06 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc77806cf3b4788d328fddf245e86c5b529f31a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

