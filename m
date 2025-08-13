Return-Path: <linux-kernel+bounces-766181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ABEB24356
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BDF880872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C302EA140;
	Wed, 13 Aug 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxvEjtxV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCD2D59E3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071678; cv=none; b=fbdFvCpm5tTD4s1uUZsD5jG1I3uuvMdzjwYCkkcCHf31sxPIFS5N6o99f7CwqIvHWGPXyfrjYxl2BdrF0W5fXewZprcpVHDubFYCH1WJD1aRXs6K5e4eqM2EGLsu14peIpY73z+AyIa1ay2FYX4kofw7TSJfqom6bDbTCJGB3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071678; c=relaxed/simple;
	bh=4UpC8Hp3hrOdrwKibq4sb+IA+3wfsieopAcrqEV0+wA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EwjBCi6Sm2giSkWYEBpA4r+X/1AxeUECuJ3IC4gJ+N5hqu8XlRqkLZgg7xUKyHfyGYtncVFj1u7dK7egzq5WLLG/SDgpf+uqiXE0U15Int7ZW9vCfGwrTaI/Ajem9SWlnsHbv4690PyAAlDzLkwwj/tAoK2cH1AMpZghLXHHUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxvEjtxV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-459e30e4477so52541685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755071675; x=1755676475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=enTpMUQG+N+PsNu+Ally96cHQthHKwj3Ek/gA2Hy28Q=;
        b=XxvEjtxV2tZLxnO/qnDhuRmNlE170aIsZtmIrT6/kpcdfVNTp+pbToqEbtJL77epCm
         K9l+GAbA7KRLzxOHSA98CMf6zuzD0zk05xUg2+2z+CbZEl7vFsnpBn9NWaxH6E3XRVTb
         gP3vtNcO+fSF937+2bjNIGRUepMsRWPHoBrk/CyBfq7HdpNaS2Z70PxDSnfUOSDIqsAh
         RlPcuVvPhww8OIZ58hAgVtmDX8NcFHC3GrUtOlsz4imilRdYh4leDOVHzR5cH3AIHaiX
         Le/zGF6Nhpu3HQTXr5XKD4mDjsAcxz6rOlhLHVxw/kSl1l2/5ZUicKZe4LPtcRWsxLUC
         069g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071675; x=1755676475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enTpMUQG+N+PsNu+Ally96cHQthHKwj3Ek/gA2Hy28Q=;
        b=KzI5opkF9TyzPMuIkUxmGNPVf0ejMzbU6qCJtDAYJekvfKTcmA5eoBg1CpVRnb2/u8
         8DU7M8MGEhdu+Fgr3CWW5yXN8NL6I3kCpgjzu2ipycIYQXtLvpgPWo9uoEftflQY50y0
         qySlfyxchSyLbZ1hSZXMYdlbEoSvzaN/wY568zWOMy7KgPSkNsPou+5k7OtA3irpqCeQ
         H+SvSbWptC2Qymxx2BtZ1YG9rmX4qGFtRW9DWGRc/PhY7UlYuke5SAMJd/SptV4Ntq/8
         Ia9cq7rgHJQn89s7iToQzjmj8HRXrhuglL8QLAdr9NIlH7EavXoXQG9bK50s+CA4BgsF
         Dn+g==
X-Forwarded-Encrypted: i=1; AJvYcCXpEsbfsL4kPu57rJ1+YM24rb4E7+XZh9VTtAP86btGu6Nxmk4rRGM0cXib+Wo/A0svyhkdpblXTTikOsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L0zcGCOTdbS2pj1hUW/TzGRpn/5a36B2YkLxebDTPghTvQO4
	d1yWZuIFi8SP+0ZnaEXRt3J/h5LLHFr9rHfe+9YdUoQKyIYxb3uycq4PDtHh/auHt52/X83FWx1
	EI401ig86ba0Xpkpb/g==
X-Google-Smtp-Source: AGHT+IF6GCq5hBvLNnDCh3mN33wn4e0d0z1DqWiY6K4ZB/EuNiV6oKLumjYG7PCtqpkwh9de5eaeh8TZoGhClBA=
X-Received: from wmbea15.prod.google.com ([2002:a05:600c:674f:b0:459:db87:c332])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:314c:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45a17258921mr8423235e9.2.1755071675021;
 Wed, 13 Aug 2025 00:54:35 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:54:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALZEnGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3eSC0tzE4mzdxOKi1DRdQwNTk6QUSzNzE6MUJaCeAqBgZgXYvOj Y2loAJfY+KF8AAAA=
