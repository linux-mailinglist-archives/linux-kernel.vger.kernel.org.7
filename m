Return-Path: <linux-kernel+bounces-653169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57243ABB5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 09:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB613BA336
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968B826A0D6;
	Mon, 19 May 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWeFw3kO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9126A0CC
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638503; cv=none; b=HbT4vyZMk3txVile4KhKa+MIMrmQ/l4Jo2QumjyYnf06hKZ/SLNTUAJYAKCjGmGIVN0nDH8AWLnKaNExRBvxRg+R5w1g6SzqJZefKk83ZWBslC8/Wh5ztTfNZub04mtMCMtNxl27sBmxvMuf5bPeQD4v48YFGd7ubndovKELyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638503; c=relaxed/simple;
	bh=RAjLeKI3WBuAp6e6mJAu5A1TpMkFZi2yh4Xbioapaok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhn4Sy+D0+66n4YyJF/Cw6zdcEXO3n9zW/Q7HcI20SK228ePYH7vpgkdQ9Eob78W5HGpD8Mu/nUQAu59K8j8PKYbtb2m+GuAiM7LmPGos4CEx5KW7/6d4eHX9T0f1hIChJKlCAoUwfEbA9/GBH0ssxBcRbr+0qbcRoKKVtK/NQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWeFw3kO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742c27df0daso819817b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638499; x=1748243299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO4wnRGM2Ejv79vsyqjeDReSjXsKi/ultczUPSVrwTg=;
        b=CWeFw3kOHoxrQx+VQDnw/TRVdyf+4Vxm0WcMFCVcaYFErcy1yB6sFDTtCK+jTwhaqS
         wImkCAm04H7PK7KzfvRmynv02pBgf5UDgoNJcBfGQ1Zd8PDw5zUb77CquQixsXG9M1FC
         sVMnyu6ZOjrIVTtrxAStrfFQouQddyWeD3xGCb7UicZH7+hI6mhseiTzAsNaxX5kabI4
         2z6oi+/H7dT4cAOm91ePfiwDTI9OM7xMwlvArgdcA3YDd9mhsPXP9W8XXa5fUBm+GEnq
         16mjib8rQ12BLsW6LdNSDsOY+NOqr+IAwlfNppXREEjioqmzwcYM/tKD/KbFmtCh4vXk
         R2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638499; x=1748243299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cO4wnRGM2Ejv79vsyqjeDReSjXsKi/ultczUPSVrwTg=;
        b=jf1UlcxDLQB6J9hzB+kBFznqkQ21HICu93cOm6dDO0BfCXPcoz+W0K9/fVDolV+DGb
         mwJFir9fsyX6m+Qk5r748hH284KHY8x9rV2ICIfzJ0IOj16Llc6/GoHxC4jGcZgX9daA
         G+I2kiHKkuPYCQY4H9g92YY00A3aj51Taxl05EAP5NrtaE9BfpvZrVaFR1sn0RHLlHkO
         90RB+WU+InLS+5FncP6w53dXx6YzrXIfqB4ezHbQ9LYxWJ2nCYazpRWwoajO3SAeOWa6
         n46dUwcK2nAGGDE9jiLTiZu7xYnYzssho3T0O2RMtl54Vj3VbTeN/vV6WqomIC9rEJf/
         kOCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhKGupmk1HE+l/pyhlbFNAD5YuMqi1uGxCrb4zk3NwcSbXUw8hpOu4kDXDV2xb0du1SClnxqTFcqlrEHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy00koGEZyJZvOYXYmZl3l/LtkTn/vA3AQog5xh3n4RP1BYEC90
	Cam8C9vxWzkGjuy7ZZaDAgsuEmvzsmlIvm0yv1TvMrDYsx+t3jHcbotOcRD62lw9avE=
