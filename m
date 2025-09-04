Return-Path: <linux-kernel+bounces-799890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02990B4312E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBD45649DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFC26C3A8;
	Thu,  4 Sep 2025 04:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iy7OTgK0"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C526B2A5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960356; cv=none; b=VZFOr7MClFwsaXSiahdxPv4zLV2KLmyPmiU0e6BEYVXzlVPXHJpYrWsExO0M2dK34TCVqeYH5Xkn36M44P7zf8V1zV00D9Iq7+YtIhb5loD8GAZqyMmxp9a4w7z97mtjN28qwEY1j2Ii3oGipo/fr0f6o55OAeJbP31MUY6p2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960356; c=relaxed/simple;
	bh=ffRgbCW+mwLvKxlr5G/zDLTTXB7A7/iZ7lLI7n5/B7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SVyyMofqE2efdeUDtSYavBpoNCcZ+DLiGIIdzyWXpgrU7QKnhsAPThJI0sfAGiyjscHSY8176RbP/VnEO02t/isyJ8Mh/6QKwng8JuVhC8nh9LFAz7pta2hBB/htWUHw1w+2YfUzXKKlxJPIZHKGXhnt/lM1FpJ1zSbvH1OdKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iy7OTgK0; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b302991b39so10709961cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960353; x=1757565153; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAh/vefV0zbzf710Ctp3hGyMWK0fEN5QciWvBjtY5IM=;
        b=Iy7OTgK0iOO6hnJB2pmf4wy+pqSCdSqfPPFTklZ36u/6bMIMeUC9S5TFqmxyM1afup
         59YWWN7ER7tJqdyD1MtNBkmTcjEftF1OgWDcPz0EWPCgZELPXqvmuKyqI2zZBmHPbW5x
         vVA7rf+sWECGNio1hwICiiVNmDU4YSimpPU+qV312mQ9M1bLMPUiOvMMEp21OWenpC+9
         lcHMqESmX9cXIsBcuBIoh7abdHTo+zoGVQoyuNTuakGEeIU85D6qcG71PRLWrkvNCgEP
         sUZW2zA7mOnzNAT41+fnpzAfi4WUE0cA//Wfoi+B2AU5TbCYIM+7Oxj3JuxhbArmFF/s
         RE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960353; x=1757565153;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAh/vefV0zbzf710Ctp3hGyMWK0fEN5QciWvBjtY5IM=;
        b=OrzwqzXf9RlS/NIz81ftDcVo97IVOxxydzHsXImD2PjHtIpd2wykor9XaKNzuYK1MA
         eLs0X1i5arzWnd46IK66UFhE5qEx/AwMQAzXB6gO9KX9byfOyWcZt3NUJkZ+qrI4Udgq
         I2sg9bxNub575NrmGXTL7zsf2yPwbpe6mYc/RIQfsUr998NHKHV/sgZ872n2WsIT9+2i
         R4h988zg7pi0caeywEAI81U9bmS8dgcK4pyShU9lMqkGozTz5YXrDteGVNHt6mFtKNpO
         o1qWgIl721K1vkKxmcPocLmkausCmLPIRn6JnFqZc9UR+ppRsoLsSL1SMjuehn4FPHLo
         IwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVth9TWI19zxx8XkIIz2mEG1EOtMXKEc9gRKiIDuPRRgmZyoQGUMAfKKRLy66DxPOgIXdgQzc4txGpBTVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUe5nLYJwdMl3nMOGb9VE5Vq6VgsbcqP+Lt5IUrxDskvKZJ+bt
	voTx0bmStSJGF/EDbbc1+3l7z92dwlDLbU+UkhDbY5JVYyh/tV97VeuqEb0CFmQeeRfUj41aETD
	4W3F80A37FQ==
X-Google-Smtp-Source: AGHT+IGEdNHFm7B7CGrnsxnQU0WMllIJFENZeBz9HftJVdwxs6kCXS9cT1zRuS7Q3IX9kPrWJUOHvT9hRfq9
X-Received: from qknua1.prod.google.com ([2002:a05:620a:6981:b0:808:15f9:475])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:14d3:b0:4b5:d932:15c9
 with SMTP id d75a77b69052e-4b5d9323596mr10750201cf.37.1756960353102; Wed, 03
 Sep 2025 21:32:33 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:06 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-12-irogers@google.com>
Subject: [PATCH v6 11/12] perf jevents: Build support for generating metrics
 from python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Generate extra-metrics.json and extra-metricgroups.json from python
architecture specific scripts. The metrics themselves will be added in
later patches.

