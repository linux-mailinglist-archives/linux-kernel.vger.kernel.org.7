Return-Path: <linux-kernel+bounces-853717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B2BDC662
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296834E9C97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518B2FE57F;
	Wed, 15 Oct 2025 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmgtgL69"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B52FB08D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501013; cv=none; b=Zo7MBTOsHlXWbI/nZat3SGpCQHGpFivw8Q1A7aZdAHVtufnNJZzRIF0Mx0L4Qowkkk678OvK2a35An7vJztaQqni+LrqJFw8cUwacyrWZ04rTpkjKQOlce5HukEReD/x2Gjdlhtv3YnZkl5MwkEmMzFrt0nPNNWxoeqWeqtLVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501013; c=relaxed/simple;
	bh=N/Hg0cUpSuxjkf/64ySl79HzvAfeUdFUvUkHgBa06ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqqgrDGdotR01fOF2/P6M4p82IbGDbOQHjPISH004EApxGGLu3tFXwL+ON2l1YKUk6VnnpOth1IKJR7btTZHWAe1nOct+VErxO0VGy1DCYH+NM512MqEWMNIwNINRYIaKxAfB1GfyIxa/SqRk+M/G2Zd91STSMkABhG+wvV4W1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmgtgL69; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/cTJtwMXIeLnmZnv2DTXzRty+qoslZ2OR6cifyBicWw=;
	b=PmgtgL69gmyp6LxvqgrZ2u3Un3oYOUNrvD+JndCL7RCGXhlGzr2l5obyYZM1yRVLDiXwlv
	4VkY0Czg9T0TAE0vVtj/NK+I73QkFWG0tITD3pp+wRJK5bQKywtoZyHfSqCPfATlevRips
	C5fmGeu+x/i+ki2ms8JSxBXAuhNdPR8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-K0kRqrx2Nsiyq8b4XzRQtw-1; Wed, 15 Oct 2025 00:03:26 -0400
X-MC-Unique: K0kRqrx2Nsiyq8b4XzRQtw-1
X-Mimecast-MFC-AGG-ID: K0kRqrx2Nsiyq8b4XzRQtw_1760501006
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-339ee7532b9so27072993a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501006; x=1761105806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cTJtwMXIeLnmZnv2DTXzRty+qoslZ2OR6cifyBicWw=;
        b=PuKQutKPk/L6q2NQU+PX6cdJG8ajojf9N3nUlM74ugq1EVwlKbFJNCgK5hBfUVUZvC
         vYft4mehLiA6h7TNGTWMDA8R9qUymjfqt9shk8IiG1tqHKDjlM0n63QfXvqV83JmaLQU
         HLuXJxRs7ZZ0QRqERh4998iJbUbX8dY5cXxKv+YK/SAdeghOlckYvtPe2YMJMO0r1L9z
         4poJQyXxUgDOrtxYT1HttH3CsLSYzkC6zALJjEURlfvZw4iIBhA8vM8Bx5FHf2nJO70o
         5Y5rdRkVQGxTEn2LrEZPDMQNrGdWd83xWgsEg022yqkSJ1GtJZ0zBx081mNCYtwKKaYz
         UDtg==
X-Forwarded-Encrypted: i=1; AJvYcCVjYyJFENuUKzv3156lNZjBI2lkKoEHEO8/9CoMP8N/6RQsaJlStGOB8FwLB2T7kHo5BypiY/JenKZZOOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSUwMB1Tf69VZQSn9/K5WuzNST5ZvjTpaxdHtd6KPFJoUW8Bt
	DymuNPhdS+K0Zn/15gSqrzNsjkwpp4ROWXjBzGgv/7K9Wiz1rrdCk8SPx5fCvMCSTNjZ/NfESXt
	UWzxc3F59I5w+ds5myVEBlzOfZtgkDSGnP3FgaJqBgVbXQtdGymzcxEjjT67uXe6Phg==
X-Gm-Gg: ASbGncuRd10tKNEhFYlIdiN5S8jyqnMoKvZrVl54Ms1PFV2C35usWZsZZVdnXEF1Zdp
	FeZNH8ihLO1i5XBhT4E9e+7jzSYvihyYucHorEPtdCzOfzHMXYsCAvg9wvcDOn6UbFbZJ6LQ60+
	V71ZJyKuvGfXe2GNCqQMa3cUkuYjIvcWUuuhfcoJRfZCsbXJobWdbnaVP8MnqdsskHXL+bftlRF
	whYnNzTgFkhVnw5sPOx82OXrMZFR3t0gy9OQveqRVrVSLPJyD86tV0AAJA9uRcRYOI36sIFM2nd
	JN1QY0D0veq3HDJBb3zID9iwuinEdO1f+psAFm8M6lACxTG1K9fk3Wp9pepAj3i5/yZugQ==
X-Received: by 2002:a17:90b:33cc:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-33b51118ee0mr34810892a91.13.1760501005667;
        Tue, 14 Oct 2025 21:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRzf7FvM8OpEXrg7e1JvlWOpwl6hxFANdBMkZkYCR63zSreZUiUYv4PdbI0oENdYzK01tTDw==
X-Received: by 2002:a17:90b:33cc:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-33b51118ee0mr34810857a91.13.1760501005275;
        Tue, 14 Oct 2025 21:03:25 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:24 -0700 (PDT)
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
Subject: [PATCH rust-next v2 2/3] rust: miscdevice: add llseek support
Date: Wed, 15 Oct 2025 13:02:42 +0900
Message-ID: <20251015040246.151141-3-ryasuoka@redhat.com>
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

Add the ability to write a file_operations->llseek hook in Rust when
using the miscdevice abstraction.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 rust/kernel/miscdevice.rs | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index d698cddcb4a5..2efd0847cde1 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -126,6 +126,16 @@ fn release(device: Self::Ptr, _file: &File) {
         drop(device);
     }
 
+    /// Handler for llseek.
+    fn llseek(
+        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        _file: &mut File,
+        _offset: i64,
+        _whence: i32,
+    ) -> Result<isize> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Handle for mmap.
     ///
     /// This function is invoked when a user space process invokes the `mmap` system call on
@@ -296,6 +306,27 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         }
     }
 
+    /// # Safety
+    ///
+    /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
+    unsafe extern "C" fn llseek(file: *mut bindings::file, offset: i64, whence: c_int) -> i64 {
+        // SAFETY: The llseek call of a file can access the private data.
+        let private = unsafe { (*file).private_data };
+        // SAFETY: This is a Rust Miscdevice, so we call `into_foreign` in `open` and
+        // `from_foreign` in `release`, and `fops_llseek` is guaranteed to be called between those
+        // two operations.
+        let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+        // SAFETY:
+        // * The file is valid for the duration of this call.
+        // * There is no active fdget_pos region on the file on this thread.
+        let file = unsafe { File::from_raw_file_mut(file) };
+
+        match T::llseek(device, file, offset, whence) {
+            Ok(res) => res as i64,
+            Err(err) => i64::from(err.to_errno()),
+        }
+    }
+
     /// # Safety
     ///
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
@@ -391,6 +422,11 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     const VTABLE: bindings::file_operations = bindings::file_operations {
         open: Some(Self::open),
         release: Some(Self::release),
+        llseek: if T::HAS_LLSEEK {
+            Some(Self::llseek)
+        } else {
+            None
+        },
         mmap: if T::HAS_MMAP { Some(Self::mmap) } else { None },
         read_iter: if T::HAS_READ_ITER {
             Some(Self::read_iter)
-- 
2.51.0


