Return-Path: <linux-kernel+bounces-612275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A007A94CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4803B2F22
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DC213E91;
	Mon, 21 Apr 2025 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCVK+MGo"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96CB21322B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 07:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220181; cv=none; b=los9o9XfvHF7fPP7nDMO9HXuQms0F4mpUaHg+tpRwiv9Cpl5dA0pZsm+0HEXI9j4IFtLuDPdOzNRIQGnCjhOCODdaM9Qqct84dhihoWF5FWqXmvyCxPxzLizMlqSmjgBV7XFSS9n4pKjA4JQpbmAyTdG0lG7DYNqP5K8bs78/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220181; c=relaxed/simple;
	bh=4HWksdgns8ejVb++Q4NJVdKDSuHEDHdMmvi+j+YhGlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR2Fxqqo6Y/CU1T0nnUHjxmXAOaylyG3IzXXlPH77/elgTzvQdZEkXhZ7Qq+w9IsZvJVF1Rb19SIvdeB8wYkKBtj32cfa3Eyjoq5Dgzc/IBrH07NkJ6Vvb2htN+o36JH7bIS7uDr6zmPH69Hc5EAFBvyDVFoApdH5R89D2g4IzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCVK+MGo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227914acd20so36992395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 00:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220179; x=1745824979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNsggH78Gujq22EIg5QA+ygoUlPHiqAj8S6vH5ayXvk=;
        b=gCVK+MGoFcq8T9M7dKRL77rn/KjhTtQugWexbw7oL6x6lHjgpoVTDBAZk5dj/yctiJ
         3PU2r+3r9RIHBMC6yZFidl2woDvGCQuns5GN523MHPB3QXCfZ03zuKJWjrOUNMh0acqD
         CETr+G0uAEwCL1iOf17Yak4l+jutYIa4Tyd/KyBMR5A7IkJIz/nq0J7FBR6ikXC/ITYH
         RW4b6OSE08Yzk/6kyGFxhUVfFpaOtBCA8MCW7M0Kef0mLJc9UquPDcKLLh/cwkCbOHru
         pBYlpwTSI5jdeyIAdGzgipZhaimAKElli1+x0HmasukEb0FuGPMXVu7JLsCP1LULFX3g
         AHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220179; x=1745824979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNsggH78Gujq22EIg5QA+ygoUlPHiqAj8S6vH5ayXvk=;
        b=q39pQbrgcd3gyNq+jQ0sEczOogI45a7d4keG8kHPTCup7YY2hF/wZRmtWBobck5wzQ
         IlEsf9mSWMdXRSmlypEHxezVyMuEweFbGsEgKJ6Tc5V2QGsSSgngTpQvk8lyrJKEHLZD
         K/Y+j6cUZRKGzoe8UzHG/Nti1TNOWtZrV5+poDHCLVSoL9oeW7ioI+8OBoyJWSP5x4CS
         Vt4y27KzCnQ7hmxvP5+PER/v4eOSadDBTjngLgG3WxoEwvVqM7LL0z3NOlmCoN1H/zlG
         QpJvrKidg9+CDGYXyhv+JugjwMaWZc/mjRc6BjACoAgYAB9lYP6rIOacTJm3ZI7A5MHT
         1siQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3iU9Uchc37FTeskPEbvYqO8LoZILToP/3MBXcV16gh1aDMHBEp1hjisjzbH3hSqWavOklwcAIbxEtilA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIWW/wSY5hH7M+PVWc4bMDFRx6w84Yy6iFnnoO2j7VDNORXDJI
	HjgXkdFvaBgIefjYx6MafZt2DXAyuHmEVMrqud5IjV8hAdE7d9wvvypm7fNFauY=
