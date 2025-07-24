Return-Path: <linux-kernel+bounces-744676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04963B10FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89B71CE2049
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFDB2EB5A6;
	Thu, 24 Jul 2025 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBodTOaD"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D92ED85E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374829; cv=none; b=XaWzf46K7Nxzb6+fpgJ71oqYWtAa2nAJE9kpvihldOEtKqhxCSjhSOugMLrUfWp8dtJiomHUEn8hlB3lgkNoymKy04C15CEHmxKKgnziejcEBZqx+zibxJAPklEmIWm/3g2DBgUqWC/21iOGfGSc/b7DEg2icqnVd+T0f0g5Hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374829; c=relaxed/simple;
	bh=VhjuIJYpXg7gkvG80mgZExtZaW1Qk4lTD2dWqGrYHq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YUWfEZzc8QJ8r/5Q4NkqG0v4V9LGWqAdXdJYVWhCqvrbpWQ06ZRLgXJfDctRdAAgCHSPYIKSQt68h6FNEQAGiNm5YlQE2CTzEO+Eai53qzXustTL7NOUTHcrwcJq/e1ZQneQGTy4PjxQep2Rbc1pq84FBhsGzo8ID1lw7BomEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBodTOaD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso17863825ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374827; x=1753979627; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4/0/V1Jpkj3zmwIH+nXlPhlxtETIFRUrmbIcWZ+uZQ=;
        b=DBodTOaDObLDYTuFZfP7utl3W/0DEWLnxxjnwjXQoStUycwLfOuFXhQssCzBf/NNJw
         GM6076KIhS8g/X7hzMsqaqlELkTR0cA/U57kQBqr07M3VOv8gV5gKKcE67rY/d990GZU
         z3kFvRYyg3wTq5fsaEmAz8d0DIXvWjzYd0MVrVgxwGp5ODCc2cIlQbtzlQ101+WRNOzv
         igQHQq8AO9fI7Um98w1jRRnQS1KBtCu31VtNq8V+rA3ze5zqF3feRkSETT966DpEAT67
         o3SghDBFN3EB7OJ08kwjyZfP+NHN7Lvlf2UAOhzHkyec2KSaKLhRV+6WZwDOhghlZqL5
         SkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374827; x=1753979627;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4/0/V1Jpkj3zmwIH+nXlPhlxtETIFRUrmbIcWZ+uZQ=;
        b=eTkUtUQLW4E5hZ4IHUgES4vKAqGUDaewU0W7KwfLvBRz4F6LLa76L9eHAhUeXMCcQ+
         IkHxb+qJ0rN4+mB5e/DtZYhCX/13ydgvgkbx1RNIgq8mFKxmSCurcGmZksrOJug4X04S
         U56fzVfTKXOPjOeJw8wcVlDR1USaSg8RRZcPuoTzvbb8gOXKuLjR+QX0iUxYchmdVuAb
         5VRvf608uaKbgBjHrtHIwr3T9Qumf7NjmQm3TdyjxsKlgqwr+o9TIf22QwP6m8L82c5v
         Ng6TfVc+kY1hV4pMD63/tkOpCmPKSNidNmpRUSQ6Bk9a+z742ySaIAW1xXFUO3TWQcZL
         r+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUFE+W0wVfDpZB5qtZaksaOz6/U3YNF9Z2PBVaNKjSSnIZggc9L/K9+UedeBd92t2PnaKoBJacq+gptOiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYToGIxsflTI71zdvsCa6RGxYHIkLMIsWrSBIrxGtqenhCQG1A
	NX+pOdO8IpNnUYKgPApZrWV0UXH3r+DoTj0NYq5/2xuTjk+PLFCTP5NV53424B5S9NCJn50WJgV
	GU5BUxMmzjQ==
X-Google-Smtp-Source: AGHT+IHFt9nlp05P3QADiTotBXyL/2/i91rG6fQdo5ZJe0teRp9VZIOuIeZUcNDn8bxRcWSr5Itsa2K1MY8D
X-Received: from plbkr8.prod.google.com ([2002:a17:903:808:b0:234:bf8f:6965])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f688:b0:220:c164:6ee1
 with SMTP id d9443c01a7336-23f981936cemr119242565ad.32.1753374826633; Thu, 24
 Jul 2025 09:33:46 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:53 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-14-irogers@google.com>
Subject: [PATCH v6 13/22] perf session: Add host_env argument to perf_session__new
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Matt Fleming <matt@readmodwrite.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When creating a perf_session the host perf_env may or may not want to
be used. For example, `perf top` uses a host perf_env while `perf
inject` does not. Add a host_env argument to perf_session__new so that
sessions requiring a host perf_env can pass it in. Currently if none
is specified the global perf_env variable is used, but this will
change in later patches.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 3 ++-
 tools/perf/util/session.c   | 5 +++--
 tools/perf/util/session.h   | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f73350a3417a..40ba6a94f719 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2539,7 +2539,8 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
-					     /*trace_event_repipe=*/inject.output.is_pipe);
+					     /*trace_event_repipe=*/inject.output.is_pipe,
+					     /*host_env=*/NULL);
 
 	if (IS_ERR(inject.session)) {
 		ret = PTR_ERR(inject.session);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a851d9130abd..36532329a633 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -138,7 +138,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe)
+					 bool trace_event_repipe,
+					 struct perf_env *host_env)
 {
 	int ret = -ENOMEM;
 	struct perf_session *session = zalloc(sizeof(*session));
@@ -191,7 +192,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 				symbol_conf.kallsyms_name = perf_data__kallsyms_name(data);
 		}
 	} else  {
-		session->machines.host.env = &perf_env;
+		session->machines.host.env = host_env ?: &perf_env;
 	}
 	if (session->evlist)
 		session->evlist->session = session;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index e7f7464b838f..cf88d65a25cb 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -107,12 +107,13 @@ struct perf_tool;
 
 struct perf_session *__perf_session__new(struct perf_data *data,
 					 struct perf_tool *tool,
-					 bool trace_event_repipe);
+					 bool trace_event_repipe,
+					 struct perf_env *host_env);
 
 static inline struct perf_session *perf_session__new(struct perf_data *data,
 						     struct perf_tool *tool)
 {
-	return __perf_session__new(data, tool, /*trace_event_repipe=*/false);
+	return __perf_session__new(data, tool, /*trace_event_repipe=*/false, /*host_env=*/NULL);
 }
 
 void perf_session__delete(struct perf_session *session);
-- 
2.50.0.727.gbf7dc18ff4-goog


