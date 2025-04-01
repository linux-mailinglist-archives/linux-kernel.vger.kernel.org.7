Return-Path: <linux-kernel+bounces-584013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CAA78247
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A34169B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F6229B10;
	Tue,  1 Apr 2025 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5Q1a0IW"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432F2288FB
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531971; cv=none; b=JrrnKpEJ09L5XSYd0gUBdem79oeMzprPzMFFUTtWGDPYWJ5tuRDR9BvDVHK51DrIGVWIOQGhQcvl8juz7JFkyrF59yohMG5rzzHr0uwTgVAutNIuugTibyUR4SmV5P5ZKkCefwvB9i93UPiZjwkmryGAe+xhWpybtEYOsIectQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531971; c=relaxed/simple;
	bh=loSeINwlbc6XnjqNUnme9Ii2wesULU3u9gelnKxDOWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RnhaVD1jqvXOE2PPwRz1XCWwizuC1DP77UCmQyuZGdAI8ey/dHXspXHegCsC9Q4+DoQ1RBUIJP7BE6p4KU1X2ZsXwd5d4Q6jsRhgNVPPF+N7/3y7Ujv9y3LGOzCIC4c0HQsVyYeSvL0AI/CSNiY4GGvPkX6xqObOXVQon77vrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5Q1a0IW; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72bd7984706so310602a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531968; x=1744136768; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXDN2IiTwXgBiyK9J/TipFHWdZHNwXGG7JKhdVlTKrc=;
        b=R5Q1a0IWGzWlzo1JrDWeQpmAxwp3pvpMSCmVoqBOjPORBBD/6971t7w+R7QUnfPrbC
         AZfBS8j8Dsp8Zf6wMOZNxeN3kyfqph9rTUDss1DVv4QZqRoAkQxoy04NzCSh8tE+iC+s
         fa4M4YTEqzy+tkmQk4C1pZ6pdvIzhdjO07iByhHK14VreN7XVMFLZFhEw0qpxS4o7IL1
         nQwESGL/w+oXvvdf++hSwmYwodPUtWgIFTmP/k6p7cSDzSWcQrDrXs4Icj1sXi+mlpPV
         M2AuA2xNyZ5T00r7H3iqXyhWWLgkGVRRigRQfDKhAgqn+sBZicJR/aDpFk5L8T53Kbu7
         dw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531968; x=1744136768;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXDN2IiTwXgBiyK9J/TipFHWdZHNwXGG7JKhdVlTKrc=;
        b=XCXp/7dPwrZV57GLFnOQwV7UnHZJzyN/w+YuShotNoCV94LylSylLqXdYG/HDZw1tA
         nP3aFs0v0xKd5QdVN+4iYp+3m3mRksuYHfkBrnO4h5DjI2z+50fusQv/aU3UTgtrLsPi
         7A/w5nMfbPHJHlVAWFE4DVSc0UUGZics7i63dFziijm3OO0jyPQipTYiIIJJfvMW0DDv
         3zmJBxGOUlVl6EwIZhs2YQXZsWZ2vY7w9yGcGVCuqimOXxpc1enPtlh2D+E9JrErquvi
         HboVcgP7mhwVHzhZ9Ybr2cRACYsmEXRocAQO5pf7EDZRIOSN0K9VM4jSyRxfarofuD0Q
         rKnA==
X-Forwarded-Encrypted: i=1; AJvYcCUit08g1XF2FdlGeftU5EF1snWRZhtGFv1bFeT8R/nxsUsQqd9qxbI/Fk2jEoTObL9n+vOYLzkbCDvTBAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLWE/voaLGxzwDQAxXDVKRfb0ykF68XmSffK1sDKBUeg6ga2a
	5pp8jMoMdiS/pPxNN7rQMWkcB7GTa41eojN8mxao3WBkXd60o72rmlZTGBsgSjrjo9gHiqzoh4z
	ap/6+nQ==
