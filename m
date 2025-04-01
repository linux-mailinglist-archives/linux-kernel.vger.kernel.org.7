Return-Path: <linux-kernel+bounces-583988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD66A78225
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A729188735C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE277221F3B;
	Tue,  1 Apr 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVcGA6ZV"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63123221F12
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531918; cv=none; b=gY55nGS5jWPoQSWSlTK8sdqYfh9kNv6MBeyxDqR/v4pk9Oi9yaXoP3OP885aJovCocr1Bt6INVSSLaJ37HUMtKtBP/9RHegxg/uO212nzrTNose1m1HNDizuP69Ws7Mi4lLjc28d+cEDF2xep9a4VfNmMCzoaRgfQ2twp+Tt+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531918; c=relaxed/simple;
	bh=3ipXD9lA5krXojMgzTZJeNFbDoGDG3hIVLo9GFGHUwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=V+IqwgB9SbAyF9gOHFIXvGymewQU2YWstkINu6lrQzRCTT6aHpLmO/woguezIAbpcMafkjHL8qjDKCMUjiGUTHJA39LeoMKV/BFtP7mFOHY4PZM6kjje59+cWBu9ayfE9NxdRJoA1d6MB5MUG4k45Y+IvPfuQ33yW/M/wmjzcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVcGA6ZV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30364fc706fso10157663a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531917; x=1744136717; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbFOgtsegWIP33hU2q1VfvbvAOcEKBmypAgL+fgEkks=;
        b=AVcGA6ZVORQ3ZCOyq2ThYmZfrRW33AvYDpM8Lq5jXeYMIiUtULtuREmCGtCjHtYKP0
         kTSW/4SbRqKm42KRvB6ZKDG1dY1FAyikiMarp04ldKAsWXcjHmF1gIKqP2vb+b7H2Ws4
         vzzomoqYT7+Oys5VmQ1DXXEmMjl3wihAfaxhUpMI9QflevBJX962stDv3AMq0t0oiTsJ
         ZsI2wWwpCq7iAd8SAe9e7qw35bzO5rLm4VUhOL6xw0PPIl8VkLztGhUpL6ShWxTw6qVt
         Rzxdex2fWoPlmH8yTvAb/1VzQrZJyzVFrrIkbM/GnDGRQ6gxT0+ByQxD0OF/8NYLX3HY
         D8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531917; x=1744136717;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbFOgtsegWIP33hU2q1VfvbvAOcEKBmypAgL+fgEkks=;
        b=GYs70cKcWDBOcUWL4c8/XDwoX6qwceEJn9hgC3g0Ev0n02oFtOvVe1rC8cr1QZ/JJ5
         LDh5xJJQfcj+CNTijhE2LGwiEZFoALy1Iw5JiUNa1RtFXHRvBkv66eA+HZ/OkWFkCkQr
         5LOmGpmiNXaGIDsxSK4pH10JxokMenRCPhhRNkwEKdp1plebSv7R0nNy0BgArAtsfmEn
         qXHjB5vH3tMk5R+X0RkzjBX0Ia84mpzim7iI2IxmBGKBwQ23M1AgPlxABwEoJw7LMu8M
         bVpPvqd/sAL/7gmiXUllEddN20LzkD4kAKnO4cXBz/rWctA7yX4eR7eol8V0J64MRPYd
         TYeg==
X-Forwarded-Encrypted: i=1; AJvYcCVTypkvRv/M4rAWr6cGjPwk/TDUwS0QVfXMZZ2JIfp/N60SvQpxK5Do8Y65SSiaMBcqtvSYyR2A3x0Qk90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5iWvVaBB+SwhmtiVMJInitmqZMmNlX+CQ007bbVXrn5E7cjwF
	zhTMsbY3REM7sFp3MZNRZKt2Tf/JslU7FdQ2jcsCiEx4KDPCsc2Wngo+UYZRSuqevRZhSbJVBiH
	HvpVnJA==
X-Google-Smtp-Source: AGHT+IHS8CwqpCMF7HFeq4dKWZ9ly2piLbucMCbuAUmYD9n4d1+U+fgWdEeYJVD2NQ881z/O0fjUe65Qoc4e
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:2fa:26f0:c221])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264d:b0:305:5f55:899
 with SMTP id 98e67ed59e1d1-305608774f4mr6510152a91.11.1743531916860; Tue, 01
 Apr 2025 11:25:16 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:18 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-21-irogers@google.com>
Subject: [PATCH v1 20/48] perf dlfilter: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/dlfilters/dlfilter-test-api-v0.c |  4 ++--
 tools/perf/util/dlfilter.c                  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index 4ca2d7b2ea6c..bf2a1a7b3c71 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -166,10 +166,10 @@ int start(void **data, void *ctx)
 
 	CHECK(dlargc == 6);
 	CHECK(!strcmp(dlargv[0], "first"));
-	verbose = strtol(dlargv[1], NULL, 0);
+	verbose = (int)strtol(dlargv[1], NULL, 0);
 	d->ip = strtoull(dlargv[2], NULL, 0);
 	d->addr = strtoull(dlargv[3], NULL, 0);
-	d->do_early = strtol(dlargv[4], NULL, 0);
+	d->do_early = (int)strtol(dlargv[4], NULL, 0);
 	CHECK(!strcmp(dlargv[5], "last"));
 
 	pr_debug("%s API\n", __func__);
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ddacef881af2..0e513ac7feae 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -38,7 +38,7 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		else
 			d_al->dso = dso__name(dso);
 		d_al->is_64_bit = dso__is_64_bit(dso);
-		d_al->buildid_size = dso__bid(dso)->size;
+		d_al->buildid_size = (__u32)dso__bid(dso)->size;
 		d_al->buildid = dso__bid(dso)->data;
 	} else {
 		d_al->dso = NULL;
@@ -51,9 +51,9 @@ static void al_to_d_al(struct addr_location *al, struct perf_dlfilter_al *d_al)
 		d_al->sym_start = sym->start;
 		d_al->sym_end = sym->end;
 		if (al->addr < sym->end)
-			d_al->symoff = al->addr - sym->start;
+			d_al->symoff = (__u32)(al->addr - sym->start);
 		else if (al->map)
-			d_al->symoff = al->addr - map__start(al->map) - sym->start;
+			d_al->symoff = (__u32)(al->addr - map__start(al->map) - sym->start);
 		else
 			d_al->symoff = 0;
 		d_al->sym_binding = sym->binding;
@@ -290,9 +290,9 @@ static __s32 code_read(__u64 ip, struct map *map, struct machine *machine, void
 	u64 offset = map__map_ip(map, ip);
 
 	if (ip + len >= map__end(map))
-		len = map__end(map) - ip;
+		len = (__u32)(map__end(map) - ip);
 
-	return dso__data_read_offset(map__dso(map), machine, offset, buf, len);
+	return (__s32)dso__data_read_offset(map__dso(map), machine, offset, buf, len);
 }
 
 static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
-- 
2.49.0.504.g3bcea36a83-goog


