Return-Path: <linux-kernel+bounces-870308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5870C0A6DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08E4F4E5C91
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE83F2110;
	Sun, 26 Oct 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfBJR55R"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3288E4400
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481004; cv=none; b=I2gayjDwxe5N3dI0yJmbAl1aBdIJ1Yc/ZYhbHH1RCA1HB2bovNTHq6ZZVH2eWxsiyZQ5/i5Y5zUlb2MES4KbxW0/SWv69qKKSC0JvNTPlo4dt1HGiJSLAIaxhZU7ciW3G8i9H9f3vDHtwMjUMf6srjhm2saW2LMkdnc+4mb6Akw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481004; c=relaxed/simple;
	bh=asvHSs16qRYWY3AyvN6c22LQmv0m5CFcbjhFgSLErzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EVksgsKm7i5e//Ke4CnrR7fUlhNetKeMECh/EKKButWy6jAW+06ZxK+A+PU6/GVRe0XTRgNtUODiWqJHGq5k3P2xUvSj+eV+q85BDa4njvhhfwtVVsvkHCaiukyEgljAIYoaf+i5wHrx+5Uz+tQ3HYZcsM2+8whya0BMCGzlhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfBJR55R; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso2960554b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761481002; x=1762085802; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MaAGqYii/RVQjpg+Bcl6+sMv72xnIH7MMiaPPCxNY/E=;
        b=kfBJR55RlJUV5cU32AuuYvYRAuFNX4VqUp59Lc3YNrI9l5G+gVuxtxWWPYd0ExSdvT
         o+tjOMR4yEbgnv/lJGvpwn0PoPbBv9PR0zrXYCnbVE1jsue7XSt6Rq+4k3D1BXdY7wD4
         DUW1NRNuoy5ZIRv0HmAyZ1TBtwbpXoXFTZa7jekEdqcCKfDM6iOMP79PfzRwpRCltKxL
         huS/dvGrsQeBo8a9PxmEihMRmrW8+Jq4PTzooKQR8Fkqq2NaJRzamEmXf2WiF5tPAMHi
         /gqPzb293O2jndxJl7RNfNTyIaERbyQWFeV2z4izltQY7gsYUkhfuT0B2S1RocgZ3CEU
         u1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761481002; x=1762085802;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaAGqYii/RVQjpg+Bcl6+sMv72xnIH7MMiaPPCxNY/E=;
        b=EB5sPjJ+XQRc9tIMjLF0IB/tR1QNClJDOHk4dcEMTw8XBEvdujCzX2FUoWFNG3l+8V
         em/TZooxsqSatcs4jlXUdQzhUgA5WTfReC9A7huvJRQOp57816SuoMS8k1fbtpB11hSF
         sK9zbx1hT4ooj6xXYxA3WibisVsDAU63jJ3VhcbxldnGPB8GlzSVR40HWrpTAUJWrEXQ
         TIBqhltsmyGxK7B2jzja6W0Kwwat5Zey5TMjEY/HECTdqFsBRrE0sPnhK+HRLakOx2go
         JB4Z18XC8z9hEh3i2/jQd2A6/aEN9CLCA2lnwi2EMIggknkDAPPuz9FEsCI5hVRO4ecp
         7DRg==
X-Forwarded-Encrypted: i=1; AJvYcCVL4SzJprgpgX04KplAPTA+ZzOSCs5zx9gUfnxU2QUStRjcAYXxpOo06lk5YSBhSXacNjtUozuMf0uQk/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUOaGYG5d12ydtKm0LcT14AzujT3GIlw1jBYV1xpDUUPMd3so
	5hjqufg55XXAqiP/g4glOn2GNhwzKMNl1Z/gL4Bbf7c3m+jQJbYFjF98
