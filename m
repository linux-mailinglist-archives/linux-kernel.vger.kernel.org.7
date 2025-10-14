Return-Path: <linux-kernel+bounces-851909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B02BD798B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABB83B7798
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3C2C3262;
	Tue, 14 Oct 2025 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxH+jrR+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA42D2493
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424092; cv=none; b=Fi4HcBgIrhSZSCa38Za7+zISTDCeXcS1yGVAChYWHEBUJmIGDAbaKDlt8HMvARVeSrqJTHuNONNIOj8uIdaLrRvg6eYq04QElfGbaCkRHszVgYeISxjwNEhN1yRBZ0bs5ZyZUEvLGBkYBsOQaUj/0ZP13g15c2rD2vCvsCW2uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424092; c=relaxed/simple;
	bh=2bp7b8xMX3lCsqrOtDwzTcWHekQK/ojdxzFCW5PavL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QxbD+JjIDxGWFqTKPzOJYEBwrMDH/G3nLAUK4IplZK33iWZk+i4gH7cIyOp85DrzOyv0PdO585thod+CkSblA2mjkufYgtl33ANm+i0cujhaX/FQr+ANCva/j36dg5igkS0gV9GaqzAT2NOGXem3OdvLVYV/+R+jl8VbSFibOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxH+jrR+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760424088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8eo0rdDzh07ckiTBotN/0G7m7UlosQASIFmbI9q9Ybw=;
	b=VxH+jrR+LRXwH/yuKDqGlQNaW4WkgeJu5NYPsuemIuRK5m+I7xy4tHUMwst1+phoLIHeaU
	6RoqEdHBfSwTwcSzELiqSuQ4zngTRKVIpwDF0t76ecMdEAbHa5e273RWhTyrQMx2Ux5/vA
	ZepaIl+iDkWd/cRUFxVsYxaG72XHo6c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-wXbSK0f5Os-VY4TmXApB5Q-1; Tue, 14 Oct 2025 02:41:27 -0400
X-MC-Unique: wXbSK0f5Os-VY4TmXApB5Q-1
X-Mimecast-MFC-AGG-ID: wXbSK0f5Os-VY4TmXApB5Q_1760424086
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f924ae2a89so5895950f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424086; x=1761028886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eo0rdDzh07ckiTBotN/0G7m7UlosQASIFmbI9q9Ybw=;
        b=R5tY1tyk/VPblsalKIKhDNeEPYjofT8A2QheBL+bKFQJsRLzm2rpOC2Xe7g3VvbB0f
         S+KeQoeDjVsMSaRvfM76rOqeArgaV30H7/4jrtDQzwL8sPJdJPItsIIMiiN8CwBT95uO
         rkchfmtB3CJ/ZfaeY+bdueiWABsd09NSXvDyLk3GuWvgpnCHleFc85eQayTc2YR9PKVP
         3O7Qy/FNL9cS4tMv4Z9FBanY1o6x7FWjU/s91LeDo993H0Lu3oMRd23N5yOfOjkPgnuz
         NE/nG/3UrtFFzuZLKhY39kqk8v9HYsOiv8WZheU+R1yOBE0zVhCrh/1WPGpJqQMQozT9
         3+rw==
X-Forwarded-Encrypted: i=1; AJvYcCVypB8W2qienVYPZJwGJEgajfyWxgvOjYgbhvdQfSN/SLeue4jNxItUJO834Iyon2CVD4HJUKw2FspfqmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS178YBd5ikb1c4oO1MH62DUpDTK4Ok+wXDd80cPSnEMlBFqlN
	Oi90Y3GLxaFoZ5MZb9/mtxGonwbfe+fADgTHsiA0gyBhUThTHsEHtDC9TTIzMCXFAFyYlT9+Zxb
	RryXJi4G+N4NRYTJqgbhbYOGZ8RFujT6GXYXZJOKmbXJyiE/BSW8TeAQnuTrOE/n/5w==
