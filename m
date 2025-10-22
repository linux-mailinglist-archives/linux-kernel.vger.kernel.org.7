Return-Path: <linux-kernel+bounces-864089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF732BF9E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96B354E702A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D92D7813;
	Wed, 22 Oct 2025 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwEXPuui"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32526350A21
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105215; cv=none; b=cikEmssbsM29dHDMABtZ2AtU3ddjxgBxkiqpVhIH4K62lhu6NYuYynJ08NWD+8iONQ432ul/pMFbnlDUEIYWvD9R1iqGlx+16lvVVx31Ek4h36mKXq6DA1Y/F5jUjE9QCdomKyBLWc89Qt80mj7ZzKy0pc8sBP7XNktj0rBY460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105215; c=relaxed/simple;
	bh=4SXBTIbBzQS7trSo3Pqcoy4S5AvvRzAQgPXHxuFH5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwLy88+N5jNIbRgCMgVSqkf+19SyYEShWzZAWbKSSlZSufdOWYYMVW31aOWNIMZKThnWpf52FLEaeM4GZVrTMpbMyOzF+7qKcyoDCa5wEgYnTF1hQT55wwkPZpYs1Lhw1tqWCwCDnzoHxpeYhssG8ZRnDIGARodgGjhIfDg4ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwEXPuui; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e883b79269so8853031cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761105212; x=1761710012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xwi9pPyT3FBFmVEwx3v/HgUNb6syohg1ynYObmMc1N4=;
        b=MwEXPuuiRJB2H3OGzGoZOBhDQ3eVLvBNA/noov/zNRvmizc+WVjJ1UcuMkDByyXMVQ
         CXe/zJwAY1yxv2mIhhIFy5zkJ4Rzbcd9Dn/kwgdSjdlaS9mDk4K4OMu0wXlHALBTOGQw
         a4NKOK6lGG2GSjUVHKMTsAGXoD1gL84no9X9x9BgjSVO3ugmRT8yf/HpOjaswqzZQaSW
         +Xqp15e0c6uVK3YHGSNZXf6du62ZkqjpiIE4OqPAyjt3VRDYOnoU3wBqfEKCytQbM7+R
         yW3sV+Xr9elMQqPwOtIxk/qOJCefP48vhAJRHVb62H3wQmvQB2Hdu+1zfn3eJW+RshSy
         Vhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105212; x=1761710012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwi9pPyT3FBFmVEwx3v/HgUNb6syohg1ynYObmMc1N4=;
        b=ht5d3VfJmR1sQ/f8b9Em5oPZWLO1RFCGHxReMvhLSK69WW4XQ2F4Vrq9lOLfeRA1rx
         Zg91XKbiv59M53Y1GnQKMXtrUiVVRkpjJJXUAbsMX3P37m5r+MAb67E/yAvehOC5vltg
         FjcvkFW8or84Nf8mLxlP/QZ5boW/Xjc9mIugaSZEXWJjKOitR5nTKBd6ivXyG4vkr9Dq
         V5Wi1qzWDGa6Kg+T8OTb59/KAIzeMf9gZZMaU/EBhDaAuLBNAaM35/LFc5Frw8uIXpel
         8Z1cR4Z3nnnncw6lhUHwegW+gu8XNj7raavLsjfWMyZGtRuCqxJnOuHnp/GX8cYU5F5j
         89yA==
X-Forwarded-Encrypted: i=1; AJvYcCWAkzvpBf0uo8NwRffWalz/fg8jcRct4a6cU+NzY2SVwWmIjQ/assD4oVtwx15uSkKy1ss1KnGHwEn8qr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PWiQClE5/Pdn0awJYkTfk2/rCXGxZS+d64iX7AtBq3T24ub0
	bWwJsmSOA7Z1+5FSrxGEZN3L/ekqABtmTFLG3haC7EC01QMX6bRs32HO
X-Gm-Gg: ASbGncvEMLPMOfsw/oB8x78s8LqKgssVJIOWeqsLjV6JAszsC6/vRGrwZnhsSqXFzz6
	W3DOgYQaA8dVZv9SQhwVu9FV9eN16EIA/joQnt9gn1PG36w3ps5Ghb8ecMfhRcqF2oAFOXRbGUY
	W6vUiDIC9ed4MRxl9V3GExUJR+EjOkTiS6GviF7LXQsINrnHZxhyYHNaNh2Bq+OToa3icMwFyr9
	r4sOKcGLCJQPqotyzVIjMjcn8/UJtBWSB/xbt/XLh2a8txBDcrEwYmpZ1pQnBPmaL+NaXoC8MOH
	cTOaHdChD1VZYQO6ceGnNKc32adxaWlKKm2sEkBWtqEbvJCse9K0OhFfP6W4h6dXmJnKaFBxtrh
	iBqcCsauz+B9ZCKjE24ZiLh+HOB2KoNSJCDJPERWICpY34W4sgIm0Qd/qYegkNjZa5WKFYLJXEG
	LOiJf4ORg83AhcNQKtqFAGvV1DeRKv5uSVqHcAahNGv+7+z3rbZcKS0WVDVKEtphHc40tiMMrmA
	0zM8wC6NUqYrHk=
