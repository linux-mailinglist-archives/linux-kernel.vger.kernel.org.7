Return-Path: <linux-kernel+bounces-744666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411ABB10FAE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D688E189CE34
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31F1DF24F;
	Thu, 24 Jul 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cw2EYYCy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAD2EB5CA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753374803; cv=none; b=OsmX+uyqt1dTRYcEUIFU6kLjEZONyWsfbfnmivSr/JnheGXmYUE1qi/05G/oHAA+aUBnolknrBFaXTjDPJCkcp+TATplKPEOHW8KUiV/smKZpbny3Fh4CI635lz8RxZGlqB9Qp/WzQ6XFtVUhh3i3BzO6ugfnH+ysnkuoDKtG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753374803; c=relaxed/simple;
	bh=MbrzOz6xbqjbPkpFZQpy97l7EOWbjfr7Msh9bjJm9Qo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=tJ2yXsugs3/ahsw5Yahq0YLTffQ7sCZ8E/uSyhtQwzgNZNreepVA4ZFjgVEy4HkpkKN2eRT/cH2O/wGNJENTVdNQb1DnGlujvs5Td9wh94fOAyTEm5tLd0NpxCh8T882L/vhJ6lnvE4dB2yDAZbNMzBTYlrJrRbJjJSrxyuoMtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cw2EYYCy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235c897d378so12371255ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753374801; x=1753979601; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxhgzI8LQ0zBBYyfTFQz7gg0JtyeRMIE8m8cXglLpRE=;
        b=cw2EYYCy698mrohsD1siDEtdqCdfqcUcqGj5Y8BuNVdBY2/X62ClUY7N0nA6V36wi3
         hAj/EprMAML0ywSc6ehu5kFWGUN6eEa31UI/3EpqwEwwjm6mwfJ3Bu/fhzGzEfJCbo+P
         9FvSM65T7GNj1dkJaf9Auhjb9CTqDK8lrJUrMkshC0S7qr+kENxPAKuwG8nqiaqIoZLJ
         HxP+YiaioE6u+TyM15YwZ8PXbQR/+owQd5zy7Nf4ADmH02fWvllChgoeA1Wq/RgJwajd
         pX7QCQvC31n7+Y7TJhr/pc2WXSJQmu1VQxdh6LcN+dNIrku6dKUQGv5osjgcXFMnJblG
         em/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753374801; x=1753979601;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxhgzI8LQ0zBBYyfTFQz7gg0JtyeRMIE8m8cXglLpRE=;
        b=qhNwUHpmnjhuo1e9KNi0OG9Jpo60u8+038Xh82S/CATHRMBNToLICmlyD/AxOGg5Ws
         Ma35pHik+qzxb70SlUGdGEl2u7n6siRQXF9oRg+hk8r4kq+PX668Q7dwpBRs9Xo2uqV4
         H92qiR8sdlDmnt+q9gWjdZCuL59AV05g6vPXcpK0eR82PTCgTh2upbl/zgeJOqVMzLPs
         znw/gR1/7a8Zu5YsphqX6HkhIGpSLC+scvYVujeYs4vCFpXia0oSdzYpVNxo5EXUbHaM
         slqWhV6G/BI46KHDHvXl4Y8bZyhhQFCJDPBlycaeyhdQLEfgmK3DlRRjF3yTvC9pJVjR
         CM2w==
X-Forwarded-Encrypted: i=1; AJvYcCUI7igluRL4mMyAeGs8IL9SskhZuQG/RsmySbyvVGFfD/K/dgUKNVYGdpbln5n0aCNvAz+5CBey5pdGVTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzO7GTZxVKakNhugN6J+yxQLBQ/f/w7NpEmH+48qBA64kQTPx
	l5oRjlRc0DnJSMIz1S7EvmlKhn/ybewWFyAPGzBZp6FVksYz2A/6pmfcE59An+5zYuB+655juGx
	fp6KdjxGXCQ==
X-Google-Smtp-Source: AGHT+IF0fV+tmN7JmkOxVM7NZXgVUq+X8iGgjMZe2Kp+psizTG6m0IdLE1kOnZzJoeycdPO/cCTFuUclSmhu
X-Received: from plgi7.prod.google.com ([2002:a17:902:cf07:b0:231:c831:9520])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c949:b0:22e:421b:49b1
 with SMTP id d9443c01a7336-23f98202832mr119778435ad.48.1753374800412; Thu, 24
 Jul 2025 09:33:20 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:32:43 -0700
