Return-Path: <linux-kernel+bounces-780312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016B6B3004A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343D4AC335C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4ED2E22A7;
	Thu, 21 Aug 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mmf703Z9"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C72E175C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794318; cv=none; b=T12jygBfh3M6UvXraA7fBhLEqloHr/uBHrcPgqjB/RQ01Xl+NCR7bFnS9O3yhMW3HqWAHMdaI7y+00RY/5nNI5J8qQugZvinsP7gtDacvrDBeU3TK7ESAK1cYfKuAgjKUapmCvBWzo8aP1NPI6frSo4/8duzx4Vs/YyaNIihonM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794318; c=relaxed/simple;
	bh=NTnQ9k5u7R42OUwbz6h2J8KHt5rVMSa96bg96BbPHI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qdst/Us9P0RIG+aKY0ARR+NwS51npZxjgFRFUVu+1xxeUskAvXzOWMhRgYhSZsMxrxhRaqaG8L/Y2nsWsjklWbu4ZFy5Fts9xG5vyBrwGLuZIvV/q27ZKN25EJqMHMSbjiKfAeiTyHFZ+yU4zqi9WLkyy+RJkPY/uv3Cp3exlbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mmf703Z9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4716fc08abso985239a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794316; x=1756399116; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MCudO0lfsSIQDEPb/Z/odYNnD8Vvb98DSCImnP79+vg=;
        b=Mmf703Z9tiWAt8POjfmeVU2aeqvya8mb5rML1vBKQtoTyk4DJeoGONgorCcfWzztKZ
         p2pge+KSqNx4esEH6zMedLU8xj8/hAM2Utv/asf3jGrs/A2fgjWHJZ/Maht3F3XWRH9W
         5bEMCWC6pCAGGHqG3KYKmuVHLKoj4yZv1de0dumuSuAaOA9+HBjZ5HwLxpqsH/vI1XAb
         CsHxqGH+4n4DV7mlOGJIYCYscagF84riFScDQ2BSMXT1xtMqU+iCO2tUft1w9wGEvUJ4
         mYBLcpxaj++jgWPjtaTwg+icnXfsxFpDmmx1YI6yS8jf1fg0lvAS2qaB7u3x3IRM5Yqy
         F/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794316; x=1756399116;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCudO0lfsSIQDEPb/Z/odYNnD8Vvb98DSCImnP79+vg=;
        b=iNAR4xo4v+gwSv2c9oJ69MST6o9sQka4D78V4n4vzForM2O7OdwvwN9PYyh05FqmCV
         C7rPFAmlwlwCl8ZgjkVirIfWTf480kwkvvdxDNAgjLk64SnNlSYy6z1fwMR8yslIDTTA
         BiyqWQhND0eDAujAeJIRKN4+cHERoQGWO+TkE9hjwt6KU3REMqqHNjCKs6/CCsF/Tphe
         W8EBfgC3oyfFTLelSEsMRAgaOB9TJ5WNpWpGM5xdWP2VYy6pesISMdorU5C4aSS8OMU2
         MJGt4ghk2WF8KyihWgThEA626hF8sAlGAHXFwG0IrE/ObgkD2RvFSRwn7WT3w2Ic/1QN
         w4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUHXJctFWII+eZCmO/ERry4a/DC6tFAxS0lqFILHTagwWxVjjlarIS8VLO/uoKMli79VyBxHbIw0pqZ8As=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgkweA2NMfMVso/5o8iRiXWAOKzyOMkdud1198icjb4viIBae/
	8Xp0BuS85x3iiW82XQUB7AaadXQD2DclXq18I2owFjCBOsnJmILkdlE7qvuDuYgNIl50+CE9W8Y
	/9upxnsvRjg==
X-Google-Smtp-Source: AGHT+IEeCnJ7b7Yhroqp8lnq2iRmwlgzQFOIRcCjMoaZ7MBplMnR6IPn6gc3uaSySrJy+SPVwdt4sO/70rsg
X-Received: from pgbfm17.prod.google.com ([2002:a05:6a02:4991:b0:b47:68a7:75e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9b:b0:232:e6ab:8de8
 with SMTP id adf61e73a8af0-24330890004mr4446962637.18.1755794316246; Thu, 21
 Aug 2025 09:38:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:18 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-5-irogers@google.com>
Subject: [PATCH v2 4/5] perf test shell lock_contention: Extra debug diagnostics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In test_record_concurrent, as stderr is sent to /dev/null, error
messages are hidden. Change this to gather the error messages and dump
them on failure.

Some minor sh->bash changes to add some more diagnostics in
trap_cleanup.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lock_contention.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index d33d9e4392b0..7248a74ca2a3 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -7,14 +7,17 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 result=$(mktemp /tmp/__perf_test.result.XXXXX)
+errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
 
 cleanup() {
 	rm -f ${perfdata}
 	rm -f ${result}
+	rm -f ${errout}
 	trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+	echo "Unexpected signal in ${FUNCNAME[1]}"
 	cleanup
 	exit ${err}
 }
@@ -75,10 +78,12 @@ test_bpf()
 test_record_concurrent()
 {
 	echo "Testing perf lock record and perf lock contention at the same time"
-	perf lock record -o- -- perf bench sched messaging -p 2> /dev/null | \
+	perf lock record -o- -- perf bench sched messaging -p 2> ${errout} | \
 	perf lock contention -i- -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
+		cat ${errout}
+		cat ${result}
 		err=1
 		exit
 	fi
-- 
2.51.0.rc1.193.gad69d77794-goog