X-Google-Smtp-Source: AGHT+IG/XJvd2aOX62N44Ph9hXSKDu373P+gXBwGZnNsgjDS/EyXbwt2p1XlwMEDfnCDOu06g6jH/g==
X-Received: by 2002:ac8:4659:0:b0:4e8:a0bf:f5b5 with SMTP id d75a77b69052e-4e8a0bff828mr177242851cf.73.1761105212020;
        Tue, 21 Oct 2025 20:53:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd098591sm897850385a.15.2025.10.21.20.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:53:31 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 39F10F4006A;
	Tue, 21 Oct 2025 23:53:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 23:53:31 -0400
X-ME-Sender: <xms:O1X4aJ7H1hFJWR8j4Vm_x8CDGSTUJiA16nXtzHpqEF75K_ggCN-YYw>
    <xme:O1X4aC2xt-LdD4JcwZDijLjOogZtPfUtmVBaUi3UHWUrppc6mBr00McYbTkeGDZSk
    4Z2dfUhzbQpGCLM77Xwd1L5d04IIsIlI35Vcu5pyJ4LHHyu-dtgrA>
X-ME-Received: <xmr:O1X4aGl6wq86UG23L0ucXzdmcxDSzleVvsmbQCqxJEHryiJyvRYQOIZXzPZhL6-N8sDB4VxuavcxnjGFomyl9AxMxEnHJlvWmyc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleefhedtieefiedufeehhfevueejheefhefghfehfeevjedvveefhfetudet
    veenucffohhmrghinheptghouhhnthgvrhdrshhtohhrvgdpphgrrhhsvgdrmhgrphenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvght
X-ME-Proxy: <xmx:O1X4aIhNOpnz7dFxrA22IREs4gSJNdFBiFmD5KjADtE7rGoeoXMyQg>
    <xmx:O1X4aLTlmhUDT-i5PPE8dtpVR9qECUc6Y78aaFHBuv_y9srBLosNXw>
    <xmx:O1X4aFghbNT-2SVRTGKkjv4ZwX4blky3lkY31ovfeCKFQn9ub0DEzw>
    <xmx:O1X4aPhhvu_LNNA9Z-nd5ZzjJWtNPlXjeYCMLdgv3sjbSd54srLhYA>
    <xmx:O1X4aNYdz-JzRgXlis8ktZ3NGgtJgUtTRJqBcNSHCtUeE7ct2IJ_f4mK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 23:53:30 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: [PATCH 3/3] rust: debugfs: Replace the usage of Rust native atomics
Date: Tue, 21 Oct 2025 23:53:24 -0400
Message-ID: <20251022035324.70785-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022035324.70785-1-boqun.feng@gmail.com>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rust native atomics are not allowed to use in kernel due to the mismatch
of memory model with Linux kernel memory model, hence remove the usage
of Rust native atomics in debufs.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/debugfs/traits.rs       | 53 +++++++++--------------------
 samples/rust/rust_debugfs.rs        | 12 +++----
 samples/rust/rust_debugfs_scoped.rs |  6 ++--
 3 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index ab009eb254b3..1bcfb3b3dd2f 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -4,14 +4,11 @@
 //! Traits for rendering or updating values exported to DebugFS.
 
 use crate::prelude::*;
+use crate::sync::atomic::{Atomic, AtomicBasicOps, AtomicType, Relaxed};
 use crate::sync::Mutex;
 use crate::uaccess::UserSliceReader;
 use core::fmt::{self, Debug, Formatter};
 use core::str::FromStr;
-use core::sync::atomic::{
-    AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, AtomicU32, AtomicU64,
-    AtomicU8, AtomicUsize, Ordering,
-};
 
 /// A trait for types that can be written into a string.
 ///
@@ -66,37 +63,21 @@ fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
     }
 }
 
