Return-Path: <linux-kernel+bounces-627580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E06ABAA52F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375A01C0705C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461C274671;
	Wed, 30 Apr 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZK3kGL2"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139D270ED5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035462; cv=none; b=rMroJtdc5X60ho0HgDnIKa2Q+rgFuLfzSRgUL47OY2aSUz2EYyPN8wI9cb00BEjZJYQdHa7MebwaZFwz2AkhtyYwHisnqYG3NYt0f2aDmTtZAous1S+YH6IMdJVRFjqF/CbhNCPbp1dScC9gd+LBtP278mSByjQL5k4RS1xaYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035462; c=relaxed/simple;
	bh=b6GEsVu9thS8iXXc8KAUQ//meHD4/cmlQIYLDMRfwN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xk76+EHegL7A51RYTd5mwyBnDa+mHNj6MSasMovs0PNyrkj1nYaiSQ4UL3F689duiUZT/sFM3rZn6YJo1Aar9GxHP3KLrefKg14XI+rPd5LaS6ArfWm5ZdY8DK8qpxJVyZc2eJdSuydHScCXsJZ87qguezPbLULE+34fcu1vPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZK3kGL2; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso209604a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035460; x=1746640260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS2b2cmlDbxRN0eNnvdNyztXD0xddYMhm98CtrBwR0w=;
        b=YZK3kGL2XcQmkqOxn3/easy2wI/fqaaEPMSHw/Hapb3r711qLmabfJRzMdSH01sTOv
         AyF8Pqp/pnaEBPYTHrEtjkOzxj72UvPouWIaubd0YJIaCWYfq0m6HRJhslwnfYYlC4F8
         pgMYhUlIGHi2b7j9FL5Xk1x2zjBLJDHFbHdr3GG5z3wyPHTbDYk5Nu6TcIjAlTeHxXhv
         gS6IXAJkWuRLGgO6hYEyXx7unk2W4NRY8+By7g1Se43qLIEl1PXMA2QSJQY/unGpLIM4
         yGIonsacQg7gaVf1+NvsfZy+fOZaGTj3yLYLmcxajbDkFAvUDW8m8lOmtRu4QLl0HexJ
         8g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035460; x=1746640260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS2b2cmlDbxRN0eNnvdNyztXD0xddYMhm98CtrBwR0w=;
        b=VmRonpBb6lVEEUSHZSQ6y15oh3WzuoTUgSIZY9U65EsnA5ajgx0z7hD6D0JYPCHW/Z
         M2WrNJZuXRxaz/5CpLD6PTykx1+xhsX3jSp/70J62NAUNCKxutkqa0mna+/sQHMdmSEL
         K+9mBxAbgwWxH45ZqVuoarQtIB9ZXYAp5q6hMSnMuvkK/zybsCgFW2v08WbF3ALF7Kq/
         uLnu+ym1VOmGcOP14JPmFt3bQTrX0E1i5drSbiu0YUWYHmBrYnbGfYH1FJAcNGnhXKA3
         pOTtMwFUlehr2Aq8aV7xiqFVW3abiTppTWXAvK1IKD13Z0tsx2QryAodXRgQ/EZSinz9
         Hl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuvFOQQw3ltTko2B2/RqSs1ShlZBbFmuBdXuOvHEl5P/ZXISwZbboT76bmXcEf46cVbvz+uecoZfj6Vfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ7k2IYQn1Gv7jXettR4Q/uZ1uhCauHMxaI/+4lwDr6YdQxidw
	mL732yIAbDTjSlam8JwzywwAfc7EsOc7IT9E7L0IoKJr+JtG5iBajGPVlf9n8kB90MMuYKYPv3w
	wlyDHiw==
X-Google-Smtp-Source: AGHT+IG+GdkoGN4xBxp4qlm4lG1pOdHUqwoA4DsTSPMhQg5ePkqBXcq3O8r8NR9aJaDVMVUVrzPROEAezvNG
X-Received: from pjbsk9.prod.google.com ([2002:a17:90b:2dc9:b0:2fc:2e92:6cf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d606:b0:2ff:53ad:a0ec
 with SMTP id 98e67ed59e1d1-30a333073f6mr5735112a91.21.1746035460084; Wed, 30
 Apr 2025 10:51:00 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:49 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-2-irogers@google.com>
Subject: [PATCH v2 01/47] perf build: Avoid building libbpf/bpftool with LIBBPF_DYNAMIC
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
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
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Building with LIBBPF_DYNAMIC still requires building libbpf as part of
bpftool, but the build also still accidentally builds it. Make the
parts of the build bringing in libbpf conditional. Don't build bpftool
is a bpftool exists from the which command.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 5438d1111f3b..296c00e224a0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -960,10 +960,12 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(RM) -r -- $(LIBAPI_OUTPUT)
 
+ifndef LIBBPF_DYNAMIC
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
 		EXTRA_CFLAGS="-fPIC" $@ install_headers
+endif
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
@@ -1183,7 +1185,11 @@ $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_
 	$(Q)$(MKDIR) -p $@
 
 ifeq ($(CONFIG_PERF_BPF_SKEL),y)
+BPFTOOL := $(shell which bpftool)
+ifeq ($(BPFTOOL),)
 BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
+BUILD_BPFTOOL := y
+endif
 # Get Clang's default includes on this system, as opposed to those seen by
 # '--target=bpf'. This fixes "missing" files on some architectures/distros,
 # such as asm/byteorder.h, asm/socket.h, asm/sockios.h, sys/cdefs.h etc.
@@ -1202,16 +1208,21 @@ endif
 
 CLANG_OPTIONS = -Wall
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
-BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
+BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. $(CLANG_SYS_INCLUDES)
+ifneq ($(LIBBPF_INCLUDE),)
+  BPF_INCLUDE += -I$(LIBBPF_INCLUDE)
+endif
 TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
 
 ifneq ($(WERROR),0)
   CLANG_OPTIONS += -Werror
 endif
 
+ifneq ($(BUILD_BPFTOOL),)
 $(BPFTOOL): | $(SKEL_TMP_OUT)
 	$(Q)CFLAGS= $(MAKE) -C ../bpf/bpftool \
 		OUTPUT=$(SKEL_TMP_OUT)/ bootstrap
+endif
 
 # Paths to search for a kernel to generate vmlinux.h from.
 VMLINUX_BTF_ELF_PATHS ?= $(if $(O),$(O)/vmlinux)			\
-- 
2.49.0.906.g1f30a19c02-goog


