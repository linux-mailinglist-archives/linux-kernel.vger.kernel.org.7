Return-Path: <linux-kernel+bounces-886659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45BC363A2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4336567AB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35D932D0C2;
	Wed,  5 Nov 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1XbyeTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0569030EF69;
	Wed,  5 Nov 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354464; cv=none; b=fXp3t9ZpF13TbfyyplFmop6jZsK5tXKRPpL4L0aW1ta48wwnG+/qwA7Gyt7MTokftuL/bzfEQpXybfnV46YXRCHprophkJZEM4DmxzKbRVCtaf5OoUkMuNkH3brFcWk74wIkl4/tgGGgulGKxN3NOddehartEjshsjiw6NzBiHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354464; c=relaxed/simple;
	bh=Pe04+1UZ0UUwjeDk+3LTlXeGLffYz6sUf1Mw1rtkdhs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7g0/jzV/dyF1pVjqkQdy0xFjB+oQfh4HO2ZFkM5XTOANPsRCMr3JoVaxKxB+5wXZPMUDI3UCvRrUwGW7HvxvEt/fHCl3fTUaQxhoVFggaAXJSu9aUHiS8F6A9Uv+GMQVi2I1qIgglqtEFMZOzKjHiWgOMTzdMV1stwsY3s2HEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1XbyeTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A443C4CEF5;
	Wed,  5 Nov 2025 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762354463;
	bh=Pe04+1UZ0UUwjeDk+3LTlXeGLffYz6sUf1Mw1rtkdhs=;
	h=From:To:Cc:Subject:Date:From;
	b=f1XbyeTg729nAGqpC8++emYUHmJen/F8k6A6JcYpf6DEK1TFa5ofaoLbygMkoVqdZ
	 EbebkV57wPl1AAhdG0TzyK71Hm6fQEbjamb1R+BJ2yM+ZhwGtSsWNsbvauB4VC19S6
	 kTD5POvN8FR+COPNC/zkbQZAWYLLdoNNSWv5PJVZK7XyMe73s+G9F5iieHElS4YMXR
	 +v6YqsdkTaYQMkPOM/ZPUw07r76iq7R3l9xa4cv/yKN2i7J4P9DpZpRbFa1nArF2iA
	 LPgJ9tKgtSLFAMV2LLOsGTeOnMJ5n3zE3xwZUjoXYcvOIotyaUVsm7uV0uE06H0eyb
	 Xpvc8FVqlV5xQ==
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
Subject: [GIT PULL] Rust fixes for 6.18
Date: Wed,  5 Nov 2025 15:54:06 +0100
Message-ID: <20251105145406.33929-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust.

They have been only one round in linux-next.

I may have another one later in the cycle.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 6146a0f1dfae5d37442a9ddcba012add260bceb0:

  Linux 6.18-rc4 (2025-11-02 11:28:02 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.18

for you to fetch changes up to 789521b4717fd6bd85164ba5c131f621a79c9736:

  rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0 (2025-11-04 19:11:39 +0100)

----------------------------------------------------------------
Rust fixes for v6.18

Toolchain and infrastructure:

  - Fix/workaround a couple Rust 1.91.0 build issues when sanitizers are
    enabled due to extra checking performed by the compiler and an
    upstream issue already fixed for Rust 1.93.0.

  - Fix future Rust 1.93.0 builds by supporting the stabilized name for
    the 'no-jump-tables' flag.

  - Fix a couple private/broken intra-doc links uncovered by the future
    move of pin-init to 'syn'.

----------------------------------------------------------------
Miguel Ojeda (5):
      rust: devres: fix private intra-doc link
      rust: condvar: fix broken intra-doc link
      rust: kbuild: treat `build_error` and `rustdoc` as kernel objects
      rust: kbuild: workaround `rustdoc` doctests modifier bug
      rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0

 arch/loongarch/Makefile     |  2 +-
 arch/x86/Makefile           |  2 +-
 rust/Makefile               | 15 ++++++++++++++-
 rust/kernel/devres.rs       |  2 +-
 rust/kernel/sync/condvar.rs |  2 +-
 5 files changed, 18 insertions(+), 5 deletions(-)