X-Gm-Gg: ASbGncuXrkntFdBen0Iyzju+K5/HqPckNJLe7oYnG0W/ngEdULrI2pmjgYm5AN/nIte
	hbcsd1v0cby2ULVMVswVA/Zb1sQ68Em4HUtl0NcAoaJYMz55sEHyX4WmyQgPejkwNI0Fb8YQKBA
	k4PfmjZE9eRx2rplnsG0YxCiZ+InLbijltmLHE67/2eLE/QiRRM8ACNaoxWdV/Rw8qDp72DCCb9
	nMW4NaPJzMaGq8i/kRAB3b0b3JD2hRa25z+XD5vjEXIU7pWC3VUbQm9axCjFInhrCST2eArwKdc
	6uhbUu0xScALdMbXzN5yeoGC16x0PH5fU9bK/In+IV4+VPVf6lkT
X-Google-Smtp-Source: AGHT+IF91jPSa77aCMbVavywdkUMQvhenQWNThM2xiCVN5W+Sa/SaDi89mcOEbghpdMcZlwk5UkZ2Q==
X-Received: by 2002:a05:6a21:3990:b0:1f5:7ea8:a791 with SMTP id adf61e73a8af0-2162189ce3fmr16488703637.10.1747638499079;
        Mon, 19 May 2025 00:08:19 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9739cdesm5558891b3a.82.2025.05.19.00.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:08:18 -0700 (PDT)
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
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 09/15] rust: opp: Add abstractions for the OPP table
Date: Mon, 19 May 2025 12:37:14 +0530
Message-Id: <d278b80d08be8ff1ec9694ea9497a83795f3f6d1.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce Rust abstractions for `struct opp_table`, enabling access to
OPP tables from Rust.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 487 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 486 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 8f0493a8b6e8..18f55c00a4d6 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -10,8 +10,9 @@
 
 use crate::{
     clk::Hertz,
+    cpumask::{Cpumask, CpumaskVar},
     device::Device,
-    error::{code::*, to_result, Result},
+    error::{code::*, from_err_ptr, to_result, Error, Result},
     ffi::c_ulong,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -171,6 +172,469 @@ fn freq(&self) -> Hertz {
     }
 }
 
