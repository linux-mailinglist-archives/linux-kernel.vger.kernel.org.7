Return-Path: <linux-kernel+bounces-627584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C85AA52FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF619E3D62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A2266EEA;
	Wed, 30 Apr 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpWZ1ADK"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D97278E53
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035470; cv=none; b=eyYS1Jk5HbPL3wJJEYgvGB4OdmoBWa6omCS1jDv9dU9YxdfUMXVckuq91hkGIVtG/V0L3Ben777KBRxqX/TKheB/L6vM0W8WxvA1m1lPERoXoYkI4KkuhzIIiNDL9KIPGYlLyyucRqP/GmoGyqpppgwYmoZo5AUCrT7tQj0Lm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035470; c=relaxed/simple;
	bh=7tLf8ZlpDGA58/SmNmZNJE4X51OXHkvdbXoRMSCnQ20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATis4UnBm2Q3LtJWKhLUgG8heZGnY+onD6f6YcwMbbOPG1Hwqpvep23rLCwlJ1FdGWmYctaMj3C/QPH5AknKnaSvgykk4YstbIYXaSn5LN09iNViXn2BlcrI5rX7vPt1cpaov7j0JXjQnfJVxwOOrsKNFyzkab+QrpzTLC7OKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpWZ1ADK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3087a703066so151705a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035468; x=1746640268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3P3h5pAB5HUVcxM6Pr4S0kZF2+GkLiV5d80YFIKGnY=;
        b=KpWZ1ADKSCxgNkbaK8HkZcn7YsWQnt4SqwmJfignWWSWcX/TPRIYGUmEuDabpkcws4
         F3EyGk2u/iV9dyDnE3SceiBUU74zs2jt4WnGKFvb7JQ5ZwbshOfTnbXz8dkMHctnB8t9
         iWNWNnhsXa3X/QiDhz4C4u3spdEXxNH3IraRC3XU42P782LPLp2q0QP7jVPirUqNy1vf
         sYmYp+oMU8cfeWXxdX4LeYAojNjXyf5qVbnSOYAiyES+H8+dVfZoxiEJsIF1EaHskDsG
         767QirhmjWOmbV87k6iQ8EAVzWDCFJsRiBilXTj8qvsZ6vf80Ul8runlK+Z7qM9drZ+S
         xccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035468; x=1746640268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3P3h5pAB5HUVcxM6Pr4S0kZF2+GkLiV5d80YFIKGnY=;
        b=ROUg4EKtz0jdf+Hxl+4VmN0Fxg/bDNLSuipC3j6fjAtsbcljJ4C/fCNLwBhImhXD9+
         E6ACZjuExEXX6YLjOSh+ntQbqlqjrSjtZGRT0thnzyx3n33CNoF16nuqS9nq7u45Bg+W
         mESM6uhwTHqvgs8MqWy/gG12hcwB9edru/66aa1fUnOf4P2uJUIcoYZXJqogctzxBgtc
         D0HSeghpKRnt9/LF48qYIHO+qN//ZDTCQwuf+I6Hql7weUTAUegQbeRKRgxCiljvl9wp
         1DggJ4Af5AwRJWj+7417/oNqLbwzOgcdv48rbYHe/6b2bqkXpF6Sjh/+lIBBRknDBDp3
         pGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+weZO87DYuVslVZc9zScT4eBcm/Qy4dveUxYhzjZVaY1JWUbYALCdSNtWOOXv+0H1pHD4hYEc2hR5YQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMiqRfjeq0pUJrxgk69YEbksxR2XsHKz36HTwgBs48CHmn4Pg
	yNK1GrTeJQJ2VQuK+p3JSM/2tmdOrhqHq4xL4I5tgUL0rVckT4fkXRclk9+Bcjnd8JMI+ktJxV4
	tNGOCvg==
X-Google-Smtp-Source: AGHT+IEo4BpVSTP736KrWVvKElXNGdJEvRja+RffiZep9xfmBDE9bpWvo/gjF9Sok1i5GqMVUn1zEL5vbAu7
X-Received: from pjbee6.prod.google.com ([2002:a17:90a:fc46:b0:2ff:852c:ceb8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c888:b0:301:1d9f:4ba2
 with SMTP id 98e67ed59e1d1-30a34450bdcmr5395853a91.28.1746035468058; Wed, 30
 Apr 2025 10:51:08 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:53 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-6-irogers@google.com>
Subject: [PATCH v2 05/47] arm64: cputype: Silence -Wshorten-64-to-32 warnings
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
2.49.0.906.g1f30a19c02-goog


