Return-Path: <linux-kernel+bounces-768452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09422B2612B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1EBA3B8440
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5062FFDD0;
	Thu, 14 Aug 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/o5FWLY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236A2F39C0;
	Thu, 14 Aug 2025 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163900; cv=none; b=MjIC/IaO8PtbkKLOflWvaUsBj4BaiMCJyiXvg3jlymkrvLYwVx7qJlsn5KLGLQRYoBIM4dpGAllA1uZ9kZuML14ellviCDlkdDwqNebLgzp8Q/KPwKUSc91R7YspS4S72Eh/8N+8LAT1nalxJ+PY33NCPyOkl61/o2ticmR1PvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163900; c=relaxed/simple;
	bh=AtdCut0p3HWXoX/BFy+3Zii54dnLRBC5LFi3wTrY/D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzKygp3LaTE9x45JedM2RCQluq/hz0rRhB9/fL2qgOulY0uAaotvOwKu/HdF1/Ju06SEI3fiqM8YEYyBmH8eBlADr8oQQMMohnFfY6rCF7HQheemaf/uyVPumjzf+a8VMr3kq108PtP65aFtZTU80S6jXqkTkXNhd4pzn0f6UGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/o5FWLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F555C4CEED;
	Thu, 14 Aug 2025 09:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755163899;
	bh=AtdCut0p3HWXoX/BFy+3Zii54dnLRBC5LFi3wTrY/D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/o5FWLYs7exPkOr91ll44EELwbqVaVEX6wyZO4o9/qG056tfyAMNks73EVJh2Xax
	 jeXxxCRYJBdCjYqYjFGcOiweiVOhknUGZEcc1WFW32fembGVZquVobIBhjBPb+MWVq
	 KLEJVevGjmlQ6IhJNgVXJ5vkVRqPoCaihnuD2LnRFumlSiw9bdbxy2IMypndBfHwPA
	 GwtZMJ42xAmvJYsez82bT/ZlKICjoddy/ArAuXLeJPjwrKTuKIPCTi6v4hs7O1voew
	 pU7UOkjdfxFAHa9FB6br68eNj4F+Hwi/fw748IkgNLIJjdpiFYy7TqcFbmFiwimTcL
	 gsQqMwKOVbhHw==
From: Benno Lossin <lossin@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Asahi Lina <lina+kernel@asahilina.net>
Cc: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] rust: drm: replace `core::mem::zeroed` with `pin_init::zeroed`
Date: Thu, 14 Aug 2025 11:30:35 +0200
Message-ID: <20250814093046.2071971-9-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814093046.2071971-1-lossin@kernel.org>
References: <20250814093046.2071971-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All types in `bindings` implement `Zeroable` if they can, so use
`pin_init::zeroed` instead of relying on `unsafe` code.

If this ends up not compiling in the future, something in bindgen or on
the C side changed and is most likely incorrect.

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/drm/gem/mod.rs | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index b71821cfb5ea..6532513090de 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -308,9 +308,7 @@ impl<T: DriverObject> AllocImpl for Object<T> {
 }
 
 pub(super) const fn create_fops() -> bindings::file_operations {
-    // SAFETY: As by the type invariant, it is safe to initialize `bindings::file_operations`
-    // zeroed.
-    let mut fops: bindings::file_operations = unsafe { core::mem::zeroed() };
+    let mut fops: bindings::file_operations = pin_init::zeroed();
 
     fops.owner = core::ptr::null_mut();
     fops.open = Some(bindings::drm_open);
-- 
2.50.1


