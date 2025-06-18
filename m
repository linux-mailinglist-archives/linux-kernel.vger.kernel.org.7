Return-Path: <linux-kernel+bounces-690993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA35ADDF09
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 00:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B767189C9D2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 22:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947B295519;
	Tue, 17 Jun 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UU4174E"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4828C029
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750199660; cv=none; b=kPynWH/BMWabxvN1vidEcyz18M8gDkG/NJHTaeVFrKwIjvHXo+Doi3ya7GENcCx6/EAdMwfrVbCEDLvnjYnMc2DCPF31J5M3tWGwkAJ8V5hRsmLCtFk6pcw/d3oup2XuxhQfEGW6g5+sEZP4npqyYpqPMzCaTNwjflHemV6MD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750199660; c=relaxed/simple;
	bh=dalspGRA76cLpNpJIHwlYn+RuacSXTlqxaj+Pd5Q3fE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oNXAucPacDRl/MdSvZ8ZaRA3SYV29lLI286BF55lvaHMjwOBGmlnwp3wlPJwKTnfeIUUAvhLUyrE/kDD5LoE9aPLn1oWjy9/xhPxa4fH87gRf7RBBbBG6ByyFjpn15MoV2rhHMlvCLoB7FAIgyBmlcYnGdlfn8Ygvy8xhfjtAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UU4174E; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23632fd6248so56708905ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750199658; x=1750804458; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFhLWcdTJt2ijNT47QXB108NB/kEexFKHObEFV2lCEI=;
        b=0UU4174EUzi3q/igAfcJurugU3G/KefqMKxOyLsLeDZ15pviOP3yA+nve91Z6W8tO0
         Qqp3kIB+LxkhwAPz6xU8/V4htyj2rAb2zSUgXQgrrCkWIInX5Eu+eoxo5WMqAWYSwDcW
         IB7LPO3fZ2U+R3i2rmIhhbf8WzgWVWQ9saebGT3ZTUxNJXZhNZ795VnAIfP4anLE+R1m
         8/7na7Rli7AJ/WYg+GtO4glPqW4giYnoYJBlbBtNLSrDdQPBzXkLaUph40SuuSWpNtZY
         FxHOfRFil6NuSw1BR3Zk4xeJAYyQoJzU5QosFQX0PUfqQVCdMHIiZyvk6tH0VJqbNd9F
         W9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750199658; x=1750804458;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFhLWcdTJt2ijNT47QXB108NB/kEexFKHObEFV2lCEI=;
        b=gpFKcVnyejJAkotqFHbXfrw3Ee6oXN7t9+eDWiwuOVKItsiWxSMQ/3F56sDvYJiFZF
         ZjNKXNB2gIVE9/j7pN2/OXWsqKPECbpB90DSfHpkpAi9fXAPoCY5qFBWdfersvWq+o3E
         D2sVkx7aullr1VIE3zdc28vtG/OxmrzYom/UeWkUUhBwvgqqegUgG+L6mLpap/NvlFAk
         +Fg2aNBDWkPVrDTMSsjCd/dG4Wp0gfUEAHx0pT75SajzBPVm/rDXweb6qtP8yJFFqFGI
         TTLYZzeqbsG3c2+TmjWxvVJBHJ2B93vOS9UC2arPcFzgvNEwFcKTVAAV67NTfHuNlBBG
         oXcg==
X-Forwarded-Encrypted: i=1; AJvYcCXC5JIdpARykP3IoO83H5CfOsSB+1i8rDVH+YdlQv5s9N2M6d/GPxaHV7hsbfJkfF/LXzXhJuwlDFHBYWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXnjMBE9nNTlh90c54xwfkeGokHiTigYlj+pkZElSV3GSEUZY
	d/XW2IH5VGejIqWMVOaSrAbB+3Ib2Odr83AkOj0aL3RWlnXtzr8kN+OuqxtBnvDhhv1oaIwNA74
	+zLn36B+IWg==
X-Google-Smtp-Source: AGHT+IF3ZUP/gylhM01v4MpGpD6GjYIOE+HkE30yc0BFr/pZf6faRRoLmNdlG/vCiutnqjqKb2xP4v6iZaQI
X-Received: from pjbdy14.prod.google.com ([2002:a17:90b:6ce:b0:313:274d:3007])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacc:b0:234:c8f6:1b05
 with SMTP id d9443c01a7336-2366b3fe725mr218715885ad.52.1750199658437; Tue, 17
 Jun 2025 15:34:18 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:33:55 -0700
In-Reply-To: <20250617223356.2752099-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617223356.2752099-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.761.g2dc52ea45b-goog
Message-ID: <20250617223356.2752099-3-irogers@google.com>
Subject: [PATCH v2 3/4] perf trace: Add missed freeing of ordered events and thread
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Andi Kleen <ak@linux.intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Caught by leak sanitizer running "perf trace BTF general tests". Make
the ordered_events initialization unconditional and early so that
trace__exit cleanup is simple - ordered_events__init doesn't allocate
and just sets up 4 values and inits 3 list heads.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Move the init code to avoid segv found by Arnaldo.
---
 tools/perf/builtin-trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bf9b5d0630d3..d50e86fccf60 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5359,6 +5359,7 @@ static int trace__config(const char *var, const char *value, void *arg)
 
 static void trace__exit(struct trace *trace)
 {
+	thread__zput(trace->current);
 	strlist__delete(trace->ev_qualifier);
 	zfree(&trace->ev_qualifier_ids.entries);
 	if (trace->syscalls.table) {
@@ -5369,6 +5370,7 @@ static void trace__exit(struct trace *trace)
 	zfree(&trace->perfconfig_events);
 	evlist__delete(trace->evlist);
 	trace->evlist = NULL;
+	ordered_events__free(&trace->oe.data);
 #ifdef HAVE_LIBBPF_SUPPORT
 	btf__free(trace->btf);
 	trace->btf = NULL;
@@ -5518,6 +5520,9 @@ int cmd_trace(int argc, const char **argv)
 	sigchld_act.sa_sigaction = sighandler_chld;
 	sigaction(SIGCHLD, &sigchld_act, NULL);
 
+	ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
+	ordered_events__set_copy_on_queue(&trace.oe.data, true);
+
 	trace.evlist = evlist__new();
 
 	if (trace.evlist == NULL) {
@@ -5676,11 +5681,6 @@ int cmd_trace(int argc, const char **argv)
 			trace__load_vmlinux_btf(&trace);
 	}
 
-	if (trace.sort_events) {
-		ordered_events__init(&trace.oe.data, ordered_events__deliver_event, &trace);
-		ordered_events__set_copy_on_queue(&trace.oe.data, true);
-	}
-
 	/*
 	 * If we are augmenting syscalls, then combine what we put in the
 	 * __augmented_syscalls__ BPF map with what is in the
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


