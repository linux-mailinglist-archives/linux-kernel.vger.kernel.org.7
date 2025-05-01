Return-Path: <linux-kernel+bounces-628835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7FDAA62F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75ED1BC1B41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14A225408;
	Thu,  1 May 2025 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHwp4bZs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2919223DE3
	for <linux-kernel@vger.kernel.org>; Thu,  1 May 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746124677; cv=none; b=mpqne1O6A0cmTGrD2Xh60yMbKqmHRKKimRt6QVzlQuf1XROJr/WK0Uhnhzk7NNssJbbB/ERVNYGLF0xLAVULXB942U0MIuiTJNA+JC0GSo3XCREeLzW+nHbeS5HBRIfk/CqgqLIvYOhlYUZNfuL/8laU684eDu60pQgyYlnPejo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746124677; c=relaxed/simple;
	bh=0xjLkMFUFx06scABoQ/zs3kafFJnRYg9F5/jrAqUGVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKA4sErlX5oCTv0dMII9e72l0CeUoaj5/vDs82UNA58bE72fpEqTVGrdUijaDbfC6GLeLUniqjjcD+WPLqq+KofCbOLz4EjfvMogLY6DzUXhvgKxukkL9MC8ZUd6D2cj21pkFeQtoBYmHYvO/Uwr7QUkL3Af1u1u79ikD0shxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHwp4bZs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746124674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKTzchovYe9btT6kqsT42uzZZYhEcMTVxwqNJvjbEbI=;
	b=DHwp4bZsovAsCLP8idHSzgxDDKc4NyCxwOlDNUx1Wm/JFWNCjgJgDbRdSurw0zd3T6Yakv
	XR4J1rtK1UqdRzqgUdpVarf0iJfFPI++rvKqWaol+2nurT9x/GZQzchQ1GVwsbil9ibARQ
	lJ1lQuLVMB3okVDmunMAe+BlHThtM5s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-XILNJ3fROF2y79f7i2Bsog-1; Thu,
 01 May 2025 14:37:51 -0400
X-MC-Unique: XILNJ3fROF2y79f7i2Bsog-1
X-Mimecast-MFC-AGG-ID: XILNJ3fROF2y79f7i2Bsog_1746124669
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0C7C1800985;
	Thu,  1 May 2025 18:37:48 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.132])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22FC31800115;
	Thu,  1 May 2025 18:37:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Asahi Lina <lina@asahilina.net>
Subject: [PATCH 3/4] rust: drm: gem: s/into_gem_obj()/as_gem_obj()/
Date: Thu,  1 May 2025 14:33:18 -0400
Message-ID: <20250501183717.2058109-4-lyude@redhat.com>
In-Reply-To: <20250501183717.2058109-1-lyude@redhat.com>
References: <20250501183717.2058109-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There's a few changes here:
* The rename, of course (this should also let us drop the clippy annotation
  here)
* Return *mut bindings::drm_gem_object instead of
  &Opaque<bindings::drm_gem_object> - the latter doesn't really have any
  benefit and just results in conversion from the rust type to the C type
  having to be more verbose than necessary.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/mod.rs | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index f70531889c21f..55b2f1d056c39 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -42,8 +42,7 @@ pub trait IntoGEMObject: Sized + super::private::Sealed {
 
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
-    #[allow(clippy::wrong_self_convention)]
-    fn into_gem_obj(&self) -> &Opaque<bindings::drm_gem_object>;
+    fn as_gem_obj(&self) -> *mut bindings::drm_gem_object;
 
     /// Converts a pointer to a `struct drm_gem_object` into a reference to `Self`.
     ///
@@ -99,8 +98,8 @@ extern "C" fn close_callback<T: BaseDriverObject<U>, U: BaseObject>(
 impl<T: DriverObject> IntoGEMObject for Object<T> {
     type Driver = T::Driver;
 
-    fn into_gem_obj(&self) -> &Opaque<bindings::drm_gem_object> {
-        &self.obj
+    fn as_gem_obj(&self) -> *mut bindings::drm_gem_object {
+        self.obj.get()
     }
 
     unsafe fn as_ref<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
@@ -119,7 +118,7 @@ pub trait BaseObject
     fn size(&self) -> usize {
         // SAFETY: `self.into_gem_obj()` is guaranteed to be a pointer to a valid `struct
         // drm_gem_object`.
-        unsafe { (*self.into_gem_obj().get()).size }
+        unsafe { (*self.as_gem_obj()).size }
     }
 
     /// Creates a new handle for the object associated with a given `File`
@@ -131,11 +130,7 @@ fn create_handle(
         let mut handle: u32 = 0;
         // SAFETY: The arguments are all valid per the type invariants.
         to_result(unsafe {
-            bindings::drm_gem_handle_create(
-                file.as_raw().cast(),
-                self.into_gem_obj().get(),
-                &mut handle,
-            )
+            bindings::drm_gem_handle_create(file.as_raw().cast(), self.as_gem_obj(), &mut handle)
         })?;
         Ok(handle)
     }
@@ -171,13 +166,11 @@ fn lookup_handle(
     /// Creates an mmap offset to map the object from userspace.
     fn create_mmap_offset(&self) -> Result<u64> {
         // SAFETY: The arguments are valid per the type invariant.
-        to_result(unsafe { bindings::drm_gem_create_mmap_offset(self.into_gem_obj().get()) })?;
+        to_result(unsafe { bindings::drm_gem_create_mmap_offset(self.as_gem_obj()) })?;
 
         // SAFETY: The arguments are valid per the type invariant.
         Ok(unsafe {
-            bindings::drm_vma_node_offset_addr(ptr::addr_of_mut!(
-                (*self.into_gem_obj().get()).vma_node
-            ))
+            bindings::drm_vma_node_offset_addr(ptr::addr_of_mut!((*self.as_gem_obj()).vma_node))
         })
     }
 }
-- 
2.48.1


