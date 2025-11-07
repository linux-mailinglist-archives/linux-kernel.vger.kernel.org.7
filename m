Return-Path: <linux-kernel+bounces-890795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68FC40FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3473A9557
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAFC333452;
	Fri,  7 Nov 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyZcHEqR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15F32D7D3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762535241; cv=none; b=KLkQysjB65dCFDFfRlLb6YNbPw+yQqOfw0cPH9hn8272EZyDsghsw/Fm4/KAZO1QMxLw9C6Hupo4kXUsV0VExAKZQRnrPgnTnIH2nI0EZqvxYQcTcHxFhS4GihbRpLlnKMI8Wofm8J2Nql6kta8+M12G0ixOhZ4oDo6NQtBx8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762535241; c=relaxed/simple;
	bh=89b4k9S4qNAUMIYu78o2Q3w4FZ/fiShO0OS+LEtI/Fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=b1nihY1gzDuTfj3hopzZ43V0nJ+lvhVI5c5AjkZoKn7V1MGTIhiy++BF/5p3asWD0JkY6MWUoF8Bgr4kcxaj2fXoBrDf0hNiTyQXfWs+7YYqhQCRE3b/Wks6nK68xTOZLIeYC+DvZ493vPhQXaeanuA79orJGbeiEAj8bkmeAz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyZcHEqR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297b355d33eso14210695ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762535239; x=1763140039; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQeT+EUx50vTmRKM25nFJZ55VX69pih0pupMwBRMU4=;
        b=UyZcHEqR6VjjWD9vR3BLgY3xfmvlgawaT6Mp9yqgrHjMaJBdkfBMd23MG0x2FoFnS+
         aFP4uckRX5+mzhnHCgLxIk8+nPtMAX6n6nfA9RUqkMmQ4hNgat/q7IbVSEv92kVAPRhc
         SaYLFrJmSNAQbsYi+35RMcmoEqVes8OmkJRQzqt66e77HS+Dk7dmCsZ0SZuJqToEZtsv
         DBpxkgnZsrNq0MQMpfzRNi6nN3186GJrK2+oceNFdHfnw3bjrBvwHAZqOtQk8oWRbZ1p
         M6m4ZUrecdET38qKYLAHIW6qNvf8CKBjwCszGrdMqFWlzZUyRXYNC/zTHlpyIvwcOemr
         CN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762535239; x=1763140039;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwQeT+EUx50vTmRKM25nFJZ55VX69pih0pupMwBRMU4=;
        b=kKQJvcUh1w5o/4Ex2kUngDD24MSIpx/o3gIgtEFpql9wIPTbzVbXdaU55Wjj3lW5Y0
         81DEKgFJb5fgKKxi8dlFqze8HEHe/t1VUwofRzOyyeBhq3SjnB3RYfTusMux6f6xPmxo
         upP1Yd12YIrGCby5jU+DQ5d+dAHYcnAK4UsFZSlZeoruIDNz5uyiuczHYpTXOcwfd7t/
         QjEhZcjj+BiCD4yVU6EjbWNTb6faWNlGeX3ImO+sp7sxt0mxcu9qxuVbflgDYgD9upnE
         FfQ3lnLrrH3twAmrzWHP2XpqfRtD/z3SHZAwJLLER7Y2OZEdwB6kMSgU0cHq8kucf27J
         K/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV5b4uUX93JzcdRU9Rm14vAUxhxYjMBCspENsVjn7VHTyLWJ/neM9130LVyoghFzSX04zE2vBBA1gnjZSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTQhqKKK1GbUbdl/f439QSCEneciyPMiG33/KQSQjhrMnAY47
	NIlXn43c86si6EAUPBgshkx//DDNHA/sBD0PDvYYXD5hojk1SdKx1SMnCzBwDf7URclbP0Pbu+r
	pJxh4bY73EA==
