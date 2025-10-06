Return-Path: <linux-kernel+bounces-843225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024BBBEAD6
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F0A1897EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14282DCF71;
	Mon,  6 Oct 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="aIZ4DWJ+"
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7221770A;
	Mon,  6 Oct 2025 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759768777; cv=none; b=ncymU6xv3OO68/0hOnoZOrd94w0OVqK+efRcNcYupx0KTtx3fVZJkOOmyw6AoyquKIXgmHju4Vi+95R7kPr7li38RUvCBUca9lKkfZSGoJhU2/HcNY+YlcHbvNLs2Vl28HSDTTOZbKa+aDOIR77d63z9w0ew/BsOcbX9PbeSRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759768777; c=relaxed/simple;
	bh=fgi7F+vcqe0RzzCkxdSjpnKSsY3ZVogIjEyJ1V5Jgtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA8NRfHBYiVrrpHJUihbSgnUWOx2alx37gWrtX1BH6b+ESjfDGzSEkdR5uo5EgsLF7rIM/ZbptYrgIMDtEIITGpUab+roIni7EjiYqZX3HPADPq1xOTSFJKG652/Vlq8G+C/963/1cA4TtuAdosnlzj8HDBJ15L8N9144ghP098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=aIZ4DWJ+; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward203d.mail.yandex.net (Yandex) with ESMTPS id 5880E87263;
	Mon, 06 Oct 2025 19:31:34 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4985:0:640:840f:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 19018C006A;
	Mon, 06 Oct 2025 19:31:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QUnb3i1LqqM0-yLIGxQ3w;
	Mon, 06 Oct 2025 19:31:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759768284;
	bh=wRSUS9fJfSKjUxXWIv62A172UK/lxalhVSV+MQPi5gg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=aIZ4DWJ+hQKF7E0UDY67rm5dnLgxygmn3WjUovjna+L8obrnlxU+4IWRUSmJ058KG
	 xuRlkolySIivPJBnTGVodkQ69g6XSh5z6Fc2FMCp+5dt3NLiyAG+T0P/qOfpvcP5AL
	 uB9InMYfzAhuL/gR/Di5Bm46fcZyBiUHHd3HjO2A=
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
Subject: [PATCH 2/3] rust: xarray: abstract `xa_alloc_cyclic`
Date: Mon,  6 Oct 2025 19:30:23 +0300
Message-ID: <20251006163024.18473-3-work@onurozkan.dev>
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

Implements `alloc_cyclic` function to `XArray<T>` that
wraps `xa_alloc_cyclic` safely.

Resolves a task from the nova/core task list under the "XArray
bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
file.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/xarray.rs | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 1b882cd2f58b..4c2fdf53c7af 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -305,6 +305,49 @@ pub fn alloc(

         Ok(id)
     }
+
+    /// Allocates an empty slot within the given `limit`, storing `value` and cycling from `*next`.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the allocated id.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn alloc_cyclic(
+        &mut self,
+        limit: bindings::xa_limit,
+        next: &mut u32,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<u32, StoreError<T>> {
+        build_assert!(
+            T::FOREIGN_ALIGN >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+
+        let new = value.into_foreign();
+
+        // `__xa_alloc_cyclic` overwrites this.
+        let mut id: u32 = 0;
+
+        // SAFETY:
+        // - `self.xa.xa` is valid by the type invariant.
+        // - `new` came from `T::into_foreign`.
+        let ret = unsafe {
+            bindings::__xa_alloc_cyclic(self.xa.xa.get(), &mut id, new, limit, next, gfp.as_raw())
+        };
+
+        if ret < 0 {
+            // SAFETY: `__xa_alloc_cyclic` doesn't take ownership on error.
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


