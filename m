Return-Path: <linux-kernel+bounces-859369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FF0BED697
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED5F74F15C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE46426A08C;
	Sat, 18 Oct 2025 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL7XNcaR"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC72DC76E
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809561; cv=none; b=CO2//0bTyshFmuOCUzqJI6CKkjnYvnIb0fXogViJAJZrkmvnBbnxrU12mVvHDVcSf5+YbUoXg0SpyvMUFqZEryE5+ZdXxTqYyLLYl+zoW9bVJZwSp0q+j2qiZeK9CMAQ9wfAjm1tcTHWBgeb1UZjm2eqOiHjERsgoWbZTDfg4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809561; c=relaxed/simple;
	bh=2RO1O8x8vlwhifkhfd816jOQiIu5L43+GQ3qhkZvCCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxZScbTPwzyS1RdIBflBfIUSFLEHpxhYSUd+gqrwji20JH4fjFAQOxq+N2m5BhftXCRrI4aNDH9PVlle+dy4dsLsbquhMsXo+kZ/2ipjhCKn2hIVRxqZBh/dQe4KIl3C0+isIpLpUZQb9O3r/YaA7rCm8mAHh+ouNqW8ouFIGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL7XNcaR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f8f346c2cso447373885a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809557; x=1761414357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a15d5fAvykxuJ32X4GoFun7W4EexMfG4QkmOfbTlvaA=;
        b=GL7XNcaRisIQRpvNANKfLsPUjWi9UKTcVHFQt3rKxT9e6k6Z7Mq4yV0sQYC4gO1Hcj
         sJyg/79Klvel4XnE0xuudtNs0raQqIomw/EIVxnvdo31WaO+XZDR8estB4jBg5M+8DNg
         URsz2s28FaId/vbAeX53DFBXSGYMLHiveLI683yf3JutpfZ5O+XRJc++HP8IxECwm4yF
         8sEzTLFwSqcIbkp2aiMS4Uz39mbuLXRrWx3q5+MShmY6MLypWnyT/l5akGk1mcXye4OV
         c4/9KfD+bGDJBWvS8XUAuaF170gODiUmD4ZCYEr4uNoR8GZj3ycLBqJwQ4imwcR9Sx2C
         r0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809557; x=1761414357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a15d5fAvykxuJ32X4GoFun7W4EexMfG4QkmOfbTlvaA=;
        b=QStK9GoooiHNd1yljouzVPtODFJzqCTHgNc3Q/7/TKRk0JhEFpp4VAv2GxNxtU0Puk
         0EkQGnG7+fGGmyIn7eyVXzh7ldXMcY5E37l7BMZcfyU3szEu7xAtP0wBiFvgv2ghac/n
         wJabQni/TC+AMbyvWvYRstRIA0FUd/AmieetBonnFK7CM+H0vijV/Xqd5TUzTslsQuj+
         MmKGetGhetbc++YdsQz+Dtyt9nk+N3M9/7L2gJFt56zYJzZXDogAjZd9ImPzJsCsbI5U
         VEu3Md+sGmIGyzmXdNrMSG5p7nCLb45EhgGKX3NyEhOxh3lN1jXGFz5z8atQ63ZO6TAX
         1tCg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Y/Z3S0kekyKiUBUXw8QSALBLSofHwEXXUIEvesnRYdLpHSTb2/L3xBVXhOs1/XqnUUTWOR5PWrrMmeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxl0rkdo01JDzXCWJrGTIj3y5dAe2960yQkUq+I/j9ym4iV6/u
	AIcMnezbaQjhnOvfWQ/dlK/1TEhbQ2SnxGdTsy4yYYkc7fIK8+CnIMlQ
X-Gm-Gg: ASbGncsbgOSQga6Aq5ahGrmq8uK9ZwuCqsfawI59hBDlwc++Ydu6+f9BfwrZrppU1FL
	gkDWsQr90vukujxta7YFCXRJBiRb4/6ISCE/OlUrqVPLkhAPnH4cCFRw92edbrDczZTNcpoyioy
	V4aF6cKZPifiP6SFHNmiq5pB2VXOrz6UjKkyoCY14bMmO5sOwpPPfrGTjTNv8KbFFQ4talQR32d
	E79CQehfPyXaTcCA9VKQyr1yZIIQP81J90uwygBdfxaKB5hpIGH0VNnUijehj6iche746XdgF6T
	6j241jN4dWXf3v/PPbAB6kOq7xt1BwYskisGPRaMmog3RVXZf//gzVRHeVQB/gpsEhscoH//vaj
	7xNDLXlJR4VrHlvz5X1kr0TcOLyd5s0lCXWFrBDJKpKaF0yEdgBhLhFT4kKEJAgFQOMLgq2Jf7H
	PoMPnWAAd9CqCUKgx/60zREZ+1t7glWsmB0budRqknp7JF5y46S34qNQapjnGTaRFjJ9zWXKiX2
	0F/UNbOFpsP8T1SKxny8Vj1dCcz4pxCK2ZazRPq0CnTZFKPzWlL2NGzNO2CpruL7dDuALwr2w==
