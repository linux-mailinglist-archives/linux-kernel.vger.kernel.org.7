Return-Path: <linux-kernel+bounces-598802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481B9A84B39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 19:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154C04E2E68
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98ED1F151E;
	Thu, 10 Apr 2025 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZODvNjD"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C49290BAB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306622; cv=none; b=JekCMZ+VceCebjwuHx2EcF59np3vFZdl6aU2k9Gfmsqfb2hu8ZZMUdgFr9/8C25pj20DHfAAhQRvYkCIEEe3elK4eY+XqBjXuNXMKeTqV7ZkHzg5Px4VgMXKN3ZdSdsrZlJgxHwKo65RoBQcZNgtPkjzT26WDYhE+slc5g2mp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306622; c=relaxed/simple;
	bh=s5GHscAETkUAKivN7aAi7TLoUIfwAcyInliqpu10XeA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bq0M9B0gZCLEmRgzLchtIoPKQjoKB5HU40xi7uTweVzqKuGxyMvE4EBPfvtoIMKibK6o7d/hdd9BQcYSBvcBJBB+/LS+x3LWllU9EqAJJRSQx1eCevfSmlSZ2TCgGVeBWtOVEPK1dtapUSimCOBCGZqYJp4w5/mnCxio+Ho18I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZODvNjD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254bdd4982so14759445ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306619; x=1744911419; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYG+riLDNowuBXALSOK3FRVNiACEEuoxpGzRk7BH3E=;
        b=IZODvNjDHhp0hVT1YiiOpynOIh0lai1bmUA25aAwSe2DiF8tmSDoMXP+6IA6TfJe7C
         alnO7R1SeMQzjnn0HlRsMCKP73WXdV6cgSXQjUgXLLRXx5nGSR6MB8AT1sfWlQRuv8Dj
         n/vN7pZAamWmH0eGWnQhZXedti7u1FWP+CncjYUf7CIzdFEnu89O/efi02OBzBYhEmGX
         vVnyKcsEDULqUM/IeuGouj8GXqvNqAjwy9/PtYS2kBoFVWFDvz+2eNzT+MqfOSWwuKVK
         iLKBK2qGw0JJNe+3FacBkw9AJiI1SSntNucpFhum3zS5fgckYb0QYoaKZ6DeaFWEgtA6
         3h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306619; x=1744911419;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpYG+riLDNowuBXALSOK3FRVNiACEEuoxpGzRk7BH3E=;
        b=a2hz0p8TAnPBY/P8yvhFWT0UY8FXBe31lGPPessjNwaikQYcS/RTC5xwTrh5TTlA4B
         Fa89GinKqKiZpqAki8lx8Gp70tc1QngW33rUkHlqg7uN/Vx3v0QQkpCM+RUbg/qMcIcy
         m7Q938+fsKLWB6vftZT9LytSnm7BilHnLZeqB21l76N0nW4eUqwfsUqOAhx9KbwFgQCC
         WASqL/e1VkWfMWHiJ6otDdouSMUiD5TW/2ovVVLbywYL51jv0LmG5bAkfIqomU8BOfMd
         8y8mVMosHvBr1FT1FggYpVU9XR+TgacJIsWLFVd/YN/qIFpww3TkI+cFu+WRNlNHcqkP
         hIew==
X-Forwarded-Encrypted: i=1; AJvYcCW0xR1YtDhGj7PXgEyzPv1xlgIq19wpqxoruukanhA8KkhLU2z0ofmRGzYMtu6ZcQzwxr7Q3XZYL8lcmxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZVACFgyZ+/xACoUq7YvoUxS1ih0XhzUTbrQIF3yJwGtaRwSXc
	4lE3yPt0AZpOd9Om4KOm5IEE/np2QIDcOFK5OfMjC9Z0qDBOEzsGP6G4YiSW4Ek197G0nOYoCSk
	7P/Q0pQ==
X-Google-Smtp-Source: AGHT+IGzIUP6D1cwLaSTj/gUi3pDoC4nLxOcZuHx9s7cibZ6nls36gURzWSfZGyGYDQBNmN1hxObG/FtTqx1
X-Received: from plge17.prod.google.com ([2002:a17:902:cf51:b0:223:242b:480a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:948:b0:224:10a2:cad5
 with SMTP id d9443c01a7336-22b2eda468bmr66678385ad.10.1744306619427; Thu, 10
 Apr 2025 10:36:59 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:27 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-9-irogers@google.com>
Subject: [PATCH v2 08/12] perf top: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 22 ++++++++++++----------
 tools/perf/util/top.c    |  4 ++--
 tools/perf/util/top.h    |  1 +
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1061f4eebc3f..9a7af69b7c73 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -642,7 +642,7 @@ static void *display_thread_tui(void *arg)
 	 */
 	evlist__for_each_entry(top->evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		hists->uid_filter_str = top->record_opts.target.uid_str;
+		hists->uid_filter_str = top->uid_str;
 	}
 
 	ret = evlist__tui_browse_hists(top->evlist, help, &hbt, top->min_percent,
@@ -1566,7 +1566,7 @@ int cmd_top(int argc, const char **argv)
 		    "Add prefix to source file path names in programs (with --prefix-strip)"),
 	OPT_STRING(0, "prefix-strip", &annotate_opts.prefix_strip, "N",
 		    "Strip first N entries of source file path name in programs (with --prefix)"),
-	OPT_STRING('u', "uid", &target->uid_str, "user", "user to profile"),
+	OPT_STRING('u', "uid", &top.uid_str, "user", "user to profile"),
 	OPT_CALLBACK(0, "percent-limit", &top, "percent",
 		     "Don't show entries under that percent", parse_percent_limit),
 	OPT_CALLBACK(0, "percentage", NULL, "relative|absolute",
@@ -1757,15 +1757,17 @@ int cmd_top(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	status = target__parse_uid(target);
-	if (status) {
-		int saved_errno = errno;
-
-		target__strerror(target, status, errbuf, BUFSIZ);
-		ui__error("%s\n", errbuf);
+	if (top.uid_str) {
+		uid_t uid = parse_uid(top.uid_str);
 
-		status = -saved_errno;
-		goto out_delete_evlist;
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", top.uid_str);
+			status = -EINVAL;
+			goto out_delete_evlist;
+		}
+		status = parse_uid_filter(top.evlist, uid);
+		if (status)
+			goto out_delete_evlist;
 	}
 
 	if (target__none(target))
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 4db3d1bd686c..b06e10a116bb 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -88,9 +88,9 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 	else if (target->tid)
 		ret += SNPRINTF(bf + ret, size - ret, " (target_tid: %s",
 				target->tid);
-	else if (target->uid_str != NULL)
+	else if (top->uid_str != NULL)
 		ret += SNPRINTF(bf + ret, size - ret, " (uid: %s",
-				target->uid_str);
+				top->uid_str);
 	else
 		ret += SNPRINTF(bf + ret, size - ret, " (all");
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 4c5588dbb131..04ff926846be 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -48,6 +48,7 @@ struct perf_top {
 	const char	   *sym_filter;
 	float		   min_percent;
 	unsigned int	   nr_threads_synthesize;
+	const char	   *uid_str;
 
 	struct {
 		struct ordered_events	*in;
-- 
2.49.0.604.gff1f9ca942-goog


