Return-Path: <linux-kernel+bounces-751520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D584B16A89
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54765677B1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829B819ABDE;
	Thu, 31 Jul 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dBlg3Dvc"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C98F5E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930290; cv=none; b=V9u8O/CPOjERkEjkW8DgFGpVtOrKLf4fCxsULiqjPl/rUU1EfPUcHS0pv/ooZsmgoazkMdDnealLlZTxz+vP2afCkYLJ2CyrLcqM3YAS1kn+d03m2ARbDWc0WOHApiseACRdP961RfmA82SCdpjIAwtEWlEywikJkndHB7d7Mew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930290; c=relaxed/simple;
	bh=xDLkbDwwbWCUE8AL1uiSSnBvGrDGAEXunwx84niv4/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHjLr5s3x45pB/HfHxt+5925g/aK/qtc+4a4vbpaL6R0Q+H4VIvSYkReWX+Q1Ll4xxUc1WGqWa6R7IgCInjPppSGgTFGEdZJCfR0gSxpmryeIUfmquRP0yHtlvfbEy65hOb47Q9vB4/o7B/v8pw2ARgZr8CPb4DwAnkCCrJKD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dBlg3Dvc; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XBg0b1G1HE6+LGXvHBLHUETYlC3Adb8PV4IOVr0IO+M=;
	b=dBlg3Dvchlfqxynrgw04DJoeIF5JJy3GTFQOZ77ehxG/7DrmTZo9XjznGGNu720gca9sZW
	BV4sKxpCAcl7FsD9w++qU2mCXfFJI355Ig+GDZxwsQVWqHRRrga/ziIp5GBE1wUsf564gH
	LlplbhUs9mHVN0ZMsRaUr4t7UOrsOAw=
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
Subject: [PATCH v7 0/3] Rust allocator and kvec improvements
Date: Thu, 31 Jul 2025 10:50:04 +0800
Message-ID: <cover.1753929369.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series adds tests and docs for Rust kernel components:
Patch 1 adds KUnit tests for allocator alignment guarantees.
Patch 2 documents KVec::as_slice with a usage example.
Patch 3 simplifies KVec test module naming convention.

Both patches are co-developed with Geliang Tang. Based on [1].
Tested on x86_64 using KUnit.

Changelog:
v7:
Updated according to the comments of Miguel.
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

Hui Zhu (3):
  rust: allocator: add KUnit tests for alignment guarantees
  rust: alloc: kvec: add doc example for as_slice method
  rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"

 rust/kernel/alloc/allocator.rs | 56 ++++++++++++++++++++++++++++++++++
 rust/kernel/alloc/kvec.rs      | 12 +++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.43.0


