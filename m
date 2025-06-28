Return-Path: <linux-kernel+bounces-707511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF8AEC4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 06:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49923AF204
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C18221287;
	Sat, 28 Jun 2025 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rzk4zldW"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5BA22127B
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086248; cv=none; b=ZrE9+gWdr5emW/utvwC2cXqsybKOW92xJW3Mxp/mYWMlVPAEWQI2vEMuEhOqQtF5/rJPtDZuejQZoWmclBfW00zNQdFJf9R2/QeRdoQhlYh5gE3vQmnu8n5jrSbcTPk3seFvrEsfXJuaI2XI1vF7EFYc/Yv3m874De1iBHjwVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086248; c=relaxed/simple;
	bh=Rls+OYEH+weNr8mgfAzavaCxy7juMyRMm0AYcaMJ00I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JGX82ySWO98YIIQXPuy59mgOrU092wNKXMMslO8KQk8qMR1hE9cWM6WAEwPZVKfY2maOIzQyF3bT+11KX+hidwE9pG6i66ktMK6xBHBRTsjiHCNi+m/lG9bM2Srf8DudlqpRqsOU4M0+8kpc/AasRcshonoBQQ+7w2q+hOwKx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rzk4zldW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2349218a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086246; x=1751691046; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhNgR0jggEgPcm92nWMts4STCtLu+unFNFe51p41/ks=;
        b=Rzk4zldWyqN5YdiMfxcRsExKkUz15E86mj5+RTmdMq6FMhLQ3k1gUWxnJ3/h9PAQUW
         aZuU8idY8RPkt+xneCCtXvN7kfMu8fMnGHfYCb7cmMoUSaIcZehz6C3H6RXn2O1TXs9U
         FnGN/eDt/QnGp4+zBtrE4Z/g7pQyWDufx9uRvqlDp2Mrd6x16Br44Wf6xaWSqPm4IMD0
         skMjORLMiNMjUCxHSJTiWwirimGQYnlIZdQz8B7QEjivDPxzoex/K+lVmmXV7b8j8k4m
         kVbj3/GJXDoqLy2qWfs9JvXXURyRzm/qxNihp9gEJ9iYIoTJzS/CquVafT/pYStrPQqR
         qbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086246; x=1751691046;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhNgR0jggEgPcm92nWMts4STCtLu+unFNFe51p41/ks=;
        b=CBGT8CYnk8ffDjNzMauz3zf7X6pR3/5Tc6TpRVlbK/4msEXu2uKAMurp1LD62JdU6x
         A8rrUPLH+qI1Gp9KgNYFVttcVv0+C4sVm29A3pjbBfmioVc2xhlr40ZeJcq1KyT8CLv4
         +zE2wOJ9MMYA0F0TAppYOr0ARqQY9omBrdoXjxjkdRUgD44AfNnA+Zsu2hAWe5hzgEML
         IEPSFza0VqFQ4yG0Rg18t9F4vECrI3BSNiQh++BoONE5qWxd665Ec9gS2JdIA4j9QVQK
         w5X/olNG3G6+FMT79VRpcIyKk2laiNrPtDMuuGIHXHZrxtrU9tptlcC+ZOhiD3ZrShwG
         SoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHdOh+5ocSSHXHZNiR2AJNuDkerGzvqBElz48KONKqiiJUJpYkdd1CIe3FXNp6YfOY3n6sAJ5eyPtrtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlE/RUe7yxrFsIc7ZeROf+tj29j0Hzbiu52pTBbqBr2fgMN1N
	ngrNMYdrHyn5YhhqiBuv1HPosj9R422U4NJHHDHEeGIfva4f/hIm2mLU4iE4HKDQ9I5yLcz6s3c
	zzNO5cCSsIg==