In-Reply-To: <20250724163302.596743-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250724163302.596743-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250724163302.596743-4-irogers@google.com>
Subject: [PATCH v6 03/22] perf build-id: Change sprintf functions to snprintf
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

Pass in a size argument rather than implying all build id strings must
be SBUILD_ID_SIZE.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c            | 12 +++----
 tools/perf/builtin-buildid-list.c             |  6 ++--
 tools/perf/util/build-id.c                    | 33 ++++++++-----------
 tools/perf/util/build-id.h                    |  6 ++--
 tools/perf/util/disasm.c                      |  2 +-
 tools/perf/util/dso.c                         |  4 +--
 tools/perf/util/dsos.c                        |  2 +-
 tools/perf/util/event.c                       |  2 +-
 tools/perf/util/header.c                      |  2 +-
 tools/perf/util/map.c                         |  2 +-
 tools/perf/util/probe-event.c                 |  2 +-
 tools/perf/util/probe-file.c                  |  4 +--
 tools/perf/util/probe-finder.c                |  2 +-
 .../scripting-engines/trace-event-python.c    |  7 ++--
 tools/perf/util/symbol.c                      |  2 +-
 15 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index b0511d16aeb6..3f7739b21148 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -31,7 +31,7 @@
 #include <linux/string.h>
 #include <linux/err.h>
 
-static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
+static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid, size_t sbuildid_size)
 {
 	char root_dir[PATH_MAX];
 	char *p;
@@ -42,7 +42,7 @@ static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
 	if (!p)
 		return -1;
 	*p = '\0';
-	return sysfs__sprintf_build_id(root_dir, sbuildid);
+	return sysfs__snprintf_build_id(root_dir, sbuildid, sbuildid_size);
 }
 
 static int build_id_cache__kcore_dir(char *dir, size_t sz)
@@ -128,7 +128,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 		return -1;
 	*p = '\0';
 
-	if (build_id_cache__kcore_buildid(from_dir, sbuildid) < 0)
+	if (build_id_cache__kcore_buildid(from_dir, sbuildid, sizeof(sbuildid)) < 0)
 		return -1;
 
 	scnprintf(to_dir, sizeof(to_dir), "%s/%s/%s",
@@ -187,7 +187,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 		return -1;
 	}
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	err = build_id_cache__add_s(sbuild_id, filename, nsi,
 				    false, false);
 	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
@@ -211,7 +211,7 @@ static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 		return -1;
 	}
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	err = build_id_cache__remove_s(sbuild_id);
 	pr_debug("Removing %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
@@ -317,7 +317,7 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 	}
 	err = 0;
 
-	build_id__sprintf(&bid, sbuild_id);
+	build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	if (build_id_cache__cached(sbuild_id))
 		err = build_id_cache__remove_s(sbuild_id);
 
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 52dfacaff8e3..ba8ba0303920 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -31,7 +31,7 @@ static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
 
 	memset(bid_buf, 0, sizeof(bid_buf));
 	if (dso__has_build_id(dso))
-		build_id__sprintf(dso__bid_const(dso), bid_buf);
+		build_id__snprintf(dso__bid_const(dso), bid_buf, sizeof(bid_buf));
 	printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), map__end(map));
 	if (dso_long_name != NULL)
 		printf(" %s", dso_long_name);
@@ -57,7 +57,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
 	char sbuild_id[SBUILD_ID_SIZE];
 	int ret;
 
-	ret = sysfs__sprintf_build_id("/", sbuild_id);
+	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
 	if (ret != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
@@ -69,7 +69,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
 	char sbuild_id[SBUILD_ID_SIZE];
 	int ret;
 
-	ret = filename__sprintf_build_id(name, sbuild_id);
+	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
 	if (ret != sizeof(sbuild_id))
 		return ret < 0 ? ret : -EINVAL;
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 5bc2040bdd0d..aa35dceace90 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -67,24 +67,17 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
-int build_id__sprintf(const struct build_id *build_id, char *bf)
+int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size)
 {
-	char *bid = bf;
-	const u8 *raw = build_id->data;
-	size_t i;
-
-	bf[0] = 0x0;
+	size_t offs = 0;
 
-	for (i = 0; i < build_id->size; ++i) {
-		sprintf(bid, "%02x", *raw);
-		++raw;
-		bid += 2;
-	}
+	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
+		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
 
-	return (bid - bf) + 1;
+	return offs;
 }
 
