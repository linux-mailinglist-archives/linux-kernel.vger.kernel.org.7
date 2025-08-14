Return-Path: <linux-kernel+bounces-768420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E42B260E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BAC2A3A16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6912F39AD;
	Thu, 14 Aug 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwh7yeme"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221212ECEAC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163565; cv=none; b=M+PR8LvB6KMjfDI16loPTaCaENq5wuHMZhrLEZOux8KKr1zBGqCB2oGjvm5ZG/wwVSrfGgTeV/5+ChhHqC7biggjSOLcCpnLxnfPktnE1SkhqFrU3lKiycEIoUU5Cgny5BGqlazInvaNQTiSMneyVav5xLBtIL8RS1XdMFPypUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163565; c=relaxed/simple;
	bh=1dn2TsDH9c3qn851HU6KhoRjFDuyNupOzJtkpyRLaL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7LPzRxlcbkDXdDsJwnXv8AOpPzD3eN6gLcv8RlLyL/ZXoxRbaU2a4xdzfjEH2PuwiZAWyZNmWH2yW4L/IwQn1kyu136JRBYbDVEgJmeCww4Num0UrDESriaN9V8sRCa/+faQnNTiUlkvLwNhdY9CHwZmnrsgfhUNA/dJiHhPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwh7yeme; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b005a3bso3357495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163561; x=1755768361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rccDGxo7Zi/+ePrAmZStYRWWCBeSec1uJGq7oyHErE=;
        b=rwh7yemem+hPFddbg7RvodRLRYiNXJeyUlZS14YQGE8HSCOj3ZxdTHJTzplzD4ghJB
         F1pnjA9Ri0x+5+1J4KJRq00yf78V1lfmjQUxrDAQ52845Y/SrAD/TnGKIu5FWWYuK9ya
         iDEaW44r5Y032/ZOCS7x0GpnxZqmmZAeBs3KW8T6uqkHAex/70s7uWnyloiQnWdvNLXs
         h6pRRAyhmzreNVvCLUW+FGgerBs6zYoIxRtUu3NLOqDRIyUrotxzsY8uuWgxv8rjUI4w
         xxhZlSbHOhfD7CmopAv185PGli3V3oN/QbPzKwKa2eGnnQNDPUfNbJIcd/0PLyTR2k+p
         U47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163561; x=1755768361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rccDGxo7Zi/+ePrAmZStYRWWCBeSec1uJGq7oyHErE=;
        b=XusAlmTUolTSi5N+ONedJIhnNSw1oTG0tgVYP840sT6MmCedyMvoq78xEQ4eaEfpCj
         wAfa9Or++PtAdaT2wYsiU0f1spSMrwXL3E7Ue7O4sNwe7QFhhLLl8hlVoMhBwyssUw9O
         VvR0852w+EBdiZ6jmxd2Fjtq92H30tGfSWghY/0fW7Uk9ihRoZWclUGkkcZFLa9Uz0Oa
         Q0BTq0pDFeXHir7HD2Nsa5glfJo/l2wZ9Vbcvft0cNuz3W8Dkn1lBcaBgO/A6PX+2NCz
         Xe3LTGcDZx0t1m5ifyHj2WqNlRczkwt9faVYf8rsUlBGb2290qitdZhHhrPrI6n8JGRt
         aKYg==
X-Forwarded-Encrypted: i=1; AJvYcCU9FNalQqau72C1jTazR6Crd75zh39h206Wa2IfumXBcQy/lPOOSa2wqfEFpuGsBgAjc1iUUHhfj24QjEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RlzcSmkgoQ3V+Qt7EnmdxuY2zRxPhRr0lOru0l6V4eonGxkr
	hXmAlFShrbOE7MArRqhULaXBJKnS5RzS+lzkNezoEOoa+5GfMSySPBIySVHWGJvlHq8=
X-Gm-Gg: ASbGncsIqJHO5fSTwSm7in0NM5tVQ5kefRoMljdyJPhx8aMAVXRosjaUc2SJItKWJg6
	24iCRqWGNd1ERQPSwf0TUTHLNgB17ui70gCPPdioIK3R5SK9L6tUWJWZ1oO7Y8xcgxgzbxT6PJ6
	NUhgJKbqibGX8cl5CEEYOTp5244PYFnBHYxUlYqtnIj4b7Pp0ebCBxjh5l8Gc9OVLXllHFjwL7q
	bRE4iZYbSEIxHaQSebXA/qUCI+daT64U+LDBdtWN9qzoaBHRUCGujHh1+PTa+Lk2StRmuD0GL/T
	g3qL9daQ5NNwrrVRW02CEpT7gB8pSIo2PBe6IrbCKrFgDdxRkzS7HskQy5E/gkOAlq6ZcNjol6j
	s1NCJyrhkYVdKqw4OWZ4hDDglg2XO4x8=
X-Google-Smtp-Source: AGHT+IF3mN9YM+z59LW2L2RCIJP1151F1ryrxu3DBo1bIpBosGzWHxhnT9S0+1q8xFvPjiRKK5C0xQ==
X-Received: by 2002:a05:600c:4705:b0:458:bd31:2c27 with SMTP id 5b1f17b1804b1-45a1b6535bemr16452535e9.23.1755163561367;
        Thu, 14 Aug 2025 02:26:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:26:01 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:25 +0100
Subject: [PATCH v7 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-3-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Leo Yan <leo.yan@arm.com>

Expose an "event_filter" entry in the caps folder to inform user space
about which events can be filtered.

Change the return type of arm_spe_pmu_cap_get() from u32 to u64 to
accommodate the added event filter entry.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 86c9948ab5a0..ba55bc3db708 100644
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


