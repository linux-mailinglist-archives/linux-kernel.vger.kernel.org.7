Return-Path: <linux-kernel+bounces-859389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 76916BED7BB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 167FE34C5D4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74C262FCD;
	Sat, 18 Oct 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/OcKtD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BFE170826;
	Sat, 18 Oct 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760812224; cv=none; b=sP4MH4b1d2hal0XbSTb31uzLUoCqDVWHJlvBxJwzm1uehNzp6XE61DuEQhxkAv3LDIW0QiD4Omv2AqCz37MQ6Y1eMGxzp7BgrmKspQep3NO6v0llmh8ZnMEJXwnd3BDWyKFnU7+4BPEJ/X6ZyiV+iUT+hEMPu8jfTWdMZD9hbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760812224; c=relaxed/simple;
	bh=lf6cbneHmqiesjl7ewdIvy6yKCqigDORe3JzbiWkM/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c7rw84g9MRHV06WEnpZVhuhvqszFTrKJ9KZTgiowaQGSQdV/mOCR16U+tPOUJ+JBjICDVUc8uVTq+2avPxEWX/mHin5Xk6ubuDHNcp8K8I75saiOVqcygooio0J4V8cwKbCPOjQNJUjm1LmfZlz8AAa040CIzA6t0Ra4FSU4dVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/OcKtD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB969C4CEF8;
	Sat, 18 Oct 2025 18:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760812223;
	bh=lf6cbneHmqiesjl7ewdIvy6yKCqigDORe3JzbiWkM/U=;
	h=From:To:Cc:Subject:Date:From;
	b=N/OcKtD6MtT/Or0m5tCgPzJ/EmYp7fBrT382b+X4KGlUTWRS6QaZ6QyDE/wz2+9Pb
	 5P3O7AGyE69y2cxcN2uIP/L8KGvL5qXeATCMxXkKRPlsXHl9xFA1ztB6llopGeAoA2
	 JOE5Cd8gvJO5k8YNpJS8t2ymwIBN8HWWQg+SkPrBEzB59DtN8oyIkTzqKENwhOa0uJ
	 aaDS5GCBKVRo3ADEXlveMEWZ/tRO7kZTME13XeWyNu6VTuz/qFE/E0rhiNmFJjkLuh
	 hPTsPSlUBZIdZsMudTjCW3L5gPeqAc60GUI9omjT7jyvDmz/fybRfmXKpaZ3zkS8m1
	 ya0gHQuAUErUQ==
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
Subject: [GIT PULL] Rust 'rustfmt'
Date: Sat, 18 Oct 2025 20:28:00 +0200
Message-ID: <20251018182800.1592965-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This is the PR for:

    https://lore.kernel.org/rust-for-linux/20251010174351.948650-1-ojeda@kernel.org/

It has only been a day in linux-next, but it is trivial. I based this
on a non-tag because there was one more change merged this week.

No conflicts expected. No functional changes intended.

Please pull -- thanks!

Cheers,
Miguel

The following changes since commit 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09:

  Merge tag 'f2fs-fix-6.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2025-10-16 10:58:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-rustfmt

for you to fetch changes up to 1f1d3e1d094db732d22b892227bf1e1ac3a8ca04:

  rust: bitmap: fix formatting (2025-10-17 13:02:22 +0200)

----------------------------------------------------------------
Rust 'rustfmt' cleanup

'rustfmt', by default, formats imports in a way that is prone to
conflicts while merging and rebasing, since in some cases it condenses
several items into the same line.

Document in our guidelines that we will handle this for the moment with
the trailing empty comment workaround and make the tree 'rustfmt'-clean
again.

----------------------------------------------------------------
Miguel Ojeda (4):
      docs: rust: add section on imports formatting
      rust: alloc: employ a trailing comment to keep vertical layout
      rust: cpufreq: fix formatting
      rust: bitmap: fix formatting

 Documentation/rust/coding-guidelines.rst | 75 ++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs                |  2 +-
 rust/kernel/bitmap.rs                    |  8 +++-
 rust/kernel/cpufreq.rs                   |  3 +-
 4 files changed, 83 insertions(+), 5 deletions(-)

