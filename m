Return-Path: <linux-kernel+bounces-583971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20363A78213
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507493A9A34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A9B214A88;
	Tue,  1 Apr 2025 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMlrtNsR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B821324D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531885; cv=none; b=XCB0SGb3siAgV3X/Aw2i5humIqJbVE6kF1DoC5ttAYiHaCMfVKl5auexAUDi2+VHtgglmoBf2Pi4DOsgnqtpV51BVIsZ8SRQ+oT93d+AE8bTj/765uI/WJqH6NI/U7IuogkvtK52xXukMffNZ0ZRk3yBCc3VTgk4adex2eASkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531885; c=relaxed/simple;
	bh=nXp5NVw8ZWXmsMvB5pE9U5xeZ45CVeKd2OU9K5iWouQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bfEcgqhdJ4Zf2Ubb+ixB7R6l1Nbot+j0Q4RNxsgp2Z0r9hODqiBvKMc2Tb/M4nKy71GVFfQZFhh9fhkY0yCy5Ak1QgKRkmd9tTaSIfDe2fuBKxScI29s2w0x1lMw2Q/Y4Ezq5g3mOOVwbclaXzm0yfPqYnBk5GXfyelTmO5YGAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMlrtNsR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225ab228a37so103521235ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 11:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743531883; x=1744136683; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVxTOI2rMy74E5I1GCMK0hz9Q6EgaUNiUbpk59hX6VA=;
        b=iMlrtNsRhbP1AFW8i2M0ZDfI37nDvLGUEz8dNzq9k4RNH9yM3YjdRDjRXu3TTVTU1F
         OKBBMjSierR8L//55YAdYPDxhaSVDy7CnbUBlT/RVSyFBJI/WdBrbwCZtDO9bXVCVC/O
         F4M1Rp8S0mRqXfzdcf8IKmu80iicnc+Li78M2+QyNp0G3KXslaYmnwBMCn6gMhIgTt5J
         F3b5kHJcfXp7sLChTHiwAHpCoTE1wi5QeaQsXYw9ziUM39DLUadZjuJmTIKTXcVYhHLF
         bLuSb+0SFedOnwZnoDHHZkOr5JeO56+1EJa3wzBNDbXv0MYvSBlMPrm0ykfgWmMRqSWi
         wlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743531883; x=1744136683;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVxTOI2rMy74E5I1GCMK0hz9Q6EgaUNiUbpk59hX6VA=;
        b=DMwZfCtgfi4OgBbkeZMcmYIyFXgSsVwWbGF4NzVBI4La+A+PgdXu1FLYUGanF78w/J
         EbH5hpicxTEa0JvFhT+wYbY6qcI18zZIQ6L+SKm/jgLTOUKghsjAfcb0rPOommywvHzO
         M1NJ4CM3KUeAAxFHOkkKN19xG2J7rlpm+ewKCNGDGF7Q5TyTND74Kkye5BJv8uUz0Myk
         vzUyjthphQUPPi4krrxfEaN06YN9w75FruXXOW8Clv75QmvrU5WpTOYdnDQfNVH9tBU+
         Vz/A+bqF6B6xXxUO9A8RO+An+l8F2UMaSv7yuplQwi+wSphjhcTfO5F9bx9WDmp8QUOj
         10Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXbx4S5t/gvaOXbONWwWaico1DbrZM0S0aUcXaOr3hHMKTgGvfX09TY0XjyjRPzuVSsF4u1G4kqYHq1gJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUIZqZwJ12u60Jurv1eH6PbbOjNWqwBELZ9+a2KGFsIm7Cqff
	OCS5poGE9r7YpD/hQfv/F1RutQylgllbbKQ9VONGVBkAfkKVFXdXXxsoNMqL8GgAiUP3J/1wx6D
	jZWAB8w==
X-Google-Smtp-Source: AGHT+IE/R/FUWdBKFYsppwkRwS7FEQKz3QhCXqgTnVjNJsrzfSerhDPlhvxPM0XuhZf8Dg7Zd48cy0mqhLr/
X-Received: from plck11.prod.google.com ([2002:a17:902:f28b:b0:223:501f:f398])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da2d:b0:220:fe50:5b44
 with SMTP id d9443c01a7336-2292f98769cmr202554215ad.31.1743531882714; Tue, 01
 Apr 2025 11:24:42 -0700 (PDT)
Date: Tue,  1 Apr 2025 11:23:01 -0700
In-Reply-To: <20250401182347.3422199-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250401182347.3422199-4-irogers@google.com>
Subject: [PATCH v1 03/48] arm64: cputype: Silence -Wshorten-64-to-32 warnings
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
 tools/arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 488f8e751349..d7289b9d2758 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -227,7 +227,7 @@
 
 #include <asm/sysreg.h>
 
-#define read_cpuid(reg)			read_sysreg_s(SYS_ ## reg)
+#define read_cpuid(reg)			((u32)read_sysreg_s(SYS_ ## reg))
 
 /*
  * Represent a range of MIDR values for a given CPU model and a
-- 
2.49.0.504.g3bcea36a83-goog


