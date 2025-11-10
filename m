Return-Path: <linux-kernel+bounces-892267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BABC44BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E321345E57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E232222C0;
	Mon, 10 Nov 2025 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/49uz+4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7258171C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738376; cv=none; b=Wp/U1yR1xmwvBL+6o85Xg+eIpfrcgtPbcv36Yt3GOVcxBHnSB002qjPUvwM9eSlLct5MODHdplpnV0RAfc+JSIHwoKrpa5gpdATKe9O4FKP/jsoS33hYmjf+SGhNZFekwsbw2r7pJtphTVVSJ86wqEi389+XSTNoMNqsSTNU8Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738376; c=relaxed/simple;
	bh=DRtl76zg9aNmLA1hizzZeGzHlOhcwzKDdt7h4eomINQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cQ/xIk6fhcpVcDC5hJYVjeMMmzKEJ7KW2WGAAcmRyzp4BKVa8NC2MxUvdeNi1tVLwwV9QBOFDSdGNrklvCidqgd1VDbYDqoFRdoUV9p6k8DXYJL6biupf8cUAQNF7UXwGGJzgOU7LBxNVU9h2V0fnJFxQ3LyGTeW6m6mOSRzkUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/49uz+4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297df52c960so44835435ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738374; x=1763343174; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQaN0dmrxTGK2FKPY285ZdcIP3sq0JzMu0hYDJFJ/ek=;
        b=s/49uz+40QwnSowJrvVqiHTHT02X3HrtZJEcdpujI2nKjbYrNbE4vJz++lUkYVoAfx
         MztXgp6sNSj4BtJ92VkQc87nKEoWYgNWtlPnV0MkeYX2dq3wguDAdA3NCTcE53Gx4e8W
         R9mCVOn9vGYPSBxjNFKf6i1Fxkq0Ww8WrNPro99Dttr7tB5CKxMpexIQRu6D7wpPrdTS
         3R5p7wEUB4CxUsn0SjGg9+0gpoe2kYRY5OLEpleTVLsRNSfOex2z/0ELbaxOhNeW0Exu
         cLIoi++2egVBPkEF4Zk6qkGwKtEdSukWSXq/KDBJSVSSIul2MSawsm3BE74AkienbDO5
         oxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738374; x=1763343174;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SQaN0dmrxTGK2FKPY285ZdcIP3sq0JzMu0hYDJFJ/ek=;
        b=MyHEKIuRaA+/9dbmdEwoDfYsl3oJdfnpNTbNU7qkAlnQHJCXTiOdv/lSWfMEGSdCS6
         hoHo6nZ0QBCJMs+xXTBGlsRsrg1CjyHstygq0iSzjwbFoQwWVpAW+hJvu96HRhaUCGac
         xKQKxTG80coMtyTV5g0zrGhRcm5HCif3N78wd0K7qZdhpg8kxYbz8mqs++KhuERMYAe7
         P7NKDWqZNQuVgKuRs0G0TqiDuU8Hsp0twty30lFSidsVuOCiHjNqHs425QnzAhf1lbsC
         3iI1X3jY9BbMyyHnyqL/lTdLdVMjOwR1NtFbzdVmj+qDvTJPUAXuE0rlFFM+eqlJP9rr
         /hQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwMAjt+rmkQu+WSEJaaO4u9fW3OFreTkr1kZ/RnIjuxP44ab5GK8MAvGyqm5Adz9LKDChh/U6WtjEZP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZtjSfBrY/Plt+z20eECQr5/n7UOpShZOgRZ+uFotGYVh6au/+
	B+xpeC66fPZ9ER9PXEDnMxivO75rP6YpXxkXJSgt2+IzeTH3QBBmOU9Q8VmDmbMO+0a/ZUW4L7m
	cJSoHSTaKhw==
X-Google-Smtp-Source: AGHT+IGB3B4t2ALjQw6hoZpIdk2YjM1WUkFpTHWdqU5SZUNgW/4Q3DrkcHG6mPsW6oI2SQpuz61ju+MhomgQ
X-Received: from pldr4.prod.google.com ([2002:a17:903:4104:b0:297:dd14:906c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f908:b0:295:70b1:edc8
 with SMTP id d9443c01a7336-297e53e7d36mr66908965ad.2.1762738374149; Sun, 09
 Nov 2025 17:32:54 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:48 -0800
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf intel-pt: Use the perf provided "cpuid.h"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than having a feature test and include of <cpuid.h> for the
__get_cpuid function, use the cpuid function provided by
tools/perf/arch/x86/util/cpuid.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/intel-pt-test.c | 6 +++---
 tools/perf/arch/x86/util/intel-pt.c       | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-pt-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
index b217ed67cd4e..970997759ec2 100644
--- a/tools/perf/arch/x86/tests/intel-pt-test.c
+++ b/tools/perf/arch/x86/tests/intel-pt-test.c
@@ -3,7 +3,6 @@
 #include <linux/compiler.h>
 #include <linux/bits.h>
 #include <string.h>
-#include <cpuid.h>
 #include <sched.h>
 
 #include "intel-pt-decoder/intel-pt-pkt-decoder.h"
@@ -11,6 +10,7 @@
 #include "debug.h"
 #include "tests/tests.h"
 #include "arch-tests.h"
+#include "../util/cpuid.h"
 #include "cpumap.h"
 
 /**
@@ -363,7 +363,7 @@ static int get_pt_caps(int cpu, struct pt_caps *caps)
 	memset(caps, 0, sizeof(*caps));
 
 	for (i = 0; i < INTEL_PT_SUBLEAF_CNT; i++) {
-		__get_cpuid_count(20, i, &r.eax, &r.ebx, &r.ecx, &r.edx);
+		cpuid(20, i, &r.eax, &r.ebx, &r.ecx, &r.edx);
 		pr_debug("CPU %d CPUID leaf 20 subleaf %d\n", cpu, i);
 		pr_debug("eax = 0x%08x\n", r.eax);
 		pr_debug("ebx = 0x%08x\n", r.ebx);
@@ -380,7 +380,7 @@ static bool is_hybrid(void)
 	unsigned int eax, ebx, ecx, edx = 0;
 	bool result;
 
-	__get_cpuid_count(7, 0, &eax, &ebx, &ecx, &edx);
+	cpuid(7, 0, &eax, &ebx, &ecx, &edx);
 	result = edx & BIT(15);
 	pr_debug("Is %shybrid : CPUID leaf 7 subleaf 0 edx %#x (bit-15 indicates hybrid)\n",
 		 result ? "" : "not ", edx);
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 2d7c0dec86b0..b394ad9cc635 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -12,7 +12,6 @@
 #include <linux/log2.h>
 #include <linux/zalloc.h>
 #include <linux/err.h>
-#include <cpuid.h>
 
 #include "../../../util/session.h"
 #include "../../../util/event.h"
@@ -34,6 +33,7 @@
 #include <internal/lib.h> // page_size
 #include "../../../util/intel-pt.h"
 #include <api/fs/fs.h>
+#include "cpuid.h"
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -311,7 +311,7 @@ static void intel_pt_tsc_ctc_ratio(u32 *n, u32 *d)
 {
 	unsigned int eax = 0, ebx = 0, ecx = 0, edx = 0;
 
-	__get_cpuid(0x15, &eax, &ebx, &ecx, &edx);
+	cpuid(0x15, 0, &eax, &ebx, &ecx, &edx);
 	*n = ebx;
 	*d = eax;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog


