Return-Path: <linux-kernel+bounces-853715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F421EBDC659
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFB964E385A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075242F7AAC;
	Wed, 15 Oct 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqCDdvzZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C81F1A23B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501008; cv=none; b=Ybzur6okImtMboDU8qwhwlnjZV5oSUbe1eLONCom8Jj7Fq/S09TdI4XwcJLuwoKSGFwaQGkFjwHk+RqahdtWbJbKNRogMnK7Y32LC1z/vXCU/ahgIH5IEB6MVFpxf4OHbJvixClNHthUdihQaBuWgIcr1xO9xGpqf8YJQVHjcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501008; c=relaxed/simple;
	bh=+ZY9ISu0W16A5V+R31X/nl/Eyjev56GCHTyxRrxZotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNeYVfm99MNs0dy08ZrC7kFjWUSwmEBXfT4neE10hxpnNXi9wUBtv9Sw3vW0NCL5Y0VlmHYlTGtfT52/mXpsSnkb7YPzyt7zsemQ5xCetSKg8le6ih7GmVFm0nd0iDm4GF72YaPXw35hQDAExvYnY7vh2nu05znG+9rwXyTBCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqCDdvzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uZpbkKbGsAFX9mFxTHGyfhWtkHglsy/t96i+4mTbI4=;
	b=UqCDdvzZJJaa3RFQT5WJDHlUfrn/2EBUVrPvDyvVg1GaydKqW0GnaVnaHCfuSYnpuptkn5
	bQjA9YZrOcpC/CTu+Fgp3wUCQlm1O+0eTGMSnDCbct2zIKGv48eH07DkY/3vcdEGr3Cv7g
	7AVYlbRFLTEqXS0FoGVrvwlAtFBW6TM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-kCKyavygNUKjK7npE4G7Kw-1; Wed, 15 Oct 2025 00:03:23 -0400
X-MC-Unique: kCKyavygNUKjK7npE4G7Kw-1
X-Mimecast-MFC-AGG-ID: kCKyavygNUKjK7npE4G7Kw_1760501003
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so27072880a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501001; x=1761105801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uZpbkKbGsAFX9mFxTHGyfhWtkHglsy/t96i+4mTbI4=;
        b=M52vKaTt7C+7SExmcE0VsEwov6ncEt7XF/n02y3dD85oLYaxKBmVbB9C8eSOOLSTR/
         o603Ya/4qz4Hfbpr1Rg6gpagikHUdyMEAfjWggPf4DD7VS4fJZNfYKa712ROKr+r9Rk4
         qGdtiMuCRszgwrCHAJJjRnexVCIxsfCHzhDwGJX5eQsErIQU6mWl0wjmZPSFZnpVoYKS
         c2Vu8GfhljUSnt83/+cd14+3OdEFjvAn34SQYN/jItEcyve6M+P893YCTbWBuXgjsnzZ
         Q4/b0fXMQuvNsI3kRdDTa0zU+Dn2wrPPt0JanLV2LVRv+syWDQNVw2P2VcfXC6d/XFI7
         QGSw==
X-Forwarded-Encrypted: i=1; AJvYcCUYRJCunkxk1YRErAw4E2BsixDQ67/0DZyqdfEkkjPHUQQzWk4FAYjniNI7BduM+glfb24xZcVkBFd4Nao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx/jYdhhkq2PLPNlmwJOo5+9lRAHgxGGwuXZx3jy+fCpLGO6X
	1cId4hv9mBz4jj1zmj8vbNTgkjJ1po/O3YIHF3Zy/ACkC84/0BPpmtgDAkqWnEG87Z5CG0QVoAc
	Zu0xsKI8lOWFGljKoPrGxwcJMSE/ypIRG4wkjlaIct0JBM3Hf/u36irEMzkcKR2N0kti5fCMhge
	Ul
X-Gm-Gg: ASbGncsEZGx4qe+CJvozJVdQeCnOLdJBdD2doX1u7Bqg8CiqEJY2nqN2owt9STvcCe9
	K0J1ivo09wVjNvmPu0EhSu444j1TT4JMR+anziOQMsS9i7wjTH3M0mxYl5rsV8twUAr61/hDQR/
	TfQIIb402FbhDqkhaGwgZ/mZPCvHvmhHJKSAwpHUWhjmD6pTyCTi0DAgijIMzIA3Iwut5PYaGL5
	11P/G6O5Y2vY6o+N+rURoi7gdwhn+cFk9qJygFZQc5THu+YFRWBdRaqrGfhtFFI7PR4cFo6jhWb
	1SG/eXyMveLtlKAynrXSXeWiOvUZ5tDDJa0=
