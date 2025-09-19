Return-Path: <linux-kernel+bounces-824781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD6B8A23C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9CC58678A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC331961A;
	Fri, 19 Sep 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndL66Goc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E23164BA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293889; cv=none; b=KJCyyRgtUkYj+MiI/f5rcPBnhsDXLHmLyAy5BAr8Jh6OiFeZKrDeHlwt+DPihbtE6iffeqSPoEj1Jn6V3ibKvVJZkIFEw5d2KJwTl0oKlZcIMeMAa9Y9T81STTozwl8OYiHMfxcZhtkz7WKeALU72bG1eCLoJseCEzbCWAfifpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293889; c=relaxed/simple;
	bh=z4XRQgx/v9aMDHTqeuKkcVV2lob3wsrHL0J2Rkuf4lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxBMhjO7dycCdelXsMz9QfUCZ60QsD7Z6sTo4QkBXcaieeCqEpt8Cc1iItBIU2ih0LYEl6ubd8xhg9RHh5Nk6HdAYIqG7iCIVp0vdoqndvnkqiBr7hbpPbOQhaTy4KKCGGCUTds7z5b9Qj1aYje8sE5KADM15UffbOwilrFCsVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndL66Goc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so21469635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758293885; x=1758898685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa5F8osjsxPwGqDjaoLyZTZuU1vO95PkOFG1IS0GKrs=;
        b=ndL66Goc6s91o2EtgHWCwvtiQxsc18t85qSefhQXDFaAVJbQl1E/cRoAwxauK0d0Mz
         I+XfyP82yUY+WmFCv3cSXzUcip03iXKXTTDNpblPmq/NMt9fq+OTe50kY1sm2Zf0+umj
         TVM6u00JkBVfXkgMcmeh1FcmToQzszDx3/0Rma9KfuWKoj0UWmEpRu02kYCXfVPBoEJL
         TpoxHZUD95o6G7tpGAKqPaAMbld6nulm0/LvVKstJoxHX44pGpTM32FPixA55aT454pM
         f5gqQcL87cX7aN1FWDRNKBnoMIkK3Yca5+FqwbiVVzgshlbKlOBJJqjeRxJqiZslFm3d
         c21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293885; x=1758898685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa5F8osjsxPwGqDjaoLyZTZuU1vO95PkOFG1IS0GKrs=;
        b=Z/ZgQbAdwvgSyLz56SJEHph8vRTTCR+kdhzlMfBXrrKG6Ai79mI5n04NuJn4tvH7Cf
         aakmgny6QugCPWzVqWHmPh/I9c8lq9e019pPp5CEkUgM2N0o/13Lx1VxpCpCMOgrtEWR
         4aoyAAcQRYP9fj+rmg1lIypQbl0rksSXBgui6MkMd2vc8RxK/rh1SS4tSV11Ls0T8GGv
         BW/G8XDe+S/w5jBN9RzQ2S23taJuoIu0RACsUZ5N3caiJ5N1McBkRrG+Mzo89ltlmnH7
         0d3h0QIgixA0JtJ4f3AJ6UjhwsaSyM9zInvu9lqjzdABtSkREWuPwXIiAIS8BqAZJ2pb
         y++A==
X-Forwarded-Encrypted: i=1; AJvYcCWs3Gw9qgjsomRPHV35UdQV+SQp4mFwujsOSZXsWTkR+MQj25EIP9x02qXu3M544JGxuYcKwtFXhLhX8+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1y0zertPif9r+LCEKzuPLP+bgsrmkbP7liQZbKBy2HIGfJKg
	211CF6fNeeh9mvdIBEGugCP7eLR0DYVVfQHDPmnpELvJkVHDCWwpudE8
X-Gm-Gg: ASbGncucuI3SdR8GPJox8oQMazKAhX9i1knsEHSfVQDlKbifQAOBBgFBOoG+xuWZP5H
	C6SaJ8oUkAsQ4a1nsWE0W8GBAMYDv/CdTIaA7gRgriVwVYU0acNAV5+YjI6aIWjNRRxZ18h/+Ai
	Khyd2LCg+OPqAGynNaj4ks3qdbEO67hSV//OquOzvnxdrOf4WjWZqiSrDjoXAi4e3f+T+jhBmzw
	uv2oU5S148I3GLtsY2MhnwNgNFzmuTH/Jxn6dR1rFeh1rmS2gRnAskYCT0zed3QC8hVyirPl7LV
	3frCdBwwNcTccNar/SVia4+Ld2nTv91VEPDQUORTVKUUkeBymfNqLzfoy206k8wfTAoTzWt4mv0
	g/ENXdoywpgmFQ0Zd0S9pxz2Qb7E4DjJ7KvyFV7+Aat+/nJSy1/ezXKFIfe6ZGTjWz+WeO58Ag8
	MinXn2A5Szffx7vXk=
X-Google-Smtp-Source: AGHT+IHdJYIXqz3C4OR8m/GvaJucPOCvchvPgeW6LDDv3ZVv3CkV0oEsEwnK0vfoZjKlHtOSmNp5DQ==
X-Received: by 2002:a05:600c:4ecb:b0:45f:2bdd:c959 with SMTP id 5b1f17b1804b1-4684c13ec45mr31051625e9.8.1758293885086;
        Fri, 19 Sep 2025 07:58:05 -0700 (PDT)
Received: from xl-nested.c.googlers.com.com (124.62.78.34.bc.googleusercontent.com. [34.78.62.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm8551386f8f.37.2025.09.19.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:58:04 -0700 (PDT)
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
	sj@kernel.org,
	tarasmadan@google.com
Subject: [PATCH v2 08/10] drivers/auxdisplay: add a KFuzzTest for parse_xy()
Date: Fri, 19 Sep 2025 14:57:48 +0000
Message-ID: <20250919145750.3448393-9-ethan.w.s.graham@gmail.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
In-Reply-To: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
References: <20250919145750.3448393-1-ethan.w.s.graham@gmail.com>
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
2.51.0.470.ga7dc726c21-goog


