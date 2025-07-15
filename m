Return-Path: <linux-kernel+bounces-731965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBDEB05F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510784A31C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF642F002E;
	Tue, 15 Jul 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc9TXKlv"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BF2ED145
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587206; cv=none; b=CEPjisXqtJ+ikjKCL7S1AqtYp1SfGP9FtIwANIxoYvJ0y/LPv0oe6eVobgMUCTVdD7G9rylRkH1o1fNlVMcLQGaMDKALu3+UTdCJb90JMXz66ITArxOI4K0ylt9pZrk4ffNg6p0LeIWmYfxSfcbr4hEj9nog6OcmmXm6WNlxBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587206; c=relaxed/simple;
	bh=hm+QQVA6P62r4L8yRa8/F/rPQxTQzaWcqgojZ/rjEUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZIpNYifRVivOFvDr3tDlIh5nug1F206ilOEpzwrpwLxiaokM4pcXeeLIemSoSkY3CGS7fSTynobgiK8B6+s6wmARwfhaWluwAmG0UguoLT3yilb8mLa+RkPDn/oEDGsjTB+kApXCSrc5nznmahdTqN7WMpYQMsOHwV2sTCskWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qc9TXKlv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2114284f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752587203; x=1753192003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ACo1fjYAZDXTqvJRVHRKHNWe7uZbNAFM49VRqGLnxa4=;
        b=qc9TXKlvEEY43glSYvriJcRJCfVG0lFuHYSSj3E3JsN2STJM0rxARxh0ZtsYiKoJNi
         EV2fFvBL59rjgH2R/b5acAIpegWgYIv0iOqW1rtmp0o3TK7mlgIizJvoxFiSHY/J/cZq
         DBFwdZsOMYHpMM/jdhIedlmLXOpnoR7WHQj9L9wDVm0qfD1Z1VfF8FAeMYf/pJLjZSXT
         40hPEb51Ws9AbAp+u6pB7iq2PJZEYgnl15dSyN1fAZmCNBW+OzWDlxBO8irIGaFQgvUm
         uIChhF6qo7gqffk5NP34sDwqZyvfLGA/hlElpIzoSvpWdUvUNA9ogWx6SoZvr2BFjndW
         5QEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587203; x=1753192003;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACo1fjYAZDXTqvJRVHRKHNWe7uZbNAFM49VRqGLnxa4=;
        b=RbPvxfDTYX/pxkVwgrGmgjMsGWMRN7gQ4G4buMqSSjb8ztY6CwQKvSgv6QlvO5NYcc
         C3RAI+fUqysa4N+SzorcymcEt2XE6ghXA7nj4l9zEygUNKYaqgUdTSQeshSqMb0wx6OF
         89nSNHA3CmmwFpspjDjQeiPOz75zd6XadjCceqXFaMqg5BwqhSsxJlKGnaXSC0OKUWgZ
         gf37tjcjs4q4GI46rnKqx3cjf9WzoyMtCKkupKh18IonbsxLQV1/iXuTnE5Epnw3ELs8
         HE1w94cuhAfwl/8RruPnE1Ndg0GtBe9C40SUP9PHDaNjQX8m0/iSf32isu0+qoIWY7Bf
         wWdw==
X-Forwarded-Encrypted: i=1; AJvYcCX3HETir7ckCxa38690L4ZE5shFcHthsr7MWy86/mO0uCIvZhkMd+eKUH9WGY19YGEKBtr0GfGpkMiUVRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydxq//676N7sCz+hq5JUbODV4L2eBD7ZfWZ8aSGidPJrTQ/+Z7
	4gzyuqos7RWmnaw9zJPya9SRfTblVv5PNBk8sjfd3UXy1/Qpn/ml+n4WjjZVEhvcPCLvdRouFqI
	4UnEyLpwpSmMEQZrN5A==
