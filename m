Return-Path: <linux-kernel+bounces-771485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F5B287D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 23:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E895C0551
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD70E310659;
	Fri, 15 Aug 2025 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6nS4xcj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8230F524
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293758; cv=none; b=IAhVFplh69r+aDXifBxJH+grYwfwapaAW++Nx/XI5RsS9oEFsLe/m7Ezrj3zuA2XZiSMslMcvciqKUCR47ccSYmR9kWWAV7gMcTL7f8HHCsqp8EzIFQEPMd2gJCtcrIWic9nsUyLvS+CiJw+epZzky7ThBM8OVQiHtPhtE0M/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293758; c=relaxed/simple;
	bh=yKA5f4nWjm9us8MphiAr5foByb9+nVvSKrYfvmpgLsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCdOdf8Uf/yjwMfrZIg7WP6d1/zrpx3xwbcpxDX/dY/axVC5XAKyBb8Rq3v5/dwp4c9Xo5VlR5n1SIyyEIIy8RFiNKcjBDctqIjlfT9oFhZfGqAbm8QYuHTwO68CR9RNY8an07TQEAsoO0fUVWwQ2cZ+cEnBieeNlUua3yqujxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6nS4xcj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755293757; x=1786829757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKA5f4nWjm9us8MphiAr5foByb9+nVvSKrYfvmpgLsI=;
  b=O6nS4xcjHtVDpPInoTlgSd+432dK+3D29IM9K3e64punGcu3K06fd4wR
   xhJB3eAF5nvvHkEZi2P/XIQ9R9M6UvFdtm6Dis3MZUS7dfJzWob9uJqrl
   RKgtWnWuA7hQhXVdtPRdVu+aN5eK9I8ckz4WAjRuuT3O8T8RJvLPYrcJT
   exAMLC+5fKrfdV6SN4b1mOKQPe5MjTLfIuFIRwM9kFMvUg8TSlOtB3Uxm
   kggOYTGa9QDCgWAv1fshUsEhqkEsHD/4R2xx8UGLEER/eRcn4I1YS83dU
   3CsaT73xAJ1nyaYgMT5d5T/JpUUh37ZQK4w2OZryRjWaIMPfds4s7x1w/
   A==;
X-CSE-ConnectionGUID: owI+Iw3LQQSZZku++8ZqAw==
X-CSE-MsgGUID: aTafiSO1QEmjbSP01iR8Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68707491"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68707491"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 14:35:48 -0700
X-CSE-ConnectionGUID: kpBkzUdeSf2MBdEaCCZ5Bw==
X-CSE-MsgGUID: 0HwQCP69Q4+cBkjWiFa6Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="166319633"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa010.jf.intel.com with ESMTP; 15 Aug 2025 14:35:48 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	jolsa@kernel.org,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	ak@linux.intel.com,
	zide.chen@intel.com,
	mark.rutland@arm.com,
	broonie@kernel.org,
	ravi.bangoria@amd.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [POC PATCH 17/17] perf regs: Support the PERF_SAMPLE_REGS_ABI_SIMD
Date: Fri, 15 Aug 2025 14:34:35 -0700
Message-Id: <20250815213435.1702022-18-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250815213435.1702022-1-kan.liang@linux.intel.com>
References: <20250815213435.1702022-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Support the new PERF_SAMPLE_REGS_ABI_SIMD. Dump the data to
perf report -D. Only the superset of the vector registers is displayed
for now.

Example:

 $perf record -e cycles:p -IXMM,YMM,OPMASK,SSP ./test
 $perf report -D
 ... ...
 237538985992962 0x454d0 [0x480]: PERF_RECORD_SAMPLE(IP, 0x1):
 179370/179370: 0xffffffff969627fc period: 124999 addr: 0
 ... intr regs: mask 0x20000000000 ABI 64-bit
 .... SSP   0x0000000000000000
 ... SIMD ABI nr_vectors 32 vector_qwords 4 nr_pred 8 pred_qwords 1
 .... YMM  [0] 0x0000000000004000
 .... YMM  [0] 0x000055e828695270
 .... YMM  [0] 0x0000000000000000
 .... YMM  [0] 0x0000000000000000
 .... YMM  [1] 0x000055e8286990e0
 .... YMM  [1] 0x000055e828698dd0
 .... YMM  [1] 0x0000000000000000
 .... YMM  [1] 0x0000000000000000
 ... ...
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... YMM  [31] 0x0000000000000000
 .... OPMASK[0] 0x0000000000100221
 .... OPMASK[1] 0x0000000000000020
 .... OPMASK[2] 0x000000007fffffff
 .... OPMASK[3] 0x0000000000000000
 .... OPMASK[4] 0x0000000000000000
 .... OPMASK[5] 0x0000000000000000
 .... OPMASK[6] 0x0000000000000000
 .... OPMASK[7] 0x0000000000000000
 ... ...

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c                       | 18 ++++++
 .../perf/util/perf-regs-arch/perf_regs_x86.c  | 45 ++++++++++++++
 tools/perf/util/sample.h                      | 10 +++
 tools/perf/util/session.c                     | 62 ++++++++++++++++---
 4 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7cfb0aab5dd9..e0c0ebfafc23 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3233,6 +3233,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords + regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
