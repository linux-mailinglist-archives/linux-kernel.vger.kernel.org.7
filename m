Return-Path: <linux-kernel+bounces-739321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B14B0C4C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D4616B332
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F7A2D9EE8;
	Mon, 21 Jul 2025 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVB3k91v"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2762D949C
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103117; cv=none; b=mMJeRD7HBfDtm11HHyB+T2SSTOjEND85/hCWNBbgFVrJTCdNuU1QYlo/qg3NgB7/x3gp/2V3hckFLSIScOqe9TYDGlRkX+qYOB5v7Qr+Ha5Oah7KmmPkSDZzLCVAHRhdUSM05gtShVrrea/O5eRACMigNmBGpIBdNyp0W5XeNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103117; c=relaxed/simple;
	bh=ioJvhXZDfjEQt2ziDmXFW0nCeOZA32fi0+BXFuZXXMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tp9IoU4K9I0Yo6xXgwFB9wWipoiMrMO+7MciX4zmOnU+gArz2WJfBDQQMql4K60OeM1qq98p0hPBYYKGUYz1YJb3iKgrmDWzKOBbAMr5uvLnF72NhucrOoMWisl1QokTY4Bp9jGieQ/y3kn6SF8aebhF7ex7yEwOvH+Ne/avRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QVB3k91v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso2509654f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103113; x=1753707913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=QVB3k91vAt5X0x7iRt0ayPZUdtpHxi0kEISpq/TzDOoOAMe+qcBLAG6yGOdgvD9yfn
         wcpOik/5tVXd0S4lvue/vLRP5qqN/+NIhGZAGXjGKpat28krTj757muLMq/r4jSPcz59
         Qr/KicDF7glSrvUMZCZqAg9ivxuQbX1CZ3sizCZ0VaKQ+dlQkzFIN+qG4XGQ6povyN6+
         DTGAq2JJlMcOkeq9RCm9sHJK1a5SIIO7r3pbL/BqWNyYPaOR2TbWmlr9x1UObbtkPvH5
         HO7d01/+uS6Sb81tf2fPduyA5SHlJAVuNcdgRkHrWCcqZzofYHpxz2GXHMpRJIRUm6DW
         qrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103113; x=1753707913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=biqvpT97OON38D2erQjft0jegS9VR07SVDhCrnevwhUBrIC/9FkC3EsAoajJyOeJdt
         fxWoTI9sQaLj78EseyUBqi0G2CHEyRjOeK48HUjr+GK6Hi3JE+Kua/oPt0mI/ouxQ6hz
         jCH3QPDXHL8wjJuD818s5MmhlP9SmsqV67g29peAPfM6Xd1NzjVR+gsNnG9ugBvQ90zk
         ERXbcOcsfSY9Cu7RiLcUYDREw+nypjfaRgLYvm2NbBdfksfseCGTY0RN5WVkHd19I8Dj
         1XliC+dh4yaMUHgN0ofdj1qyoiyH8lSAH6twyfmoAJkDN89yz7jCMVIB5u/1zXPE6Mci
         QPkg==
X-Forwarded-Encrypted: i=1; AJvYcCXK70KtooMpqOVF+0NBLCNVVGvPQUVy9TICOczNL9F9xZeIe91+9gorqWo+RwBpJNqD6s1MSFq0zTtiOY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAG56otaAS7jh3JXpjWRPpe9CiYS+mWcR4JtCy5lf5vUmNV6Nb
	Uwb5yfY5U7L+prWlHA0jdG72JMBCUHpqZID3fqSMuiGfDEYF4fjIHeUb+sKEFbTiPe8=
X-Gm-Gg: ASbGncuJYW3D6QVPH65Efi56hO7pDbQYCdKap+5l6nYAjvF++mHQctxolu83LqDNK4O
	TJxehhV4suHOpVA4L4Z2BJSzB+fXo02KmnWhb2gQ6/n9mykM4kHXYKQUAqEZENzbwq9akfdpstj
	xYycv3bxP5KMgqLy8lgPsrYIZCOw6axNowuzIDrUIbGPrqcgSccyefc9DSikzPye+XciAgkVhqY
	UDr+/YdNsYsmFvCXOhCnMcywNqQG66aR9o6frA4owi63rHDKAhAGVQ6zFzq5KeY8bpoK3F/G7BS
	SP5/rKyg1k4JXy5UtOx35+MOKfRhv1Z0MzBGiXiJFSRCqywz+Pm8r9rYgB63c2ciIQzXW0B7wHb
	XbvTnR29gXi9uapLF5atAjnvMv+917Gs=
X-Google-Smtp-Source: AGHT+IGWq4jzpIhEdv6123LGkJS3kcsTALE6uCDdvRzPU6u7cW14a0/tv2JQi8/2wxRmO1WYzyv6ew==
X-Received: by 2002:a05:6000:430c:b0:3a4:d939:62f8 with SMTP id ffacd0b85a97d-3b613e984ccmr12134458f8f.32.1753103112960;
        Mon, 21 Jul 2025 06:05:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:04:57 +0100
Subject: [PATCH v5 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-3-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Leo Yan <leo.yan@arm.com>

Expose an "event_filter" entry in the caps folder to inform user space
about which events can be filtered.

Change the return type of arm_spe_pmu_cap_get() from u32 to u64 to
accommodate the added event filter entry.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 051ec885318d..3e9221a22a61 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -116,6 +116,7 @@ enum arm_spe_pmu_capabilities {
 	SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_MIN_IVAL,
+	SPE_PMU_CAP_EVENT_FILTER,
 };
 
 static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
@@ -123,7 +124,7 @@ static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
 	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
 };
 
-static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
+static u64 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 {
 	if (cap < SPE_PMU_CAP_FEAT_MAX)
 		return !!(spe_pmu->features & arm_spe_pmu_feat_caps[cap]);
@@ -133,6 +134,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
 		return spe_pmu->counter_sz;
 	case SPE_PMU_CAP_MIN_IVAL:
 		return spe_pmu->min_period;
+	case SPE_PMU_CAP_EVENT_FILTER:
+		return ~spe_pmu->pmsevfr_res0;
 	default:
 		WARN(1, "unknown cap %d\n", cap);
 	}
@@ -149,7 +152,19 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	int cap = (long)ea->var;
 
-	return sysfs_emit(buf, "%u\n", arm_spe_pmu_cap_get(spe_pmu, cap));
+	return sysfs_emit(buf, "%llu\n", arm_spe_pmu_cap_get(spe_pmu, cap));
+}
+
+static ssize_t arm_spe_pmu_cap_show_hex(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
+	struct dev_ext_attribute *ea =
+		container_of(attr, struct dev_ext_attribute, attr);
+	int cap = (long)ea->var;
+
+	return sysfs_emit(buf, "0x%llx\n", arm_spe_pmu_cap_get(spe_pmu, cap));
 }
 
 #define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
@@ -159,12 +174,15 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 
 #define SPE_CAP_EXT_ATTR_ENTRY(_name, _var)				\
 	SPE_EXT_ATTR_ENTRY(_name, arm_spe_pmu_cap_show, _var)
+#define SPE_CAP_EXT_ATTR_ENTRY_HEX(_name, _var)				\
+	SPE_EXT_ATTR_ENTRY(_name, arm_spe_pmu_cap_show_hex, _var)
 
 static struct attribute *arm_spe_pmu_cap_attr[] = {
 	SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
 	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
 	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
 	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
+	SPE_CAP_EXT_ATTR_ENTRY_HEX(event_filter, SPE_PMU_CAP_EVENT_FILTER),
 	NULL,
 };
 

-- 
2.34.1


