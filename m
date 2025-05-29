Return-Path: <linux-kernel+bounces-666480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62222AC7741
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3256A162866
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE125D1F1;
	Thu, 29 May 2025 04:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5aen7h0"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B68025CC51
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493641; cv=none; b=bqcTOfJAI1dJIqpxwvGI6hsfpA9UelMnqa0sqxFlT4W+bu++nRj9Oe8oEZaRtFDNcB7YB5K3CgdCfGQfMZZCUFynzguTRlB4grmptqvoM196Mi3RDzqLb4vBdgGL7n7Fzye5Het9L+N3RB5lVQCp75lmrJFWVEC4kC1JvMfq1Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493641; c=relaxed/simple;
	bh=njJn7n/5kLIH9BxF+z3EOdBKR9OtD/CADSM783LEAuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MjHDHWfvSFEOgsPHIxePoAVuIersXnIEOovCCPqkD7AMcIzE10BtS0LLgnZ7odgFUazy18lsoeJ4fE2TrwHpi00woifXV9JgbdDfh0IVDJ3XXHOCeuadw5zZaJp1ILDlfELgXI8ckW9XiRp6+cAKsiL8EV8Wpxw9LEgNCVkAWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5aen7h0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2344f94f9e5so3941105ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493639; x=1749098439; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pnm6XAU4xFoMWfTd8OLWEtaFTFv8v2LBbG5v3SrDeM=;
        b=l5aen7h0dDCbQTPEgFvVcu97it+t3umysoF33P/qi+iuzqRgoaiJeLtHSyrsB+QjpG
         Dk3dhyn8cw9W+GG7oqhkP2HzIdw4SJgwQljzspRmqtQiA28rGHRLVwsy570i7ZfbAJ1p
         8+bK/RcgINuKGO7d98ECl6Rv9C5Z83GsvGGP9FJB7Q5tQtJUWutc3+8khPGINwn1Slzn
         D0OOauCTM/EUdmjbo9PGw2NLzMfi2fzvk6odX5Cn3n65j622FtqH+AMfBSjgL9kDk1Sr
         LH/StmobectX8Zmx6O7oZJE6pP4ZjQt2u2Bx7sPdHvC5OleDvW8QzbiEXjdYzWzhdn+R
         2xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493639; x=1749098439;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pnm6XAU4xFoMWfTd8OLWEtaFTFv8v2LBbG5v3SrDeM=;
        b=w8pL9/N+DCbuJ2icdLsJ8+fHBp70r5I6wiL7N7TW61rG3vMkxabAiaaKaqDBf4+3A3
         2fQbnVfNwFAleSiF5CQ3Z6zFF3olHx8AL4zcwyCisjH/ttMj8dWsQ65YrUFdT69lwkzX
         EFclGBlHreE9NRk6hjigfeLycOt2xanJQTNAINLcvmBHQF6NhDTxI4tgfzE8wY8OHmBu
         KUaRkPl7a4fTXnhWd+zlCbwE+EZvN7yRxuxnG/bLpUC3ugR6y1RfkRFhSLSXAbcWyhOE
         vj0d/GsIvrOBYsfTB6WGnzZN1o5pfsVoMjtV4kYfS0wsPmXxz5xqAxG5vCccMVKj4ZSd
         cSpw==
X-Forwarded-Encrypted: i=1; AJvYcCWB62ehX8EtKXMXNAp/S5PB202rBeTyybQT5FHABAdyXVqhaai7nM5JXL3oqUFWCRjHu2ZjlSd3A5ayNmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVfwq0GPfy3Momt2kRz3XMi9vP9SKjT6+OCD25tM5gEvWqH0Gx
	e7EjP4T/d8nnm5HkNnl2nrYB/fFc0+rXOYrahLY7Cxno+2JGfnL4i6xjZBhQlU1gOBSHkYyOiBf
	XtjWbndrPXw==