X-Google-Smtp-Source: AGHT+IGBq3R9luEQdDGUT+ehdyASOxOv6YZaQeET7ZAo5DpnvtF4ybFvvtKpEyvlFqi5avs2rWm3frsM24DgRxc=
X-Received: from wruz15.prod.google.com ([2002:a5d:640f:0:b0:3a4:d770:e74f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e186:0:b0:3a5:2653:7308 with SMTP id ffacd0b85a97d-3b5f18debd5mr16710074f8f.57.1752587202941;
 Tue, 15 Jul 2025 06:46:42 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:46:34 +0000
In-Reply-To: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hm+QQVA6P62r4L8yRa8/F/rPQxTQzaWcqgojZ/rjEUg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodlvAXD7jigSPg9pSkftUrz+P7iBYlXollyaEL
 i0weeZAJxSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHZbwAAKCRAEWL7uWMY5
 RgWNEACObqQ81a9TVudRRgk/RKfwO4T/cIHYyu/eu6p3lZsOHdCSR9F4jZ9sE7np7W501HA+Kky
 4e7gim/kZqfXXbE5beTOqB2QwcAN0IwNql4HiqEzlE/76NUMo2ZEfszAs/QqCTc/+8bUb0MFaBD
 wbRo4oMU0ig4KPILmY6btYspJoJtFE43XfAIKmDspYTLmqqaadjYcooO7So5lzo1uAVcGmAnEzM
 W+WQb0dyEq+Q5LXJaIFKOAgVjos4a4RAjSRnrjSC26MBTIVJJ6Ftdxyi9F/wiIvk8IX/EEDZAWS
 I1LpQ3XrF33mJ5mqGvS2UXWDQ29nDuyU4DtkM8yZq7L3tmq4pha+Bkpp799IZE2fky/k/06XTez
 BlwxsFs4aD7pPaEeFi2tiie/10QRIvH8Y6ZuxE4Lvs/bSNaJgbFl0Q8IFEMfzns0WhNCAVE2mmf
 iyeQAod6UF2/UlbtAOcYO2as35v+5owOmUIqJp8RzgiFtq4L8YXFyG2o93+vHw3qATYv10ybtKV
 uO1Ta3KpJQNH4k9ykCXIPJKr6591OvcRrwGQLJW2Onk3P1CyJb+/893rfu9PhBfgK9+vES0CTqw
 dkbPcrIPpMkoua1OmLBVdtNUlg7yeL1D1lTBdabUp4LA1LQEHtG3+iusPKtNQpcJoTCTXdS5Wvd /v7VSjaqrfl3BeQ==
X-Mailer: b4 0.14.2
Message-ID: <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>
Subject: [PATCH 1/2] rust: alloc: specify the minimum alignment of each allocator
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The kernel's allocators sometimes provide a higher alignment than the
end-user requested, so add a new constant on the Allocator trait to let
the allocator specify what its minimum guaranteed alignment is.

This allows the ForeignOwnable trait to provide a more accurate value of
FOREIGN_ALIGN when using a pointer type such as Box, which will be
useful with certain collections such as XArray that store its own data
in the low bits of pointers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc.rs           | 8 ++++++++
 rust/kernel/alloc/allocator.rs | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index a2c49e5494d334bfde67328464dafcdb31052947..c12753a5fb1c7423a4063553674b537a775c860e 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -137,6 +137,14 @@ pub mod flags {
 /// - Implementers must ensure that all trait functions abide by the guarantees documented in the
 ///   `# Guarantees` sections.
 pub unsafe trait Allocator {
+    /// The minimum alignment satisfied by all allocations from this allocator.
+    ///
+    /// # Guarantees
+    ///
+    /// Any pointer allocated by this allocator must be aligned to `MIN_ALIGN` even if the
+    /// requested layout has a smaller alignment.
+    const MIN_ALIGN: usize;
+
     /// Allocate memory based on `layout` and `flags`.
     ///
     /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c309e5a9eafc7da6a8a9bd7b54b11..25fc9f9ae3b4e471a08d77130b374bd1397f7384 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -17,6 +17,8 @@
 use crate::bindings;
 use crate::pr_warn;
 
+const ARCH_KMALLOC_MINALIGN: usize = bindings::ARCH_KMALLOC_MINALIGN as usize;
+
 /// The contiguous kernel allocator.
 ///
 /// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
@@ -128,6 +130,8 @@ unsafe fn call(
 // - passing a pointer to a valid memory allocation is OK,
 // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
 unsafe impl Allocator for Kmalloc {
+    const MIN_ALIGN: usize = ARCH_KMALLOC_MINALIGN;
+
     #[inline]
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
@@ -145,6 +149,8 @@ unsafe fn realloc(
 // - passing a pointer to a valid memory allocation is OK,
 // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
 unsafe impl Allocator for Vmalloc {
+    const MIN_ALIGN: usize = kernel::page::PAGE_SIZE;
+
     #[inline]
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
@@ -169,6 +175,8 @@ unsafe fn realloc(
 // - passing a pointer to a valid memory allocation is OK,
 // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
 unsafe impl Allocator for KVmalloc {
+    const MIN_ALIGN: usize = ARCH_KMALLOC_MINALIGN;
+
     #[inline]
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,

-- 
2.50.0.727.gbf7dc18ff4-goog


