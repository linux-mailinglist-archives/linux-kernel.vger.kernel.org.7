Return-Path: <linux-kernel+bounces-790581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05DB3AA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7516EA01C53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A80340D94;
	Thu, 28 Aug 2025 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfhAHQY9"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9693375C3;
	Thu, 28 Aug 2025 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407660; cv=none; b=iwla7CpPMWzVhu/h21nVESPHyN38QFgtAS63gyR9pr23v5csFFxf3bsAg30kovvvRMsXe9NsFi+pe9hVHO/ar/0IDZy74ZAkBQZipB+av/ETxM3KGSAX4lzsExy3QYk5wiZDptYsuyV0zjpf6qveoiaPPCqFDKozk9zvHORjwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407660; c=relaxed/simple;
	bh=OtpCqlB9e1zWex8jQODuqGl1cz5sc9yZWh45+Mzno2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZMFaRVOw9ehe+JadLorN2BOtS56EGLcsmMsvSsaKV2BjGqrwnLIt/SGC8HPTLxbL5Mk5WGpHQ6YKhaDvgwlbmMeH24WXx6X46l/KtFcGXNOVUxt9yHIibwbPO1Ne3xuvYcXtiyCrzJNgL3A4sL04ouPjyxv3HAcX9tzlqZskIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfhAHQY9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-327b657924dso794161a91.0;
        Thu, 28 Aug 2025 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407658; x=1757012458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuV95K9JyY8TZOXbZAHoweF1aWF6QJFXwWOQdj7kvnY=;
        b=SfhAHQY9SG+LaSwqsqvowXgfSOomhbfD4wnV5HmFr3V367xlztHHGURk/cgviFruYt
         X8bSoBcDeTZMTqLyD3nFKiv3puOAHvTC1d7tQG+Im2b6gtUiPNzsmpDpnos7kR8h/m5O
         MfufvYtXEKS9lyDw/WtdNB/Voprx6Rh5nhxG2lBmScB/AjpgrjDjsEGBszGcM+LAxmUE
         xWrtAGi54liFU1aO8aIQtx/gi8/fQo3q5pUOYcma78h8OtUcrFgA5eGWIStAdJq0cLUY
         9q1FotFPnKt74BurbWhJiRYLfQIueuk1+M2DqPYc4LaWT1JON/2F3DGx6kzHbFJFQPkH
         A/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407658; x=1757012458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuV95K9JyY8TZOXbZAHoweF1aWF6QJFXwWOQdj7kvnY=;
        b=ktBCJG6NlfF8x6nInT/b+F066Hd1E/gKu7Wqs/Y/NU2JLj/QUovRSe7UOSqe48P1m8
         TnVGE91w/Cc7Yk8Sr1bqzaG4Fq9wuWSD4KrjJZPzPKNrRKDVZm69boGj4sIyRl1S1P5p
         io6zqIBGwC4SF7fJM83mY3i8o50QbK8ukyOdNrVPS0oanh1vAVEPgmFtlN2e1AAB19/L
         vtpYKUX8h46u3fNFNziJS3qh9rZI/C8c0Zv3VsU/kCCIukYchRs1BJ7IEn6XosNGZOc7
         99C1s1GgTUAqgDxk5DU6gjB5KLQrbR+Yj0/AcgApVcAIMYbY7Lz8f/oYMenTSqgNiRj8
         4Svw==
X-Forwarded-Encrypted: i=1; AJvYcCVJeeYGR+rr6cWPZdD3Bu7Y3BexkXjtG06RMJod7roB1eMJPN4UTE29NO/P9Lp7FExd2J0C7ljB3YjP8L0=@vger.kernel.org, AJvYcCVoqsyjSAnj0HclSv7IctRiCzvzm5V4O52XtMbZWj9FJbwZ5kIPuo4i7L5PYMoVCGt0kHYL2Rpipm6G0/Ccshg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAzILdw8glkSozPAGpGX8l44G+r7hIGyiKDAQl9fnAwDDXyTj
	2OK3VdxOCZ/tRxlMzt5y8G09gY7VpiY7uO0sxHr8l/+m1PrsQuvNBt4YoqbPMlhz