X-Received: by 2002:a17:90b:3a91:b0:329:f535:6e48 with SMTP id 98e67ed59e1d1-33b513a1f54mr36206167a91.36.1760501001440;
        Tue, 14 Oct 2025 21:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeB00/IAiV2A5VWR2GpIwimPRs4bIDRky9OnqOTaOwRvemdHPVbmX+QZZKvd8185HR/P1l4A==
X-Received: by 2002:a17:90b:3a91:b0:329:f535:6e48 with SMTP id 98e67ed59e1d1-33b513a1f54mr36206138a91.36.1760501001077;
        Tue, 14 Oct 2025 21:03:21 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:20 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH rust-next v2 1/3] rust: fs: add pos/pos_mut methods for LocalFile struct
Date: Wed, 15 Oct 2025 13:02:41 +0900
Message-ID: <20251015040246.151141-2-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015040246.151141-1-ryasuoka@redhat.com>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pos() and pos_mut() methods to get and set a file position.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 rust/kernel/fs/file.rs | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index cf06e73a6da0..bda6cc540dfe 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -283,6 +283,23 @@ pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a LocalFile {
         unsafe { &*ptr.cast() }
     }
 
+    /// Create a mutable reference to a [`LocalFile`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of `'a`.
+    /// * The caller must ensure that if there is an active call to `fdget_pos` that did not take
+    ///   the `f_pos_lock` mutex, then that call is on the current thread.
+    #[inline]
+    pub unsafe fn from_raw_file_mut<'a>(ptr: *mut bindings::file) -> &'a mut LocalFile {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of `'a`. The cast is okay because `LocalFile` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &mut *ptr.cast() }
+    }
+
     /// Assume that there are no active `fdget_pos` calls that prevent us from sharing this file.
     ///
     /// This makes it safe to transfer this file to other threads. No checks are performed, and
@@ -337,6 +354,20 @@ pub fn flags(&self) -> u32 {
         // FIXME(read_once): Replace with `read_once` when available on the Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
     }
+
+    /// Get the current `f_pos` with the file.
+    #[inline]
+    pub fn pos(&self) -> i64 {
+        // SAFETY: The `f_pos` is valid while `LocalFile` is valid
+        unsafe { (*self.as_ptr()).f_pos }
+    }
+
+    /// Get a mutable reference to the `f_pos`.
+    #[inline]
+    pub fn pos_mut(&mut self) -> &mut i64 {
+        // SAFETY: The `f_pos` is valid while `LocalFile` is valid
+        unsafe { &mut (*self.as_ptr()).f_pos }
+    }
 }
 
 impl File {
@@ -356,6 +387,23 @@ pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a File {
         // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
         unsafe { &*ptr.cast() }
     }
+
+    /// Creates a mutable reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// * The caller must ensure that `ptr` points at a valid file and that the file's refcount is
+    ///   positive for the duration of `'a`.
+    /// * The caller must ensure that if there are active `fdget_pos` calls on this file, then they
+    ///   took the `f_pos_lock` mutex.
+    #[inline]
+    pub unsafe fn from_raw_file_mut<'a>(ptr: *mut bindings::file) -> &'a mut File {
+        // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
+        // duration of `'a`. The cast is okay because `File` is `repr(transparent)`.
+        //
+        // INVARIANT: The caller guarantees that there are no problematic `fdget_pos` calls.
+        unsafe { &mut *ptr.cast() }
+    }
 }
 
 // Make LocalFile methods available on File.
@@ -372,6 +420,19 @@ fn deref(&self) -> &LocalFile {
     }
 }
 
+// Make LocalFile methods available on File.
+impl core::ops::DerefMut for File {
+    #[inline]
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
+        // valid file for the desired duration.
+        //
+        // By the type invariants, there are no `fdget_pos` calls that did not take the
+        // `f_pos_lock` mutex.
+        unsafe { LocalFile::from_raw_file_mut(core::ptr::from_mut(self).cast()) }
+    }
+}
+
 /// A file descriptor reservation.
 ///
 /// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
-- 
2.51.0


