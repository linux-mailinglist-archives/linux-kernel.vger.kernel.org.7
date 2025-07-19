Return-Path: <linux-kernel+bounces-737684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3CB0AF54
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFF168219
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC212376FC;
	Sat, 19 Jul 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+zmVadh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68488148838;
	Sat, 19 Jul 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921106; cv=none; b=AYK2t9NRIrsY0+M6nEJbRG6fpykiolPBvPXZVwuAhrEW7TK4L1PKAUFu7NaKT9z3rvjI9Udj7Ip0Tr/sNzgOY0U2YOEKHa6uiF8+KDlTOpmmG3EW9vpnOdeJ69b3yPTJ+29W5nQ5OQk9vFeGLrkCyeAtiw5H0v7NIayp9oRyaZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921106; c=relaxed/simple;
	bh=izNdIcFuvOrLt6cxGef2sjtELlmOZjtN6nfYIH9IpwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/nhfho2wPHlSzPD+49mxyF9cvfjy/XCbdJma8/fDaUHgcGEandEwno9BeOWXwbdx3fXbvygnAxDFxq8cavcA7sGIoA7MX8ASBEk3EXFY70r5EHChtUZrLHApDQTYdQIx8DyUCNNgisfYr4Eo+A3CZXZ3IH2gXA4OrsttliLcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+zmVadh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06242C4CEE3;
	Sat, 19 Jul 2025 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752921105;
	bh=izNdIcFuvOrLt6cxGef2sjtELlmOZjtN6nfYIH9IpwI=;
	h=From:To:Cc:Subject:Date:From;
	b=p+zmVadhbTztJUOub3K++IayOI4UT5PuQX8+RF0022o3gNzwsSr0+Ylbj+wPE+dC7
	 zzE2i7zo+Zxay3OE1ltJprr1PkpaTBgQpXFSfConxYQI/KXSXMW4xb14fhiGxxwKND
	 Gz8H4W7QpBCCouHv+HHQobr0YRRg8iBbQouDxCU5F4zYtwEEistAkqnJXAgatCgOQI
	 0SUBFVkctKMOaoqCBHNjfF+l0F/27+4omGiNSjTjWOtV42z+/NSWDql+VwNyass7Xo
	 U0jAZpX9vF01qk9/oaRCxCrxBUtaWURiAeoByi7TU7KNe3ZfSrbWIqwEUaibLZB3st
	 v5b2KtqcqEgMQ==
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
Subject: [GIT PULL] Rust fixes for 6.16 (2nd)
Date: Sat, 19 Jul 2025 12:31:09 +0200
Message-ID: <20250719103109.155136-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust (second round).

All commits have been in linux-next for four rounds.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.16-2

for you to fetch changes up to 7498159226772d66f150dd406be462d75964a366:

  rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0 (2025-07-14 23:30:44 +0200)

----------------------------------------------------------------
Rust fixes for v6.16 (2nd)

Toolchain and infrastructure:

 - Fix build and modpost confusion for the upcoming Rust 1.89.0 release.

 - Clean objtool warning for the upcoming Rust 1.89.0 release by adding
   one more noreturn function.

'kernel' crate:

 - Fix build error when using generics in the 'try_{,pin_}init!' macros.

----------------------------------------------------------------
Janne Grunau (1):
      rust: init: Fix generics in *_init! macros

Miguel Ojeda (2):
      objtool/rust: add one more `noreturn` Rust function for Rust 1.89.0
      rust: use `#[used(compiler)]` to fix build and `modpost` with Rust >= 1.89.0

 rust/Makefile           |  1 +
 rust/kernel/firmware.rs |  2 +-
 rust/kernel/init.rs     |  8 ++++----
 rust/kernel/kunit.rs    |  2 +-
 rust/kernel/lib.rs      |  3 +++
 rust/macros/module.rs   | 10 +++++-----
 scripts/Makefile.build  |  3 ++-
 tools/objtool/check.c   |  1 +
 8 files changed, 18 insertions(+), 12 deletions(-)

