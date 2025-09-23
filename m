Return-Path: <linux-kernel+bounces-829741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDBB97BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9644C538D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5C31A56C;
	Tue, 23 Sep 2025 22:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y68a8MPi"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24415319867
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666835; cv=none; b=VsmNExwwQsLZNHXPS39PtbdeMervJdyMp3J2y9tydNNPZSTo7Sj6280I8fp1RmTwrlqRT7qylcjMneVVBkavKfuDaF7VJMnXXC3BFPdK8kh29tEQ8zK4royMIwnVVXlyDKEjZdzBf1LuVXH5NKMm5MBQpDCU/0HHcR29ZZ0c4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666835; c=relaxed/simple;
	bh=kinTax4WdFsYYPU1EvIznTAAAXuDIYlDDYft/HbDYZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OrHteNOAv0NksXLVnFpFw52Knhum3aBQG4rjInAPAXOm3xEmybNk6IABkNFu/ezwXJfylZ5ElVkKPnoD3jgU9I1mREvadOomw2R1/rMPobwwUT/Dnp9qjGedh8miVO3aBjH2Fzm61ibodIjN7RiHrbN06vIRMNSd4s8TAaflNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y68a8MPi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457ef983fso129598765ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666833; x=1759271633; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=Y68a8MPiyoXN9UA+tp9PwgEZlYTzFvygVvVqs/SEi6SqDyrNa9dd+SZ5WXyX++Iaw2
         dsdojXljcq7G16d/60Ty93AJE+q0UUysGwuAZqUelHhvydVRvbz2xFXKw4/plPZ1Pj91
         dRnd6h5rKMgtYc6rZh/VQ6LRWscmxLM6azTno606RrX+VlOeKQOL7ARTHzPnqKEEyFbI
         ox4X1X2g09ioy6duJGarEvG/4IB+bPeL1zjkAvDdUEkh8RKvvJAIqkpFD92ub7ksjJ9j
         a8AIrHs20f2WyTl3noJxiRrRL2Qw5l0rUpqSewuxWs9YbQgkiPf/yTPcLuHbHj7zgO5r
         Hubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666833; x=1759271633;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=wP9EcALdzucxzQubbth4b6nqFLewge9sY4Wj2Ip16LLKbNXbzPR2Bhc3lubKDxoVGv
         1BnHyX0+lKM3jq+6tR0S7AJtiNnunyokVYRWqqRjxxjQwjBqLiwHnYMH6QJmhM4UNgTL
         f1evQhBQbsjO/xHbN/4dN1XhQzhtSfRW8eFwC/Y8drbBzZP2KR2c/wt5q94JoUfG58ha
         zhed+4Y8mEeePOdtTSX2LGl/evfT9ORBp/2WgfXcdugmF6h4J7UXRfS+M8WgxDpVpGwl
         1uxTYpgom9tVmFN6PAD09N+UO+aCHO19ADrWZC5yIAbbzik4HLl7nSeHnu4AzbOwIjG3
         jzHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6XyDwConD2jtS0zCL+2o3eGjDtdhgazmEefa0JOoY312o5hdMY9cYsJN2isLuygNn1Km6rInmBo95uZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YysdEbzUE9Jdz0eKDrwIqp9VSkdII2P+erir7+6ZOkE7pZVwzAR
	XFXQpcNjf1cmmycPZTxom+5oFfT266TCVJrEUKa01ukIqIzt83NlmhHENlGWksrLIWjVdbm5Q+I
	ZmkL32L5z/Q==
X-Google-Smtp-Source: AGHT+IGjohmk085Bt7hgNSYy4qobunpfeMzukLWAVzAkXBIc1/tN9I0IdDgHb1iE9xLkPZU8IJVSAVHFU4AS
X-Received: from plih16.prod.google.com ([2002:a17:903:37d0:b0:266:b1de:9fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60b:b0:25c:38be:748f
 with SMTP id d9443c01a7336-27cc09e4184mr47330855ad.9.1758666833513; Tue, 23
 Sep 2025 15:33:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:02 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-19-irogers@google.com>
Subject: [PATCH v6 18/28] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index effe6802c1a3..e7c0e5363797 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4343,9 +4343,13 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		err = parse_event(rec->evlist, "cycles:P");
-		if (err)
+		struct evlist *def_evlist = evlist__new_default();
+
+		if (!def_evlist)
 			goto out;
+
+		evlist__splice_list_tail(rec->evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
-- 
2.51.0.534.gc79095c0ca-goog


