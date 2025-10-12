Return-Path: <linux-kernel+bounces-849477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E725BD0355
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54051895030
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0F283CA7;
	Sun, 12 Oct 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co8vOhR4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C631283CBE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278827; cv=none; b=RgWrJ+Opcdm7bw1J1/iqhF4ugBMwPMebJhvpaYkFxIuOY4VOORfKeGI0pVnsabY+oG9h+73J531s3VMrPf+7T7xDONu/ngBmGu1FLYVfexo+x843xHjEaOoN5YajqY163iPXwsi6levxkTZaGaV/X9IRxVG2mvnKeJGtEqkBcmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278827; c=relaxed/simple;
	bh=2k6zfbV5v2cf+4wgu/XCSpdhWf+Wu46HVvzRy5EuNf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mI5zcLo3MezwCddO1jGOiqAdRs7UmRO02xokTT4812oBkU4EOWPwuHWuNOyE2pTKwOQXlM+H66FmuIbdgzzexiCxST5enAvHQrf85dGbS3Ojn/Ex6PnDilbWGGSQY8Kr1ovy/0RTk84L390HtC5i/vjwdKfcFnBMrG6EB9drWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co8vOhR4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f898fso47016305ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760278824; x=1760883624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hfkmdzafh7+VHjG0RAeg5sF4FBAljqq3jIvcOzngZlg=;
        b=Co8vOhR4jNm0dn3Aoz4mtvMDX+V3QoxoynHZgrs3wbB7HQ2mTAI/77rJPCTa3ldC2J
         o9HkYQfL7s7fD/xprG06pkSlybgXnnbF+aTXrt6is8hrCOcfgE76euD/tQ1+TDld5Qcf
         PmFIeiCp/EgefscWXP9AKCQKLDUcD3EFmwmiXwL1LlPLxKGVP7lWFpRyMFvD/0qcJA5q
         mu2Jrbd7cVWTRQQRC4ZU/ggQUPBf7AkyLmT0XqtyHgsyQGBWsXeNfPW14TmRmwhQR7p/
         ii7Aib7KVOI7wG0dc7eYhwLShseVFT+/eiHLlriKcIrnONnokn84BNUe/e/3N5V6V7mF
         4ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760278824; x=1760883624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfkmdzafh7+VHjG0RAeg5sF4FBAljqq3jIvcOzngZlg=;
        b=nDfUnGhqnO4RaDtcDkD+rxYTxuOcznNNS3VLTkSlnyCAuudqFsIpWtUEwpHIBerB37
         agv2RYNlgQK6yQ7Of0Dz+bHYh3JASYSxzVHNBwDG9H4NcHxXYorWGm28FF0rFhVhPbgG
         9kpTlnXuKL3k5bR0mZJdMLdLLwFdnb5TcpNOs4NDsaLKcaU4iqVYDmD8f2M+b3xwumjK
         4J88z0nXYB3uMpPfb95/QgokjFmo6TN00viEJTtQru6VabkUSERENjb0viPRwWO38kYi
         AtWqtjQGQW7lst41D5mWupOy98oeRLhbkbeJljh9NqIYYabBydlanMDMKCNBTZqQmuAx
         NTQA==
X-Forwarded-Encrypted: i=1; AJvYcCU6TWwrjKDD/AP7IP2gj8XsLfFGzeztHzyANZ9QWOBa7oVdGgyLSvMBGx2xC8iRmo0wyD2hWh9bXnOkBu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUsXgof6/DOVzLEXYD+ef1PqCar8l4fPbmjfRBPoY+5zq+n7/
	POOUO5gMeuMn/EGESr9QOK9A7vokZ7/+qlRHxQfpekkk061goF+6z82I
X-Gm-Gg: ASbGncvATfL0qKGx8BfHBXgQL/8OKFvIGLQEhKU57Z7Xig1VO+Xma6sUGIcSg6tjEw7
	dfFsxdpW9oQF2sn89ihRVP1tONmRyVaNcv4IvBmu33XT4pm6co3ttOgyFBdHaXPvabtb8u2uVTI
	8mP77RX1qSAo1RtMlvt0xgte13ZLOKQh3e8mHn4WZztKyuifsqyX/4AYVdaKNOFz+9F1jn1dcp2
	wqhQJgRHIbHAn2q50RF0Q7jFHW9LVOVUvT3Gax+nG7pk4UlieIE3fOq6J72svFSK1JRSUYGO04J
	9yaCFGqoo5Gx35N246n9rtol+I0JkWA96z7n894c6YiO5RLWY1kW/Q/aUOR+qc//2fF3tip9qjC
	ImkkdFrqS6A6q1nRsS7qjq86iWAKQ9I2yu3ohwQiG/GtSAgJmHYLketu8qQ==