-macro_rules! impl_reader_for_atomic {
-    ($(($atomic_type:ty, $int_type:ty)),*) => {
-        $(
-            impl Reader for $atomic_type {
-                fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
-                    let mut buf = [0u8; 21]; // Enough for a 64-bit number.
-                    if reader.len() > buf.len() {
-                        return Err(EINVAL);
-                    }
-                    let n = reader.len();
-                    reader.read_slice(&mut buf[..n])?;
+impl<T: AtomicType + FromStr> Reader for Atomic<T>
+where
+    T::Repr: AtomicBasicOps,
+{
+    fn read_from_slice(&self, reader: &mut UserSliceReader) -> Result {
+        let mut buf = [0u8; 21]; // Enough for a 64-bit number.
+        if reader.len() > buf.len() {
+            return Err(EINVAL);
+        }
+        let n = reader.len();
+        reader.read_slice(&mut buf[..n])?;
 
-                    let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
-                    let val = s.trim().parse::<$int_type>().map_err(|_| EINVAL)?;
-                    self.store(val, Ordering::Relaxed);
-                    Ok(())
-                }
-            }
-        )*
-    };
+        let s = core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
+        let val = s.trim().parse::<T>().map_err(|_| EINVAL)?;
+        self.store(val, Relaxed);
+        Ok(())
+    }
 }
-
-impl_reader_for_atomic!(
-    (AtomicI16, i16),
-    (AtomicI32, i32),
-    (AtomicI64, i64),
-    (AtomicI8, i8),
-    (AtomicIsize, isize),
-    (AtomicU16, u16),
-    (AtomicU32, u32),
-    (AtomicU64, u64),
-    (AtomicU8, u8),
-    (AtomicUsize, usize)
-);
diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
index 82b61a15a34b..711faa07bece 100644
--- a/samples/rust/rust_debugfs.rs
+++ b/samples/rust/rust_debugfs.rs
@@ -32,14 +32,12 @@
 //! ```
 
 use core::str::FromStr;
-use core::sync::atomic::AtomicUsize;
-use core::sync::atomic::Ordering;
 use kernel::c_str;
 use kernel::debugfs::{Dir, File};
 use kernel::new_mutex;
 use kernel::prelude::*;
+use kernel::sync::atomic::{Atomic, Relaxed};
 use kernel::sync::Mutex;
-
 use kernel::{acpi, device::Core, of, platform, str::CString, types::ARef};
 
 kernel::module_platform_driver! {
@@ -59,7 +57,7 @@ struct RustDebugFs {
     #[pin]
     _compatible: File<CString>,
     #[pin]
-    counter: File<AtomicUsize>,
+    counter: File<Atomic<usize>>,
     #[pin]
     inner: File<Mutex<Inner>>,
 }
@@ -109,7 +107,7 @@ fn probe(
     ) -> Result<Pin<KBox<Self>>> {
         let result = KBox::try_pin_init(RustDebugFs::new(pdev), GFP_KERNEL)?;
         // We can still mutate fields through the files which are atomic or mutexed:
-        result.counter.store(91, Ordering::Relaxed);
+        result.counter.store(91, Relaxed);
         {
             let mut guard = result.inner.lock();
             guard.x = guard.y;
@@ -120,8 +118,8 @@ fn probe(
 }
 
 impl RustDebugFs {
-    fn build_counter(dir: &Dir) -> impl PinInit<File<AtomicUsize>> + '_ {
-        dir.read_write_file(c_str!("counter"), AtomicUsize::new(0))
+    fn build_counter(dir: &Dir) -> impl PinInit<File<Atomic<usize>>> + '_ {
+        dir.read_write_file(c_str!("counter"), Atomic::<usize>::new(0))
     }
 
     fn build_inner(dir: &Dir) -> impl PinInit<File<Mutex<Inner>>> + '_ {
diff --git a/samples/rust/rust_debugfs_scoped.rs b/samples/rust/rust_debugfs_scoped.rs
index b0c4e76b123e..9f0ec5f24cda 100644
--- a/samples/rust/rust_debugfs_scoped.rs
+++ b/samples/rust/rust_debugfs_scoped.rs
@@ -6,9 +6,9 @@
 //! `Scope::dir` to create a variety of files without the need to separately
 //! track them all.
 
-use core::sync::atomic::AtomicUsize;
 use kernel::debugfs::{Dir, Scope};
 use kernel::prelude::*;
+use kernel::sync::atomic::Atomic;
 use kernel::sync::Mutex;
 use kernel::{c_str, new_mutex, str::CString};
 
@@ -62,7 +62,7 @@ fn create_file_write(
     let file_name = CString::try_from_fmt(fmt!("{name_str}"))?;
     for sub in items {
         nums.push(
-            AtomicUsize::new(sub.parse().map_err(|_| EINVAL)?),
+            Atomic::<usize>::new(sub.parse().map_err(|_| EINVAL)?),
             GFP_KERNEL,
         )?;
     }
@@ -109,7 +109,7 @@ fn init(device_dir: Dir) -> impl PinInit<Self> {
 
 struct DeviceData {
     name: CString,
-    nums: KVec<AtomicUsize>,
+    nums: KVec<Atomic<usize>>,
 }
 
 fn init_control(base_dir: &Dir, dyn_dirs: Dir) -> impl PinInit<Scope<ModuleData>> + '_ {
-- 
2.51.0


