Return-Path: <linux-kernel+bounces-892268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF0C44BBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8612A4E64ED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57246221D92;
	Mon, 10 Nov 2025 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F5Cieisf"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D11F30AD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762738382; cv=none; b=Dmz6fZo0uJTszRk4s8jHuVuOL0iGIX+Dff9cTbMlgv3pM8qZNxukOs+jQUBDVVF6O09uknIKlU1nS+2ju/7oo7mQ+ZWyJL2pAO7REFcGaSrRi/JkWQ4/G6iuiXhSWRBSFGve5ZhOMZZLGUjAq07poDAGhOaAzEuD9SVid3/z9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762738382; c=relaxed/simple;
	bh=9LV96d37xehqpithsFIs6MVs8BcbI2EjyS0bItBYfSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=AyERdfs/FptBONzTPUJ26UEWg6pwldF33Gytjee6nSq/+37rAu1rtNkRqHku3lOF/lioHpYXQAmdhUcPQnhLUA2HIYCR8kN2dcn8G7H6vk0G3I36o8kPqwc+eRgBQrKxhOC5bM9IY3bNW60kv5A8YjlWy44Onl+FRLpYJf2sl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F5Cieisf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297d50cd8c4so49766635ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762738381; x=1763343181; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4U7M3pwjQ17FcfKzTEAaFDLeG/gMTrXfhERhFZ2tw=;
        b=F5CieisfI/ebIWggeIeZ1erS4g/ZePtiuLu5Vtj/de3wTYcNFeEMqUhucao3nGx5P5
         BAGO8mvs7rU4+pwgEgffuxK6wjsizipW6yBh2+p4XNk5gKAy6ex04H5udRFj2r3diw0i
         qiaq98TXUK3va6cV20V8KNQxEf7RsZ923FOvQRwAsIWuYpFQcrCQ/m/85dDilmyuvqFV
         e5XWOCuXWFHAeU36KuZRMPex0ujn9Q8aT/+GCZoO5gpw9jno23fYL4wPK+MxD1mXlAqi
         0KO6+5eiMIG6zdmWiwHeYPCsDwubT+TPSP5LtMQiWpH4U0hGLtHhLcUgZ8Z4/ZFjT3gf
         gyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762738381; x=1763343181;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ4U7M3pwjQ17FcfKzTEAaFDLeG/gMTrXfhERhFZ2tw=;
        b=ULnqChWrRLg4FiXmwhtq8eHqxBBJfbEpFqAaYeLjHQg/Ezz6r80Ge5761rsRSkOxvo
         1yRSuQj955KGd3rBqKZQTwdrcIVlkUVqFTVxh6rIGRZCdk3OL+PPNcqRZwt0VFExSUD5
         223cVpWYYQUW15xq6HS8csxOw8gU1oCVbLdfRCuaBZSkG1R1ivZ6bvwZQMGit9wlEEJx
         ydnexvpNDkhd6xcJ9EliMPVQeyjC6LRnfntXKoTRUbP9Str+PP7KnQW+jgtnhTsmWeWo
         AHRE93zDwAFBkHIjfm6IlJas7QjIwyItO9JcAsr8FbqhPK3MJHqtsKGrrGWR4e3RzOjb
         jbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrnIUHBoE9E4ZiTFqKQDwrxKfJo8/cxLBHlzN84M7EwNUjp+4mcKE8UvGdihOc3DRm1USi4i02pmeYRGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdcIihuCIEFLNpHS2EKpTwsawaLUCJwivEUY2IoDuY0Tpt8ARM
	VLtoFioDm3fdSg6Zh5tfmPWLD4F97vf4TaGD+6wbOUrv32KD5I0PS53zV9HAeG1tnQH2sZOH7eP
	e1Oy8BoAxtQ==
X-Google-Smtp-Source: AGHT+IGU/Cy8lULW9NbbWjCc8Ka2MNexQ9YPtC1zURZj2oeBjlfwc8cIuYF/gU8+FCBvxVfINfO1iEo9k4XI
X-Received: from pjzj4.prod.google.com ([2002:a17:90a:eb04:b0:334:1843:ee45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:94e:b0:264:70da:7a3b
 with SMTP id d9443c01a7336-297e570dd4bmr82665285ad.49.1762738380513; Sun, 09
 Nov 2025 17:33:00 -0800 (PST)
Date: Sun,  9 Nov 2025 17:31:49 -0800
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110013152.3099080-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251110013152.3099080-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Collin Funk <collin.funk1@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
	Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
	Markus Elfring <Markus.Elfring@web.de>, Colin Ian King <colin.i.king@gmail.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The intel-pt code dependent on __get_cpuid is no longer present so
remove the feature test in the Makefile.config.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5700516aa84a..5decc3d5fef8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1114,16 +1114,8 @@ ifndef NO_CAPSTONE
 endif
 
 ifndef NO_AUXTRACE
-  ifeq ($(SRCARCH),x86)
-    ifeq ($(feature-get_cpuid), 0)
-      $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
-      NO_AUXTRACE := 1
-    endif
-  endif
-  ifndef NO_AUXTRACE
-    $(call detected,CONFIG_AUXTRACE)
-    CFLAGS += -DHAVE_AUXTRACE_SUPPORT
-  endif
+  $(call detected,CONFIG_AUXTRACE)
+  CFLAGS += -DHAVE_AUXTRACE_SUPPORT
 endif
 
 ifdef EXTRA_TESTS
-- 
2.51.2.1041.gc1ab5b90ca-goog


