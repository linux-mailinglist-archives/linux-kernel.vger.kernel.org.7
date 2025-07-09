Return-Path: <linux-kernel+bounces-724601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E09AFF4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BE21C8440B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A125484A;
	Wed,  9 Jul 2025 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuABHA1h"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F0E156237;
	Wed,  9 Jul 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100484; cv=none; b=iqobT9mAmr5/u6+ifRjvWRA/+7AUqseiOpa42s9zjk90AK3S7oiDrM4xDIYpEJnz1V5llM/MX2OB9QplLfR7AOea7A//EuZmrGcF0o7a+m1oXHDOE7bG25TdHopyHPVRM2j1jQNV5lO6+QFhUz/Et7cO1nCRv3Hb1GBVblBn6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100484; c=relaxed/simple;
	bh=CLTu8BXlPBActcHgBi7NMR/ZJnqvRtAOzOb+cfc/to4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Oh/DT78iIovCFa2iJ5RxeUWtwrDcTjlGKrOqv/o8qhEROPIl+KoGbqG3VsM417EJguRDQgqIaAQ+g2U5seASSa6zplG8vxr7AhsIVsgHnPOVsdrNPayEgAP8HSPM8HsQotfUb/kKUdvHbBLHE9DHbX5vdg2CHPv/SzEHrLKwPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuABHA1h; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7d094ef02e5so181974085a.1;
        Wed, 09 Jul 2025 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752100482; x=1752705282; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxMpaLnvpar1TOoyObF1yy5rb3DAuYrSwv8+89Yn05s=;
        b=TuABHA1hs9NxxwuzeRytLibGV4i79zb9ArZIYHleEhFj7i/surfLQiDAmMF8hN+wyG
         XucPBsYbru29F+JHNbAgnbdcMej/tewCqjoLuym30r9xUQOJt/ITDD6fytbJvoz9NKGr
         /d90iYSCflEHFMM6TpQYgud13igolwodhNFyfgQ11NfDw1u8SRl78DFaLLuh7pCj6RlX
         Q3QiRS88mE0FZWT4hO48rbihm4zJhoAApI2/ijgmyg6/YSFnVxIvVHSPEpxChq1wfa7N
         5+pMAHmd7+jgwjZf2Xb2wyF6Qd/zVe4AZko0ii5sSeEyZ/VTPaB2Ap+vGSiWg+AAi6b6
         RdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752100482; x=1752705282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxMpaLnvpar1TOoyObF1yy5rb3DAuYrSwv8+89Yn05s=;
        b=pXA1Yar9LKZNxQnieduGDaXb+Z+iPwhbrNkixBzl+yE11vzEzfoh54bqp0WMWIwLKO
         p77P3wu8KTB0GS/xZHFiU++ZgO+LuRWV+OMiy5SEsjSIYEhg/JqDuTC9YJOQqS133NJ8
         ieCfvz1cnNPF2BVwI+urAHx2r+k0zhIvp1X/4S/vqG7CkrX0shWNbQ/N8ZUJi4RR/nbh
         4bWNt7JGituSTUuNL/zXEpTCRMXtP6wx9ENK1VTSfFvVlSPkxZQBnGt+0OlkMXCsQeSk
         GYL1tA7yz73EVs7fVqYBeJpkeKArZDU6aavOzQB+v+2ojyllnnylC3V1fAfY98m0/Cwt
         2gsw==
X-Forwarded-Encrypted: i=1; AJvYcCX9icbjK9i960ty9eSOujUqWhCZS3W3UvYsoNfS44/3PsVGi3nA0v4pT3zOLVtkj3mRmzSzpnnDbEQms5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqiPCnOanKecruSYv2q1VFjsUp+o5ntDWnFI6NqrxpRbyUDhm
	ljSz4+wB2kI0S0frGdPnp1ItxcHi1sqhzmwPqbD9BkqE9hBRqYXMo64c2EgyAT4n0POrQQ==
X-Gm-Gg: ASbGncs61nzPU5SUcbD7zP2FSGuC0f0QJsEcvQnjymAsOJ2/2yiR7Tzlr1QJ90LOjU4
	QNV1j9BX+xaPuMnHuJIuCsq4yY+ArMQsc8gx1B/bwkRlbgMQDeop0hfgQ5ur3Q1UQYP8gdMHvo6
	bPJlDcp8jWL7Wsi4htFERPr/OEWMSHbLpTaYXhxnlcvgdY8QSxXr20VfpQ/c9UB2Z01EvBFf8is
	PIq8cglSnQF05ZtFGNDk8toTk1Tl6O44FNbXbDK+vAHLFNmwg9BQg8363jKrHhkU8IHYCWF+IlP
	07+1hORs2/ptlxAZxOEFdaM+V8pp9myZyuPrX7dOpd0B83Z2GqcOD8AuXvLOLYtNn4V3rc496Tt
	CM8k=
X-Google-Smtp-Source: AGHT+IFcb2vNf7yZgHMKGGNNF4J6NldMFWB8MAdiPL7GzLxU+rWdX4QchWtF7JPYiQIxjdXntVro4w==
X-Received: by 2002:a05:620a:880d:b0:7c0:af6d:a52a with SMTP id af79cd13be357-7dc9aa3b9b8mr172468585a.26.1752100481427;
        Wed, 09 Jul 2025 15:34:41 -0700 (PDT)
Received: from [192.168.1.156] ([2600:4041:5c29:e400:5085:1d69:8814:72d4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde9f18cfsm12493585a.100.2025.07.09.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:34:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 18:34:33 -0400
Subject: [PATCH] rust: init: remove old workaround
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-init-remove-old-workaround-v1-1-a922d32338d2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHjubmgC/x3MwQqCQBAG4FeROTcwLqTYq0SHxf2tId2J2bJAf
 HeXjt/l26jAFYUuzUaOVYtarmhPDY2PmO9gTdUUJJyll4E165sdi61gmxN/zZ/R7ZMTxw5j1w8
 B0grV4OWY9PfPr7d9PwDS3drJbAAAAA==
X-Change-ID: 20250709-init-remove-old-workaround-a6ec6792e010
To: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752100480; l=1199;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=CLTu8BXlPBActcHgBi7NMR/ZJnqvRtAOzOb+cfc/to4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJJlcp0la5ilnuXn8m/U8lxvOx5rJuSksymhikJiK0IueKlNmtSPM1N3h9j0gQxsYi3as1l4mSm
 W9QX6nCNdoQs=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

`Error::from_errno` is `pub` since commit 5ed147473458 ("rust: error:
make conversion functions public"), thus remove this workaround which is
no longer needed.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/init.rs | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 8d228c237954..be3a25932342 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -77,13 +77,6 @@
 //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
 //! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0 }
 //! # }
-//! # // `Error::from_errno` is `pub(crate)` in the `kernel` crate, thus provide a workaround.
-//! # trait FromErrno {
-//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
-//! #         // Dummy error that can be constructed outside the `kernel` crate.
-//! #         Error::from(core::fmt::Error)
-//! #     }
-//! # }
 //! # impl FromErrno for Error {}
 //! /// # Invariants
 //! ///

---
base-commit: 2009a2d5696944d85c34d75e691a6f3884e787c0
change-id: 20250709-init-remove-old-workaround-a6ec6792e010

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>


