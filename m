Return-Path: <linux-kernel+bounces-720233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBCAFB8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5137D1AA0D67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3F221D87;
	Mon,  7 Jul 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="SgO+096u";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="djzzTuqt"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63C41C84C6
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906890; cv=none; b=mFVOQcWZ/TR5bkog5QDQ+mt3xFcaSV+XQDE0252uKG58CW/fMO7wNQqs3VH2Gt6UXVrfY9rCkaAVCe0a4Rl8i6w/rtJE2OZo5bVvFVNoObmOxvu0Rh0JHKptfFSFXG42EF3SpMd19/qHuF1Dzpz7ZFvJ8upBDr5MrGT3tn/8z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906890; c=relaxed/simple;
	bh=9YAHoAQC9II/WUl8ghxse7lomOpGWi15/QDsTz10xhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nonJG5hmPSikED6M0u2dSt+eYxjBKZFpbcLpRX/bxBYj5rINL/rhWaWtaaYN0ZXQbeBoQM1qdFX1G1JzEDp/w2TxpbQJv5xgSUBsbtppOdmhUzUOqKzLlkax1uCh36mVRGu1I7RTGtHA6NUu1cg4b6JSqFfW1xr1Fcbed6BmeWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=SgO+096u; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=djzzTuqt; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751906879; x=1752511679;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=mdqPDHemg+/vhl4rLlsYuKkgf9Pz8c5juqrYGtBQxpE=;
	b=SgO+096uu5w0zT5AIQRx1FBCL2qKxLN6tyaO7xSJ5+7+nueH7f9gjQO7CPEh6qjrSKLR/hsQmje4k
	 XmGl7Ss595KeUmtb2mWi3hUX8HLfKusB5pPbRWpWmxZQK3JGbK/Ggq9cnwX4DOB7IP64A8V4+O7T9U
	 Fh2CCBafpkrftmtKEPbwxjke2B9rmFsZuFOaBzUqk6krQkzeYh754366WPHFy9jf8pgBrNB7pHY2Qo
	 1UlzLnppYq3N6HjCQKXx2ZOqEAUXm4tVWc/eUQ6p8XWftqp7UfVk1bo5jwTTLw4A6fhzJAccFl0bnK
	 ZIhnRaLQsFUiAzWZjxwYzGncVZHStPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751906879; x=1752511679;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=mdqPDHemg+/vhl4rLlsYuKkgf9Pz8c5juqrYGtBQxpE=;
	b=djzzTuqtkiGl3OgcJVq+qD67+Q57UMMbVj1oJn5cKMEfZY6rVDq4K2k2jqaHFq4pUjeroFOXGOjou
	 Lkufr6DCw==
X-HalOne-ID: 23151964-5b52-11f0-b337-c9fa7b04d629
Received: from localhost.localdomain (host-90-238-19-233.mobileonline.telia.com [90.238.19.233])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 23151964-5b52-11f0-b337-c9fa7b04d629;
	Mon, 07 Jul 2025 16:47:59 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	rust-for-linux@vger.kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v11 0/4] support large align and nid in Rust allocators
Date: Mon,  7 Jul 2025 18:47:55 +0200
Message-Id: <20250707164755.631374-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coming patches provide the ability for Rust allocators to set
NUMA node and large alignment.

Changelog:
v2 -> v3:
* fixed the build breakage for non-MMU configs
v3 -> v4:
* added NUMA node support for k[v]realloc (patch #2)
* removed extra logic in Rust helpers
* patch for Rust allocators split into 2 (align: patch #3 and
  NUMA ids: patch #4)
v4 -> v5:
* reworked NUMA node support for k[v]realloc for all 3 <alloc>_node
  functions to have the same signature
* all 3 <alloc>_node slab/vmalloc functions now support alignment
  specification
* Rust helpers are extended with new functions, the old ones are left
  intact
* Rust support for NUMA nodes comes first now (as patch #3)
v5 -> v6:
* added <alloc>_node_align functions to keep the existing interfaces
  intact
* clearer separation for Rust support of MUNA ids and large alignments
v6 -> v7:
* NUMA identifier as a new Rust type (NumaNode)
* better documentation for changed and new functions and constants
v7 -> v8:
* removed NumaError
* small cleanups per reviewers' comments
v8 -> v9:
* realloc functions can now reallocate memory for a different NUMA
  node
* better comments/explanations in the Rust part
v9 -> v10:
* refined behavior when memory is being reallocated for a different
  NUMA node, comments added
* cleanups in the Rust part, rustfmt ran
* typos corrected
v10 -> v11:
* added documentation for the NO_NODE constant
* added node parameter to Allocator's alloc/realloc instead of adding
  separate alloc_node resp. realloc_node functions, modified users of
  alloc/realloc in accordance with that

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