X-Gm-Gg: ASbGnct4W+D1aUXEHSFbCTtMCP4TBEqy3NJeFnv1l8BaxMLjzCoCu41jCYDD0HzEQZf
	cntqEi6GugwRtxvZIfICSHkNeV22dE/jzsyhMTR8glDhWWYJJrM6F/Tu6716jQoUirh8H2Ab+2L
	w4EeERk+QtXcSMorNER5I261trAUaLVttF7Z5unRawKl7dOIp3rClUpoT56jaccF9TWC3rcAQAF
	TTw6m7x7xWlrD93iTt9TFohmf85YmVo6NiIt0wY2gX/Hu6lTK0kDQ3xwRLRexBkI2tdMa8l0lx7
	J845Ys28lEmcKInp6xIo9QmmT1LUKNobeEwTu6Wfpq7ln0hx7jWt7TAp4udasjYQ5agtIdgVhSQ
	MpQiX7LsQegEPKZhvcJ3kSFv9DIlg1+xIQ9F3nSbKDN8yPPQq7mwBdOysneuv/VXe+ML4Kzo7GH
	LzcCbZmyc=
X-Google-Smtp-Source: AGHT+IFmHuylR7Ui6hsy1odnbRX2+lABszBxXIycdwPxbfbofwKJPRVZapxqclulIWt/Z5OK+YneXA==
X-Received: by 2002:a05:6a20:7344:b0:2b4:41d9:b068 with SMTP id adf61e73a8af0-334a85ef540mr41378632637.37.1761481002281;
        Sun, 26 Oct 2025 05:16:42 -0700 (PDT)
