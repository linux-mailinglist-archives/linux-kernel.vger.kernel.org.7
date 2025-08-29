Return-Path: <linux-kernel+bounces-791260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB503B3B41D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804C63BEF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D201DC075;
	Fri, 29 Aug 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="qglSs33k";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="HrLnCpRQ"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83913FC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451863; cv=none; b=Q5JhCXZpTrGfy1e6wjEhd5GuIiSIUPtTpZeWbV0NuVMP3EA0YMehcAkLSC56oUt+Mtn+U9ZvtlwfX2jwXIFRacvwZ2UQWNmu0/2uI9qRIBGX++TnBeJjzNW1TLv2tZmxqKir90PX9zMXqzda18lUoTCWgHRBFJFce5H6Kavvpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451863; c=relaxed/simple;
	bh=6WSROdcVqcZo7x2Y2xNEChYddvOxeR9+jCq4zSApPnQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n+V7HeBphvR6HN1UNq5q8SX5g9nZeYd/gNW6RUsw248pLn4wizdONNhNqVxUm3kVus8Gkmgs/KyaPzHAOiH8TyvMzj3plD22hd08mnLNmYmCSaC8PnPPJwnx6VkjvgKktJIlMwu7FYe9RFs3jDlv4CJssFaTe0T5Ng0e1m7kRHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=qglSs33k; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=HrLnCpRQ; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756451853; x=1757056653;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=vNSad52aBrW/gbkd9CRAeWQXdQBZ237EXpTRnMLWU/0=;
	b=qglSs33kjKLVStmyCTImUb3HM1CVAO1GdmLl4a7I+RqoWe2lcOvnsWIBih85REuY4FHlJ/OFuqY1p
	 mEZPE9Zko8zLlgfBXZgWiFfLTtYveJne9T3MZhN5Y4AGy7IjGQACD98UQEHB84+b8lH4MqNa3VkKAc
	 8zxkl46I5NkY1/QQvJYGrUJSJ7mtXLcDc9lHV4fGtpCOB59dBus2oFs6Y9oJNYw9FhCSvpshslH4RB
	 46PcMYY1B6jMaHIy8JAhrLxapabwP5aofmbrCp0TrPrRR4NlS26DzMmTYLlAgZ78spcmb4o0+9hzn8
	 M3TU+GOlMQl2tYNovy601LRob4Zu7dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756451853; x=1757056653;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=vNSad52aBrW/gbkd9CRAeWQXdQBZ237EXpTRnMLWU/0=;
	b=HrLnCpRQI3jFYuLAMCltoTf6/IViB3Rydh7f9UKA47DxyYUsZaUINxTN/LCvf1nZwOkIN+KfLrRpJ
	 68fEI/xDg==
X-HalOne-ID: 3a975893-84a8-11f0-8b9a-c9fa7b04d629
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 3a975893-84a8-11f0-8b9a-c9fa7b04d629;
	Fri, 29 Aug 2025 07:17:32 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v5 0/2] rust: zpool: add abstraction for zpool drivers
Date: Fri, 29 Aug 2025 09:17:09 +0200
Message-Id: <20250829071709.1973086-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zpool is a common frontend for memory storage pool implementations.
These pools are typically used to store compressed memory objects,
e. g. for Zswap, the lightweight compressed cache for swap pages.

This patch provides the interface to use Zpool in Rust kernel code,
thus enabling Rust implementations of Zpool allocators for arbitrary
Zpool users.

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
* new files added to MAINTAINERS
---
 MAINTAINERS                     |    2 
 rust/bindings/bindings_helper.h |    1 
 rust/helpers/helpers.c          |    1 
 rust/helpers/zpool.c            |    8 +
 rust/kernel/alloc.rs            |    7 +
 rust/kernel/lib.rs              |    2 
 rust/kernel/zpool.rs            |  377 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 398 insertions(+)

