Return-Path: <linux-kernel+bounces-855144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8349BE0623
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 846AE358039
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B519A3101B0;
	Wed, 15 Oct 2025 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7LPK/2Z"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E930FF21
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556319; cv=none; b=upkJTDwUe1R/IxqTYJSCfeXeWSpRxGG7MKiR8zIvtf+kMydpJjNz+l+c5gNA7/CHwKsCulF+FAF+EJWsvytPjQXzOhooBkyvvA4PWpClGsdSnxQBhz4cmCsDyEqYyoQ2qYdEwxSUUJ0wv5VfC3HbBgrBLJfnKpVG46SMDMufwVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556319; c=relaxed/simple;
	bh=dVZb5Pcu1XHbZt2SW9FpYlV89iSmsSjiuXxsiQfQLK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pW/7M11vR0GidYmwB8ieqIBIjABK1tTmr6Octq2AIefAinyqI4Se3ybhSV2FgypooNeu4r13LtDne4E0nXCwHYsWrSJtScN0Q9ZW/y9g7odgS4YUzVLDlZZNHbuIZZDgQltiDboar4RjYRjsoYvtnSBj/YJHUk7DnnlT5MO0dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7LPK/2Z; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f15d58576so16571416d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556316; x=1761161116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcA+z8eYaRvOgVrZmY/xhbxjfSBJr0w9ghrKai5yQJ0=;
        b=A7LPK/2ZcjAQL7xVWJxRF0OckSL4EAYosmXjxRhaDABPim0FoifmCoQ8mQAampIf5B
         4jZRg5pwl75YHnlKyC22D8S2So9lb0zOgShysSwArYVYsW82bUXfh1iDgY2pnEsVr/8Z
         yGS12//9A2cCPi1raUg+rJ7IQt/YzJN2wImtSdvLw8XY0/dXHaxQpTgDOTnqDcxWcute
         QJdQTwwWMH/ibrbT6cTbKqeXJX10RMUqBS0OFXREuYLGgSdo6qfFC0oZJENulhbLbgA4
         Fig9gTCGtlIkaxrlmVrBJRi3bX6HkJQ0OXJidjO03JftgSDUsKJg+hV5Z3bcSA4r2ESd
         epuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556316; x=1761161116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcA+z8eYaRvOgVrZmY/xhbxjfSBJr0w9ghrKai5yQJ0=;
        b=CF5/IuyNBePP4bjTindzepMO5jvYGFE9MewUxskHgOzf4O8hqoQoprIOpifvjlGigB
         LxmlNpbyC3n6GDOsLNIOx5OVBvdIlEIUO6RyI0YI4y3aW0yU8GDUAJsajmXkr/MC3eiE
         gxnZWZJqaHvYeq0zvTs99mLhFlKvCiNL4sHzH54vMIhm+S2JgrVp/QI4sOFtxGdV6Uu3
         P6c6bzbMZqqs3E1tiTgZALpIwrFEK+ZQAgOlEwRfpgh2h4uoFR/E/aTipKWXnYHcZNHW
         Ez8koNmnzGyHj047xHL14orZzm5O2to3XbWC1LgRlB3Vyvk6KzTh86no64YybUrNnjMN
         L43g==
X-Forwarded-Encrypted: i=1; AJvYcCWa3G7rqxXTN5Rz+jZv1xDcPqCt2qfFx+zgJUTlMXQ7pfwi9qB7/5jsvkh70a9bRAaXrqv5IFXSmwOqRIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytk9TJnjw/MrdumSOni0tWkxF9kAztu/KTs35hcsxeZ3sVpXvc
	F9flblZPVONlHBzqkPcVMyiy6nm6mHoeeSjfyydTDrI0/c9xO2Hofggv
X-Gm-Gg: ASbGnctASF/1oDMup3hPNUgJ5KXQNDLKhsbuo3DvMWTWdvGkrN+720alYZnTWvTCtjb
	6JlfhzKmMOAx8MYEcPs5NMgqii8NXEuwMO3W6IX633jEOCiimTgbwDQoQvpmoL3pd5Bqg0927jE
	6lf/Jz3o29jtHNC8MjkKrIPvDC1+4IsiGlC7XmUHZ+FvLUhHGmo9fe1jFneuWhn8wpH3BvLc405
	bNECrj58/MtesiUjuz8XeaSuwt3SHnzPyDeudnQyAqUKGvkWN5cyAnV9sNBNauEUG4Cz68arnmP
	NkS/oQU5vQu8mkVbA4HCqS36m0F8kzwkcyi190DXbD2aJ1G37ZdJtYsbzyqhFV5yk6NTRE5nAuE
	UlC5U+LvrAoKcZCfmethPUWCLr3Movddw2gNCIUVcoWJadMyhAcJ4NYuz2GBZcNa0KTuRDjfihE
	7BwGR70ZcflfcWDkr2KJz46vR2ZnV4IxqHmKSNa6tGwNmluBmMlWlQIy+xp0TmeL+/ofnOtn4Rl
	tM9lB35o3A9qkI3oGpwwdAAGJUPCrzigNvFCxAPEQCFwC2vZj+WjHplDLYYwy4=
X-Google-Smtp-Source: AGHT+IGtrSTY0FUSiNdgbPyhOIH/YvdyU5sl8fvg654fDJk8BbKW5z4ao5A5UXUjIURMYSPijzmsPA==
X-Received: by 2002:a05:6214:48f:b0:78e:f6cd:4704 with SMTP id 6a1803df08f44-87c0c5cd3aemr17462466d6.5.1760556315435;
        Wed, 15 Oct 2025 12:25:15 -0700 (PDT)
Received: from 136.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:8573:f4c5:e7a9:9cd9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c012b165asm24076996d6.59.2025.10.15.12.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:25:14 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:24:37 -0400
Subject: [PATCH v17 07/11] rust: debugfs: use `kernel::fmt`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-cstr-core-v17-7-dc5e7aec870d@gmail.com>
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com>
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760556295; l=4568;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=dVZb5Pcu1XHbZt2SW9FpYlV89iSmsSjiuXxsiQfQLK4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIygDVPZERtANioDtpZsLIsIx6DMuRfppWFXkHaK3hI5+YEfWJFA0uNjCcv/4Z25JqUAs3bOoMG
 11/p3YDZDuQA=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Reduce coupling to implementation details of the formatting machinery by
avoiding direct use for `core`'s formatting traits and macros.

This backslid in commit 40ecc49466c8 ("rust: debugfs: Add support for
callback-based files") and commit 5e40b591cb46 ("rust: debugfs: Add
support for read-only files").

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
2.51.0


