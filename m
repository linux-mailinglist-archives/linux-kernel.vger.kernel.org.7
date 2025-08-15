Return-Path: <linux-kernel+bounces-771254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B2B284BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E33B666AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1891E304BDA;
	Fri, 15 Aug 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck8DlEiw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275B304BC1;
	Fri, 15 Aug 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277870; cv=none; b=Igv+jVDsVMPLiXJGPu5ER2eDXsBUndAXWAe4xhQbYtDepfBlerDYA6Z2uKIkmCZC55b4Fb995an2pyQdtQg9ancdS83HPm8+v5KbFR+X35/0n9z+Gwys9y6vgFsvkZXIytxrGb6Wbrfu6m9JIQbpNtNDd52lcIxVnWSAmSugUuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277870; c=relaxed/simple;
	bh=CZCB9C4OC01lRaJnY1+mbzNcaU4SLBsIwe2LGd1+qkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1um+wnizT5k7ifQXetwh17qesnnCHJjSmVjVgpXgtg7svMgxSLSfUntiOCkyklaf1U//Ya2EDOueVR+I/aWiCecmoLMj40j9ca8c3zZYtYVbi8ZxI/bGmElDv2rRAaSNT2Ae6somA+dnu/3amXEuQxJcq4XmaQPSaCy5T/zXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck8DlEiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D882C4CEEB;
	Fri, 15 Aug 2025 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755277870;
	bh=CZCB9C4OC01lRaJnY1+mbzNcaU4SLBsIwe2LGd1+qkI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ck8DlEiwIAMpZsKHxE9x2OD45YbpJgT7BAGZbyEnvLhafVZxG6grzCRsvDRnutSQq
	 5dzApt+oMDlmQT6XLnHVmfU1339H1mQ62OGpYg+mA1uBy120koCBbLhLh9M6WORFbn
	 KeQQBv0eEcOXpX33/RHflxAWkjXuVE18aMP2cr/qpdO6j9IrOhDJfcwoti1qWRstTY
	 IxCu5hWynaJNlSOhDLk24ZeOtZ51xojdTRlSIZh1EOkaHCXZDaea0r2HxsCS40ANXL
	 x7Tff1uwLiobSmOcQFHvo9q0LS6x/wrpIP0IwGw8LEpplstXPOUm7KaPyH1jSddTtr
	 dI/gZ/ROgH71g==
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
Subject: [PATCH 0/4] Rust infrastructure for sg_table and scatterlist
Date: Fri, 15 Aug 2025 19:10:01 +0200
Message-ID: <20250815171058.299270-1-dakr@kernel.org>
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

[1] https://lore.kernel.org/rust-for-linux/20250814093427.19629-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=page-iter
[3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=scatterlist
[4] https://lore.kernel.org/lkml/20250718103359.1026240-1-abdiel.janulgue@gmail.com/

Danilo Krummrich (4):
  rust: dma: implement DataDirection
  rust: scatterlist: Add type-state abstraction for sg_table
  samples: rust: dma: add sample code for SGTable
  MAINTAINERS: rust: dma: add scatterlist files

 MAINTAINERS                     |   4 +-
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/scatterlist.c      |  24 ++
 rust/kernel/dma.rs              |  41 +++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/scatterlist.rs      | 433 ++++++++++++++++++++++++++++++++
 samples/rust/rust_dma.rs        |  35 ++-
 8 files changed, 530 insertions(+), 10 deletions(-)
 create mode 100644 rust/helpers/scatterlist.c
 create mode 100644 rust/kernel/scatterlist.rs


base-commit: a66548bf306b60441ed2ea6b034a0cd69f464e74
-- 
2.50.1


