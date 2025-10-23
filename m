Return-Path: <linux-kernel+bounces-867804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C50C03879
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AEE3B399D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A128489B;
	Thu, 23 Oct 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5JtqhXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B11DB375
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254770; cv=none; b=F0EUhsd2Py4x9BImf8IbfrP0XXtS5nIDhn8nj6T0OkaCqxYRn1GuBk5E3mlWFpUItSw61XGLpzrGFX50iX3pyNnCdDyM7E3X2sav5SJoYYBZ5rBJ4hp12zNpUzPiPnyZngtf/NlHa2mAtH9OPS9TV+KWvEuejOU0uZxxP2LhZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254770; c=relaxed/simple;
	bh=lwDclK5zyxp1awpvPaJAKW/PWA9pPm0C7jX9Z+AxEaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPxsmkryh4M6b+DoZkFf0d13ZTG0L8GLUJUuqgEYVS7nuw7XL81sQKrOxpZYRmaKVn1r1JT9hQ/rfnmnpKhcnzz1G+WZMYVLHBu5x/BOYprmdaOBBBcVjQl8InDOESfQyA32NPPCwWjHK1W05QG7A+sDJJdQeXceAUXA02LV5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5JtqhXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761254766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tojreo2SCeXW/AFAiQR1a/N+EZ+cx5QocDZTELD04Hw=;
	b=d5JtqhXRcdiO0EwQXjzRGZU3Vc4mvpeXz75Q5ySlP/2V+w48JHRR7CaPRkvMBQy+3OYBNI
	WPIt1GXey3v5ACU6XXlUJfE3+9/o4jc6h12HTCuQkcauBxxgZnw4/xRZG/LAt0nDvDp2Iy
	G2rwpr0phC7mcOzJW4gYVrXHu8vGAac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-bgxhGK6HM7qRBtyz1apc3Q-1; Thu,
 23 Oct 2025 17:26:03 -0400
X-MC-Unique: bgxhGK6HM7qRBtyz1apc3Q-1
X-Mimecast-MFC-AGG-ID: bgxhGK6HM7qRBtyz1apc3Q_1761254761
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14FFF1800D89;
	Thu, 23 Oct 2025 21:26:01 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.235])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5975B30002E1;
	Thu, 23 Oct 2025 21:25:56 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v5 1/8] rust/drm: Add gem::impl_aref_for_gem_obj!
Date: Thu, 23 Oct 2025 17:22:03 -0400
Message-ID: <20251023212540.1141999-2-lyude@redhat.com>
In-Reply-To: <20251023212540.1141999-1-lyude@redhat.com>
References: <20251023212540.1141999-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In the future we're going to be introducing more GEM object types in rust
then just gem::Object<T>. Since all types of GEM objects have refcounting,
let's introduce a macro that we can use in the gem crate in order to copy
this boilerplate implementation for each type: impl_aref_for_gem_obj!().

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V5:
* Move .as_raw() call to `let obj` in dec_ref, to ensure that the reference
  to object is not live by the time that we call drm_gem_object_put().
* Add missing #[macro_export] annotation

 rust/kernel/drm/gem/mod.rs | 54 +++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 20c2769a8c9d6..32bff2e8463f4 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -15,6 +15,44 @@
 };
 use core::{ops::Deref, ptr::NonNull};
 
+/// A macro for implementing [`AlwaysRefCounted`] for any GEM object type.
+///
+/// Since all GEM objects use the same refcounting scheme.
+#[macro_export]
+macro_rules! impl_aref_for_gem_obj {
+    (
+        impl $( <$( $tparam_id:ident ),+> )? for $type:ty
+        $(
+            where
+                $( $bind_param:path : $bind_trait:path ),+
+        )?
+    ) => {
+        // SAFETY: All gem objects are refcounted
+        unsafe impl $( <$( $tparam_id ),+> )? $crate::types::AlwaysRefCounted for $type
+        $(
+            where
+                $( $bind_param : $bind_trait ),+
+        )?
+        {
+            fn inc_ref(&self) {
+                // SAFETY: The existence of a shared reference guarantees that the refcount is
+                // non-zero.
+                unsafe { bindings::drm_gem_object_get(self.as_raw()) };
+            }
+
+            unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+                // SAFETY: `obj` is a valid pointer to an `Object<T>`.
+                let obj = unsafe { obj.as_ref() }.as_raw();
+
+                // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+                unsafe { bindings::drm_gem_object_put(obj) };
+            }
+        }
+    };
+}
+
+pub(crate) use impl_aref_for_gem_obj;
+
 /// A type alias for retrieving a [`Driver`]s [`DriverFile`] implementation from its
 /// [`DriverObject`] implementation.
 ///
@@ -253,21 +291,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
-// SAFETY: Instances of `Object<T>` are always reference-counted.
-unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
-    fn inc_ref(&self) {
-        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
-    }
-
-    unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: `obj` is a valid pointer to an `Object<T>`.
-        let obj = unsafe { obj.as_ref() };
-
-        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_put(obj.as_raw()) }
-    }
-}
+impl_aref_for_gem_obj!(impl<T> for Object<T> where T: DriverObject);
 
 impl<T: DriverObject> super::private::Sealed for Object<T> {}
 
-- 
2.51.0


