Return-Path: <linux-kernel+bounces-739327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11593B0C4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79271AA671E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83662DE6E8;
	Mon, 21 Jul 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cBeYcOTK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8052D8DD6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103125; cv=none; b=cvGBn9Nr12lJMFgZeekdeQHESEMAuuibVlAUWD3vg1SV2n3nDC9+jPeYlyI28z81zGwIh+CkBmkA27X2AzgC8IOEkkd/fkSvhE+yJ/UgOA7AbDy1sBTjo5Tf7TSmHum03wYZmwmBoeBe3eZiZppc0ItxBlVyc+o4jN5XA3h+OpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103125; c=relaxed/simple;
	bh=Gadj83wy4unursiBjFtgA2eyEqAMFePNrTi88fqMsXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S/2zXR45RIAW6LMESgtzd6ZcAnPU7TL4hZLhvKSITxIBa2BJNYcM3s6LvJUUIUOwWI7Mz7NnEjNI3TYarAhlGoJ0JbYmW7icnJbynw9kRSMXljSfFNgQkHy56O1/2UOFMMt0v2gF8UDT8I54pVOU10GWPQfDBgRYZFfaJSOPY7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cBeYcOTK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a54700a463so2408567f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103122; x=1753707922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lWHuVE1EgR5wLSuZVPObZK1oCh3b9sh0cLYRdc3oQUo=;
        b=cBeYcOTKr+41ENx9Lzn1gvGpZg+1eTi7/gzRywfHc5btAQAuO/sBHxcMRimvZ5YidX
         H9ZCEF+mRZRnAvzn54isK2ku48iF044JdQFStG+p1Zrajlqafk6kQBtUThYo5IpgVcOP
         QxIS7hYDzpyICp3bHoAwhXQ8RxYY0hUG9/r0+JUpVAVz+0G20xo9O05Gb6VOnI8eBKsK
         eUQrGlE4sfloAji0pyClhSRbHMGLCFOjFOqNE5Gg8D27jmO2i2OjeD+bLzyvej+ksexg
         TvHfdInDCanevtjUGS4QrZf+DU3ql8jVQ0EIatSKMnNYreTLnp/aM7g2s63pntq1WfPl
         W5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103122; x=1753707922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWHuVE1EgR5wLSuZVPObZK1oCh3b9sh0cLYRdc3oQUo=;
        b=esxvvP5/CeG69ZCOKJR8rkOM3NwpOSrcPkJ8WseUzDJ+piDDuGLVco8wQPqnI7ldar
         FKCsR7fVmhYGqgdsoJJnpYUE9PXeROdZaTZx2cbUd6t6hTYqruI/3yf6PJyVVlYONjYl
         zGHB67bS1AAyDrilWIClHZnPbMENZbVCqNy3jPRVrLAZZHeucW03ltGDi+uvsuX/nt7w
         SrdPoo9vpqUHiikadRabVD5kZpqjxv025+fJIEBb5saziImjIcRZrAV7+B2M2mAVdqoK
         duj82E2gEMmbXKINaa6eu6zKD79J7XwIDkUxzcoPkMJjpKceAKlfreeJJWZiwuPlX2DL
         NEAw==
X-Forwarded-Encrypted: i=1; AJvYcCUpFf/2OWtOj2HbzbQvBW4nuy8+f+DdiPfutGb1nPIewKxbjWuIieghviMzermLjbR9XoWl/XNN99xFcVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGqOJgcJ0E1XsGoavL0ca6JPo8rkPFsMp0bRsZNVkuuuCHqPB
	cQ//QEZ4sI3E2L5lyR+G4lvsb+9EMhs8Zw3aUK9QU+F4F3SIVw7TqdAI1RGNON52hh0=
X-Gm-Gg: ASbGncv7s0/VLIO2ew4GX7XomYxfKJcIv8rtDFdc7I1t794kaays0Kihbf/lu33Vbd6
	cKTkJc3d/VL6KEwRXUrORDLgetsjyTXinrEc0WkI4p0Zs2Ao0oOdq2u/DVE7xp+NJaB5jbc2Ofh
	U8ppm8hlOSfCQhDB4yp47plY36xBnzp283rV27jYzI8e5fgej3Gy0RyDQ0z3BqOerccDLz60fMG
	VF+IyJEkMrOEoAoHO4IKStMYx6RFhWhzv+Nzd83tQvCEMHPN71uZAhiz/77fI5k0fC4cfDaQ+C2
	2+xGV/FAupiC+AgTEz5O5J494sGgtQYN6124YeQZLQLbKau8RBteFsQGeM4oRr2/AuKludKxmXn
	g/hxWyR7vTdurWDPTU9iJgywS+ADEBItlM/jDw996sg==
