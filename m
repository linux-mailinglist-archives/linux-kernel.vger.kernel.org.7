Return-Path: <linux-kernel+bounces-790582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88BB3AA7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3272056309D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B3D341660;
	Thu, 28 Aug 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrKBn7nv"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724B33EB17;
	Thu, 28 Aug 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407662; cv=none; b=BoA+lzNiMR6M4XcLmatMcl5Tmyklb+4ikrdS+WpQHNLeamfZnN4yGR5t5Lhu3jwSkb6adDM2r2MSI2JOVRITLhqMApU2TL1AgRfSVP3QkFGGaKrFdi3PyU4eglVKWLQeIOkNdOQhr+axirWYc4eQzt3KC6luWfFgRkIw6XCLs6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407662; c=relaxed/simple;
	bh=7jLeexJ2MkarSDLXB95v3y9TJT2OgU8sLC2vrrP6MLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrzzCrWtNutILDEgGJb1vb8wdixKplTp82A7/ZUSuITEPFTwCyVj6pTIJofBNekPMK49Lc8KbfbUDoVKsE7CN4Vf86UW9qUC25g20EZjhMKMn2XiI/PwTMcHdEGy9YVmrWQnEkO3ca2GH1pQFN8/WsNd2VqnQnvVEykGttzCIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrKBn7nv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32326793a85so1126422a91.1;
        Thu, 28 Aug 2025 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407660; x=1757012460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvt8V2L0ZNh+boeq/LSZQ3FvXwvuba2eMR3cn35JyVE=;
        b=DrKBn7nvFPPxJbVuUiHZQup0F5x3Nd20AhnzhcZII0ZZU83Qh1i0kNj8frumNkrR1a
         QtUzARz9bnikWjVwM20nQO52lLb9zWeZenz4B3TDGjK3QNQg8dbmJDnQUM1sI+jfufei
         RYgPu7QJAxLAc/eb1SJbhmnz73coSLjQJgWl76eGMjfKR/z6HWesUmXOMc85xOf5V0hr
         2RKi5AFxDsECu2sk/XP15q+Nn1dD2nTDqNdaaYZ2qnpXpDINA/uGzD/LJiiHRuJKETq4
         KbfFMdfXDlJdpIOdNYdnA1Y26cvyk6B1ocDDQLy2ld/hxmrb5hmOOqJ/+O9liLOZXcvs
         18mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407660; x=1757012460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bvt8V2L0ZNh+boeq/LSZQ3FvXwvuba2eMR3cn35JyVE=;
        b=bGSB2FIVu6+ffUHSIJ3ADDrqTTbZd2oEa4Fx/iAn3pmETlwe2wpBG6ruOe2dUgK5Yn
         3yqxCeUQgLue32qU6EP+uG3elV2V7ud969soDCgg0+bP+uQQAmAf8XL1YuGeNCRvZorM
         1Nzt4s9NpO4YGMKm2OE1a3rVrb8cic3BWmk4DoxHagNZJce5P+kRYKhqnrQrVcWUHj2Q
         Pc7tP0rQkjWIzhlsDDXPOORrElOqTDNhpFV1Kpha0v1tiz2r2YWEgiGW5gnygxOEj4Yo
         iozHeq5xnsrduKzrwan0H23p5f1zen9PfyxhprQzs3AaWK8a1b87qa6xM2tUdixRovld
         mXlw==
X-Forwarded-Encrypted: i=1; AJvYcCURbEIz0b/9dzEfK3mB5AnoCHEgxnrEJBmeRoTjShwAaqGYAJq007WYJHbDOMiHPaAHs14+SZLQ1tmo1BSzGr4=@vger.kernel.org, AJvYcCVv/7P+kZ62jLYSXmKsfzapxJF2Lk1+yJKou7e48d71m3Ve1mGD+oFCFY+Pk5iL3KhuqKuDh8AeS09UmGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2QKWj/L9uvm50LjIXIBJWbJEcI6fqn7TFkmOuAWPwjh0RI1j
	V6yaqf26EZ/P9ip8OLextbt/6+MP2XMjsovA4hl/4heJ95DReQGnZ+iWBt3aixM9
X-Gm-Gg: ASbGnctIC6n/fz/shfLMkj7xYAjGB6njIewkuTkQW8cSSySQbZoq9WOc1/DYzC//Mzc
	L38q0wqlYCBCEm7HJsJOr7b1aZXXVNe/1+kvOScLsu5r2d4tWuRWvpv0905YVLz6yPRK3QCMyno
	gcFNYL3dJQPzyEYVF5BNN2WCgu3irZlyqDbvAuokrSdY+8BFT9xScA2Wq2C4sMaY6IL4yOnNfnI
	aDLckYCZ9GheeIskmIrlEJdyrMilAsBDXJ8J4/X5zx2rdMVN3P8sR2aMa0VJjXtslCxDC2wi4kR
	bgT+Jyzsv3hu86URITuz5X5aUyVLeUzuq+MQE/XGpKuO+Zv6y8+N4+rGpTWpNJHmLymOJzlD2vC
	2Y/pXJjY3RTL5llbpbqqOWFqqufsQISENF16xy0lMQwwmUQ==
X-Google-Smtp-Source: AGHT+IGQ0nXDwQcd/znOgAHZEvb/bzRjgwuKUmEsfOnNkUUtXy/qInCtHGgW4wGogHPA6Xq9dBOiiw==
X-Received: by 2002:a17:90b:2810:b0:325:4c48:af54 with SMTP id 98e67ed59e1d1-3254c48af7fmr24907043a91.11.1756407659077;
        Thu, 28 Aug 2025 12:00:59 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:00:58 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:11 -0700
Subject: [PATCH v3 4/7] rust: cpumask: Add getters for globally defined
 cpumasks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-4-4dd92e1e7904@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=3131;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=7jLeexJ2MkarSDLXB95v3y9TJT2OgU8sLC2vrrP6MLQ=;
 b=zdA4F+LZY4slMG5Ve/I8Wi53or1iBeA2t76HP1S/w0KxfOdIOk6rZ4Cn8dc+CTq5sE+G9IGfS
 wDLwFlpvR9NCANhbfUBEg7Q4L7XNwOUKLYnJTuUUrEqPZkM8zn1ec0T
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add getters for the global cpumasks documented in
`include/linux/cpumask.h`, specifically:
- cpu_possible_mask
- cpu_online_mask
- cpu_enabled_mask
- cpu_present_mask
- cpu_active_mask

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index b7401848f59e..ca9aa6875b4a 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
         unsafe { &*ptr.cast() }
     }
 
+    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
+    #[inline]
+    pub fn possible() -> &'static Self {
+        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
+        // forever.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
+    }
+
+    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
+    /// scheduler
+    #[inline]
+    pub fn online() -> &'static Self {
+        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
+    }
+
+    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
+    #[inline]
+    pub fn enabled() -> &'static Self {
+        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
+    }
+
+    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
+    #[inline]
+    pub fn present() -> &'static Self {
+        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
+        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
+        // `__cpu_present_mask` may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
+    }
+
+    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
+    /// migration.
+    #[inline]
+    pub fn active() -> &'static Self {
+        // SAFETY: `__cpu_active_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_active_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_active_mask) }
+    }
+
     /// Obtain the raw `struct cpumask` pointer.
     pub fn as_raw(&self) -> *mut bindings::cpumask {
         let this: *const Self = self;

-- 
2.34.1


