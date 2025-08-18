Return-Path: <linux-kernel+bounces-773773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B888B2A9C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AB46E5EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83900322DBD;
	Mon, 18 Aug 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjGbqSsY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE54322A2F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525594; cv=none; b=eaBHJWvl8+7bgX60aYcqvdoWc+TEVZXpLzTaLS/OBjNJGiXmbycD+4d3wlGW7KOal4bssahouxRMiq1UL7Y4X8U+4+DHjhQJGLqNSwQxmPZLJWr/2vGYQ5y22yiF3KBnhkRPUnByDsYgHaL0lwRHwUmove6B8u4dc6FTHZgMkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525594; c=relaxed/simple;
	bh=Y+NmXte2jVt9vIilx+qaBiTo6qTI0LRZmsoTSTKd/O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTJBXIIK9cLFljTgBy1GL3KygAudVLMlxZThxvcLk316Uxqp1vpahgckY4twKQnH+O+BQjAY3XSJhtzttTZgwQ9Z1cGQxmw3KR+LUEq3K8lwczqe2YAVx+0ts9JpjIb7XSva4ca7y9qk0dHRRxgDaUehSqIP7JMuDTmf/LcXZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjGbqSsY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755525592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YMRGYhZCgVYyf6TKWipcOATVyFwuIq5BqY8EP2wiQo=;
	b=VjGbqSsYvGUY5oXr0OzM7Z8q1SUSlWsaZ89vnCZiJSFK77VRbsiYEgHKgMEWTTmQfwHGWE
	1F4qtATORIU7VH4hpGar5C+/f8NcI4g9feqheANFitXU3G7RTyotRvctxnHnGY0NbkPRQm
	wwW1auXnw74kOZv0MFU2KEocshVbS+U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-009AGrh8P8iV3AxCY-YpHA-1; Mon, 18 Aug 2025 09:59:51 -0400
X-MC-Unique: 009AGrh8P8iV3AxCY-YpHA-1
X-Mimecast-MFC-AGG-ID: 009AGrh8P8iV3AxCY-YpHA_1755525590
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e2506aso3959839a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525590; x=1756130390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YMRGYhZCgVYyf6TKWipcOATVyFwuIq5BqY8EP2wiQo=;
        b=SpO6L+wRQkXUSRMx7P8PRl1WaFrBUN228/YIaFyO3Etkc8pq92Q6h+XtM5A88uwruX
         O9bIPZGqFFN3v0Fndey2qlTSx8pUdl7KFQHW534jODQX3mrMl9CO299PMIhKPYLsUvNK
         pO3NwoGs0nFNSrEW97W1H/7GlraSk1EN3mlIfhwGb2y+vgFOkhIDlO/4YqmviCrVowx3
         AIVQMLSkuBLwEk3MnOqSoy/AENRek0M8xtD90e560Z6VOo1HiHoxU+fAtHT4A2sG2bAG
         ZThJebaDx4c7sy0A95tS1WH154SohvQ8UmcFe5+TnS5J28zsocJ3MjUZX8FObGqzNsmW
         0hvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIb3WelDXWnC6eAast1sntLxEoWzcjZ1BQlyzcIFogiqAxL3OMhhOSuJeIWz9XRhfDLGgT7tbUixxY/O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZLUn4ZXTsLbsdPmGsRaGcgYiJLTGewYo2iQ6AQZeQSRm/OXO
	2XJTMvQjk8EC0Z6o9z/FNLtc+pndKDcQ0RyhDvoByazSAwiPh7mje7Mgd/j/Rj5tSvRm9BSc0RG
	nltmxNboFA17WAbg47hTra5W9coCKXpeZ/gMNJIuSpVhlJS/QwURe3eNhNC+2XuBiQw==
X-Gm-Gg: ASbGncv4AZYGO8eU2Hp7ZQlV9IMSjmUVOjMe4PPmbAHh+2hxwYlYA9TFgU+QKJsEK1t
	RPzFl6goUUD1hDyC2Euu8ETw/6ykwvGae7+s4slD9aGaJ8D1KUAV85aEN92zy4HjGdDF7FUuZh6
	sut7V2sLtNWTQdmyJHwl+Hc8FFlIZ4IgAww4w3EPaqZEyHmUPW6loWx3i65yek8QkpUYlg8bxCY
	VutHpxtLey4XbKRxswGWH4AjQHf3lNfktsaZ4uU482Ihjx156r0h9xWiG5LhkClkj6K9U0GBJ+s
	5F9YyrGhfD2QZVSqwbXgSmSxMEd5MMiFoA==
