Return-Path: <linux-kernel+bounces-752279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92005B1737D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6517D841
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13251A76D4;
	Thu, 31 Jul 2025 14:53:51 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D591ACED9;
	Thu, 31 Jul 2025 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973631; cv=none; b=sk4rMK8IvQRZnpeI6Jh+uhmUDbvEkJNkPhQRcyb/b8sMAqSqnR+ygGpf4wPOxGGs2x7r+BF4ZHNSdaVXXMoRGAeGrID+pYgurT2qyxWyXdudVunyppz26V24gg0L0GhSUiF4K5MUmg4TixYKdOfqhRvMTmjnudvaEiKWBDRKM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973631; c=relaxed/simple;
	bh=3sXELTEm7qK2XP/5dvwiNq6rQnHkyVy7gY7QF4iSR64=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=a+Z1y7F4oz6wahPx3s6asaeHZz/F8e49lSqShGoaj1XOJ3ozKSOv2b/PeD3wTNPRjrIhrafh6APYHfMqkAkpVoKTgLH1q2gwasHVClf4BkAcV7+QDQ959mBOwEAKrdbQ1FpmKpmdbiJxt7Yh8pIZYjHg+cQwML4xmN0nrAw19iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4btBss1vg1z6FyBr;
	Thu, 31 Jul 2025 22:53:37 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 56VErORP043467;
	Thu, 31 Jul 2025 22:53:24 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 31 Jul 2025 22:53:26 +0800 (CST)
Date: Thu, 31 Jul 2025 22:53:26 +0800 (CST)
X-Zmail-TransId: 2af9688b8366fffffffffc6-7c266
X-Mailer: Zmail v1.0
Message-ID: <20250731225326549CttJ7g9NfjTlaqBwl015T@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHRvb2xzL2dldGRlbGF5czogYWRkIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgZm9yIHRhc2tzdGF0cyB2ZXJzaW9u?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56VErORP043467
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Thu, 31 Jul 2025 22:53:37 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688B8371.000/4btBss1vg1z6FyBr

From: Fan Yu <fan.yu9@zte.com.cn>

Add version checks to print_delayacct() to handle differences in
struct taskstats across kernel versions. Field availability depends
on taskstats version (t->version), corresponding to TASKSTATS_VERSION
in kernel headers (see include/uapi/linux/taskstats.h).

Version feature mapping:
- version >= 11  - supports COMPACT statistics
- version >= 13  - supports WPCOPY statistics
- version >= 14  - supports IRQ statistics
- version >= 16  - supports *_max and *_min delay statistics

This ensures the tool works correctly with both older and newer kernel
versions by conditionally printing fields based on the reported version.

eg.1
bash# grep -r "#define TASKSTATS_VERSION" /usr/include/linux/taskstats.h
"#define TASKSTATS_VERSION       10"
bash# ./getdelays -d -p 1
CPU                 count     real total  virtual total    delay total  delay average
                     7481     3786181709     3807098291       36393725          0.005ms
IO                  count    delay total  delay average
                      369     1116046035          3.025ms
SWAP                count    delay total  delay average
                        0              0          0.000ms
RECLAIM             count    delay total  delay average
                        0              0          0.000ms
THRASHING           count    delay total  delay average
                        0              0          0.000ms

eg.2
bash# grep -r "#define TASKSTATS_VERSION" /usr/include/linux/taskstats.h
"#define TASKSTATS_VERSION       14"
bash# ./getdelays -d -p 1
CPU                 count     real total  virtual total    delay total  delay average
                    68862   163474790046   174584722267    19962496806          0.290ms
IO                  count    delay total  delay average
                        0              0          0.000ms
SWAP                count    delay total  delay average
                        0              0          0.000ms
RECLAIM             count    delay total  delay average
                        0              0          0.000ms
THRASHING           count    delay total  delay average
                        0              0          0.000ms
COMPACT             count    delay total  delay average
                        0              0          0.000ms
WPCOPY              count    delay total  delay average
                        0              0          0.000ms
