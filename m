Return-Path: <linux-kernel+bounces-873744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55838C149B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A3F465DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5832E15D;
	Tue, 28 Oct 2025 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W39YBq8g"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE399313E1C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761654201; cv=none; b=Dr1lLJuXa5fphDWyB2fWPJxOlNvQfrOiVm16xQIB4dixBM93DeXxe5/z9gFmaVS4/eK8YyJygo4XLckwESgXi9OMHw5rMNd7XgC93ss/SwZ4LFeMxdYn6AH09DvWbYXXzbSBsZoiop/phB9Fj7fAA+9sD+6O/eWBe+5tcG2CO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761654201; c=relaxed/simple;
	bh=ilXtrzC3TR5zhx7isAOn4iceKAqSG1FEMM/Y2Bz7K1I=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=ASoiLu68spZBdy/vJX+EDudDZLrW6uoJ56GFk7Hc6cMDi9U33udG3Pr8pI+LOvP/Heg8LBiiP4d2ZlRszUCemvskxfZU1iZ6jyCkJQ1frqjKEqozpJiDx1EREh3S5/RTpNRxew1QwHvoEckGfjdpnxIRNBxM74JqkZui+UNlBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=W39YBq8g; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251028122317euoutp021f1d3399f76e0895ce03c2805da0c9f9~ypyiowVyt3173531735euoutp02h
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251028122317euoutp021f1d3399f76e0895ce03c2805da0c9f9~ypyiowVyt3173531735euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761654197;
	bh=S7Qb8GD7QtIdkNg1sJYTbyBiBhynyekDP/0KBPsG5fc=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=W39YBq8gRkSQRtmiqYbhAmCfOap53lZ4hkYWh/z6xZuBhkZ4AR5bJvtKO6Kip+d8h
	 AMu6xTCU4OjpicB+jSJ/h6BmVSExYtvmu5N+KxQwjqGxlcfGSDHesf2OTIOgE/S2MQ
	 6bcTdPwtJmmGqXghLFxtr96X2pbe2jwJcZBY9e8s=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a~ypyh4s3HI0846208462eucas1p2I;
	Tue, 28 Oct 2025 12:23:16 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251028122315eusmtip2aa7fbb6e4d59ddf58d1f0e5dabdc826e~ypyg2_QJ10792007920eusmtip2f;
	Tue, 28 Oct 2025 12:23:15 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 28 Oct 2025 13:22:32 +0100
Subject: [PATCH 1/4] rust: macros: Add support for 'imports_ns' to module!
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pwm_fixes-v1-1-25a532d31998@samsung.com>
In-Reply-To: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,  Danilo Krummrich
	<dakr@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>,  Drew
	Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a
X-EPHeader: CA
X-CMS-RootMailID: 20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
	<CGME20251028122316eucas1p2733987cd4c1eb8f83d6572d542e76d2a@eucas1p2.samsung.com>

Kernel modules that use C symbols exported via `EXPORT_SYMBOL_NS` must
declare this dependency for `modpost` verification. C modules achieve
this by using the `MODULE_IMPORT_NS(NAMESPACE)` macro, which embeds an
`import_ns=<NAMESPACE>` tag into the `.modinfo` section.

The Rust `module!` macro lacked the ability to generate these tags,
resulting in build warnings for Rust drivers (like the PWM driver) that
call namespaced C functions.

Modify the `module!` macro's internal parser (`ModuleInfo`) to accept a
new optional field `imports_ns`, which takes an array of namespace
strings.  Update the code generator (`ModInfoBuilder::emit`) loop to
iterate over these strings and emit the corresponding
`import_ns=<NAMESPACE>` tags into the `.modinfo` section using the
existing `#[link_section]` mechanism.

This provides the necessary infrastructure for Rust modules to correctly
declare their C namespace dependencies.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 rust/macros/module.rs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 5ee54a00c0b65699596e660b2d4d60e64be2a50c..408cd115487514c8be79724d901c676435696376 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -98,6 +98,7 @@ struct ModuleInfo {
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
+    imports_ns: Option<Vec<String>>,
 }
 
 impl ModuleInfo {
@@ -112,6 +113,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             "license",
             "alias",
             "firmware",
+            "imports_ns",
         ];
         const REQUIRED_KEYS: &[&str] = &["type", "name", "license"];
         let mut seen_keys = Vec::new();
@@ -137,6 +139,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
                 "firmware" => info.firmware = Some(expect_string_array(it)),
+                "imports_ns" => info.imports_ns = Some(expect_string_array(it)),
                 _ => panic!("Unknown key \"{key}\". Valid keys are: {EXPECTED_KEYS:?}."),
             }
 
@@ -195,6 +198,11 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             modinfo.emit("firmware", &fw);
         }
     }
+    if let Some(imports) = info.imports_ns {
+        for ns in imports {
+            modinfo.emit("import_ns", &ns);
+        }
+    }
 
     // Built-in modules also export the `file` modinfo string.
     let file =

-- 
2.34.1


