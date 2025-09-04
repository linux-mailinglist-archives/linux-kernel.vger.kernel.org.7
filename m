Return-Path: <linux-kernel+bounces-801394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA57B4448B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4BA02038
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F2311C3D;
	Thu,  4 Sep 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AE6uX0MQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773E30E85F;
	Thu,  4 Sep 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007508; cv=none; b=gb8lTORNDNEORSVXNJbQ7RZSh1OCpJh9oXLdLAQIW4M8NNpK25uvvK8OQon4Z1220EM3KAEqrnDgabGMJt77F4nyYIyaHF/w4Sq0hfK0xiz1VGWwBJNMnPLgtBciYiMXHteGzb65sDcseWYiWh777sc/koyrGY4IVq3ABu6K9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007508; c=relaxed/simple;
	bh=ClxexQ/a7OST66iIxAo1C/n96JM3lKGXw0eScg5CJnc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version; b=i17z4eCOpYOVBUeuuuKwKIaetpjPDY/060x3qMdic8lhrMH6+J9SrDlhwcgv3IdEw9A0kph67hBIYn9mOAI3t+oTbZ27s4mtVFOlSH0qbmWlhVyo0xZsslXKNPDL5Aj5caFQ0StSmANJtQUtDPfsYQl3QVLu2VUtBMqRngRScGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AE6uX0MQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32304C4CEF0;
	Thu,  4 Sep 2025 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007508;
	bh=ClxexQ/a7OST66iIxAo1C/n96JM3lKGXw0eScg5CJnc=;
	h=Date:Subject:Cc:To:From:From;
	b=AE6uX0MQ/CDEUz2/O6RbIDRhFdUsiR8rImcO+/U/NBhW+NP2WG8A0/kud2WlSnDc1
	 Y1STxwBnZacJ3uEABFuadV64DANlM/KnS+PS4kS12X93pzuRQ8COZGWzIiliN/rGmA
	 H4iMHgmncbs5Exzj8I2qttNlyjWNZ3MKA0lbWv+uRkJrsFfqe8V26bIJmKMqLjSpH7
	 Et06ZHxgxmIIx9cps5hgDYXQFf2aq2t6RqvlfplSwY8eMpn0Yg7sV8vuE4IXSu6glm
	 vDPvojoJD3Q1N3uYbI/nAdr9fW2FMgnyCdDpg+w0bPabqKIuucpCFUGGiRkNcU8hYe
	 UL9QbnL8o2OKw==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 19:38:23 +0200
Message-Id: <DCK76G2JH58W.1QPN6YHTEOABB@kernel.org>
Subject: [GIT PULL] Rust ALLOC & DMA for v6.18
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Vlastimil Babka"
 <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Miguel Ojeda" <ojeda@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.20.1

Hi Miguel,

Please pull the following ALLOC & DMA changes.

All commits have been in linux-next for a couple of weeks. There are two tr=
ivial
conflicts with the -mm and Linus' tree [1][2].

Some patches that would usually go through this tree went through the -mm t=
ree
[3][4]; [5] and [6] go through drm-rust together with their first user -- o=
ne
minor import conflict in samples/rust/rust_dma.rs expected.

- Danilo

[1] https://lore.kernel.org/all/20250818122053.355aab17@canb.auug.org.au/
[2] https://lore.kernel.org/all/20250826173041.3140da7b@canb.auug.org.au/
[3] https://lore.kernel.org/all/20250806124034.1724515-1-vitaly.wool@konsul=
ko.se/
[4] https://lore.kernel.org/all/d2e3d6454c1435713be0fe3c0dc444d2c60bba51.17=
53929369.git.zhuhui@kylinos.cn/
[5] https://lore.kernel.org/all/20250820145434.94745-1-dakr@kernel.org/
[6] https://lore.kernel.org/all/20250828133323.53311-1-dakr@kernel.org/

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/alloc-next-v6.18-2025-09=
-04

for you to fetch changes up to fe927defbb4f31c15a52f0372d7f5d608f161086:

  rust: alloc: remove `allocator_test` (2025-08-24 15:30:40 +0200)

----------------------------------------------------------------
Alloc & DMA changes for v6.18

Allocator:
  - Provide information about the minimum alignment guarantees of
    Kmalloc, Vmalloc and KVmalloc.
  - Take minimum alignment guarantees of allocators for ForeignOwnable
    into account.
  - Remove the `allocator_test` incl. `Cmalloc`.

Box:
  - Implement Box::pin_slice(), which constructs a pinned slice of
    elements.

Vec:
  - Simplify KUnit test module name to "rust_kvec".
  - Add doc-test for Vec::as_slice().
  - Constify various methods.

DMA:
  - Update ARef and AlwaysRefCounted imports.

MISC:
  - Remove support for unused host `#[test]`s.
  - Constify ArrayLayout::new_unchecked().

----------------------------------------------------------------
Alice Ryhl (3):
      rust: alloc: specify the minimum alignment of each allocator
      rust: alloc: take the allocator into account for FOREIGN_ALIGN
      rust: alloc: implement Box::pin_slice()

Danilo Krummrich (1):
      rust: alloc: add ARCH_KMALLOC_MINALIGN to bindgen blocklist

Hui Zhu (2):
      rust: alloc: kvec: add doc example for as_slice method
      rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"

Miguel Ojeda (2):
      rust: kernel: remove support for unused host `#[test]`s
      rust: alloc: remove `allocator_test`

Onur =C3=96zkan (2):
      rust: make `ArrayLayout::new_unchecked` a `const fn`
      rust: make `kvec::Vec` functions `const fn`

Shankari Anand (1):
      rust: dma: Update ARef and AlwaysRefCounted imports from sync::aref

 rust/Makefile                       |   9 +--------
 rust/bindgen_parameters             |   1 +
 rust/bindings/bindings_helper.h     |   1 +
 rust/kernel/alloc.rs                |  15 ++++++++-------
 rust/kernel/alloc/allocator.rs      |   8 ++++++++
 rust/kernel/alloc/allocator_test.rs | 113 --------------------------------=
---------------------------------------------------------------------------=
------
 rust/kernel/alloc/kbox.rs           |  90 ++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 rust/kernel/alloc/kvec.rs           |  22 ++++++++++++++++------
 rust/kernel/alloc/layout.rs         |   2 +-
 rust/kernel/dma.rs                  |   2 +-
 rust/kernel/error.rs                |   4 ++--
 rust/kernel/lib.rs                  |   2 +-
 rust/kernel/sync/arc.rs             |   6 +++---
 samples/rust/rust_dma.rs            |   2 +-
 14 files changed, 130 insertions(+), 147 deletions(-)
 delete mode 100644 rust/kernel/alloc/allocator_test.rs

