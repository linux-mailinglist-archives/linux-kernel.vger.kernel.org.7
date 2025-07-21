Return-Path: <linux-kernel+bounces-739294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B7FB0C482
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255FE4E2C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254452D838D;
	Mon, 21 Jul 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8ZJ38MG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38622D6610
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102459; cv=none; b=Jri52Tw986fqmm3zgcEFEZ4Tsu/wYtzuDtPFb7nXjUTCEDzZ+Pr89oc/GV9ZFwtz721Shwj7B3PjfBRajo+nZqmd1invStYYfCbCGm3F5LsoeVMi9us2DQnX7cIVXpXa1acPbcuzXdKbkiyTA9au0oTwGHlyVba6vtNKlJIzF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102459; c=relaxed/simple;
	bh=0lvW3KXNc6coCfrtsL0oIans0QG/77+hgVWwOlpuVDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kUFHaTWI5onK0hf63u9Zs3V7IzTJe8McAndj0WCfUzjNqBtDOMtjioWuIxF/HTlgDXYYAEhInzXBsPKAVZR473VBXoLkXkAdQ9FirgfnZKjlYxyCSPfwDSS+AKDDlQhgM4M+s8NPvlQKHkCLIlWN050dxahYIqkYf8E6ZedmDXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8ZJ38MG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45634205adaso20200075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102455; x=1753707255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjhDYf9y6EuvwS1bzG74pgfv+zF3H7PqlliS5Dv+cFI=;
        b=Z8ZJ38MG+h0WpkGwPwfMVmGdNmklevPvcDBAeBhFcdLHGAaq9tuemarjHRrnv+fzAl
         iisTnhuklegUVTXgW7bv0bdK2d025IHuwtbToT1Xw7oPorG4dxMVaL685PbFYDUFvMZj
         FNh77Tu9+DPTinbVsMX3DAxKXUo2NIVTUiYWcF4tBFvG35J1PQ56N5xZOB/mJyvHV85w
         cEQUBM/05W5DXgcApvNSA9U+waXQYjSaHyxtsq0eOV78VDW8ql6M5VXylM0NEme3rr47
         XGcM240lebkGWjhUQDl2Ytn+rwulfIEFfFvjrMGM/hqOGdt9oArt0mupauA2IK82tH26
         FqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102455; x=1753707255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjhDYf9y6EuvwS1bzG74pgfv+zF3H7PqlliS5Dv+cFI=;
        b=RWWPr+FYF4TrG1VUIC8H4koUWtHyzsYqf0O+j3ZI7jNt554AiuZQtKLi3Pq/cCoDy4
         hMRamhDh054d+EgchNdGdLbWyVMmwredgxtkDuF6PG/pg+3PqXlyTn+Y6CHi9QOSyG5S
         k/O1RgnqPg5VIWMFxWV2DPoqsSEKvMgQ80V5R4GWdfiycNLcr9eJ7wtoMS6r2mlLrxj8
         Z/bmW4DIVM953t+zY6E+asWx49L8JjB53Y4vWjssvQPBw6huP9W+hd9xpAGyQ10p9Ezr
         UeB9s+flBRuw0wYezHBuSDXlS6vvr9KvYybHhqvObbYaQk8ExH+QgXPVhGRalPPL+iOu
         F/vg==
X-Forwarded-Encrypted: i=1; AJvYcCXFJsMkLWfdMlUPETpWdKWD5pFUTGcAW25k61F/TU9Zhsc/9G4+g/9OKcSaLgRliSS4j/AboGhsBuF/zyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYr7wmJzqSgLMku5p/xu3tHPJzXTXTG/o2PXJ8hCKz1iQSd+Rs
	RqyM3gcIjh98VZWLjhtT++vsWPdpu7uIlUjyPkCdsq0lUnPv1xtTqIuZPIf3gUAq/js=
