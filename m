Return-Path: <linux-kernel+bounces-606544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD8A8B08C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861A53BE409
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EFD228CA3;
	Wed, 16 Apr 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TULXhWD/"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EF522FE03
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785614; cv=none; b=jDDAusYY7b59TrFqVvTfUcTnDVfu6OlvpoboKq/3HtEMQOhq3EoA9Edw2JYkR+it8LPGFuBc2iB4W3bv1NyuKARNkjDYgpsGGJzFk/dSU2Np0dymgN+OaXwc/wWtvjSzXiQGnaF3zTgHRkuX5E/bthRL1mhx6XiYcdEpcRVuTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785614; c=relaxed/simple;
	bh=OK9LP8IuB4dZ4tNPJ7BqHK7tgUFvTgGIoVzWhWAVPdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tjpg0lJukJRQF6qQJTOI/62EdvUc4hcjJATJR+KayEd0/qhbIXbuCZzwLy+X2jK4XFw/2cPfdkePcjuCoMZ6bvVPiqb4kw+nUnzu91JSdcxo67k3g5uiQkXNvs6xrYTSB1h/5cz3txS82lwgbgk4zINFBDrbWgODW4RC5qUKehQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TULXhWD/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227a8cdd241so75746885ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785611; x=1745390411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtiIzVJT0XSWQl5nAIRSPSyCufgx9olJIUW0gvaR0zI=;
        b=TULXhWD/CRn2zolmJ1YU3NrM0E/0iVD12hRBEbyVoA7ynkS5eeJEdkJ26ZStL6Hh5q
         jQTOL0x+MCiACebhOHgmOW2Fz9RUOVJulpg6c2hcYd+ipTqNxI4UYYT9CFh87x9AAjDu
         RMxIeE4SUEwvPwT1AdTperQBnY85VqEz9e1wANDfBqDNeEzHgi7KU8yDGTYj25U1DL8l
         hIk3/l/NgreJ1UDcz1dLNHer44oHgehSMdHeym5l2XFvaicVsEfvB4UXF0oJr1Ltw+Jp
         pCDiKCD2UDAEyvUyBPLvkrn5JKPLxFvjt42VdnV0pbNfN+TSLQiXlGmjHI9eYrFm63Xi
         7U7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785611; x=1745390411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtiIzVJT0XSWQl5nAIRSPSyCufgx9olJIUW0gvaR0zI=;
        b=tOnikMk6FDZY+FOKEeYOgdmsuGCXAXs88Ic6NTMuPlr8DGWRGP83iNe4kIGqFP+XtB
         0DA1h5YyiXlO/PlPVi+lzZezp3MNy02yfDua5U3Iz8uF1KeMzqApJcJHdMqSXLVInaiO
         Y4724eSzhI2jhOH8g9pMtkr/eqXthJxXqvTnfsao7t9pScvLzMqBi0MVQjgeFTRgzXBk
         eg2KanL6EzkBdzic7j6rCQO7wGOJKO9Ltbuc8nJunpJ8DkGy755Eaq1FwqT24x1o5PnY
         po6RbnLOlW9G4ICSzAH49zpAvc14SO3nysoQP7xKWWYh77hdfsOcWnB0R4yuL+h1jFaU
         VKTA==
X-Forwarded-Encrypted: i=1; AJvYcCW5xpUVBfoAHx6Q3r13YQ7RkfGMjOaoC4b77NMdVt2XaRnxXvicyj+HB2DXgozPOmg+fE2ubjkuF4plSm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpLjtvS7Mcb9Wh4dsorWiFgcNs/CthwTH4iCGbBdmnc21klPuf
	E+ui7hDcAdqV56LuEjrVyiCezQgkRiosVdkYQ75dO7Ebow0mjvVcc4jUfLrifUU=