-int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
+int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size)
 {
 	char notes[PATH_MAX];
 	struct build_id bid;
@@ -99,10 +92,10 @@ int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id)
 	if (ret < 0)
 		return ret;
 
-	return build_id__sprintf(&bid, sbuild_id);
+	return build_id__snprintf(&bid, sbuild_id, sbuild_id_size);
 }
 
-int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
+int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size)
 {
 	struct build_id bid;
 	int ret;
@@ -111,7 +104,7 @@ int filename__sprintf_build_id(const char *pathname, char *sbuild_id)
 	if (ret < 0)
 		return ret;
 
-	return build_id__sprintf(&bid, sbuild_id);
+	return build_id__snprintf(&bid, sbuild_id, sbuild_id_size);
 }
 
 /* asnprintf consolidates asprintf and snprintf */
@@ -212,9 +205,9 @@ static bool build_id_cache__valid_id(char *sbuild_id)
 		return false;
 
 	if (!strcmp(pathname, DSO__NAME_KALLSYMS))
-		ret = sysfs__sprintf_build_id("/", real_sbuild_id);
+		ret = sysfs__snprintf_build_id("/", real_sbuild_id, sizeof(real_sbuild_id));
 	else if (pathname[0] == '/')
-		ret = filename__sprintf_build_id(pathname, real_sbuild_id);
+		ret = filename__snprintf_build_id(pathname, real_sbuild_id, sizeof(real_sbuild_id));
 	else
 		ret = -EINVAL;	/* Should we support other special DSO cache? */
 	if (ret >= 0)
@@ -243,7 +236,7 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 	if (!dso__has_build_id(dso))
 		return NULL;
 
-	build_id__sprintf(dso__bid_const(dso), sbuild_id);
+	build_id__snprintf(dso__bid_const(dso), sbuild_id, sizeof(sbuild_id));
 	linkname = build_id_cache__linkname(sbuild_id, NULL, 0);
 	if (!linkname)
 		return NULL;
@@ -769,7 +762,7 @@ static int build_id_cache__add_b(const struct build_id *bid,
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(bid, sbuild_id);
+	build_id__snprintf(bid, sbuild_id, sizeof(sbuild_id));
 
 	return __build_id_cache__add_s(sbuild_id, name, nsi, is_kallsyms,
 				       is_vdso, proper_name, root_dir);
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index e3e0a446ff0c..47e621cebe1b 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -21,10 +21,10 @@ struct feat_fd;
 struct nsinfo;
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size);
-int build_id__sprintf(const struct build_id *build_id, char *bf);
+int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size);
 bool build_id__is_defined(const struct build_id *bid);
