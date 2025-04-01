Return-Path: <linux-kernel+bounces-583918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88361A78161
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6348188CD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD77C20E6E7;
	Tue,  1 Apr 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcn3R1Kc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD31C8612
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528202; cv=none; b=iyIS5Sj2+ecwTRRkAgi0CxZ5rCk2YdtQW9EwRdy6TZ3wWiCjHFJGX7wm1hGjlziIQpivCn33gmZGcv4xBOW7HOGJyOX4JrLuRk8UKC3UGrYyA+yyD5rZnnotJvzK1pZBQKfSheRsXOZBPOpUNgNtKqaGbpP5yGdIB0lhmbBLzDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528202; c=relaxed/simple;
	bh=Y2NVahqoWXbrwHtxeCMK+uMCUCqvZjwCroDdCq/+QLk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AE46TZUqvD9bFcvzfiP5+yHiPYJEhdxn2YhnnhcQwrcCcrY5iesltN4LOde0ftwbB9z/CPSb6k0MDX2I7YXY0709PiUvK9jqJ5NRmAcNUT0cqWT5n1oJoyiob1W89BZ/blqgYWljpODCqcixk8l9UlSo71rZTZ5hIrXloHQFFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcn3R1Kc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-224364f2492so100603235ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743528200; x=1744133000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QyQc1obK807oGm0cfb/LDMQ0LSKhQg0xMePPIJKuS8c=;
        b=pcn3R1KcVM9TcevdCch3Kcg9lr31ors9WVdlRpWmg6844kjP3vCyLo5c8pD/ZR3//e
         kg3Rm3t/zpy7lkeE36s7g00lr52UYETnJCdL8YdyM5aNyH94jny1oqGihJlcJcv8ycFd
         z2qHD1lKLtFcO7r/dEzOm18AzbzQUywjOzP1RYT6uTmo1ZNr43GMBjh8gd1PqPWs6OE6
         b5X2H6SXK1oyVTnGeThXUjTA96ALCOFesLHjHz7h4adA+bzKLidVTzRP5gRxShcpmAen
         kOXc0pjzbBRhUk0r5f5faQ7TnTsFAnyKdb3ujoLfg9dGIACLXr86smYpwrg+7iGijdmO
         42Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743528200; x=1744133000;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyQc1obK807oGm0cfb/LDMQ0LSKhQg0xMePPIJKuS8c=;
        b=tpOF2YqQQPwzEF+NcmCczYXrcr/AszZJd07sezNEer9pKAgV3AJx5iDwynScCOt0BP
         aPvidTozPnkaaH/vV4NAZ4owjkpfxHV9jTGHIGuFTzV/yCupYjfwznzXwa5YzgYruizg
         P4bUtp4oHsrtHJ1vCqqqHqipGnvtEbYyEM5VpGREfQGV1TQ6xF/BndV2cPzy+b/P+sdU
         s3UunZopGgiuxWuudhWAz9XHZQMCnDFi46YUlm5jMq4MMcrpo9J9ueQjcuv3hNLlc2PV
         Z+2jQVUNeoG7/rIt/61SpVb9G33jbG50Clq7JYaiM8ekEmjBpiKWXUhl0vmydsL+uOqP
         0jbg==
X-Gm-Message-State: AOJu0YyxNYlAIxwjCqe2PbDWYxFYZXDVhHwWeyeVVpagbUT/+A5Ep5IJ
	T/aWPwjYrYtkh94Bfluuk7OMfE5yr9nPLr0Ilm1s1ARZpx5ufiX1Vnx1bk3FG421UwsQjSWJGTo
	+uR+l6B8HnhFFqkZ+cuGj67brrra17FOVHh+lB05XlUCTk1qBRXobwTI6EwJVr613npqFmRB2OH
	uZMLkOBMUKimB9ElxFsZPV16fgiEApWH9oulmhnpa3
X-Google-Smtp-Source: AGHT+IGn+uWDpPJQ9Q1BejGtkWcrh2IzP2FyqV2ddY2F5XEVXCBFVJjOzAB/x4JxfBcyHKprrZEnk1kDv/k=
X-Received: from plbkq8.prod.google.com ([2002:a17:903:2848:b0:21f:14cc:68b0])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74e:b0:229:1619:ab58
 with SMTP id d9443c01a7336-2292f9fb8f1mr231063535ad.43.1743528200018; Tue, 01
 Apr 2025 10:23:20 -0700 (PDT)
Date: Tue,  1 Apr 2025 10:22:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250401172302.1442092-1-ctshao@google.com>
Subject: [PATCH v1] perf test: Allow tolerance for leader sampling test
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, dapeng1.mi@linux.intel.com, 
	vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a known issue that the leader sampling is inconsistent, since
throttle only affect leader, not the slave. The detail is in [1]. To
maintain test coverage, this patch sets a tolerance rate of 80% to
accommodate the throttled samples and prevent test failures due to
throttling.

[1] lore.kernel.org/20250328182752.769662-1-ctshao@google.com

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..1bbe16fb3420 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -238,22 +238,35 @@ test_leader_sampling() {
     err=1
     return
   fi
+  perf script -i "${perfdata}" | grep brstack > $script_output
+  # Check if the two instruction counts are equal in each record.
+  # However, the throttling code doesn't consider event grouping. During throttling, only the
+  # leader is stopped, causing the slave's counts significantly higher. To temporarily solve this,
+  # let's set the tolerance rate to 80%.
+  # TODO: Revert the code for tolerance once the throttling mechanism is fixed.
   index=0
-  perf script -i "${perfdata}" > $script_output
+  valid_counts=0
+  invalid_counts=0
+  tolerance_rate=0.8
   while IFS= read -r line
   do
-    # Check if the two instruction counts are equal in each record
     cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
     if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
     then
-      echo "Leader sampling [Failed inconsistent cycles count]"
-      err=1
-      return
+      invalid_counts=$(($invalid_counts+1))
+    else
+      valid_counts=$(($valid_counts+1))
     fi
     index=$(($index+1))
     prev_cycles=$cycles
   done < $script_output
-  echo "Basic leader sampling test [Success]"
+  if [[ "$(echo "scale=2; $invalid_counts/($invalid_counts+$valid_counts)" | bc)" > 1-$tolerance_rate ]]
+  then
+      echo "Leader sampling [Failed inconsistent cycles count]"
+      err=1
+  else
+    echo "Basic leader sampling test [Success]"
+  fi
 }

 test_topdown_leader_sampling() {
--
2.49.0.472.ge94155a9ec-goog