X-Received: by 2002:a17:90b:5303:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32342121790mr15990085a91.31.1755525589656;
        Mon, 18 Aug 2025 06:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu7vo2Z28+oGIgafdRKdRRdnXgn+83ZqnfwYDbcN4yit1cp5xdUDY79kWLpeCIOW3hf6Uyng==
X-Received: by 2002:a17:90b:5303:b0:31f:1744:e7fd with SMTP id 98e67ed59e1d1-32342121790mr15990028a91.31.1755525589147;
        Mon, 18 Aug 2025 06:59:49 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d60978fsm8269896a12.26.2025.08.18.06.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:59:48 -0700 (PDT)
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
	lee@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rust-next 2/2] rust: samples: miscdevice: add lseek samples
Date: Mon, 18 Aug 2025 22:58:39 +0900
Message-ID: <20250818135846.133722-3-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818135846.133722-1-ryasuoka@redhat.com>
References: <20250818135846.133722-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add lseek samples in Rust MiscDevice samples

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index e7ab77448f75..991a59a3ea16 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -86,6 +86,33 @@
 //!     return -1;
 //!   }
 //!
+//!   // Set a file offset
+//!   printf("Call lseek SEEK_SET\n");
+//!   ret = lseek(fd, 10, SEEK_SET);
+//!   if (ret == 10)
+//!     printf("lseek: Succeed to SEEK_SET\n");
+//!   else
+//!     printf("lseek: Failed to SEEK_SET\n");
+//!
+//!   // Change the file offset from the initial value
+//!   printf("Call lseek SEEK_CUR\n");
+//!   ret = lseek(fd, 10, SEEK_CUR);
+//!   if (ret == 20)
+//!     printf("lseek: Succeed to SEEK_CUR\n");
+//!   else
+//!     printf("lseek: Failed to SEEK_CUR\n");
+//!
+//!   // i_size is 0. So the following task always should fail.
+//!   printf("Call lseek SEEK_END\n");
+//!   ret = lseek(fd, -10, SEEK_END);
+//!   if (ret < 0)
+//!     perror("lseek: Succeeded to fail - this was expected");
+//!   else {
+//!     printf("lseek: Failed to fail SEEK_END\n");
+//!     close(fd);
+//!     return -1;
+//!   }
+//!
 //!   // Close the device file
 //!   printf("Closing /dev/rust-misc-device\n");
 //!   close(fd);
@@ -114,6 +141,10 @@
 const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
 const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
+const SEEK_SET: i32 = 0;
+const SEEK_CUR: i32 = 1;
+const SEEK_END: i32 = 2;
+
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
@@ -173,6 +204,43 @@ fn open(_file: &File, misc: &MiscDeviceRegistration<Self>) -> Result<Pin<KBox<Se
         )
     }
 
+    fn llseek(me: Pin<&RustMiscDevice>, file: &File, offset: i64, whence: i32) -> Result<isize> {
+        dev_info!(me.dev, "LLSEEK Rust Misc Device Sample\n");
+        let pos: i64;
+        let eof: i64;
+
+        // SAFETY:
+        // * The file is valid for the duration of this call.
+        // * f_inode must be valid while the file is valid.
+        unsafe {
+            pos = (*file.as_ptr()).f_pos;
+            eof = (*(*file.as_ptr()).f_inode).i_size;
+        }
+
+        let new_pos = match whence {
+            SEEK_SET => offset,
+            SEEK_CUR => pos + offset,
+            SEEK_END => eof + offset,
+            _ => {
+                dev_err!(me.dev, "LLSEEK does not recognised: {}.\n", whence);
+                return Err(EINVAL);
+            }
+        };
+
+        if new_pos < 0 {
+            dev_err!(me.dev, "The file offset becomes negative: {}.\n", new_pos);
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The file is valid for the duration of this call.
+        let ret: isize = unsafe {
+            (*file.as_ptr()).f_pos = new_pos;
+            new_pos as isize
+        };
+
+        Ok(ret)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 
-- 
2.50.1