X-Gm-Gg: ASbGncs9sOaUaKmb1lpoU/5kL1qMGAJz63kD2G9JyzKy7Puf7AqX+ai0XHFue+bYv38
	pq5M3OCWy7Kao0+0jcc2peA0gA8M0iHahLavFKf9Ja7eg/kZgP6ZMXuEC3jv6RAymIOqOVGkr5p
	MvrrgB3bP6rHPi04zytVry7gCzpl9gN8tgzjhMRXtbE6cqPupWOpRw3H9SUA7PSMwyxzoaMVAtf
	ABjNrPWajMYqXUg+KNqH1Lkic5LURQE0y5+yF63dq+Y7oJ36AJOWqXfmwaufTInQ+37AQxy2GC9
	f4lBgOSIB+8nynIXRn1kCCRDQVTr6nUDprIjH5vEjg==
X-Google-Smtp-Source: AGHT+IEWuhQLaBTU4M/wgFAv18zSV246NrzKwik2ssZOtfWRe58J3TX0f/3yOuGQ17po2sEwvCNH9g==
X-Received: by 2002:a17:903:238a:b0:216:644f:bc0e with SMTP id d9443c01a7336-22c3590dcadmr13395765ad.24.1744785610853;
        Tue, 15 Apr 2025 23:40:10 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fe8de8sm6377705ad.248.2025.04.15.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:40:10 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
	Nishanth Menon <nm@ti.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 05/15] rust: clk: Add initial abstractions
Date: Wed, 16 Apr 2025 12:09:22 +0530
Message-Id: <4207f5bf540de148e1bd31a88dc75eaac1aaf897.1744783509.git.viresh.kumar@linaro.org>
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

Add initial abstractions for the clk APIs. These provide the minimal
functionality needed for common use cases, making them straightforward
to introduce in the first iteration.

These will be used by Rust based cpufreq / OPP layers to begin with.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS        |   1 +
 rust/kernel/clk.rs | 318 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   2 +
 3 files changed, 321 insertions(+)
 create mode 100644 rust/kernel/clk.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 608689342aaf..12cde55579a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5884,6 +5884,7 @@ F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
 F:	rust/helpers/clk.c
