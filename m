Return-Path: <linux-kernel+bounces-818425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D3BB5919B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD7C527115
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2E22BE021;
	Tue, 16 Sep 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N58pLXJ6"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9BF29B778
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013292; cv=none; b=dBISdDr2x8jaHKZCxc7HvzuIgUoj0Zlg5iCGFYUh1QOQzHxLMvqrZCFR6mIpHqK/teJ88LHflVrTfL53/5SvTg8kVGnVLiCscNJ/Nslz6suDfPFetArSY03CDRJhBUh3P7JIiY+4QPY2tCGkUaFVSw8l/Z10xiOaUyD7l8Dv1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013292; c=relaxed/simple;
	bh=JJCw6mv16EeG+3BtXxjY/l2oWcIXNWBdkiWvUlFHp88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoSF1rd/6WXrSl91stYMkvtMXq+D/NyG302ZA7S83+18rxuSguFGAe67eD/EYcqbA98QP1rcf71NjL+WvPNWyWXs1C+OawEztFyrHC9SC++kXeF2sdk5V9JPiMZO/ZXiKd3uk/ZpW+JscxnMuIxYuEHfY9O4lpHXNOidoR+gRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N58pLXJ6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso31004335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013288; x=1758618088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DO9AFhAl9ilu83R9AZsAc7oWiIru4g9kqtmWSFQA0xE=;
        b=N58pLXJ6T0qHU3h2Zwf7fuXi6gHhTD6H1TRqgoxFYisWjb8hZg+7Mkeg0e4cMlY5FH
         PZuZo9hYshBC83rNwd0WYy6b+AtaFa9GrHZklM+8cdQXec15oatowoCs9l3MjheAaz9f
         57sNME+3wnVwYHgcnR3LBfkAoDqGswjRbONRx3c5pYxpKJzOtNKbIUlczKwsi6PSCUZI
         aCNhd4HaJ8cllZnffPrOQUabKK9AhOq4/Z3YHRHUb+hQu7XdBcLwGIPSHWQALuzEbpli
         tlcUsUycnugwmAcW47dzMwul7hjxjYim29OQEHK5My0ddYRjfBlmxuzhTSoBbR/hyRGK
         F07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013288; x=1758618088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DO9AFhAl9ilu83R9AZsAc7oWiIru4g9kqtmWSFQA0xE=;
        b=wVswapjarV3oyS5XdxB7N6hgKsk9ux+cGnXn37MwgeGyLMOonohyqJe7mo2LEUve9p
         6jr/YvB7gd1V8KkwJ1wqv4PyDek41jRxt0aBnKiBD/bS2GFlNZnbQm7RecVgu86R49f4
         fHQykGxDVGOXm20N0QCD1u19ROIdj3m3ShrFwSeUWCpOcXz9Lr+SstmY+vGrrGRz1Coq
         d1sBf2TSliUiVavQj6UpD9KTWzB91m0b5l6195QA0WxvGpwJXFTUR3Tmwa4w8uSryQyM
         h5Socj7lcGq6E5xmTAB5256uYjbLJcQDyQTCSzByILFLcwtTNtvYvnWobVMfFTQfeLKK
         HhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuen8UrH/UFHhSLvN/KxDEjBir5QGtZhapttha3ebh3Uaj6jiFGYYKxX7ksO1v20iMWOLrBjbTaNC/cCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjp7ljvGOmr4YTbfUEtf/iBOuZ77RxXWxs6vWeK1ZTiibHfrdu
	R8WM1dIytT2diu2pYHXilZmzsNjUeUBgyMgQnSq6u6Gx9C+cK/pn8s2D
X-Gm-Gg: ASbGnctlkl1CvBI3VncsV22jFRFXbpDXNs7TuYdpJT58yQNYpK5HgBbsGy4Fv02sTyv
	mUJ/U+HNTWWJ4OmxEgGQtH2up9u0fIhwybbhZmDDbqfh3OEyf6AatsyHe8iNzKSSNDKeeZbgT0A
	s3CqITyLSAx8JV/ekvM4XiljuuD5zYrkGSZM2H4ym8APFbhQBXEbmAZIyHPEV7mdKDhvVu8abZE
	2xVpWaRomYeAxdFBkBjFQp47x72zGbEfqMCZqt+b9nD+2Li2D5MvSFmcJdcpqUW/Kun6Li9MQCe
	nVhbjgfwZbyb3U7ua2wYl4aIdmUigB3QVEV4dRZaRGcKrnW1cf0RwLiPUQ4Cu7wXVsaGOJ7ml+l
	yTimf9RBx7+rFI9PbfSYBzqFp0nHcV07G0GvampwPaJevAR3kdndrNKrzMzJOARXvgd87RtRpKg
	qi5XAZPMopg7PxfqQvdbKnyp0=
