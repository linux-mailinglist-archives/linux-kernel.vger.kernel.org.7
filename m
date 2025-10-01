Return-Path: <linux-kernel+bounces-838337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C2BAEFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4463C62F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F02765EA;
	Wed,  1 Oct 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTLM/mez"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA02749E6;
	Wed,  1 Oct 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285260; cv=none; b=QgXhQ1sm5KRyT/xJP/3Vrxj20IFQcxrtTIgzEM2BEzQifBpKb+DDPNjocrN+6F+nL8rLZwP4DaSs2j78AdKHz8rdgFZ07/u/7kz0yg2JdnkHlRV554f/sAqMn11XstaHxZZxBxJRS03INvuac7X5rmU2Aw67i1fc0CTFwFkqBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285260; c=relaxed/simple;
	bh=EajitOefMf440FDSsGrpx9I+DhOePQJVjF799A7XsRk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ga1af7LyoqZHs7sZc9Y7xuIDvoeXkooTLmp3M0ukyBMLEDBrp4EmOwVE/sT2slJ9C9VmSfUL/uOimSYNMcOmDXdaqlYXYNZpxY1wOlkimQEH0RHvXUx16CzQincWNuzKiqAcahkp9eiSZzKy7BM39qrFY3+Yi49KA/I7bb//E8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTLM/mez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DC7C116B1;
	Wed,  1 Oct 2025 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759285259;
	bh=EajitOefMf440FDSsGrpx9I+DhOePQJVjF799A7XsRk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VTLM/mezZyg5bNHmZgnU6WTt2umKzQQ8CFrSlAj45ieKuCv6pPt3I+/wzyrlzssAw
	 mLs03/0I+CmEvW75us0ZhCEdym/dZelkB4BFC03Ps8fnEGUN+qaMhnpJw6+ydaYWbe
	 xXWq7HbqvoNGVtiRHxjwWFeop13/Zsu/3K0cmn0hM/Gdu8dSNLeaGa6MXP+l1wUELP
	 NmdViODQCYNeXH3gN0jyqkP4hcz6O51DOdrm15Mh3Ne1ghKPrmWLyKiB7b5JtqGBxu
	 pzbnWJNPXPuyrw/p62VB/I67qPFG6ldHaE6vyWBrM7O338jd2wheDvt21iV2qDKSXe
	 U6GEZDTzN+H2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E982039D0C1B;
	Wed,  1 Oct 2025 02:20:53 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250928173541.229298-1-ojeda@kernel.org>
References: <20250928173541.229298-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250928173541.229298-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-6.18
X-PR-Tracked-Commit-Id: f3f6b3664302e16ef1c6b91034a72df5564d6b8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4e0ff7e45c30f4665cfbbe2f0538e9c5789bebc
Message-Id: <175928525277.2275091.15646607935777095101.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 02:20:52 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 28 Sep 2025 19:35:40 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4e0ff7e45c30f4665cfbbe2f0538e9c5789bebc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

