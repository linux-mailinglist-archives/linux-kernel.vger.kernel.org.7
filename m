Return-Path: <linux-kernel+bounces-778719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AD5B2E961
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EFC5E4545
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D101D618C;
	Thu, 21 Aug 2025 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL2oJY8z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB31D2F42;
	Thu, 21 Aug 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735723; cv=none; b=DriToIi8KfIYLnv+5ONZucSSuwZZIGfgAEtltoOHoNGOxgVCgsA9rcZxAIF8YxAORglPClTnSkSvf/8Mr171tvspJg5JINniG2NPI4FF5CuV7otmv2gFnBVOSlybZMYUbz6PVHc50Z5IP7VGXqmvy1gOsK3E4NHTdLd+2L/YMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735723; c=relaxed/simple;
	bh=NHCpoRdJvBjcdgXxpXWGTxmjk/NM2evM81BLpKgklJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3odYcV6l2Sm0pJu7p0svkfExoea0gT+vJKxtG0M62rZF2A1xCoWNORH9zTxRKcdowosRCOlRgzl26DPIcBoCeYuwvvpH+qkQFUSvyWGZOTYEshbrosKSHSdPK/Yuuya1WwLA1cphO6oIjPeM857WGudq35r48JxIKIPCCDpIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL2oJY8z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2430c5b1b32so10133305ad.1;
        Wed, 20 Aug 2025 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755735720; x=1756340520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLXJmSCb54AB518avytFHUwqrRiU1lSUWESDVVdxjdE=;
        b=JL2oJY8zcvh5nok3xT4DanJKEJq+jDmg1lmMyC2qpIs6O5dvQ4GQTy61xImF/5SpnR
         xnMJ7rYw/sgQmAfdRL+z7rxLYWVM6ld2Oi8rtUL9NabZEJtUQNmBQoZ+OUc5BosxQkRi
         OXrakmrg6WFXxo/YJxFqrMWG7EBHdWSsIuP6igdolyqRoUOHeEMwodEpXeHEc0w7T9gp
         zRCZnYfZUnrZOVNczLNZQ1rKPSqmnzHNa5/Dk/hB1BrZ+3GLE1ji72o8tyihP+xBVXm8
         4NP5ABT9tHOb859cfAkk4Hw3jR9gI25LY+gsyVhuWyylkOKzxuYWSvB3H6OTbucwU5ug
         XNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755735720; x=1756340520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLXJmSCb54AB518avytFHUwqrRiU1lSUWESDVVdxjdE=;
        b=GkstKOS7SR9C+Ajxw8Yqn6K9XwQw37h6sZ1GFqoS7mp25McRtiTzdXVUS4LZ6WgzHN
         BcROELGNvmNAGAMgpZoVUZI/GcfzMTEaKY4xfAonQJ6sjaedjeAQMkAwki0pk6X8dM1H
         xE2UUmG7wRH/upfVTpfxnNW5KZsKNquGFj63tcmy7++t/OQ97s17+hw2PndZ6bw7+fbu
         xoU6HP+oNit/DpONBURdxNea1SETcVp8VBGh4SUN1XsF5iYgJib7xV+0KSPbRrPlCilm
         zWC3f7/Hiq7TdowJM1MZTH8Cmik/nCjXn37fRaGPgmlc7EvLL+2gfm/N8Mkc5s75V3yR
         7b2A==
X-Forwarded-Encrypted: i=1; AJvYcCUp+38DL/WSFMbfSq7nHjzGcP76Uep96C724cFFG2jht3sh8U/Az+RU7AacA029/KhiBt/1W/Ye4dcgLY+At2s=@vger.kernel.org, AJvYcCWNGZTkg+kR0Htyy9tu82K/CkyeGUCA+xGd+/yJb8iXV/41gxSXqjZaAPXwmDcvX5En5Eg2mCffSxj4aok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ0GPpsLmiT195N2FdUt/uaE6OoJTk3wH3XjHiJP1f3C9sryQK
	p5tAPCPx4qiSSAKYHmVNzm08DJLOZoQre8/Yr4Xdsxl10k/tJOYhrA/o
X-Gm-Gg: ASbGncumbxz3EVyoVtBED/onmut7aQdVMW43ulcZOPYb1fRa7p4e3Pny/tfDm+UzPJm
	nZCMVUMLyibIE461b/BjymvWZ7HE4zC7DPIOuY5KlABYNPgEHLpB2pCusPkLZ2bmpKuL1fndT+B
	0YWgY1H5O/qS5SEkw8AEO2bN9glGaBgbl27xzSk2doTNLeE1pwlu+wGSMYp+vm6OYIH2tvm1j0v
	LgtSbNW04hFR4BVG3fvMclcGaQKuIzAYS5lr1QRj5nQc/j29nIZRQGfqBQGywKLVWPY9T63lOiZ
	Z69G6ZPxYw+Kp8Vmr/6ZYtkjO6CdcCFlPl85z/SANDto/sexUYWMex7yjhcyWAWllxx5We8OTYt
	FmZ24QoT307aj00CKuSepbLkMd1AJT2Q+VRvkn5WqegUZ/W4H+HuN5makPCHOUJXnxIRe+4pgXO
	8BC14M3A==
X-Google-Smtp-Source: AGHT+IFDavR3BVc+dzmXzWQ5OsRVgQc75V+wJlTYod6HcPUdrL5h0Jovgil8kwH+BvrPV7MELNBpSw==
X-Received: by 2002:a17:902:e751:b0:245:fcc6:a99f with SMTP id d9443c01a7336-246023cf093mr6995975ad.11.1755735720170;
        Wed, 20 Aug 2025 17:22:00 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm37464065ad.128.2025.08.20.17.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:21:59 -0700 (PDT)
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
Subject: [PATCH v3 1/2] rust: Add cpu_relax() helper
Date: Thu, 21 Aug 2025 09:20:54 +0900
Message-ID: <20250821002055.3654160-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
References: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
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


