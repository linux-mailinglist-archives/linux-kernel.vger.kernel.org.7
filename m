Return-Path: <linux-kernel+bounces-806593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAD0B4991A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E39189B2A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287631D732;
	Mon,  8 Sep 2025 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FchzLYEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1E31C599
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357601; cv=none; b=c2N9QQFtBKbP+rKr8D8DawQ+lMPTNlvi4UBJ/RKJwHo14LpLWtKlEe3GqHb5VUGiKaI5/awNN/D/BOSbhMCtldaYg7gM4Uw+sE/Xta7jvPtA2ezjhovs5Iaug/CVmklU1W1nqOdAVBExSzTPnTFXY4vaxoMd/ykD7bSedVp//Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357601; c=relaxed/simple;
	bh=t0DySZDoZrCvAVH1zss8yS+r/+N0+AJYcWf53CpQ91o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qENtdtEkdiRFSKElmcliH/Bqml958xwr5nYaWuIA4hsjNtQTBLyZ2R4XMCvnLSXp5qoCwvdqkb4Qxt8FbTSufs0Zs6QRO5UB6i2Ps1hBUwDjSuQw+Ylmo8Q1DLRHP504NvL+vh2hl4z5bdug/F764RH63GsnLJd8x8DB7+6ZnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FchzLYEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757357598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yth/iNP2a9kIBqrpNP1SCw4ew99ds4JSecEtwRjN4t4=;
	b=FchzLYEVM/T1VBJO39xc5Kk1iVoxGGvKre28I6TN2bb05pZl/CUYIMEN0CHvudIv/hgBB6
	cvZ/k/LDduPRG3+ZcKOoLTyAM+taM5D1N7TKyy9uoLQILbmKJDTstXC5HpXafIcoJLPw19
	v0r3hnXcrUhcQo8WnAel25p+xQCjbcY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-JUvqPGVbPMWXH18TqaEzhw-1; Mon,
 08 Sep 2025 14:53:13 -0400
X-MC-Unique: JUvqPGVbPMWXH18TqaEzhw-1
X-Mimecast-MFC-AGG-ID: JUvqPGVbPMWXH18TqaEzhw_1757357590
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B66A319560B7;
	Mon,  8 Sep 2025 18:53:10 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.64.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC4AE1800446;
	Mon,  8 Sep 2025 18:53:05 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	David Airlie <airlied@gmail.com>,
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
	Trevor Gross <tmgross@umich.edu>,
	Asahi Lina <lina+kernel@asahilina.net>
Subject: [PATCH v4 3/3] rust: drm: gem: Drop Object::SIZE
Date: Mon,  8 Sep 2025 14:46:38 -0400
Message-ID: <20250908185239.135849-4-lyude@redhat.com>
In-Reply-To: <20250908185239.135849-1-lyude@redhat.com>
References: <20250908185239.135849-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Drive-by fix, it doesn't seem like anything actually uses this constant
anymore.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/drm/gem/mod.rs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index ead723980b276..fd872de3b6695 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -12,7 +12,7 @@
     prelude::*,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::{mem, ops::Deref, ptr::NonNull};
+use core::{ops::Deref, ptr::NonNull};
 
 /// A type alias for retrieving a [`Driver`]s [`DriverFile`] implementation from its
 /// [`DriverObject`] implementation.
@@ -197,9 +197,6 @@ pub struct Object<T: DriverObject + Send + Sync> {
 }
 
 impl<T: DriverObject> Object<T> {
-    /// The size of this object's structure.
-    pub const SIZE: usize = mem::size_of::<Self>();
-
     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
         free: Some(Self::free_callback),
         open: Some(open_callback::<T>),
-- 
2.51.0


