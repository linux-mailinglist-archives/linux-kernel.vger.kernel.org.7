Return-Path: <linux-kernel+bounces-783046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14739B328AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EF35E0670
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5506259CBD;
	Sat, 23 Aug 2025 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="Klob4DAx";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="bxvj28n8"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11B273F9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954316; cv=none; b=IKwtKZSETImPjmNcjXcN1AxbZ89EZP/UPd+KrmgPL/I1SRjsgsfLlSawvkFmJNiBL3w7D5UOuMf2NqIMiI5gKevfejZxgIzWIqxcrrzbeRkq5EHzoqE7MOO/HwKaThC2hDT1XiPOaCS+9gEkkEkioA2xHbd4LJtLSiCBDOq2d9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954316; c=relaxed/simple;
	bh=o5bZS0Hn/0GBTVwtul/CtIWHIi0vIDxEqADoLYYjauU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ni9dxTEzdP5FBuoWXAFeEQ0Z29n71JTGMUHdmqCM2cv/QIBhJT9Pylo6BNiedvZLr+ffcHAbAlfjZNQTkVbOfY7xNzH9iPwM3zUihWJWH/pBzxT7u8r5i8FtwvyXqjGTFbZCkpHvlns+8fGNuTQ5v1cUj25j36gMwRWHHMdDqSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=Klob4DAx; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=bxvj28n8; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954313; x=1756559113;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=5/+5QaPnbawAB9+9CprgOyXuWrPA3BDw+ITmY3eFxYI=;
	b=Klob4DAx9tUzA2YL0N54l5w43RiBgkpJvmvNrJD2E/AMyubgG628hbNU0XsILyRhobocK6l16eUEs
	 7r7dNgZAACwG6D/d/X3sYcuTDVc8WO76dM5bCKIsBfUCOvrONEFZeSC3joCzDB8y5x3oDfvsiIZ9uV
	 1JiLZ2hjrDAxiBs1mn42nXj1kOs0PSr81w/IKTJqzsUABcd7TGod1NTM21K6ydHEELtzY8v+GYiSN+
	 L1KBMK205AsZmZLv8J4SgPzbZjCPtwwztH2BjXIyaIHa8kBw3qnhiI4n+UfSfp9ApJnUY7Sa0t8D5r
	 AQ5Mn35vDcjB9JGtMUgbHM/f/KY4DNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755954313; x=1756559113;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=5/+5QaPnbawAB9+9CprgOyXuWrPA3BDw+ITmY3eFxYI=;
	b=bxvj28n8v53SeZTzpDLY4K5hgIa2b/hVHYJ3/EfptsPSWYr6r0UG+GcYg5BGQ6YMb08PqbLlKdiMs
	 6cYSDvgDg==
X-HalOne-ID: cd25f38d-8021-11f0-a170-494313b7f784
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id cd25f38d-8021-11f0-a170-494313b7f784;
	Sat, 23 Aug 2025 13:05:12 +0000 (UTC)
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
Subject: [PATCH v4 1/2] rust: alloc: add from_raw method to Flags
Date: Sat, 23 Aug 2025 15:05:08 +0200
Message-Id: <20250823130508.867235-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250823130420.867133-1-vitaly.wool@konsulko.se>
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to be able to create Flags from its raw representation as u32
to properly map zpool C API into Rust. This patch adds from_raw method
to Flags and makes it crate private.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
 rust/kernel/alloc.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index b39c279236f5..808bd4281164 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -41,6 +41,11 @@
 pub struct Flags(u32);
 
 impl Flags {
+    /// Create from the raw representation
+    pub(crate) fn from_raw(f: u32) -> Self {
+        Self(f)
+    }
+
     /// Get the raw representation of this flag.
     pub(crate) fn as_raw(self) -> u32 {
         self.0
-- 
2.39.2