X-Google-Smtp-Source: AGHT+IFjutP7obK0TADVT6/jr5reX7v34JHSR9gBVaHhK88qEC2UiRaBIKkiBy1t0yjPHCjcIVALCw==
X-Received: by 2002:a17:902:e786:b0:26e:7468:8a99 with SMTP id d9443c01a7336-290272c18e1mr224136745ad.36.1760278824509;
        Sun, 12 Oct 2025 07:20:24 -0700 (PDT)
Received: from shankari-IdeaPad.. ([49.128.169.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f089a3sm108167325ad.76.2025.10.12.07.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:20:24 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Shankari Anand <shankari.ak0208@gmail.com>
Subject: [PATCH v2] rust: block: update ARef and AlwaysRefCounted imports from sync::aref
Date: Sun, 12 Oct 2025 19:50:12 +0530
Message-Id: <20251012142012.166230-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update call sites in the block subsystem to import `ARef` and
`AlwaysRefCounted` from `sync::aref` instead of `types`.

This aligns with the ongoing effort to move `ARef` and
`AlwaysRefCounted` to sync.

Suggested-by: Benno Lossin <lossin@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1173
Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
Changelog:
v1 -> v2:
Rebased it on top of the latest linux-next upstream commit
Dropped 1/7 from the subject as it might lead to confusion of it being a series
Link of v1: https://lore.kernel.org/lkml/20250716090712.809750-1-shankari.ak0208@gmail.com/

The original patch of moving ARef and AlwaysRefCounted to sync::aref is here:
(commit 07dad44aa9a93)
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440


Gradually the re-export from types.rs will be eliminated in the
future cycle.
---
 
 drivers/block/rnull/rnull.rs       | 3 +--
 rust/kernel/block/mq.rs            | 5 ++---
 rust/kernel/block/mq/operations.rs | 4 ++--
 rust/kernel/block/mq/request.rs    | 8 ++++++--
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 1ec694d7f1a6..a9d5e575a2c4 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -17,8 +17,7 @@
     error::Result,
     pr_info,
     prelude::*,
-    sync::Arc,
-    types::ARef,
+    sync::{aref::ARef, Arc},
 };
 use pin_init::PinInit;
 
diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
index 637018ead0ab..1fd0d54dd549 100644
--- a/rust/kernel/block/mq.rs
+++ b/rust/kernel/block/mq.rs
@@ -20,7 +20,7 @@
 //! The kernel will interface with the block device driver by calling the method
 //! implementations of the `Operations` trait.
 //!
-//! IO requests are passed to the driver as [`kernel::types::ARef<Request>`]
+//! IO requests are passed to the driver as [`kernel::sync::aref::ARef<Request>`]
 //! instances. The `Request` type is a wrapper around the C `struct request`.
 //! The driver must mark end of processing by calling one of the
 //! `Request::end`, methods. Failure to do so can lead to deadlock or timeout
@@ -61,8 +61,7 @@
 //!     block::mq::*,
 //!     new_mutex,
 //!     prelude::*,
-//!     sync::{Arc, Mutex},
-//!     types::{ARef, ForeignOwnable},
+//!     sync::{aref::ARef, Arc, Mutex},
 //! };
 //!
 //! struct MyBlkDevice;
diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
index f91a1719886c..8ad46129a52c 100644
--- a/rust/kernel/block/mq/operations.rs
+++ b/rust/kernel/block/mq/operations.rs
@@ -9,8 +9,8 @@
     block::mq::{request::RequestDataWrapper, Request},
     error::{from_result, Result},
     prelude::*,
-    sync::Refcount,
-    types::{ARef, ForeignOwnable},
+    sync::{aref::ARef, Refcount},
+    types::ForeignOwnable,
 };
 use core::marker::PhantomData;
 
diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
index c5f1f6b1ccfb..ce3e30c81cb5 100644
--- a/rust/kernel/block/mq/request.rs
+++ b/rust/kernel/block/mq/request.rs
@@ -8,8 +8,12 @@
     bindings,
     block::mq::Operations,
     error::Result,
-    sync::{atomic::Relaxed, Refcount},
-    types::{ARef, AlwaysRefCounted, Opaque},
+    sync::{
+        aref::{ARef, AlwaysRefCounted},
+        atomic::Relaxed,
+        Refcount,
+    },
+    types::Opaque,
 };
 use core::{marker::PhantomData, ptr::NonNull};

base-commit: 2b763d4652393c90eaa771a5164502ec9dd965ae 
-- 
2.34.1