X-Google-Smtp-Source: AGHT+IHGSP8ghcsLex9rV/DWu974KETLxAJzRGhz0EHAcVyp++M48UPOe4csSadruYBpQcd/oR/J5NXfKFOV
X-Received: from pfve20.prod.google.com ([2002:a05:6a00:1a94:b0:746:2ceb:2ec0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7350:b0:220:5fd4:a882
 with SMTP id adf61e73a8af0-220a16c8c73mr7991271637.33.1751086244124; Fri, 27
 Jun 2025 21:50:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:49:59 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-6-irogers@google.com>
Subject: [PATCH v5 05/23] perf build-id: Ensure struct build_id is empty
 before use
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

If a build ID is read then not all code paths may ensure it is empty
before use. Initialize the build_id to be zero-ed unless there is
clear initialization such as a call to build_id__init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/inject-buildid.c  | 2 +-
 tools/perf/builtin-buildid-cache.c | 8 ++++----
 tools/perf/tests/pe-file-parsing.c | 2 +-
 tools/perf/tests/sdt.c             | 2 +-
 tools/perf/util/build-id.c         | 6 +++---
 tools/perf/util/debuginfo.c        | 2 +-
 tools/perf/util/probe-event.c      | 3 ++-
 tools/perf/util/probe-finder.c     | 3 ++-
 tools/perf/util/symbol-minimal.c   | 2 +-
 tools/perf/util/symbol.c           | 5 +++--
 tools/perf/util/synthetic-events.c | 2 +-
 11 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index f55c07e4be94..aad572a78d7f 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -80,7 +80,7 @@ static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
 		   int typeflag, struct FTW *ftwbuf __maybe_unused)
 {
 	struct bench_dso *dso = &dsos[nr_dsos];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 
 	if (typeflag == FTW_D || typeflag == FTW_SL)
 		return 0;
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 3f7739b21148..e936a34b7d37 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -175,7 +175,7 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int err;
 	struct nscookie nsc;
 
@@ -198,7 +198,7 @@ static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nscookie nsc;
 
 	int err;
@@ -275,7 +275,7 @@ static int build_id_cache__purge_all(void)
 static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 {
 	char filename[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
@@ -303,7 +303,7 @@ static int build_id_cache__fprintf_missing(struct perf_session *session, FILE *f
 static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nscookie nsc;
 
 	int err;
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
index fff58b220c07..30c7da79e109 100644
--- a/tools/perf/tests/pe-file-parsing.c
+++ b/tools/perf/tests/pe-file-parsing.c
@@ -24,7 +24,7 @@ static int run_dir(const char *d)
 {
 	char filename[PATH_MAX];
 	char debugfile[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	char debuglink[PATH_MAX];
 	char expect_build_id[] = {
 		0x5a, 0x0f, 0xd8, 0x82, 0xb5, 0x30, 0x84, 0x22,
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 919712899251..de4c7916b40d 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -28,7 +28,7 @@ static int target_function(void)
 static int build_id_cache__add_file(const char *filename)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int err;
 
 	err = filename__read_build_id(filename, &bid);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 3386fa8e1e7e..1abd5a670665 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -95,7 +95,7 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
 int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuild_id_size)
 {
 	char notes[PATH_MAX];
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	if (!root_dir)
@@ -112,7 +112,7 @@ int sysfs__snprintf_build_id(const char *root_dir, char *sbuild_id, size_t sbuil
 
 int filename__snprintf_build_id(const char *pathname, char *sbuild_id, size_t sbuild_id_size)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = filename__read_build_id(pathname, &bid);
@@ -849,7 +849,7 @@ static int filename__read_build_id_ns(const char *filename,
 
 static bool dso__build_id_mismatch(struct dso *dso, const char *name)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	bool ret = false;
 
 	mutex_lock(dso__lock(dso));
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index b5deea7cbdf2..a44c70f93156 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -103,7 +103,7 @@ struct debuginfo *debuginfo__new(const char *path)
 	char buf[PATH_MAX], nil = '\0';
 	struct dso *dso;
 	struct debuginfo *dinfo = NULL;
-	struct build_id bid;
+	struct build_id bid = { .size = 0};
 
 	/* Try to open distro debuginfo files */
 	dso = dso__new(path);
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 307ad6242a4e..3c87aa6f7d3b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1063,7 +1063,6 @@ static int sprint_line_description(char *sbuf, size_t size, struct line_range *l
 static int __show_line_range(struct line_range *lr, const char *module,
 			     bool user)
 {
-	struct build_id bid;
 	int l = 1;
 	struct int_node *ln;
 	struct debuginfo *dinfo;
@@ -1088,6 +1087,8 @@ static int __show_line_range(struct line_range *lr, const char *module,
 			ret = -ENOENT;
 	}
 	if (dinfo->build_id) {
+		struct build_id bid;
+
 		build_id__init(&bid, dinfo->build_id, BUILD_ID_SIZE);
 		build_id__sprintf(&bid, sbuild_id);
 	}
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 3cc7c40f5097..1bbb91758316 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -848,7 +848,6 @@ static int probe_point_lazy_walker(const char *fname, int lineno,
 /* Find probe points from lazy pattern  */
 static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 {
-	struct build_id bid;
 	char sbuild_id[SBUILD_ID_SIZE] = "";
 	int ret = 0;
 	char *fpath;
@@ -858,6 +857,8 @@ static int find_probe_point_lazy(Dwarf_Die *sp_die, struct probe_finder *pf)
 
 		comp_dir = cu_get_comp_dir(&pf->cu_die);
 		if (pf->dbg->build_id) {
+			struct build_id bid;
+
 			build_id__init(&bid, pf->dbg->build_id, BUILD_ID_SIZE);
 			build_id__sprintf(&bid, sbuild_id);
 		}
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index c73fe2e09fe9..7201494c5c20 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -317,7 +317,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		  struct symsrc *runtime_ss __maybe_unused,
 		  int kmodule __maybe_unused)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	int ret;
 
 	ret = fd__is_64_bit(ss->fd);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ea86a6253f04..0fe227d32b98 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1812,7 +1812,6 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
 	bool perfmap;
-	struct build_id bid;
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
@@ -1873,6 +1872,8 @@ int dso__load(struct dso *dso, struct map *map)
 	 */
 	if (!dso__has_build_id(dso) &&
 	    is_regular_file(dso__long_name(dso))) {
+		struct build_id bid = { .size = 0, };
+
 		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
 		if (filename__read_build_id(name, &bid) > 0)
 			dso__set_build_id(dso, &bid);
@@ -2121,7 +2122,7 @@ static bool filename__readable(const char *file)
 
 static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	char sbuild_id[SBUILD_ID_SIZE];
 	bool is_host = false;
 	char path[PATH_MAX];
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 68bb7c5fe1b1..b7ebee95536f 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -368,7 +368,7 @@ static void perf_record_mmap2__read_build_id(struct perf_record_mmap2 *event,
 					     struct machine *machine,
 					     bool is_kernel)
 {
-	struct build_id bid;
+	struct build_id bid = { .size = 0, };
 	struct nsinfo *nsi;
 	struct nscookie nc;
 	struct dso *dso = NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog


