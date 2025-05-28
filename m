Return-Path: <linux-kernel+bounces-664573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77066AC5D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 01:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D1A3B2D16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951821B8EC;
	Tue, 27 May 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="L3GOZjA6"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42255218E99
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748386903; cv=none; b=L3iWPfLv0+DbV1NzZPeZVrDaZEtUC5KG4uQ9mHIpBgoO3GzPTLRnS5LTSl61Da1p+ts0eWOzHCqdc5A/pgoy1S07wSIbEg0+t7TkNXGIr5Zx8K7z5lpCuOn7cesgdxB917a5KKFGnArqlMfmuR/AktiABCd1RwTZPZTrOwz91MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748386903; c=relaxed/simple;
	bh=ZJhwzOmSuVIRZM6C8NuS6de5d62hXA7N2bsVv3NkUsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATV2dbBEYdFO3OACdS3V/oiVtkLqNUNGe86wGXd4gg2voVvtd4uxRsOAQ6u9dO9RQIT9vN3ar73Ek6i6MMabbbV68+Ncs9z+YLU5d/M6lgNzCq+DlvbNpIh3TpaZB0L0QWVccRlrm2arGo7NV7ZlsHJwhKbkHIuQ+z6xffOus1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=L3GOZjA6; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7399838db7fso313943b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748386898; x=1748991698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pESW1DmGA2xfvhcuYLJNJRRdLKXFlLJ673mH8jAFaME=;
        b=L3GOZjA67qnzopHX+gwvrN+D33hVOmpnNXHi54tfO+XwpLRWqwTZLmUtAEeWVkMxWt
         V0WRXVZcvNISOi0jkrDFy9HvC4lTIgALlsxH6hfaGOsXreTpjueLJXiMdDROOHurz78K
         Vc3eBhZyWvVBPjnrtKc9x0MHwvPPumJ0wiJWkPQwKulVSazu3DsHvPY91o3jkOktxwEa
         9EscCq2jHsAER+4TdTteYNPUJIwAazoTPzkn6i0n1REZp5msgEUfFM/1JagCtp159uvC
         wcp3ywKhQXQs3QkAylAN3+vZv+i+DRYmIkoAjFFGd3u7TlwJwZkkg573hx9k/yzUKVrg
         MaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748386898; x=1748991698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pESW1DmGA2xfvhcuYLJNJRRdLKXFlLJ673mH8jAFaME=;
        b=P5GLt9QkWU5VSopwhWZH8s5LFiF4OaV2A4zczfNvojdQeDFrTUdBF+YvDVGsF+EAjn
         m8XS4kCkcTozaKpyMrNcADdrroB9sBIkcDtiVX2z/izIpzeUeqydLiPW4fNEa69ApPRG
         OlHBbiZhcyQT8PAVt+0vRlAz2QMxnfHePgTOnnpH8INMPL/UsW2qSsCH0oPP6Lg0EeJp
         /jKyTlyXeL//lSkNIdpEBpYlsLohAcArGoHtEhJe277/zgl8qInhsaCkKG2/IFyLRcQk
         NaAFpQF/o8qCRN/DVUSvzW8Hjg5zypXMrcA3MCFRJ1dgPfh9UZHzWPFVmaaf96LyTttE
         6Q4w==
X-Forwarded-Encrypted: i=1; AJvYcCVqy7ZULytzy93wiXXQSFKMEZ9Uo88A0NZlIsr4Ov/5gEaPyUEarT7APlUtFKLvlfAKshrmmlbNRtOe8UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcpeB1E191hr7DFp/ORhv0AqelXLWGWqLCgmMlE1XjPfehRCl
	/MQ+Zi68x4rEonhqiL0FQjKKsIqPoWZd+yw8UeNccyfpsQp0icv69NluL35hQ7xkyVggh1ioZGP
	xtwLHLAeeXNdOpIYobJDseNakYZs0UoY2wQfTMV8sitivZ7D9ODbR
X-Gm-Gg: ASbGncusxhnbkOK1Adf8/oBMq+Jd715NEzhHuC3DTzWV1kMtc0ml2wIa7R4893dCgtt
	ntCubvgC/HToyAOyN241gWkDfXQryKV+ou9m7Rb6KRll4BR4OumnK9XEJP9Y2pXLwWmz6OlT3OT
	jwFftKIwI/dLMj4soZXrQsAYhh+PA+0jxwD+240GNyC3F5cnkYtbspLhTTw/PXAhhqalsvzNFt1
	gdGOkwdfXPiqooaWBV0cAKCr5/jb6VFa6RvqIz7jynt3PBoJcwo9Jd7pdygZhLycDgZJkbP2veS
	ErD9gH4jlWkqsuvUUEliYDQ+5OeobhE=
