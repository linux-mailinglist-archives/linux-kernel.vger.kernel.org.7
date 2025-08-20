Return-Path: <linux-kernel+bounces-778221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1158B2E2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954917A5487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9C33437D;
	Wed, 20 Aug 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efkcIbsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3232779F;
	Wed, 20 Aug 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708886; cv=none; b=bzHYc5uTXGJvdRN25w7Zgx3p5qoqJ+2DHKog1REYxIiYMTHBJf42+uMFl4+NcU0xYwbzDvGx/7yrZeM0fd9O7syeghvDR9MP54sl4QkUhcGBj+7pO6qggz6CoJUD0eJTMP8jti5MabFt72nkIOKXYfE60Z7oy2XcnK/Oj+kYe/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708886; c=relaxed/simple;
	bh=b9CAtiZGBAUeN5c+6dFLuwunLd2TUSqw9oj3uDrZk+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QvgozZNRA6tocnc2+Y/wxn+h/ieTLCOkjt6IL6dErAsY/ezCv2HDih3k2SscS4w4EzMhRpmufow2drBDrwy/3ZbKGNO11QN4ot1J63FmeONnZafmgNLcdrlxSFgBxsEwHCsf0zym//L8QQZjpHn1jTlRrIL7uu7HHUuw13NBT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efkcIbsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633D2C4CEE7;
	Wed, 20 Aug 2025 16:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755708885;
	bh=b9CAtiZGBAUeN5c+6dFLuwunLd2TUSqw9oj3uDrZk+A=;
	h=From:To:Cc:Subject:Date:From;
	b=efkcIbsEZN5VVyNd/Of+mSW2lBg8/dHdvid6nUnUWwGwitIwzilF++86qyFBNLW2n
	 d8SXO1tm9XUoBXvN0eSksq/bXtnoB/XcCa3h/8s+JC2Z8xjgmE75zVEqfSZqTx+IQT
	 KPZhF4VRridBxRkcwNYQ4vBjYp5vvJTAV160pDXBydXhSIvdRcjbZiaLrWgP0Xlnyy
	 ygDOaQka1Ym+JGH1uEPVQWaXqxv0cY6KIQrzxvinblkKJKc2EzS2Jy/wrNjc8zWaaX
	 oHso1agr5mPD5o+hiNnOi90Gy62zEFH5GkFWRtkVguFqI4pbjtnq/nlsTgytmnj3J7
	 u+m7vnFdF9EAQ==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	abdiel.janulgue@gmail.com,
	acourbot@nvidia.com,
	jgg@ziepe.ca,
	lyude@redhat.com,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/5] Rust infrastructure for sg_table and scatterlist
Date: Wed, 20 Aug 2025 18:52:54 +0200
Message-ID: <20250820165431.170195-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provides abstractions for struct sg_table and struct
scatterlist.

Abdiel and me agreed for me to take over his previous iterations on this topic.
I decided to send my patches as a new series rather than as a subsequent version
of Abdiel's previous iterations, since the changes I made turned out to be much
closer to a full rewrite.

The most notable differences in design are:

  - SGTable utilizes BorrowedPage, AsPageIter and VmallocPageIter from my patch
    series in [1].

  -  SGTable is a transparent wrapper over either struct Owned<P> (where P is
     the provider of the backing pages) or struct Borrowed, which by itself is a
     transparent wrapper over Opaque<bindings::sg_table>, i.e. either
     SGTable<Owned<P>> or just SGTable (which is equivalent to
     SGTable<Borrowed>.

     - `SGTable<Owned<P>>`: Represents a table whose resources are fully managed
       by Rust. It takes ownership of a page provider `P`, allocates the
       underlying `struct sg_table`, maps it for DMA, and handles all cleanup
       automatically upon drop. The DMA mapping's lifetime is tied to the
       associated device using `Devres`, ensuring it is correctly unmapped
       before the device is unbound.

     - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation of an
       externally managed `struct sg_table`. It is created from a raw pointer
       using `SGTable::as_ref()` and provides a lifetime-bound reference
       (`&'a SGTable`) for operations like iteration.

     - As a consequence, a borrowed SG table can be created with
       SGTable::as_ref(), which returns a &'a SGTable, just like similar
       existing abstractions.

       An owned SGTable is created with SGTable::new(), which returns an
       impl PinInit<SGTable<Owned<P>>, Error>, such that it can be initialized
       directly within existing private data memory allocations while providing
       the required pin guarantees.

  - SGTable<Owned<P>> uses an inner type Devres<DmaMapSgt> to ensure that the
    DMA mapping can't out-live device unbind.

  - SGTable<Owned<P>> uses pin-init for initialization.

This patch series depends on [1] (branch containing the patches in [2]). A
branch containing this series (including dependencies) can be found in [3];
Abdiel's latest series can be found in [4].

[1] https://lore.kernel.org/rust-for-linux/20250820145434.94745-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=page-iter
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=scatterlist
[4] https://lore.kernel.org/lkml/20250718103359.1026240-1-abdiel.janulgue@gmail.com/

Changes in v2:
  - Switch to an enum impl for DmaDirection utilizing compile time boundary
    checks.
  - Add missing Send/ Sync impls.
  - Rename as_ref() to from_raw().
  - Add a bunch of inline annotations.
  - Add a patch to introduce a typedef for dma_addr_t.
  - Let dma_len() return ResourceSize.
  - Add addional invariant to DmaMapSgt.
  - In RawSGTable::new(), pass pages as mutable slice reference.
  - Avoid casts when deriving max_segment in Owned::new().

Danilo Krummrich (5):
  rust: dma: implement DataDirection
  rust: dma: add type alias for bindings::dma_addr_t
  rust: scatterlist: Add type-state abstraction for sg_table
  samples: rust: dma: add sample code for SGTable
  MAINTAINERS: rust: dma: add scatterlist files

 MAINTAINERS                     |   4 +-
 drivers/gpu/nova-core/falcon.rs |   4 +-
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  24 ++
 rust/kernel/dma.rs              |  86 +++++-
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 475 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  35 ++-
 9 files changed, 615 insertions(+), 16 deletions(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 27941214d368f3c17ed26a72662fc453bcc81b9d
-- 
2.50.1


