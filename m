Return-Path: <linux-kernel+bounces-824577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C031FB89974
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8761A1C84E6F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3623323AB9D;
	Fri, 19 Sep 2025 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ctzHx0J8"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F23B62A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287195; cv=none; b=DT44tKRFWoGqRBE3IgZ9Mz4qr/lTFfyg/ERNAEChD8jgEta0AN6uozVxsYUtfZFbJrruI5nN5VKcmx+TAGCKbrjem61y7a5E5jqOJyqVOStB7+kXuAC7EoqhhHXWm5ybuoJ3fT3QkFLU0KhCjwFf57MeqsP++M4cjREeau1Ys1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287195; c=relaxed/simple;
	bh=rWHkrjGiK/PkSG/Wl+on4XzMkxSKB3j5hi6+81rUdHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/QGL+tM2WDTWC86q7/umJ03oZNtuRP2bl5NE3axtWDN+nJp+W0s6T2cE35hzCZLEP2JquGSI8wPXOWgYyDswNuNSHg1i9WWkYP9QkOINvJQuYNLjeHtPfqAHNBcO/NmgkEMGeV3Sd2GJVkSBBsOmRz1MSoR5VuOEdxSJNvO3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ctzHx0J8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2570bf605b1so27955565ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287193; x=1758891993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QM3z2LyJW+bazyfIUJsU26vcVsKZ5Gd2BUVcAs3sFgA=;
        b=ctzHx0J8gOWsZQ4MHuCVK1x5UsAdhEq5mG1tJEA8WLxptXDIQaDjuYIZ7Ko72+QQ/5
         9PDov+zNx81WqGtnq25F7MBnEDmJXtDzyFXdI5nETO5/AGq31RGS0CT0mAOBalWlBOpV
         g+C1TZ5OTZNE4jemWavXbU4KFEn11hXQb+hesdlvYwV9YVsz+B8dcn0+j0gPo4gpL5T+
         GBTsM42pI0zgQj/iAuCzHPhaK0lvyawKML1pzCdC5smRk1S+uvdpc8UI1hoN1a6kOoxF
         R4nax/bK81utCq4C20Y011sg34rEC9iQQvsFX46ffCB3OpqnYR5/P/JiJ95/2AB0SnML
         GwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287193; x=1758891993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QM3z2LyJW+bazyfIUJsU26vcVsKZ5Gd2BUVcAs3sFgA=;
        b=qReFPxeWQ3g6bnlz2tlf/2Ik75a2giD+XDF5qQ6ylwmwt1qr18eRSXHXFWhxOhfm3w
         o5pWj1Xp+5FicxVxXJMmASP48BP/WxwJdLIkYSllGTwjE2X5EO8VKMefIJSC25Zfmdfw
         Tb4XtQ8DaHsF2k+a1/LfTeLwhBRgE10xfjnkgAtIfMLhgxSC0Ck4BdE8VXKbq2lgZGti
         GYbbLu8P2TxxmsuhXA+MWpj5PYzd4sfHI3qdFl3m5ojl7dwMNd6y4ffL+jz3egdcTsbB
         pu/8pOd/tvMt4Y4ShhGa/Cist6E8n2KuNCrT9hA54p/bwM5zY+nfrHNTT/oQF8B1fjTL
         i7FQ==
X-Gm-Message-State: AOJu0YyktQJOGWt0UXMsRJcTcN7gOtGy0vfTiUt795E8ibVJxNGfKzuV
	0FyqzOLXOG6T9zlrQTdajFrc1VgU6oOXSURCFgB8JKWqv5/HC4xZ3RGmhbiRD3cRSsg=
X-Gm-Gg: ASbGnctQ2wduWJOj/aeXYXntCneJt7A6vkB6lV15O3H5LcEogwskZZUU/1afa01O7xg
	rYM7Gs+qCClNtWfW07hJBnkte7j4c9J1mb4AHXTWRXcLegqfmDaVh1mSUq1SEemKxrAZHj66dzz
	k/YVRpIVjP+eQ1Kxiln8/uhqn6QyU4gk1hcplBzuphd5Q7Fi0wPgif5VYXS/nO3xWK6Z6XfgdJF
	P9900qzGSVCQ+c8druZCseTJUCkyQW6i4h9yDr/H7b3NQ+qa0eFULaUIMwvbs7cj2gjH6pbuJ8K
	7dWEC94f/vxdF7Dlseyv3vXvRidy6FbbCuD41EPe4RJBQtF3yC2kfZc5hAv1sFXbt6XJv84xPIH
	R5a3Py6jKEHn6W+ILP9nWDaCosPdlzJnXZTJHTfZWvKVXrm4=
X-Google-Smtp-Source: AGHT+IGbrf3KBw1E9vOkt5rEaC3g4HQJ3sGafywJShI64TnAWeeXbrI8TdW5u7TwWDUuix9UTIPH4w==
X-Received: by 2002:a17:903:3c2f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-269ba40e0ebmr37928995ad.8.1758287193223;
        Fri, 19 Sep 2025 06:06:33 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:32 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 1/8] mshare: Add selftests
Date: Fri, 19 Sep 2025 21:06:14 +0800
Message-Id: <20250919130620.56518-2-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch setup the selftests project for mshare and add a
'hello world' to project.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/.gitignore |  3 +++
 tools/testing/selftests/mshare/Makefile   |  7 +++++++
 tools/testing/selftests/mshare/basic.c    | 10 ++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c

diff --git a/tools/testing/selftests/mshare/.gitignore b/tools/testing/selftests/mshare/.gitignore
new file mode 100644
index 000000000000..406f31bd432c
--- /dev/null
+++ b/tools/testing/selftests/mshare/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+basic
diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
new file mode 100644
index 000000000000..651658d091c5
--- /dev/null
+++ b/tools/testing/selftests/mshare/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
+
+TEST_GEN_PROGS := basic
+
+include ../lib.mk
diff --git a/tools/testing/selftests/mshare/basic.c b/tools/testing/selftests/mshare/basic.c
new file mode 100644
index 000000000000..482af948878d
--- /dev/null
+++ b/tools/testing/selftests/mshare/basic.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "../kselftest_harness.h"
+
+TEST(basic)
+{
+	printf("Hello mshare\n");
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


