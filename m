Return-Path: <linux-kernel+bounces-785014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE1B344C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7414E3A3556
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E032FC87E;
	Mon, 25 Aug 2025 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U45/bRS6"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC52FC87A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133857; cv=none; b=NZv0QyaxCCZl2X8kFianu7AKGPSbUY74zcSf0Pn/TVaaSIyw54LexZAvAPZFQYm+xAdItjgHnV43AZXw5G5M0UzDr/ixrfzEJyUY7xon05Cnni/E+lq/zKVfYBivn3ej/Jh7RLyV0qjuepTZrhAR4pAU7zcpj+Qn8wB07Now8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133857; c=relaxed/simple;
	bh=5SQHOFh1sUDEoQa/LsWjRDqFRqBAtXV8PziERqMxVJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCFcyfMRA0H8Wm5qVBJdafhNmMU8eNhj6Lcwx5zpo18I8Q1IdsoUW3QBAFcoHd8KcPGAXK7r+j0OzqXgOYzVqtPrA1K/dRBFLQoauZG0X7rfHcnVbBpM7VlkLMINNbvPTo8cga4chzYTPrPPIYm761eGEQKi3CBJfcpGNYA9nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U45/bRS6; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77053017462so1133054b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133854; x=1756738654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=U45/bRS6mtIk0S7Xl3Gc5ye+V/U6c5SiuMFFrUaS2fykbmQTPOMAj7wnH1653Akm1s
         PHxJd8ZBJPxFepuJFiaDjCSndeB4XiBEMsD5Tm7egNHI6hnY/lxVT8UQ0ssCzDffX29o
         esg8vb2bmKBxdWXBvKpXY0VKB/ANW80ZADXlJ52ANC76FjfgJFQP4hmmZEIlUEN1iGGQ
         ywpk658DjXNJTutBsl3HW2vIt224H2aan54En+nFMQPDDUqRd8OpJ5H1nW/LCLtouzez
         6jHyKsGMI+vJVCWvmjKTrHK6cz3pg9fFo34CHcyQxICw/zb5FyvB5qEoPQSQjVhFcEjN
         nGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133854; x=1756738654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS8UElWYPBKNDeTRQOyijx7AjeTpgm/xr/2yY07TeYU=;
        b=neTwJHrGyFi0CaxeLbz9jFquQ8Yx8kGNOM2ESffY8SdDat2SSP1SGgUtB96cw5snB3
         sRBDsjCcUtt39FNmW8GA37v2mOAcwVbosl+FsxcdJhMoP5I09Hhw+bECY9J0mpIQXdzH
         TXwd4eYO3PtqJvj2+uIpnZHY8wBPtEi0e9DCSS9njIdS4lFTfg4WppzXR0x3nxAIDSgZ
         /y6jtqhpMaYAKp0Vz14EnX7PIDL1BgmDRHcPpBbRJ0a48gYM3AS7mgMIgZSqqUsD2aJW
         RLLJmRWQNyRBIUI4qtsOVaict3HoYa8NYZnzHrKl49kaMpcXIcVh+syJoCW1KooVpgaz
         Yryw==
X-Gm-Message-State: AOJu0YzAwXlXxhYs2tZORcdqNWh/ocp/vl37iyzDhk1+NXJBzzkxWO+8
	shTFZRNDZbEWcQ795h2M53jqUIdhOWEfedi5v7xc+Scjh3uDEboBX4FqDJcNIX6ODko=
X-Gm-Gg: ASbGnct7Do+cew743xzkjac6lIslSnUbS0hFoRKp8YJs2DWF3Q+sdEc468zzpv0G6PD
	+y/45MOVahO+ShzeJisejrrHcygsbEXLYCqkw9r1pBM9uixsOKAZ+NOacChdLvXJktIu8rM2tJQ
	N6wOy4kpMDG8ixSCt4Meem8nZ6iwirZlb+AgJ+mp0QPVkJXpXzuyZrNmWtQPJL9WN3Le9+toeqT
	bWFNDr0fRYywfFBcVJOQ37kAkwJncpaz8ojBEuKlQI1ESQzgUwralg+cPktGMiPDnwPOK/d6d5J
	1U1s92kOEnlVZzwIExnoa62ovBBLgpQHkIdKGNgjwvTsCQheBopOSR5Q1K18+pviqoHDGYCoY4m
	VB6E39jXrS8h0RyZwuKoN7RNnoukSUFkUfUKmqMRUteUauKH6WcjMgYKtQaKo
X-Google-Smtp-Source: AGHT+IHz+meFfe4e38cUw2IZHOaqrwBamHHnHRSOwdnH4MJHnCKcgOHroPbVyCsbXw3Co2hLg9rpTQ==
X-Received: by 2002:a05:6a00:3e01:b0:76e:885a:c33a with SMTP id d2e1a72fcca58-7702fc28b0cmr17435058b3a.32.1756133853573;
        Mon, 25 Aug 2025 07:57:33 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:33 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mshare: Add selftests
Date: Mon, 25 Aug 2025 22:57:04 +0800
Message-Id: <20250825145719.29455-2-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets up the selftests project for mshare and add a
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


