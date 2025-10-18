Return-Path: <linux-kernel+bounces-859457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 089BEBEDB6E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 695924EECC3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2029BDB1;
	Sat, 18 Oct 2025 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkESQsZr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515127602C;
	Sat, 18 Oct 2025 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760818089; cv=none; b=bfMUomlNDfG3q86eXDs6adDeeAatL9Dx1bUJN3HlPK8AQ8GBP3B3aNXKxTCMv5c9gbUwk91X/fLVAvzPoTLWIU1tXVkS/OAbzopdelwZsZ0CTq23cNgAfdP/C5JlldTqsMRW8msfcRwwgzXjV+axx+isNGj0Yhj6063rfhSMb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760818089; c=relaxed/simple;
	bh=Si2s4d9gwNd2O4/FoO2uHD621OWA+Qk1HR/T+0aDmoc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FpNPuE4aacvJpvFqcLTtjTqOvbx+LqWkL0ED/mEr4/GPIsmXHMkkjO8TFZs/FHAALXM9X8bQeIJ15PJ3miDxOGMMr+EBO2z4w3S+/ytSCzlmVdzXcwSvlZ9bxotICvOMkWxUClPrm5jxQ67pN8yMUioFY/+R4kTI3lMzUlcmgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkESQsZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5617AC4CEF8;
	Sat, 18 Oct 2025 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760818086;
	bh=Si2s4d9gwNd2O4/FoO2uHD621OWA+Qk1HR/T+0aDmoc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TkESQsZrTDsyvFcOhvKoBMkwrMmYF1o4VpdhIodHwgmxkSjP0PvK5D1PHGbpyGgLF
	 ux7XP2AzgfjlO2P8OVa1lxt0zPpuinK3W/37YuAQ4LJJXrh8ROIBZqtcURA1ydl1qx
	 BrPWpuzyCV6amJ9ipZzn6if/ogXNpzzrDiyRFPI+hfos8aBCO2Spe8eswGG7/mCYr4
	 0a21u3f/SKn+Sr/ota3iqeihQ0MhkE4N6WCnW/pffm2Foe0MTh8+sUBYl2mmfWXuvu
	 KmmFK+s2xdFawU790Klx7QxMkxeUtbS/HoIJMwElJzpMLdw5E0OxwVRty4mwHrQMsm
	 Ouzm+In0aUg9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8C93E39EFBBB;
	Sat, 18 Oct 2025 20:07:50 +0000 (UTC)
Subject: Re: [GIT PULL] Rust 'rustfmt'
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251018182800.1592965-1-ojeda@kernel.org>
References: <20251018182800.1592965-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251018182800.1592965-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-rustfmt
X-PR-Tracked-Commit-Id: 1f1d3e1d094db732d22b892227bf1e1ac3a8ca04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c64efcb083c48c85227cb4d72ab137feef2cdac
Message-Id: <176081806917.3092921.16515996162714554124.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 20:07:49 +0000
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Oct 2025 20:28:00 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-rustfmt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c64efcb083c48c85227cb4d72ab137feef2cdac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

