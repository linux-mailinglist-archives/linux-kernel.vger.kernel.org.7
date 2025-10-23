Return-Path: <linux-kernel+bounces-866820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F136C00BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80AB84FCA59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9C30DEC5;
	Thu, 23 Oct 2025 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYtkqRJO"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5E30BB82
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218970; cv=none; b=AZHWwQkylABWTs89VWWkwQthusejunl325fAnLEfjupA5c+M/IZuS1WP2oqnIKsVpSth40FFdPElqN5vBewymPHFTq6VJ8QztH+1DY3nO3ILKk7oNgMzb8GMr2Lq98y2GISBX89O/pkZTM8d9DGr9HDFdtZnaDmwcKp9o3vaGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218970; c=relaxed/simple;
	bh=FzKKP+qi1TzhAHy7hRHyyiW9VgAJXjaR72cYrrVJ5mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDQIom0XtwP1D0aM9wjqF3SqaLMcmduWhogv9veFQNALkIEi1hX4HlsCcYNq7032TeMZeOH95sQnpjzpuW68pph33VbCiGYMIIEGhstuyHrPaZtvodD8gClyXKDkjq8EfuyPd/pTaZse9unzfQgTbmPYDtMoWw16+JRWqVh/q8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYtkqRJO; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso900195a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218967; x=1761823767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pI8fyvV9NpEDh37BJB0AeNnznBi5OzA64bjGckGCQw4=;
        b=bYtkqRJO3m2MRd84Vh8P8CENFYgXShP7hPZayPRpzHltTEjMRbDEG2gAJblVt3iU1C
         pyh/BdGcXrPx5MUCWFx7es6Yd718xgvasR3ibASOPdIQoFI7P6MiNjtYH+fHgykZV8ru
         /edtBNnv2xnc1RJVW+J50tCiqndrpvTEa9A7gZ1VJF0rLjcQinNuUJ9j+ZJuZ8L8TorP
         hY9z1if0M4y7d9yiqe2oYkfZDcn9aWqUEIUS08K+83t//sIrBlnOsCvA9aFsjc5ncT3h
         5lU1FDhHLubrPipc2uhC2OVL8rjVTR6GRMJak5JONyU8SoSrYEU9dgkyfotxCbLeS47l
         c9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218967; x=1761823767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pI8fyvV9NpEDh37BJB0AeNnznBi5OzA64bjGckGCQw4=;
        b=ehAevmqLN1O2OR3nmywPN90XXM482oEvWhLILrzoJ9Oct/vlHEYWJU5YTpa7NRwcdk
         yupyV88arUuWxsbjPBHHwmjRpRZIobfMNiwAl/lETbNheBGYETLscC9cagNimlEesRuj
         0GF2H9UzD7PvxOaNBwdo98K/Vurv6J66PMMCoXqheEysvHviWfAPAfQMeawnFZ2J4ugG
         oUL73JVWlblDpIxmxYtqboOT1gZXgTjL3ePZ+iWjPvas2LtQk6s6NM1iuHtvjR9ldj++
         6S8TpEBHHH7EU4GMbU4vj3apXHCiUCFQVv7W9XJdA1pA/BaHIujJpELP+0hmoiolZxvD
         vF6w==
X-Gm-Message-State: AOJu0YwihCT80smiGuk/4FJt8zgol+ojxBrA0ZaeZMQ2iZ8ffM8Jpw2K
	TC03t5lrpsHkF8nSGsD9K/HVH0nzVVA2XbOfEXsDZWjPbqLQ7aKkWWaQ
X-Gm-Gg: ASbGncveWo+EhrYfj2Vqh/F+z7fQ+56h2ITENI4PZejWFwLlSGe/J5uTkl+5aiemjDI
	e62Rbrp/U1abF+T5Q28/P88mspqnm238+MCTHuXjTtYbmeS4lBwF0KBcMajuw9I7SXkqZI8aimI
	WKlhdFWxHAPVdGpmr+Mz1vqsVS+4yYCxzWq1Mj77EFbsRMMyuTRA/wnxsPsLdVtq1+3DdmYwxPn
	DX/Um5KS6/YL3AneHGn5SDo9MBDgGQcTlRFsdcsuLGUV0/b27a77fQ6sfhj3zvJ13pq/QiefncI
	fnYEBKPPYuVYg2pYrjeEJXTVbj1I7Om6u40d5r9Rffuji1B1c0Bh5QhTThXJeEAtLRfygT3S+LI
	wqOAhL5c0YkJWn4mgw/xhbvr19v/1Ild+ogD+7xwdG/kcW8JcNghAm3ZY9YPB21DFW05OP3bu04
	WsJsAmV+Mz1H2idFvm0kqIG0EHZh29rax8MVebv2Y=
X-Google-Smtp-Source: AGHT+IHMYmeE18WGGDWshrdmjaUibaI2DHVfeSDnI9qvk7s92Hc90Yy/ULdLnI50ohpLA3HpbFF6uw==
X-Received: by 2002:a17:903:b0e:b0:290:c76f:d2ac with SMTP id d9443c01a7336-290cb65c5dbmr299615075ad.43.1761218967442;
        Thu, 23 Oct 2025 04:29:27 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de02cb7sm20942165ad.40.2025.10.23.04.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:26 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v4 1/3] selinux: Introduce a new config to make avc cache slot size adjustable
Date: Thu, 23 Oct 2025 19:29:19 +0800
Message-ID: <cc48748e9dcfa63fbbaeabad0b2536a0f602cb1d.1761217900.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761217900.git.zhanghongru@xiaomi.com>
References: <cover.1761217900.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

An actual call stack is as follows:
 => avc_compute_av
 => avc_perm_nonode
 => avc_has_perm_noaudit
 => selinux_capable
 => security_capable
 => capable
 => __sched_setscheduler
 => do_sched_setscheduler
 => __arm64_sys_sched_setscheduler
 => invoke_syscall
 => el0_svc_common
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node() latency increase.

So introduce a new config to make avc cache slot size also configurable,
and with fine tuning, we can mitigate long time irqs off with slightly
avc_search_node() performance regression.

Theoretically, the main overhead is memory consumption.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/Kconfig | 11 +++++++++++
 security/selinux/avc.c   |  6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 61abc1e094a8..5588c4d573f6 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -69,6 +69,17 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
 
 	  If unsure, keep the default value.
 
+config SECURITY_SELINUX_AVC_HASH_BITS
+	int "SELinux avc hashtable size"
+	depends on SECURITY_SELINUX
+	range 9 14
+	default 9
+	help
+	  This option sets the number of buckets used in the AVC hash table
+	  to 2^SECURITY_SELINUX_AVC_HASH_BITS. A higher value helps maintain
+	  shorter chain lengths especially when expanding AVC nodes via
+	  /sys/fs/selinux/avc/cache_threshold.
+
 config SECURITY_SELINUX_DEBUG
 	bool "SELinux kernel debugging support"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 430b0e23ee00..c12d45e46db6 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -34,9 +34,9 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/avc.h>
 
-#define AVC_CACHE_SLOTS			512
-#define AVC_DEF_CACHE_THRESHOLD		512
-#define AVC_CACHE_RECLAIM		16
+#define AVC_CACHE_SLOTS		(1 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
+#define AVC_DEF_CACHE_THRESHOLD	AVC_CACHE_SLOTS
+#define AVC_CACHE_RECLAIM	16
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 #define avc_cache_stats_incr(field)	this_cpu_inc(avc_cache_stats.field)
-- 
2.43.0


