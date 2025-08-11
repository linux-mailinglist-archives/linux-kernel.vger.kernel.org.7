Return-Path: <linux-kernel+bounces-761774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE58B1FE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596221722E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205BF269D06;
	Mon, 11 Aug 2025 04:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnyZaf1D"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF3526529E;
	Mon, 11 Aug 2025 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754885514; cv=none; b=G3NeXNF7+JevUraS/LKnx5asO+W8EO88i+KwunR2zgHqaxxwOohigvK/YxCE/h7s/jdg3YoNrWHP/J+EaYgN54MKn0G80etnAQSeIf8kR0l1Q47RrlXycLUHIzzIga3KwSqrPjYBQ5IF53UFFa83VIE6H7gij/hm+QpMnJcMevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754885514; c=relaxed/simple;
	bh=vj6R7yEBEScaXFjg+uDQW3Hn6iHtgNwZH55tzH+I1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4wr0I0QP77vYpO283RvawA48FOtB93MsiaITseFNt+3iR6pMMrPCmRd7I46izn1DG2r0cN7l9wZlr/Tp+jm40W0SWENTiBOjPNW8pstXGxkMCCq0Pw9BWTdiiBtnZu/c5+Nb9bfG4YpQCgniCI4Svd8szRYAOoQw+ydRdxeNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnyZaf1D; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4545482a12.3;
        Sun, 10 Aug 2025 21:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754885512; x=1755490312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03NiMWFy1lDygEZYdIVumyD+uLWaGBh68QLZgvH0C60=;
        b=LnyZaf1Dy7bZI+Ixocm20Hk1971O4sz/eJJhXWr21Du3c+NOF3Y8Xt19SWSyMRoBll
         PImhK3xugUdXd7eQtCzQbTzb07s45AV+7CZgD7W1i0qfFnz3IFYWMQx8NV/7mLbCHIEp
         437K+2hNr7cGMc09IMhXJuE+2EsEC1TMk889CHYEnavHm96QBSbnGUM0rMtwafQx+UoL
         9B1t1Qz9GKH7FhvS1f9JATaAEtQJXWAKuJuyeNK7tGeufcRGHzbpTRJt7XwTrEV2HJsT
         AmFsHtbhpKPhtq8255aCTbKFmOvuPemsyO1aggyGMzGR76ZV6pViwJYK+JeQD6eaTpoT
         YAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754885512; x=1755490312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03NiMWFy1lDygEZYdIVumyD+uLWaGBh68QLZgvH0C60=;
        b=xMC4C8DP7+Qi5SXfXLO+dqpDgdB1C1Og394DCLnO2hVl5snlgQffVTmhOAkWfnSNJQ
         EVWEVvAalxSAm+koH9hAgPjLWaIDeLbB7ryoGO2FNNw1SJV/qySyZ70+FKeSZxnLgJPG
         E6uBfOgjeOHPWelyxXOQV75AR5ffPsJmezzstYvbRdItu/7FtnO+d53Y+ybxI7pmYWaC
         TbmhxDVr5FErv42xwhwi+DeHVkyiXxSmtYn86u7hk5TwMpjRqBeLsFj3dTFp7dIkwLgx
         YjlJ9bEa+L/MykLuCLVRNxQV4RLKgIJRRsjY6XSS6PfOHKmYHfbypS7JnAxHjZzqy0Yt
         jMZA==
X-Forwarded-Encrypted: i=1; AJvYcCWg2aA49UMTma+l1LdaqoUq11FcxvCij4OUGhzA1zqI+i6x2ndXtel5rkZ9SO71u35aFDZrQVj5UQ08PjA=@vger.kernel.org, AJvYcCXwB+TLlW0bN6NS1W8UTGRMF64RnPUbKrlMvIC0013x3kK6DtpWXYugnsO0edrtpjV9hr0s+5tmeeKWZ94FIWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcup+pVZKiumTf/xxeM3hOdcv33Wt5IEL4/RWFNYXxy0bvMlc
	wg9k/BvrQHqMof6S8940/oo0++57BPVZsMMRA1zJZ5eKX99IZkBUoyhw
X-Gm-Gg: ASbGncudahwvkWjUblv/EHEyZE4z+aay6qyeHEAWEjvlq4MjRA1CaYrM1U5Qv7MdYgO
	FSNmarCtxw70DYctxo/bY94YhPsfvJ7XPtOFMgRf8W/jEs2imr3Jv86KiEfQPLZCyt6OKQgM0qp
	+beq2t6ekZ0M2O3XRjfIjiTCuZt5PmQRH2sFB5pSD2tIL9+Wg7bSpdwKUPambyJgsYF0wHVILkx
	pXzbndwp5ClP6QfmjhtcUjOeI7WPuOFgUTq0BPOTdFjNEe9wHKNeCre4jdtUmrWDM0HOtGA1WYl
	33iVTJSRbir6bBL+RHhwTKgI3FhRoe7bl2ktkOFIftBcG+Gd7pkDNNadxWf4H+Myh0DrrgITFOK
	3KFLDPqcdbpJHqmPkd5IDjw61eg8zmSqFCVv4gj5Z7PAtOytJIUZY/FGzjm9i9qALHzUIpkU=
X-Google-Smtp-Source: AGHT+IFZJyXqdISeq1LYGuDoRPB/KpqNGpnz/HFb5vd+PfVIBgIoznnfXea7mfEJECpLfocW6QKn0g==
X-Received: by 2002:a17:903:4b08:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-242c21a7db6mr151772175ad.20.1754885512197;
        Sun, 10 Aug 2025 21:11:52 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aa1asm260029025ad.122.2025.08.10.21.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 21:11:51 -0700 (PDT)
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
Subject: [PATCH v1 1/2] rust: Add cpu_relax() helper
Date: Mon, 11 Aug 2025 13:10:37 +0900
Message-ID: <20250811041039.3231548-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cpu_relax() helper in preparation for supporting
read_poll_timeout().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/helpers.c   |  1 +
 rust/helpers/processor.c |  8 ++++++++
 rust/kernel/lib.rs       |  1 +
 rust/kernel/processor.rs | 13 +++++++++++++
 4 files changed, 23 insertions(+)
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
index 000000000000..d1db85b76243
--- /dev/null
+++ b/rust/kernel/processor.rs
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Processor related primitives.
+//!
+//! C header: [`include/linux/processor.h`](srctree/include/linux/processor.h)
+
+/// Lower CPU power consumption or yield to a hyperthreaded twin processor.
+///
+/// It also happens to serve as a compiler barrier.
+pub fn cpu_relax() {
+    // SAFETY: Always safe to call.
+    unsafe { bindings::cpu_relax() }
+}
-- 
2.43.0