If a build takes place in tools/perf/ then extra-metrics.json and
extra-metricgroups.json are generated in that directory and so added
to .gitignore. If there is an OUTPUT directory then the
tools/perf/pmu-events/arch files are copied to it so the generated
extra-metrics.json and extra-metricgroups.json can be added/generated
there.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore                  |  5 +++
 tools/perf/Makefile.perf               |  2 +
 tools/perf/pmu-events/Build            | 51 +++++++++++++++++++++++++-
 tools/perf/pmu-events/amd_metrics.py   | 38 +++++++++++++++++++
 tools/perf/pmu-events/arm64_metrics.py | 39 ++++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py | 38 +++++++++++++++++++
 6 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index b64302a76144..133e343bf44e 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -42,6 +42,11 @@ pmu-events/metric_test.log
 pmu-events/empty-pmu-events.log
 pmu-events/test-empty-pmu-events.c
 *.shellcheck_log
+pmu-events/arch/**/extra-metrics.json
+pmu-events/arch/**/extra-metricgroups.json
+tests/shell/*.shellcheck_log
+tests/shell/coresight/*.shellcheck_log
+tests/shell/lib/*.shellcheck_log
 feature/
 libapi/
 libbpf/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cc1635335586..96ad9ea60f68 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1279,6 +1279,8 @@ ifeq ($(OUTPUT),)
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
+	$(Q)find pmu-events/arch -name 'extra-metrics.json' -delete -o \
+		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
 		$(OUTPUT)pmu-events/pmu-events.c \
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 4ebf37c14978..162d5f74cbe8 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -30,6 +30,10 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)cp $< $@
 else
+# Extract the model from a extra-metrics.json or extra-metricgroups.json path
+model_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/extra-metric.*\.json@\1@')
+vendor_name = $(shell echo $(1)|sed -e 's@.\+/\(.*\)/[^/]*/extra-metric.*\.json@\1@')
+
 # Copy checked-in json for generation.
 $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
 	$(call rule_mkdir)
@@ -39,7 +43,52 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
+GEN_METRIC_DEPS := pmu-events/metric.py
+
+# Generate AMD Json
+ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
+ZEN_METRICS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metrics.json)
+ZEN_METRICGROUPS = $(foreach x,$(ZENS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ZEN_METRICS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(ZEN_METRICGROUPS): pmu-events/amd_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+# Generate ARM Json
+ARMS = $(shell ls -d pmu-events/arch/arm64/arm/*)
+ARM_METRICS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metrics.json)
+ARM_METRICGROUPS = $(foreach x,$(ARMS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(ARM_METRICS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+$(ARM_METRICGROUPS): pmu-events/arm64_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call vendor_name,$@) $(call model_name,$@) arch > $@
+
+# Generate Intel Json
+INTELS = $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v mapfile.csv)
+INTEL_METRICS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json)
+INTEL_METRICGROUPS = $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricgroups.json)
+
+$(INTEL_METRICS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< $(call model_name,$@) arch > $@
+
+$(INTEL_METRICGROUPS): pmu-events/intel_metrics.py $(GEN_METRIC_DEPS)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $< -metricgroups $(call model_name,$@) arch > $@
+
+GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) \
+            $(LEGACY_CACHE_JSON) \
+            $(ZEN_METRICS) $(ZEN_METRICGROUPS) \
+            $(ARM_METRICS) $(ARM_METRICGROUPS) \
+            $(INTEL_METRICS) $(INTEL_METRICGROUPS)
 
 $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
 	$(call rule_mkdir)
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
new file mode 100755
index 000000000000..7ab2ee4fdb17
--- /dev/null
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="AMD perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. amdzen[123]")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
new file mode 100755
index 000000000000..a9f0e6bc751b
--- /dev/null
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="ARM perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("vendor", help="e.g. arm")
+  parser.add_argument("model", help="e.g. neoverse-n1")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
new file mode 100755
index 000000000000..f004c27640d2
--- /dev/null
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -0,0 +1,38 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, MetricGroup)
+import argparse
+import json
+import os
+
+# Global command line arguments.
+_args = None
+
+def main() -> None:
+  global _args
+
+  def dir_path(path: str) -> str:
+    """Validate path is a directory for argparse."""
+    if os.path.isdir(path):
+      return path
+    raise argparse.ArgumentTypeError(f'\'{path}\' is not a valid directory')
+
+  parser = argparse.ArgumentParser(description="Intel perf json generator")
+  parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
+  parser.add_argument("model", help="e.g. skylakex")
+  parser.add_argument(
+      'events_path',
+      type=dir_path,
+      help='Root of tree containing architecture directories containing json files'
+  )
+  _args = parser.parse_args()
+
+  all_metrics = MetricGroup("",[])
+
+  if _args.metricgroups:
+    print(JsonEncodeMetricGroupDescriptions(all_metrics))
+  else:
+    print(JsonEncodeMetric(all_metrics))
+
+if __name__ == '__main__':
+  main()
-- 
2.51.0.338.gd7d06c2dae-goog


