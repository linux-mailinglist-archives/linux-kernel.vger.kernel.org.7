Return-Path: <linux-kernel+bounces-895315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 653A0C4D811
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00B654FF773
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA55255F3F;
	Tue, 11 Nov 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDZqaDiq"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D3357730
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861117; cv=none; b=pVZiyHOhdZF4UsIqNzLmzzvJFS+HqNzvF5CKy+UmUSToUhNiMtL6krVnh413qVRFcCw8+NhhTsDW9HxLiprtCmExjioxYSNvEJxdHVlCCrLfCsu3UXupzZBDQ2L0lJDHH7M/bRwDs4o5cTSF7mxaB2gJnddaQu4S/BKUQXn/9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861117; c=relaxed/simple;
	bh=wuWGqKWZZ/BTt5fqv81cBQwVikNNCsOKo8cdQBD/rvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eV06s6RsHz2LtH3/6AYBJFW8COBhh56xadKnG+PqiamD4GqQ0VOx91VUcpeT764lyHho5LG71b0gl4yrI51H10PPaKOdNwKW/1IWTHWDiKBRl/84q/sdgSvj1g2J0udJGKZFXAvIoanqiH44bu/knB2xDYfBWKliFaKFQ8nPEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDZqaDiq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so30698685e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762861112; x=1763465912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwCuT4qpbf858s5dq2pagCIko/kgMzJ+Cwp9chp+q6I=;
        b=lDZqaDiqywqaaZM1tvO7QMn2TkJNGsZeP1loG17uERUs4YpjthLT595dVZI5knXpnG
         kbfPOwSLZs0HlrWb7AdpLECAc633vMjUUtGaSIPjiircdaK+vx2g+YEeovY3wM/Vc+gY
         ExXVlZ+8tiY/ptvTZcInbVoChjSoTwon5LuV6M6RWtCgvbpHOB5GdV6CgXTw5LyoApSM
         2fd7FaaNY8X7J/RdYAxKmUDLDyfAbmHbgGDvhLiByYfJHxicIHkI/Pj0X+VXBttYC4l7
         4YyqUTGr/91mzcWsizlmEDzOj+OgZlaGVYZuNcQ6zMHBH2n8P2R4M5/GerofXWVDU52L
         smdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861112; x=1763465912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gwCuT4qpbf858s5dq2pagCIko/kgMzJ+Cwp9chp+q6I=;
        b=cENDhwpfBJGrfEnPo4jaNNL4FtCaIsSDQHICeCteAoXAYYu6P1g1RjU2A6CG5MI0yt
         J5JgQnyM3MqjJaTDf516n7Bsk0y2ztA0hpguf1caf19XX1b3qRqNwgh+bVldck0PEtp7
         9mauO6YREPuLAcEDtc3qkwB/vIIMOsI84A08azjGUB21IF+doDVsjwGAYU+L+vyIqPZn
         PfXbRzEGCDpS7i3IZ+fXHVzzIl+qYCSvBTEkPolOWxGb7GcAj9d5Hu5KNt+iVmgulumX
         qP/URq33TV00YP/TK2Cjtz1Ikb2a1N6SEN/eSOMPll7HONmEjrPd+QnqsVxbD8PE+Ih5
         9Fsg==
X-Forwarded-Encrypted: i=1; AJvYcCVmOeYwCYggNiGEq2tL5CfhofIHIjURF4RPF1KxzpDzX5VXQcMKLZuxewe1Fl1Am/28baywyh/7a0kkzcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15TpvcTULdWG1HXivODIvSfOUoMgf6P9bQVkC4wRRfS3NI/nK
	iwZyH02KD++3eW4wiCRQKID4fBlDNNkjUSxXhyCKvlmjOEU74ur93kkHPIiKdWJxMSo=
X-Gm-Gg: ASbGnctGBJrPXeRKm6lIJag3RTJyWwMg8oyqqarMftVHGbKpIbwbn3hEl3Bi/jwTZyg
	8/T7Qei3nqRPB0eBUd2OHhuBCIbhtj+TYr9UPB96Di9w/bCgj32IGMfN8P7SGo/hYqwnTdtTydV
	E6mstROh+abWUyo+VBagnj9c5gsIj30zHZ23nl13TPeModrp4TsCWGmMsgn0s6YBnvu7j2pfytQ
	QHa2EEXpDl3i2Ziheo07as+mf6Lohb/v1B/aHh/L8kvZvciTuykR1UkeaYQumKrHVjXKPly8ubY
	bpm7mqWIrJsHXtbRQQhMlWMkEDayb5++LOoQSii1wHqm9xJEQ5QfVI/CdH7A6VTrj5/uL/LwmQd
	trojYYG9Bg7lR5uvJGwXzF+ie26bXdxSoIxjDP5sZUF3WACIZ8Ht+CT7L4RbIM3QBSNcT7onD+Z
	PDEMEuOBiVkg==