X-Gm-Gg: ASbGncsfOL2znDU/OA1bwHTAw6L9oOSRFaQSQXfyeZ/ix//q784J4TkhkbZKS4F4+dH
	ueUtP9LUokAm43iFqsyjow50ZsWatojYHMymlzBlwDjjz5RgOfkZBlgfyVlRwPmMgA42VMkO8z2
	rLVgq9ke7AtmPAkyzMEiYUTp57hbCrfKUDtY/XI+jczeYmOmgr4moTmjlS33uUoa5F5bdRWja3L
	BAbWDp+c6aALTi7zESTciU1bnaVqTSNcLTMXAU/uaLAHJ8W0ZUqEtBkkiCImYWxp1gEqUQllIoD
	lXM0ogtTYukrE2mvfOcbnc97ZrzsJ0CeV+dPxwZrt6fNCCB1I0qY9PKp1UwWX1VD1v7ngYrJxOz
	3XSehTE+43TMqIA==
X-Received: by 2002:a5d:5d86:0:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4266e8f7f58mr14331629f8f.29.1760424085624;
        Mon, 13 Oct 2025 23:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQ04e7UfQsRRayb/A53UoKDUPQdS7WxAqx3NLzVujqatyY5Y+mwqkqiVt78YRvyiQ00wF5w==
X-Received: by 2002:a5d:5d86:0:b0:3eb:4e88:585 with SMTP id ffacd0b85a97d-4266e8f7f58mr14331606f8f.29.1760424085157;
        Mon, 13 Oct 2025 23:41:25 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982c10sm217369235e9.5.2025.10.13.23.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:41:24 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>,
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
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] rust: drm: remove unneeded handling for config DRM_LEGACY
Date: Tue, 14 Oct 2025 08:41:20 +0200
Message-ID: <20251014064120.263455-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Since commit 94f8f319cbcb ("drm: Remove Kconfig option for legacy support
(CONFIG_DRM_LEGACY)"), the special handling in the rust drm code for the
config DRM_LEGACY is not needed.

Remove the drm_legacy_fields macro and simply use bindings::drm_driver
unconditionally.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 rust/kernel/drm/device.rs | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3ce8f62a0056..a1d92d8922a4 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -16,37 +16,6 @@
 };
 use core::{alloc::Layout, mem, ops::Deref, ptr, ptr::NonNull};
 
-#[cfg(CONFIG_DRM_LEGACY)]
-macro_rules! drm_legacy_fields {
-    ( $($field:ident: $val:expr),* $(,)? ) => {
-        bindings::drm_driver {
-            $( $field: $val ),*,
-            firstopen: None,
-            preclose: None,
-            dma_ioctl: None,
-            dma_quiescent: None,
-            context_dtor: None,
-            irq_handler: None,
-            irq_preinstall: None,
-            irq_postinstall: None,
-            irq_uninstall: None,
-            get_vblank_counter: None,
-            enable_vblank: None,
-            disable_vblank: None,
-            dev_priv_size: 0,
-        }
-    }
-}
-
-#[cfg(not(CONFIG_DRM_LEGACY))]
-macro_rules! drm_legacy_fields {
-    ( $($field:ident: $val:expr),* $(,)? ) => {
-        bindings::drm_driver {
-            $( $field: $val ),*
-        }
-    }
-}
-
 /// A typed DRM device with a specific `drm::Driver` implementation.
 ///
 /// The device is always reference-counted.
@@ -61,7 +30,7 @@ pub struct Device<T: drm::Driver> {
 }
 
 impl<T: drm::Driver> Device<T> {
-    const VTABLE: bindings::drm_driver = drm_legacy_fields! {
+    const VTABLE: bindings::drm_driver = bindings::drm_driver {
         load: None,
         open: Some(drm::File::<T::File>::open_callback),
         postclose: Some(drm::File::<T::File>::postclose_callback),
-- 
2.51.0