X-Change-Id: 20250813-cpumask-asref-1054bd96742d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2622; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4UpC8Hp3hrOdrwKibq4sb+IA+3wfsieopAcrqEV0+wA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBonES5XZwUJ2selstqELMTKRORyQuTVShFfWyhi
 1SbJOyltlKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJxEuQAKCRAEWL7uWMY5
 RpCBD/9whSFM+wCJaGrpRwcPuDM7qu5xVbjiUAkZettBY+U6avijRh7vkpvhfUrA3VZRt5iXKEh
 xhOGV9Emhj26VaJHbHVPyo3ubnpBbeytDT9KUKfQ4wO40+1FqhPIPio/AotPN5OFXhGX7K4GD/t
 F4zZDsaRRPze0oWNcDtG52flLxZVJnYyY6lW96UptvP2Yxr33z9sHwToR6FL7QLpU4NWnIwsdqq
 /VexYRWE214/+MXZKYCJx0AzAIIumRwjZlgZhQOP7fle4C1bpIhjddwpCoCoP20yp3MnbeC9/6a
 geTM9wIs5wFdV4ZQqMJTADmSNjFo3RemzdUSYO76wajgiVzy5vJtw5/UIXrABv9pM600SApBkD8
 /3vCo2llvmOTLOhEqHvCd3MLPjjZzKvyFupnWn/j4hHDEBhSSO90SjHbG77olfsk57EQYQWLIkI
 ttJ8NZt2en/4HuCon9TQIH1qkPxHeScanN2BUKGWn4OQQ5MPO4nVAtssQS8yRk8xWeYoVnLrdiF
 3uAdzhpaP11T0ruKdtLTvWbLLaiwaFcU5NqxKXIlruKUKQAkVdkZLq95m8miHgWeUflUTPcnmEm
 JH4SBhNAt8BNHIjWVczqMQ6vYwMoab1IptKJygEDQXRc9iQcyX8thKorVLP7Zj3p3vNtlq+RsGA 358sFNT8abTXsMw==
X-Mailer: b4 0.14.2
Message-ID: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>
Subject: [PATCH] rust: cpumask: rename CpumaskVar::as[_mut]_ref to from_raw[_mut]
From: Alice Ryhl <aliceryhl@google.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, Yury Norov <yury.norov@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The prefix as_* shouldn't be used for constructors. For further
motivation, see commit 2f5606afa4c2 ("device: rust: rename
Device::as_ref() to Device::from_raw()").

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/cpufreq.rs | 2 +-
 rust/kernel/cpumask.rs | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index afc15e72a7c37ac781f25a8a6edd804fa4c9658a..eea57ba95f241dc06218e2d65a0986a1f9c1415c 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -543,7 +543,7 @@ pub fn register_em_opp(&mut self) {
     pub fn cpus(&mut self) -> &mut cpumask::Cpumask {
         // SAFETY: The pointer to `cpus` is valid for writing and remains valid for the lifetime of
         // the returned reference.
-        unsafe { cpumask::CpumaskVar::as_mut_ref(&mut self.as_mut_ref().cpus) }
+        unsafe { cpumask::CpumaskVar::from_raw_mut(&mut self.as_mut_ref().cpus) }
     }
 
     /// Sets clock for the [`Policy`].
diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index 3fcbff4386705490b73360e3108fa447e63b7b34..e311ab9038dfdac01cdbfe5a7303caf5922813fd 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -270,7 +270,7 @@ pub unsafe fn new(_flags: Flags) -> Result<Self, AllocError> {
     ///
     /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
     /// of the returned reference.
-    pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self {
         // SAFETY: Guaranteed by the safety requirements of the function.
         //
         // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
@@ -284,7 +284,7 @@ pub unsafe fn as_mut_ref<'a>(ptr: *mut bindings::cpumask_var_t) -> &'a mut Self
     ///
     /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
     /// of the returned reference.
-    pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpumask_var_t) -> &'a Self {
         // SAFETY: Guaranteed by the safety requirements of the function.
         //
         // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-cpumask-asref-1054bd96742d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


