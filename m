Return-Path: <linux-kernel+bounces-845452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E342EBC4FF8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28613B09A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75736265CCB;
	Wed,  8 Oct 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="d94HbiTA"
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7422576E;
	Wed,  8 Oct 2025 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927992; cv=none; b=h+bzvCEwohWXh5THwxm3Zg94Q0/pwDn1CJ0ysaqse0Ay2J3VPic+9yXPtiu02v03VOaakM4whGEj1fZQ6bk8Y4RCGEU9jmxpSkbf7vh5zf9Q9398tLfXPRB177anFc2UIfP5RQ569/taeFc5HjmyzExGEWQIkXeyOjHBgQf+duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927992; c=relaxed/simple;
	bh=M4vQ/ICTS7HOdkm3Eyry1Ae2cRQyR4+iqQSeG7AUovY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXACXgyF7MyocUs3xBl/U7r/YtxxBq+MVURazG2taapNylDHcp1Ydyn798/hSjUKoGct9yXyK+xVEs+ktZ5aFjcyOnUHOEFgFBbvflVnTB8L7WNVoSq4VPWWWHyjxD9l/UrYHEdvfM0Tj5TttfeujcjUwhhvy/1Rnrrs3zCKzmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=d94HbiTA; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id 3EDE38371D;
	Wed, 08 Oct 2025 15:47:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1b:3715:0:640:1185:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 1F57CC008F;
	Wed, 08 Oct 2025 15:47:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LklD46OLveA0-F6jyaQdz;
	Wed, 08 Oct 2025 15:47:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1759927646;
	bh=9zjv8cFRBo9Unx3PUTFt2Dg057u0swwLrQZWxNbSWj4=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=d94HbiTA+/qglKjJNUP8UVu3bp8xKNT88f5lgUR+fkNWhAJlK+ztEZp8TWsToIzAw
	 MhBlPnbG3663GBUWrs07fyw2dKY3CHazNA7NRMOHgF/ci1zgL6+7VvLLhPLp2R4uVI
	 Iko7lWPUHDqcjZXLTjT99r3iXrE4YdTbi+G4E+kU=
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
Subject: [PATCH v2 2/4] rust: xarray: abstract `xa_alloc`
Date: Wed,  8 Oct 2025 15:46:17 +0300
Message-ID: <20251008124619.3160-3-work@onurozkan.dev>
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

Implements `alloc` function to `XArray<T>` that wraps
`xa_alloc` safely, which will be used to generate the
auxiliary device IDs.

Resolves a task from the nova/core task list under the "XArray
bindings [XARR]" section in "Documentation/gpu/nova/core/todo.rst"
file.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/xarray.rs | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 90e27cd5197e..0711ccf99fb4 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -10,7 +10,7 @@
     ffi::c_void,
     types::{ForeignOwnable, NotThreadSafe, Opaque},
 };
-use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
+use core::{iter, marker::PhantomData, ops::Range, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};

 /// An array which efficiently maps sparse integer indices to owned objects.
@@ -268,6 +268,45 @@ pub fn store(
             Ok(unsafe { T::try_from_foreign(old) })
         }
     }
+
+    /// Allocates an empty slot within the given `limit` and stores `value` there.
+    ///
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the allocated index.
+    ///
+    /// On failure, returns the element which was attempted to be stored.
+    pub fn alloc(
+        &mut self,
+        limit: Range<u32>,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<u32, StoreError<T>> {
+        let new = value.into_foreign();
+        let mut id: u32 = 0;
+
+        let limit = bindings::xa_limit {
+            min: limit.start,
+            max: limit.end,
+        };
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


