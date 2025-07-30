Return-Path: <linux-kernel+bounces-750141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E3B157D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4286A3BDF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1F11DE891;
	Wed, 30 Jul 2025 03:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D3wEZuTI"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0A18DB27
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753846624; cv=none; b=HaNtWX8qXR/fHfpcQMswvWCPSE5w7HQVsfXEIwAzE2M5XEr3JUqcN3yolXCm9R+IuA5WsoUusW0UewvBaywn664lhZTMlkOxyJVQqhFizwLgik5in5H4yhB/+UT/JaaFD5t0hJWzxRA1SS0Eq6ZpVhnSSTPn70yKCVGFP/DsyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753846624; c=relaxed/simple;
	bh=zGY2jdf4vwNGy2jL8S1laYHDpWXAZd61lFxoeC07tZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCR2mZQ+X/TAB8JjZ76sFhb/VN+FNeEsqnJAGemIV1m2J3FMJibXsgNN5p+sUf+6FmJJsVQ2xYUojzef5kYIkRPg7qrYJ8iPyFFOKTpdmkLqHEw9ct9N5XcCYAuuZDo8YzOOqWJohEjPEgkq/Y2LlPsCBiaEcf/kX5hYZDEtXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D3wEZuTI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753846610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYjDc48syFzuGpanzRl9N75Vx1E8TRBTq1YggaL7ywY=;
	b=D3wEZuTIVeX67M8CGioaiYgUvCyaJV/2Kbb/eLQYdKuV/auXmX0CKozKB3WMVnpycU03m4
	2Z6X7IHEl2WC3xB9z3jXbV8hJOCr1bc/qMCLvucWWhT29/0BXmE8odndBXOPDSEwkzqJGF
	Ff5bayx2a5QKi8bLw7jKUBfZWVspVTA=
From: Hui Zhu <hui.zhu@linux.dev>
To: Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	vitaly.wool@konsulko.se
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v6 0/2] rust: alloc: kvec doc example and allocator unit tests
Date: Wed, 30 Jul 2025 11:35:20 +0800
Message-ID: <cover.1753841900.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This patchset adds KUnit tests for allocator alignment
guarantees and improves kvec documentation.

Patch 1 adds KUnit tests for verifying alignment guarantees
in Rust kernel allocators. Tests cover Kmalloc, Vmalloc
and KVmalloc with both standard (128B) and large page-aligned
(8192B) allocations.

Patch 2 adds a practical usage example for KVec::as_slice
method, showing how to create KVec, push elements and convert
to a slice.

Both patches are co-developed with Geliang Tang. Based on [1].
Tested on x86_64 using KUnit.

Changelog:
v6:
According to the comments of Danilo, updated test for allocator.rs
and allocator rebase onto [1].
v5:
According to the comments of Danilo, change to use generic struct and
allocator Generics in allocator.rs.
v4:
According to the comments of, add the error check for push.
v3:
According to the comments of Danilo and Boqun, move KVec test to doc
example and move VBox to allocator unit tests.
v2:
According to the comments of Danilo, updated the commit to samples the
usage of VBox and KVec.

[1] https://lore.kernel.org/lkml/20250715135645.2230065-1-vitaly.wool@konsulko.se/

Hui Zhu (2):
  rust: allocator: add KUnit tests for alignment guarantees
  rust: alloc: kvec: add doc example for as_slice method

 rust/kernel/alloc/allocator.rs | 56 ++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs      | 10 ++++++
 2 files changed, 66 insertions(+)

-- 
2.43.0


