Return-Path: <linux-kernel+bounces-745352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED3B118D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0489E4E155D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C225286D46;
	Fri, 25 Jul 2025 07:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XfvyqF0f"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8477323D280
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753426966; cv=none; b=EcMykbg94EPHpWFP/S8aj4ue5yl8ic/7SazM1b1ZVB80aVhCKNiPWzmPMxX1HDdfTtdne3fVYa8WCVDJ/yPZxtIyMUcrDMzyZj/XXuC3BofgetQFGn8uzGuC5wwxKFudn6g8ecBY+zJwaA78ixIoyK8W9eTQVNV/9Nl5CuHkNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753426966; c=relaxed/simple;
	bh=/0ZaeKflkYoUnjPEWmw5DzEKj3MPpiESTUxu+5rJyEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uj+3gPUkoanE6usIQYNarLAsFcGs3MzWYS8vFwdOBWNN3ghx3RVuceO08CAd3rie90JzcELmp/9eA/KQJmEGNyV5kRPOAC8FZi3K7kjQUTf9aVuh0zm1xq3Ae+X7EMCeldP7UrpavmSepeamDaafXPoIHiLcvqN2AzAeo2F17dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XfvyqF0f; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753426961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=41UniJ+34Rp0qyLnwuIJ1xf6VMhgDx8mSKviyXrmgjc=;
	b=XfvyqF0fh+7xqQHYW8iguQvn8S8UOVJVJaWe6dxOfLdHCy7QZ6DV5XNNjqptpS1qVVlcHQ
	9NS97tns1E1NWzg7J1IKcQ3kvlZnD6qFAmqE6FePERzvlaMKzMoJxtFEBWtNtJCQ/44n2z
	jcWoWS/N0WGUhOxV5Y1OSKP47yiZBNU=
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
Subject: [PATCH v5 0/2] rust: alloc: kvec doc example and allocator unit tests
Date: Fri, 25 Jul 2025 15:02:19 +0800
Message-Id: <cover.1753423953.git.zhuhui@kylinos.cn>
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

Patch 1 adds KUnit tests for alignment guarantees in Rust allocators.
Validates kmalloc handling of standard (128B) and page-size (8KB)
alignments.
Confirms vmalloc/kvmalloc reject oversized alignment requests.
Ensures Rust allocators respect kernel allocation constraints.

Patch 2 improves the documentation for KVec::as_slice() by adding a
code example. This shows how to use the method with push operations and
assertions.

Both patches are co-developed with Geliang Tang. Tested on x86_64 using
KUnit.

Changelog:
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

Hui Zhu (2):
  rust: allocator: add KUnit tests for alignment guarantees
  rust: alloc: kvec: add doc example for as_slice method

 rust/kernel/alloc/allocator.rs | 58 ++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs      | 10 ++++++
 2 files changed, 68 insertions(+)

-- 
2.43.0