X-Google-Smtp-Source: AGHT+IEyBOauqRJ5lW8gx8T3lFoPJrKU4MWzljukglU4aN8knHconNg3KXU4KFaMeY8fZSb7CJ3vmEDTr4Ww
X-Received: by 2002:a05:6a20:cfa9:b0:218:574e:830d with SMTP id adf61e73a8af0-218ccd94689mr3199088637.21.1748386897772;
        Tue, 27 May 2025 16:01:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-746682d5eddsm10864b3a.24.2025.05.27.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 16:01:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 45908340998;
	Tue, 27 May 2025 17:01:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4376AE539B9; Tue, 27 May 2025 17:01:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 27 May 2025 17:01:30 -0600
Subject: [PATCH v7 7/8] selftests: ublk: add test for per io daemons
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-ublk_task_per_io-v7-7-cbdbaf283baa@purestorage.com>
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Add a new test test_generic_12 which:

- sets up a ublk server with per_io_tasks and a different number of ublk
  server threads and ublk_queues. This is possible now that these
  objects are decoupled
- runs some I/O load from a single CPU
- verifies that all the ublk server threads handle some I/O

Before this changeset, this test fails, since I/O issued from one CPU is
always handled by the one ublk server thread. After this changeset, the
test passes.

In the future, the last check above may be strengthened to "verify that
all ublk server threads handle the same amount of I/O." However, this
requires some adjustments/bugfixes to tag allocation, so this work is
postponed to a followup.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/Makefile              |  1 +
 tools/testing/selftests/ublk/test_generic_12.sh    | 55 ++++++++++++++++++++++
 .../selftests/ublk/trace/count_ios_per_tid.bt      | 11 +++++
 3 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 4dde8838261d660ba31a07d608332d1733a6321d..5d7f4ecfb81612f919a89eb442f948d6bfafe225 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -19,6 +19,7 @@ TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
 TEST_PROGS += test_generic_11.sh
+TEST_PROGS += test_generic_12.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7abbb00d251df9403857b1c6f53aec8bf8eab176
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_12"
+ERR_CODE=0
+
+if ! _have_program bpftrace; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "null" "do imbalanced load, it should be balanced over I/O threads"
+
+NTHREADS=6
+dev_id=$(_add_ublk_dev -t null -q 4 -d 16 --nthreads $NTHREADS --per_io_tasks)
+_check_add_dev $TID $?
+
+dev_t=$(_get_disk_dev_t "$dev_id")
+bpftrace trace/count_ios_per_tid.bt "$dev_t" > "$UBLK_TMP" 2>&1 &
+btrace_pid=$!
+sleep 2
+
+if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+	_cleanup_test "null"
+	exit "$UBLK_SKIP_CODE"
+fi
+
+# do imbalanced I/O on the ublk device
+# pin to cpu 0 to prevent migration/only target one queue
+fio --name=write_seq \
+    --filename=/dev/ublkb"${dev_id}" \
+    --ioengine=libaio --iodepth=16 \
+    --rw=write \
+    --size=512M \
+    --direct=1 \
+    --bs=4k \
+    --cpus_allowed=0 > /dev/null 2>&1
+ERR_CODE=$?
+kill "$btrace_pid"
+wait
+
+# check that every task handles some I/O, even though all I/O was issued
+# from a single CPU. when ublk gets support for round-robin tag
+# allocation, this check can be strengthened to assert that every thread
+# handles the same number of I/Os
+NR_THREADS_THAT_HANDLED_IO=$(grep -c '@' ${UBLK_TMP})
+if [[ $NR_THREADS_THAT_HANDLED_IO -ne $NTHREADS ]]; then
+        echo "only $NR_THREADS_THAT_HANDLED_IO handled I/O! expected $NTHREADS"
+        cat "$UBLK_TMP"
+        ERR_CODE=255
+fi
+
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
new file mode 100644
index 0000000000000000000000000000000000000000..f4aa63ff2938a4097c2b848f379dbc87fe898a7f
--- /dev/null
+++ b/tools/testing/selftests/ublk/trace/count_ios_per_tid.bt
@@ -0,0 +1,11 @@
+/*
+ * Tabulates and prints I/O completions per thread for the given device
+ *
+ * $1: dev_t
+*/
+tracepoint:block:block_rq_complete
+{
+	if (args.dev == $1) {
+		@[tid] = count();
+	}
+}

-- 
2.34.1