X-Google-Smtp-Source: AGHT+IFf2ROERl93tZEMUSUc1C5M+qPdy6K+Bb64NwcExMZ80JlTfZlXL4r/45CkmlH83g5U4mlnTQDXosbS
X-Received: from dlkk18.prod.google.com ([2002:a05:7022:6092:b0:119:49ca:6b9e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:987:b0:294:fc1d:9d0
 with SMTP id d9443c01a7336-297c04820c0mr53283435ad.40.1762535238734; Fri, 07
 Nov 2025 09:07:18 -0800 (PST)
Date: Fri,  7 Nov 2025 09:07:12 -0800
In-Reply-To: <20251107170712.2302714-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107170712.2302714-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107170712.2302714-2-irogers@google.com>
Subject: [PATCH v2 2/2] perf tool: Add a delegate_tool that just delegates
 actions to another tool
From: Ian Rogers <irogers@google.com>
To: Gabriel Marin <gmx@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Blake Jones <blakejones@google.com>, Anubhav Shelat <ashelat@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add an ability to be able to compose perf_tools, by having one perform
an action and then calling a delegate. Currently the perf_tools have
if-then-elses setting the callback and then if-then-elses within the
callback. Understanding the behavior is complex as it is in two places
and logic for numerous operations, within things like perf inject, is
interwoven. By chaining perf_tools together based on command line
options this kind of code can be avoided.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/tool.c | 171 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/tool.h |   9 +++
 2 files changed, 180 insertions(+)

diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index c983b526b30d..22a8a4ffe05f 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -321,3 +321,174 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 {
 	return tool->compressed == perf_session__process_compressed_event_stub;
 }
+
+#define CREATE_DELEGATE_SAMPLE(name) \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event, \
+				     struct perf_sample *sample, \
+				     struct evsel *evsel, \
+				     struct machine *machine) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, sample, evsel, machine);	\
+	}
+CREATE_DELEGATE_SAMPLE(read);
+CREATE_DELEGATE_SAMPLE(sample);
+
+#define CREATE_DELEGATE_ATTR(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool,	\
+				union perf_event *event,		\
+				struct evlist **pevlist)		\
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, pevlist);	\
+	}
+CREATE_DELEGATE_ATTR(attr);
+CREATE_DELEGATE_ATTR(event_update);
+
+#define CREATE_DELEGATE_OE(name)				   \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event,	   \
+				     struct ordered_events *oe)	   \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, oe);	\
+	}
+CREATE_DELEGATE_OE(finished_round);
+
+#define CREATE_DELEGATE_OP(name)				   \
+	static int delegate_ ## name(const struct perf_tool *tool, \
+				     union perf_event *event, \
+				     struct perf_sample *sample, \
+				     struct machine *machine) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, event, sample, machine); \
+	}
+CREATE_DELEGATE_OP(aux);
+CREATE_DELEGATE_OP(aux_output_hw_id);
+CREATE_DELEGATE_OP(bpf);
+CREATE_DELEGATE_OP(cgroup);
+CREATE_DELEGATE_OP(comm);
+CREATE_DELEGATE_OP(context_switch);
+CREATE_DELEGATE_OP(exit);
+CREATE_DELEGATE_OP(fork);
+CREATE_DELEGATE_OP(itrace_start);
+CREATE_DELEGATE_OP(ksymbol);
+CREATE_DELEGATE_OP(lost);
+CREATE_DELEGATE_OP(lost_samples);
+CREATE_DELEGATE_OP(mmap);
+CREATE_DELEGATE_OP(mmap2);
+CREATE_DELEGATE_OP(namespaces);
+CREATE_DELEGATE_OP(text_poke);
+CREATE_DELEGATE_OP(throttle);
+CREATE_DELEGATE_OP(unthrottle);
+
+#define CREATE_DELEGATE_OP2(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool,	\
+				     struct perf_session *session,	\
+				     union perf_event *event)		\
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, session, event);	\
+	}
+CREATE_DELEGATE_OP2(auxtrace_error);
+CREATE_DELEGATE_OP2(auxtrace_info);
+CREATE_DELEGATE_OP2(bpf_metadata);
+CREATE_DELEGATE_OP2(build_id);
+CREATE_DELEGATE_OP2(cpu_map);
+CREATE_DELEGATE_OP2(feature);
+CREATE_DELEGATE_OP2(finished_init);
+CREATE_DELEGATE_OP2(id_index);
+CREATE_DELEGATE_OP2(stat);
+CREATE_DELEGATE_OP2(stat_config);
+CREATE_DELEGATE_OP2(stat_round);
+CREATE_DELEGATE_OP2(thread_map);
+CREATE_DELEGATE_OP2(time_conv);
+CREATE_DELEGATE_OP2(tracing_data);
+
+#define CREATE_DELEGATE_OP3(name)					\
+	static s64 delegate_ ## name(const struct perf_tool *tool,	\
+				     struct perf_session *session,      \
+				     union perf_event *event)           \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;	\
+		return delegate->name(delegate, session, event);	\
+	}
+CREATE_DELEGATE_OP3(auxtrace);
+
+#define CREATE_DELEGATE_OP4(name)					\
+	static int delegate_ ## name(const struct perf_tool *tool, \
+			struct perf_session *session, \
+			union perf_event *event, \
+			u64 data, \
+			const char *str) \
+	{								\
+		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
+		struct perf_tool *delegate = del_tool->delegate;		\
+		return delegate->name(delegate, session, event, data, str);	\
+	}
+CREATE_DELEGATE_OP4(compressed);
+
+void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate)
+{
+	tool->delegate = delegate;
+
+	tool->tool.ordered_events = delegate->ordered_events;
+	tool->tool.ordering_requires_timestamps = delegate->ordering_requires_timestamps;
+	tool->tool.namespace_events = delegate->namespace_events;
+	tool->tool.cgroup_events = delegate->cgroup_events;
+	tool->tool.no_warn = delegate->no_warn;
+	tool->tool.show_feat_hdr = delegate->show_feat_hdr;
+
+	tool->tool.sample = delegate_sample;
+	tool->tool.read = delegate_read;
+
+	tool->tool.mmap = delegate_mmap;
+	tool->tool.mmap2 = delegate_mmap2;
+	tool->tool.comm = delegate_comm;
+	tool->tool.namespaces = delegate_namespaces;
+	tool->tool.cgroup = delegate_cgroup;
+	tool->tool.fork = delegate_fork;
+	tool->tool.exit = delegate_exit;
+	tool->tool.lost = delegate_lost;
+	tool->tool.lost_samples = delegate_lost_samples;
+	tool->tool.aux = delegate_aux;
+	tool->tool.itrace_start = delegate_itrace_start;
+	tool->tool.aux_output_hw_id = delegate_aux_output_hw_id;
+	tool->tool.context_switch = delegate_context_switch;
+	tool->tool.throttle = delegate_throttle;
+	tool->tool.unthrottle = delegate_unthrottle;
+	tool->tool.ksymbol = delegate_ksymbol;
+	tool->tool.bpf = delegate_bpf;
+	tool->tool.text_poke = delegate_text_poke;
+
+	tool->tool.attr = delegate_attr;
+	tool->tool.event_update = delegate_event_update;
+
+	tool->tool.tracing_data = delegate_tracing_data;
+
+	tool->tool.finished_round = delegate_finished_round;
+
+	tool->tool.build_id = delegate_build_id;
+	tool->tool.id_index = delegate_id_index;
+	tool->tool.auxtrace_info = delegate_auxtrace_info;
+	tool->tool.auxtrace_error = delegate_auxtrace_error;
+	tool->tool.time_conv = delegate_time_conv;
+	tool->tool.thread_map = delegate_thread_map;
+	tool->tool.cpu_map = delegate_cpu_map;
+	tool->tool.stat_config = delegate_stat_config;
+	tool->tool.stat = delegate_stat;
+	tool->tool.stat_round = delegate_stat_round;
+	tool->tool.feature = delegate_feature;
+	tool->tool.finished_init = delegate_finished_init;
+	tool->tool.bpf_metadata = delegate_bpf_metadata;
+	tool->tool.compressed = delegate_compressed;
+	tool->tool.auxtrace = delegate_auxtrace;
+}
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 1f1461808371..88337cee1e3e 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -102,4 +102,13 @@ int process_event_sample_stub(const struct perf_tool *tool,
 			      struct evsel *evsel,
 			      struct machine *machine);
 
+struct delegate_tool {
+	/** @tool: The actual tool that calls the delegate. */
+	struct perf_tool tool;
+	/** @delegate: The tool that is delegated to. */
+	struct perf_tool *delegate;
+};
+
+void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate);
+
 #endif /* __PERF_TOOL_H */
-- 
2.51.2.1041.gc1ab5b90ca-goog