+F:	rust/kernel/clk.rs
 X:	drivers/clk/clkdev.c
 
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
new file mode 100644
index 000000000000..698e05cd41f8
--- /dev/null
+++ b/rust/kernel/clk.rs
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Clock abstractions.
+//!
+//! C header: [`include/linux/clk.h`](srctree/include/linux/clk.h)
+//!
+//! Reference: <https://docs.kernel.org/driver-api/clk.html>
+
+use crate::{
+    device::Device,
+    error::{from_err_ptr, to_result, Result},
+    ffi::c_ulong,
+    prelude::*,
+};
+
+use core::{ops::Deref, ptr};
+
+/// The frequency unit.
+///
+/// Represents a frequency in hertz, wrapping a [`c_ulong`] value.
+///
+/// ## Examples
+///
+/// ```
+/// use kernel::clk::Hertz;
+///
+/// let hz = 1_000_000_000;
+/// let rate = Hertz(hz);
+///
+/// assert_eq!(rate.as_hz(), hz);
+/// assert_eq!(rate, Hertz(hz));
+/// assert_eq!(rate, Hertz::from_khz(hz / 1_000));
+/// assert_eq!(rate, Hertz::from_mhz(hz / 1_000_000));
+/// assert_eq!(rate, Hertz::from_ghz(hz / 1_000_000_000));
+/// ```
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct Hertz(pub c_ulong);
+
+impl Hertz {
+    /// Create a new instance from kilohertz (kHz)
+    pub fn from_khz(khz: c_ulong) -> Self {
+        Self(khz * 1_000)
+    }
+
+    /// Create a new instance from megahertz (MHz)
+    pub fn from_mhz(mhz: c_ulong) -> Self {
+        Self(mhz * 1_000_000)
+    }
+
+    /// Create a new instance from gigahertz (GHz)
+    pub fn from_ghz(ghz: c_ulong) -> Self {
+        Self(ghz * 1_000_000_000)
+    }
+
+    /// Get the frequency in hertz
+    pub fn as_hz(&self) -> c_ulong {
+        self.0
+    }
+
+    /// Get the frequency in kilohertz
+    pub fn as_khz(&self) -> c_ulong {
+        self.0 / 1_000
+    }
+
+    /// Get the frequency in megahertz
+    pub fn as_mhz(&self) -> c_ulong {
+        self.0 / 1_000_000
+    }
+
+    /// Get the frequency in gigahertz
+    pub fn as_ghz(&self) -> c_ulong {
+        self.0 / 1_000_000_000
+    }
+}
+
+impl From<Hertz> for c_ulong {
+    fn from(freq: Hertz) -> Self {
+        freq.0
+    }
+}
+
+/// A reference-counted clock.
+///
+/// Rust abstraction for the C [`struct clk`].
+///
+/// # Invariants
+///
+/// A [`Clk`] instance holds either a pointer to a valid [`struct clk`] created by the C portion of
+/// the kernel or a NULL pointer.
+///
+/// Instances of this type are reference-counted. Calling [`Clk::get`] ensures that the allocation
+/// remains valid for the lifetime of the [`Clk`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to obtain and configure a clock for a device.
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::clk::{Clk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = Clk::get(dev, Some(c_str!("apb_clk")))?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::from_ghz(1);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+#[repr(transparent)]
+pub struct Clk(*mut bindings::clk);
+
+impl Clk {
+    /// Gets [`Clk`] corresponding to a [`Device`] and a connection id.
+    ///
+    /// Equivalent to the kernel's [`clk_get`] API.
+    ///
+    /// [`clk_get`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr()
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call [`clk_get`] for a valid device pointer.
+        //
+        // INVARIANT: The reference-count is decremented when [`Clk`] goes out of scope.
+        Ok(Self(from_err_ptr(unsafe {
+            bindings::clk_get(dev.as_raw(), con_id)
+        })?))
+    }
+
+    /// Obtain the raw [`struct clk`] pointer.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::clk {
+        self.0
+    }
+
+    /// Enable the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_enable`] API.
+    ///
+    /// [`clk_enable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_enable
+    #[inline]
+    pub fn enable(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_enable`].
+        to_result(unsafe { bindings::clk_enable(self.as_raw()) })
+    }
+
+    /// Disable the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_disable`] API.
+    ///
+    /// [`clk_disable`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_disable
+    #[inline]
+    pub fn disable(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_disable`].
+        unsafe { bindings::clk_disable(self.as_raw()) };
+    }
+
+    /// Prepare the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_prepare`] API.
+    ///
+    /// [`clk_prepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_prepare
+    #[inline]
+    pub fn prepare(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_prepare`].
+        to_result(unsafe { bindings::clk_prepare(self.as_raw()) })
+    }
+
+    /// Unprepare the clock.
+    ///
+    /// Equivalent to the kernel's [`clk_unprepare`] API.
+    ///
+    /// [`clk_unprepare`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_unprepare
+    #[inline]
+    pub fn unprepare(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_unprepare`].
+        unsafe { bindings::clk_unprepare(self.as_raw()) };
+    }
+
+    /// Prepare and enable the clock.
+    ///
+    /// Equivalent to calling [`Clk::prepare`] followed by [`Clk::enable`].
+    #[inline]
+    pub fn prepare_enable(&self) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+        // [`clk_prepare_enable`].
+        to_result(unsafe { bindings::clk_prepare_enable(self.as_raw()) })
+    }
+
+    /// Disable and unprepare the clock.
+    ///
+    /// Equivalent to calling [`Clk::disable`] followed by [`Clk::unprepare`].
+    #[inline]
+    pub fn disable_unprepare(&self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for
+        // [`clk_disable_unprepare`].
+        unsafe { bindings::clk_disable_unprepare(self.as_raw()) };
+    }
+
+    /// Get clock's rate.
+    ///
+    /// Equivalent to the kernel's [`clk_get_rate`] API.
+    ///
+    /// [`clk_get_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_rate
+    #[inline]
+    pub fn rate(&self) -> Hertz {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_get_rate`].
+        Hertz(unsafe { bindings::clk_get_rate(self.as_raw()) })
+    }
+
+    /// Set clock's rate.
+    ///
+    /// Equivalent to the kernel's [`clk_set_rate`] API.
+    ///
+    /// [`clk_set_rate`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_set_rate
+    #[inline]
+    pub fn set_rate(&self, rate: Hertz) -> Result {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_set_rate`].
+        to_result(unsafe { bindings::clk_set_rate(self.as_raw(), rate.as_hz()) })
+    }
+}
+
+impl Drop for Clk {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, self.as_raw() is a valid argument for [`clk_put`].
+        unsafe { bindings::clk_put(self.as_raw()) };
+    }
+}
+
+/// A reference-counted optional clock.
+///
+/// A lightweight wrapper around an optional [`Clk`]. An [`OptionalClk`] represents a [`Clk`] that
+/// a driver can function without but may improve performance or enable additional features when
+/// available.
+///
+/// # Invariants
+///
+/// An [`OptionalClk`] instance encapsulates a [`Clk`] with either a valid [`struct clk`] or `NULL`
+/// pointer.
+///
+/// Instances of this type are reference-counted. Calling [`OptionalClk::get`] ensures that the
+/// allocation remains valid for the lifetime of the [`OptionalClk`].
+///
+/// ## Examples
+///
+/// The following example demonstrates how to obtain and configure an optional clock for a device.
+/// The code functions correctly whether or not the clock is available.
+///
+/// ```
+/// use kernel::c_str;
+/// use kernel::clk::{OptionalClk, Hertz};
+/// use kernel::device::Device;
+/// use kernel::error::Result;
+///
+/// fn configure_clk(dev: &Device) -> Result {
+///     let clk = OptionalClk::get(dev, Some(c_str!("apb_clk")))?;
+///
+///     clk.prepare_enable()?;
+///
+///     let expected_rate = Hertz::from_ghz(1);
+///
+///     if clk.rate() != expected_rate {
+///         clk.set_rate(expected_rate)?;
+///     }
+///
+///     clk.disable_unprepare();
+///     Ok(())
+/// }
+/// ```
+///
+/// [`struct clk`]: https://docs.kernel.org/driver-api/clk.html
+pub struct OptionalClk(Clk);
+
+impl OptionalClk {
+    /// Gets [`OptionalClk`] corresponding to a [`Device`] and a connection id.
+    ///
+    /// Equivalent to the kernel's [`clk_get_optional`] API.
+    ///
+    /// [`clk_get_optional`]: https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
+    pub fn get(dev: &Device, name: Option<&CStr>) -> Result<Self> {
+        let con_id = if let Some(name) = name {
+            name.as_ptr()
+        } else {
+            ptr::null()
+        };
+
+        // SAFETY: It is safe to call [`clk_get_optional`] for a valid device pointer.
+        //
+        // INVARIANT: The reference-count is decremented when [`OptionalClk`] goes out of scope.
+        Ok(Self(Clk(from_err_ptr(unsafe {
+            bindings::clk_get_optional(dev.as_raw(), con_id)
+        })?)))
+    }
+}
+
+// Make [`OptionalClk`] behave like [`Clk`].
+impl Deref for OptionalClk {
+    type Target = Clk;
+
+    fn deref(&self) -> &Clk {
+        &self.0
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 75f78f6bfaa6..f4dcfefe94be 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,8 @@
 pub mod block;
 #[doc(hidden)]
 pub mod build_assert;
+#[cfg(CONFIG_COMMON_CLK)]
+pub mod clk;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