X-Google-Smtp-Source: AGHT+IF0jDSr4+x2H9ezxo4E3+k6pmF019NwUbAdiwnAzhTA8DToLrkpZSznJQWz124+QD1Dm24uLg==
X-Received: by 2002:a05:622a:1102:b0:4e8:b17d:916b with SMTP id d75a77b69052e-4e8b17d949fmr28810291cf.51.1760809556972;
        Sat, 18 Oct 2025 10:45:56 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:45:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:18 -0400
Subject: [PATCH v18 07/16] rust: debugfs: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-7-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>, 
 Matthew Maurer <mmaurer@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=4664;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=2RO1O8x8vlwhifkhfd816jOQiIu5L43+GQ3qhkZvCCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMATZCii+4KTdwmO4cL/e3cZ7fEhaFxHdhr1qxcBeKLRmamGNwC2RJ/lvy+nkubg5+s2N1SC1jy
 AY70o32pQ0gI=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
support for read-only files").

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/debugfs.rs                   |  2 +-
 rust/kernel/debugfs/callback_adapters.rs |  7 +++----
 rust/kernel/debugfs/file_ops.rs          |  6 +++---
 rust/kernel/debugfs/traits.rs            | 10 +++++-----
 4 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index 381c23b3dd83..8c35d032acfe 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -8,12 +8,12 @@
 // When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
 #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
 
+use crate::fmt;
 use crate::prelude::*;
 use crate::str::CStr;
 #[cfg(CONFIG_DEBUG_FS)]
 use crate::sync::Arc;
 use crate::uaccess::UserSliceReader;
-use core::fmt;
 use core::marker::PhantomData;
 use core::marker::PhantomPinned;
 #[cfg(CONFIG_DEBUG_FS)]
diff --git a/rust/kernel/debugfs/callback_adapters.rs b/rust/kernel/debugfs/callback_adapters.rs
index 6c024230f676..a260d8dee051 100644
--- a/rust/kernel/debugfs/callback_adapters.rs
+++ b/rust/kernel/debugfs/callback_adapters.rs
@@ -5,10 +5,9 @@
 //! than a trait implementation. If provided, it will override the trait implementation.
 
 use super::{Reader, Writer};
+use crate::fmt;
 use crate::prelude::*;
 use crate::uaccess::UserSliceReader;
-use core::fmt;
-use core::fmt::Formatter;
 use core::marker::PhantomData;
 use core::ops::Deref;
 
@@ -76,9 +75,9 @@ fn deref(&self) -> &D {
 
 impl<D, F> Writer for FormatAdapter<D, F>
 where
-    F: Fn(&D, &mut Formatter<'_>) -> fmt::Result + 'static,
+    F: Fn(&D, &mut fmt::Formatter<'_>) -> fmt::Result + 'static,
 {
-    fn write(&self, fmt: &mut Formatter<'_>) -> fmt::Result {
+    fn write(&self, fmt: &mut fmt::Formatter<'_>) -> fmt::Result {
         // SAFETY: FormatAdapter<_, F> can only be constructed if F is inhabited
         let f: &F = unsafe { materialize_zst() };
         f(&self.inner, fmt)
diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops.rs
index 50fead17b6f3..9ad5e3fa6f69 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -3,11 +3,11 @@
 
 use super::{Reader, Writer};
 use crate::debugfs::callback_adapters::Adapter;
+use crate::fmt;
 use crate::prelude::*;
 use crate::seq_file::SeqFile;
 use crate::seq_print;
 use crate::uaccess::UserSlice;
-use core::fmt::{Display, Formatter, Result};
 use core::marker::PhantomData;
 
 #[cfg(CONFIG_DEBUG_FS)]
@@ -65,8 +65,8 @@ fn deref(&self) -> &Self::Target {
 
 struct WriterAdapter<T>(T);
 
-impl<'a, T: Writer> Display for WriterAdapter<&'a T> {
-    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
+impl<'a, T: Writer> fmt::Display for WriterAdapter<&'a T> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.0.write(f)
     }
 }
diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb254b3..ad33bfbc7669 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -3,10 +3,10 @@
 
 //! Traits for rendering or updating values exported to DebugFS.
 
+use crate::fmt;
 use crate::prelude::*;
 use crate::sync::Mutex;
 use crate::uaccess::UserSliceReader;
-use core::fmt::{self, Debug, Formatter};
 use core::str::FromStr;
 use core::sync::atomic::{
     AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
@@ -24,17 +24,17 @@
 /// explicitly instead.
 pub trait Writer {
     /// Formats the value using the given formatter.
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result;
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result;
 }
 
 impl<T: Writer> Writer for Mutex<T> {
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         self.lock().write(f)
     }
 }
 
-impl<T: Debug> Writer for T {
-    fn write(&self, f: &mut Formatter<'_>) -> fmt::Result {
+impl<T: fmt::Debug> Writer for T {
+    fn write(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         writeln!(f, "{self:?}")
     }
 }

-- 
2.51.1