IRQ                 count    delay total  delay average
                        0              0          0.000ms

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 tools/accounting/getdelays.c | 167 +++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 67 deletions(-)

diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 3feac0482fe9..21cb3c3d1331 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -194,75 +194,108 @@ static int get_family_id(int sd)
 #define average_ms(t, c) (t / 1000000ULL / (c ? c : 1))
 #define delay_ms(t) (t / 1000000ULL)

+/*
+ * Version compatibility note:
+ * Field availability depends on taskstats version (t->version),
+ * corresponding to TASKSTATS_VERSION in kernel headers
+ * see include/uapi/linux/taskstats.h
+ *
+ * Version feature mapping:
+ * version >= 11  - supports COMPACT statistics
+ * version >= 13  - supports WPCOPY statistics
+ * version >= 14  - supports IRQ statistics
+ * version >= 16  - supports *_max and *_min delay statistics
+ *
+ * Always verify version before accessing version-dependent fields
+ * to maintain backward compatibility.
+ */
+#define PRINT_CPU_DELAY(version, t) \
+	do { \
+		if (version >= 16) { \
+			printf("%-10s%15s%15s%15s%15s%15s%15s%15s\n", \
+				"CPU", "count", "real total", "virtual total", \
+				"delay total", "delay average", "delay max", "delay min"); \
+			printf("          %15llu%15llu%15llu%15llu%15.3fms%13.6fms%13.6fms\n", \
+				(unsigned long long)(t)->cpu_count, \
+				(unsigned long long)(t)->cpu_run_real_total, \
+				(unsigned long long)(t)->cpu_run_virtual_total, \
+				(unsigned long long)(t)->cpu_delay_total, \
+				average_ms((double)(t)->cpu_delay_total, (t)->cpu_count), \
+				delay_ms((double)(t)->cpu_delay_max), \
+				delay_ms((double)(t)->cpu_delay_min)); \
+		} else { \
+			printf("%-10s%15s%15s%15s%15s%15s\n", \
+				"CPU", "count", "real total", "virtual total", \
+				"delay total", "delay average"); \
+			printf("          %15llu%15llu%15llu%15llu%15.3fms\n", \
+				(unsigned long long)(t)->cpu_count, \
+				(unsigned long long)(t)->cpu_run_real_total, \
+				(unsigned long long)(t)->cpu_run_virtual_total, \
+				(unsigned long long)(t)->cpu_delay_total, \
+				average_ms((double)(t)->cpu_delay_total, (t)->cpu_count)); \
+		} \
+	} while (0)
+#define PRINT_FILED_DELAY(name, version, t, count, total, max, min) \
+	do { \
+		if (version >= 16) { \
+			printf("%-10s%15s%15s%15s%15s%15s\n", \
+				name, "count", "delay total", "delay average", \
+				"delay max", "delay min"); \
+			printf("          %15llu%15llu%15.3fms%13.6fms%13.6fms\n", \
+				(unsigned long long)(t)->count, \
+				(unsigned long long)(t)->total, \
+				average_ms((double)(t)->total, (t)->count), \
+				delay_ms((double)(t)->max), \
+				delay_ms((double)(t)->min)); \
+		} else { \
+			printf("%-10s%15s%15s%15s\n", \
+				name, "count", "delay total", "delay average"); \
+			printf("          %15llu%15llu%15.3fms\n", \
+				(unsigned long long)(t)->count, \
+				(unsigned long long)(t)->total, \
+				average_ms((double)(t)->total, (t)->count)); \
+		} \
+	} while (0)
+
 static void print_delayacct(struct taskstats *t)
 {
-	printf("\n\nCPU   %15s%15s%15s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "IO    %15s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "SWAP  %15s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "RECLAIM  %12s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "THRASHING%12s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "COMPACT  %12s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "WPCOPY   %12s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n"
-	       "IRQ   %15s%15s%15s%15s%15s\n"
-	       "      %15llu%15llu%15.3fms%13.6fms%13.6fms\n",
-	       "count", "real total", "virtual total",
-	       "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->cpu_count,
-	       (unsigned long long)t->cpu_run_real_total,
-	       (unsigned long long)t->cpu_run_virtual_total,
-	       (unsigned long long)t->cpu_delay_total,
-	       average_ms((double)t->cpu_delay_total, t->cpu_count),
-	       delay_ms((double)t->cpu_delay_max),
-	       delay_ms((double)t->cpu_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->blkio_count,
-	       (unsigned long long)t->blkio_delay_total,
-	       average_ms((double)t->blkio_delay_total, t->blkio_count),
-	       delay_ms((double)t->blkio_delay_max),
-	       delay_ms((double)t->blkio_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->swapin_count,
-	       (unsigned long long)t->swapin_delay_total,
-	       average_ms((double)t->swapin_delay_total, t->swapin_count),
-	       delay_ms((double)t->swapin_delay_max),
-	       delay_ms((double)t->swapin_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->freepages_count,
-	       (unsigned long long)t->freepages_delay_total,
-	       average_ms((double)t->freepages_delay_total, t->freepages_count),
-	       delay_ms((double)t->freepages_delay_max),
-	       delay_ms((double)t->freepages_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->thrashing_count,
-	       (unsigned long long)t->thrashing_delay_total,
-	       average_ms((double)t->thrashing_delay_total, t->thrashing_count),
-	       delay_ms((double)t->thrashing_delay_max),
-	       delay_ms((double)t->thrashing_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->compact_count,
-	       (unsigned long long)t->compact_delay_total,
-	       average_ms((double)t->compact_delay_total, t->compact_count),
-	       delay_ms((double)t->compact_delay_max),
-	       delay_ms((double)t->compact_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->wpcopy_count,
-	       (unsigned long long)t->wpcopy_delay_total,
-	       average_ms((double)t->wpcopy_delay_total, t->wpcopy_count),
-	       delay_ms((double)t->wpcopy_delay_max),
-	       delay_ms((double)t->wpcopy_delay_min),
-	       "count", "delay total", "delay average", "delay max", "delay min",
-	       (unsigned long long)t->irq_count,
-	       (unsigned long long)t->irq_delay_total,
-	       average_ms((double)t->irq_delay_total, t->irq_count),
-	       delay_ms((double)t->irq_delay_max),
-	       delay_ms((double)t->irq_delay_min));
+	printf("\n\n");
+
+	PRINT_CPU_DELAY(t->version, t);
+
+	PRINT_FILED_DELAY("IO", t->version, t,
+		blkio_count, blkio_delay_total,
+		blkio_delay_max, blkio_delay_min);
+
+	PRINT_FILED_DELAY("SWAP", t->version, t,
+		swapin_count, swapin_delay_total,
+		swapin_delay_max, swapin_delay_min);
+
+	PRINT_FILED_DELAY("RECLAIM", t->version, t,
+		freepages_count, freepages_delay_total,
+		freepages_delay_max, freepages_delay_min);
+
+	PRINT_FILED_DELAY("THRASHING", t->version, t,
+		thrashing_count, thrashing_delay_total,
+		thrashing_delay_max, thrashing_delay_min);
+
+	if (t->version >= 11) {
+		PRINT_FILED_DELAY("COMPACT", t->version, t,
+			compact_count, compact_delay_total,
+			compact_delay_max, compact_delay_min);
+	}
+
+	if (t->version >= 13) {
+		PRINT_FILED_DELAY("WPCOPY", t->version, t,
+			wpcopy_count, wpcopy_delay_total,
+			wpcopy_delay_max, wpcopy_delay_min);
+	}
+
+	if (t->version >= 14) {
+		PRINT_FILED_DELAY("IRQ", t->version, t,
+			irq_count, irq_delay_total,
+			irq_delay_max, irq_delay_min);
+	}
 }

 static void task_context_switch_counts(struct taskstats *t)
-- 
2.25.1

