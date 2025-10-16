Return-Path: <linux-kernel+bounces-856896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB326BE55C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87375358B24
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3B2DC79A;
	Thu, 16 Oct 2025 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K53GujsG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2D21C8629
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646072; cv=none; b=neCRia2dmmsh3Umo9j8RJSGKt/m1/7WLuShuOP1+Mu5nc06jo6RoTRIeTo0y0z2ZjXMenBBZeuONmGy2OJOyp5MA+XmhOWxNzLfB5ndx37LyXNO0B+O6uutHYehNqU1ughF/Exz9PKEdPfF4KqoDYsJEww1AATaMYh2nc5q3rAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646072; c=relaxed/simple;
	bh=46KNg+fC3i7V+coM5JvY1PEvdh3AinPsyoPA3OH+3jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R23xyp0yv8wNNwnCeHdwefKowLjR45Ygr8maK4OTZfb+3AT4wuXQe4Z1oKoZ9yEuietq0YfkfhNzSpbcQDfLHNMPb53xSj0e5HVwo9JNgeBvMzGt/SHEvNIKTRW7ClnDhiNk9sFZ+arVP0d53IWPTA7VRmL4xqT+QGH4VTIXvW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K53GujsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760646070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1cXSfh1OwJkFuHajMO4OqXkTcp1mTaMCP9KapZOWIVo=;
	b=K53GujsGQY+delCUXwjQmHEdTKP0jACZyBFqTpQDnR4s+/pEwYZGxwgAluNSzwH+N1MU+5
	AwEMP2enMY8C0i2yTVT59yaVdLWISiUZ38SN/83JROwrA2OlvYLYaS9ernpG5iq6gM5ZnY
	ksU3O8+Lz9tuzP04ljj95xL2RivBiTQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-gWB795RmMuWweSC23aiErQ-1; Thu,
 16 Oct 2025 16:21:07 -0400
X-MC-Unique: gWB795RmMuWweSC23aiErQ-1
X-Mimecast-MFC-AGG-ID: gWB795RmMuWweSC23aiErQ_1760646064
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C0FB18002E4;
	Thu, 16 Oct 2025 20:21:04 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.80.252])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B23019560B0;
	Thu, 16 Oct 2025 20:21:00 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
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
	Asahi Lina <lina+kernel@asahilina.net>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH] rust: drm/gem: Remove Object.dev
Date: Thu, 16 Oct 2025 16:18:58 -0400
Message-ID: <20251016202044.2748678-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I noticed by chance that there's actually already a pointer to this in
struct drm_gem_object. So, no use in carrying this around!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/mod.rs | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 30c853988b942..28d929edae267 100644
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
@@ -247,9 +242,9 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize) -> Result<ARef<Self>> {
 
     /// Returns the `Device` that owns this GEM object.
     pub fn dev(&self) -> &drm::Device<T::Driver> {
-        // SAFETY: The DRM subsystem guarantees that the `struct drm_device` will live as long as
-        // the GEM object lives, hence the pointer must be valid.
-        unsafe { self.dev.as_ref() }
+        // SAFETY: `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
+        // object lives.
+        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
     }
 
     fn as_raw(&self) -> *mut bindings::drm_gem_object {

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


