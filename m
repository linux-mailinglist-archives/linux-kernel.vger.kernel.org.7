Return-Path: <linux-kernel+bounces-707444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4DAEC400
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 03:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CA9188CA61
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F131FBEA2;
	Sat, 28 Jun 2025 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTBTfSE/"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E41C8633
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 01:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751075919; cv=none; b=sHEHEc3AibzMY8/qihO82Y5/3nri6RibOa3kmKTLcOEqrCfTov7APqee+tvYmiz83fx+XPtqa0Mmx990sNLWMgwrQhiODcUVdLfhVsX6M3xBLzjR0R5JmvTnZDoRnPjZhpSUli1Cqv2Nb9IMa85uLAT4AJvDrWTPhX0eoVRjeFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751075919; c=relaxed/simple;
	bh=Ax6PVjysvVmkdZpiGPf+FNf8BQln7B9S7Vembicd0Lw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=i4eLydu0IZZttJ2cwdiCU9T822JMrOU2sFP2shJRlAqcLn+ikhjAwZPsV/IX3Z2uEFow9fjVE5SCidJvAml8xMHTEPiPOeBXRGubFMvCfeCpyqFugvT8a3ub6qAhiE6LnSMOsbofOM8ARoMS8OFH7N2LREwLzfoaSZFQ93ZdAgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTBTfSE/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23824a9bc29so2990965ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 18:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751075917; x=1751680717; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z4qJuZ+MbBlsjD8+LJUsz09T91b2pylsklhkgd6DbHw=;
        b=mTBTfSE/0mbhYB3Y4+5at6vDCWO8DMCck2WwE9qHh2YEdRzKI6PhGPMhgzYqQD+pKm
         2Pi7l/ysG9vdwQ1xVD2UdgDmhFr+dHVTY87ouayRQ+pLfZak80w1j39qV35oQEd2TnU/
         26OM4ySJNM72RB5eJg7k63bskutNuM7trTMffulvLZmb68xmNNJeL5YXLmw1jKD0RIcn
         DMw2WTkwBO5P5lN/wPeb3j9iRgqrBGjCvOZTrAHqEzMyEtq/EwWYUiMZp5gWrl4i2HDM
         eqeXMdnWsa4cifVwpxFp2vbAwMlWu7yQg3BmDKVfRxCNoyfHTqULTHe8xAN1OVFUE41E
         WDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751075917; x=1751680717;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4qJuZ+MbBlsjD8+LJUsz09T91b2pylsklhkgd6DbHw=;
        b=MOoUsKBHQGJ/w3VziuJU1CKpJYdFsImN1J+186TCCfYXPxJjs29gv3+hnYJ72lc3Ep
         vmrY9kqMvNYLMQ0xLExlDnJIkWUSIYA5Vo72aaYqPEivxc2w+Cu0jxw5l/OBMUpPiQUB
         05KYh8DVNeP55ehZl3H29VRXh8I2wxh8MtmA6ttOMg/VXjVmWgOCwmNfb2WoBDRfAUoJ
         EqI2EQZ1SMTjKYPZl4/5VBkRNAEWrgVE912u0gewqk2F4Th+sXxrbNXpSgQ0fgeW0Faq
         JMHa3+46RXRSRIsVgi41ST33E0a3wpzESJd23p5iTgtb3sBt3Ed72AZCoaSyWZQBV4mx
         IiNg==
X-Forwarded-Encrypted: i=1; AJvYcCXj8XM9Ihvs4Rm9H+81bPDJYmucJbNdVSiUDTUmdDA6VO+1zzgnpJLZzgbXv8zuoBlb5A2G5zluFVuXHWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuKqF/DLiKk6xznwitWLeMjm6ZERNzvxcMEOayAtW/+oQnQUAP
	5gBMoiQpY4flQpVi3Y85Y9i+t+SsG9wlV+x7ToNw1U7K6+X0nqmKKw74zHTUetCiRP/dOuZQJT6
	pXXksoyyJgw==
X-Google-Smtp-Source: AGHT+IGGX2i9/sB5hygu9P9bHsykzcDxhWCr90CHC0OLfMZKPAKCwX2cBOpOB0xzb5YRb+RXYw28+QsuFBf6
X-Received: from plbmu16.prod.google.com ([2002:a17:903:b50:b0:234:f137:75cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c5:b0:234:c549:da10
 with SMTP id d9443c01a7336-23ac487f607mr82121215ad.47.1751075917662; Fri, 27
 Jun 2025 18:58:37 -0700 (PDT)
Date: Fri, 27 Jun 2025 18:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628015832.1271229-1-irogers@google.com>
Subject: [PATCH v1] perf test annotate: Use --percent-limit rather than head
 to reduce output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The annotate test was sped up by Thomas Richter
<tmricht@linux.ibm.com> in commit
658a8805cb60 ("perf test: Speed up test case 70 annotate basic tests")
by reducing the annotate output using head. This causes flakes on
hybrid machines where the first event dumped may not have the samples
for the test within it. Rather than reduce the output using `head`
switch to `--percent-limit 10` which will stop annotate dumping
functions that have an overhead of less than 10%, the noploop program
should be using more.

Add the missing objdump option for the pipe mode version of the
objdump with a command test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 16a1ccd06089..689de58e9238 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -53,21 +53,22 @@ test_basic() {
   # Generate the annotated output file
   if [ "x${mode}" == "xBasic" ]
   then
-    perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+    perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 10 2> /dev/null > "${perfout}"
   else
-    perf annotate --no-demangle -i - --stdio 2> /dev/null < "${perfdata}" > "${perfout}"
+    perf annotate --no-demangle -i - --stdio 2> /dev/null --percent-limit 10 < "${perfdata}" > "${perfout}"
   fi
 
   # check if it has the target symbol
-  if ! head -250 "${perfout}" | grep -q "${testsym}"
+  if ! grep -q "${testsym}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing target symbol]"
+    cat "${perfout}"
     err=1
     return
   fi
 
   # check if it has the disassembly lines
-  if ! head -250 "${perfout}" | grep -q "${disasm_regex}"
+  if ! grep -q "${disasm_regex}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing disasm output from default disassembler]"
     err=1
@@ -92,11 +93,11 @@ test_basic() {
   # check one more with external objdump tool (forced by --objdump option)
   if [ "x${mode}" == "xBasic" ]
   then
-    perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null > "${perfout}"
+    perf annotate --no-demangle -i "${perfdata}" --percent-limit 10 --objdump=objdump 2> /dev/null > "${perfout}"
   else
-    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+    perf annotate --no-demangle -i - "${testsym}" --percent-limit 10 --objdump=objdump 2> /dev/null < "${perfdata}" > "${perfout}"
   fi
-  if ! head -250 "${perfout}" | grep -q -m 3 "${disasm_regex}"
+  if ! grep -q -m 3 "${disasm_regex}" "${perfout}"
   then
     echo "${mode} annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
-- 
2.50.0.727.gbf7dc18ff4-goog


