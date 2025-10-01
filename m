Return-Path: <linux-kernel+bounces-838404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48224BAF1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169B8189C346
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A862D6E44;
	Wed,  1 Oct 2025 04:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="BVY13p2N";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="sbFVLOys"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E24433AD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293976; cv=none; b=hT2L2jgjDYWa9LP8XRn64H4OlLMc4e2Z4/zZomxKR3zihKC6j1mDWIl2dlINakjE9uNw7atRpxfiUCBy508fRROuxaaxVjEaxqqGaen0qk/+u2fkEwSrCdfyw/TfPfRuZ8kTJHW41deEpZucmUXU/oueqYo58B5pD59yqbd1q+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293976; c=relaxed/simple;
	bh=W9aE/h0MCF2uj9dBQXAmWE6NxDahP+VqHyrnxKfSqKI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diWjahN/W8Ruj7ru+YaWkbkGqVl6DFxITZhDnFZ+HnymD0LjeZTvvSGTRAnokqyQMbHVcYTF2/89Wh0xAu1XJiuMsKWtjAX/p1GvVpCTMfoNu9o42Tp3Pcd5W2KRvfF+cd3m4FF1xO0lRDVUIkWXckKRAL8gqiSHDe8qFZFGxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=BVY13p2N; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=sbFVLOys; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=BVY13p2N/J3gxB4vcQ9vaRwkpICVSGS0Wg6rMVgrnHn43OzsTUq8aa3vKO4E1Q98CwPKLz42Sh3UlxbgS6E2dqKO0d1JXhlWPLQ4wP/etM5iRzgY1yNKpg86ZWDL98DD2yiHNUZH7y1MvCXtBOxgpS/Cg90xqMAZg5lyTCs2+B0Eac0ZW9Tt9hgWmGY6hRRn6GOr+LzuuAQQMZyoiLNlOIhEVekzBTi1bz0j3GoYilS4+dBqqVYjvqfTtJX5muWc2RpD0cqeZ6nZS9JtE8kD6WqmKoDpLigTN8ZshnQ0YMZEvH2isqhGYJErXJHCNjxD72gUJKXm8GYmYlHoF8Ro/g==; s=purelymail3; d=elijahs.space; v=1; bh=W9aE/h0MCF2uj9dBQXAmWE6NxDahP+VqHyrnxKfSqKI=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=sbFVLOysOH+HRfWWENrNx001woaBDpzpoQnXyPe7Dm5sNgrt5iTQaULT8fqQbLwmp7xE5BVFTnX9JdbZcwfvZlgTg+ZpuuxaXIcaCEw72xMz135jxKjj3rEIIbAuvvk8DTdakrD4i33EcifpCrYrwdqE7ohadn0dKwCaYRSbMr3c5Rj+aO2gjD3cLSFLqfm2zgT2lzeF2LMGfnR2e5CST0hw9XDh/V2zYHBCtO6GFWIMD0b5cpuK4uz8FDPLCFWMI/0DA7vf6hCUc9RdzX2IL5GTxR0xannQyrn7xEcKE7XU4uTjVICThplaIy9l5wpV59gc8jQyxGjmTz3eqeBVEw==; s=purelymail3; d=purelymail.com; v=1; bh=W9aE/h0MCF2uj9dBQXAmWE6NxDahP+VqHyrnxKfSqKI=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 147366:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1637358726;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 01 Oct 2025 04:45:34 +0000 (UTC)
From: Elijah Wright <git@elijahs.space>
To: Elijah Wright <git@elijahs.space>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	linux-mm@kvack.org
Subject: [PATCH v2] rust: slab: add basic slab module
Date: Tue, 30 Sep 2025 21:44:21 -0700
Message-ID: <20251001044508.23126-1-git@elijahs.space>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250924193643.4001-1-git@elijahs.space>
References: <20250924193643.4001-1-git@elijahs.space>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

this revision adds gen_kmem_cache_allocator, a macro that implements
Allocator::realloc for kmem_cache. the one concern that I did have was real=
loc()
for resizing, since that obviously isn't possible for slab

Signed-off-by: Elijah Wright <git@elijahs.space>
---
 rust/kernel/slab.rs | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/rust/kernel/slab.rs b/rust/kernel/slab.rs
index 8b418f9db7cb..3f1310f309c5 100644
--- a/rust/kernel/slab.rs
+++ b/rust/kernel/slab.rs
@@ -83,3 +83,55 @@ fn drop(&mut self) {
         unsafe { bindings::kmem_cache_destroy(self.cache.as_ptr()) };
     }
 }
+
+// SAFETY: The pointer does not change after creation, so `Slab<T>` may
+// be used from multiple threads.
+unsafe impl<T> Send for Slab<T> {}
+unsafe impl<T> Sync for Slab<T> {}
+
+/// Generates a zero-sized allocator type that allocates from a given
+/// `Slab<T>`.
+#[macro_export]
+macro_rules! gen_kmem_cache_allocator {
+    (struct $name:ident for $cache:expr $(,)?) =3D> {
+        #[derive(Clone, Copy, Default)]
+        pub struct $name;
+
+        // SAFETY: Allocation and free happen through kernel APIs which
+        // provide guarantees. The ZST carries no state, so it can be
+        // duplicated freely.
+        unsafe impl $crate::alloc::Allocator for $name {
+            #[inline]
+            unsafe fn realloc(
+                ptr: Option::<::core::ptr::NonNull<u8>>,
+                layout: ::core::alloc::Layout,
+                old_layout: ::core::alloc::Layout,
+                flags: $crate::alloc::Flags,
+            ) -> ::core::result::Result<::core::ptr::NonNull<[u8]>, $crate=
::alloc::AllocError> {
+                if layout.size() =3D=3D 0 {
+                    if let Some(p) =3D ptr {
+                        // SAFETY: Caller promises `p` came from this allo=
cator.
+                        unsafe {
+                            $crate::bindings::kmem_cache_free($cache.as_pt=
r(), p.as_ptr().cast());
+                        }
+                    }
+                    let dang =3D $crate::alloc::dangling_from_layout(layou=
t);
+                    let slice =3D ::core::ptr::NonNull::slice_from_raw_par=
ts(dang, 0);
+                    return Ok(slice);
+                }
+
+                if ptr.is_some() {
+                    return Err($crate::alloc::AllocError);
+                }
+
+                let raw_ptr =3D unsafe {
+                    $crate::bindings::kmem_cache_alloc($cache.as_ptr(), fl=
ags.as_raw())
+                };
+                let nn =3D ::core::ptr::NonNull::new(raw_ptr.cast())
+                    .ok_or($crate::alloc::AllocError)?;
+                let slice =3D ::core::ptr::NonNull::slice_from_raw_parts(n=
n.cast::<u8>(), layout.size());
+                Ok(slice)
+            }
+        }
+    };
+}
\ No newline at end of file
--=20
2.49.1


