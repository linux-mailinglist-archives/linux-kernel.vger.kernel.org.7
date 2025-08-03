Return-Path: <linux-kernel+bounces-754528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184EB19573
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC86189355E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967920126A;
	Sun,  3 Aug 2025 21:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwlmsnID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5D1EEA6;
	Sun,  3 Aug 2025 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754255614; cv=none; b=S4ou78/8XNVwCZykQgEGUJPDNSdQ0uQVQ7w67O8n/A04thbMND7G9QzzgwazkLOyqnQM0GD+wYdazDgXocfsflE+yp43A2zHTPH4z6iMQ3VsbCef5L/4iCelbxdZQMv40GGIix8TKLy2LOi+eWegc06kD9YsRVUutzIvsV4YnlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754255614; c=relaxed/simple;
	bh=pYYJW2tHQadIcv13MaCztDyuV+ELxiUl2kdaCxFSDkY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cFY/gzIrrpih/qgG8n/sewwutzVOkqTQBY1W36oDiZ3xRDa/REmnYix5vPbbTdK0oAl87pJpNEv3joka41ZuilQYTOQvxWewkPWABfLWQJWVc5TiQwqJvFEVIczzQWzpjKfpiyyfjgj3BMvDEZ6TbJTV6OfR/z7TWvWCCKUVZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwlmsnID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7470C4CEEB;
	Sun,  3 Aug 2025 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754255613;
	bh=pYYJW2tHQadIcv13MaCztDyuV+ELxiUl2kdaCxFSDkY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LwlmsnIDW1O6Yj2IwCnghfKVkpX9Hay3/+OcaneEMQz/8iGWMA0SePiZM/636CP5P
	 jeCXCUdq6JZ4ul7VRvaFgmSw/e54CYG2MWNWw7DlolGpOhccJgmpsiiFHMBfquLamV
	 dpofPkFHpw62/DLphVAbSF/P0uLRPA5U1qJ33cFJQWN6t8IvbvWHqm4SWuJAtpDy87
	 tjK3GzZaSLSBDbJPEyQ4bLiqtQ2imrtYAoXdedFiIPjyEZK8wVHItguYWXF6RtxK0I
	 T8+jevaUYzssbtun/jpdNdzPmqhLWWYRAziVWqwq1imjcF1lecYm9bPrFjn8m/ZyMG
	 YUDUYdSeMyKmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFCC383BF56;
	Sun,  3 Aug 2025 21:13:49 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250802211316.875761-1-ojeda@kernel.org>
References: <20250802211316.875761-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250802211316.875761-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git rust-6.17-test-merge
X-PR-Tracked-Commit-Id: dff64b072708ffef23c117fa1ee1ea59eb417807
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 352af6a011d586ff042db4b2d1f7421875eb8a14
Message-Id: <175425562826.537064.2790627555650149300.pr-tracker-bot@kernel.org>
Date: Sun, 03 Aug 2025 21:13:48 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat,  2 Aug 2025 23:13:15 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git rust-6.17-test-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/352af6a011d586ff042db4b2d1f7421875eb8a14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

