Return-Path: <linux-kernel+bounces-621126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93D2A9D44A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE164C2599
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F322F75F;
	Fri, 25 Apr 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3k4QB3i"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCD922A7F8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617232; cv=none; b=RqBSqfPrcmCMJb5NU8ryd7vkMtH9saaT6QdKty2Rq5MLXQ9LN2MQt7sEyRMxf+YxzYP656Ew14WzNjqeqa2+30GiH+G6L8aJu5xcOndHFmoqxy1fyrzFFPFFAy6+8CZf29dv8DALoomISWBsKzOpDqi0KHr/a1WANqtWSLl6M1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617232; c=relaxed/simple;
	bh=LvH1IfFiRYzJWPR2DBxrtN9tmwFbXEeic3+ot8Z8LH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=A5VxGflqo1zrsr7ypdLc3deo9TAmtf6V4PtoDnxMDXjXIayzj8K2jXObQyqSgFjNfZVg3c3d4ieepThXokhuhpJBg8MZ+V9Y/0ZeR3pRQFaa8/I9C5pNGii1W/xQ2W2klsF7BAPvwHyfPa9awiuQETO5efo+zeDbgSYXCWWmREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j3k4QB3i; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b00aa1f50d1so1579506a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617230; x=1746222030; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XmvjAR81O8HPM36SkAdYui69A1+Io4OkQZ3ltx3CRQ=;
        b=j3k4QB3i9pU4LSIS5+X5GyRNIPOsseSzehZ4lSpMVS6eC2cw4A3YqXC/hZ3IHQpQgd
         WR1gprJi53SVJM25kGM37XaD/62TQA3MmmJfDG3d25v3Bv3lb2Odsiv1L7k7ITxZClIO
         l/QUkmRDDlBwHDbHhSxVI+K3vLMEe2zOrPV3KI3x7Hzd5ThQkr7LQhfS+AUIY/7G3kMy
         8o2Ivu62wJY8Ha9DuSHWwe2I4y3YbYgSqnm8ggOA56LRXqyg2OLYNaM2ltF3Uup1Q80s
         7jmgI8SAQre+MSqqgEqN3aj3od+kZrrTLMf0ZB7nbS4x1+0a/Ovw/ZicrFFznZaUydc8
         egFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617230; x=1746222030;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XmvjAR81O8HPM36SkAdYui69A1+Io4OkQZ3ltx3CRQ=;
        b=ggaCcPOBY4H7BLtO0sR6As6j3FsiFvZhPoWXwK3hnN//6EafdrPOosf2+EtPoWvh1O
         r91hanZrSw9J8Vg78uz6nFmcIhf8XeGjEgL2gJTwtQDDSukQ2V2olCxW1VUDYnSAoV1e
         8CHcUikfU4wvVLQe5YyXezpdiOZ1jfshqoLzXf1uD7mrG8IrIZP5z8LPMbcbMImSffVA
         04lLMVbo45t8CG96WGxkhenkSb27rMX2/B6li1/vtexc4Xi+2DU1hg4B0pFx2vhX+dc0
         +Djk3bpdoCjAQJMd30HfVCOis581s7M/oOizdFi9ohYFKAY/UZJC+rysmr0UH5XD1rPq
         ApOw==
X-Forwarded-Encrypted: i=1; AJvYcCXDgiLZS4MyjfGiSzGsO/5pcvR+jrKH0RMMX+qZh2sUsHnYRjq0VzMa/TylXwCrN4KLSG8WBIGcXCbPiiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLZiq+nv6I0dfQLbVseV5Zf9+LvRBUkHPGAXiubO13lEoL/uY
	ygmFgD5eTrOw3fv5Gkc61C0wq86AZHk+zmIi0Twyy2/PplhZHs8AXcCCiJ/nWOxPyVktePk08G0
	cwzcLrQ==
X-Google-Smtp-Source: AGHT+IFPx94l2No/fmon1OdF/8vvvV7PGuto3FEMdzF4QNWLs5H2WqILYAjuXpwf2f9FODWfheUbYlUZVcMv
X-Received: from pgcp16.prod.google.com ([2002:a63:7410:0:b0:af2:448e:a04d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:394b:b0:1f5:6878:1a43
 with SMTP id adf61e73a8af0-2045b6f4c38mr5841222637.14.1745617230027; Fri, 25
 Apr 2025 14:40:30 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:02 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-5-irogers@google.com>
Subject: [PATCH v3 04/10] perf record: Switch user option to use BPF filter
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

The existing --uid option finds user processes by scanning
/proc. Scanning /proc is inherently racy due to processes being in
/proc but then exiting before perf does the perf_event_open. When the
perf_event_open fails perf will terminate reporting errors which is a
disappointing user experience. Scanning /proc when perf starts also
cannot inform perf of new user processes starting.

The ability to filter perf events with BPF isn't new, and has been in
the perf tool for 10 years:
https://lore.kernel.org/all/1444826502-49291-8-git-send-email-wangnan0@huawei.com/
An ability to do filtering on the command line with a BPF program
that's part of perf was added 2 years ago:
https://lore.kernel.org/all/20230314234237.3008956-1-namhyung@kernel.org/
This was then extended to support uids as a way of filtering:
https://lore.kernel.org/all/20240524205227.244375-1-irogers@google.com/

This change switches the perf record --uid option to use the BPF
filter code to avoid the inherent race and existing failures. To
ensure all processes are considered by the filter, the change forces
system-wide mode.

Using BPF has permission issues in loading the BPF program not present
in scanning /proc. As the scanning approach would miss new programs
and fail due to the race, this is considered preferable. The change
also avoids opening a perf event per PID, which is less overhead in
the kernel.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7b64013ba8c0..5eddf3568b04 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -174,6 +174,7 @@ struct record {
 	bool			timestamp_boundary;
 	bool			off_cpu;
 	const char		*filter_action;
+	const char		*uid_str;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3465,8 +3466,7 @@ static struct option __record_options[] = {
 		     "or ranges of time to enable events e.g. '-D 10-20,30-40'",
 		     record__parse_event_enable_time),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
-	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &record.uid_str, "user", "user to profile"),
 
 	OPT_CALLBACK_NOOPT('b', "branch-any", &record.opts.branch_stack,
 		     "branch any", "sample any taken branches",
@@ -4205,19 +4205,24 @@ int cmd_record(int argc, const char **argv)
 		ui__warning("%s\n", errbuf);
 	}
 
-	err = target__parse_uid(&rec->opts.target);
-	if (err) {
-		int saved_errno = errno;
+	if (rec->uid_str) {
+		uid_t uid = parse_uid(rec->uid_str);
 
-		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__error("%s", errbuf);
+		if (uid == UINT_MAX) {
+			ui__error("Invalid User: %s", rec->uid_str);
+			err = -EINVAL;
+			goto out;
+		}
+		err = parse_uid_filter(rec->evlist, uid);
+		if (err)
+			goto out;
 
-		err = -saved_errno;
-		goto out;
+		/* User ID filtering implies system wide. */
+		rec->opts.target.system_wide = true;
 	}
 
-	/* Enable ignoring missing threads when -u/-p option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
+	/* Enable ignoring missing threads when -p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.pid;
 
 	evlist__warn_user_requested_cpus(rec->evlist, rec->opts.target.cpu_list);
 
-- 
2.49.0.850.g28803427d3-goog


