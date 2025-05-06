Return-Path: <linux-kernel+bounces-635869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C467EAAC301
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 13:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647F31C27B83
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EA827CCF9;
	Tue,  6 May 2025 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NF/UOpOR"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCE27E1D7
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531770; cv=none; b=VL/FcNv2XK+8pz6Zla+4/rKlDsdQiG9uANjcCKOKtbEY75N403O/SRX83d12tSl0EP9IftDWY0ypMSLJ/xGutHQBNDAfkzzZREtIWvNh7c0fYqIlIUO+zTMbIwePb4ZywMRRD2hYyxkYM/JFbjT0vs7RV1lL4+mE7fxUjqTv0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531770; c=relaxed/simple;
	bh=3sMCtIotqVivKM8/Ownc6QdZfz5Z6QLgO4uRyf0+zJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1cExTa55JuHqurS36ct6AxF4W5ZaPjBT8s+zsvJHiZovOTmoaSFgXRgDyC9I95jeaWAszgJ5EWdEoCyZMtB1oUR23SN3ZMSpfOH1oS81w6vn25/HW380JkQ8apzQ86VV+o2D+gQ0RNiVoAGHJ8z/i7Zj1Q+Wjex1mHQ9xL5EvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NF/UOpOR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso226130f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531766; x=1747136566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkqHrlk5rXmqQcmnUyYZSiZOvHTWZlNV/KJqAn/HjmE=;
        b=NF/UOpOR9/Y1yHivouHxWA1bycM4PJz1GMQW4ZMbBMjkQptY+WJUuyPp6DrscHkgjK
         lus9ZUr2ptqsPJ5IOh1cJCxZ4NLQCLonGHLtPjHeBxATzD1BpO29sRrCWIzaDJi17mAq
         U8tURzjpS5cYL0vD4HMYoDKAMBJDF3gv/nK9YMexY4T6luEhtPiSlsanKv4dWy36iPeC
         Jq5XgalsE021B/B6c77gDMolKuroDOunGAWVNmsK6H2s23PiXRrRiG4Bb894bJl8vxL4
         Z3i4xSAF+EunxHg8YoVyf+sAkmCjl4TusSlRE0ISqiqZtOr8IwtvBv/qeBrhHv9e+r8C
         kuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531766; x=1747136566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkqHrlk5rXmqQcmnUyYZSiZOvHTWZlNV/KJqAn/HjmE=;
        b=XWs7Oid8toyvddOV1g5n6Ei0Clm1BQE3zaiyMmDs3ouRn0utF9QNq/w75kUXBrT4c3
         KB8GCzthYttRbUl4Cb0PQ0jFEJy4vJ3vzozVzS/17jOQIOaxv5oTQcLT15beOiZGFhm1
         Le9+ROYMG9MJJvdcvjr9c9t5wUJGGtKO2j0DDTy900BYJTy2gAIApYTYBTae8PWcFQnD
         b25a1A8rCLM0fZ1z4JbnJeG320D8Ydmjck/nf6FYtljGLfJmREsR4Ire8kYHGJ03+m/T
         ylbfiayv3w1duQKi87bL3KPTpA/Yw5fXScrWnBKm3p83bLzY2xyboupnpwvFDRBFLORU
         BlcA==
X-Forwarded-Encrypted: i=1; AJvYcCXUMVpgKy7uwPUT1dhnpzdKtEnmDKFLzjThAGuhEa17whF58Ov3ySXvL1UbLd/rFfFs6obdOXPz5WPpeYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONQR4zRHTPu3xliOT4BLKtRwIieaErkS3YDrgSFnzvvhgzreG
	PebYCywc4bEJRDlUrzpYli2EbapyEcurLr3b/59UqDGnL8Bzlc4DLDoqJ5LjV1Q=
