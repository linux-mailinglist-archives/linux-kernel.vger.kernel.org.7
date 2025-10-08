Return-Path: <linux-kernel+bounces-845458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E2BC506A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA63B3A91F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0972820BF;
	Wed,  8 Oct 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="TIGY6JA7"
Received: from forward204b.mail.yandex.net (forward204b.mail.yandex.net [178.154.239.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F12248F77;
	Wed,  8 Oct 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928114; cv=none; b=RwZ+BXZalx/5GD/7NEEfpFN4NePbIEEsUBymay+Nqo0B/v6b564fw78/0f3TqBcOSmJ9/2KAFTSgl3AG8RwbIJQ02YLN7hnmL/s/1xVkK0JzV/nukwKtvcnXE4Wkcuo6ioEbGyLlsQXfAp1wk9/IbQup0Y0dcW7bs/Txyot2xCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928114; c=relaxed/simple;
	bh=o4JSOiNvSiuVy6wKHbAIexksGThs/RLhe1e8HWTcEjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmYUIZvK2ha0i+v+pLn9NegD+3DOG8V/XcnJ+3JF/Yb7bW+dtbObUTguhuRxjT0kpVHzhTjN0BmXC46AKuynG9dj0ECStSlTtaNmgKRAC8PHvml5Nvt0bOvacWj47uBmaVrt3OruVeKfyVjZ1NGrF85kwPjGGk4AMFmwAXlbz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=TIGY6JA7; arc=none smtp.client-ip=178.154.239.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward204b.mail.yandex.net (Yandex) with ESMTPS id 60BBF85679;
	Wed, 08 Oct 2025 15:47:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id CC76180783;
	Wed, 08 Oct 2025 15:47:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LklD46OLveA0-5Fip2vTH;
	Wed, 08 Oct 2025 15:47:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759927650;
	bh=uRGv0l/dmTbmeqoiwwL0sBB19QCoeul8k0YBcio2lRE=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=TIGY6JA7uXQqZzGsU6qvsO+MVeWfyh6H8FJlt0NscSCMfPmwy9t/MW5XIVXced7ve
	 QIxBT7OUA3CWxqSPrgkRg7Lr0URBTJNWI/RYACVQa7XSn13n9DeW4DpqQMUZYdG0fZ
	 oCBkiHgRnCunKHIPSO7UeVbhe6AE/ZFpUqAuS1BI=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
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
	linux-mm@kvack.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 3/4] rust: xarray: abstract `xa_alloc_cyclic`
Date: Wed,  8 Oct 2025 15:46:18 +0300
Message-ID: <20251008124619.3160-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008124619.3160-1-work@onurozkan.dev>
References: <20251008124619.3160-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implements `alloc_cyclic` function to `XArray<T>` that
wraps `xa_alloc_cyclic` safely, which will be used to
generate the auxiliary device IDs.

Resolves a task from the nova/core task list under the "XArray
bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
file.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/xarray.rs | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 0711ccf99fb4..8ac7210afd6b 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -307,6 +307,56 @@ pub fn alloc(

         Ok(id)
     }
+
+    /// Allocates an empty slot within the given `limit`, storing `value` and cycling from `*next`.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the allocated index and the next pointer respectively.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn alloc_cyclic(
+        &mut self,
+        limit: Range<u32>,
+        mut next: u32,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<(u32, u32), StoreError<T>> {
+        let new = value.into_foreign();
+
+        let limit = bindings::xa_limit {
+            min: limit.start,
+            max: limit.end,
+        };
+
+        // `__xa_alloc_cyclic` overwrites this.
+        let mut id: u32 = 0;
+
+        // SAFETY:
+        // - `self.xa.xa` is valid by the type invariant.
+        // - `new` came from `T::into_foreign`.
+        let ret = unsafe {
+            bindings::__xa_alloc_cyclic(
+                self.xa.xa.get(),
+                &mut id,
+                new,
+                limit,
+                &mut next,
+                gfp.as_raw(),
+            )
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
+        Ok((id, next))
+    }
 }

 // SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
--
2.51.0


