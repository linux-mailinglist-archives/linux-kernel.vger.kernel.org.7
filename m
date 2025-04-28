Return-Path: <linux-kernel+bounces-623894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEFEA9FC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 23:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFC5466837
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 21:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185D20E704;
	Mon, 28 Apr 2025 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hsn+CXyW"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA020B7FD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876056; cv=none; b=Z+tfZCrWu0GgjfD3PWrcXdOZmIp7UxCzUTK1Q0CP98CypplqFakvtsfN0S/rqQaFBjlM1jMeGg7V+gVmb52RMNVpTp9+PXEyLNJYEeB791Wa4Qz9B/QCMhsCOY0eksZPU7ea4KwkQazOUgEkD4wpm5UYmckgqrR5qUtL2LOYit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876056; c=relaxed/simple;
	bh=LdmURnz0R1a5FVqiI4nFqL5u59jB8oweDiJoAaDInp8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h9juH5NHcqCB2xKSec+b6JJWKO2CjWawk4+hlwBv0LLkEzoo4G4yNhIe/lnZWmy1SJH3uA02xx8EjLuoPpcSiQSHHvm+agFeaUVQR4fzgD7pxQfFvk8YYzRKY0nkCTiwwdKUl/SXgvEzCDw3tKBEdupriymzUlLWVGuvaYuowBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hsn+CXyW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4eca83so4822310a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876054; x=1746480854; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koyWNYDZNjv4brGRecLzxvFP1YjUxm4xs1rsKpWQ/6U=;
        b=Hsn+CXyWC8Ljh1bq6ZnLwd+REpn1UK4hN1hxEwUoe4zMro/lgMHda1xlVoM5sAXWPv
         R5Hj5Hl8kXPxdzmjAgxd23Rh6Ybxnti0p5Be+HuqNX7yv4w142X0Jp53uVUDa/BVdBGj
         8XbKToNQVH2Vg4QJmC6MWlgO3buMIL6wdwhp8t9cI7Rf4AY0bMsRg0LeFxFqQkstsqNC
         zUILxhlZa3Y7fQ7C5EQT28XyCp/QhoINIo8KKZe1CJPgs58EDRbhlngo4K31Ejc69G8u
         WqNdT0AB019rIvGf2r+Yeum0HwzW8UTjsY0fhxDEBjhGLT2TJ0AfOq36OpJ8Oj+BLG5P
         25CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876054; x=1746480854;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koyWNYDZNjv4brGRecLzxvFP1YjUxm4xs1rsKpWQ/6U=;
        b=LdcriWOIHJMnkFG/LLBJvGtci+nUQCqTlU1DkkyO4K6KhrPuVYoh7LIVfeWVR1ht5h
         BKPHVKUHXh/livbLVn5pQrX5vAlLqyTjBCPH1uenOUzlViWwd0Ef/5bqRXidOGD71WwM
         Vhssr8Cp3W2udgzDCd3k/dzOHIIEaZOy1rLsAN6qhL2miXJo0EzGvzklkpUlJ3d3ahvd
         pBn5C8i1pL5Kt5UJhhnFbUmLNNsatkkENAg3+n0VQlvUlpzHbHcZDv+No6Ac+WJLRgyD
         ZlgPb9NZ4Cqjvlt5MuvlDftn9rxs9d6UqC6uYGcTaTHgivFbNA8KWXkwBubamm833tWl
         /umw==
X-Forwarded-Encrypted: i=1; AJvYcCXUVxos8pdPBTQOg+dyB3bwdZLJIMJPMlqyY4Fzfs93TLVtz2AjGSrbglt8QQ4yv/wYtlnc5chZG2PO0E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVajU7xT90eYcvp4y7JNda3/F8DnxJXUll0AW2D5zz3RORXco
	IxB8YyznkUhb17Z0jHKIb9t7Hd+RdJ7IoPY7QlSPocGWTEKYu3bhmhAhrEbixxv7RysysOB8hOc
	jV/KnGA==
X-Google-Smtp-Source: AGHT+IHPWoz0u7w36m0654PxQqLObpuJBqZKNki39vypWG6RSx0hMOplImILFRIhdHKgwb8mQwcfwXsr87k0
X-Received: from pjbcz3.prod.google.com ([2002:a17:90a:d443:b0:2fa:a101:755])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:586e:b0:2ee:e518:c1cb
 with SMTP id 98e67ed59e1d1-30a012ecbd8mr16031789a91.7.1745876054164; Mon, 28
 Apr 2025 14:34:14 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:34:00 -0700
In-Reply-To: <20250428213409.1417584-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428213409.1417584-2-irogers@google.com>
Subject: [PATCH v3 1/9] perf callchain: Always populate the addr_location map
 when adding IP
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, James Clark <james.clark@linaro.org>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dropping symbols also meant the callchain maps wasn't populated, but
the callchain map is needed to find the DSO. Plumb the symbols option
better, falling back to thread__find_map rather than
thread__find_symbol when symbols are disabled.

Fixes: 02b2705017d2 ("perf callchain: Allow symbols to be optional when resolving a callchain")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 6 ++++--
 tools/perf/util/thread.c  | 8 ++++++--
 tools/perf/util/thread.h  | 2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf..b048165b10c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1976,7 +1976,7 @@ static void ip__resolve_ams(struct thread *thread,
 	 * Thus, we have to try consecutively until we find a match
 	 * or else, the symbol is unknown
 	 */
-	thread__find_cpumode_addr_location(thread, ip, &al);
+	thread__find_cpumode_addr_location(thread, ip, /*symbols=*/true, &al);
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
@@ -2078,7 +2078,7 @@ static int add_callchain_ip(struct thread *thread,
 	al.sym = NULL;
 	al.srcline = NULL;
 	if (!cpumode) {
-		thread__find_cpumode_addr_location(thread, ip, &al);
+		thread__find_cpumode_addr_location(thread, ip, symbols, &al);
 	} else {
 		if (ip >= PERF_CONTEXT_MAX) {
 			switch (ip) {
@@ -2106,6 +2106,8 @@ static int add_callchain_ip(struct thread *thread,
 		}
 		if (symbols)
 			thread__find_symbol(thread, *cpumode, ip, &al);
+		else
+			thread__find_map(thread, *cpumode, ip, &al);
 	}
 
 	if (al.sym != NULL) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 89585f53c1d5..10a01f8fbd40 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -410,7 +410,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, bo
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al)
+					bool symbols, struct addr_location *al)
 {
 	size_t i;
 	const u8 cpumodes[] = {
@@ -421,7 +421,11 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	};
 
 	for (i = 0; i < ARRAY_SIZE(cpumodes); i++) {
-		thread__find_symbol(thread, cpumodes[i], addr, al);
+		if (symbols)
+			thread__find_symbol(thread, cpumodes[i], addr, al);
+		else
+			thread__find_map(thread, cpumodes[i], addr, al);
+
 		if (al->map)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cd574a896418..2b90bbed7a61 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -126,7 +126,7 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 				      u64 addr, struct addr_location *al);
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
-					struct addr_location *al);
+					bool symbols, struct addr_location *al);
 
 int thread__memcpy(struct thread *thread, struct machine *machine,
 		   void *buf, u64 ip, int len, bool *is64bit);
-- 
2.49.0.901.g37484f566f-goog


