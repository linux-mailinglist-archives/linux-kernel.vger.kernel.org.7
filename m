Return-Path: <linux-kernel+bounces-839864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DB7BB2992
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6553B8BB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA172D323E;
	Thu,  2 Oct 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="k/3CAjt+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB22D2390
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 06:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385372; cv=none; b=Sby/cES3ZmOk84svnhkCFJkXHPUxn5YxfyDKsL/ESJ8da9UAHUjZxiAZV+7DxPEmeNP/UI33NzjoXE5ttYrdh8pWlq/jQFPklYfzHA2/VzCsynFaMIS8xKsSftmHiVMfxVe2zSd3JfRVPRL3bz/GJjmi8PmYLqI59HGt7sO9P6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385372; c=relaxed/simple;
	bh=A8yV6HZYjL3Q3FaHQaHm8hNAwETN0T+E21KzDymdeVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n10XiaDj/Ni6LYJRPgSiBmMVeZfq9NQF+uQg71Cr3SQMf2V7pgZX0U5ugvJNOWAbdHhM+aU+F0I0WQ638poaGqEqp1ZUChQl8JN+8TKrIsIwNjYyeqtUPDXlQF4LcMarS1josGBUh7rtBwAm69e+a87IdxuLvX4tEL8Ta5U0u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=k/3CAjt+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78118e163e5so1647283b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 23:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759385370; x=1759990170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zmmvMMm35WfJWJCu/rbPWUzK6j6v7Igidp5p7E+6WY=;
        b=k/3CAjt+Jo16pYkpnbpvBxVzcvIbnZwFycGZMB1N+g/J9ZV1yDLUcL98Am+PW4ClrE
         BpvAxWkCC5g16yzXuVxWMTNY428F5EnXxV92Jda3gkLBr/296zvbYMBK8lyYRhGGxw2d
         PXY0OqQMdmmt8EfRo4/fRfpJOfXBs5ZsNobwtQckF+Qp1YFmB3uwb+rNudQzzS+cw0gC
         K1DaS7u5VuJ5j4hjsNTF4vWtCuQ5Qjb82S81Xz1vd/e2Q6FcC1MEFkw8w3IFkrOIti3g
         hCMiDUAN7Dvc4ZKqqyj98qMLHgF6aoHYFCzDPnrcSB5ZbdYJxnjLkPummDou+LtECDz3
         cEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759385370; x=1759990170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zmmvMMm35WfJWJCu/rbPWUzK6j6v7Igidp5p7E+6WY=;
        b=Wl8TusZEFzhfyk/V4zBmPGnJG2sMPJL/b4CJ+hLB49T9AhLNFamISeWACIAExfeRTo
         VbZa9Y2JsYoo2GZ8fYST1n+H5QXqf5lOvEASvW31lFKj7Kcmt6JFfBK+5tEEjr9YkG05
         fUgQdopqNy5moW6jB9tgwnB15w+k+gETErzPCCHu9Gx5DwhlOEHa07E8AKl66jHOkBHm
         9xlJtRbJmoCCIqoDwEB6cykfsC0Te2CIheWz1cIjdIc4ltqk2PZoElKxNPJimiBmzrQD
         OE92ls1n2XrXBgXjj//WexX7JQ8Nr6Vqzh2UnEnllB+usnlFVBNjJSY6XCyPMYHT8W1B
         hLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7AasgrZO6Pasv/GrPB+n1uVSbZ2zbYuLkRF95z+8vDLsGlQD4D0va6Gk7i1BOzIb1j9uaAbg2dtJ5wIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IspfgnY8hlIYjdZlYeZZB2X77iIucdA1YWFZPEBmrVZ/dXXU
	01MWlNNqBb4Yq8MhdP1Qyp1gsrX5nZ7Je1NGHXkLmBHIzE9mg+2qOPfxze6xcvPj9fg=
X-Gm-Gg: ASbGncsusUXp0bfJc99SJF/1lXD7CE2qIYo5oP5zcI/JzmnCqAqVGr73y4bpXFv3AoZ
	60BBXA3zDzYt4NY52cXxe2yylr2KtQ6byzSlAMWpG3rdsRcCHL7fon4HIa4jN2Xan/UAA4YnY7R
	M7eLjVio5R9fIAvcY/pRAc37WEALOIzKEWoKgKVtx0p/dxxyQJvi1DuGQL/DDt8c0EbN0taixA2
	nj0jp2y+EdnbV3MfSe7TRYzcW43aAX+n93ZOuhhJplIfNv/1r6zNWczbW9RHRgmiwxM+FTH2FMs
	8+y2dWTOWY0Y6XVSkiZC+pSthvcBQUnciVFlv9vtu+DXvjfpGQKOOP0OOW0JzY76D7iF+RT8fdo
	9ViTztRPCnrdfXgDTd+tfa32ZqCvWFcQoSY1yq9Hc1sdOyDFskEZcAS1EbtP60bCEZIsGYesK1i
	tsZaI=
X-Google-Smtp-Source: AGHT+IF+YSzJ58uViX8Nc9sdQwacWiEzaK5CydbflVdamOordFViOPRH4V5+hIAsR14420tWtxw0Bw==
X-Received: by 2002:a05:6a21:3943:b0:243:78a:82c4 with SMTP id adf61e73a8af0-32a261f188amr2830964637.25.1759385370384;
        Wed, 01 Oct 2025 23:09:30 -0700 (PDT)
