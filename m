Return-Path: <linux-kernel+bounces-853718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B0BDC665
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2568318A8746
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E382FF644;
	Wed, 15 Oct 2025 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHNYE0kL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9A2EE5F5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760501019; cv=none; b=fIKGXRH90JHdliPoGY6yfDn766eDiiDZKtAM16FnN5vailg8dCkO4NXiXUknI+Xt1aVazXHEeQPznRKQkk2vXsY4eN04+pCdO3G3VlvWO2d4YK8wSXOY9f8+KLa+li6GHLUe5qkJeEkUzWjOI0jwQxu949eJt+Adrgc1bGd19Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760501019; c=relaxed/simple;
	bh=MUM+uW6qnDu0apC4KR7QWlmonTleTGezmIe8a4nc1Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTkXMoiyj3keKcAR3uw47ek3M9odTfD56xvL0FacOjF72JiUytsQ2V3rEASV22EYp4SLzPrj4bq20ReicrqUaXZ+EiL0n923DEaFN9WbLEk9N05UuvCgwtsLf4uwEFMSr9PQ0l+BhLMDM/F7xFP0XmPywHuzGVp5utVJ77Ghxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHNYE0kL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760501015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5ohKs6qKbp9M57nvQdcRMhKqmCNN3hHdO4AybKNaC4=;
	b=NHNYE0kLseEuBSWKqB0W5+v5Bx+0CBp3ntb7/IgRkq9YjvSWBbVDA8iNMcp5Zxnr/3J6M1
	3qAh3sJ5P/KyKvxjKd1ebuEx/nslEid07zJIs/oP4Ed0OhegqJcIlBuhoJM1vcDb2SzlPK
	abvZlPbrBHapQtVxS784fFTL1caH2Ak=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-5zGpuEAoOU6dY1lmcKcmCQ-1; Wed, 15 Oct 2025 00:03:31 -0400
X-MC-Unique: 5zGpuEAoOU6dY1lmcKcmCQ-1
X-Mimecast-MFC-AGG-ID: 5zGpuEAoOU6dY1lmcKcmCQ_1760501011
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so9259850a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760501010; x=1761105810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5ohKs6qKbp9M57nvQdcRMhKqmCNN3hHdO4AybKNaC4=;
        b=vJKCmmSZejW5fxd65eROADOuOUBgrxtGA+nEZu9+kQfSE93srlr+0e2MlkgqMY+IRN
         SivKIkRkPs4ENmklb4rPNjQLvjO1CN8fFAwMFcO8OqEZgVIkCI8bQA6wltn8fpyePKBi
         XQa6RNfrtTDO4YaXjtzkDP2hHhdeKdBe6FBSWJuRTjgDFG0g8/cHJHUQguM6JzJuh+vV
         PAU7QcFINZ5XxlP2Q6VYtjBY0g/4e02GI/zsN9e9hD19XFs3oiRbqIG71j5/1gdKx4Hc
         rQbRzLCPpQNf1wdqli4Gtt9Xqd/cw8OcUbowKsjGryBP+w6+MkaSZkyCrstBXDO757DX
         KDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFuLzAf7e2TPcm7ExrsmPRmcRxFd246MJHCrUGbQAOk/qAEddFf2NkAHGNM8jGpYn19r48k03GDhywk9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRA9bjrs37qsE+GAkpN3CbZ1Wt4n67qOc7ZSjPREXAJOCIdTA
	n83ilq/BuZ4Y7zh40GsfHovUblsMtCxiR9Mx4FGwDbQzbJx9hdSXAdM6A4YqOFbodKSZDzkEix/
	kt/FD45G9QjIviiL9HRiTXHCfw+R9SQv31Gwzo6gTcruLDmD610ob9znsk5mMsiSI7A==
X-Gm-Gg: ASbGncuu4mN6ZXT1Hhd+FMZc2v4ySGDqbhnVtmF4WbKE1gWTDkojpwTSLSVNe6Mo0mN
	XKp605nrBElmIDYDU5SNaQQCXpmWVBmtg0uqyjet78xucSWNacK5bN5a1K4zNixbeMRGKD6qMD/
	zKQIVVjlE6RN8V0hjgC8L/ulMgb5VHr8N5vRbRjihNIslpm92mZXRG5knjAAR3uA5KGE1ueFqxb
	lqP0t4EDapkBiayU3apaSIrtQK503YHpxaQnNQNbfgpFDo9VOlz1DcOLD/mtDG8Xhrzcm6RpfzL
	suLR9tN3bbip3PrOoBuvxcXuQkeXaf2rKAw=
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr37028097a91.3.1760501009928;
        Tue, 14 Oct 2025 21:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuLhwfwk717yOcd8hPJjqG2qML+HfCGwgfNoBL1CNQBuD1WSe9rogLQkLlfQFnzLiekkeHRA==
