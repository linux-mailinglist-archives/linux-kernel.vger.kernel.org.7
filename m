Return-Path: <linux-kernel+bounces-762595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F9FB208CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932363B2298
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895512D3EDF;
	Mon, 11 Aug 2025 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqtOTpmi"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4352BE03D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915529; cv=none; b=Y6tyLJU+4p27CL3ERk4CDwEFbaLn5939KUcf+p22lmsHfiaTKEmqzSaIRSBa+lyibsP5AHzoxigXJtyKpRP+WSvFfEvsS5MTekq9HnKYqe86zme90ph3lDRmWrMfi3rsoKVjo5dCJABpJms05vQxC7G4syscC4CjkksFfS+RPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915529; c=relaxed/simple;
	bh=xrRdYUi/ackTh+GxFSroXvpaNgAFYJLwSEWSCNu0Vh4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MjcJds4/gdBrGaPMTP32bhj1/uOfGBwXPHDp0mVy9fwHScoiB0GBSyN+rLx4acfiQhi3Vey6wVOkhpop6Od6djA8SjCYxrZ08aAm+wuP0KX1DdQFLLncxnJJ2eM8PDo/G/3jR0p25GDGGOKFUwjtxnvj83qg8NV2K7zejn7U0wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqtOTpmi; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7825a2ca5so2761336f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754915526; x=1755520326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EeF3bGUOa7e9fi1mYtzUmovCQl97kCDgwj4UAdIAQzA=;
        b=FqtOTpmip6K/t/2AoFauJ8XTdnZIhwBHy++AGHJzMdNTPMd77rcstudICYRMJswx+F
         kvnzeOHiOfoC9cnvS6lwhLGunEBzd6o2cjrxObP54T2PXFY1txOeWwmcJO+tkyaTzLFa
         AVPhtNtMGk5ztPvJ2U3QVK2eq+LglUKUIh8hCv3FhGTiR5/7CdTeDCR/u0WTFhfP0kIL
         XHNZcMjYDQiJkkilwJyyDWYvNmD/+T4qmKyKn9B5orL7GjHhzyavGJz7JWxMjNDg2OPB
         oiQLb7x0fI4MiiZgAbkL/Y9cwGlkJP7IUrHOr5EgJB0rc6n6yprzg4P8IoAXvr5rb2A3
         B/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915526; x=1755520326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EeF3bGUOa7e9fi1mYtzUmovCQl97kCDgwj4UAdIAQzA=;
        b=X2pIyulEOiXB8zCsTHj4juQe3Jk9Ji0EkBGU0yffIfmDyoLSY2vuS0iq0lDd2GAYGN
         Fo6VzDiPOnPKD2Lvz0iUMTQpcl/YOTNB3m1BBERwvMIEwiUuCUQm/0uW37TLxjn8Ivar
         XBQ3a7PGlqUq8IA3fQEugXwceaeez8rhGqCnYwoppyveZ+MSD0BdHj5eDpXK9i2f3VLk
         R/Tm2bIJkjQt0DAR+H/ilG6JFgTHQlKWPfeDp9OkzC2JcNyyivswze7qiq4Vq5PmIF/E
         gqp6mwGKGpLoi3Z+qTuoa+2TXVQBAHOuwq4dcBwyed/PA/xbZ6aGvV3AweQhTLHA6G2n
         BRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmX/ccFpuJS1RH2L8Ja/bLE7Qvr3UWWSdO8pBPyiAGp1tx91MHGxJ6lLKejGrvy9HoHzl+FMe7LNgqCdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5rgIODI3v8Ham3njiuew27Q3R+HR6YFkPfXAIoL4UrMo0lNA
	Lf/Eqh1uHW3qXY+di945wsKkYKrZCqfeOfpHH7g3i0OXX+7CWLcSMciY4c49+gJNHcztb01kw4H
	MBQJIB+qX17HuGah81g==
X-Google-Smtp-Source: AGHT+IHuDZSpEk8s4TEttjba6L2NvFtGfFsONeAGvCghisyrKanTpyDc2apiIaxwNjc3et8Cs5h0CmJDe4Mrfv4=
X-Received: from wrbeh10.prod.google.com ([2002:a05:6000:410a:b0:3b7:d75e:c4a7])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a6:b0:3a4:f7dd:6fad with SMTP id ffacd0b85a97d-3b900fdd6femr9908384f8f.14.1754915526236;
 Mon, 11 Aug 2025 05:32:06 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:50 +0000
In-Reply-To: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3229; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xrRdYUi/ackTh+GxFSroXvpaNgAFYJLwSEWSCNu0Vh4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomeLDLapzSgRvvWowdCWxONAxAhx/5FT2Y5YJk
 gx+2bT0DGyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJniwwAKCRAEWL7uWMY5
 Rt1QD/9YADVnV44goF9lcDd9dHPZxmydoBRcrufELmZmXlCQlrzMOEHsw0sBYEc6FhjWrVW46vm
 Kb8ps8JkxIQFAla48r0G19xim2rb3zCBUhfFqpE31VZRkl8dDghHjNMP/hMLSWb+8E7AMH9ZlU2
 jHcDfkxJFqvQW9qHe+vAJUKx2POgZktnewhvHWUMwn4HFKg+etyqSloAV0CZ/lzm9GPTVCt7Bpv
 SsjsqBfcVoTjxXEiG/LjL20spSbiv2Uf2LcSm/zKBQMC/Y6goWtowLiBV64uRztcYQaNqdsLsQD
 L6SKhK53K18XdvSltKZaXVvyR/ckouWMtnIVneZblav0IpnoG0EibcFhzslXngg5izAVmqMaHLG
 VEBFWqRt3eCT6HXp7Y1KKhW2nj0pvEhwvgtG0fSM0UT/279tGzCSkc4Ua4VyX9Ule0Dp+lof8wV
 TD1LA0+PQWUvYMTArKetljTUSiJmoXCuUiJtlQ9U+uAWRi9qiU9sjbFDrRQ7epQw0QS45DmkkMy
 AvKsMjuMyoQKwTf3LYsXLUlzx1NqgxMOld0YahE+Zl8wmjy2mK5i7ERAIBo9mNecm/sF55tBidr
 rZEeeG+fR23ufyG4H2hvz6VhTXvpklJDtZ/cWudrSt4ho1ok4OAVPTqWq9mCEJEE4Q8I0+AxIsR WYeTU9cOEOY1jfQ==
X-Mailer: b4 0.14.2
Message-ID: <20250811-align-min-allocator-v2-1-3386cc94f4fc@google.com>
Subject: [PATCH v2 1/2] rust: alloc: specify the minimum alignment of each allocator
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

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc.rs           | 8 ++++++++
 rust/kernel/alloc/allocator.rs | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index a2c49e5494d334bfde67328464dafcdb31052947..907301334d8c111eb26719ad89700a289e03f037 100644
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
+    /// Any pointer allocated by this allocator is guaranteed to be aligned to `MIN_ALIGN` even if
+    /// the requested layout has a smaller alignment.
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
2.50.1.703.g449372360f-goog