X-Gm-Gg: ASbGnct7Xy5oa0+xaEG1ked70rh3+Og6Yxx0YffJtBA5IRTj4jJXHxGB1/1vh47/uRe
	mtNB0KXT5E7JXhGNMHMdOl+GazcBA8epCSW4eFrd7+B8sU4HXdQvoO5fwYaBM3S//bvrJWLTcV6
	D7ffPWjB7ZSv7Mzuade15a9GSe0IaDa6AS8D4LFvZHsdw0/DzQaNv0l3icMaGo3mFWIeTQxXXJ3
	uloWGzLEkfvyLz2qr3Mhw9fEAOeuRDIRvXB7jXhuiq7453ywTj6/qkM+2Yh5AuvqgUycjUuRcQn
	WGWSgEv+3VB40Dx/vnrYX/rC+psFv58GiEN/Jhc6cZcSvvpDoEwFTsMf5CiwKdopmcBfXn061J5
	7G4wwTjIn/7TKSzCcY9QZaq/7V1k+agzH0xIpxiA8I5UkFg==
X-Google-Smtp-Source: AGHT+IHmhZQt+LgvfoXPy01Ao1mL5xCYpm5wePCqKk17/kEIhhYnOE66ySAPA1ychd2bemd1EStE9g==
X-Received: by 2002:a17:90b:2648:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-32783e10b79mr7615856a91.28.1756407657841;
        Thu, 28 Aug 2025 12:00:57 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:00:56 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:10 -0700
Subject: [PATCH v3 3/7] rust: cpumask: Add a `Cpumask` iterator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-3-4dd92e1e7904@gmail.com>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
In-Reply-To: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=2580;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=OtpCqlB9e1zWex8jQODuqGl1cz5sc9yZWh45+Mzno2g=;
 b=Q2FpQBwE86VcGQRhHVGrqBBJHXeoNsMFqG0rXzfh0HY7/r2ixF2OqX8DlbwQU04IWLevtgaFs
 K718VADFXt1CjEvHDLa8XOH/wgma/rXuoAzd1eGF+iseEpYpZNWDfXJ
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add an iterator for `Cpumask` making use of C's `cpumask_next`.

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/cpumask.c |  5 +++++
 rust/kernel/cpumask.rs | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/cpumask.c b/rust/helpers/cpumask.c
index eb10598a0242..d95bfa111191 100644
--- a/rust/helpers/cpumask.c
+++ b/rust/helpers/cpumask.c
@@ -42,6 +42,11 @@ bool rust_helper_cpumask_full(struct cpumask *srcp)
 	return cpumask_full(srcp);
 }
 
+unsigned int rust_helper_cpumask_next(int n, struct cpumask *srcp)
+{
+	return cpumask_next(n, srcp);
+}
+
 unsigned int rust_helper_cpumask_weight(struct cpumask *srcp)
 {
 	return cpumask_weight(srcp);
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index 3fcbff438670..b7401848f59e 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -6,7 +6,7 @@
 
 use crate::{
     alloc::{AllocError, Flags},
-    cpu::CpuId,
+    cpu::{self, CpuId},
     prelude::*,
     types::Opaque,
 };
@@ -161,6 +161,52 @@ pub fn copy(&self, dstp: &mut Self) {
     }
 }
 
+/// Iterator for a `Cpumask`.
+pub struct CpumaskIter<'a> {
+    mask: &'a Cpumask,
+    last: Option<u32>,
+}
+
+impl<'a> CpumaskIter<'a> {
+    /// Creates a new `CpumaskIter` for the given `Cpumask`.
+    fn new(mask: &'a Cpumask) -> CpumaskIter<'a> {
+        Self { mask, last: None }
+    }
+}
+
+impl<'a> Iterator for CpumaskIter<'a> {
+    type Item = CpuId;
+
+    fn next(&mut self) -> Option<Self::Item> {
+        // SAFETY: By the type invariant, `self.mask.as_raw` is a `struct cpumask *`.
+        let next = unsafe {
+            bindings::cpumask_next(
+                if let Some(last) = self.last {
+                    last.try_into().unwrap()
+                } else {
+                    -1
+                },
+                self.mask.as_raw(),
+            )
+        };
+
+        if next == cpu::nr_cpu_ids() {
+            None
+        } else {
+            self.last = Some(next);
+            // SAFETY: `cpumask_next` returns either `nr_cpu_ids` or a valid CPU ID.
+            unsafe { Some(CpuId::from_u32_unchecked(next)) }
+        }
+    }
+}
+
+impl Cpumask {
+    /// Returns an iterator over the set bits in the cpumask.
+    pub fn iter(&self) -> CpumaskIter<'_> {
+        CpumaskIter::new(self)
+    }
+}
+
 /// A CPU Mask pointer.
 ///
 /// Rust abstraction for the C `struct cpumask_var_t`.

-- 
2.34.1