X-Received: by 2002:a17:90b:4a45:b0:329:cb75:fef2 with SMTP id 98e67ed59e1d1-33b5111731amr37028057a91.3.1760501009473;
        Tue, 14 Oct 2025 21:03:29 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b978607cfsm608006a91.9.2025.10.14.21.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:03:28 -0700 (PDT)
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
Subject: [PATCH rust-next v2 3/3] rust: samples: miscdevice: add lseek samples
Date: Wed, 15 Oct 2025 13:02:43 +0900
Message-ID: <20251015040246.151141-4-ryasuoka@redhat.com>
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

Add lseek samples in Rust MiscDevice samples

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 samples/rust/rust_misc_device.rs | 68 ++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
index d69bc33dbd99..7f227deef69d 100644
--- a/samples/rust/rust_misc_device.rs
+++ b/samples/rust/rust_misc_device.rs
@@ -12,6 +12,7 @@
 //! #include <errno.h>
 //! #include <fcntl.h>
 //! #include <unistd.h>
+//! #include <string.h>
 //! #include <sys/ioctl.h>
 //!
 //! #define RUST_MISC_DEV_FAIL _IO('|', 0)
@@ -19,9 +20,11 @@
 //! #define RUST_MISC_DEV_GET_VALUE _IOR('|', 0x81, int)
 //! #define RUST_MISC_DEV_SET_VALUE _IOW('|', 0x82, int)
 //!
+//! #define BUF_SIZE 16
 //! int main() {
 //!   int value, new_value;
 //!   int fd, ret;
+//!   char *buf[BUF_SIZE];
 //!
 //!   // Open the device file
 //!   printf("Opening /dev/rust-misc-device for reading and writing\n");
@@ -86,6 +89,40 @@
 //!     return -1;
 //!   }
 //!
+//!   // Write values to the buffer
+//!   char *w_buf = "ABCDEFG";
+//!   ret = write(fd, w_buf, strlen(w_buf));
+//!   if (ret < 0) {
+//!     perror("write");
+//!     close(fd);
+//!     return errno;
+//!   }
+//!   printf("Write values to the buffer: %.*s\n", ret, w_buf);
+//!
+//!   // Read values from the buffer
+//!   lseek(fd, 0, SEEK_SET);
+//!   ret = read(fd, buf, BUF_SIZE - 1);
+//!   if (ret < 0) {
+//!   	perror("read");
+//! 	close(fd);
+//! 	return errno;
+//!   }
+//!   buf[ret] = '\0';
+//!   printf("Read values from the buffer: %s\n", buf);
+//!
+//!   // Read value from the middle of the buffer
+//!   memset(buf, 0, sizeof(buf));
+//!   lseek(fd, 1, SEEK_SET);
+//!   lseek(fd, 2, SEEK_CUR);
+//!   ret = read(fd, buf, BUF_SIZE - 1);
+//!   if (ret < 0) {
+//!   	perror("read");
+//! 	close(fd);
+//! 	return errno;
+//!   }
+//!   buf[ret] = '\0';
+//!   printf("Read values from the middle of the buffer: %s\n", buf);
+//!
 //!   // Close the device file
 //!   printf("Closing /dev/rust-misc-device\n");
 //!   close(fd);
@@ -114,6 +151,9 @@
 const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('|' as u32, 0x81);
 const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('|' as u32, 0x82);
 
+const SEEK_SET: i32 = 0;
+const SEEK_CUR: i32 = 1;
+
 module! {
     type: RustMiscDeviceModule,
     name: "rust_misc_device",
@@ -204,6 +244,34 @@ fn write_iter(mut kiocb: Kiocb<'_, Self::Ptr>, iov: &mut IovIterSource<'_>) -> R
         Ok(len)
     }
 
+    fn llseek(
+        me: Pin<&RustMiscDevice>,
+        file: &mut File,
+        offset: i64,
+        whence: i32,
+    ) -> Result<isize> {
+        dev_info!(me.dev, "LLSEEK Rust Misc Device Sample\n");
+        let pos: i64 = file.pos();
+
+        let new_pos = match whence {
+            SEEK_SET => offset,
+            SEEK_CUR => pos + offset,
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
+        *file.pos_mut() = new_pos;
+
+        Ok(new_pos as isize)
+    }
+
     fn ioctl(me: Pin<&RustMiscDevice>, _file: &File, cmd: u32, arg: usize) -> Result<isize> {
         dev_info!(me.dev, "IOCTLing Rust Misc Device Sample\n");
 
-- 
2.51.0


