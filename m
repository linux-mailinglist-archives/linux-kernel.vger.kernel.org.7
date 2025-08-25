Return-Path: <linux-kernel+bounces-784748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4E4B340A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1952080C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50C271A9D;
	Mon, 25 Aug 2025 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRS8/5RB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76DEEBD;
	Mon, 25 Aug 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128351; cv=none; b=NzH4z5/V/Wf5iox5o9S4czKmDVONel8PgZBgM+FhAwRuPRKtFGsg0qQJKmR71AjdwkSWF1XI6kucNvI37Af6oOAetjahu5PKbKEcbqJZfqhOkb7LlXUHu5egUv2wwsuIarLc+E/ht7f58hrjSOq1vgd+5OdYn1M/bmB2NiIpM3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128351; c=relaxed/simple;
	bh=kTLOg8ZWto7m4mLxe3AMRggh4mVgO3Q/TaPM5uD+Fa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACKIvHdPssDR4TKnWXQUiWWZPEcFjgAw9KW1lbtWcp+7K6HSkgf5ds3rIx+O+Wb6Dv2ePSB9SZyZZaxlvg6fxOCBiF8EAob1x2vdo2IaKkv73G4cX7H8ZoWBdjK20+lMm25LQLci8HgC2Z/eBlly/P0YNG/V+06fNAzHpCXw7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRS8/5RB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3730DC4CEED;
	Mon, 25 Aug 2025 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128350;
	bh=kTLOg8ZWto7m4mLxe3AMRggh4mVgO3Q/TaPM5uD+Fa4=;
	h=From:To:Cc:Subject:Date:From;
	b=eRS8/5RBrkmW1JVlyTssz8GFTmNDzM5Cfat2ufG9o4tAdw8dHVJ2YeBtwmNb/j8Ab
	 GawlVhwR4vXYIY3QrF+b8wuwqoq/cdNDMIbnHi97Ya/FItCXFqppqWH5ybHlsQs/KV
	 VHACZPA9epVDycTbA6G2GiuHY71vQEekp+59zUE6kwgPGBCGxO9qf4vMfYLAUJrZct
	 6s33uiHJ5AsErD49EjQAtChFTbm6ACI71R5ICsgtrmW0iEV8G2KlTugQDV1XRr595w
	 nlTi1iRSggXkZMUS4WMxFWQdow1jsF0qyPvVyyG+NMsL7JhJU1A/1SbwM/uAhOs2Ev
	 e+MjmDn9c3PHA==
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
Subject: [PATCH v3 0/5] Rust infrastructure for sg_table and scatterlist
Date: Mon, 25 Aug 2025 15:24:39 +0200
Message-ID: <20250825132539.122412-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
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
       using `SGTable::from_raw()` and provides a lifetime-bound reference
       (`&'a SGTable`) for operations like iteration.

     - As a consequence, a borrowed SG table can be created with
       SGTable::from_raw(), which returns a &'a SGTable, just like similar
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

Changes in v3:
  - Beautify max_segment assignment code.
  - Rename DmaMapSg to DmaMappedSg and improve documentation.
  - Rename SGTable::as_iter() into SGTable::iter() and remove IntoIterator impl.
  - Consider struct sg_table::nents in SGTable::iter() and SGTableIter<'_>.

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
  rust: scatterlist: Add abstraction for sg_table
  samples: rust: dma: add sample code for SGTable
  MAINTAINERS: rust: dma: add scatterlist files

 MAINTAINERS                     |   4 +-
 drivers/gpu/nova-core/falcon.rs |   4 +-
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  24 ++
 rust/kernel/dma.rs              |  86 +++++-
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 483 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  35 ++-
 9 files changed, 623 insertions(+), 16 deletions(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 27941214d368f3c17ed26a72662fc453bcc81b9d
-- 
2.51.0


