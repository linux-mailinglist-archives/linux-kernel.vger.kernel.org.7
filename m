Return-Path: <linux-kernel+bounces-739292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B266B0C47F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F44E524D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722142D7805;
	Mon, 21 Jul 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1cgsCi0"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C862D5C99
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102457; cv=none; b=Rt81th3Kx8cz4EzDeUF20CaBZUrnKfhnkmJlg/P/jW1QHyQSfAsD56VeIB93Jrd0FXkoMy4WR5s1HAK+HF9p70dvncT6aT1XaxrWSZ16B92xZdzj5Upe0oAKxpWiA4FQfpDe+7rd4Q3YdQ9Nzva37BLoHDYBV82JzSoAMXf9Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102457; c=relaxed/simple;
	bh=ioJvhXZDfjEQt2ziDmXFW0nCeOZA32fi0+BXFuZXXMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bovUPvlcn2yMZDD+/I3tSuWa5qArnDFFOXQfl/hw0sIzLsXPSZ9it8ICO/IkJc4IBUuq+cPxg3GVZl2auEIpbCvsczunb1hNCXwDD3XOt3cb0yE1uex4VbxVHruJo5SOUQUSDEdouNTzflZoU2nBHgBAkbq2kUdh+DBO5kfepaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z1cgsCi0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3474484f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102454; x=1753707254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=z1cgsCi0s6WiCo3cL702Oe6ZP+35NGH4GeLe+w9fvprnljAXgta7Uq4hutaJlBhu+K
         7iU3k4I7YUAvhvEDYHEvvQll++jZxtGDuiCbPEq5hFMTltnMFVuEky7CqcLSCRpz6wse
         w2Kvg1SWGSizxvhDgaCCX0ZCo/q3xfw96VojBgcoxlLg50EbRgTnhrVmEQlpDepjLyZP
         iCdQ8Ki3bCPlZoNNxnw8PSkxW+GV9jzzKq0NBsXtc0ul53jtFptcwtiSXjg5+2TvKGoO
         /z1I+yE2Cv0dKglgyBt8MNcADVPg54KgzukROjlWJS+ZYXPUME6Y8RJqbK54XHdpUZek
         8rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102454; x=1753707254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55PgdiB+GN4B/bQE+c0k9cxCNgbWScuraMcZpMP7YeE=;
        b=gPxmT8dTpbJCjunabu/FyGBtVvG3wQ2jf7y8SCWbWbKktgCCw5ANXrz3fWhESjS+FD
         OmlyH9AJk3fkFFZJ+ZqSuXY9FT6oAbF/FIPdOQ2x34N6kjufiak3PFlt2LvHHpR7L1UJ
         xrehK1JoGMcBjQBzX544WLMVdjU0URsrN0HyfvudMuFUJ5nDZYe3i4BQT8GbUvHyVEhw
         KBYyjxNzFLL/7k3rUUgBwUNCyzt0m7RoGJBbMWYcNpiKUUkjYrp+qZnK65CA8DH63fee
         x1FiD3/fy6lglb9a9Lmi7zaZ+9ewCzU98pS4yrFcd0uTzDYCsFU0xuZz9mwTq3ESGzoR
         c1PA==
X-Forwarded-Encrypted: i=1; AJvYcCUtlz3kyD10CRiiqUMdU6ijpKpzcx1M+IdEhlLZWvc5MQitU8v3HgeaI9AXVtWrVzvgJegah3AS8NeBfyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzlbfze74jEVypKFjEfMZFSqiE3rYmX0fGPWDreMRhUfreTBtQ
	oOQQa2TkK5pH604idf2jT0xuMTtTe+SQFcPBg4RezDHzbr0A0wiMRCY/kl/xumlJ2pE=
X-Gm-Gg: ASbGncv4hxDW6lxsXm77kfct0Q76dhxK3UnPSaJXewvpi6io0/KbnxMnzZQ7jH4SY9W
	6cLEFzOp9w0BkMfO8ZZ2tHI/xdCl0+sBzhYVjx37n7Fy5y4jEGT2yZrm7FkPQIE4SnDfIPabayz
	Ohra1IQrNQk4ox108cFCtuqvbueW4/TcQOcuoXfp+PKZYiSflBdsJjpIPknRfEHVOAQ0q/wEZvo
	4BxZN5RBsCqul8O0z45x8wvL8SiiG6GSwVpB5H58Pv6iJAJMmetuuVu2CFKfTNPRquir8jxvWAZ
	ahGT6nmG6ceqZ+YXm2HJnYY7bmpTZnsO2lbYzOqzlZkKnQEUyNimGjzQoDz2kHDN/ZNKyC92p8H
	N4XOtN38umVPWJapwCYS+1bKMqzRXxm8=
X-Google-Smtp-Source: AGHT+IEL8PHgJ4SopjgITysCZQMBksfX7qBSxWXMtzthfbfPyv1+5wLWmZAb1M4QE19p4pJCh7/Zmg==
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47c7 with SMTP id ffacd0b85a97d-3b60e50ff6amr16938260f8f.48.1753102453767;
        Mon, 21 Jul 2025 05:54:13 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:13 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:34 +0100
Subject: [PATCH v4 03/12] perf: arm_spe: Expose event filter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-3-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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


