Return-Path: <linux-kernel+bounces-584015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1FA7824A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF1C1652F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670421B9C1;
	Tue,  1 Apr 2025 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6eEkNwL"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC9229B18
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531975; cv=none; b=r6Ak8NfiWOTb7+G1RuroBUo1FANibr861XktgKMuCanwDG2C3FlxHR+FY5WxWa6H/dPcK/pKsDGQ/ThCF6lYEg3UQ4oELbExoXkpsoT/1mTOK+uzhie1mKC11Noq4wiLSTk2dppRGv8cf9+YB8ZQc3vAlIFZtu3wHNuG2/0vBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531975; c=relaxed/simple;
	bh=bRqcJNqdHpJ92JW9Ryv+Tum+BcxSVSmO0diBUAO4Zbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lwK7rUfw7xJPYCSC5x5vFegIy1TiNyl2HRL0kgeiKDnFdT1rH/nNm2waMKLaxRTwpsVAtPbG3ZEIkQEWlUtIDJghSOnc/aVY20uQcVqSIn2LRcnqj2m53yawsZxLcNVgIN88Z0RxsiNauOzwWmtBgXDyDGjv4mZnx//HdXbTWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6eEkNwL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3055f2e1486so4313833a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531972; x=1744136772; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSwN5ZhtSE4cdH17wQnS7beYUnk/E6AzAjOBdetWRXw=;
        b=L6eEkNwL7NmxnkYDv9cpBI+gDoZ3+L6GXmnOew3TaXcJB8VPfUfteQrSZR+SSKjuqT
         SREW1fhvW+CN8FWJq66WCBzgP1orfnhL+8AqC3Bi+a/gBCqZTVZvxcbV/2++mCR+CpXe
         n9y2aL7GCXAs2LzgR6bBXw8hmYObWI+2xHCSQxLdjl4emjRUgVKYCZxwXMxHLvdqnNG5
         nbT0ks3pw39LmKFY6b34zBGTG4x84OuzuZZZPzbDNOSMUJUGB9XUsxGm5nE1JYJXgSfX
         pB51iZj4wRbkkC0HwPrKbfXGp/h2YOk09OW65o5miNoce+7U+oJUUsten2PJVbhkyLiM
         k4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531972; x=1744136772;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSwN5ZhtSE4cdH17wQnS7beYUnk/E6AzAjOBdetWRXw=;
        b=uUwV9j+Z66l/pPYzHxEOEquKpt/PCytMhvoq/UwAfqLXHiidWs/7zqKBreXvuk/A4g
         vtmLs8vWyrmzo40HgRnoC6cEHBjTZZ5lNNnf4pwzqqA4+G8BucN8K+xsCuQEz6OOYD3A
         onRlxxpepIGeORq1dh9nQSy+l9EN6TnCJTjzEFMbPtyHnegL70/q7ofEwz1ImsSBfOR7
         YZVkhPk/7rf7Ab7njJwUEBrIwz0nGRX0Zr9DFWHNmiED+29tVRBClKZIlzXwSFEBXc7N
         k8wI3maEZDr4Vh2Jy1K9DxfTg3HkiHLBL+gXZ4bI1Na3Kh7D78sRxOW0JiAset4Ue3zK
         cEsg==
X-Forwarded-Encrypted: i=1; AJvYcCVyYRob846UyPl25nOasIJTU6PMonAmS5U1Uyw6Os7OhD+heekREYeFi8Z1CkuoxjdHEEHF8+mJzPDSsEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGi+B3pRxEOnEK3DyxMIBNE5Ih0PgDqgSag9q+UIZR+vRcDHAZ
	7pqDqm6DisRhYgp5ikBMgnaTqURJMhBoO9XfILZDG74MPl1VrykBqJ4GxFge8/R9trs1l0b25uZ
	NXiL8xg==
X-Google-Smtp-Source: AGHT+IF6T2ulSDFK8OsLYwxcRIOMccUUICCNSn+TOjQB/3bOJGqM6yG07KKXmBXUDSyMBIijHO+1iE5Jy859
X-Received: from pjbsq15.prod.google.com ([2002:a17:90b:530f:b0:2ff:5344:b54])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc2:b0:2f9:cf97:56a6
 with SMTP id 98e67ed59e1d1-30531fa18b7mr25114861a91.14.1743531971624; Tue, 01
 Apr 2025 11:26:11 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:45 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-48-irogers@google.com>
Subject: [PATCH v1 47/48] perf hashmap: Silence -Wshorten-64-to-32 warnings
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
 tools/perf/util/hashmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index 140ee4055676..f2719f522b84 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -115,7 +115,7 @@ static int hashmap_grow(struct hashmap *map)
 		return -ENOMEM;
 
 	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
-		h = hash_bits(map->hash_fn(cur->key, map->ctx), new_cap_bits);
+		h = hash_bits(map->hash_fn(cur->key, map->ctx), (int)new_cap_bits);
 		hashmap_add_entry(&new_buckets[h], cur);
 	}
 
@@ -164,7 +164,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 	if (old_value)
 		*old_value = 0;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
 	    hashmap_find_entry(map, key, h, NULL, &entry)) {
 		if (old_key)
@@ -188,7 +188,7 @@ int hashmap_insert(struct hashmap *map, long key, long value,
 		err = hashmap_grow(map);
 		if (err)
 			return err;
-		h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+		h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	}
 
 	entry = malloc(sizeof(struct hashmap_entry));
@@ -208,7 +208,7 @@ bool hashmap_find(const struct hashmap *map, long key, long *value)
 	struct hashmap_entry *entry;
 	size_t h;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (!hashmap_find_entry(map, key, h, NULL, &entry))
 		return false;
 
@@ -223,7 +223,7 @@ bool hashmap_delete(struct hashmap *map, long key,
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
 
-	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
+	h = hash_bits(map->hash_fn(key, map->ctx), (int)map->cap_bits);
 	if (!hashmap_find_entry(map, key, h, &pprev, &entry))
 		return false;
 
-- 
2.49.0.504.g3bcea36a83-goog