@@ -3290,6 +3299,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			regs->mask = mask;
 			regs->regs = (u64 *)array;
 			array = (void *)array + sz;
+
+			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+				regs->config = *(u64 *)array;
+				array = (void *)array + sizeof(u64);
+				regs->data = (u64 *)array;
+				sz = (regs->nr_vectors * regs->vector_qwords + regs->nr_pred * regs->pred_qwords) * sizeof(u64);
+				OVERFLOW_CHECK(array, sz, max_size);
+				array = (void *)array + sz;
+			}
 		}
 	}
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 708954a9d35d..b494f4504052 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -5,6 +5,51 @@
 
 const char *__perf_reg_name_x86(int id)
 {
+	u16 qwords;
+
+	if (id > PERF_REG_X86_R15 && arch__intr_simd_reg_mask(&qwords)) {
+		switch (id) {
+		case PERF_REG_X86_R16:
+			return "R16";
+		case PERF_REG_X86_R17:
+			return "R17";
+		case PERF_REG_X86_R18:
+			return "R18";
+		case PERF_REG_X86_R19:
+			return "R19";
+		case PERF_REG_X86_R20:
+			return "R20";
+		case PERF_REG_X86_R21:
+			return "R21";
+		case PERF_REG_X86_R22:
+			return "R22";
+		case PERF_REG_X86_R23:
+			return "R23";
+		case PERF_REG_X86_R24:
+			return "R24";
+		case PERF_REG_X86_R25:
+			return "R25";
+		case PERF_REG_X86_R26:
+			return "R26";
+		case PERF_REG_X86_R27:
+			return "R27";
+		case PERF_REG_X86_R28:
+			return "R28";
+		case PERF_REG_X86_R29:
+			return "R29";
+		case PERF_REG_X86_R30:
+			return "R30";
+		case PERF_REG_X86_R31:
+			return "R31";
+		case PERF_REG_X86_SSP:
+			return "SSP";
+		default:
+			return NULL;
+		}
+
+		return NULL;
+	}
+
 	switch (id) {
 	case PERF_REG_X86_AX:
 		return "AX";
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e96240052e9..36ac4519014b 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -12,6 +12,16 @@ struct regs_dump {
 	u64 abi;
 	u64 mask;
 	u64 *regs;
+	union {
+		u64 config;
+		struct {
+			u16 nr_vectors;
+			u16 vector_qwords;
+			u16 nr_pred;
+			u16 pred_qwords;
+		};
+	};
+	u64 *data;
 
 	/* Cached values/mask filled by first register access. */
 	u64 cache_regs[PERF_SAMPLE_REGS_CACHE_SIZE];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a320672c264e..6f931abe2050 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -922,18 +922,62 @@ static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
 	}
 }
 
-static const char *regs_abi[] = {
-	[PERF_SAMPLE_REGS_ABI_NONE] = "none",
-	[PERF_SAMPLE_REGS_ABI_32] = "32-bit",
-	[PERF_SAMPLE_REGS_ABI_64] = "64-bit",
-};
+static void simd_regs_dump__printf(struct regs_dump *regs)
+{
+	const char *name = "unknown";
+	const struct sample_reg *r;
+	int i, idx = 0;
+
+	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
+		return;
+
+	printf("... SIMD ABI nr_vectors %d vector_qwords %d nr_pred %d pred_qwords %d\n",
+	       regs->nr_vectors, regs->vector_qwords,
+	       regs->nr_pred, regs->pred_qwords);
+
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		if (regs->vector_qwords == r->qwords.vec) {
+			name = r->name;
+			break;
+		}
+	}
+
+	for (i = 0; i < regs->nr_vectors; i++) {
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		if (regs->vector_qwords > 2) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		}
+		if (regs->vector_qwords > 4) {
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+			printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+		}
+	}
+
+	name = "unknown";
+	for (r = arch__sample_simd_reg_masks(); r->name; r++) {
+		if (r->qwords.pred && regs->pred_qwords == r->qwords.pred) {
+			name = r->name;
+			break;
+		}
+	}
+	for (i = 0; i < regs->nr_pred; i++)
+		printf(".... %-5s[%d] 0x%016" PRIx64 "\n", name, i, regs->data[idx++]);
+}
 
 static inline const char *regs_dump_abi(struct regs_dump *d)
 {
-	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
-		return "unknown";
+	if (!d->abi)
+		return "none";
+	if (d->abi & PERF_SAMPLE_REGS_ABI_32)
+		return "32-bit";
+	else if (d->abi & PERF_SAMPLE_REGS_ABI_64)
+		return "64-bit";
 
-	return regs_abi[d->abi];
+	return "unknown";
 }
 
 static void regs__printf(const char *type, struct regs_dump *regs, const char *arch)
@@ -946,6 +990,8 @@ static void regs__printf(const char *type, struct regs_dump *regs, const char *a
 	       regs_dump_abi(regs));
 
 	regs_dump__printf(mask, regs->regs, arch);
+
+	simd_regs_dump__printf(regs);
 }
 
 static void regs_user__printf(struct perf_sample *sample, const char *arch)
-- 
2.38.1


