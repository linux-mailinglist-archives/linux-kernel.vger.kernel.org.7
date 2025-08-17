Return-Path: <linux-kernel+bounces-772343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5AB29193
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFAF2A32A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E220FA9C;
	Sun, 17 Aug 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY3I7nz5"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8D2066DE;
	Sun, 17 Aug 2025 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755406115; cv=none; b=EEVBYBxGVU3db8wlKvzYXCq5OTe9g8cSlZpj7kb8TCcdXIIl19r1Vdy3T2IllljeSQLuCjhAWIuYv4I5LXc4q/HxODAxSEqv5pM0Q9aPFtfP6/o6N41Wj+3trEEWf3msdsAL/5i1pMX7lih0vuORoogap7E0xufkmjj7n048t88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755406115; c=relaxed/simple;
	bh=zR5XKh7w5gkBdupYDlaIX7+lVBe6u+YpHl1FbIn7Jlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1fC3//9L8HQjLmXBQ40HOynkltKU4ddPLpdYvujjIVf0JI9y+gK7k4c0DgjxZwJliUEsn4T02/j7E3EIoN6OEaDef8sEvPcRkhhILgZgWptHzoFFkev9X0eziqmlODYCGKn63hW4KPsJjXr1bKYetUH8IJqUArQAlF1ArF8XGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY3I7nz5; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174beccfso2708996a12.2;
        Sat, 16 Aug 2025 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755406113; x=1756010913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZeul7DWVgd1xgnUZden0askSft4WTjZ/RPAZ88zu+Q=;
        b=QY3I7nz5GG73VOxHAu4t6IHTk8csDfmxqlZ461hKsAlca9SHLGD67qUc/BmLzeGCyF
         fXxK4Bf4ktMBlSAQA3lObqUPE9En3StmHWeqIQveX8EgAWaepqlB/e6+QeOvMzqz1m3K
         pFd8xPRq7FDjsiTTOa6bDtbtAZtzn+7a3Tnlo/1pielIN2xw2v99ghk4GFV/TJiwATPJ
         kV4dy/GqMUHQ2f4LiPubHENqb5NSmjOb+toQMPV/es7whQwS/3b4g2mh78tU2WFqbw1P
         395QUW0Gu5jSNoFHo+aOVDHuiCV4P7kvJAo7z9ZUhIbGHnKtAD1X2oYG2WIyA4s9aZZp
         /G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755406113; x=1756010913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZeul7DWVgd1xgnUZden0askSft4WTjZ/RPAZ88zu+Q=;
        b=h7rRLUb7IBM/1939j3lu6LvBbBRsbr5mJh1RucFrrdDR2l89pFPr5/LW+nLcz79EZz
         6axCx9V0TRFMc54U3m7xHf9apH6SuieX+bOx9fdhNH77tALIyg5vpSsu4cczoP7ZmWE5
         Qyk7WvoOkQ3ryFzmsnsr8plw3Ar1Y/BcFXvqUEBPK0cI+XIHnSpmLIDcqLBeu2qcrrVR
         QfF10V5G+q9dMa7PtbtP9G11B42TT167MBTa3iVkMmQDunEfPJ9ovZJaL6LjoncAlPXA
         zVQX872E+Af7ulwmOnGcHDBYNqYJET1+Uf6ovz+7EZBWtSvEtd8IK2sRGz9FqcxaFYWw
         kung==
X-Forwarded-Encrypted: i=1; AJvYcCVa3ChMW/1rD2O6W4n4xJFbQgT4Xa86ZPlJHBtQTtCUBrGtNp6eRXg6lbHif+Pj/ZoSEbdfiq447R275q1Qqjc=@vger.kernel.org, AJvYcCWmcEKeuCPnncgCnQAaL+xejYM3FeizGpN4R4BirTXS5LvfySJj/Rd0pndYD7IcXrx5mYh8EEiBJgHiL6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWdF7Aoq0Nq1MutZ2Jbqif/F0pAxXUFYfKNJruRCLFvUDaYTb
	ZCETwzmXJ9thaSZ2bW9Yp2aYY4jHNlai8QPBV0tBxlSIQMC5tOJapPpd
X-Gm-Gg: ASbGncvEXfaES0Jo2/gS3UopGCUwEkRsJD7DI9oMi56ByaUc35xUgD9fdMujm8LvHXc
	8bZOW9QCeb5m4+FD3kmsExLS/RZUC20zub2dY/6OkI14h1s8HFlWY3+lk863M+6SukD2ap3uffc
	PTbzrO9m7M4MJvQAVbe2ecVSb01rSYG/hdDqydcCnlDJVGhV6IqhKGMVyx0hHwquiZLUO0NFvyh
	KXqcIB32OkMV71vd22NURnFG6lObi8xqzRPu01CkH9JplP0oshPbH+0KAuHUc/Kq7ZBsr7t8w5s
	VG3aZfOKAWF8vkYxLdDSYHfOe7lBvOAThNNvlABMdc/IwzPpUG6U0HLDVMMzGEU2RK9TNC4tC3i
	N841TTjzdJonoG9nOe18zJH5wXIV1uscCWx50vUKCN/yCrDuO+Sk078zRdo+dWic7LUJ2aKk=
X-Google-Smtp-Source: AGHT+IFX9oAZ7mTeM4M0+jCJMK6pzIebt99KVD0HFS1uAkWC989yIHy5IR7AHDIkL/tVgrbmvsNWMg==
X-Received: by 2002:a17:903:3bc5:b0:242:1b:7f05 with SMTP id d9443c01a7336-2446d725139mr116745755ad.24.1755406113031;
        Sat, 16 Aug 2025 21:48:33 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3234368aeadsm4740645a91.0.2025.08.16.21.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 21:48:32 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Subject: [PATCH v2 1/2] rust: Add cpu_relax() helper
Date: Sun, 17 Aug 2025 13:47:22 +0900
Message-ID: <20250817044724.3528968-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cpu_relax() helper in preparation for supporting
read_poll_timeout().

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/processor.c |  8 ++++++++
 rust/kernel/lib.rs       |  1 +
 rust/kernel/processor.rs | 14 ++++++++++++++
 4 files changed, 24 insertions(+)
 create mode 100644 rust/helpers/processor.c
 create mode 100644 rust/kernel/processor.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 7cf7fe95e41d..04598665e7c8 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -34,6 +34,7 @@
 #include "pid_namespace.c"
 #include "platform.c"
 #include "poll.c"
+#include "processor.c"
 #include "property.c"
 #include "rbtree.c"
 #include "rcu.c"
diff --git a/rust/helpers/processor.c b/rust/helpers/processor.c
new file mode 100644
index 000000000000..d41355e14d6e
--- /dev/null
+++ b/rust/helpers/processor.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/processor.h>
+
+void rust_helper_cpu_relax(void)
+{
+	cpu_relax();
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ed53169e795c..c098c47c1817 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -110,6 +110,7 @@
 pub mod platform;
 pub mod prelude;
 pub mod print;
+pub mod processor;
 pub mod rbtree;
 pub mod regulator;
 pub mod revocable;
diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
new file mode 100644
index 000000000000..85b49b3614dd
--- /dev/null
+++ b/rust/kernel/processor.rs
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Processor related primitives.
+//!
+//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h)
+
+/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
+///
+/// It also happens to serve as a compiler barrier.
+#[inline]
+pub fn cpu_relax() {
+    // SAFETY: Always safe to call.
+    unsafe { bindings::cpu_relax() }
+}
-- 
2.43.0


