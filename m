Return-Path: <linux-kernel+bounces-790074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EEB39F08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147515625E2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E81553A3;
	Thu, 28 Aug 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdV7FcHT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DC1A5B8B;
	Thu, 28 Aug 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388016; cv=none; b=EMCOx4GoV9v4ecIWlkOfsRbUesjET6Sn19WaaVSGgLL3YswmDfa7o0fEHglWP4svDT5QddpLLJ7ShlxlPtS9dpZxyF7Scqi9mCZRtBo2ISalTOgsr/+cZQRwbbJylL0l/t0qkQP1LJzFDYMpMcsjaiV1fXY6vD1egfpixQPsSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388016; c=relaxed/simple;
	bh=ga4Ux0R5ONIeG/iiK0Aw2LdpzlpRzO8yJNQLxCZ/VX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz7tDntxHm7d0Nt6Wg9Wzq6daTh54FICJj9oOYvvrB5tgGGjDKPY5YuvFQypNaChgjxC+5qe2O6SaFMBL8apIqNpJg4l5Qg/m7n2bJrhnC47mEl3d91VXY6cexROfX7VaK/RyIjbjBqHWmZoQOqf981glxs7S/mpovQIA/mxTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdV7FcHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453FC4CEEB;
	Thu, 28 Aug 2025 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756388015;
	bh=ga4Ux0R5ONIeG/iiK0Aw2LdpzlpRzO8yJNQLxCZ/VX4=;
	h=From:To:Cc:Subject:Date:From;
	b=cdV7FcHTSbpvmJ1DOJ24V71SFT9yAokqO9bn8hX1RfuY753PHzgShqwSDvdzxmCsa
	 CSF8Xi3dfq1y9wcn9jJ6ZNjzZF4+BpaH9q5GTmZEG1LQYFsyPFHqkfukoiZy2zImEE
	 pFFH8+GauwaFMVZ8CvYi0n8u0JOp+/cdkpDbSFZxYA0NTTqyXlPLBdEQVlOQDcapGE
	 H85CZfI/LkxLThKqtAd0X4hHYuRgec5g3JJ9D+wFoo7q9wD/L3LYVl6a7jYgImxYeP
	 Nh2AusuS9e0YBvtIMGgdEopZWNIE7m6dVWMAJGFPsVto0K7dJVU59Tp3YH+CEAuaky
	 95OSN13vHxy4Q==
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
Subject: [PATCH v4 0/5] Rust infrastructure for sg_table and scatterlist
Date: Thu, 28 Aug 2025 15:32:13 +0200
Message-ID: <20250828133323.53311-1-dakr@kernel.org>
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

Changes in v4:
  - Replace "type state" leftovers.
  - Add a brief explanation to RawSGTable.
  - Mention "no interior mutability" in Sync safety comments.
  - Add safety requirement to RawSGTable::new().
  - Don't use pin-init for RawSGTable itself.

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
 rust/kernel/scatterlist.rs      | 491 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  35 ++-
 9 files changed, 631 insertions(+), 16 deletions(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: 27941214d368f3c17ed26a72662fc453bcc81b9d
-- 
2.51.0


