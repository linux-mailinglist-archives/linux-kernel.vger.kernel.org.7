Return-Path: <linux-kernel+bounces-828224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B34B9433B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467B618A4D69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C42C324E;
	Tue, 23 Sep 2025 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ry3BU6z1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824E2BEFF3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601170; cv=none; b=JNTBKmZUmFwysAPaYa/PIwZXpx/ItKucKttkILLA4dSqlz8wl6M6K7f8VBMhYgpStmkprtSCJ56TSk12hDVL1d+3EfLA+RfEZbpyH0AU1uehDsWQ2+mZF+6nZWUKWMdyl6PlAyZq4MHMJCZdnnEsUSdzbuq/4mdp5/GMeopa23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601170; c=relaxed/simple;
	bh=9O0SNp6qNzDy9oFmBjqIkwm4W7+WsJXlTJVpqO78PTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FP+AqZ1C+vhyE8syMmFt+8bglF2VodGy4pQojo1QzKOq7HlJ5A02qWWFGMp9ao2EO2eb3OJeiaq/GCA4iwBH6xM7QIZfJM2SFFBSfOHoNoRKHpUBlWUfYTMGV8egN8hm81QZZXFzXHjvVi2DX8DIF7PTFHGhTMGJDBIBH0sLJTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ry3BU6z1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f93fe3831so6641965a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601168; x=1759205968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=Ry3BU6z1AWEESr/Tw2Zd4VC8ocFZVfV7UZwGJXTI3BedZffaNcI5tQV9mTyzmaHEaL
         2jdq4xE2xfL7jr4uNDXRNyyEHJhKtOmgj/17fhqk76V0s7Ex0KU+w1zzFFvMhLDCzdZD
         4jZPuPY0SQGeGEN+hRkpZR0M5Z+809RrZAYUBPYYGWrjMDDFsxoW/PeyW43+u9DCvJkE
         o5x3TqalpihIqV51K/hqdvSboFM29poArdj4p8u5L/Jbm8Y2wnTL8y7GRLp4JP+jnuJp
         Cs9ng5zbQy2BCLHibQJmbKVQPCTcmRDjIjGdDc3uQyEoPW5wGBnq7C+oXsXP73rQX2Xt
         g8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601168; x=1759205968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0JHoX72jOJKlox/FmxfaLo+8gSeVEW25ROCTEI3UNc=;
        b=h3mnANrKkufAM7QE+UkvECPxhxnZPs5IF7h2o3bd2MjRnyinGpSmtaaYE99mIe6lQy
         fjqOL5W3cKj5B2a/ZAX179QeLlsEfl0DYZa960yXyl/Y1hU6Z+GyeUkGRyzJB7iHc+Sm
         ZpR0d3LogTdwbv3k4vo+JmtmurnuNlbbhIN7cFrYmV4/SaBoKRjCFldZOoJ16dR61oer
         8eARqs8JJU3k1QuyReijJUxpkMHqibMSJsyZz03SYaVQ69QK2vNj3C1jhnV+OpBrl6rH
         cVB6ysKJpLc2urYM9/fgsyDYb3/3t1ywvJy6wi0oHG9Ve/zKutu4Vj3AgyFpC7A0CgC4
         0kFg==
X-Forwarded-Encrypted: i=1; AJvYcCXxYJS+pRidE+XJedPnx28LomaOyC0Fk7ayPmb3QiDia9LRkxU5GKIZygTqQFaXizK5s1ovA0L53ZBtZsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjCPRqFFybZErtvz4ZA07AMX6tBZSGviyMPy1ff7FgZFxWJ1k
	UfAyK6379XUVdP4O668D5Sl1SrYnCTK60xjyLrK3/v+3gS1MyEpBIvXrp/6Z2mrJVWsQNPhi8Zr
	T+owUozbXLw==
X-Google-Smtp-Source: AGHT+IGvRDv7iYQ4DuiY0lWhYKuV9AopBcB3rCWURZmJh46SLp5NMcg+FG/Da2UNrd8kbLv4JhV9QEWZyBx/
X-Received: from pgco29.prod.google.com ([2002:a63:731d:0:b0:b54:fe45:6acf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:430f:b0:2c4:dbc:6ad6
 with SMTP id adf61e73a8af0-2d01f344d5cmr2004981637.58.1758601167900; Mon, 22
 Sep 2025 21:19:27 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:37 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-19-irogers@google.com>
Subject: [PATCH v5 18/25] perf top: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a11f629c7d76..710604c4f6f6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1695,11 +1695,13 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 
 	if (!top.evlist->core.nr_entries) {
-		bool can_profile_kernel = perf_event_paranoid_check(1);
-		int err = parse_event(top.evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
+		struct evlist *def_evlist = evlist__new_default();
 
-		if (err)
+		if (!def_evlist)
 			goto out_delete_evlist;
+
+		evlist__splice_list_tail(top.evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	status = evswitch__init(&top.evswitch, top.evlist, stderr);
-- 
2.51.0.534.gc79095c0ca-goog


