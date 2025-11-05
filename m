Return-Path: <linux-kernel+bounces-887474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB7CC3851A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F918C6003
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314AF2F618B;
	Wed,  5 Nov 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiFn2Kb2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4B2F4A12
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384590; cv=none; b=He275x8l0WJkJF7eoWMhKIs6a4UqK/cXxnZQLvQmHSGNRJRvrPXMLKEwbPZ/WtulqGk3NjtIX1F+47z6zvAhIbp+HHWhiWU4hFlbqhTYhZiZEs7mZK0a+sc1nfgyevd04A1f84568Lw8UcvDPJEYVWH8jN7tKFudKYp0CJpKuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384590; c=relaxed/simple;
	bh=YISdcADBQqzuvoNcCs3nt3kan2jGJvuSVytELmc4hYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EddsDd3ZVMcjuFbMGEAaCuQh3j3JGHOSkD3V7yQBT3UFcVqXwxB6sO5OZy6u9m+jCD/IZFSZUeW99e7mmgWYeNu2xDIzsKdDD3k1YImQRiDxg9oNUz80brDdsUHQCV35cpj1pPb17SZYOKfzR0jzUrWvCU6SuRbNC1KBj4bP0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FiFn2Kb2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29568d93e87so3684275ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762384588; x=1762989388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6ObyT3Tt6gveKOeNa7NjmSIElr//qB7g+FJoPS22Qs=;
        b=FiFn2Kb2islhrWGo1x7AtCiM6O/QxzCAQGMxOa3dQrvZbEfcdFTWIn/VkKOPh7ISar
         b4Lx8OOiet/FwnLJDrzbD6pv9dWPCAevDeH54T/+2yC/5Ms//tRqOAQPMwfG//t6VsFW
         03fnb+GYRQVfby4d1d6A5mUcxBYR4Uw0b1FpSEMprU2X/ZJcLuG+ZN/nVHVUMacvYjjg
         AaqyaL/+yGGVSuq33iJ2oU0JT+UhjGC3BRHzaJBsDmQnkyKQSlp2SKfFc8jnI+zb/oR9
         5fA+FsnY2J8xpGdcgnDPAJxnND6twCihak9H9cvGQ9fs0FugkLxG6Wsto6beOIKVe87E
         Vx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762384588; x=1762989388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6ObyT3Tt6gveKOeNa7NjmSIElr//qB7g+FJoPS22Qs=;
        b=oYMkWfOuHRiSdmZODDk/P8W+0wIW09qOKXJW7R0jOC0Muh08CIHmqeU06zExaadmvc
         jNAqsQ5US6K5dVuxmH/mUTQ7e9KZAqpgmDsYWNPUrDctRdS3zypRl9P4IMp4Ux0xGKwV
         BOjYezTZ+YvIwUT65wh/sZaWKfWmmOfxzr7FpVMBJTDhaQS0vnZIFjQB+/y37TSYPMQj
         cFCTUVSupi4zAU40W5qXY8ZkpniHsb+bp3tW9uuRnpObBRZjvo74OTr9HlMhOweC2qrj
         PVmEOV7BPm4zK8YMC8qyoP0BWDpkvfI6n6dRkArm/4QZrWhwHr83k6I8/9A+PxboL5PA
         iTzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0KrZ6PBzSs33w7TsqB+nmOLhnqE00L1OLTaNdUztvWgvFL1AIYB+xZch4eYW2vCo3c7+WStM3xbIq358=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtsnQCKCFZpU970k9d5kkC3KmKAcsO9HmfkypvE1gER37XJh7
	15/Eu7kZeSfeEzxcokNOlyixDy1/ReltktZSE1CuDaAlmjyjSXsyXfKU
X-Gm-Gg: ASbGncvMvuNpvSXrY5gqk7XEIPQzzOlE1ux5p6bVkbgSt+7nThgF+AmJ/ZfeZahFU/1
	9BaDNnxmspwivRnlmgW1KZoNrSb92A87tA8LGQU/iN5o211kJam/XuhjqifKlT66tGkqIAI48A+
	Pdw6X/8T7KOJj8DvXjyhqJC3yrFYFm/B1RPYnliIMjhAdnJuI72DsziuADbMSu6+OL+XEyKcfN8
	n8RxRE6YZG4OyORaE9iz2CdXJZFkQcYyk0Y09CT2XIyTD30yg54kjB6NXmnf0/kDEQq4DjfwXnn
	jrrrUZ8fGH+/zkmJx30KO/vlLIP6eGoQysfFTw8TFZniq2AlcBAskicUaEJeALnVPbXKaMxfFM9
	CWrgZ0Dii/ssG0DQITD/MDCHi8T59VmwNcN4fkctHEzP0y/6IsTgWzu11kz2Fi8+tVf+FQ3NCug
	6xL1ziXXlP7J7dT1iE5yoa6qurYyZ/3d4=
X-Google-Smtp-Source: AGHT+IErnpQ9NEon4sLnfm43ewHu1WQPnKlmXQx64IUma2bPMa0syB8oJXoKEKJnh6FdaNt8aobyMg==
X-Received: by 2002:a17:902:ce91:b0:295:bba8:3c4d with SMTP id d9443c01a7336-2962ae4c366mr66913885ad.35.1762384588147;
        Wed, 05 Nov 2025 15:16:28 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.1.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c93ce0sm6391925ad.88.2025.11.05.15.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:16:27 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:16:15 -0800
Subject: [PATCH 2/2] rust: cpumask: Add getters for globally defined
 cpumasks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-cpumask-iter-v1-2-7536f906d7ed@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762384584; l=3255;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=YISdcADBQqzuvoNcCs3nt3kan2jGJvuSVytELmc4hYw=;
 b=uWbL7USdtFPgH46WxrNbQZ+7YvwlQnivbiloF3uMV8bMyInBPeqFjbQKvOxXYBDa7D6TidaKB
 dNHrZoxQBYzA/019iZJHr8ErSir7cF+0H6gpVhXBhlzP00RmajPrcVx
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add getters for the global cpumasks documented in
`include/linux/cpumask.h`, specifically:
- cpu_possible_mask
- cpu_online_mask
- cpu_enabled_mask
- cpu_present_mask
- cpu_active_mask

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index b7401848f59e..a6a130092fcb 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
         unsafe { &*ptr.cast() }
     }
 
+    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
+    #[inline]
+    pub fn possible_cpus() -> &'static Self {
+        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
+        // forever.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
+    }
+
+    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
+    /// scheduler
+    #[inline]
+    pub fn online_cpus() -> &'static Self {
+        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
+    }
+
+    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
+    #[inline]
+    pub fn enabled_cpus() -> &'static Self {
+        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
+    }
+
+    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
+    #[inline]
+    pub fn present_cpus() -> &'static Self {
+        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
+        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
+        // `__cpu_present_mask` may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
+    }
+
+    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
+    /// migration.
+    #[inline]
+    pub fn active_cpus() -> &'static Self {
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


