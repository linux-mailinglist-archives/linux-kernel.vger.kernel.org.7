Return-Path: <linux-kernel+bounces-658285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5043ABFFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 00:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC9D9E42B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212E237176;
	Wed, 21 May 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hu9qRlG9"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C91EA65
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867519; cv=none; b=BLU618f6+AQC6dDvV27hTwaNRrFUxYOGjQTbK34Fb2stMz17PtZRYf7FnjcsaMZRyl1FJ42eNrSvMSVIzhFEKHutJxAYxdDfqddUbX/j6sNBQ7NLZcR8lRo2CAkVmSRaIXOKVuR374Fs7xowVWBaW8jqwCUxgZD2XahsPBSCjQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867519; c=relaxed/simple;
	bh=xZgJo2U5Oqlv+e+ZIxQH/yIo94gPJK+soITSMOLMTbQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EyXLBzCRz2GnRdcDjOvkIxPUvyPrxBGPx9LhjTMl9JtCCZc4j6yqWkuQUMO7ujSoyDZg7rxTKi8W5zcBWnp1/u+yC2V57n4GOPS7u2vGRW+HiMWRLJ+VBDYcbrB9sk9pbn6t5gcB88h60DB9FD/c31e4cw49qS6FKEnHiM4VUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hu9qRlG9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742cede1473so5545644b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747867517; x=1748472317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfHI5fGKLQI+x+/KKWzuEGZWb5ffWuVi94dEzPRM36E=;
        b=hu9qRlG9EglB6Q4FKIOmcrU6UfxUd1Eh6C/9zdSMvSxrDoJyPHvNGpTDSW2YmJN6Wj
         bTdN5CNLUxs8m6KGIFqjHpmmc4jwfMVsIoiOGEZanDluyaqPN9WF3NExEzCxSWEIkXD+
         blo788tfuFDMmmlGC+IOPtaxGsLS536DqaylhETbeEw/GHtuX2G493wb9bw3ZIP3ZpF1
         +HJKg0qpUy0QVfKH4inKERJFYZdL4lViKSX546qrN+YXSqp8vtqQC8lNJYva/HHolN53
         sxlbtxbC6zWZEwY1Igu5mwLzFJS8hlSzkSOuVSpg9yVMlFlJOsphg43kR+4v0+08+Cc8
         DnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747867517; x=1748472317;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfHI5fGKLQI+x+/KKWzuEGZWb5ffWuVi94dEzPRM36E=;
        b=WZ3ENFULYEvaCxpKFbVcEhEXcy+nGt7MUESbzijmZKexHpb4oecXkPmevW49xSMMH4
         xmmypEK00AJjFPv/UdICDx+1FhaYC590pxctQuLNzXkhCIjMWtQ88tSOqtQG+IvC9LE1
         xHQfockgbaoqnTA1KvuVs88OFDNy5Q327/2dAShlM7TCn5UvMjgg4P0vAK19+CItsFgX
         3VvCOoyZfq7SzybAr1Dm92yA9rInh9YuEZy7er2GAvFwflJTO0wbt1sLdYMroI8DbAI1
         pXMRZtmfKBKY6FX9h//pj1+iUUKIvXxQ+mA+Nr99RZ2oxDy+rrs/ZJcnnYC/k20qL8h6
         aUcw==
X-Gm-Message-State: AOJu0Ywj0CydazGPMYCc/rf4MmwfaYCublLPhBdZC8Uo2/RHAlHr/i/d
	DpD1B7PV6msUiHc7kzqgl87axv+TLqlbhcOtlL7ijhaE6wI6pfGS7oeEQflcHLmqNb5WJVCRvdw
	ov1n0GSDVnIB4pa5tCTVJnHwDdP9pITiwUhHcozDNj6/i4wjDoZlO2oMK3wJ69q0G5Xep43vavr
	23kgC/xgZnAw0tTRzry2cvSSKUizY5ycYUNWjrHM3uydHK
X-Google-Smtp-Source: AGHT+IFszDobkiUraJeHgcNFZihIdTuBuhQC8bh9e/uK8oYBjvn0Ued33hZeuVzToZnZSjSAqeU04nhT2iI=
X-Received: from pfwz39.prod.google.com ([2002:a05:6a00:1da7:b0:740:3f40:b53b])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3492:b0:742:9bd3:cd1f
 with SMTP id d2e1a72fcca58-742acd728eamr28948980b3a.23.1747867516825; Wed, 21
 May 2025 15:45:16 -0700 (PDT)
Date: Wed, 21 May 2025 15:44:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521224513.1104129-1-ctshao@google.com>
Subject: [PATCH v1] perf test: Restrict uniquifying test to machines with uncore_imc
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test would fail if target machine does not have `uncore_imc` devices.
Since event uniquifying behavior is similar among different
architectures, we are restricting the test to only run on machines with
`uncore_imc` devices.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+event_uniquifying.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/perf/tests/shell/stat+event_uniquifying.sh
index 5ec35c52b7d9..5a51fbaa13bb 100755
--- a/tools/perf/tests/shell/stat+event_uniquifying.sh
+++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
@@ -9,7 +9,8 @@ perf_tool=perf
 err=0

 test_event_uniquifying() {
-  # We use `clockticks` to verify the uniquify behavior.
+  # We use `clockticks` in `uncore_imc` to verify the uniquify behavior.
+  pmu="uncore_imc"
   event="clockticks"

   # If the `-A` option is added, the event should be uniquified.
@@ -43,11 +44,17 @@ test_event_uniquifying() {
   echo "stat event uniquifying test"
   uniquified_event_array=()

+  # Skip if the machine does not have `uncore_imc` device.
+  if ! ${perf_tool} list pmu | grep -q ${pmu}; then
+    echo "Target does not support pmu ${pmu} [Skipped]"
+    return
+  fi
+
   # Check how many uniquified events.
   while IFS= read -r line; do
     uniquified_event=$(echo "$line" | awk '{print $1}')
     uniquified_event_array+=("${uniquified_event}")
-  done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
+  done < <(${perf_tool} list -v ${event} | grep ${pmu})

   perf_command="${perf_tool} stat -e $event -A -o ${stat_output} -- true"
   $perf_command
--
2.49.0.1143.g0be31eac6b-goog