X-Gm-Gg: ASbGncs9GvLzElLSksTWO3PvM1NWMq2Opsul9ADRuNLVl6B2NOwxH+fi0DN2p+GXKFS
	4pBXzCDmN/iDomlZbB6HmpCGXY5etYRF5eRQ32SZ1m5FTRchlauIMwCezWzpYHOzSHFct64Q0Rr
	WaEJlfmlzpti15Wr/5SCOeut7BLF92oo+/8DPd5I6ZS+wEv44Uh8kDxa1wXCQWfCsM7gbKWhOrn
	5CJVtB4Gj11pj1J8cQoPBxWo9lhVmewRurvvizzSKwEBt0alHOIxQV+rv9eD0Db4rBM6JoQQWIO
	aC1VRr9LQyerVg++KsIZbWLAynqSNQDPj1Rdmtolng==
X-Google-Smtp-Source: AGHT+IFmAEZmVfF2/jJIFd2AX+TRAi14+CXqAGbQyZTBUCMo9uzwZXqwwPnyIMPXsyXmqJRV3PygbA==
X-Received: by 2002:a17:902:cf05:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22c50d8c10fmr163080145ad.26.1745220178930;
        Mon, 21 Apr 2025 00:22:58 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaacf48sm6086222b3a.148.2025.04.21.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:22:58 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
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
Subject: [PATCH V11 04/15] rust: clk: Add helpers for Rust code
Date: Mon, 21 Apr 2025 12:52:11 +0530
Message-Id: <97741e1c82feecbd650183c6a52d2e8bbafad79f.1745218975.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-trivial C macros and inlined C functions cannot be used directly
in the Rust code and are used via functions ("helpers") that wrap
those so that they can be called from Rust.

In order to prepare for adding Rust abstractions for the clock APIs,
add clock helpers required by the Rust implementation.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |  1 +
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/clk.c              | 66 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 4 files changed, 69 insertions(+)
 create mode 100644 rust/helpers/clk.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7c54af4fd4..608689342aaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5883,6 +5883,7 @@ F:	include/dt-bindings/clock/
 F:	include/linux/clk-pr*
 F:	include/linux/clk/
 F:	include/linux/of_clk.h
+F:	rust/helpers/clk.c
 X:	drivers/clk/clkdev.c
 
 COMMON INTERNET FILE SYSTEM CLIENT (CIFS and SMB3)
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ab37e1d35c70..f53d6e1a21f2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/clk.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
diff --git a/rust/helpers/clk.c b/rust/helpers/clk.c
new file mode 100644
index 000000000000..6d04372c9f3b
--- /dev/null
+++ b/rust/helpers/clk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk.h>
+
+/*
+ * The "inline" implementation of below helpers are only available when
+ * CONFIG_HAVE_CLK or CONFIG_HAVE_CLK_PREPARE aren't set.
+ */
+#ifndef CONFIG_HAVE_CLK
+struct clk *rust_helper_clk_get(struct device *dev, const char *id)
+{
+	return clk_get(dev, id);
+}
+
+void rust_helper_clk_put(struct clk *clk)
+{
+	clk_put(clk);
+}
+
+int rust_helper_clk_enable(struct clk *clk)
+{
+	return clk_enable(clk);
+}
+
+void rust_helper_clk_disable(struct clk *clk)
+{
+	clk_disable(clk);
+}
+
+unsigned long rust_helper_clk_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk);
+}
+
+int rust_helper_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_set_rate(clk, rate);
+}
+#endif
+
+#ifndef CONFIG_HAVE_CLK_PREPARE
+int rust_helper_clk_prepare(struct clk *clk)
+{
+	return clk_prepare(clk);
+}
+
+void rust_helper_clk_unprepare(struct clk *clk)
+{
+	clk_unprepare(clk);
+}
+#endif
+
+struct clk *rust_helper_clk_get_optional(struct device *dev, const char *id)
+{
+	return clk_get_optional(dev, id);
+}
+
+int rust_helper_clk_prepare_enable(struct clk *clk)
+{
+	return clk_prepare_enable(clk);
+}
+
+void rust_helper_clk_disable_unprepare(struct clk *clk)
+{
+	clk_disable_unprepare(clk);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index e1c21eba9b15..ae595c9cd91b 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "clk.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
-- 
2.31.1.272.g89b43f80a514