X-Google-Smtp-Source: AGHT+IGotFF9hMuk2BHhjmZio101NvNZ9u1/TzQ6HKksgBv+fiil5SUdoiHKC9mTRtqP9GooBIX06A==
X-Received: by 2002:a05:600c:3b87:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-45f2d345de3mr59942395e9.3.1758013288120;
        Tue, 16 Sep 2025 02:01:28 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (42.16.79.34.bc.googleusercontent.com. [34.79.16.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm212975035e9.5.2025.09.16.02.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:01:27 -0700 (PDT)
From: Ethan Graham <ethan.w.s.graham@gmail.com>
To: ethangraham@google.com,
	glider@google.com
Cc: andreyknvl@gmail.com,
	andy@kernel.org,
	brauner@kernel.org,
	brendan.higgins@linux.dev,
	davem@davemloft.net,
	davidgow@google.com,
	dhowells@redhat.com,
	dvyukov@google.com,
	elver@google.com,
	herbert@gondor.apana.org.au,
	ignat@cloudflare.com,
	jack@suse.cz,
	jannh@google.com,
	johannes@sipsolutions.net,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kunit-dev@googlegroups.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lukas@wunner.de,
	rmoar@google.com,
	shuah@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v1 08/10] drivers/auxdisplay: add a KFuzzTest for parse_xy()
Date: Tue, 16 Sep 2025 09:01:07 +0000
Message-ID: <20250916090109.91132-9-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
References: <20250916090109.91132-1-ethan.w.s.graham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ethan Graham <ethangraham@google.com>

Add a KFuzzTest fuzzer for the parse_xy() function, located in a new
file under /drivers/auxdisplay/tests.

To validate the correctness and effectiveness of this KFuzzTest target,
a bug was injected into parse_xy() like so:

drivers/auxdisplay/charlcd.c:179
- s = p;
+ s = p + 1;

Although a simple off-by-one bug, it requires a specific input sequence
in order to trigger it, thus demonstrating the power of pairing
KFuzzTest with a coverage-guided fuzzer like syzkaller.

Signed-off-by: Ethan Graham <ethangraham@google.com>
---
 drivers/auxdisplay/charlcd.c             |  8 ++++++++
 drivers/auxdisplay/tests/charlcd_kfuzz.c | 20 ++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 drivers/auxdisplay/tests/charlcd_kfuzz.c

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 09020bb8ad15..e079b5a9c93c 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -682,3 +682,11 @@ EXPORT_SYMBOL_GPL(charlcd_unregister);
 
 MODULE_DESCRIPTION("Character LCD core support");
 MODULE_LICENSE("GPL");
+
+/*
+ * When CONFIG_KFUZZTEST is enabled, we include this _kfuzz.c file to ensure
+ * that KFuzzTest targets are built.
+ */
+#ifdef CONFIG_KFUZZTEST
+#include "tests/charlcd_kfuzz.c"
+#endif /* CONFIG_KFUZZTEST */
diff --git a/drivers/auxdisplay/tests/charlcd_kfuzz.c b/drivers/auxdisplay/tests/charlcd_kfuzz.c
new file mode 100644
index 000000000000..28ce7069c65c
--- /dev/null
+++ b/drivers/auxdisplay/tests/charlcd_kfuzz.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * charlcd KFuzzTest target
+ *
+ * Copyright 2025 Google LLC
+ */
+#include <linux/kfuzztest.h>
+
+struct parse_xy_arg {
+	const char *s;
+};
+
+FUZZ_TEST(test_parse_xy, struct parse_xy_arg)
+{
+	unsigned long x, y;
+
+	KFUZZTEST_EXPECT_NOT_NULL(parse_xy_arg, s);
+	KFUZZTEST_ANNOTATE_STRING(parse_xy_arg, s);
+	parse_xy(arg->s, &x, &y);
+}
-- 
2.51.0.384.g4c02a37b29-goog


