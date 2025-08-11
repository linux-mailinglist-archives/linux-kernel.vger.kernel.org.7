Return-Path: <linux-kernel+bounces-762596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6BB208CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055323AD598
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F423B613;
	Mon, 11 Aug 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+mYYA3m"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E432D3A9D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915531; cv=none; b=WIbMGpCkT0Gu78T7JivWiNmzIhr0PkvsHiv2rBsYu0RD9kU/9c+uWwUmIPGw8vgR9z/8kzLILIK5xsih45tPDXhkbjrUam1MVVDf01A88+DCksPJzscQAHOG4BX2ylpxc9KWEKZcsmg6hOAaN1z2yGifXQs/57OWKm/JpmvpYoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915531; c=relaxed/simple;
	bh=3TOHdsav1ycB+aZ84BPSmdU5PVabBdrJYr0uju0OSxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=thq6aegdsit942Krq77AQwL5TCrRrpyj9VpdSYWbxJpG2vHNUz1GOS0rTYSR7s6Ot1gPUDaDBv6GRvSllZ/3RPhxgCztTHeE7ZSsFe7prRitD6Z9aXyWP+3V5LNNyqRy7vDOJkJz46EAIRPtRazHYSStnUl5DHREfgKiSXDa5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t+mYYA3m; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b79629bd88so1854072f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754915528; x=1755520328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rlOmIicLtEp3jt4sv4CSTuwkEdgZbSMhZPZuiG0qNY=;
        b=t+mYYA3mMQvkekV2PRoPz1Toy0BH1Egyl91FoUPmdK/yH8GVPmfMXJJX4JRMMqs30C
         V5C78yDx/8GOfgpT0gQgU1IJYoxK1LZrm4qjQllChU4WZkWk3NnlvhPL0aR6kJSSAnoM
         5HivFRLTn5STS5rad7RSjCFlMd7pNL3zerx+7NrfZieY26dHYUrj1diDUgUhLJexsFYA
         IjZbHTntlP/mxhiBNRokh7oT3BuGZoqdSUxzRTzpZgN+LY29J7nROVV558Q1pO79jHPG
         pYu0zp61+aUb+hi+9t4j4TEonNKf2rT1ApLFydPB8zCdRcuE5EzRoUKwsmaPSXLRvoAO
         vJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915528; x=1755520328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rlOmIicLtEp3jt4sv4CSTuwkEdgZbSMhZPZuiG0qNY=;
        b=SiIwLiCv9T8WtEBqADeHry21ZZsGhC4HgGdt9120pAM34nqaOXLPhy2KPn0GPZCING
         ujDMUcT6sUZs5oiusvAfZQh0vaS3h6FdRk0Cnogmm5GRT43DFxHbHjmK8nzpjvD2k2vp
         urnxiylp9UTudXTRlwiV+4gycXq9HGpWn36aVh5fv049YYrNAx7NKeA3MwHygSkApKKL
         QbK65xxGr2gxLPw3ustoKVS8Cz0qKB15sE6TbLJtEuHBFUDBvPjJugmju9277CaGv+8W
         R5F03PZNn8L9QhH/AL0jzHe/PSDKTWKc8bfCTk6dCp9w3JJ6y2Kh3xzAAG1FVxflp6gI
         MsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS3Sc2A2ilVQ9vy7WGvboYyUNisSWwEBDCiU7f3W+6+xWzniCSCPjVFJMHdz7u8J+OnVvhABksRWfKfgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+EQ0mPgYsHI5R000UgDfcPD9QuLESOxmLIB90gZwIT1+K9sGF
	eWLQg/kSK4PEN1xKj9GC6hiaSCflZ6cGM7hlMj6MnF0iLMpE7BZVAPtiMqpxORT30T70WimvduN
	8JgeXPnfFFfgpGsUKsQ==
X-Google-Smtp-Source: AGHT+IGLqvqODrNKUqFGV1RPHxhNKh2ajU+3kusbjIAlTVO5vOTLv+p7fkC+SL8LO9kaXdUyiw31plWpnKodurU=
X-Received: from wmth4.prod.google.com ([2002:a05:600c:8b64:b0:459:dcf5:1b54])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:25c4:b0:3b7:76ac:8b72 with SMTP id ffacd0b85a97d-3b9009294e5mr9096299f8f.12.1754915527779;
 Mon, 11 Aug 2025 05:32:07 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:51 +0000
