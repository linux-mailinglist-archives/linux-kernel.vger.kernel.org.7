Return-Path: <linux-kernel+bounces-794577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB2B3E389
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE216926A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812D322DD4;
	Mon,  1 Sep 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s9FZoOfx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD103101AB
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730516; cv=none; b=GwUq0DtiukjyeHleFdhH1sRc+IcGQ6djLoCJkyrPnQYjNkK/ICFtyTBxG5EHZrwhd5wjZSJQTvlNWsyuEIr2+ltzMi0m8HPTFzyjYcFt3wDoLruVk4vU8+pPM2GKZzPpD32zyyW+TdMtFRVzSbSItnzC7swzglv6BuEX8aKYv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730516; c=relaxed/simple;
	bh=1dn2TsDH9c3qn851HU6KhoRjFDuyNupOzJtkpyRLaL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLU/hYBGJWFjIAupBMbJaR8IkZNiGoF0u2LO+uI0lADUv5Ip1QgitIc7yFOcaNESRsx3Ad5aOJubUoW3cvBgWm/k9S6rYws2JIbqKU/5EPZ0zWZ0Yfh5SjrfxrewizjpBXH2dptydO/Ik9BinzzeDHr84DqcVc/12oFSG7p80N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s9FZoOfx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so9442635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730513; x=1757335313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rccDGxo7Zi/+ePrAmZStYRWWCBeSec1uJGq7oyHErE=;
        b=s9FZoOfxxCzWkIyetl9yZTurTTiqZnIDBztZWxtN3g1VERZXI/I8fgyqkXb1X4prB6
         VrxPGcEPoDVHYxOFk9ZZ+7nWwsB95fs9vl48ziCAsweYytdZFZRfTd0pYyLwaTsoNgBJ
         gFpbtgGwQVNlLrSTjPpx1MWKuTiiwMzDCV9JK+jAzt3DwlOtxJ4h7o4Z2tVPAz3Vk5QJ
         WB7jEqlCdZ2Y4oiVIRgc0VXi6Ri8YmbidLzw9ejs05bevqwkQt7pwC3wzwU7Zlc+5Dri
         LoVv4+yuHdlh1DL2Dybmu9m5nYoqIcENLYYxk0b3OniejBljVibF1zpiT0EazFtBD2mU
         p+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730513; x=1757335313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rccDGxo7Zi/+ePrAmZStYRWWCBeSec1uJGq7oyHErE=;
        b=Fsp5tQC1APRsnE1V1C5odlQe3grnp0awzC7ynuAWMiNYhxDgJ7W8EsRjHFO7vPQhkF
         o033b210CVQaq+OayDQvumKor1SL8lKWMO10t+xVo+Ws3SlVwSK8GfCvt8WBcSLsfEkJ
         PXOcZ7UtiiKIKWFBWwlxGvtHg73b583GOTGWdT/iNcjA7j8Kqw0gahU15LTU1QdxP/s0
         W399AgKhylQPFSwnHSTyjzOfZLZvT5VRBP45uQP7cihhiUlFcs+gOLB+tTcpePAF0EfL
         eRpgV2m4FHt7KZ6qeT7zU1JYWn/nOGHzjSbKyuKd6MaMTnQlokYPRbddHva4ohqwvon3
         cPQg==
X-Forwarded-Encrypted: i=1; AJvYcCXicd/OYoo3ClPB+PckDFF9nA//11x/JUr82nEhrPs2wKBXwJpo5zvJ4+O4YVPLJGXgAYNgTwrncddl2sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGweLfrtbFUJujSt/hfnzIXMhNfYtlQ4kQBzsltnONHNdEGivN
	+P9YvAnBL5SuHIQoOaymHYU6c87dpaA1f+W6/lRBhr70m2BNmgMOglIP9ns0CzleK8w=
X-Gm-Gg: ASbGncu5iZKnl7vq/VQB2cXXeismYNvV24kHpI4pjXQVrQJU1zgThfVYc+S1oo1IQH+
	e8lcPkmZsEdGieVv5xZchUPzoO4oSnjLTcBGbF8ZFkTCTU0XoCguRUlDA4uOTMQbQrmnsGMheP1
	bJJxZ/38CFFw7/uQNIIF2scT/9VXh/vVvKwoQ3yw2Sv32tEfXUba+DnagJ/zC3jxDi2u89h08y4
	Z/tfCqvXs0SS89LUR9q/TRQl0CvyZ3fKE2F+jpspHgm0/xTWA5VPTKSjqCRqPo8W0XkIBK/1TUf
	maDP406X7IF7avzWwlcq0yAxlUwOX9CvpUjAUx31oQ7iUJRY3otA90zpR+tqiiyjthANHZ4eErq
	ZCcfGWZequcBysEkJOsjbE3Cjzv7xBrs=
X-Google-Smtp-Source: AGHT+IEiJacQeJIhAlVFIVb4gBUFN/ZD4+BtNn08VuvIydbSJk4ZmQ+RW5QdnGmgopAeFlemw8drNw==
X-Received: by 2002:a05:600c:4fcd:b0:459:db71:74d7 with SMTP id 5b1f17b1804b1-45b8557c8d1mr55430795e9.27.1756730512680;
        Mon, 01 Sep 2025 05:41:52 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:32 +0100
Subject: [PATCH v8 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-3-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
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


