Return-Path: <linux-kernel+bounces-791261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CD2B3B41F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E381A581920
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A2235057;
	Fri, 29 Aug 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="apDgEv3l";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="cXOKDVYl"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D654279
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451903; cv=none; b=sI52h46QrfkIZLcEfZjtVF3DxiISuxc0wuDf7fxhnmmyBdhY/F3+LzegF/qc1JA/e+3bUxeTANvbe8RXQY5mIEXZC8nAThAQoSUN0dZ2U/YxB2V6xADd+gQkQSF2F1cvFjMQnL1y3PJ5vZqn0kB/RS62g33wuyEP77Siw/4XXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451903; c=relaxed/simple;
	bh=qzl/6sy8OVffzxtl8FMD/NNTrKt229GDFr99TgraCLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewq9gJBOQ/aFThBgnzkr08jqg75/5zjO0fDrAapIGMYODB3lCGz2orI/iWJnTSVXldzRjYhlr4p5r9ThWqpNCXOVcw2oEFGa1GF7WB+S8zxJVNebNHHl4sMka0m2GtrMpd8IxUof/7ds9MBILmjOKDzSb+kMCp+xobwHwyp1rXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=apDgEv3l; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=cXOKDVYl; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756451900; x=1757056700;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=JIj8SIbtAgtpy0p9VklqThtQxV6/s8k0YSWKmDTTMMA=;
	b=apDgEv3lhMuPlcRQ1NhVoYp8wX175iTZBNHvVtxmNQOLwePO8EppFq1p+eu/Ig3v8bKtBWAaI8djc
	 v4zB2A6Uzfq2mzyqhosRL+SR/NSqRqiT8CNVD0xnucex8oILQNpB25mI3tuxpf2DDESNCZ5xGdYQ6i
	 kgqzV9pObhLI759vb1SDzLUBGA9VIwjrVR74o4dDg4AFXeZW43UO53KKb2DBuYnn0lX/fia2vXGV/I
	 d42L3mfagyX4OHHpdqdq6dP+OaAQ/gpYZWjBQP/3BcGY2A1EYwydiWTzqHcZKNf8DuMb9+5AJ62Ntu
	 EdZM7OS3FAlxM52jnzMR6pwZ7+JGMJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756451900; x=1757056700;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=JIj8SIbtAgtpy0p9VklqThtQxV6/s8k0YSWKmDTTMMA=;
	b=cXOKDVYlm/PRDmxYuD+0ykRgCvcBbCb/JB7u4uqebxbesDEr/Cuid7qmtMDVZ5CS5yIZagW19rypJ
	 EoDdWbCCg==
X-HalOne-ID: 5560e6fc-84a8-11f0-8d86-fb5fec76084d
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 5560e6fc-84a8-11f0-8d86-fb5fec76084d;
	Fri, 29 Aug 2025 07:18:19 +0000 (UTC)
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
Subject: [PATCH v5 1/2] rust: alloc: add from_raw method to Flags
Date: Fri, 29 Aug 2025 09:18:14 +0200
Message-Id: <20250829071814.1973188-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250829071709.1973086-1-vitaly.wool@konsulko.se>
References: <20250829071709.1973086-1-vitaly.wool@konsulko.se>
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
 rust/kernel/alloc.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index b39c279236f5..0c839813a15d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -41,6 +41,13 @@
 pub struct Flags(u32);
 
 impl Flags {
+    /// Create `Flags` from the raw representation.
+    ///
+    /// `f` must be a valid combination of GFP flags.
+    pub(crate) fn from_raw(f: u32) -> Self {
+        Self(f)
+    }
+
     /// Get the raw representation of this flag.
     pub(crate) fn as_raw(self) -> u32 {
         self.0
-- 
2.39.2


