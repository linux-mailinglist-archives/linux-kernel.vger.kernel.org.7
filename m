Return-Path: <linux-kernel+bounces-760158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2006EB1E72E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB711C2094A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E922797AD;
	Fri,  8 Aug 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T9Qmx8oA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113127814C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652245; cv=none; b=K4yMxQ70WtUqPC/9u1AAhpXKpVbpCZ/Chm0PItMIY8/Pb6zq7Emzgnr2sqnl0ElBQ4VFpq7EHSI93TVrTQwmFs2sl2HxMcorbfcv40+TPn5ErWnYyrt58NgGIFSskLLx6r+3Pb3f+C56c4SzlXz9W4zM/pD4zzKyQxLkcQlrB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652245; c=relaxed/simple;
	bh=aRUWGynzXd2I0iPJ8E252lMe7rGfIx7dGynoHirUSWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQZyEc5gqgRTRHS5cpMRRPP6EZC09M/z4LvWws2gYSjSdT4fQmOhWGV4oLJmvaUoH0qgCIcmHomRqEFW2kbmE4nobQ3ZazWkdTN1EQB+yGyS7/58S4uP4umyl32ujs6d50lj+zPZfG7LLvYRNNfBEH6+oLOfjdH5WMSpZvR1HMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T9Qmx8oA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e7ea3ebeso8023585e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652241; x=1755257041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJMmlptoopG7uLnpNHx3BFeWdRFU3hEImM+p7yUrZvk=;
        b=T9Qmx8oA30OeY/AkrLd+4aJrgboV6NBUIKm1U/nCvGa8s6rKqEnplLWaxtiXuMD2Oh
         EmN77fIY+v4AlKh+dDxsEfSUPpDUq69xTLwjUpuaUAzn/KbHxnnMHjzrTx4cyEhAO5OV
         pGCA86SJghMUVcxwHP8F22KHe907F6F29RuJpnIR1syiKv9NSX2kTq4lEa3tJxhZP+zi
         oABntV0bxhGTSpQQSwTrydFIkKCgmQvUg4M0Pm1QEphP7TafBy1R227OLfW03BY8QhoW
         GBVXssor0AFKrPbbik2A+opzKdZSD+/+WkQWqNwfs6IFxZCaziRt0cUC44AnRpQpl4ph
         drkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652241; x=1755257041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJMmlptoopG7uLnpNHx3BFeWdRFU3hEImM+p7yUrZvk=;
        b=buQpMF+Ulkp2oz/LPu0FdBEenNKFdF1Pidd4P1DMc0TNZdRDFIw/N6ADRzR+hh7Niv
         m7tSnhaYUzbPesDSYQ/Pb49TPG5HOo7obDbnDKNUGDOA/Ifl+M8P+hUgaay43dJwf21y
         n6B9/chWpfRBKpZd+UEnZDZzjjlidkUbfkg3gcoQ/xPnCCmnp9mKGRpY1rdV65KmYEGh
         akP0insXvU+hMI4wpBb3IUTeLdv0uNiYzwK9lvI4NC8owSN/s5hOrFllFh6Li6P8nypD
         WgiLZArmbkVQ3dp3wZZq/J2x/oXxRXxnCIwysmd7+JSCOXZwwg8fwTsMYVU8RMlC+mxv
         ySzw==
X-Forwarded-Encrypted: i=1; AJvYcCVBH99jYfrWZ5grT/0QYXMZju8vt63qLvIxW9yIsZ2NA5Bsy2T272VPjSx+pmT9BaBc7X21hADxxkJlGek=@vger.kernel.org
X-Gm-Message-State: AOJu0YykJ9/l1EURw0htjZe0DkgY0aE23KR0XbAR5XaBgvAXvfhYIROI
	vbiAnJriDh1HtW7Gu70Uk4ojF/A1Gjrpcpltm8KyCkQoAriR6s/yEuCwMkK5OHMvW4w=
X-Gm-Gg: ASbGncsreKaf8iJy+dg8mCivCnqeyDYA+vZIjJi8k4YP7DJ49786LRxYWn/QhBZmFeK
	FEZ8XRs2EifPlpInnX315dgbgEsy8jWAxV8HJ8AjAgS1AqpZjfWOIFtN/mgoDxqRbQkxmuiddZM
	E/wwith9d6N9njHaklBHL9j0cqMIueBy3lcI4pIZsY2LrJ+YVFCVyVrJ3ONtozuYb0If6rKuKnz
	fF0+WXOx5p7iegocehsjDgsvjh90mw1xRxPg4nNH/YN1YNSDsRA2N8qAOQK9hgonex2F638U8WJ
	9W4RajsscM6yQNsP1TfyPFr4MPyh0CtLPolGiXb1HJ/tqX2NchZwmAPZ0/3B4XsEDyiEzKh8plN
	CsgacSSSN6QTY1dFmqd1Fe+1ueTSS5+s=
X-Google-Smtp-Source: AGHT+IHmVAPILAQt3jjnEVGZ95cvj/TwlhhBPdwWWqHVaKoukt+lAJlLJ0e2hot/FLFDTcAHZ+O1UQ==
X-Received: by 2002:a05:600c:468d:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-459f4f98174mr23235225e9.19.1754652241155;
        Fri, 08 Aug 2025 04:24:01 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:24:00 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:09 +0100
Subject: [PATCH v6 12/12] perf docs: arm-spe: Document new SPE filtering
 features
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-12-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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

FEAT_SPE_EFT and FEAT_SPE_FDS etc have new user facing format attributes
so document them. Also document existing 'event_filter' bits that were
missing from the doc and the fact that latency values are stored in the
weight field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-arm-spe.txt | 104 +++++++++++++++++++++++++++---
 1 file changed, 95 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
