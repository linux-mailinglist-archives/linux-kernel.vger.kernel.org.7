Return-Path: <linux-kernel+bounces-863455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6628BF7E2B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61D2C19C590A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2E234C801;
	Tue, 21 Oct 2025 17:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFuq5llG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D22E34C133
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067357; cv=none; b=bfnii9DiQC8/kYmcyKbD8wrG2YPGlB6ipcLc8stUNEJPe2TCfCTqnj+VL3nToM7Gf1/WEZ8wEtY9EkgZpjNufgmo9HRlSfSezGnADk0YEAeq+jodIfKE4lvLQXrzUXacZXQHjlwntktE4TZRF7AeGjs/dyDJOJwGSALL6yiz7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067357; c=relaxed/simple;
	bh=bwPOKX5PZI7Mj59bAoGxCiXrdi6zMchTri3Ym6fNPR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDBvjhjgYoQ4fm1GWqi5SPXf8lCWquAAwtqfhdYQ0v6iw1VWlFv7G6kIJpJIBwaTfgp8kiyVMMPuuET1gNdQC7Gu6fFSJ73S22J8ynh/OFGGkqLHp4jPpTPEtori/sNAVjf4netZbjbeFEBBYh+bKMrs6cdaUh6AGY1t2Agpixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFuq5llG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761067354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cdSPcH+wHvNWj0StlLEMwA8RIMWmorG7W7FYDNP1txU=;
	b=QFuq5llGbp01Ubi5DneI68Y2WAa3hLQ3pQQcB4lJ2V0vX+j5tknOZHMX14fWhDzdfdHIKa
	HqGy8Pqhm8eajJ3mK4XoX9nXWPUPLa8a0wPMOkCdQzUqIxASjq3K8GOEnKymqZfjv7yXTi
	nPD70nDgPk1yKv88ntw3S2ulBpsJnBE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Bn21VuWYNCCoPQv5bCC6Fw-1; Tue,
 21 Oct 2025 13:22:30 -0400
X-MC-Unique: Bn21VuWYNCCoPQv5bCC6Fw-1
X-Mimecast-MFC-AGG-ID: Bn21VuWYNCCoPQv5bCC6Fw_1761067348
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4333518002C1;
	Tue, 21 Oct 2025 17:22:28 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C94E1800451;
	Tue, 21 Oct 2025 17:22:23 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Shankari Anand <shankari.ak0208@gmail.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] rust: drm/gem: Remove Object.dev
Date: Tue, 21 Oct 2025 13:21:36 -0400
Message-ID: <20251021172220.252558-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I noticed by chance that there's actually already a pointer to this in
struct drm_gem_object. So, no use in carrying this around!

Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
V2:
* Improve safety comment in Object.dev()

 rust/kernel/drm/gem/mod.rs | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 30c853988b942..d984148403679 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -187,12 +187,10 @@ impl<T: IntoGEMObject> BaseObject for T {}
 /// Invariants
 ///
 /// - `self.obj` is a valid instance of a `struct drm_gem_object`.
-/// - `self.dev` is always a valid pointer to a `struct drm_device`.
 #[repr(C)]
 #[pin_data]
 pub struct Object<T: DriverObject + Send + Sync> {
     obj: Opaque<bindings::drm_gem_object>,
-    dev: NonNull<drm::Device<T::Driver>>,
     #[pin]
     data: T,
 }
@@ -222,9 +220,6 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
             try_pin_init!(Self {
                 obj: Opaque::new(bindings::drm_gem_object::default()),
                 data <- T::new(dev, size),
-                // INVARIANT: The drm subsystem guarantees that the `struct drm_device` will live
-                // as long as the GEM object lives.
-                dev: dev.into(),
             }),
             GFP_KERNEL,
         )?;
@@ -247,9 +242,13 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
 
     /// Returns the `Device` that owns this GEM object.
     pub fn dev(&self) -> &drm::Device<T::Driver> {
-        // SAFETY: The DRM subsystem guarantees that the `struct drm_device` will live as long as
-        // the GEM object lives, hence the pointer must be valid.
-        unsafe { self.dev.as_ref() }
+        // SAFETY:
+        // - `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
+        //   object lives.
+        // - The device we used for creating the gem object is passed as &drm::Device<T::Driver> to
+        //   Object::<T>::new(), so we know that `T::Driver` is the right generic parameter to use
+        //   here.
+        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
     }
 
     fn as_raw(&self) -> *mut bindings::drm_gem_object {

base-commit: 77ed4376d7c5de8be1f2612d6b4777077fb5fdb2
-- 
2.51.0


