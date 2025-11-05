Return-Path: <linux-kernel+bounces-887454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C1C384B3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A933A9706
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DBC221FB6;
	Wed,  5 Nov 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS/LjCIE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C41FDE31
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383749; cv=none; b=pm9l6Ct2LJFvWsvTdloOixAxzsYrLiFzi1Uy0uG1SDvPjqZGP+fEDPOos+v3XsHEP8B0X5bZxAl2Wq2KPoIx+XGe0BTPCDrCtRsjIcjhDct8e1ZH9m0uIuNpUSls9xpxDM+7yUBXKomBjKfUF/iIhMhBhCQzeKQXrdJeFigBC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383749; c=relaxed/simple;
	bh=O+TJ1giWcgX8q8AVGe652HR0hPyTAH9TmZB/EtY9dHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/4hdUtcC/KX52/v8R7fqDDF8qTAfUxDCNBqlyT3QZYHnrhw3liLgFlCL386JJvJciT4E+GfecEWtDVSJ0p3Yp4fQV0FMALu4Rz8X7JOthj/EQinqggjxp+cLMfovXBbwh7PCZtegGk32v30v1c+szkHFxTGSXRaqTlx/hqsCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CS/LjCIE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-295ceaf8dacso3673865ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383747; x=1762988547; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WwAIlG6TTHwluLnC19ePK0hNp9oFcPVSx2rVuCQMRhQ=;
        b=CS/LjCIEyPP388iMN8FFCVk34LhhJxphqF3MPao06xoHOEpgOn8h1fvlcGhow8QCkt
         1/k46yMUxVes7BTiLVTXutBhUu601LmL1RPM7dqRxGt0exuUdDzZIqSw/tZRxB7OYgsp
         NCW/b6/9Uknyhaq5RS8HsgwdVoKGj4VDMQwimHw44rG+UpvKF/zsCwPwRQuZp0uGbncg
         +mRtE4xqcZ28wBgdEy/rPvCkVtf2sJkUtBRyRt/obR1Ohi/lf2zAOpvn+g2Te9fzBXtX
         lkdlTIL+lDkd9UuF1rpGXzymvFuW2XHErONL9tNlcNvqB17acJfK38vpoimasYY+ABsc
         3S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383747; x=1762988547;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwAIlG6TTHwluLnC19ePK0hNp9oFcPVSx2rVuCQMRhQ=;
        b=qfliNxwnPGfu63fjUjuziTGqACvH5wnlWwf4wG68hnCW8/Cj4R8Gv7b0EieShvAJlo
         8DZR/q6XNQUwdamuVSuugQ0RH9mZ6DPTdI71L1s45XTZQvzx24P+J/p3tB8jjetYsZV6
         OW759pVuVldyr0N30n2q7411X7IEep9PHF5WnIanxeh+GdKiG2RpTvcONwqDShUEch79
         steENQEO1ZjTpgD09ezbcDQOapYdC1DaJArHT1hUpID4v7sCOxtIENJEDldozd6ZQeaN
         iLaN106zieA7ysZzqBQbkOjSM5c6wfFfTMv6dIIy1y3d/Y6MFlEmbCcivnHUWf/1mrD/
         BZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUGuWooptt6NaZhiCA/daUjuHiL1kymX65Nw49S7XCwpAbaeBrvDYiZkZp+2znZvRyp5/DsoOgTs9/f+0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyArrcn3oQT5e7yR3OKCG4KdLBxDIW8ArZLt3zS5XY/gdkp5A2
	MEGuKHjNvmYoBTqHmpN3JKpfvbvtZi6ck+5IX6Lz7n4Wb8hYzW/ZmPFcEs8Qx/Ae
X-Gm-Gg: ASbGncvxgcPoKYS38ng7pR5N0QRSrDSgXQu5XLLzJw5/yf5BafwocjVCJ7kedJgY/C8
	bPaFKpU1k9+m9G1SYTcU1G2ndYQRrmYoPi4QbIm94ugjjNONOpTK/a4Kmfq0K69ZhL+0855fjs+
	7HE8vixpcKXD5mqQzRn3dIm0K4UVTsntOkFt3WPNCmkQxVEFrsfeLP4EoHxnjH2/JydXYjZQ9S3
	JwgkztE7DMGDcuZLhHHJDWUnf0vJMa+MV13dXEYh2F1b/teadTgo6A97sCxY8+utArCGBXgBZLU
	i67EChdXFTkdXJIvhA4wFzJN8YwrvX2GkVtSC97Jwec7XeLIawFrIAwq5HBgLSo40DMJND0ZB9a
	MMVOPiVQW7I5JtvlfDtidCnEzH6KEjm6qDaJ4gOM5YFZS1MqPrvzTQuNElQ0QHuID8AePCRvXdq
	X1WzBcjxvWd3U9JCa21G3g4wk=
X-Google-Smtp-Source: AGHT+IE331S/e6OJPAmtF3ZjSt+Kn7kDN7/mWSvZsNxV7o3ouRhjWuYNtynxsbk6GSGpD8SmdbjGKQ==
X-Received: by 2002:a17:902:c401:b0:295:5da6:6014 with SMTP id d9443c01a7336-2962ad2ae93mr63812035ad.22.1762383747306;
        Wed, 05 Nov 2025 15:02:27 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:26 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:13 -0800
Subject: [PATCH v4 1/9] rust: cpumask: Add a `Cpumask` iterator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-1-984b1470adcb@gmail.com>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
In-Reply-To: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, Allen Pais <apais@linux.microsoft.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=2630;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=O+TJ1giWcgX8q8AVGe652HR0hPyTAH9TmZB/EtY9dHk=;
 b=8IczBPVeTYnGGmDoLSMEmJlu5vzuoGi7eS1E9YY+hxeS+rAglAWrTxtFqNGLBBFPmAYcnTMTJ
 x4pMKIkcfTyAX8RTADOq/K1QFRETacSNE1KN9TEQp5gLyy/1NwS76JQ
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


