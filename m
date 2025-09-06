Return-Path: <linux-kernel+bounces-804398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED271B475F8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6535D583927
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F252F0C6B;
	Sat,  6 Sep 2025 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKz9TubJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDA84E07;
	Sat,  6 Sep 2025 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757180961; cv=none; b=PBXxP7CHgJXsdD50EOsv/nzVqitik3fSbuddpZqtNivIkALZVxqqJ3Ydicz4ut5Hp2+kxHi3KEJxg7zTPWikYY1o9ETfuR4Q2cVzD2ygE1i5ZMotGPHmirXvBZ1VgsP7QDC6+Q9v5mB5+ZiNhJUfD6C+CU94n96dJgIdzrtYZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757180961; c=relaxed/simple;
	bh=83wRe5Lt+eBDQM0fzG8eoc8FaWDaq9vHLIisNMS4MP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTVClkCqXsixXXjg6EsAkJN/F2F/HLCqgRXf1PvArAmaW4KA5MTIw38NHxrzT/lZ5Dwk9IMZk4FzS4MLOH+bcdKOjuvxrPyTnTY0uBM0sT4CW28S6xPOwaHgM4oRnkL/bverfL9U7RNTfRL4J8BcgKAM4rtULkUVPCQV0rLnehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKz9TubJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD33C4CEE7;
	Sat,  6 Sep 2025 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757180960;
	bh=83wRe5Lt+eBDQM0fzG8eoc8FaWDaq9vHLIisNMS4MP0=;
	h=From:To:Cc:Subject:Date:From;
	b=dKz9TubJ434H6+8ZBLDWbc7rKTItogRbcJ2eQLlkqOERJ4SnZuUOiBgxGyg8hVgMc
	 RwP0uZVC2WQLE2X7fgJR/4CH0EM65dzsapj06qjfvwqfmYvDfTdsTvujiI1EA29O1M
	 Vhr3oknr52KELbv1T2P6BSEDn8U5Fp2y8csQePx1ifaEOo8ZpBy0MN2CK2ykGgRGCz
	 iiJx5MZmnpr+ang1JLjPFHe3Qzu9TdQ0WDBeQOeMuzNsyrPTNNTf6t0hF9gHCUi/wq
	 XPQrvWG0vlIQB7saz1yHS6fo6a/DwTttDQkKVqU2hys2FgfG9FPHr65QyuoUTVraxo
	 sMXgoMgaWwtDw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Rust fixes for 6.17 (2nd)
Date: Sat,  6 Sep 2025 19:49:01 +0200
Message-ID: <20250906174901.1244166-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these two changes to prepare for the future Rust 1.91.0.

All commits have been in linux-next during this week.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17-2

for you to fetch changes up to 8851e27d2cb947ea8bbbe8e812068f7bf5cbd00b:

  rust: support Rust >= 1.91.0 target spec (2025-08-31 23:34:34 +0200)

----------------------------------------------------------------
Rust fixes for v6.17 (2nd)

Toolchain and infrastructure:

 - Two changes to prepare for the future Rust 1.91.0 release (expected
   2025-10-30, currently in nightly): a target specification format
   change and a renamed, soon-to-be-stabilized 'core' function.

----------------------------------------------------------------
Alice Ryhl (1):
      rust: use the new name Location::file_as_c_str() in Rust >= 1.91.0

Miguel Ojeda (1):
      rust: support Rust >= 1.91.0 target spec

 init/Kconfig                    |  3 +++
 rust/kernel/lib.rs              | 15 ++++++++++-----
 scripts/generate_rust_target.rs | 12 ++++++++++--
 3 files changed, 23 insertions(+), 7 deletions(-)

