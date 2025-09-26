Return-Path: <linux-kernel+bounces-834257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250D9BA446B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77A777A2191
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6021581EE;
	Fri, 26 Sep 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfmuP/OO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604518EAB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897932; cv=none; b=YRzCbrhCzmCWAtOMYgE1SQ4n/WJ5lTnDVlLrs3NIvaaNHpQ9Ldi1coV/kJ9g70/5VQrRP2Mt0E2WzwGDdvWbdltYka18CwWDN51EXXnTpfp9qBWOaLmzD2Gc7JnOV4B0R8OtaPZVNQIfG/56Rkp4sQro5glPBiwJUo5Yy+ohAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897932; c=relaxed/simple;
	bh=g4pU1woDSzu6mtGDlhD/Rbuub0cyYAVp77nzYSrP5vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I4pL8Bjm/WmPeyW57zUSSm7qV6HK4QQiZJBJN79jEROslGtbm3wuvEEJyDdjyNZPfPH1jGoTA4MsWDHuTkKyzPoAFchJYCW7qFrfdcejl70XX98nErMnK/0utPIPDCuPEjEgOYVgbbT3I0SDRIJ/cErNvGiRJQ1hpmxvZVebakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfmuP/OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A2C113CF;
	Fri, 26 Sep 2025 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758897931;
	bh=g4pU1woDSzu6mtGDlhD/Rbuub0cyYAVp77nzYSrP5vQ=;
	h=Date:From:To:Cc:Subject:From;
	b=JfmuP/OOHM1aY7r/c2XLshxDRkH8LnJRfxuYko/K8Xep2etWmPiWAU1JEPifZRs5B
	 3xlq7/PvjLycaXYGURI2IKxyc2RXjRS284njWDDnuecyow/+5pHSFQO/yFFmix8MBO
	 Exv9eT7Fhpd86iebZTPRxT9UBG7okBvonPuR4vN2OlOLGv2PI1M4BmQoq9IpfzDVAN
	 5Q6SXhyOQzVux2zYTYcyYFLVUoY++O65oZtl0pblYatHdKNgS5x4A7Yutz3vDZCIPe
	 YfFTngzPl6H58OlREJiF9Bnu9x1zKaQ3MPkG2jMwznUygC0SB0AIirpoLXfUtX90ts
	 S8zS7k9pGOZMw==
Date: Fri, 26 Sep 2025 16:45:25 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>, Uros Bizjak <ubizjak@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Gary Guo <gary@garyguo.net>
Subject: [GIT PULL] locking changes for v6.18
Message-ID: <aNanBZ9VbIO2CO9x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest locking/core Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2025-09-26

   # HEAD: 17d9f8eaa87d40a2ff66598875a43363e37a909b MAINTAINERS: update atomic infrastructure entry to include Rust

Locking updates for v6.16 mostly include Rust runtime enhancements:

 - Add initial support for generic LKMM atomic variables in Rust. (Boqun Feng)
 - Add the wrapper for `refcount_t` in Rust. (Gary Guo)
 - Make `data` in `Lock` structurally pinned. (Daniel Almeida)
 - Add a new reviewer, Gary Guo.

 Thanks,

	Ingo

------------------>
Boqun Feng (9):
      rust: Introduce atomic API helpers
      rust: sync: Add basic atomic operation mapping framework
      rust: sync: atomic: Add ordering annotation types
      rust: sync: atomic: Add generic atomics
      rust: sync: atomic: Add atomic {cmp,}xchg operations
      rust: sync: atomic: Add the framework of arithmetic operations
      rust: sync: atomic: Add Atomic<u{32,64}>
      rust: sync: atomic: Add Atomic<{usize,isize}>
      rust: sync: Add memory barriers

Gary Guo (5):
      rust: implement `kernel::sync::Refcount`
      rust: make `Arc::into_unique_or_drop` associated function
      rust: convert `Arc` to use `Refcount`
      rust: block: convert `block::mq` to use `Refcount`
      MAINTAINERS: update atomic infrastructure entry to include Rust


 MAINTAINERS                               |    6 +-
 rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++++++++++
 rust/helpers/barrier.c                    |   18 +
 rust/helpers/helpers.c                    |    2 +
 rust/helpers/refcount.c                   |   10 +
 rust/kernel/block/mq/operations.rs        |    7 +-
 rust/kernel/block/mq/request.rs           |   73 +-
 rust/kernel/sync.rs                       |    4 +
 rust/kernel/sync/arc.rs                   |   55 +-
 rust/kernel/sync/atomic.rs                |  551 +++++++++++++++
 rust/kernel/sync/atomic/internal.rs       |  265 ++++++++
 rust/kernel/sync/atomic/ordering.rs       |  104 +++
 rust/kernel/sync/atomic/predefine.rs      |  169 +++++
 rust/kernel/sync/barrier.rs               |   61 ++
 rust/kernel/sync/refcount.rs              |  113 ++++
 scripts/atomic/gen-atomics.sh             |    1 +
 scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
 17 files changed, 2454 insertions(+), 92 deletions(-)
 create mode 100644 rust/helpers/atomic.c
 create mode 100644 rust/helpers/barrier.c
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/internal.rs
 create mode 100644 rust/kernel/sync/atomic/ordering.rs
 create mode 100644 rust/kernel/sync/atomic/predefine.rs
 create mode 100644 rust/kernel/sync/barrier.rs
 create mode 100644 rust/kernel/sync/refcount.rs
 create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh

