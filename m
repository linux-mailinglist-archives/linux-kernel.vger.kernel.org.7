Return-Path: <linux-kernel+bounces-673633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873CFACE3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 19:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141E03A2978
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576F20DD4E;
	Wed,  4 Jun 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVDLVAwc"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B5204689
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059167; cv=none; b=Ho7UEGkUhGP+s8MSrff5MsGHjQMk7n0Te76LtL54sbBMWngOmiyTMjqTASp9Nzf6ozXYDSV7NJFCLTtgVd2fWWiD7Am0btEAWUK/OfkSBwBF/56Kb4rlJQfLLD/CIM86M+BPcWbZg0R6H4POanY4BUnCaYiY/jvlGifgpvdvfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059167; c=relaxed/simple;
	bh=Pr6uyNOCYDQtOIdkrEEBjYxHbHN2ZcnxheLKgXvILHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Tn026U5aFNucWl+930qT4K6pbm2mIBPldQPhfgpOZjQblqfw/UPjsCYtsiy4tF5C17wk3F3gxcMb3ZS/TvBjrr+lsvh41cRyhVJj574afwa64mcLZISY0edF5ABSsjuc9aMLnqGDQRgzNOazIo0xryGU6KPmFfQ5iE0BQX8lCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVDLVAwc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31171a736b2so154186a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059165; x=1749663965; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osXo3AqwK/4YO7kimxxv/q9KVIECdD745Jh5D5390RI=;
        b=iVDLVAwcmEppPf5aDxsk390schat4c0OKRO4W7rz3Q4L+lGVbABoIdDY/9w9GAYAgd
         3ia8cUEYUGPkUIufU9js5BeUNk2AxgIZiss2/aTIWVZZUissYrFYf8zM7idiErSFMEAt
         V/o3Btn9oOeu2gI9FJ+VInIoZTwNdTR3uBPetaWaqSGZTQ4WuWeCJojQRVLIGJkr5DXv
         LpxnGo6xUbO+3FxhtO/Od2awlfS6GCDoJANSU1/gZI/idJdWPGiEUHt7YyXF9nxLAyPe
         RduuV6C5g8edbIMKfl5I6nNycHwyDf6wSRay4TcfLgT7QG0nKXM9bXWUmf50Sea4F2SJ
         1v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059165; x=1749663965;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osXo3AqwK/4YO7kimxxv/q9KVIECdD745Jh5D5390RI=;
        b=UUiN294uzXDqE8HHEUEOmR5FP/WbKDO4Fib9i+PNz6VOz/arXlNGkS8aSY9O1Ztohf
         GyiAmKHU/gd+XcIKWxXkZ3m1EffVDdhW1Ge9gB0QjrhYBQ4jLFl0XYkXE5ZxVdA1nTjH
         bgEPF25gwidRP3vdNCgLEyYDexRYpcIs3MlCPohDfS7esnzZG7zLmRPQk6yAdkeA5d0W
         l+UrDo22f7LbFIuwDtc4fT9vMSnfZoISTkY84ZSiwbLf6BFZNwH/O0L7nWYrBGbfdgmQ
         5TToXcU3U4tP9e26/+TKbr9XXWLIAO9wFZf6NHEks0hXLqbCF72rOnXvwRL+d4V7Z9MI
         J75g==
X-Forwarded-Encrypted: i=1; AJvYcCUv0+zWr9jx0yUqm5WnuTVg/qnpn4KwgbWYGtBbWm8ua6G2FeCkgCQpz3LnCigROIob6ruYKDWrFq2qjAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdsyKbxu6Ffysex5veRhnH0BBKFQVb9eWOnjxaqOCUGxPNRoc
	yhZ++r4m7FyKJ+xnKPiR/Tr2khsJfGdbw2CPZH4fxujsH+XIKrItpvtDV3NBNkhrwtaoBAzRJk7
	b9Y1sxiKogg==
X-Google-Smtp-Source: AGHT+IGaJvKbsygH4nlibrH4C9ybgV0Y+hG1/QFJLM/QlJRX7V3i3wxQTU1yhbDG2f0xCgPzM5E/1IiYFrh1
X-Received: from pjg14.prod.google.com ([2002:a17:90b:3f4e:b0:311:a879:981f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c0f:b0:313:1769:eb49
 with SMTP id 98e67ed59e1d1-3131769eb8cmr2917651a91.8.1749059165471; Wed, 04
 Jun 2025 10:46:05 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:38 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-5-irogers@google.com>
Subject: [PATCH v4 04/10] perf record: Switch user option to use BPF filter
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding user processes by scanning /proc is inherently racy and
results in perf_event_open failures. Use a BPF filter to drop samples
where the uid doesn't match. Ensure adding the BPF filter forces
system-wide.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8059bce85a51..0b566f300569 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -175,6 +175,7 @@ struct record {
 	bool			timestamp_boundary;
 	bool			off_cpu;
 	const char		*filter_action;
+	const char		*uid_str;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3513,8 +3514,7 @@ static struct option __record_options[] = {
 		     "or ranges of time to enable events e.g. '-D 10-20,30-40'",
 		     record__parse_event_enable_time),
 	OPT_BOOLEAN(0, "kcore", &record.opts.kcore, "copy /proc/kcore"),
-	OPT_STRING('u', "uid", &record.opts.target.uid_str, "user",
-		   "user to profile"),
+	OPT_STRING('u', "uid", &record.uid_str, "user", "user to profile"),
 
 	OPT_CALLBACK_NOOPT('b', "branch-any", &record.opts.branch_stack,
 		     "branch any", "sample any taken branches",
@@ -4256,19 +4256,24 @@ int cmd_record(int argc, const char **argv)
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
2.50.0.rc0.604.gd4ff7b7c86-goog


