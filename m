Return-Path: <linux-kernel+bounces-887473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5DC38513
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F30F54EF895
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64A2F60A1;
	Wed,  5 Nov 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVtUUUh/"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0629BD80
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384589; cv=none; b=QPIWOfMY9UlKXJiqAycpFQY4VrGsu23DWkwGK4QlRtkY7CpMXAxLio1l9QH/bIPu84n6z7w62lngJZPW4rDT90iLtA38tw7uFRS7bnkz/FLo2w45Psgzwz0xOkNZG/OWiP8y3FjVXdvjEyVqR+IIbofuz9wyDHwfkdmZuRZ6nQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384589; c=relaxed/simple;
	bh=O+TJ1giWcgX8q8AVGe652HR0hPyTAH9TmZB/EtY9dHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uo8D4++ZlFEzPncKhE5yRkH4ctZmbdYdPFr10j/mLNCnB3CCEiq/lXfpX+si7mRjWh4CH+yXJbdLuFygvIsdO5yiMn0YbqXCzHJO/ECzaUwDhSB3dr4ar4YtZPG6JTXcBfBjG5lf0turgfSj1TwhGVlVYGZ1o8ubl+bFkgagAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVtUUUh/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295f937d4c3so2983895ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762384587; x=1762989387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwAIlG6TTHwluLnC19ePK0hNp9oFcPVSx2rVuCQMRhQ=;
        b=BVtUUUh/aDbMLHmIIZEDEYstH8FyN9cBcBDRcNaoeie1FSYuNLgX0mmt6J8yztSVnb
         XwNFGxGV/bt/BUd1veam0dyIYGYk6Hci5+wc+vBjJy/BXQUAGmUpH4F4uwFkh4HakOW1
         NvEhLZasBsPHpVqq6juCtqGtTDAlQKF03RafmsOCuAh9kxI5dRKS09nd7hdDpb2CYHLV
         zCVhOVChyYKM1GirGBTYGphqemQEf9OAcmFhx/xEBgsme81ZziRoXSLEXmf2egHI1iPe
         NZg7zU73/lFXqn7RNDnJxCpe2S4mRManvhNZeME9rO/NLLV2/ggdnGUgC5HIL4snj/RZ
         pypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384587; x=1762989387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwAIlG6TTHwluLnC19ePK0hNp9oFcPVSx2rVuCQMRhQ=;
        b=AjZh7Ky51tby1i5wezCti4iafyCLpOVD9Ak77F7hS1ve8Vz1p+d5nTq+qU5YziZYEU
         FFtN3eNhjO4KYDSlN2pGylX3pZmf+vHgiaqMBqRzSpBmeM8idHCdb82QnKTysATEjBqz
         JbKXoweuA+L1InSNSdE14ZJBw3T78fqn8gFEWMLVl+j26tzdW9XtcRUl49IJvqwEzAPc
         8KRL6qee2ndHbrGg47bRT3g2m2Sd5rQ9H9xs6oddLlWHSovv2r665lVDfjtPDl49NKc0
         HSVBnDS4L02DczHecHyP0b92A03hMZ0uvsKkLqos8eLcwUXr2uILBVDjBSy98nyutVT7
         qowQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDnbaR1AlTJ7WJ8zd1mrJjSCzqzamTXQr/AiIguqzsrqK+HcDXQx1FFJQtDh2itxokaERzOacFOvbkesQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXkMIoX+1r/Pic8kx4v/iEgUDK4Xfom7lUw4nJWFT6k+72w/B
	6Tsf4XcFkKahz5MZiLuLG2668GjSLqCPD5nTbBgAPRHD2Tm8vYVA6KxH
X-Gm-Gg: ASbGncuZP5bb2TU+/2AeFEF2yXrGTeBlFN/Z2e3WjqAx0qPidIB7RSTPrtkxdqBDbw5
	d7tuRgCnY5bdxHDbmudqkASYdQG3/m1R1PToi2HXuINqc5KxnV2+iTMDGNsfpgO4S7aTiZ2A/8J
	KpOoJNufNgxneby7cnw+t/gbneRFL2z6+QK4Fbq6vZCFaFndMPUohKJVts7JBW+nhLWAOAGiO1S
	wFdYX91me1BQKzqCLJ8FROvC8cvb/AyJvdQIOoPdSqbygAfIShzRdV3Bm1xpodt4yAwWIOatOIZ
	BTi4/zHB1s+DZtyrXjc5lA8kOiMnxevnphEjSDZJRlgPpDdoT1AqnqaLzpEoP2zUo0ZlrQU/7E7
	7K5Bxjq9q46Vi8+7qF8FPXexi2EoVTVRBhvUBkG0kka9attK0Dnh5RlvYVXGCxSfv9QY26saWgg
	T/azle/PsfFiYQ5Ci4NNvR
X-Google-Smtp-Source: AGHT+IEepHklLDAxqKXJps4E9hwL8Bs3tisjtWzu/YVvcP91A5CkpsqwgRxYF4+8t3q3DKAyo0BvYA==
X-Received: by 2002:a17:902:ea10:b0:295:24ab:fb08 with SMTP id d9443c01a7336-2962adb27d6mr72654555ad.47.1762384587205;
        Wed, 05 Nov 2025 15:16:27 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.1.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93ce0sm6391925ad.88.2025.11.05.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:16:26 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:16:14 -0800
Subject: [PATCH 1/2] rust: cpumask: Add a `Cpumask` iterator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-cpumask-iter-v1-1-7536f906d7ed@gmail.com>
References: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
In-Reply-To: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762384584; l=2630;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=O+TJ1giWcgX8q8AVGe652HR0hPyTAH9TmZB/EtY9dHk=;
 b=sTFswU9v+NtwvD+1ATeGBxN3/kjtiLHvd6VJ9Q0ZY2hC8iqQZALO24cBW53aj3K6RF0bQCBqb
 G5lUorisoS2CtF+TJVAineCbVSChP8vZR54FiCfFK5HTHuvH8txb4Wx
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add an iterator for `Cpumask` making use of C's `cpumask_next`.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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


