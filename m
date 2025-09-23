Return-Path: <linux-kernel+bounces-828770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8260BB956B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4421D7AAEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15831D72D;
	Tue, 23 Sep 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="On4c/9u6";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Pv1Y85Bb"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEC427B4EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758623192; cv=none; b=RKWcvmFNLF3lYpArirm87hpfq3/DhkdkGbqZCvy0L7USksHB4Pz4o35dzc8vMC56xSLw3TFtfMy9gR1T30tdGjJMra4e9G41NMw/spLEnE+BlF0MYQGQmiOwjJ+KHU/TuV1cgrif3su0Xc1r6ZDoBPs261EcDt7B6woIVZimQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758623192; c=relaxed/simple;
	bh=+6KkPKPpTAxrAvWQ5zev/Zk8mSq4Vaj1I5f+VxwRvwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u3bIJiHvKoqCF1Z6MNGTOLReuKtwnjC8AVL70oiad5jncm6bPwcA70WCMcSNLVSciqjooiigd1BYKIKZO++5iY5Zd+ISBUdb5rztV3R2drXYzFGfK2RzMGH95ucC4VhWR/zvKQAG4+V9mJrWHxQfEKNi4CuD7mqWilDsOBcf+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=On4c/9u6; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Pv1Y85Bb; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1758623181; x=1759227981;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=wdDTHWqIIQrO4Z56Gwoii2btyUPVsS03K4kULpvGLhE=;
	b=On4c/9u6+mPnFx+axc8y1FQ13QoBkGkkSIigzg6s2MTIDFm9fsDApEqNUZL4M1ZYfD5wG5q3UPFsL
	 pbgbYfTjDY9SVqhhGT5go8Jz0MM0JUiezkrDgGZlwAcilwdTnPdo+0IJLVQASqKr8im2fXfSqCNKtC
	 gGjTnjZnPXJO7uxRb3xiOoVdpAQWXohdwazGQpoqtAI0SPjssRvD8vxwQWHhXJIwFyIciYDd/xg630
	 k4uiBtoRn+M+//+DYnS4+UA3mKEjdsQKlPfXD7LZNUXbB62qOKKi2/z/NBPXNbHZ054+QQDs5/a/Ty
	 yMSTDTeJZ5y3y2OP7PnC+3bnVaCy8PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1758623181; x=1759227981;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=wdDTHWqIIQrO4Z56Gwoii2btyUPVsS03K4kULpvGLhE=;
	b=Pv1Y85Bbid3q4EqIpaUuZa0uJ39ubo4f1p3+Tk6z18By/Ib7BfokadvFbtCXPmJh6kSvMB3tNXe1B
	 Akpp2p+Bg==
X-HalOne-ID: bef8abd3-9867-11f0-9446-fb5fec76084d
Received: from localhost.localdomain (host-95-203-13-255.mobileonline.telia.com [95.203.13.255])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id bef8abd3-9867-11f0-9446-fb5fec76084d;
	Tue, 23 Sep 2025 10:26:21 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v6 0/2] rust: zpool: add API for C and Rust
Date: Tue, 23 Sep 2025 12:25:47 +0200
Message-Id: <20250923102547.2545992-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zpool used to be a common frontend for memory storage pool
implementations. With its removal the opportunity to select an
allocation backend for zswap has been completely lost. However, with
the recent advancements in the vmap/vmalloc field that allow for fast
and simple allocation backends, and the initiative to implement one in
Rust, the zpool API is still necessary, though it's enough to have it
as a thin API for compile time backend selection.

This patchset provides such API and implements the interface to use
it in Rust kernel code, thus enabling both C and Rust implementations
of zpool allocators. zsmalloc and documentation are updated
accordingly.

Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
Changelog:
v1 -> v2:
* reworked to stick to the existing Rust driver infrastructure
* removed raw pointers from the Rust API
v2 -> v3:
* detailed safety requirements for unsafe API functions
* removed unwrap()
* some typo corrections
v3 -> v4:
* added a working example of zpool Rust API usage in the
  documentation part
* change to Flags arranged as a separate patch
* improved safety requirements for ZpoolDriver trait
v4 -> v5:
* created a new type ZpoolHandle for handle representation on the
  Rust side
* improved description of Flags::from_raw()
* pool is no more borrowed as mutable for ZpoolDriver::malloc()
* ZpoolDriver::destroy() removed
* improved ZpoolDriver implementation example
* typos/markup corrections
v5 -> v6:
* removed zpool API is partially restored (to the minimal required
  extent)
* no Adapter based runtime registration is necessary
* a Rust macro for compile time registration is introduced instead
---
 Documentation/admin-guide/mm/zswap.rst |   14 +-
 MAINTAINERS                            |    1 
 include/linux/zpool.h                  |   62 ++++++++
 mm/Kconfig                             |   22 ++-
 mm/zsmalloc.c                          |    3 
 mm/zswap.c                             |   30 ++--
 rust/bindings/bindings_helper.h        |    1 
 rust/kernel/lib.rs                     |    2 
 rust/kernel/zpool.rs                   |  366 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 479 insertions(+), 22 deletions(-)