Received: from fedora.local ([2804:d57:4e50:a700:f33d:65d1:e22e:109b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127a0a2f9sm4535238a12.9.2025.10.26.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 05:16:41 -0700 (PDT)
From: Filipe Xavier <felipeaggger@gmail.com>
Date: Sun, 26 Oct 2025 09:16:15 -0300
Subject: [PATCH v4] rust: add new macro for common bitmap operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-feat-add-bitmask-macro-v4-1-e1b59b4762bc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA4R/mgC/4XOwQ6CMAwG4FchOzuzdQPUk+9hPHRbgUUBsxGiI
 by7g4vExJie/ib/104sUvAU2SmbWKDRR993KehdxmyDXU3cu5QZCMiFEppXhANH57jxQ4vxxlu
 0oeeFBm2kVbIkYKn8CFT55wpfrik3Pg59eK13Rrls/5Kj5GksODDW6LIw57pFf9/bvmULOcKGg
 fwnA4lxyhAah+4oqm9GfRgt5U9GLd8cSuMUaRSKtsw8z2+l+GsYSgEAAA==
X-Change-ID: 20250304-feat-add-bitmask-macro-6424b1c317e2
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org, 
 felipe_life@live.com, linux-kernel@vger.kernel.org, 
 Filipe Xavier <felipeaggger@gmail.com>, Lyude Paul <lyude@redhat.com>
X-Mailer: b4 0.14.2

We have seen a proliferation of mod_whatever::foo::Flags
being defined with essentially the same implementation
for BitAnd, BitOr, contains and etc.

This macro aims to bring a solution for this,
allowing to generate these methods for user-defined structs.
With some use cases in KMS and upcoming GPU drivers.

Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/We.20really.20need.20a.20common.20.60Flags.60.20type
Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Suggested-by: Lyude Paul <lyude@redhat.com>
---
Changes in v4:
- Use enum: changed flag type from struct to enum.
- Minor fix: airect casting (flag as $ty) instead of field access (.0).
- Link to v3: https://lore.kernel.org/r/20250411-feat-add-bitmask-macro-v3-1-187bd3e4a03e@gmail.com

Changes in v3:
- New Feat: added support to declare flags inside macro use.
- Minor fixes: used absolute paths to refer to items, fix rustdoc and fix example cases.
- Link to v2: https://lore.kernel.org/r/20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com

Changes in v2:
- rename: change macro and file name to impl_flags.
- negation sign: change char for negation to `!`. 
- transpose docs: add support to transpose user provided docs.
- visibility: add support to use user defined visibility.
- operations: add new operations for flag, 
to support use between bit and bitmap, eg: flag & flags.
- code style: small fixes to remove warnings.
- Link to v1: https://lore.kernel.org/r/20250304-feat-add-bitmask-macro-v1-1-1c2d2bcb476b@gmail.com
---
 rust/kernel/impl_flags.rs | 227 ++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs        |   1 +
 rust/kernel/prelude.rs    |   1 +
 3 files changed, 229 insertions(+)

diff --git a/rust/kernel/impl_flags.rs b/rust/kernel/impl_flags.rs
new file mode 100644
index 0000000000000000000000000000000000000000..15c8fc82e76254f927b7487379d8f0a2776a4010
--- /dev/null
+++ b/rust/kernel/impl_flags.rs
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/// Declares a impl_flags type with its corresponding flag type.
+///
+/// This macro generates:
+/// - Implementations of common bitmap op. ([`::core::ops::BitOr`], [`::core::ops::BitAnd`], etc.).
+/// - Utility methods such as `.contains()` to check flags.
+///
+/// # Examples
+///
+/// Defining and using impl_flags:
+///
+/// ```
+/// use kernel::impl_flags;
+///
+/// impl_flags!(
+///     /// Represents multiple permissions.
+///     #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
+///     pub struct Permissions(u32);
+///     /// Represents a single permission.
+///     #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+///     pub enum Permission {
+///         Read    = 1 << 0,
+///         Write   = 1 << 1,
+///         Execute = 1 << 2,
+///     }
+/// );
+///
+/// // Combine multiple permissions using operation OR (`|`).
+/// let read_write: Permissions = Permission::Read | Permission::Write;
+///
+/// assert!(read_write.contains(Permission::Read));
+/// assert!(read_write.contains(Permission::Write));
+/// assert!(!read_write.contains(Permission::Execute));
+///
+/// // Removing a permission with operation AND (`&`).
+/// let read_only: Permissions = read_write & Permission::Read;
+/// assert!(read_only.contains(Permission::Read));
+/// assert!(!read_only.contains(Permission::Write));
+///
+/// // Toggling permissions with XOR (`^`).
+/// let toggled: Permissions = read_only ^ Permission::Read;
+/// assert!(!toggled.contains(Permission::Read));
+///
+/// // Inverting permissions with negation (`!`).
+/// let negated = !read_only;
+/// assert!(negated.contains(Permission::Write));
+/// ```
+#[macro_export]
+macro_rules! impl_flags {
+    (
+        $(#[$outer_flags:meta])*
+        $vis_flags:vis struct $flags:ident($ty:ty);
+
+        $(#[$outer_flag:meta])*
+        $vis_flag:vis enum $flag:ident {
+            $(
+                $(#[$inner_flag:meta])*
+                $name:ident = $value:expr
+            ),+ $( , )?
+        }
+    ) => {
+        $(#[$outer_flags])*
+        #[repr(transparent)]
+        $vis_flags struct $flags($ty);
+
+        $(#[$outer_flag])*
+        #[repr($ty)]
+        $vis_flag enum $flag {
+            $(
+                $(#[$inner_flag])*
+                $name = $value
+            ),+
+        }
+
+        impl ::core::convert::From<$flag> for $flags {
+            #[inline]
+            fn from(value: $flag) -> Self {
+                Self(value as $ty)
+            }
+        }
+
+        impl ::core::convert::From<$flags> for $ty {
+            #[inline]
+            fn from(value: $flags) -> Self {
+                value.0
+            }
+        }
+
+        impl ::core::ops::BitOr for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
+            }
+        }
+
+        impl ::core::ops::BitOrAssign for $flags {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: Self) {
+                *self = *self | rhs;
+            }
+        }
+
+        impl ::core::ops::BitAnd for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitand(self, rhs: Self) -> Self::Output {
+                Self(self.0 & rhs.0)
+            }
+        }
+
+        impl ::core::ops::BitAndAssign for $flags {
+            #[inline]
+            fn bitand_assign(&mut self, rhs: Self) {
+                *self = *self & rhs;
+            }
+        }
+
+        impl ::core::ops::BitOr<$flag> for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitor(self, rhs: $flag) -> Self::Output {
+                self | Self::from(rhs)
+            }
+        }
+
+        impl ::core::ops::BitOrAssign<$flag> for $flags {
+            #[inline]
+            fn bitor_assign(&mut self, rhs: $flag) {
+                *self = *self | rhs;
+            }
+        }
+
+        impl ::core::ops::BitAnd<$flag> for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitand(self, rhs: $flag) -> Self::Output {
+                self & Self::from(rhs)
+            }
+        }
+
+        impl ::core::ops::BitAndAssign<$flag> for $flags {
+            #[inline]
+            fn bitand_assign(&mut self, rhs: $flag) {
+                *self = *self & rhs;
+            }
+        }
+
+        impl ::core::ops::BitXor for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitxor(self, rhs: Self) -> Self::Output {
+                Self(self.0 ^ rhs.0)
+            }
+        }
+
+        impl ::core::ops::BitXorAssign for $flags {
+            #[inline]
+            fn bitxor_assign(&mut self, rhs: Self) {
+                *self = *self ^ rhs;
+            }
+        }
+
+        impl ::core::ops::Not for $flags {
+            type Output = Self;
+            #[inline]
+            fn not(self) -> Self::Output {
+                Self(!self.0)
+            }
+        }
+
+        impl ::core::ops::BitOr for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitor(self, rhs: Self) -> Self::Output {
+                $flags(self as $ty | rhs as $ty)
+            }
+        }
+
+        impl ::core::ops::BitAnd for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitand(self, rhs: Self) -> Self::Output {
+                $flags(self as $ty & rhs as $ty)
+            }
+        }
+
+        impl ::core::ops::BitXor for $flag {
+            type Output = $flags;
+            #[inline]
+            fn bitxor(self, rhs: Self) -> Self::Output {
+                $flags(self as $ty ^ rhs as $ty)
+            }
+        }
+
+        impl ::core::ops::Not for $flag {
+            type Output = $flags;
+            #[inline]
+            fn not(self) -> Self::Output {
+                $flags(!(self as $ty))
+            }
+        }
+
+        impl ::core::ops::BitXor<$flag> for $flags {
+            type Output = Self;
+            #[inline]
+            fn bitxor(self, rhs: $flag) -> Self::Output {
+                self ^ Self::from(rhs)
+            }
+        }
+
+        impl $flags {
+            /// Returns an empty instance of `type` where no flags are set.
+            #[inline]
+            pub const fn empty() -> Self {
+                Self(0)
+            }
+
+            /// Checks if a specific flag is set.
+            #[inline]
+            pub fn contains(self, flag: $flag) -> bool {
+                (self.0 & flag as $ty) == flag as $ty
+            }
+        }
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 28007be98fbad0e875d7e5345e164e2af2c5da32..a315607629c321db377343ca678c9845ae69bb14 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -67,6 +67,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+pub mod impl_flags;
 pub mod init;
 pub mod io;
 pub mod ioctl;
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index baa774a351ceeb995a2a647f78a27b408d9f3834..085f23502544c80c2202eacd18ba190186a74f30 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -27,6 +27,7 @@
 #[doc(no_inline)]
 pub use super::dbg;
 pub use super::fmt;
+pub use super::impl_flags;
 pub use super::{dev_alert, dev_crit, dev_dbg, dev_emerg, dev_err, dev_info, dev_notice, dev_warn};
 pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
 

---
base-commit: edc5e6e019c99b529b3d1f2801d5cce9924ae79b
change-id: 20250304-feat-add-bitmask-macro-6424b1c317e2

Best regards,
-- 
Filipe Xavier <felipeaggger@gmail.com>