X-Gm-Gg: ASbGnct6Nht08wrtXjgQjefV2eGvZkxDjH/yS0DhLaFKQaFsj2RDSHKEMmQ3ZIg7cZ6
	VDhsHhzUc1gxES5FqGaXgVjXXVmda/csJ24wTZuZ6V9rAIhHUvO1PDiSReOI0fLjpJoGyNuZfV1
	0TPR45K9/hK/EU1WOYXYrin232P1EXNKzKijbfW8LZfOjj2l26f24S7HNpdbfxOZu6u41IWvM2v
	kreXdhVBZeMeoOc+KDQ9oHMvUgUfPY7rknOonOfk6FtypFkUXfh1lKgfJrgyMKllR0A60dbMXfZ
	0J770crWo+1YFZWq4STcOhNEhXXqHoMoKN/BqW7tLu57ZQ0=
X-Google-Smtp-Source: AGHT+IGUvZmO1ysjfj2110bUiJ8J7jVXWaXvMQnsa2Hz+uClfkGhq0fClzub1N37FV3ldFVqBc7yhA==
X-Received: by 2002:a05:6000:2287:b0:391:3f4f:a169 with SMTP id ffacd0b85a97d-3a0ac0ec06fmr2094137f8f.32.1746531765765;
        Tue, 06 May 2025 04:42:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:45 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:42 +0100
Subject: [PATCH 10/10] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-10-dd480e8e4851@linaro.org>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 86 ++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..a90da9f36d93 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -141,27 +141,60 @@ Config parameters
 These are placed between the // in the event and comma separated. For example '-e
 arm_spe/load_filter=1,min_latency=10/'
 
-  branch_filter=1     - collect branches only (PMSFCR.B)
-  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
+  event_filter=<mask> - logical AND filter on specific events (PMSEVFR) - see bitfield description below
+  inv_event_filter=<mask> - logical AND to filter out specific events (PMSNEVFR, FEAT_SPEv1p2) - see bitfield description below
   jitter=1            - use jitter to avoid resonance when sampling (PMSIRR.RND)
-  load_filter=1       - collect loads only (PMSFCR.LD)
   min_latency=<n>     - collect only samples with this latency or higher* (PMSLATFR)
   pa_enable=1         - collect physical address (as well as VA) of loads/stores (PMSCR.PA) - requires privilege
   pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
-  store_filter=1      - collect stores only (PMSFCR.ST)
   ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
   discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
+  data_src_filter=<mask> - mask to filter from 0-63 possible data sources (PMSDSFR, FEAT_SPE_FDS) - See 'Data source filtering'
 
 +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
 than only the execution latency.
 
-Only some events can be filtered on; these include:
+Only some events can be filtered on using 'event_filter' bits. The overall
+filter is the logical AND of these bits, for example if bits 3 and 5 are set
+only samples that have both L1D cache refill and TLB walk are recorded. When
+FEAT_SPEv1p2 is implemented 'inv_event_filter' can also be used to filter on
+events that do _not_ have the target bit set. Filter bits for both event_filter
+and inv_event_filter are:
 
-  bit 1     - instruction retired (i.e. omit speculative instructions)
+  bit 1     - Instruction retired (i.e. omit speculative instructions)
+  bit 2     - L1D access (FEAT_SPEv1p4)
   bit 3     - L1D refill
+  bit 4     - TLB access (FEAT_SPEv1p4)
   bit 5     - TLB refill
