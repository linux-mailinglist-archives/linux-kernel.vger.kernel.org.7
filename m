Return-Path: <linux-kernel+bounces-772282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2875B290B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 23:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B602AA1E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71E21FF48;
	Sat, 16 Aug 2025 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/ihQXqu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAA72614;
	Sat, 16 Aug 2025 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755380758; cv=none; b=pg7uKiJ0TZ0nbZnWllZO+vkFNZo8hW+QHDUJrJZaXP2xdz+uA/ItPsbe+cmeXjDTKfBOi00AyPgt2PqJcHCvMpGAB5rWdjJjsicoR4zsBo0lHpL79bQN6Wd5vpJPLHhYyr6gB62bPudFnNa70htjyLPTCO5xaI8PfepjT7O+dQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755380758; c=relaxed/simple;
	bh=XNmCpz+qTJMlbgXL45hQVb6txNHF2K6d6OOnSyKNEJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdzte8N4p8C2hNQb/5a7fu0gmMt5RMmIFLlT00JSfpyytrVH+2zradUmzG6dZAgOdGinGc9xNi8cieb0xfUTghMgkpBMVS8QmUc3alaOJYTF1Xc+7v7Oj7H+2cbZI1XV63F8rKGeIjRmyUgJ0RwGJ1BluE4+AXa3bB81L/53tKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/ihQXqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19467C4CEEF;
	Sat, 16 Aug 2025 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755380758;
	bh=XNmCpz+qTJMlbgXL45hQVb6txNHF2K6d6OOnSyKNEJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=R/ihQXqukr7zFynvfGMJ4P/UXlMNc99CBW1IlhNYLjmYRaRcuiQ4IuTZ4uAUVO0FQ
	 sR6Vau+wX/tIipUixcji7Rg/0qrLE/6ahKyY4MLgA3sS3eAjdxaDG8RRG/4Rllczge
	 0DZdr9INLpfThgbuTUoAOKjFiTZP/YE21vnO5gv0P8Gbz9wfvUQ8q8f3cnJnU56imq
	 kpw4bTWqks/GOoNHQFsV2MqhkZABV7uLDLPqTUmEuQ0AFYPdLfgXoShZY1mK3GHlXI
	 IM2q9q+i+RVZs+ATH9hlSJr17Ac0C+rRAb5OBh57lKZC6C+Wx4IW1TaavD8IK3RAdN
	 ItpF/JgnKljYw==
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
Subject: [GIT PULL] Rust fixes for 6.17
Date: Sat, 16 Aug 2025 23:45:34 +0200
Message-ID: <20250816214534.2736622-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these fixes for Rust.

They have been only three rounds in linux-next. They are not urgent so
it would not hurt leaving them there for a few more days.

I may have a few more later in the cycle.

No conflicts expected.

Thanks!

Cheers,
Miguel

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux.git tags/rust-fixes-6.17

for you to fetch changes up to 252fea131e15aba2cd487119d1a8f546471199e2:

  rust: kbuild: clean output before running `rustdoc` (2025-08-12 21:10:50 +0200)

----------------------------------------------------------------
Rust fixes for v6.17

Toolchain and infrastructure:

  - Workaround 'rustdoc' target modifiers bug in Rust >= 1.88.0. It will
    be fixed in Rust 1.90.0 (expected 2025-09-18).

  - Clean 'rustdoc' output before running it to avoid confusing the tool
    when files from previous versions remain.

----------------------------------------------------------------
Miguel Ojeda (2):
      rust: workaround `rustdoc` target modifiers bug
      rust: kbuild: clean output before running `rustdoc`

 rust/Makefile | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