Received: from localhost.localdomain ([122.171.19.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f594afsm1205029a12.37.2025.10.01.23.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 23:09:29 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Mayuresh Chitale <mchitale@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 10/11] perf tools: Initial support for RISC-V trace decoder
Date: Thu,  2 Oct 2025 11:37:31 +0530
Message-ID: <20251002060732.100213-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002060732.100213-1-apatel@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mayuresh Chitale <mchitale@ventanamicro.com>

Add bare bones support for RISC-V trace decoder so that the data received
from the hardware by the RISC-V trace perf driver can be written to the
perf record output file.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 tools/perf/util/Build             |  1 +
 tools/perf/util/auxtrace.c        |  3 +
 tools/perf/util/rvtrace-decoder.c | 91 +++++++++++++++++++++++++++++++
 tools/perf/util/rvtrace.h         |  2 +
 4 files changed, 97 insertions(+)
 create mode 100644 tools/perf/util/rvtrace-decoder.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4959e7a990e4..2305638283c4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -142,6 +142,7 @@ perf-util-$(CONFIG_AUXTRACE) += cs-etm.o
 perf-util-$(CONFIG_AUXTRACE) += cs-etm-decoder/
 endif
 perf-util-$(CONFIG_AUXTRACE) += cs-etm-base.o
+perf-util-$(CONFIG_AUXTRACE) += rvtrace-decoder.o
 
 perf-util-y += parse-branch-options.o
 perf-util-y += dump-insn.o
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 735f6c360064..5ccb5f3d9af8 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -54,6 +54,7 @@
 #include "arm-spe.h"
 #include "hisi-ptt.h"
 #include "s390-cpumsf.h"
+#include "rvtrace.h"
 #include "util/mmap.h"
 
 #include <linux/ctype.h>
@@ -1394,6 +1395,8 @@ int perf_event__process_auxtrace_info(struct perf_session *session,
 		err = hisi_ptt_process_auxtrace_info(event, session);
 		break;
 	case PERF_AUXTRACE_RISCV_TRACE:
+		err = rvtrace__process_auxtrace_info(event, session);
+		break;
 	case PERF_AUXTRACE_UNKNOWN:
 	default:
 		return -EINVAL;
diff --git a/tools/perf/util/rvtrace-decoder.c b/tools/perf/util/rvtrace-decoder.c
new file mode 100644
index 000000000000..58db5ca62c1a
--- /dev/null
+++ b/tools/perf/util/rvtrace-decoder.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V trace Decoder
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include "evlist.h"
+#include <internal/lib.h>
+#include "rvtrace.h"
+
+struct rvtrace_decoder {
+	struct auxtrace auxtrace;
+	u32 auxtrace_type;
+	struct perf_session *session;
+	struct machine *machine;
+	u32 pmu_type;
+};
+
+static int rvtrace_process_event(struct perf_session *session __maybe_unused,
+				 union perf_event *event __maybe_unused,
+				 struct perf_sample *sample __maybe_unused,
+				 const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int rvtrace_process_auxtrace_event(struct perf_session *session __maybe_unused,
+					  union perf_event *event __maybe_unused,
+					  const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static int rvtrace_flush(struct perf_session *session __maybe_unused,
+			 const struct perf_tool *tool __maybe_unused)
+{
+	return 0;
+}
+
+static void rvtrace_free_events(struct perf_session *session __maybe_unused)
+{
+}
+
+static void rvtrace_free(struct perf_session *session)
+{
+	struct rvtrace_decoder *ptr = container_of(session->auxtrace, struct rvtrace_decoder,
+					    auxtrace);
+
+	session->auxtrace = NULL;
+	free(ptr);
+}
+
+static bool rvtrace_evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct rvtrace_decoder *ptr = container_of(session->auxtrace,
+						   struct rvtrace_decoder, auxtrace);
+
+	return evsel->core.attr.type == ptr->pmu_type;
+}
+
+int rvtrace__process_auxtrace_info(union perf_event *event,
+				   struct perf_session *session)
+{
+	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
+	struct rvtrace_decoder *ptr;
+
+	if (auxtrace_info->header.size < RVTRACE_AUXTRACE_PRIV_SIZE +
+	    sizeof(struct perf_record_auxtrace_info))
+		return -EINVAL;
+
+	ptr = zalloc(sizeof(*ptr));
+	if (!ptr)
+		return -ENOMEM;
+
+	ptr->session = session;
+	ptr->machine = &session->machines.host;
+	ptr->auxtrace_type = auxtrace_info->type;
+	ptr->pmu_type = auxtrace_info->priv[0];
+
+	ptr->auxtrace.process_event = rvtrace_process_event;
+	ptr->auxtrace.process_auxtrace_event = rvtrace_process_auxtrace_event;
+	ptr->auxtrace.flush_events = rvtrace_flush;
+	ptr->auxtrace.free_events = rvtrace_free_events;
+	ptr->auxtrace.free = rvtrace_free;
+	ptr->auxtrace.evsel_is_auxtrace = rvtrace_evsel_is_auxtrace;
+	session->auxtrace = &ptr->auxtrace;
+
+	return 0;
+}
diff --git a/tools/perf/util/rvtrace.h b/tools/perf/util/rvtrace.h
index 93c041db8660..fdf2e5866c85 100644
--- a/tools/perf/util/rvtrace.h
+++ b/tools/perf/util/rvtrace.h
@@ -15,4 +15,6 @@
 
 #define RVTRACE_AUXTRACE_PRIV_SIZE	sizeof(u64)
 
+int rvtrace__process_auxtrace_info(union perf_event *event, struct perf_session *session);
+struct auxtrace_record *rvtrace_record_init(int *err);
 #endif
-- 
2.43.0


