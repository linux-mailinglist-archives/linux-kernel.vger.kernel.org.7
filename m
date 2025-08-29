Return-Path: <linux-kernel+bounces-792531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBBCB3C548
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5DD7C764E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332722D877F;
	Fri, 29 Aug 2025 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGCpEY7/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F492D9EE0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507384; cv=none; b=JFDFFjpicJjdDFRmfKYJg+FDoUah0gJR4zZ1vbsbMdICfOMTJwCufAcv9ax0MpYaPdE0shHhRJz6F/h78OfKTfp3LycVRg1Nc9uDlMNtOOWE3qPd2pIx3iFnWLzQI+CSsNBCI3bKjhuoADWn/kugPh5hvQPEcOB2UN7l7zQicBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507384; c=relaxed/simple;
	bh=J4kt0AH42ZTONC28Th1Okh8r1ILQmR1UJzSCMd6Q6e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgEODfPryAMoBXdeeoIrVygGPK25c/3Z+ANmQXHqvUPoitEaM9jm0jGCPxzcDR1Uhl8nx+OV+M+29XOcvO3O9EwgjeoToxH6k3ja8/YUjb95Fsb40al2NMR0iobS3gNA2GL6sW5YgnI+jCYygQTh7U3EEthS2U637Si/18H8DE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGCpEY7/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756507380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ze5i6Pi0AsJ8OZnGY1zOw/cDXaH5xQ4ENMo0wMvIxrk=;
	b=ZGCpEY7/5rzCYb6s6CWtJdTb/Yt5e8fCFDa0Huw/gVBm2mYrBoSueFci4pnpkLX7KgF0u1
	t3izcTaeWqVbHtW3DGTTMsnOZXfCMiUSzCvsRQC6PMUTQHhQjAruMSkcLPxIgh6THV7909
	508APAwhRDRyhlZShmhPDPQ21sWOEaY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-I9enlBaGM4CVqSLLlPdsZg-1; Fri,
 29 Aug 2025 18:42:57 -0400
X-MC-Unique: I9enlBaGM4CVqSLLlPdsZg-1
X-Mimecast-MFC-AGG-ID: I9enlBaGM4CVqSLLlPdsZg_1756507373
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D75719560AD;
	Fri, 29 Aug 2025 22:42:53 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.80.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E951E18003FC;
	Fri, 29 Aug 2025 22:42:48 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Asahi Lina <lina+kernel@asahilina.net>
Subject: [PATCH v3 11/14] rust: drm: gem: Introduce SGTableRef
Date: Fri, 29 Aug 2025 18:35:26 -0400
Message-ID: <20250829224116.477990-12-lyude@redhat.com>
In-Reply-To: <20250829224116.477990-1-lyude@redhat.com>
References: <20250829224116.477990-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Currently we expose the ability to retrieve an SGTable for an shmem gem
object using gem::shmem::Object::<T>::sg_table(). However, this only gives us a
borrowed reference. This being said - retrieving an SGTable is a fallible
operation, and as such it's reasonable that a driver may want to hold
onto an SGTable for longer then a reference would allow in order to avoid
having to deal with fallibility every time they want to access the SGTable.
One such driver with this usecase is the Asahi driver.

So to support this, let's introduce SGTableRef - which both holds a
pointer to the SGTable and a reference to its respective GEM object in
order to keep the GEM object alive for as long as the SGTableRef. The
type can be used identically to a normal SGTable.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V3:
* Rename OwnedSGTable to SGTableRef. Since the current version of the
  SGTable abstractions now has a `Owned` and `Borrowed` variant, I think
  renaming this to SGTableRef makes things less confusing.
  We do however, keep the name of owned_sg_table() as-is.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/gem/shmem.rs | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 6a8a392c3691b..1437cda27a22c 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -178,6 +178,22 @@ pub fn sg_table(&self) -> Result<&scatterlist::SGTable> {
         Ok(unsafe { scatterlist::SGTable::from_raw(sgt) })
     }
 
+    /// Creates (if necessary) and returns an owned reference to a scatter-gather table of DMA pages
+    /// for this object.
+    ///
+    /// This is the same as [`sg_table`](Self::sg_table), except that it instead returns a
+    /// [`OwnedSGTable`] which holds a reference to the associated gem object.
+    ///
+    /// This will pin the object in memory.
+    pub fn owned_sg_table(&self) -> Result<SGTableRef<T>> {
+        Ok(SGTableRef {
+            sgt: self.sg_table()?.into(),
+            // INVARIANT: We take an owned refcount to `self` here, ensuring that `sgt` remains
+            // valid for as long as this `OwnedSGTable`.
+            _owner: self.into(),
+        })
+    }
+
     /// Creates and returns a virtual kernel memory mapping for this object.
     pub fn vmap(&self) -> Result<VMap<T>> {
         let mut map: MaybeUninit<bindings::iosys_map> = MaybeUninit::uninit();
@@ -309,3 +325,37 @@ fn drop(&mut self) {
 unsafe impl<T: DriverObject> Send for VMap<T> {}
 /// SAFETY: `iosys_map` objects are safe to send across threads.
 unsafe impl<T: DriverObject> Sync for VMap<T> {}
+
+/// An owned reference to a scatter-gather table of DMA address spans for a GEM shmem object.
+///
+/// This object holds an owned reference to the underlying GEM shmem object, ensuring that the
+/// [`SGTable`] referenced by `SGTableRef` remains valid for the lifetime of this object.
+///
+/// # Invariants
+///
+/// - `sgt` is kept alive by `_owner`, ensuring it remains valid for as long as `Self`.
+/// - `sgt` corresponds to the owned object in `_owner`.
+/// - This object is only exposed in situations where we know the underlying `SGTable` will not be
+///   modified for the lifetime of this object.
+///
+/// [`SGTable`]: scatterlist::SGTable
+pub struct SGTableRef<T: DriverObject> {
+    sgt: NonNull<scatterlist::SGTable>,
+    _owner: ARef<Object<T>>,
+}
+
+// SAFETY: This object is only exposed in situations where we know the underlying `SGTable` will not
+// be modified for the lifetime of this object.
+unsafe impl<T: DriverObject> Send for SGTableRef<T> {}
+// SAFETY: This object is only exposed in situations where we know the underlying `SGTable` will not
+// be modified for the lifetime of this object.
+unsafe impl<T: DriverObject> Sync for SGTableRef<T> {}
+
+impl<T: DriverObject> Deref for SGTableRef<T> {
+    type Target = scatterlist::SGTable;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: Creating an immutable reference to this is safe via our type invariants.
+        unsafe { self.sgt.as_ref() }
+    }
+}
-- 
2.50.0