-  bit 7     - mispredict
-  bit 11    - misaligned access
+  bit 6     - Not taken event (FEAT_SPEv1p2)
+  bit 7     - Mispredict
+  bit 8     - Last level cache access (FEAT_SPEv1p4)
+  bit 9     - Last level cache miss (FEAT_SPEv1p4)
+  bit 10    - Remote access (FEAT_SPEv1p4)
+  bit 11    - Misaligned access (FEAT_SPEv1p1)
+  bit 12-15 - IMPLEMENTATION DEFINED events (when implemented)
+  bit 16    - FEAT_TME transactions
+  bit 17    - Partial or empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 18    - Empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 19    - L2D access (FEAT_SPEv1p4)
+  bit 20    - L2D miss (FEAT_SPEv1p4)
+  bit 21    - Cache data modified (FEAT_SPEv1p4)
+  bit 22    - Recently fetched (FEAT_SPEv1p4)
+  bit 23    - Data snooped (FEAT_SPEv1p4)
+  bit 24    - Streaming SVE mode event when FEAT_SPE_SME is implemented, or
+              IMPLEMENTATION DEFINED event 24 (when implemented)
+  bit 25    - SMCU or external coprocessor operation event when FEAT_SPE_SME is implemented, or
+              IMPLEMENTATION DEFINED event 25 (when implemented)
+  bit 26-31 - IMPLEMENTATION DEFINED events (only versions less than FEAT_SPEv1p4)
+  bit 48-63 - IMPLEMENTATION DEFINED events (when implemented)
+
+For IMPLEMENTATION DEFINED bits, refer to the CPU TRM if these bits are
+implemented.
+
+The driver will reject events if requested filter bits require unimplemented SPE
+versions, but will not reject filter bits for unimplemented IMPDEF bits or when
+their related feature is not present (e.g. SME). For example, if FEAT_SPEv1p2 is
+not implemented, filtering on "Not taken event" (bit 6) will be rejected.
 
 So to sample just retired instructions:
 
@@ -171,6 +204,29 @@ or just mispredicted branches:
 
   perf record -e arm_spe/event_filter=0x80/ -- ./mybench
 
+When set, the following filters can be used to select samples that match any of
+the operation types (OR filtering). If only one is set then only samples of that
+type are collected:
+
+  branch_filter=1     - Collect branches (PMSFCR.B)
+  load_filter=1       - Collect loads (PMSFCR.LD)
+  store_filter=1      - Collect stores (PMSFCR.ST)
+
+When extended filtering is supported (FEAT_SPE_EFT), operation type filters can
+be changed to AND and also new filters are added. For example samples could be
+selected if they are store AND SIMD by setting
+'store_filter=1,simd_filter=1,store_filter_mask=1,simd_filter_mask=1'. The new
+filters are as follows:
+
+  branch_filter_mask=1  - Change branch filter behavior from OR to AND (PMSFCR.Bm)
+  load_filter_mask=1    - Change load filter behavior from OR to AND (PMSFCR.LDm)
+  store_filter_mask=1   - Change store filter behavior from OR to AND (PMSFCR.STm)
+  simd_filter_mask=1    - Change SIMD filter behavior from OR to AND (PMSFCR.SIMDm)
+  float_filter_mask=1   - Change floating point filter behavior from OR to AND (PMSFCR.FPm)
+
+  simd_filter=1         - Collect SIMD loads, stores and operations (PMSFCR.SIMD)
+  float_filter=1        - Collect floating point loads, stores and operations (PMSFCR.FP)
+
 Viewing the data
 ~~~~~~~~~~~~~~~~~
 
@@ -204,6 +260,10 @@ Memory access details are also stored on the samples and this can be viewed with
 
   perf report --mem-mode
 
+The latency value from the SPE sample is stored in the 'weight' field of the
+Perf samples and can be displayed in Perf script and report outputs by enabling
+its display from the command line.
+
 Common errors
 ~~~~~~~~~~~~~
 
@@ -247,6 +307,16 @@ to minimize output. Then run perf stat:
   perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
   perf stat -e SAMPLE_FEED_LD
 
+Data source filtering
+~~~~~~~~~~~~~~~~~~~~~
+
+When FEAT_SPE_FDS is present, 'data_src_filter' can be used as a mask to filter
+a subset (0 - 63) of possible data source IDs. The full range of data sources is
+0 - 65 535 although these are unlikely to be used in practice. Data sources are
+IMPDEF so refer to the TRM for the mappings. Each bit N of the filter maps to
+data source N. The filter is an OR of all the bits, so for example setting bits
+0 and 3 filters on packets from data sources 0 OR 3.
+
 SEE ALSO
 --------
 

-- 
2.34.1