In-Reply-To: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=3TOHdsav1ycB+aZ84BPSmdU5PVabBdrJYr0uju0OSxE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomeLD7qI0nZRsYh9EJ8g3j8Abdi0u+B75wO6Tr
 Lti2BBLUReJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJniwwAKCRAEWL7uWMY5
 RvAWD/4qmVr48iymYXFuDkGmxltJS6ILykjTpfpC8zNFFY76rrYxiOtJRaNzi/FbdFsdgGHH8pn
 U0Dtcj+pEVp/ac9Jej3eTY8RdHtWiHTTza/GeRYt0vKrl3j4qp2GHh4oN9wOLqbpdNL5QbAaxjg
 tXiwjycVXRR5inzf7VtQ+6ERQHeN4ja6xDxdRNOze2ltFpQ2pELfdJbXhlQEGqyQOhVTZpqjfsg
 EUJi3VLNXZnyJGCj3florbFn848EvfG/QkErQdXkFee+qxsVygZ0ev+z0G9p5y4crdFdM9Qt0E9
 gWUpG2sWvqV1qLgdXfwMwhDfJxEHNJz5Vm6nG92uwaWkn5EsjmUsZs7MgawgTWTtZmrxZc0R1ik
 NDgBhTaWzKXM0XCga0yHRhiOMZqH9XB9IGSnUKTsXedMRhP8As3rnf6FF1TVb9j6Ru3eb2/AljH
 4q7FWAuTi3flms0P0eG5AYEY8rvlRz7Wj+QA0Owu32mVmiJ6bCEeX0H4swgrsY1aJu9dbck5izo
 1S+kHlcnmzXt65jisEuoc6rH6ZeI3RI4jzfeSLEc2xBl8m7MbEXOuJsiuHURnTn6+g8oFV5VlRo
 Rizotk0lWMfBDg2orMlo48dCPAIUQrYPoRD2JAejExoHgqLXffV5tz1anAo6KMnTE5rpam+aV8z JDLA7pMlhh3Ymog==
X-Mailer: b4 0.14.2
Message-ID: <20250811-align-min-allocator-v2-2-3386cc94f4fc@google.com>
Subject: [PATCH v2 2/2] rust: alloc: take the allocator into account for FOREIGN_ALIGN
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

When converting a Box<T> into a void pointer, the allocator might
guarantee a higher alignment than the type itself does, and in that case
it is guaranteed that the void pointer has that higher alignment.

This is quite useful when combined with the XArray, which you can only
create using a ForeignOwnable whose FOREIGN_ALIGN is at least 4. This
means that you can now always use a Box<T> with the XArray no matter the
alignment of T.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kbox.rs | 13 +++++++++----
 rust/kernel/sync/arc.rs   |  6 +++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 856d05aa60f13485d8afc98f0b7fe7593867b5a1..eedab0be1eff78a8150524346348ec0759f852e2 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -401,12 +401,17 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 }
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `T`.
+// pointer to `T` allocated by `A`.
 unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+    const FOREIGN_ALIGN: usize = if core::mem::align_of::<T>() < A::MIN_ALIGN {
+        A::MIN_ALIGN
+    } else {
+        core::mem::align_of::<T>()
+    };
+
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
 
@@ -435,12 +440,12 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a mut T {
 }
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `T`.
+// pointer to `T` allocated by `A`.
 unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+    const FOREIGN_ALIGN: usize = <Box<T, A> as ForeignOwnable>::FOREIGN_ALIGN;
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7d752e09ce7372bc230661b2f7c6d..74121cf935f364c16799b5c31cc88714dfd6b702 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -373,10 +373,10 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
     }
 }
 
-// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
-// pointer to `ArcInner<T>`.
+// SAFETY: The pointer returned by `into_foreign` was originally allocated as an
+// `KBox<ArcInner<T>>`, so that type is what determines the alignment.
 unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
-    const FOREIGN_ALIGN: usize = core::mem::align_of::<ArcInner<T>>();
+    const FOREIGN_ALIGN: usize = <KBox<ArcInner<T>> as ForeignOwnable>::FOREIGN_ALIGN;
 
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;

-- 
2.50.1.703.g449372360f-goog


