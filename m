Return-Path: <linux-kernel+bounces-743958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997C6B1063F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65055A3AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D32D0C9C;
	Thu, 24 Jul 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBz2krSQ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8B42D0C7A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349160; cv=none; b=EDjMpKkjsSUFTdkhEFTlGlc+GMB6wJvK5JfPu3tjPb9HESRcuDWJmTpJtP3Yy5cO7Dy5oP+xmH7b/6HVHy4M6VKadwhIkgvAVL6BL6eQ8qNDZoSmFNpE7HLxshAo/2zVnnsBmY/5haVodd2IAfqOB9hjP1WWp8HUb04/nsK5M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349160; c=relaxed/simple;
	bh=Hcncw3LkOjkkPG88myc8s2iTsdVsVypg8XAQoqXjUl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rvtShhX6cgOr08UXqLGz/gGNhdMCNrAeXB6j03zFKlhw+EJxhvLJKb/7WRze35O+1S0CjPxXQdxBOvHC1ieXMaGTK3CMbczrG69jvAhWQOuCDTByufjwFYY+rbPOVpgtqCWTZlgIJC5lU7stM9GDD5krzyNknefmKNIWd0YudYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBz2krSQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753349146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t2EYM/bX0LdPyMUuxH9B+a3i0CJmIUsSrBWdEflzeU0=;
	b=kBz2krSQUY3ZJ1uVteqs7oEYoZLCs28mqHsPS0DiyG9DchLAMDsQlYd2jpKlVGzjXtf/G2
	DGqVZUmRQ0ecS7bhlyUUVcjCbw0U7cTeypnOIsCDptCNUNxbHGWGj6HlI9NW35GESClk+L
	wcXQgor+ObFufd6QoSyfENuEAilgqwQ=
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
Subject: [PATCH v4 0/2] rust: alloc: kvec doc example and allocator unit tests
Date: Thu, 24 Jul 2025 17:25:33 +0800
Message-Id: <cover.1753348867.git.zhuhui@kylinos.cn>
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

Patch 2 improves the documentation for KVec::as_slice() by adding a
code example. This shows how to use the method with push operations and
assertions.

Both patches are co-developed with Geliang Tang. Tested on x86_64 using
KUnit.

Changelog:
v4:
According to the comments of, add the error check for push.
v3:
According to the comments of Danilo and Boqun, move KVec test to doc
example and move VBox to allocator unit tests.
v2:
According to the comments of Danilo, updated the commit to samples the
usage of VBox and KVec.

Hui Zhu (2):
  rust: allocator: add unit tests of kmalloc, vmalloc and kvmalloc
  rust: alloc: kvec: add doc example for as_slice method

 rust/kernel/alloc/allocator.rs | 57 ++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs      | 10 ++++++
 2 files changed, 67 insertions(+)

-- 
2.43.0


