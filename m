Return-Path: <linux-kernel+bounces-878029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C9C1F9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A12188046B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9356C34D936;
	Thu, 30 Oct 2025 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lkG0Vr74"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A733F385
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820873; cv=none; b=Xdox49/GOz7eEEWBNOtJeKrUEX9o46EIYVo+9Fu5DUIdO5Y0zSAyep9LHzaqbxMl//a4aWvxLf03pNFYtccwRTxpnyQL0E70N0v+rEAYp5mExTqnsMeBpa16F5FkeOYKNSsKav6ci4+Lr2oQINbTh7lqvW/IuUJol+wduACxMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820873; c=relaxed/simple;
	bh=qB4+AN+XtWF1ZQlX4n330LR8dLEGK6tp50f5P7FmmOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZDY2tea6sIEq6Jp88EUVzVPKhTlPFMDHmvys7v8YhmvhbOVB1IYUgWElNOlWnNJV3v3ITTHjqBoOZLDEY3HEeuRRDtrcNwkpQ4pnegcqPQEwNSZhZVDn7e7MdQMD2pZM9rllOVtkXLjhBmkOpcXFf1O9QPZY8rvNICowHgR4cRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lkG0Vr74; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-63c10d86ef2so830394a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761820870; x=1762425670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=moMZ7EUS7x50M5ZOXZBq3dx7C8epDy4gJjTPsdjnRvw=;
        b=lkG0Vr74LbPKJs67TCTXffqPScDlBa8pNOkiTgY54F2I9BVYoFGtFKWXGsVYs+IkBv
         B3anykp4MLXL0aBHQBjq37ObZQcFftMbebTP+cF8VscvOBzBn+eGaI3BDa5Yg9FHt2f0
         aEFnDor8Vc92RBveJlEf6DatdiEFhhMIrfHMIuJTXhBxCR5jp4V58vffYOU1PUDmkTUE
         DLe9SvADW8AX/ahIsa7Aqad/PeHxGxQkok+crgVouvwmQbfDVpb4/lej8rny/7qDqDtt
         4m/JK7fj5QH2DGE4ruARzooruFLwuF15XJ1nSq0HLzXWWwAk7bBB1Xf89kLk/M54XHBv
         G5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820870; x=1762425670;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moMZ7EUS7x50M5ZOXZBq3dx7C8epDy4gJjTPsdjnRvw=;
        b=fvnQa1wF4IeNNLGukwvB9oNtWzOSBFNSyKXRvmWaI74FuTdLiJ0A9uplg5GVqxqAjU
         xyqS+++Cgmjr9DLMwbd94cveb+JiwimA+9qp4+U7GDTTqZjO29QxOtcvZlAXit1Cqt6+
         9KlLof+NmQELStIBqnOVVPevKbHBaRcU4rk9IlC/dY9EeD4G1fKEAqsDNOypLuFcdte6
         CWNlZIGxAuB5YytOWK04UiHD3Uoq8maT0L9d7ZOL/FOCkBgrBKUrItSFKk399HgQ4hUN
         uSn0Tou1hqBYzWYCrpB/KPIe3Z0GOjOgJ4qpvivFEQxIDYHCLKdujCUJlVmyH2oJQVHE
         as/w==
X-Forwarded-Encrypted: i=1; AJvYcCVD6dpsg8NXcwqw2hJXLWGQByx4kcm1HTV5r7SCpbSMSzlRhYpFTHo41+NaTe/GoUNQGKGKuaXpzXIQyUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2MtsP3TOu+M0UKrU2icQMZyRmVm7r5YQ/oF1JRFN2u3mHIdj7
	nfQehd/mTVDOVzTe3fGWKNr0dN84srjhS0LvZci4s3iPitWaBkE67MkI02sHvA3zMHtzEKGjpYM
	ciY70opJyj2pr5aLabA==
X-Google-Smtp-Source: AGHT+IEWoYbwyLCri6MdfQcuPF9lnLunNX959SrwJVa92mvpCBGO5XoUBG1tP6cOYcaj85SnHI3H+MiMQpTdE7A=
X-Received: from edz6.prod.google.com ([2002:a05:6402:1f46:b0:634:c016:745a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3045:10b0:633:7017:fcc1 with SMTP id 4fb4d7f45d1cf-640619fce8cmr1783593a12.14.1761820870615;
 Thu, 30 Oct 2025 03:41:10 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:41:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL9AA2kC/x3MywqDMBBG4VeRWTeQCy7aVxEXOvnVgTYJk1AE8
 d0buvwW51xUoYJKr+EixVeq5NThHgPxsaQdRmI3eetHZ4M1q6QINZw/ZWmlqWRubwPmJ7wLDnG l3hbFJuf/O833/QMLUvFvZwAAAA==
X-Change-Id: 20251030-binder-compatptrioctl-ecc9e2131edb
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qB4+AN+XtWF1ZQlX4n330LR8dLEGK6tp50f5P7FmmOo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpA0DAGdHfRYFrmlKBFauUCROo0RBKEkS0KgrZk
 Ba+slMpMPeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQNAwAAKCRAEWL7uWMY5
 Rh/tD/9kFcN9q5MWaJ8m+z/nA3Ho33n2cvKVN60F0+yqCMOomjfh4pMMam4+kPz28dU1oqM2e7r
 /Wel7E+EOjGdKUlFfhRu0VuWhyInE70nQdJ9NVNbUhJfImaBFnZQ6BbIXKwTj71VI0p50jIuEUI
 0YLGStCSUmnCpEK9RpxA79GDpkdIBWW5afWkHcLuqDF0vf10W6+5stqc52fjz9GbZhTakGSUgol
 OyFTpd6zTs1xmZYdxSruWacd9p4GFEhMzqOfSrQiFR4YsV12GT1mmAyQ0D+Qalz0zMtm4sv+QAO
 Z+kkywu5WNOzDWRNpwB1BMXuV7VUA/63/FyMPZbpMXETlEpbj9TM+CT2iSaE9H6AKXPFugp6J4t
 6IJHnkI1/rm37n5pdhQnwbwNvP+peLTbqTuAnz2YXsWtXWkbhfNJgLaR2H54cekgMyQEo5vfm3F
 STbDRpTCeGyEJ5xDXm44sPyDsddwDJ1ywjJixTY2EIY+4zFHrc/C+a33Db07PUAu4pTAf5JJbiy
 Kp3d7Og24M3OBjm2yCpxEEqi8g5y+pk3hdeq5Y+vMk2vZA0HOJBrDf9pazME30tf9r8HhqtBPMl
 aA3x4USgoQiOOHYsALnN/svqjMh1FP8EBsIZs4WMGXzJ5Nfun47ABYjjmjBWhRvl/LZMZyqcI1o MkgD+SmIM/dTMyA==
X-Mailer: b4 0.14.2
Message-ID: <20251030-binder-compatptrioctl-v1-1-64875010279e@google.com>
Subject: [PATCH] rust_binder: use compat_ptr_ioctl
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is commit 1832f2d8ff69 ("compat_ioctl: move more drivers to
compat_ptr_ioctl") but for Rust Binder.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
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


