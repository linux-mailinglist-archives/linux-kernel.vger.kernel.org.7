Return-Path: <linux-kernel+bounces-879746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCFC23E68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A25234C0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFEB3112D2;
	Fri, 31 Oct 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V22Zltzk"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2F30103F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900508; cv=none; b=b4ZSpeCM5Xul7hCHITNCbvQKyMt4Kfq8XakkefTYTOx/A/Jg0jE+ENRSWrwEaoQas7MG1499WQOwsAiP3GlXsiToMMxdiKS4RdJ1KUsTIJCPD8TI5XmgSmtDOEloz/WlbpKIM2x/fkwJRYh9aWvDMyUYmYTauCvCPNbzsha8QlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900508; c=relaxed/simple;
	bh=ndaQyFE2B0OkWxvkKgAAJ4xPsNlMkCgWYWVxZwI0yZo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gbR/ywHIrGOxBDpcSwPLYTtf9attixjsQiQxd923tLYzQlOI5e3+hxDLUg7QxcApD8wacEFGxZ0t0SXbdpzS3EuZKgdxiSiMU5h/tRlSQ14bQ3PKkpHANao1ExlvvqxTzH1fQj4sroe7Y3uI9bPwu+tPjikpEwY6g6vHPhmvLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V22Zltzk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4771e696e76so23573515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761900505; x=1762505305; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+372a3WmkEY6tgddzTdcmzcWDwIw39UAqHi/ZzXAids=;
        b=V22ZltzkJhZU96gx8GDUa/ee8vz7Ud3eDrsY/p9ap0GhiiYnynGyLCP8mU7ZyfhzL3
         sS3RI+suyc/eAkwHunGtkOGdrAF+1uBupDDzo5U66C5BacGNvXN4aYe4gke5lIXZZpSI
         Kfr1Pbjt/OXoA2DTHjQhhQ6+aQoauchzg6Z01rjUREEkaf9qvTpvYzQlbOEMrYnEvBBu
         y3LJwSkfx0fPE27bAyYNqAr+P5sG/2l/lbZxb9jTp3ykxHjiBkCwi8y4SNIo+Y/qy9Dx
         14o5WgjQH0ZqzsReIJf++Lt27BKvuw53x89ej025/hnRknSaG6aED829R26RzSuVkdEc
         7dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900505; x=1762505305;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+372a3WmkEY6tgddzTdcmzcWDwIw39UAqHi/ZzXAids=;
        b=fOBxvSJhQsKQmL2UfTgF788NzNeOgFHVQVRCUSo8O8ycok1L8NqQm89OWlk5H0LZf0
         6a4wrVNt4B1aqG/1iFcFBg4hYqD/qJn4OLVzp7Q/h1I1mUWpvQEhBIXieNNarkqmzVUZ
         /j7sV6gIc2j2/lirwgpibcLXLPtDoOUiIf8xGsrxWUcMtXrPFDMVJzUd+bV0I5xYOcqt
         Zn1nhDJSK+S1fHqXz2bM663hCBhb2fuEipL5nBiSrfIzoJdiVz1Rcw9APQQki28YqgR2
         DO+U3R7PthepP0KS4GLy7VfkihzrsSxHYMRdUVVZfYu6xRgE3iIXyH6flvg2jDQJeaY3
         mC/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmCrotng6jKKqRO2L7MttNsPxxC+Z3MVB7oae341CRpMFUc+giMrDZ9nsOPsXdbeISCwXLA/lHk8ak2gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJD365aDUxuEgUzdRwp/n60k3tP5y5navgx1mxb8uvVV7iaDas
	NgDtElUS/uK5rJYv1tfyPHQPp1dGL1hXH87tr5v6SeeiPEfrpvrEHTu2ZSEtS/u32xk3GUQd3e2
	27Q6zMmZ1QCMkLINozA==
X-Google-Smtp-Source: AGHT+IGvOjm/actgy4mwcV9ArK/QT0WmXxyzpClAjkGwq0Za23DkXs2ThfcsWWR9g0eRkoQXn3I8U4T8EM5UEP4=
X-Received: from wmwr21.prod.google.com ([2002:a05:600d:8395:b0:477:100b:1033])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b85:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-477308908c6mr22520415e9.29.1761900504836;
 Fri, 31 Oct 2025 01:48:24 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:48:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANF3BGkC/4WNQQ6CMBBFr0JmbU2niAgr72FYQBnLJEibtmk0p
 He3cgGX7+f/93cI5JkC9NUOnhIHtlsBdapAL+NmSPBcGJRUDcpaiom3mbzQ9uXG6KJnq+MqSOu
 OFNZI8wRl6zw9+X14H0PhhUO0/nPcJPyl/4wJBYrr5dY2EqVqO7oba81K59KDIef8BZ7qN167A AAA
