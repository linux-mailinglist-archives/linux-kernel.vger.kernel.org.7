Return-Path: <linux-kernel+bounces-782847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E22B325F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CA7B04D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B70224AF7;
	Sat, 23 Aug 2025 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7dYMps4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B1D21B1AA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909188; cv=none; b=JBygjfjlAFjanj4KX5fUx/UD7NmxUvF9bzVjEtje4ixeHI9WFasCigVYVcj0emFbWXf9GTTk/Pbi0COhpKqiZvRHUittbMCjwaCSCMHOu1m54zAAjvLtbIHKQKrmHJ8Jy8p6WmCohzB6No1qaBlxa+6y3QwuZ3CbMVJW6TRqp3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909188; c=relaxed/simple;
	bh=wLFpqbMmcTY/fllGJKa8e5RF+S6JWZUk148fLGz1+x4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xy0RsCegzjI9Z66hVvjjjgJDQ1Rpo5bZXOlCEMaxdxr+shXS/fr59p3ilKlNcVcoTUiJjuAFcLlvD/NKHnerVMzlBy+//mjf/D0F36L0BrnU3esPj+e3fdTJb9VAU860b+UGpQnYRAcxCPqQsX2ekkti73TDZ5TAhb3kB3W0u40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7dYMps4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4704f9dfc0so3253725a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909186; x=1756513986; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZd+KViNkgPk6uGWtqta6gYv6vqzzqK5gvrF3dTKFc0=;
        b=k7dYMps4YgRIHvEOcltYLVx4vGdtB0lla/ouyNECcHu3ItQi6ui53VZWFdznzXC8yE
         CcNIrqElboPubpjbOFgRYh1elsq6ibI4mOt+dhD0wuYsOtN2VitNTc9nsd6UR+xxbq6I
         jAe7pECtYccyoLVNqsCjhi/TAUs9iOyR7aK1jc1OtJLKQ0bayeslSG91nVWe/mIe8Kq5
         3mrvLlDLdGQRd5AVev2zv67f0Xuh8kM/eiek80mcCKCYDnFP1VgHACxdz7VFX7mwTb8t
         QxZG8fPYSEnYtP3qJQXn9Pj6ZgzcI2XNzrWeknUKeC0vVgiQss+WfMKGS6GFyv4JUstz
         KU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909186; x=1756513986;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZd+KViNkgPk6uGWtqta6gYv6vqzzqK5gvrF3dTKFc0=;
        b=lNHAVBF1l6K+iD2doRTepZq/eLXTfksGxAPPSTlJ4Xo9Dpf9WUv4wGb4WOrtcL+KpH
         I/0P51cXlowT4m0Nlwj90ZkSbjJen1vt1/XwoGrzNT4Dh5GVZBWOsTcjsg4JFWiaeFeh
         clcH5tno+JJ0TYW7UAMAo3M36fF/5+/uqLuA3jL76TZXanafCCZKd43H9oFGCeOkc4/q
         8EVpP32MnDlK6ZlPj+ymXhXdLODkCXK62kK9dF6YFQP6euiUy1TuS3eTmdaWvZk0QYj7
         NTv5p2AdRhWgxJiPbtJg+ikG72fXfAbneN1elvATMu/706qr62EEwMMGaH+AkcS/oFuG
         acnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxY3phMvPgANiatOczQnRtSGOdn7CiPqQxyRB48JNT/Pp1kHcwTPEoAxEms/nJVnnwLM4HPC7h4tJFbMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mwVyzo1YXQNGhGXTf38/mT81qPh9kTQheUdUcD7+x8MQeYfi
	5Ru+o6IFqrdEv7OHqHRlnzK0ic0RARd59Xi2hEyc/SiAQttbMFWoI3JXakvdE2/R4kvKEIYiPid
	mEk76lFINHg==
X-Google-Smtp-Source: AGHT+IEo4i1Oh6GMUczyU8oICZtsLUiYPNm/BnhXDlA+3OjsdkTKGwRPj2wnAswxCKoDGQjOWgRa+76VTakc
X-Received: from pjh3.prod.google.com ([2002:a17:90b:3f83:b0:325:23da:629b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a68:b0:233:d3e7:6fd6
 with SMTP id d9443c01a7336-2460248450emr103031885ad.19.1755909185922; Fri, 22
 Aug 2025 17:33:05 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:13 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-18-irogers@google.com>
Subject: [PATCH v5 17/19] perf disasm: Make ins__scnprintf and ins__is_nop static
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of ins__scnprintf and ins__is_nop that aren't used
outside of disasm.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 6 +++---
 tools/perf/util/disasm.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f7bba5e1e15a..a5d06f63a59e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -246,8 +246,8 @@ static int ins__raw_scnprintf(struct ins *ins, char *bf, size_t size,
 	return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
 }
 
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name)
+static int ins__scnprintf(struct ins *ins, char *bf, size_t size,
+			  struct ins_operands *ops, int max_ins_name)
 {
 	if (ins->ops->scnprintf)
 		return ins->ops->scnprintf(ins, bf, size, ops, max_ins_name);
@@ -824,7 +824,7 @@ static struct ins_ops ret_ops = {
 	.scnprintf = ins__raw_scnprintf,
 };
 
-bool ins__is_nop(const struct ins *ins)
+static bool ins__is_nop(const struct ins *ins)
 {
 	return ins->ops == &nop_ops;
 }
diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2cb4e1a6bd30..09c86f540f7f 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -110,13 +110,10 @@ struct arch *arch__find(const char *name);
 bool arch__is(struct arch *arch, const char *name);
 
 struct ins_ops *ins__find(struct arch *arch, const char *name, struct disasm_line *dl);
-int ins__scnprintf(struct ins *ins, char *bf, size_t size,
-		   struct ins_operands *ops, int max_ins_name);
 
 bool ins__is_call(const struct ins *ins);
 bool ins__is_jump(const struct ins *ins);
 bool ins__is_fused(struct arch *arch, const char *ins1, const char *ins2);
-bool ins__is_nop(const struct ins *ins);
 bool ins__is_ret(const struct ins *ins);
 bool ins__is_lock(const struct ins *ins);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


