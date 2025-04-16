Return-Path: <linux-kernel+bounces-606553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDEA8B0AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5B11899B71
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82822245038;
	Wed, 16 Apr 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qw5l8c3Q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBA23E336
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785648; cv=none; b=LwPsF6e9Pr9Gql1keGLSHxRm7WOusnKn5OLstBWvt44RTa8U0X4jE/PhpETgOXnGlZy/3ZMsMg2J3NkGcWDROcFZIOJub3CmIdQL81womtcQkU9f7wpMiRPodTV/bPVTwlcjQXSvOxId9f5HaEGL37Bnw9OWaIb4+/2YQyjh4nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785648; c=relaxed/simple;
	bh=0oAPeXp/PuUtI+r6+VnpeufFCyNZfY1rcOa88ugE1TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HC4E9tBIx9D0StJmVNtDxg4Ch/kEaBLqVSVDa8InmyT0a6VXR70+qXmce7evMVKvue5VD8fgx+tr2wO5b8vpM9Bh+qggpcrQCnX6WcFCua4zyVoGcGORxC3ZAbRSUF3p+hJY+80YMtq71P6i4iSlIFU1JCT5TBoBP4iQoedh1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qw5l8c3Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso7150175b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 23:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785646; x=1745390446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lQWbn6xCAFQD5C3/8f6kegHNBrNwg8cRG4PxnN6CGw=;
        b=Qw5l8c3QR2PZqgl9BQjWJ98u6hZKlktnzESsW+s5O08BGS3z0UZqcCkm4DW+yfVIAQ
         b1jQTn/wkVtvJgGQzAugJhBQSUL+aHfMdcAefR29gaiWNNR3ARJrLZr0BlT3K9RlCv9z
         f8D3Ha3kYF6hcWFZwSZYDPJrzU41TvIaxJuCoBNbBwbUn3hEPF56zEj/dzl8njKQwPAM
         dvSaqR2huOp7iweqsVNSnzQfUQMRE4RR2NtaH+1ZkOHHW7B2i5j3f4sK2g2CvCqQGtuD
         dvMqFXVkgYKhlfSPM1SkW32KTNLhCU61bFOKzRPpfpiXYHnIJurxwN8aqtR+Wl5R9Ylk
         fyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785646; x=1745390446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lQWbn6xCAFQD5C3/8f6kegHNBrNwg8cRG4PxnN6CGw=;
        b=t0vQt7vDIUdNkG9mg/4/5ksWTj2vTpbzxM6HM6acwmly6++BmwwGKjEGY1v8nTDwKm
         MsyHwbfmYBs8Tij+rvyAdTh++74kb/cspVY16PTJvZ1bt94zZ3eroo1E9MxyJfQ4d6WY
         dnbsm6ly+TvA3JWKd54WrvNLfBHYQjMbnVqQwov6bjah454fSM3FfPgNlQJu3bd0+Fy+
         hYyHT/bwNiehTleNy0nxYTUe5N3HyWlvLDDeX1wLqtSuPIPpltXx5pZFSNZmUoVME8o0
         gv5oC33xD9/+8t/CZKCPbNGP1POtHQ0HBwKH3Z8Cse29xLVRQOXEP9Y2SDGIKwEprP9H
         HCTA==
X-Forwarded-Encrypted: i=1; AJvYcCUKFojr3oiQJmC5awQkfCPMqPCklOlB0jPLvI9WrW0Cb2aPqVhJ8goKqlgaeIB42RiGEd7AiOf5v/choHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBS0hSAJGFQlpokDDOv7abS3K/CcLPGgucIswWyIYky3OgJTO
	2O8aU8bF1Ulp/8mlRd+DNm6vRKnABzk3EHLnMsnGP37PW1piAiWMalpOdTOq/Vk=
X-Gm-Gg: ASbGncvtQPZByL23yE3Mkm7J5PPFvgutXXKJS4VRLIrBFeYD96sF1e72mxweeAFSCXK
	YOYcoTKf99LwXY+vp0o+By/6XE9vX8MQ5hj5c4VB20ff5jf/1E3BLfYzERtjsorb8Djhr2xiTKo
	YldEIavmdwL1vBcUjtbnABFHDyOSiNFOSRnOOc7VyzjQymmJukydoZpUZR8bnptm5huT4VdgWTu
	kYu6bWT8q1Ix7vKa/83djeaYxM9KtknT2rc2qR15p/AusiZv4sJPXyEaL7s1rCWSIHCmiPOcg9/
	T80sO/c6T9o+Z/iTgMYF/AbxIzFGCjfd9QO9ND10jb2WeIxcxo4X
X-Google-Smtp-Source: AGHT+IGcC7USaY6oAxRsHSPlQeIONoztyY2iv3IC1aLwlzT7hWILIJ8jWmGaRC16byakE8SVjYhJkg==
X-Received: by 2002:a05:6a00:1487:b0:736:ab48:18f0 with SMTP id d2e1a72fcca58-73c266b318cmr900916b3a.1.1744785646320;
        Tue, 15 Apr 2025 23:40:46 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f1259sm9658028b3a.119.2025.04.15.23.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:45 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 14/15] rust: opp: Extend OPP abstractions with cpufreq support
Date: Wed, 16 Apr 2025 12:09:31 +0530
Message-Id: <a940d1b1a02d99fdc80ba8d0526c35a776854cb3.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1744783509.git.viresh.kumar@linaro.org>
References: <cover.1744783509.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the OPP abstractions to include support for interacting with the
cpufreq core, including the ability to retrieve frequency tables from
OPP table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 44e11808793a..734be8b6d0ef 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -19,6 +19,12 @@
     types::{ARef, AlwaysRefCounted, Opaque},
 };
 
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+#[cfg(CONFIG_CPU_FREQ)]
+use core::ops::Deref;
+
 use core::{marker::PhantomData, ptr};
 
 use macros::vtable;
@@ -496,6 +502,60 @@ extern "C" fn config_regulators(
     }
 }
 
+/// OPP frequency table.
+///
+/// A [`cpufreq::Table`] created from [`Table`].
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: ARef<Device>,
+    ptr: *mut bindings::cpufreq_frequency_table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates a new instance of [`FreqTable`] from [`Table`].
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.as_raw(), &mut ptr)
+        })?;
+
+        Ok(Self {
+            dev: table.dev.clone(),
+            ptr,
+        })
+    }
+
+    // Returns a reference to the underlying [`cpufreq::Table`].
+    #[inline]
+    fn table(&self) -> &cpufreq::Table {
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { cpufreq::Table::from_raw(self.ptr) }
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.table()
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: The pointer was created via `dev_pm_opp_init_cpufreq_table`, and is only freed
+        // here.
+        unsafe { bindings::dev_pm_opp_free_cpufreq_table(self.dev.as_raw(), &mut self.as_raw()) };
+    }
+}
+
 /// A reference-counted OPP table.
 ///
 /// Rust abstraction for the C `struct opp_table`.
@@ -751,6 +811,13 @@ pub fn adjust_voltage(
         })
     }
 
+    /// Creates [`FreqTable`] from [`Table`].
+    #[cfg(CONFIG_CPU_FREQ)]
+    #[inline]
+    pub fn cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
     /// Configures device with [`OPP`] matching the frequency value.
     #[inline]
     pub fn set_rate(&self, freq: Hertz) -> Result<()> {
-- 
2.31.1.272.g89b43f80a514


