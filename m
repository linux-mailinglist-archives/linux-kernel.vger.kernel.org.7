Return-Path: <linux-kernel+bounces-594532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED29EA8135C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C804C4E3BED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A42356BE;
	Tue,  8 Apr 2025 17:16:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32652356CC;
	Tue,  8 Apr 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132594; cv=none; b=d4xln2PIfqJfQprug/Y7IyjfQQKJhWbt/u0q6Whd0Wr89hSUUVCZA9bwJcfjTgt8NHVBWl8eAVM8zn+eJRXEWOr+v8KzcstBknyjwW0TO6iVlfXwWOajiNN8ypTxjHAA3kiUXxuYCdPg9oczLD75WD5KMsdWPXvk5Zu4uj7p5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132594; c=relaxed/simple;
	bh=HzNfzNrhhEGtHEAmmwegS0Lov/OL0xRdpo39lr3yU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9d0MmogM5WLv9D4ZE+CG02o/vaFv3XYrCkRFqjxL6wx5EpuVNbclJYyburU1D3b1CHt1GnG2mGrQFBzonZogUq5xlD2X5rnQGvFRUuRS+QcXSyv52rBzr1VlvfrppihwSh8rz2zFtm9PnqunyXM4isW2KImJEV7uIapIfuFryY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08C241688;
	Tue,  8 Apr 2025 10:16:33 -0700 (PDT)