X-Gm-Gg: ASbGncsrtSeRNZb7KdNl8QpIc8/wkoPJD7Kq8Pk6fjuw9tqKYP+D7XIQOlOicmuKFfL
	YbeXnw2ZerWsCR0/p9+LGN9HhrkwxRpfJqREdokmY3FB3BZ+p6tl8o+BY3LSJuvBf7cUSLASilQ
	wUD/lbAI7RAPQzI6g32tcCtlHQvft3Jj0BucVYdTCGF5KfIPljbADhWWD2WsTX8BrGAcCIfg8KN
	y6xlkD7jHmULZ/vtcYoAWd5CAFfIlUN4s3ENeQraJpi/rh/ArxpGArhVZyctm76FjuMIAXzCWGV
	AU5O9jX6XYjLyty7zU90cIG0Q5Zghm8WukcM1Tbrz35StLxi3CwE+tCdYxNAvGEiECOmVIH/ewh
	zhq0eKJaCNJngyDCS7Jq7EQIArPWzDME=
X-Google-Smtp-Source: AGHT+IG0Lqf9JLdc82VseKoNnxJV0uPpL0xZ6qrFtfBWK0QI1+SxXgCPXtiSz+6Y7bCTGmIfLohdig==
X-Received: by 2002:a05:600c:3481:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-4562e3c4b8bmr160735325e9.25.1753102455100;
        Mon, 21 Jul 2025 05:54:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:35 +0100
Subject: [PATCH v4 04/12] perf: arm_spe: Add support for FEAT_SPE_EFT
 extended filtering
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-4-0a527410f8fd@linaro.org>
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

FEAT_SPE_EFT (optional from Armv9.4) adds mask bits for the existing
load, store and branch filters. It also adds two new filter bits for
SIMD and floating point with their own associated mask bits. The current
filters only allow OR filtering on samples that are load OR store etc,
and the new mask bits allow setting part of the filter to an AND, for
example filtering samples that are store AND SIMD. With mask bits set to
0, the OR behavior is preserved, so the unless any masks are explicitly
set old filters will behave the same.

Add them all and make them behave the same way as existing format bits,
hidden and return EOPNOTSUPP if set when the feature doesn't exist.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3e9221a22a61..e69a0d170702 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -86,6 +86,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_ERND			(1UL << 5)
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
+#define SPE_PMU_FEAT_EFT			(1UL << 8)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -216,6 +217,27 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
 #define ATTR_CFG_FLD_discard_LO			35
 #define ATTR_CFG_FLD_discard_HI			35
+#define ATTR_CFG_FLD_branch_filter_mask_CFG	config	/* PMSFCR_EL1.Bm */
+#define ATTR_CFG_FLD_branch_filter_mask_LO	36
+#define ATTR_CFG_FLD_branch_filter_mask_HI	36
+#define ATTR_CFG_FLD_load_filter_mask_CFG	config	/* PMSFCR_EL1.LDm */
+#define ATTR_CFG_FLD_load_filter_mask_LO	37
+#define ATTR_CFG_FLD_load_filter_mask_HI	37
+#define ATTR_CFG_FLD_store_filter_mask_CFG	config	/* PMSFCR_EL1.STm */
+#define ATTR_CFG_FLD_store_filter_mask_LO	38
+#define ATTR_CFG_FLD_store_filter_mask_HI	38
+#define ATTR_CFG_FLD_simd_filter_CFG		config	/* PMSFCR_EL1.SIMD */
+#define ATTR_CFG_FLD_simd_filter_LO		39
+#define ATTR_CFG_FLD_simd_filter_HI		39
+#define ATTR_CFG_FLD_simd_filter_mask_CFG	config	/* PMSFCR_EL1.SIMDm */
+#define ATTR_CFG_FLD_simd_filter_mask_LO	40
+#define ATTR_CFG_FLD_simd_filter_mask_HI	40
+#define ATTR_CFG_FLD_float_filter_CFG		config	/* PMSFCR_EL1.FP */
+#define ATTR_CFG_FLD_float_filter_LO		41
+#define ATTR_CFG_FLD_float_filter_HI		41
+#define ATTR_CFG_FLD_float_filter_mask_CFG	config	/* PMSFCR_EL1.FPm */
+#define ATTR_CFG_FLD_float_filter_mask_LO	42
+#define ATTR_CFG_FLD_float_filter_mask_HI	42
 
 #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
 #define ATTR_CFG_FLD_event_filter_LO		0
@@ -234,8 +256,15 @@ GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
 GEN_PMU_FORMAT_ATTR(jitter);
 GEN_PMU_FORMAT_ATTR(branch_filter);
+GEN_PMU_FORMAT_ATTR(branch_filter_mask);
 GEN_PMU_FORMAT_ATTR(load_filter);
