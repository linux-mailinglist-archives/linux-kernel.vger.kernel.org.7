Return-Path: <linux-kernel+bounces-751523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E960B16A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ADCC3B7624
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174D23B60E;
	Thu, 31 Jul 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SoQOXwF5"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9723C514
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930307; cv=none; b=miCvllbwEl8a1krkpDsVZH7rUi53Z14r597vSUNuKTLGwQH6CHjh+9cLCz93gkT01yfQzDtcMxBhugmZLmJAMaFQM/IkM/iXfEADtGCem4K7FdIqJEMvU/XfSw7m4z4OiKgboAOS3s9P4JnxOTM/AYn9KclTf8guNEEr8HMq14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930307; c=relaxed/simple;
	bh=RDlfNfQEHhiICjk1uvGjpCw6/n4I2MukkpEFDaUNPdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G83vV69E0YCTqqEuOlZTVudNKX28p1L7hwYYPMYRmH52+m7Pzi+F9j7pG3wOHuTBhWx8bx4dbzeFnqgNk84fsnEmvxCQT5aNvc2YiHuQEipfO9pITsYCD1D86Kxc9ta5VXf9xlvpcusYfECz1IrVe6n3xjNG1yrQRtbpKuHRhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SoQOXwF5; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753930303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWVEKjQhtRSvkjvWgOZqR1GFKXNm3YpoxK5+J0Ifg7w=;
	b=SoQOXwF5nEytYZZuLlDZQn3YAZXDsEjvEtKLZ/R87bb3J5OP1zpN3c9h5mbVLemitBTyl+
	iw8Dm/HGe0dfravTXtAlMSnF/gfZ/eLewnKktx31XPqxdckK6F0vVAYZAM/Eja0RhxyvYi
	kAYnNr0Fkfp/hcitcbrAZRnj3vVrb3E=
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
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH v7 3/3] rust: alloc: kvec: simplify KUnit test module name to "rust_kvec"
Date: Thu, 31 Jul 2025 10:50:07 +0800
Message-ID: <4eb554c3bf03dd4f9e6dea659497938baab61dba.1753929369.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1753929369.git.zhuhui@kylinos.cn>
References: <cover.1753929369.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

Remove redundant "_kunit" suffix from test module name.

The naming is now consistent with other Rust components as the test
context is already implied by the #[kunit_tests] macro and test module
location.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 rust/kernel/alloc/kvec.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index f57e08c64929..d71f6a1513e2 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -1311,7 +1311,7 @@ fn drop(&mut self) {
     }
 }
 
-#[macros::kunit_tests(rust_kvec_kunit)]
+#[macros::kunit_tests(rust_kvec)]
 mod tests {
     use super::*;
     use crate::prelude::*;
-- 
2.43.0