X-Google-Smtp-Source: AGHT+IEUdCPJiJpyqBaz6iiXCBXVzYTDWVBJoUhGLiGCMAHw7VkL+HZG9N9o2zdQKDxspEDQx15JDhYjLuti
X-Received: from plwg3.prod.google.com ([2002:a17:902:f743:b0:235:6d5:688b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f611:b0:231:d7f9:dc6d
 with SMTP id d9443c01a7336-23414e9b517mr308516605ad.0.1748493638649; Wed, 28
 May 2025 21:40:38 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:52 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-17-irogers@google.com>
Subject: [PATCH v4 16/24] perf top: Make perf_env locally scoped
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
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The use of the global host perf_env variable is potentially
inconsistent within the code. Switch perf top to using a locally
scoped variable that is generally accessed through the session.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c63dda6a7017..2327496296be 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1301,7 +1301,7 @@ static int __cmd_top(struct perf_top *top)
 	perf_set_multithreaded();
 
 	if (perf_hpp_list.socket) {
-		ret = perf_env__read_cpu_topology_map(&perf_env);
+		ret = perf_env__read_cpu_topology_map(perf_session__env(top->session));
 		if (ret < 0) {
 			char errbuf[BUFSIZ];
 			const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
@@ -1624,6 +1624,7 @@ int cmd_top(int argc, const char **argv)
 		NULL
 	};
 	int status = hists__init();
+	struct perf_env host_env;
 
 	if (status < 0)
 		return status;
@@ -1639,12 +1640,17 @@ int cmd_top(int argc, const char **argv)
 
 	status = perf_config(perf_top_config, &top);
 	if (status)
-		return status;
+		goto out_delete_evlist;
 	/*
 	 * Since the per arch annotation init routine may need the cpuid, read
 	 * it here, since we are not getting this from the perf.data header.
 	 */
-	status = perf_env__read_cpuid(&perf_env);
+	perf_env__init(&host_env);
+	status = perf_env__set_cmdline(&host_env, argc, argv);
+	if (status)
+		goto out_delete_evlist;
+
+	status = perf_env__read_cpuid(&host_env);
 	if (status) {
 		/*
 		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
@@ -1661,18 +1667,24 @@ int cmd_top(int argc, const char **argv)
 
 	if (disassembler_style) {
 		annotate_opts.disassembler_style = strdup(disassembler_style);
-		if (!annotate_opts.disassembler_style)
-			return -ENOMEM;
+		if (!annotate_opts.disassembler_style) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 	if (objdump_path) {
 		annotate_opts.objdump_path = strdup(objdump_path);
-		if (!annotate_opts.objdump_path)
-			return -ENOMEM;
+		if (!annotate_opts.objdump_path) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 	if (addr2line_path) {
 		symbol_conf.addr2line_path = strdup(addr2line_path);
-		if (!symbol_conf.addr2line_path)
-			return -ENOMEM;
+		if (!symbol_conf.addr2line_path) {
+			status = -ENOMEM;
+			goto out_delete_evlist;
+		}
 	}
 
 	status = symbol__validate_sym_arguments();
@@ -1819,14 +1831,16 @@ int cmd_top(int argc, const char **argv)
 		perf_top__update_print_entries(&top);
 		signal(SIGWINCH, winch_sig);
 	}
-	top.session->env = &perf_env;
 
-	top.session = perf_session__new(NULL, NULL);
+	top.session = __perf_session__new(/*data=*/NULL, /*tool=*/NULL,
+					  /*trace_event_repipe=*/false,
+					  &host_env);
 	if (IS_ERR(top.session)) {
 		status = PTR_ERR(top.session);
 		top.session = NULL;
 		goto out_delete_evlist;
 	}
+	top.evlist->session = top.session;
 
 	if (!evlist__needs_bpf_sb_event(top.evlist))
 		top.record_opts.no_bpf_event = true;
@@ -1841,7 +1855,7 @@ int cmd_top(int argc, const char **argv)
 			goto out_delete_evlist;
 		}
 
-		if (evlist__add_bpf_sb_event(top.sb_evlist, &perf_env)) {
+		if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env)) {
 			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
 			status = -EINVAL;
 			goto out_delete_evlist;
@@ -1863,6 +1877,7 @@ int cmd_top(int argc, const char **argv)
 	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
 	annotation_options__exit();
+	perf_env__exit(&host_env);
 
 	return status;
 }
-- 
2.49.0.1204.g71687c7c1d-goog