X-Change-Id: 20251030-binder-compatptrioctl-ecc9e2131edb
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ndaQyFE2B0OkWxvkKgAAJ4xPsNlMkCgWYWVxZwI0yZo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpBHfTK1F9zcJOa7JIQrwi/jR5F385Pw9WGB7vx
 dAXypSuNnuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQR30wAKCRAEWL7uWMY5
 RpsFD/9he1mRoOSXLajq2KGFMDa017We0/SV71zZUHe9jVY6x7c7220iurehk6UP4GlyP8mqJ9k
 Olg7XjDG+c0gMPUg9WrQxG4VVug8GSqR2TepqGCQA0hznIfcpIigIpOh0nfqA7stylD8YHJtkGq
 nqAvPy1QzteYQX17fsrg+38Z6DuQXTL0E73W05JDqlGS0zaNLaqdXps4nCsXI/AvO3p+N6yasDo
 DOLSx1k5A3it0B4AXYGobdqSoWgnSL1PucpAsDCHRoV0klwm8nO029I8jtHP5Prvos8XHVve/hy
 7+eqS2Cv6f2tpExBKw5kQLxPDRMCt1gpHRYOAmXEo9OroEZehTnfTvd5Hbl+knpt+fboERZ3ihN
 sDVm7javb8FsdPaqewf1G0lxu1Pv1xOWD8JZvZFlsKx59J9w66actulD3CdT7aZdMc4n+SU91e+
 BZ39Qtx0tnwsIjSO1NGH/FugEk8u1rwByE43FeGwUxxinuJPnyoNV4eWhRgbqv1B0mhnlqhpU7c
 EfktoY9bgfBteJK8QMpBgnjec2a4WuIEEoMdejOBgqAyeAxCB/Yu5dsd9ydr4BaTXvo8ePMUM3i
 PJRGUE6GlrdiqxtnzWM1o8rJzRj8zPm5k9uGJWRz5oYAaKfG2W6vGf3Dab0eTiUhXrbc0HRob4y NYUPBrSkcKnhVrg==
X-Mailer: b4 0.14.2
Message-ID: <20251031-binder-compatptrioctl-v2-1-3d05b5cc058e@google.com>
Subject: [PATCH v2] rust_binder: use compat_ptr_ioctl
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Binder always treats the ioctl argument as a pointer. In this scenario,
the idiomatic way to implement compat_ioctl is to use compat_ptr_ioctl.
Thus update Rust Binder to do that.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Reword commit message.
- Link to v1: https://lore.kernel.org/r/20251030-binder-compatptrioctl-v1-1-64875010279e@google.com
---
 drivers/android/binder/process.rs          |  9 ---------
 drivers/android/binder/rust_binder_main.rs | 22 +++-------------------
 2 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..7df144d07b20d238a127299cd208f6280ba1bb7a 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1599,15 +1599,6 @@ pub(crate) fn ioctl(this: ArcBorrow<'_, Process>, file: &File, cmd: u32, arg: us
         }
     }
 
-    pub(crate) fn compat_ioctl(
-        this: ArcBorrow<'_, Process>,
-        file: &File,
-        cmd: u32,
-        arg: usize,
-    ) -> Result {
-        Self::ioctl(this, file, cmd, arg)
-    }
-
     pub(crate) fn mmap(
         this: ArcBorrow<'_, Process>,
         _file: &File,
diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 6773b7c273ec9634057300954d67b51ca9b54f6f..c79a9e7422401fd50078c1902774573b8ba0076c 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -313,8 +313,8 @@ unsafe impl<T> Sync for AssertSync<T> {}
     let ops = kernel::bindings::file_operations {
         owner: THIS_MODULE.as_ptr(),
         poll: Some(rust_binder_poll),
-        unlocked_ioctl: Some(rust_binder_unlocked_ioctl),
-        compat_ioctl: Some(rust_binder_compat_ioctl),
+        unlocked_ioctl: Some(rust_binder_ioctl),
+        compat_ioctl: Some(bindings::compat_ptr_ioctl),
         mmap: Some(rust_binder_mmap),
         open: Some(rust_binder_open),
         release: Some(rust_binder_release),
@@ -402,23 +402,7 @@ unsafe impl<T> Sync for AssertSync<T> {}
 
 /// # Safety
 /// Only called by binderfs.
-unsafe extern "C" fn rust_binder_compat_ioctl(
-    file: *mut bindings::file,
-    cmd: kernel::ffi::c_uint,
-    arg: kernel::ffi::c_ulong,
-) -> kernel::ffi::c_long {
-    // SAFETY: We previously set `private_data` in `rust_binder_open`.
-    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
-    // SAFETY: The caller ensures that the file is valid.
-    match Process::compat_ioctl(f, unsafe { File::from_raw_file(file) }, cmd as _, arg as _) {
-        Ok(()) => 0,
-        Err(err) => err.to_errno() as isize,
-    }
-}
-
-/// # Safety
-/// Only called by binderfs.
-unsafe extern "C" fn rust_binder_unlocked_ioctl(
+unsafe extern "C" fn rust_binder_ioctl(
     file: *mut bindings::file,
     cmd: kernel::ffi::c_uint,
     arg: kernel::ffi::c_ulong,

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251030-binder-compatptrioctl-ecc9e2131edb

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