Received: from e128066.cambridge.arm.com (e128066.cambridge.arm.com [10.1.26.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 840AF3F59E;
	Tue,  8 Apr 2025 10:16:28 -0700 (PDT)
From: mark.barnett@arm.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: ben.gainey@arm.com,
	deepak.surti@arm.com,
	ak@linux.intel.com,
	will@kernel.org,
	james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mark Barnett <mark.barnett@arm.com>
Subject: [PATCH v4 4/5] tools/perf: Modify event parser to support hf-period term
Date: Tue,  8 Apr 2025 18:15:29 +0100
Message-Id: <20250408171530.140858-5-mark.barnett@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408171530.140858-1-mark.barnett@arm.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Gainey <ben.gainey@arm.com>

parse-events is modified, adding the "hf-period" term which can be used
to specify the high-frequency sampling period.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Mark Barnett <mark.barnett@arm.com>
---
 tools/include/uapi/linux/perf_event.h             | 10 ++++++++++
 tools/perf/tests/shell/attr/base-record           |  3 ++-
 tools/perf/tests/shell/attr/base-record-spe       |  1 +
 tools/perf/tests/shell/attr/base-stat             |  3 ++-
 tools/perf/tests/shell/attr/system-wide-dummy     |  3 ++-
 tools/perf/tests/shell/attr/test-record-dummy-C0  |  3 ++-
 .../tests/shell/attr/test-record-hf-period-term   | 12 ++++++++++++
 tools/perf/tests/shell/lib/attr.py                |  1 +
 tools/perf/util/evsel.c                           |  1 +
 tools/perf/util/parse-events.c                    | 15 +++++++++++++++
 tools/perf/util/parse-events.h                    |  3 ++-
 tools/perf/util/parse-events.l                    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c         |  1 +
 tools/perf/util/pmu.c                             |  3 ++-
 14 files changed, 54 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/tests/shell/attr/test-record-hf-period-term

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 0524d541d4e3..2a6cc543df0e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: hf_sample */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -531,6 +532,15 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+
+	union {
+		__u64 hf_sample;
+		struct {
+			__u64 hf_sample_period : 32,
+			      hf_sample_rand   :  4,
+			      __reserved_4     : 28;
+		};
+	};
 };
 
 /*
diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
index b44e4e6e4443..8369f505dfb2 100644
--- a/tools/perf/tests/shell/attr/base-record
+++ b/tools/perf/tests/shell/attr/base-record
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0|1
-size=136
+size=144
 config=0|1
 sample_period=*
 sample_type=263
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+hf_sample_period=0
diff --git a/tools/perf/tests/shell/attr/base-record-spe b/tools/perf/tests/shell/attr/base-record-spe
index 08fa96b59240..2b4f051b6717 100644
--- a/tools/perf/tests/shell/attr/base-record-spe
+++ b/tools/perf/tests/shell/attr/base-record-spe
@@ -38,3 +38,4 @@ config2=*
 branch_sample_type=*
 sample_regs_user=*
 sample_stack_user=*
+hf_sample_period=0
diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
index fccd8ec4d1b0..499c44c6216c 100644
--- a/tools/perf/tests/shell/attr/base-stat
+++ b/tools/perf/tests/shell/attr/base-stat
@@ -5,7 +5,7 @@ group_fd=-1
 flags=0|8
 cpu=*
 type=0
-size=136
+size=144
 config=0
 sample_period=0
 sample_type=65536
@@ -39,3 +39,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+hf_sample_period=0
diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
index a1e1d6a263bf..1dad060d304a 100644
--- a/tools/perf/tests/shell/attr/system-wide-dummy
+++ b/tools/perf/tests/shell/attr/system-wide-dummy
@@ -7,7 +7,7 @@ cpu=*
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=1
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -50,3 +50,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+hf_sample_period=0
diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
index 91499405fff4..18f0e3766389 100644
--- a/tools/perf/tests/shell/attr/test-record-dummy-C0
+++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
@@ -10,7 +10,7 @@ cpu=0
 pid=-1
 flags=8
 type=1
-size=136
+size=144
 config=9
 sample_period=4000
 # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
@@ -53,3 +53,4 @@ config2=0
 branch_sample_type=0
 sample_regs_user=0
 sample_stack_user=0
+hf_sample_period=0
diff --git a/tools/perf/tests/shell/attr/test-record-hf-period-term b/tools/perf/tests/shell/attr/test-record-hf-period-term
new file mode 100644
index 000000000000..539b9946c8cc
--- /dev/null
+++ b/tools/perf/tests/shell/attr/test-record-hf-period-term
@@ -0,0 +1,12 @@
+[config]
+command = record
+args    = --no-bpf-event -e cycles/period=3,hf-period=2/ -- kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.15
+
+[event-10:base-record]
+sample_period=3
+hf_sample_period=2
+
+freq=0
+sample_type=7
diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index bfccc727d9b2..80c99758bd86 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -85,6 +85,7 @@ class Event(dict):
         'branch_sample_type',
         'sample_regs_user',
         'sample_stack_user',
+        'hf_sample_period',
     ]
 
     def add(self, data):
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1974395492d7..6e8eb34ef957 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -180,6 +180,7 @@ static int store_event(struct perf_event_attr *attr, pid_t pid, struct perf_cpu
 	WRITE_ASS(branch_sample_type, "llu");
 	WRITE_ASS(sample_regs_user,   "llu");
 	WRITE_ASS(sample_stack_user,  PRIu32);
+	WRITE_ASS(hf_sample_period,  PRIu32);
 
 	fclose(file);
 	return 0;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5152fd5a6ead..c0943eb7f171 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -805,6 +805,7 @@ const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 		[PARSE_EVENTS__TERM_TYPE_RAW]                   = "raw",
 		[PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          = "legacy-cache",
 		[PARSE_EVENTS__TERM_TYPE_HARDWARE]              = "hardware",
+		[PARSE_EVENTS__TERM_TYPE_HF_PERIOD]		= "hf-period",
 	};
 	if ((unsigned int)term_type >= __PARSE_EVENTS__TERM_TYPE_NR)
 		return "unknown term";
@@ -833,6 +834,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 	case PARSE_EVENTS__TERM_TYPE_NAME:
 	case PARSE_EVENTS__TERM_TYPE_METRIC_ID:
 	case PARSE_EVENTS__TERM_TYPE_SAMPLE_PERIOD:
+	case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
 	case PARSE_EVENTS__TERM_TYPE_PERCORE:
 		return true;
 	case PARSE_EVENTS__TERM_TYPE_USER:
@@ -981,6 +983,16 @@ do {									   \
 			return -EINVAL;
 		}
 		break;
+	case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
+		CHECK_TYPE_VAL(NUM);
+		if (term->val.num == 0) {
+			parse_events_error__handle(err, term->err_val,
+						strdup("expected a non-zero value"),
+						NULL);
+			return -EINVAL;
+		}
+		attr->hf_sample_period = term->val.num;
+		break;
 	case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
 	case PARSE_EVENTS__TERM_TYPE_USER:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
@@ -1108,6 +1120,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	case PARSE_EVENTS__TERM_TYPE_RAW:
 	case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+	case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
@@ -1242,6 +1255,7 @@ do {								\
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
 		default:
 			break;
 		}
@@ -1296,6 +1310,7 @@ static int get_config_chgs(struct perf_pmu *pmu, struct parse_events_terms *head
 		case PARSE_EVENTS__TERM_TYPE_RAW:
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
 		case PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
 		default:
 			break;
 		}
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index e176a34ab088..a6c4f81d5989 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -80,7 +80,8 @@ enum parse_events__term_type {
 	PARSE_EVENTS__TERM_TYPE_RAW,
 	PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
 	PARSE_EVENTS__TERM_TYPE_HARDWARE,
-#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HARDWARE + 1)
+	PARSE_EVENTS__TERM_TYPE_HF_PERIOD,
+#define	__PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HF_PERIOD + 1)
 };
 
 struct parse_events_term {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7ed86e3e34e3..482321ace228 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -335,6 +335,7 @@ aux-output		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
 aux-action		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_ACTION); }
 aux-sample-size		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
 metric-id		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_METRIC_ID); }
+hf-period		{ return term(yyscanner, PARSE_EVENTS__TERM_TYPE_HF_PERIOD); }
 cpu-cycles|cycles				{ return hw_term(yyscanner, PERF_COUNT_HW_CPU_CYCLES); }
 stalled-cycles-frontend|idle-cycles-frontend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
 stalled-cycles-backend|idle-cycles-backend	{ return hw_term(yyscanner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 66b666d9ce64..c93904a299af 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -360,6 +360,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(aux_start_paused, p_unsigned);
 	PRINT_ATTRf(aux_pause, p_unsigned);
 	PRINT_ATTRf(aux_resume, p_unsigned);
+	PRINT_ATTRf(hf_sample_period, p_unsigned);
 
 	return ret;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b7ebac5ab1d1..f90c59e29371 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1429,7 +1429,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			break;
 		case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
 			return -EINVAL;
-		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HARDWARE:
+		case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_TYPE_HF_PERIOD:
 			/* Skip non-config terms. */
 			break;
 		default:
@@ -1804,6 +1804,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 		"aux-output",
 		"aux-action=(pause|resume|start-paused)",
 		"aux-sample-size=number",
+		"hf-period=number",
 	};
 	struct perf_pmu_format *format;
 	int ret;
-- 
2.43.0