-int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
-int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
+int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size);
+int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size);
 char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
 				    size_t size);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index ff475a239f4b..b1e4919d016f 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1218,7 +1218,7 @@ int symbol__strerror_disassemble(struct map_symbol *ms, int errnum, char *buf, s
 		char *build_id_msg = NULL;
 
 		if (dso__has_build_id(dso)) {
-			build_id__sprintf(dso__bid(dso), bf + 15);
+			build_id__snprintf(dso__bid(dso), bf + 15, sizeof(bf) - 15);
 			build_id_msg = bf;
 		}
 		scnprintf(buf, buflen,
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index c6c1637e098c..4ff94029632e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -217,7 +217,7 @@ int dso__read_binary_type_filename(const struct dso *dso,
 			break;
 		}
 
-		build_id__sprintf(dso__bid_const(dso), build_id_hex);
+		build_id__snprintf(dso__bid_const(dso), build_id_hex, sizeof(build_id_hex));
 		len = __symbol__join_symfs(filename, size, "/usr/lib/debug/.build-id/");
 		snprintf(filename + len, size - len, "%.2s/%s.debug",
 			 build_id_hex, build_id_hex + 2);
@@ -1708,7 +1708,7 @@ static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	return fprintf(fp, "%s", sbuild_id);
 }
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 4d213017d202..47538273915d 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -373,7 +373,7 @@ static int dsos__fprintf_buildid_cb(struct dso *dso, void *data)
 
 	if (args->skip && args->skip(dso, args->parm))
 		return 0;
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 	args->ret += fprintf(args->fp, "%-40s %s\n", sbuild_id, dso__long_name(dso));
 	return 0;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 14b0d3689137..fcf44149feb2 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -334,7 +334,7 @@ size_t perf_event__fprintf_mmap2(union perf_event *event, FILE *fp)
 
 		build_id__init(&bid, event->mmap2.build_id,
 			       event->mmap2.build_id_size);
-		build_id__sprintf(&bid, sbuild_id);
+		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 
 		return fprintf(fp, " %d/%d: [%#" PRI_lx64 "(%#" PRI_lx64 ") @ %#" PRI_lx64
 				   " <%s>]: %c%c%c%c %s\n",
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 53d54fbda10d..2aba0d829c9e 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2303,7 +2303,7 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 			free(m.name);
 		}
 
-		build_id__sprintf(dso__bid(dso), sbuild_id);
+		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 		pr_debug("build id event received for %s: %s [%zu]\n",
 			 dso__long_name(dso), sbuild_id, size);
 		dso__put(dso);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index d729438b7d65..0f6b185f9589 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -354,7 +354,7 @@ int map__load(struct map *map)
 		if (dso__has_build_id(dso)) {
 			char sbuild_id[SBUILD_ID_SIZE];
 
-			build_id__sprintf(dso__bid(dso), sbuild_id);
+			build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 			pr_debug("%s with build id %s not found", name, sbuild_id);
 		} else
 			pr_debug("Failed to open %s", name);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..cb777b878a48 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1089,7 +1089,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 	}
 	if (dinfo->build_id) {
 		build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
-		build_id__sprintf(&bid, sbuild_id);
+		build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 	}
 	debuginfo__delete(dinfo);
 	if (ret == 0 || ret == -ENOENT) {
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index ec8ac242fedb..5069fb61f48c 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -448,10 +448,10 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
 	if (!target || !strcmp(target, DSO__NAME_KALLSYMS)) {
 		target = DSO__NAME_KALLSYMS;
 		is_kallsyms = true;
-		ret = sysfs__sprintf_build_id("/", sbuildid);
+		ret = sysfs__snprintf_build_id("/", sbuildid, sizeof(sbuildid));
 	} else {
 		nsinfo__mountns_enter(nsi, &nsc);
-		ret = filename__sprintf_build_id(target, sbuildid);
+		ret = filename__snprintf_build_id(target, sbuildid, sizeof(sbuildid));
 		nsinfo__mountns_exit(&nsc);
 	}
 
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3cc7c40f5097..b74f6fe24bb6 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -859,7 +859,7 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
 		if (pf->dbg->build_id) {
 			build_id__init(&bid, pf->dbg->build_id, BUILD_ID_SIZE);
-			build_id__sprintf(&bid, sbuild_id);
+			build_id__snprintf(&bid, sbuild_id, sizeof(sbuild_id));
 		}
 		ret = find_source_path(pf->fname, sbuild_id, comp_dir, &fpath);
 		if (ret < 0) {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 00f2c6c5114d..6655c0bbe0d8 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -780,14 +780,13 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
 			    const char *sym_field, const char *symoff_field,
 			    const char *map_pgoff)
 {
-	char sbuild_id[SBUILD_ID_SIZE];
-
 	if (al->map) {
+		char sbuild_id[SBUILD_ID_SIZE];
 		struct dso *dso = map__dso(al->map);
 
 		pydict_set_item_string_decref(dict, dso_field,
 					      _PyUnicode_FromString(dso__name(dso)));
-		build_id__sprintf(dso__bid(dso), sbuild_id);
+		build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_bid_field,
 			_PyUnicode_FromString(sbuild_id));
 		pydict_set_item_string_decref(dict, dso_map_start,
@@ -1238,7 +1237,7 @@ static int python_export_dso(struct db_export *dbe, struct dso *dso,
 	char sbuild_id[SBUILD_ID_SIZE];
 	PyObject *t;
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 
 	t = tuple_new(5);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ae0bd568ac45..573c65da9fe0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2152,7 +2152,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 			goto proc_kallsyms;
 	}
 
-	build_id__sprintf(dso__bid(dso), sbuild_id);
+	build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
 
 	/* Find kallsyms in build-id cache with kcore */
 	scnprintf(path, sizeof(path), "%s/%s/%s",
-- 
2.50.0.727.gbf7dc18ff4-goog


