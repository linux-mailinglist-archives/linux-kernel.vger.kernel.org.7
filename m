Return-Path: <linux-kernel+bounces-693028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 378A6ADFA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 02:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7ABE189EEF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 00:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3AD634;
	Thu, 19 Jun 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyACvprE"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C651D555
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292689; cv=none; b=rHCQc29sUUP1OfYFj0vj7j/sryFp9H3kPrm0rA/1SOxI5DgKQjB9X3XvO0ufKQXFBOZHt3PXBzKv5Swi0XkhFjqMyDQVRssPZHyrSatZz/LB0vE8InzkhNkC0w6Ex4NgYBdgeZTVa3wwwOpJOfs6uYkrps6oRbOVgYlvdutWi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292689; c=relaxed/simple;
	bh=NewwN4RPE7BHdcREEHS9Gp9Bq8qzjxUMrwfsyM2ngTc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Bnleacv34h6Dk3byUo/o049wTsi0EMBcF/0vghTOnXkqQxs1djnA49eZ+FMCtbzs6Y15qDkxcNVoLelPNVuocBpdQ0pTcfTo2QA7K6zm1syc2vvOrdgEc6G8aIqxRzxBIOhf+5qOLHQ9sz9nQxZ5EAeoSSiOoIIcc2Wv1L9Fqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyACvprE; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747af0bf0ebso151340b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750292688; x=1750897488; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GR416osTWevjir5IPTUtOXKt4AGP7e4u/2bT2JOfmqk=;
        b=fyACvprE3nDRZIByesNRPqr7h+leucotS032elwx7SxW2zv/aKRvZQ5J/cnIvmiqTc
         o0zF/HpiurJg08AD//d1A4eFzrtavVtNfo+KxoWddPAzAeBzfoVd0775CtLll2Q4s4tS
         8AXN9IMjqPbcYhfVBh4WVFxb4yaTdM2npYtObVMTJbhiQteSkxEG9/5qLZu0oN1LVN5k
         JxyA5RiTsJke7iWGrS8MU8CIZHeNbNdwXWb/Mxzw46C7lL0ujfRkCmsKfsVHp/xO6Czb
         HweyY7HY9wd4G6/4uR1sQUeE7MYLs0wmHFnLh0v/r+rn4DFJA4Z612TZYlbfSpaTA4H1
         gHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750292688; x=1750897488;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR416osTWevjir5IPTUtOXKt4AGP7e4u/2bT2JOfmqk=;
        b=RxpmQY+ZUgEAPVC0lyO/3vyXFG1HExML545+dqn6tYQGwj0s6MD4ei1FGZy7LyaLPX
         hh7cDlVVSAgI6CtnR4LrO8RJt8RzArFon3qPmeUH0laUieu33Cni7nMuApDkaL8PYZUj
         XKosu3Iai6g1idiKul5qM/UG8G1cnDwvea1Oh+VcbyQjMFTFS9vaJigq/t0LgSfpAImj
         qTTpi7FXxTTdZkyawUSjc3+zkfHxdZcRPUUgB1K7nYZzG58/gBD8OWD65XN/51oC9tbR
         UhDHjj4+r/e0zT9F1J6KuAckFO0ehqW4NengZ+rUi6W2qsnwDGzD98UAvgC41dbKmOzk
         j+og==
X-Forwarded-Encrypted: i=1; AJvYcCXvC47QLsDOVOwbhpUSjsLCxSp7gIYqF7pG8ML8CAE6CieJyRsMvkQgzlzaIL6Q+yREOW90MK1DLGdXL3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEOZD11wCVkJeGL7y71SfMeuy7cG+Bg/RBJMP/jq3rbA3RS45
	RGxRh/GbKQzzSeDLgWm1y/GuhFOZO6IopZGsUJI3gWtTIa28BOn2c7ik+kKjqsWvHacI8avzoWY
	q9xyQg0KN7A==
X-Google-Smtp-Source: AGHT+IHLowUPcLb1AsoedloUBtGHZIvYsXFAHsudDPVaZi3qGGgXzLTZOOecHMUjXB8s/QSKjkglN4btCO8q
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:747:9faf:ed39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:418d:b0:748:e9e4:d970
 with SMTP id d2e1a72fcca58-748e9e4de0emr5691992b3a.1.1750292687648; Wed, 18
 Jun 2025 17:24:47 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619002443.100301-1-irogers@google.com>
Subject: [PATCH v1] perf test: Add basic callgraph test to record testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give some basic perf record callgraph coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 2022a4f739be..603fa6b79b5d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
+testsym2="brstack"
 
 skip_test_missing_symbol ${testsym}
+skip_test_missing_symbol ${testsym2}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
@@ -359,6 +361,23 @@ test_precise_max() {
   fi
 }
 
+test_callgraph() {
+  echo "Callgraph test"
+  if ! perf record -o "${perfdata}" -g perf test -w brstack
+  then
+    echo "Callgraph test [Failed missing output]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
+  then
+    echo "Callgraph test [Failed missing symbol]"
+    err=1
+    return
+  fi
+  echo "Callgraph test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -374,6 +393,7 @@ test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
+test_callgraph
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.50.0.rc2.701.gf1e915cc24-goog