+GEN_PMU_FORMAT_ATTR(load_filter_mask);
 GEN_PMU_FORMAT_ATTR(store_filter);
+GEN_PMU_FORMAT_ATTR(store_filter_mask);
+GEN_PMU_FORMAT_ATTR(simd_filter);
+GEN_PMU_FORMAT_ATTR(simd_filter_mask);
+GEN_PMU_FORMAT_ATTR(float_filter);
+GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
@@ -247,8 +276,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_pct_enable.attr,
 	&format_attr_jitter.attr,
 	&format_attr_branch_filter.attr,
+	&format_attr_branch_filter_mask.attr,
 	&format_attr_load_filter.attr,
+	&format_attr_load_filter_mask.attr,
 	&format_attr_store_filter.attr,
+	&format_attr_store_filter_mask.attr,
+	&format_attr_simd_filter.attr,
+	&format_attr_simd_filter_mask.attr,
+	&format_attr_float_filter.attr,
+	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
 	&format_attr_min_latency.attr,
@@ -269,6 +305,16 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if ((attr == &format_attr_branch_filter_mask.attr ||
+	     attr == &format_attr_load_filter_mask.attr ||
+	     attr == &format_attr_store_filter_mask.attr ||
+	     attr == &format_attr_simd_filter.attr ||
+	     attr == &format_attr_simd_filter_mask.attr ||
+	     attr == &format_attr_float_filter.attr ||
+	     attr == &format_attr_float_filter_mask.attr) &&
+	     !(spe_pmu->features & SPE_PMU_FEAT_EFT))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -360,8 +406,15 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	u64 reg = 0;
 
 	reg |= FIELD_PREP(PMSFCR_EL1_LD, ATTR_CFG_GET_FLD(attr, load_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_LDm, ATTR_CFG_GET_FLD(attr, load_filter_mask));
 	reg |= FIELD_PREP(PMSFCR_EL1_ST, ATTR_CFG_GET_FLD(attr, store_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_STm, ATTR_CFG_GET_FLD(attr, store_filter_mask));
 	reg |= FIELD_PREP(PMSFCR_EL1_B, ATTR_CFG_GET_FLD(attr, branch_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_Bm, ATTR_CFG_GET_FLD(attr, branch_filter_mask));
+	reg |= FIELD_PREP(PMSFCR_EL1_SIMD, ATTR_CFG_GET_FLD(attr, simd_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_SIMDm, ATTR_CFG_GET_FLD(attr, simd_filter_mask));
+	reg |= FIELD_PREP(PMSFCR_EL1_FP, ATTR_CFG_GET_FLD(attr, float_filter));
+	reg |= FIELD_PREP(PMSFCR_EL1_FPm, ATTR_CFG_GET_FLD(attr, float_filter_mask));
 
 	if (reg)
 		reg |= PMSFCR_EL1_FT;
@@ -763,6 +816,16 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
+	if ((FIELD_GET(PMSFCR_EL1_LDm, reg) ||
+	     FIELD_GET(PMSFCR_EL1_STm, reg) ||
+	     FIELD_GET(PMSFCR_EL1_Bm, reg) ||
+	     FIELD_GET(PMSFCR_EL1_SIMD, reg) ||
+	     FIELD_GET(PMSFCR_EL1_SIMDm, reg) ||
+	     FIELD_GET(PMSFCR_EL1_FP, reg) ||
+	     FIELD_GET(PMSFCR_EL1_FPm, reg)) &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_EFT))
+		return -EOPNOTSUPP;
+
 	if (ATTR_CFG_GET_FLD(&event->attr, discard) &&
 	    !(spe_pmu->features & SPE_PMU_FEAT_DISCARD))
 		return -EOPNOTSUPP;
@@ -1054,6 +1117,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
 	if (spe_pmu->pmsver >= ID_AA64DFR0_EL1_PMSVer_V1P2)
 		spe_pmu->features |= SPE_PMU_FEAT_DISCARD;
 
+	if (FIELD_GET(PMSIDR_EL1_EFT, reg))
+		spe_pmu->features |= SPE_PMU_FEAT_EFT;
+
 	/* This field has a spaced out encoding, so just use a look-up */
 	fld = FIELD_GET(PMSIDR_EL1_INTERVAL, reg);
 	switch (fld) {

-- 
2.34.1


