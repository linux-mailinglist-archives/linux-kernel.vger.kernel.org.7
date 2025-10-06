Return-Path: <linux-kernel+bounces-843226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B401BBEADC
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F42A18973B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0730D2DE704;
	Mon,  6 Oct 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="GmphZBoX"
Received: from forward206d.mail.yandex.net (forward206d.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D151E98F3;
	Mon,  6 Oct 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768778; cv=none; b=pFFLU48wZASWUfTscn79hr55zKmQfdRmKQ62i/Of+/T8RjBiIgYxgIPBmBZyxxwJ4lyBC0j656P2B94E8LCuMUKAW0TausocAr0eGzOPJdaJLPZtjDFTpvCWCpyludXPkeEUYr51ZveM7eHC+y23+2vUEZ39Hqj75k63sRhi/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768778; c=relaxed/simple;
	bh=JUSnWyLOB4Y3CkxaXpFFOkLJpwZSX0Z/YxSqkPIVmTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILMcCxLwvYs8DQgcFDjw1gMcZStUtJ7ZiBCEkXRdtohaRHqzscdZuK7Lw1+kLeXw3iqyH5Cbqjsl+xbNzIFqseE+c/foXEOD1L0BujTGWr7NnmiM+quJWdUDWoGMTy1LMG4BkJ/IE0PjMCuUKmCRx1R68j48IOd4PjVgCn0cYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=GmphZBoX; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward206d.mail.yandex.net (Yandex) with ESMTPS id 2DFFD81721;
	Mon, 06 Oct 2025 19:31:30 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 5A1BAC0020;
	Mon, 06 Oct 2025 19:31:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QUnb3i1LqqM0-s618dfjU;
	Mon, 06 Oct 2025 19:31:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759768281;
	bh=h9w3fGruuyxxZovTmUnVz6z/ZezxkUgog/9KTM7sRNU=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=GmphZBoXYH9ubVCL6t9of4gE+XoksrljirMXhAB0YFCLv6t4utL7plpArSomgu0wa
	 qoXwyM6xLdQBtwYHtDf+go1iyADqQstbG+qXGZ/FBpNtcOFKtq/6hy9Dr+NLZQ9zGv
	 u9/aP+i/L94WR/e1Kgm1j5k0gP3lHFuOrl5UL4rY=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	corbet@lwn.net,
	lyude@redhat.com,
	linux-doc@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 1/3] rust: xarray: abstract `xa_alloc`
Date: Mon,  6 Oct 2025 19:30:22 +0300
Message-ID: <20251006163024.18473-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006163024.18473-1-work@onurozkan.dev>
References: <20251006163024.18473-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implements `alloc` function to `XArray<T>` that wraps
`xa_alloc` safely.

Resolves a task from the nova/core task list under the "XArray
bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
file.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/xarray.rs | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index a49d6db28845..1b882cd2f58b 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -266,6 +266,45 @@ pub fn store(
             Ok(unsafe { T::try_from_foreign(old) })
         }
     }
+
+    /// Allocates an empty slot within the given limit range and stores `value` there.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the allocated id.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn alloc(
+        &mut self,
+        limit: bindings::xa_limit,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<u32, StoreError<T>> {
+        build_assert!(
+            T::FOREIGN_ALIGN >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+
+        let new = value.into_foreign();
+        let mut id: u32 = 0;
+
+        // SAFETY:
+        // - `self.xa.xa` is valid by the type invariant.
+        // - `new` came from `T::into_foreign`.
+        let ret =
+            unsafe { bindings::__xa_alloc(self.xa.xa.get(), &mut id, new, limit, gfp.as_raw()) };
+
+        if ret < 0 {
+            // SAFETY: `__xa_alloc` doesn't take ownership on error.
+            let value = unsafe { T::from_foreign(new) };
+            return Err(StoreError {
+                value,
+                error: Error::from_errno(ret),
+            });
+        }
+
+        Ok(id)
+    }
 }

 // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
--
2.51.0


