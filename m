Return-Path: <linux-kernel+bounces-806852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6FB49CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966777AD7F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010E2EAB83;
	Mon,  8 Sep 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYa6ViDL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11892EA166
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369238; cv=none; b=GN/e3YCp1xoRdUTyfwnPJO6gjn2IG3LErRRuVlVIhFdgf6o07LuGAGUEN2o/iYDAYurpdh3CmMW3DSCA+3RI8c8wYxVb0/iCKC3dx7rTLaWvXq27vAMp38ipLopfoaqzWVOjprAwpBbeP1swnO7WSbgjyQLwddBnbMyX16mQMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369238; c=relaxed/simple;
	bh=VTyyObHR88FDo90+g9Ql1CNb2rsAg3EyIbgbO6VqvY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChuDHG2bgg1k3x4A+JiPoT9P7Axf8U6kGwe3sbpzP2nnfq1rZzldse5OAB449O+N1+EyBlvDE3HOJqSLQ6amLU/5Jo5ZzTOharCXZHCh2zDtp/YaDpQupQ99+ef2d/Anhsr2pDubAMUv5B+z2a0858mr5MaHse7yZlzRepQGyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYa6ViDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757369235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKR3M+u2UbhgI9ZzLhPjRhOHXsTKC9RJaF9aymRCG+M=;
	b=UYa6ViDLN9opQoETBZUPeiohX5HbkXUDAPqoywOOnhU1Ji6Rh0U7KbIsOrDqocmWFWTsBX
	uUltcWFFDuZSo5XQqh37bWb94xrQb8QVoSghU1zY+/lA6e3W5UWb2ro6R2h3b0/or1UUgS
	9BT0q4jNW8+x+KhpZEYEZgWlXvSLK+o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-3ydI1IEgPEucyGfw7RBkRQ-1; Mon,
 08 Sep 2025 18:07:13 -0400
X-MC-Unique: 3ydI1IEgPEucyGfw7RBkRQ-1
X-Mimecast-MFC-AGG-ID: 3ydI1IEgPEucyGfw7RBkRQ_1757369230
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E507C1800365;
	Mon,  8 Sep 2025 22:07:09 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBBC41800452;
	Mon,  8 Sep 2025 22:07:05 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Asahi Lina <lina+kernel@asahilina.net>
Subject: [PATCH 1/2] Partially revert "rust: drm: gem: Implement AlwaysRefCounted for all gem objects automatically"
Date: Mon,  8 Sep 2025 18:04:44 -0400
Message-ID: <20250908220657.165715-2-lyude@redhat.com>
In-Reply-To: <20250908220657.165715-1-lyude@redhat.com>
References: <20250908220657.165715-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I made a very silly mistake with this commit that managed to slip by
because I forgot to mzke sure rvkms was rebased before testing my work last
- we can't do blanket implementations like this due to rust's orphan rule.

The code -does- build just fine right now, but it doesn't with the ongoing
bindings for gem shmem. So, just revert this and we'll introduce a macro
for implementing AlwaysRefCounted individually for each type of gem
implementation.

Note that we leave the IntoGEMObject since it is true that all gem objects
are refcounted, so any implementations that are added should be
implementing AlwaysRefCounted anyhow.

This reverts commit 38cb08c3fcd3f3b1d0225dcec8ae50fab5751549.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/mod.rs | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index fd872de3b6695..af92f2d46d8d8 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -54,26 +54,6 @@ pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
     unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self;
 }
 
-// SAFETY: All gem objects are refcounted.
-unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
-    fn inc_ref(&self) {
-        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
-        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
-    }
-
-    unsafe fn dec_ref(obj: NonNull<Self>) {
-        // SAFETY: We either hold the only refcount on `obj`, or one of many - meaning that no one
-        // else could possibly hold a mutable reference to `obj` and thus this immutable reference
-        // is safe.
-        let obj = unsafe { obj.as_ref() }.as_raw();
-
-        // SAFETY:
-        // - The safety requirements guarantee that the refcount is non-zero.
-        // - We hold no references to `obj` now, making it safe for us to potentially deallocate it.
-        unsafe { bindings::drm_gem_object_put(obj) };
-    }
-}
-
 extern "C" fn open_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
@@ -272,6 +252,22 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
+// SAFETY: Instances of `Object<T>` are always reference-counted.
+unsafe impl<T: DriverObject> crate::types::AlwaysRefCounted for Object<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::drm_gem_object_get(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: `obj` is a valid pointer to an `Object<T>`.
+        let obj = unsafe { obj.as_ref() };
+
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::drm_gem_object_put(obj.as_raw()) }
+    }
+}
+
 impl<T: DriverObject> super::private::Sealed for Object<T> {}
 
 impl<T: DriverObject> Deref for Object<T> {
-- 
2.51.0