+/// [`OPP`] search options.
+///
+/// ## Examples
+///
+/// Defines how to search for an [`OPP`] in a [`Table`] relative to a frequency.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::error::Result;
+/// use kernel::opp::{OPP, SearchType, Table};
+/// use kernel::types::ARef;
+///
+/// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
+///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
+///
+///     pr_info!("OPP frequency is: {:?}\n", opp.freq(None));
+///     pr_info!("OPP voltage is: {:?}\n", opp.voltage());
+///     pr_info!("OPP level is: {}\n", opp.level());
+///     pr_info!("OPP power is: {:?}\n", opp.power());
+///
+///     Ok(opp)
+/// }
+/// ```
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum SearchType {
+    /// Match the exact frequency.
+    Exact,
+    /// Find the highest frequency less than or equal to the given value.
+    Floor,
+    /// Find the lowest frequency greater than or equal to the given value.
+    Ceil,
+}
+
+/// A reference-counted OPP table.
+///
+/// Rust abstraction for the C `struct opp_table`.
+///
+/// # Invariants
+///
+/// The pointer stored in `Self` is non-null and valid for the lifetime of the [`Table`].
+///
+/// Instances of this type are reference-counted.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to get OPP [`Table`] for a [`Cpumask`] and set its
+/// frequency.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::cpumask::Cpumask;
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+/// use kernel::opp::Table;
+/// use kernel::types::ARef;
+///
+/// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
+///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
+///
+///     if opp_table.opp_count()? == 0 {
+///         return Err(EINVAL);
+///     }
+///
+///     pr_info!("Max transition latency is: {} ns\n", opp_table.max_transition_latency_ns());
+///     pr_info!("Suspend frequency is: {:?}\n", opp_table.suspend_freq());
+///
+///     opp_table.set_rate(freq)?;
+///     Ok(opp_table)
+/// }
+/// ```
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: ARef<Device>,
+    #[allow(dead_code)]
+    em: bool,
+    #[allow(dead_code)]
+    of: bool,
+    cpus: Option<CpumaskVar>,
+}
+
+/// SAFETY: It is okay to send ownership of [`Table`] across thread boundaries.
+unsafe impl Send for Table {}
+
+/// SAFETY: It is okay to access [`Table`] through shared references from other threads because
+/// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Table {}
+
+impl Table {
+    /// Creates a new reference-counted [`Table`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    unsafe fn from_raw_table(ptr: *mut bindings::opp_table, dev: &ARef<Device>) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        //
+        // INVARIANT: The reference-count is decremented when [`Table`] goes out of scope.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpus: None,
+        }
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Device`].
+    pub fn from_dev(dev: &Device) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.as_raw()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.into(),
+            em: false,
+            of: false,
+            cpus: None,
+        })
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Device`] based on device tree
+    /// entries.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of(dev: &ARef<Device>, index: i32) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.as_raw(), index) })?;
+
+        // Get the newly created [`Table`].
+        let mut table = Self::from_dev(dev)?;
+        table.of = true;
+
+        Ok(table)
+    }
+
+    /// Remove device tree based [`Table`].
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    fn remove_of(&self) {
+        // SAFETY: The requirements are satisfied by the existence of the [`Device`] and its safety
+        // requirements. We took the reference from [`from_of`] earlier, it is safe to drop the
+        // same now.
+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.as_raw()) };
+    }
+
+    /// Creates a new reference-counted [`Table`] instance for a [`Cpumask`] based on device tree
+    /// entries.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of_cpumask(dev: &Device, cpumask: &mut Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned pointer will be owned by the [`Table`]
+        // instance.
+        //
+        // INVARIANT: The reference-count is incremented by the C code and is decremented when
+        // [`Table`] goes out of scope.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_raw()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        table.cpus = Some(CpumaskVar::try_clone(cpumask)?);
+
+        Ok(table)
+    }
+
+    /// Remove device tree based [`Table`] for a [`Cpumask`].
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    fn remove_of_cpumask(&self, cpumask: &Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from [`from_of_cpumask`] earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_raw()) };
+    }
+
+    /// Returns the number of [`OPP`]s in the [`Table`].
+    pub fn opp_count(&self) -> Result<u32> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.as_raw()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u32)
+        }
+    }
+
+    /// Returns max clock latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_clock_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max volt latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_volt_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns max transition latency (in nanoseconds) of the [`OPP`]s in the [`Table`].
+    #[inline]
+    pub fn max_transition_latency_ns(&self) -> usize {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.as_raw()) }
+    }
+
+    /// Returns the suspend [`OPP`]'s frequency.
+    #[inline]
+    pub fn suspend_freq(&self) -> Hertz {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        Hertz(unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.as_raw()) })
+    }
+
+    /// Synchronizes regulators used by the [`Table`].
+    #[inline]
+    pub fn sync_regulators(&self) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.as_raw()) })
+    }
+
+    /// Gets sharing CPUs.
+    #[inline]
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_get_sharing_cpus(dev.as_raw(), cpumask.as_raw()) })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.as_raw(), cpumask.as_raw())
+        })?;
+
+        if let Some(mask) = self.cpus.as_mut() {
+            // Update the cpumask as this will be used while removing the table.
+            cpumask.copy(mask);
+        }
+
+        Ok(())
+    }
+
+    /// Gets sharing CPUs from device tree.
+    #[cfg(CONFIG_OF)]
+    #[inline]
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.as_raw(), cpumask.as_raw())
+        })
+    }
+
+    /// Updates the voltage value for an [`OPP`].
+    #[inline]
+    pub fn adjust_voltage(
+        &self,
+        freq: Hertz,
+        volt: MicroVolt,
+        volt_min: MicroVolt,
+        volt_max: MicroVolt,
+    ) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_adjust_voltage(
+                self.dev.as_raw(),
+                freq.into(),
+                volt.into(),
+                volt_min.into(),
+                volt_max.into(),
+            )
+        })
+    }
+
+    /// Configures device with [`OPP`] matching the frequency value.
+    #[inline]
+    pub fn set_rate(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Configures device with [`OPP`].
+    #[inline]
+    pub fn set_opp(&self, opp: &OPP) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.as_raw(), opp.as_raw()) })
+    }
+
+    /// Finds [`OPP`] based on frequency.
+    pub fn opp_from_freq(
+        &self,
+        freq: Hertz,
+        available: Option<bool>,
+        index: Option<u32>,
+        stype: SearchType,
+    ) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+        let index = index.unwrap_or(0);
+        let mut rate = freq.into();
+
+        let ptr = from_err_ptr(match stype {
+            SearchType::Exact => {
+                if let Some(available) = available {
+                    // SAFETY: The requirements are satisfied by the existence of [`Device`] and
+                    // its safety requirements. The returned pointer will be owned by the new
+                    // [`OPP`] instance.
+                    unsafe {
+                        bindings::dev_pm_opp_find_freq_exact_indexed(
+                            raw_dev, rate, index, available,
+                        )
+                    }
+                } else {
+                    return Err(EINVAL);
+                }
+            }
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_freq_ceil_indexed(raw_dev, &mut rate, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(raw_dev, &mut rate, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds [`OPP`] based on level.
+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(raw_dev, level) },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_level_ceil(raw_dev, &mut level)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_level_floor(raw_dev, &mut level)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Finds [`OPP`] based on bandwidth.
+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<ARef<OPP>> {
+        let raw_dev = self.dev.as_raw();
+
+        let ptr = from_err_ptr(match stype {
+            // The OPP core doesn't support this yet.
+            SearchType::Exact => return Err(EINVAL),
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_bw_ceil(raw_dev, &mut bw, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+            // requirements. The returned pointer will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_bw_floor(raw_dev, &mut bw, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_raw_opp_owned(ptr) }
+    }
+
+    /// Enables the [`OPP`].
+    #[inline]
+    pub fn enable_opp(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Disables the [`OPP`].
+    #[inline]
+    pub fn disable_opp(&self, freq: Hertz) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.as_raw(), freq.into()) })
+    }
+
+    /// Registers with the Energy model.
+    #[cfg(CONFIG_OF)]
+    pub fn of_register_em(&mut self, cpumask: &mut Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_register_em(self.dev.as_raw(), cpumask.as_raw())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    /// Unregisters with the Energy model.
+    #[cfg(all(CONFIG_OF, CONFIG_ENERGY_MODEL))]
+    #[inline]
+    fn of_unregister_em(&self) {
+        // SAFETY: The requirements are satisfied by the existence of [`Device`] and its safety
+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.as_raw()) };
+    }
+}
+
+impl Drop for Table {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
+
+        #[cfg(CONFIG_OF)]
+        {
+            #[cfg(CONFIG_ENERGY_MODEL)]
+            if self.em {
+                self.of_unregister_em();
+            }
+
+            if self.of {
+                self.remove_of();
+            } else if let Some(cpumask) = self.cpus.take() {
+                self.remove_of_cpumask(&cpumask);
+            }
+        }
+    }
+}
+
 /// A reference-counted Operating performance point (OPP).
 ///
 /// Rust abstraction for the C `struct dev_pm_opp`.
@@ -184,6 +648,27 @@ fn freq(&self) -> Hertz {
 /// represents a pointer that owns a reference count on the [`OPP`].
 ///
 /// A reference to the [`OPP`], &[`OPP`], isn't refcounted by the Rust code.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to get [`OPP`] corresponding to a frequency value and
+/// configure the device with it.
+///
+/// ```
+/// use kernel::clk::Hertz;
+/// use kernel::error::Result;
+/// use kernel::opp::{SearchType, Table};
+///
+/// fn configure_opp(table: &Table, freq: Hertz) -> Result {
+///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
+///
+///     if opp.freq(None) != freq {
+///         return Err(EINVAL);
+///     }
+///
+///     table.set_opp(&opp)
+/// }
+/// ```
 #[repr(transparent)]
 pub struct OPP(Opaque<bindings::dev_pm_opp>);
 
-- 
2.31.1.272.g89b43f80a514