index 37afade4f1b2..c7d1032ff219 100644
--- a/tools/perf/Documentation/perf-arm-spe.txt
+++ b/tools/perf/Documentation/perf-arm-spe.txt
@@ -141,27 +141,65 @@ Config parameters
 These are placed between the // in the event and comma separated. For example '-e
 arm_spe/load_filter=1,min_latency=10/'
 
-  branch_filter=1     - collect branches only (PMSFCR.B)
-  event_filter=<mask> - filter on specific events (PMSEVFR) - see bitfield description below
+  event_filter=<mask> - logical AND filter on specific events (PMSEVFR) - see bitfield description below
+  inv_event_filter=<mask> - logical OR to filter out specific events (PMSNEVFR, FEAT_SPEv1p2) - see bitfield description below
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
-
-  bit 1     - instruction retired (i.e. omit speculative instructions)
+Only some events can be filtered on using 'event_filter' bits. The overall
+filter is the logical AND of these bits, for example if bits 3 and 5 are set
+only samples that have both 'L1D cache refill' AND 'TLB walk' are recorded. When
+FEAT_SPEv1p2 is implemented 'inv_event_filter' can also be used to exclude
+events that have any (OR) of the filter's bits set. For example setting bits 3
+and 5 in 'inv_event_filter' will exclude any events that are either L1D cache
+refill OR TLB walk. If the same bit is set in both filters it's UNPREDICTABLE
+whether the sample is included or excluded. Filter bits for both event_filter
+and inv_event_filter are:
+
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
+  bit 16    - Transaction (FEAT_TME)
+  bit 17    - Partial or empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 18    - Empty SME or SVE predicate (FEAT_SPEv1p1)
+  bit 19    - L2D access (FEAT_SPEv1p4)
+  bit 20    - L2D miss (FEAT_SPEv1p4)
+  bit 21    - Cache data modified (FEAT_SPEv1p4)
+  bit 22    - Recently fetched (FEAT_SPEv1p4)
+  bit 23    - Data snooped (FEAT_SPEv1p4)
+  bit 24    - Streaming SVE mode event (when FEAT_SPE_SME is implemented), or
+              IMPLEMENTATION DEFINED event 24 (when implemented, only versions
+              less than FEAT_SPEv1p4)
+  bit 25    - SMCU or external coprocessor operation event when FEAT_SPE_SME is
+              implemented, or IMPLEMENTATION DEFINED event 25 (when implemented,
+              only versions less than FEAT_SPEv1p4)
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
 
@@ -171,6 +209,31 @@ or just mispredicted branches:
 
   perf record -e arm_spe/event_filter=0x80/ -- ./mybench
 
+When set, the following filters can be used to select samples that match any of
+the operation types (OR filtering). If only one is set then only samples of that
+type are collected:
+
+  branch_filter=1     - Collect branches (PMSFCR.B)
+  load_filter=1       - Collect loads (PMSFCR.LD)
+  store_filter=1      - Collect stores (PMSFCR.ST)
+
+When extended filtering is supported (FEAT_SPE_EFT), SIMD and float
+pointer operations can also be selected:
+
+  simd_filter=1         - Collect SIMD loads, stores and operations (PMSFCR.SIMD)
+  float_filter=1        - Collect floating point loads, stores and operations (PMSFCR.FP)
+
+When extended filtering is supported (FEAT_SPE_EFT), operation type filters can
+be changed to AND using _mask fields. For example samples could be selected if
+they are store AND SIMD by setting 'store_filter=1,simd_filter=1,
+store_filter_mask=1,simd_filter_mask=1'. The new masks are as follows:
+
+  branch_filter_mask=1  - Change branch filter behavior from OR to AND (PMSFCR.Bm)
+  load_filter_mask=1    - Change load filter behavior from OR to AND (PMSFCR.LDm)
+  store_filter_mask=1   - Change store filter behavior from OR to AND (PMSFCR.STm)
+  simd_filter_mask=1    - Change SIMD filter behavior from OR to AND (PMSFCR.SIMDm)
+  float_filter_mask=1   - Change floating point filter behavior from OR to AND (PMSFCR.FPm)
+
 Viewing the data
 ~~~~~~~~~~~~~~~~~
 
@@ -204,6 +267,10 @@ Memory access details are also stored on the samples and this can be viewed with
 
   perf report --mem-mode
 
+The latency value from the SPE sample is stored in the 'weight' field of the
+Perf samples and can be displayed in Perf script and report outputs by enabling
+its display from the command line.
+
 Common errors
 ~~~~~~~~~~~~~
 
@@ -247,6 +314,25 @@ to minimize output. Then run perf stat:
   perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
   perf stat -e SAMPLE_FEED_LD
 
+Data source filtering
+~~~~~~~~~~~~~~~~~~~~~
+
+When FEAT_SPE_FDS is present, 'inv_data_src_filter' can be used as a mask to
+filter on a subset (0 - 63) of possible data source IDs. The full range of data
+sources is 0 - 65535 although these are unlikely to be used in practice. Data
+sources are IMPDEF so refer to the TRM for the mappings. Each bit N of the
+filter maps to data source N. The filter is an OR of all the bits, and the value
+provided inv_data_src_filter is inverted before writing to PMSDSFR_EL1 so that
+set bits exclude that data source and cleared bits include that data source.
+Therefore the default value of 0 is equivalent to no filtering (all data sources
+included).
+
+For example, to include only data sources 0 and 3, clear bits 0 and 3
+(0xFFFFFFFFFFFFFFF6)
+
+When 'inv_data_src_filter' is set to 0xFFFFFFFFFFFFFFFF, any samples with any
+data source set are excluded.
+
 SEE ALSO
 --------
 

-- 
2.34.1