X-Google-Smtp-Source: AGHT+IENuZ8sJTZYDX4FPNTpsJ3T0y3YydlBHbyO5i6H0FPLw38B5Bhq3yc1kar5ictPycy0p5ZNpw==
X-Received: by 2002:a05:6000:438a:b0:3a3:7117:1bba with SMTP id ffacd0b85a97d-3b613ad5ec1mr14410276f8f.24.1753103121601;
        Mon, 21 Jul 2025 06:05:21 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:21 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:03 +0100
Subject: [PATCH v5 09/12] perf: arm_spe: Add support for filtering on data
 source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-9-a7bc533485a1@linaro.org>
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
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE_FEAT_FDS adds the ability to filter on the data source of packets.
Like the other existing filters, enable filtering with PMSFCR_EL1.FDS
when any of the filter bits are set.

Each bit maps to data sources 0-63 described by bits[0:5] in the data
source packet (although the full range of data source is 16 bits so
higher value data sources can't be filtered on). The filter is an OR of
all the bits, so for example clearing bits 0 and 3 only includes packets
from data sources 0 OR 3.

Invert the filter given by userspace so that the default value of 0 is
equivalent to including all values (no filtering). This allows us to
skip adding a new format bit to enable filtering and still support
excluding all data sources which would have been a filter value of 0 if
not for the inversion.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/perf/arm_spe_pmu.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index e69a0d170702..5729be9e5952 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -87,6 +87,7 @@ struct arm_spe_pmu {
 #define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
 #define SPE_PMU_FEAT_DISCARD			(1UL << 7)
 #define SPE_PMU_FEAT_EFT			(1UL << 8)
+#define SPE_PMU_FEAT_FDS			(1UL << 9)
 #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
 	u64					features;
 
@@ -251,6 +252,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
 #define ATTR_CFG_FLD_inv_event_filter_LO	0
 #define ATTR_CFG_FLD_inv_event_filter_HI	63
 
+#define ATTR_CFG_FLD_inv_data_src_filter_CFG	config4	/* inverse of PMSDSFR_EL1 */
+#define ATTR_CFG_FLD_inv_data_src_filter_LO	0
+#define ATTR_CFG_FLD_inv_data_src_filter_HI	63
+
 GEN_PMU_FORMAT_ATTR(ts_enable);
 GEN_PMU_FORMAT_ATTR(pa_enable);
 GEN_PMU_FORMAT_ATTR(pct_enable);
@@ -267,6 +272,7 @@ GEN_PMU_FORMAT_ATTR(float_filter);
 GEN_PMU_FORMAT_ATTR(float_filter_mask);
 GEN_PMU_FORMAT_ATTR(event_filter);
 GEN_PMU_FORMAT_ATTR(inv_event_filter);
+GEN_PMU_FORMAT_ATTR(inv_data_src_filter);
 GEN_PMU_FORMAT_ATTR(min_latency);
 GEN_PMU_FORMAT_ATTR(discard);
 
@@ -287,6 +293,7 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
 	&format_attr_float_filter_mask.attr,
 	&format_attr_event_filter.attr,
 	&format_attr_inv_event_filter.attr,
+	&format_attr_inv_data_src_filter.attr,
 	&format_attr_min_latency.attr,
 	&format_attr_discard.attr,
 	NULL,
@@ -305,6 +312,10 @@ static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
 	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
 		return 0;
 
+	if (attr == &format_attr_inv_data_src_filter.attr &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return 0;
+
 	if ((attr == &format_attr_branch_filter_mask.attr ||
 	     attr == &format_attr_load_filter_mask.attr ||
 	     attr == &format_attr_store_filter_mask.attr ||
@@ -425,6 +436,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
 	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
 		reg |= PMSFCR_EL1_FnE;
 
+	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter))
+		reg |= PMSFCR_EL1_FDS;
+
 	if (ATTR_CFG_GET_FLD(attr, min_latency))
 		reg |= PMSFCR_EL1_FL;
 
@@ -449,6 +463,17 @@ static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
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
@@ -786,6 +811,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
+	if (arm_spe_event_to_pmsdsfr(event) != U64_MAX &&
+	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
+		return -EOPNOTSUPP;
+
 	if (attr->exclude_idle)
 		return -EOPNOTSUPP;
 
@@ -861,6 +890,11 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
 		write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
 	}
 
+	if (spe_pmu->features & SPE_PMU_FEAT_FDS) {
+		reg = arm_spe_event_to_pmsdsfr(event);
+		write_sysreg_s(reg, SYS_PMSDSFR_EL1);
+	}
+
 	reg = arm_spe_event_to_pmslatfr(event);
 	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
 
@@ -1120,6 +1154,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
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