X-Google-Smtp-Source: AGHT+IHoaAdyno4PCEkIfLITG0AGBI1bC/mX+D1DG/Yst4Q/794Wn0/d79DNOynMvzJ3hrqergaE6g==
X-Received: by 2002:a5d:588a:0:b0:42b:3e20:f1b4 with SMTP id ffacd0b85a97d-42b3e20f5bdmr5248092f8f.5.1762861111797;
        Tue, 11 Nov 2025 03:38:31 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675cd25sm28133486f8f.22.2025.11.11.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:38:31 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Nov 2025 11:37:56 +0000
Subject: [PATCH v10 2/5] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-james-perf-feat_spe_eft-v10-2-1e1b5bf2cd05@linaro.org>
References: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
In-Reply-To: <20251111-james-perf-feat_spe_eft-v10-0-1e1b5bf2cd05@linaro.org>
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

SPE_FEAT_FDS adds the ability to filter on the data source of packets.
Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
when any of the filter bits are set.

Each bit position of the 64 bit filter maps to numerical data sources
0-63 described by bits[0:5] in the data source packet (although the full
range of data source is 16 bits so higher value data sources can't be
filtered on). The filter is an OR of all the filter bits, so for example
clearing filter bits 0 and 3 only includes packets from data sources 0
OR 3.

Invert the filter given by userspace so that the default value of 0 is
equivalent to including all values (no filtering). This allows us to
skip adding a new format bit to enable filtering and still support
excluding all data sources which would have been a filter value of 0 if
not for the inversion.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645fedda..617f8a98dd63 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -87,6 +87,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
+#define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -252,6 +253,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
+#define ATTR_CFG_FLD_inv_data_src_filter_CFG	config4	/* inverse of PMSDSFR_EL1 */
+#define ATTR_CFG_FLD_inv_data_src_filter_LO	0
+#define ATTR_CFG_FLD_inv_data_src_filter_HI	63
+
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
@@ -268,6 +273,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
 GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
+GEN_PMU_FORMAT_ATTR(inv_data_src_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 GEN_PMU_FORMAT_ATTR(discard);
 
@@ -288,6 +294,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
+	&format_attr_inv_data_src_filter.attr,
 	&format_attr_min_latency.attr,
 	&format_attr_discard.attr,
 	NULL,
@@ -306,6 +313,10 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if (attr == &format_attr_inv_data_src_filter.attr &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return 0;
+
 	if ((attr == &format_attr_branch_filter_mask.attr ||
 	     attr == &format_attr_load_filter_mask.attr ||
 	     attr == &format_attr_store_filter_mask.attr ||
@@ -430,6 +441,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
 		reg |= PMSFCR_EL1_FnE;
 
+	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter))
+		reg |= PMSFCR_EL1_FDS;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -454,6 +468,17 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
 	return FIELD_PREP(PMSLATFR_EL1_MINLAT, ATTR_CFG_GET_FLD(attr, min_latency));
 }
 
+static u64 arm_spe_event_to_pmsdsfr(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	/*
+	 * Data src filter is inverted so that the default value of 0 is
+	 * equivalent to no filtering.
+	 */
+	return ~ATTR_CFG_GET_FLD(attr, inv_data_src_filter);
+}
+
 static void arm_spe_pmu_pad_buf(struct perf_output_handle *handle, int len)
 {
 	struct arm_spe_pmu_buf *buf = perf_get_aux(handle);
@@ -791,6 +816,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -866,6 +895,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
 	}
 
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		reg = arm_spe_event_to_pmsdsfr(event);
+		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -1125,6 +1159,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (FIELD_GET(PMSIDR_EL1_EFT, reg))
 		spe_pmu->features |= SPE_PMU_FEAT_EFT;
 
+	if (FIELD_GET(PMSIDR_EL1_FDS, reg))
+		spe_pmu->features |= SPE_PMU_FEAT_FDS;
+
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {

-- 
2.34.1