X-Google-Smtp-Source: AGHT+IHUffenbdrxtR2eLoeeVEpZywaWbKXEVYkXtogEfzNSPRpDS6P26p637BPNcEuYtvO3lbjegNy1msNO
X-Received: from oabhi26.prod.google.com ([2002:a05:6870:c99a:b0:2c1:5c70:acac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:2808:b0:72a:f44b:13ed
 with SMTP id 46e09a7af769-72c637771c3mr8057489a34.2.1743531968061; Tue, 01
 Apr 2025 11:26:08 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:43 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-46-irogers@google.com>
Subject: [PATCH v1 45/48] perf symbol: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/symbol-elf.c | 33 +++++++++++++++++----------------
 tools/perf/util/symbol.c     | 10 +++++-----
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index fbf6d0f73af9..9de6e963ca79 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -261,7 +261,7 @@ static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
 		return -1;
 
 	for (i = 0; i < phdrnum; i++) {
-		if (gelf_getphdr(elf, i, phdr) == NULL)
+		if (gelf_getphdr(elf, (int)i, phdr) == NULL)
 			return -1;
 
 		if (phdr->p_type != PT_LOAD)
@@ -550,7 +550,7 @@ static void get_rela_dyn_info(Elf *elf, GElf_Ehdr *ehdr, struct rela_dyn_info *d
 	if (!scn || !rela_dyn_shdr.sh_link || !rela_dyn_shdr.sh_entsize)
 		return;
 
-	di->nr_entries = rela_dyn_shdr.sh_size / rela_dyn_shdr.sh_entsize;
+	di->nr_entries = (u32)(rela_dyn_shdr.sh_size / rela_dyn_shdr.sh_entsize);
 	di->rela_dyn_data = elf_getdata(scn, NULL);
 
 	scn = elf_getscn(elf, rela_dyn_shdr.sh_link);
@@ -789,7 +789,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	if (symstrs->d_size == 0)
 		goto out_elf_end;
 
-	ri.nr_entries = shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize;
+	ri.nr_entries = (u32)(shdr_rel_plt.sh_size / shdr_rel_plt.sh_entsize);
 
 	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
@@ -925,7 +925,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 				size_t sz = min(size, descsz);
 				memcpy(bf, ptr, sz);
 				memset(bf + sz, 0, size - sz);
-				err = sz;
+				err = (int)sz;
 				break;
 			}
 		}
@@ -1066,14 +1066,14 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 			} else if (read(fd, bf, descsz) != (ssize_t)descsz)
 				break;
 		} else {
-			int n = namesz + descsz;
+			size_t n = namesz + descsz;
 
-			if (n > (int)sizeof(bf)) {
+			if (n > sizeof(bf)) {
 				n = sizeof(bf);
 				pr_debug("%s: truncating reading of build id in sysfs file %s: n_namesz=%u, n_descsz=%u.\n",
 					 __func__, filename, nhdr.n_namesz, nhdr.n_descsz);
 			}
-			if (read(fd, bf, n) != n)
+			if (read(fd, bf, n) != (ssize_t)n)
 				break;
 		}
 	}
@@ -1426,7 +1426,7 @@ static u64 max_text_section(Elf *elf, GElf_Ehdr *ehdr)
 		if (!gelf_getshdr(sec, &shdr))
 			break;
 
-		if (!is_exe_text(shdr.sh_flags))
+		if (!is_exe_text((int)shdr.sh_flags))
 			continue;
 
 		/* .init and .exit sections are not placed with .text */
@@ -1546,7 +1546,7 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	 * perf does not record module section addresses except for .text, but
 	 * some sections can use the same mapping as .text.
 	 */
