Return-Path: <linux-kernel+bounces-743721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3D0B1026C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B201F5465DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499227056D;
	Thu, 24 Jul 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o69N/2u0"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF626F45D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753343684; cv=none; b=ApvBHhcF6PqvRHXqc0zmcWjlvx5jF53dCmSR0SOjgq3qVVTL7wGLnTs8Dv7kqzl5UX0A1s4DMbnpv0vYREJninbecNNxahuGfGM5Q1qih5mgqhiq3o+RwKN1tj58rOyQQXgyNQ6gjo8WWlrVMe7EJsBdOlu0e9xZNi+2d82O3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753343684; c=relaxed/simple;
	bh=ACD2zYINIxgfFz8EBjJPvfzFI6fX2nmWkQaGYNKCjrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rib4uJKeG1RK+2IuW9xebIQVFm9nJ3CxoEgA8tGdPnkS+6qeptJzwBwQx9VjW38LIjTkO5jmqFuoTzxoVlSj7SGFePoPHMPilC03paqWScszbC3smmMAZ+B04778tk1IW+/G51q6cAF68Ss44U5H7u0t8M5MAV6Y/wZnLdbivU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o69N/2u0; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753343679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oGI12C/lmT3zYBkqkvKfsU15BIp6uudBd0KMDRTc1F0=;
	b=o69N/2u0jEFLyQQV1rkIL1dCnLMulYl6OorLIqUadUK/3KzuSJRUO+oQmdh36y6fgO9lLZ
	xbN+oJki6gAddRVxAZTO8Wv56LV7PvVXSWQ+H8anIRWbex5QFo68QqiNME9IGjq3UlCWjg
	M2m2p1kvG/4ZlIYOqRzzk+/PnDx/pjM=
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
	linux-kernel@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH v3 0/2] rust: alloc: kvec doc example and allocator unit tests
Date: Thu, 24 Jul 2025 15:54:17 +0800
Message-Id: <cover.1753339262.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series includes two Rust patches:

Patch 1 adds KUnit tests for Rust allocation wrappers (kmalloc, vmalloc,
kvmalloc). It covers basic allocations, large alignments, and checks for
expected failures. Each test verifies content integrity through byte
pattern checks.

Patch 2 improves the documentation for `KVec::as_slice()` by adding a
code example. This shows how to use the method with push operations and
assertions.

Both patches are co-developed with Geliang Tang. Tested on x86_64 using
KUnit.

Changelog:
v3:
According to the comments of Danilo and Boqun, move KVec test to doc
example and move VBox to allocator unit tests.
v2:
According to the comments of Danilo, updated the commit to samples the
usage of VBox and KVec.

Hui Zhu (2):
  rust: allocator: add unit tests of kmalloc, vmalloc and kvmalloc
  rust: alloc: kvec: add doc example for `as_slice` method

 rust/kernel/alloc/allocator.rs | 57 ++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs      |  9 ++++++
 2 files changed, 66 insertions(+)

-- 
2.43.0


