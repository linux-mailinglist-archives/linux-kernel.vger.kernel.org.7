Return-Path: <linux-kernel+bounces-731931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C2B05D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0074A120A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21E92E7BD3;
	Tue, 15 Jul 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMSztChe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB642E4991;
	Tue, 15 Jul 2025 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586369; cv=none; b=eC74ZVEUEjus7cyWIpf1bRIyQhtGt63ip/anQ8RMVA33x5gJGovp2pxG4u2VROw3srGnXdPJ5wIf/JFUv0EfFoBdjCZ1ppj55zhL0H5BKLTuuDotD14dgks9NM8pAetFXDm5BccRIoChU63835ZpSgAOr2UNEtcLsSc8OUgTui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586369; c=relaxed/simple;
	bh=Z+gZfl6gp7rtHC+Srr8siWFBIRE/edCp3oceobQTq4Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From; b=pg07MEuFYeWr2rbQqvM6Bbkv0d08qzvatFsTwf3XiPwyhhSKqO0AwXSlVPjmnEYYRD+50Tp4P1O+6Kr3RMc4B1VAIQzvKmRm9s+dxPlvgXyby4WWULa3TyvIVXvmMVAWxM1Vc/rtsC16uPLld3mJznDHY9jCMVL7FT+BrYjdfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMSztChe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEE7C4CEE3;
	Tue, 15 Jul 2025 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752586368;
	bh=Z+gZfl6gp7rtHC+Srr8siWFBIRE/edCp3oceobQTq4Q=;
	h=Date:Subject:Cc:To:From:From;
	b=TMSztCheFvZFsnv/Rwcw09SFMupU7BiI8zntI6y84Pea+uCjFuDcuu/Ij1NzII9ZJ
	 Ypzb/PCaxcdzXJSyrUXnmjdDIRZu5BXYbLM1XS6nc8B+WPqDbfw0UyqB+bE2AqOJ3y
	 kQ02r3s+gGxb+9A+kt8Um+uGYfqWctb/41qqc+AyMgixvbXbRTGNuTx2vcZ+fJDaQ6
	 BkR9tMGTY89wmREpxYSThmrHAbORB7O7lkDN/dahulGfQS6sikuIwVPiKyhviqKNpO
	 wTeRt+oDk8oJqn8q9P5kYotxmtA4TRJfRrUNM8/v6neFg0B4kpgnbVRA9GNzezNIKK
	 I20B7lZYg84/w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 15:32:44 +0200
Message-Id: <DBCO0KQERIT5.GS89BZ9LY4TM@kernel.org>
Subject: [GIT PULL] Rust ALLOC & DMA for v6.17
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
X-Mailer: aerc 0.20.1

Hi Miguel,

Please pull the following ALLOC & DMA changes.

All commits have been in linux-next for a couple of weeks. I did a test mer=
ge
without any conflicts.

- Danilo

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/alloc-next-v6.17-2025-07=
-15

for you to fetch changes up to d49ac7744f578bcc8708a845cce24d3b91f86260:

  MAINTAINERS: add mm folks as reviewers to rust alloc (2025-07-09 16:01:17=
 +0200)

----------------------------------------------------------------
Alloc & DMA changes for v6.17

Box:
  - Implement Borrow / BorrowMut for Box<T, A>.

Vec:
  - Implement Default for Vec<T, A>.

  - Implement Borrow / BorrowMut for Vec<T, A>.

DMA:
  - Clarify wording and be consistent in 'coherent' nomenclature.

  - Convert the read!() / write!() macros to return a Result.

  - Add as_slice() / write() methods in CoherentAllocation.

  - Fix doc-comment of dma_handle().

  - Expose count() and size() in CoherentAllocation and add the
    corresponding type invariants.

  - Implement CoherentAllocation::dma_handle_with_offset().

  - Require mutable reference for as_slice_mut() and write().

- Add Vlastimil Babka, Liam R. Howlett, Uladzislau Rezki and Lorenzo Stoake=
s
  as reviewers (thanks everyone).

----------------------------------------------------------------
Abdiel Janulgue (3):
      rust: dma: clarify wording and be consistent in `coherent` nomenclatu=
re
      rust: dma: convert the read/write macros to return Result
      rust: dma: add as_slice/write functions for CoherentAllocation

Alexandre Courbot (5):
      rust: alloc: implement `Borrow` and `BorrowMut` for `Vec`
      rust: alloc: implement `Borrow` and `BorrowMut` for `KBox`
      rust: dma: fix doc-comment of dma_handle()
      rust: dma: expose the count and size of CoherentAllocation
      rust: dma: add dma_handle_with_offset method to CoherentAllocation

Alice Ryhl (1):
      rust: vec: impl Default for Vec with any allocator

Danilo Krummrich (2):
      Merge tag 'topic/dma-features-2025-06-23' into alloc-next
      rust: dma: require mutable reference for as_slice_mut() and write()

Lorenzo Stoakes (1):
      MAINTAINERS: add mm folks as reviewers to rust alloc

 MAINTAINERS               |   4 +++
 rust/kernel/alloc/kbox.rs |  57 +++++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs |  55 ++++++++++++++++++++++++++++++++++-
 rust/kernel/dma.rs        | 199 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------=
----------
 samples/rust/rust_dma.rs  |  28 +++++++++---------
 5 files changed, 295 insertions(+), 48 deletions(-)