-	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
+	if (kmodule && adjust_kernel_syms && is_exe_text((int)shdr->sh_flags) &&
 	    shdr->sh_offset <= max_text_sh_offset) {
 		dso__put(*curr_dsop);
 		*curr_dsop = dso__get(dso);
@@ -1672,7 +1672,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (secstrs_sym == NULL)
 		goto out_elf_end;
 
-	nr_syms = shdr.sh_size / shdr.sh_entsize;
+	nr_syms = (uint32_t)(shdr.sh_size / shdr.sh_entsize);
 
 	memset(&sym, 0, sizeof(sym));
 
@@ -1734,7 +1734,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		}
 
 		if (runtime_ss->opdsec && sym.st_shndx == runtime_ss->opdidx) {
-			u32 offset = sym.st_value - syms_ss->opdshdr.sh_addr;
+			u32 offset = (u32)(sym.st_value - syms_ss->opdshdr.sh_addr);
 			u64 *opd = opddata->d_buf + offset;
 			sym.st_value = DSO__SWAP(dso, u64, *opd);
 			sym.st_shndx = elf_addr_to_index(runtime_ss->elf,
@@ -1946,7 +1946,7 @@ static int elf_read_maps(Elf *elf, bool exe, mapfn_t mapfn, void *data)
 		return -1;
 
 	for (i = 0; i < phdrnum; i++) {
-		if (gelf_getphdr(elf, i, &phdr) == NULL)
+		if (gelf_getphdr(elf, (int)i, &phdr) == NULL)
 			return -1;
 		if (phdr.p_type != PT_LOAD)
 			continue;
@@ -2767,14 +2767,15 @@ static void sdt_adjust_loc(struct sdt_note *tmp, GElf_Addr base_off)
 	if (!base_off)
 		return;
 
-	if (tmp->bit32)
+	if (tmp->bit32) {
 		tmp->addr.a32[SDT_NOTE_IDX_LOC] =
-			tmp->addr.a32[SDT_NOTE_IDX_LOC] + base_off -
-			tmp->addr.a32[SDT_NOTE_IDX_BASE];
-	else
+			(Elf32_Addr)(tmp->addr.a32[SDT_NOTE_IDX_LOC] + base_off -
+				     tmp->addr.a32[SDT_NOTE_IDX_BASE]);
+	} else {
 		tmp->addr.a64[SDT_NOTE_IDX_LOC] =
 			tmp->addr.a64[SDT_NOTE_IDX_LOC] + base_off -
 			tmp->addr.a64[SDT_NOTE_IDX_BASE];
+	}
 }
 
 static void sdt_adjust_refctr(struct sdt_note *tmp, GElf_Addr base_addr,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 11540219481b..7eceb6679ed5 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -111,7 +111,7 @@ static int prefix_underscores_count(const char *str)
 	while (*tail == '_')
 		tail++;
 
-	return tail - str;
+	return (int)(tail - str);
 }
 
 const char * __weak arch__normalize_symbol_name(const char *name)
@@ -481,10 +481,10 @@ int symbol__match_symbol_name(const char *name, const char *str,
 
 	if (includes == SYMBOL_TAG_INCLUDE__DEFAULT_ONLY &&
 	    (versioning = strstr(name, "@@"))) {
-		int len = strlen(str);
+		int len = (int)strlen(str);
 
 		if (len < versioning - name)
-			len = versioning - name;
+			len = (int)(versioning - name);
 
 		return arch__compare_symbol_names_n(name, str, len);
 	} else
@@ -638,7 +638,7 @@ void dso__sort_by_name(struct dso *dso)
  * While we find nice hex chars, build a long_val.
  * Return number of chars processed.
  */
-static int hex2u64(const char *ptr, u64 *long_val)
+static size_t hex2u64(const char *ptr, u64 *long_val)
 {
 	char *p;
 
@@ -1532,7 +1532,7 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	while (!feof(file)) {
 		u64 start, size;
 		struct symbol *sym;
-		int line_len, len;
+		size_t line_len, len;
 
 		line_len = getline(&line, &n, file);
 		if (line_len < 0)
-- 
2.49.0.504.g3bcea36a83-goog


