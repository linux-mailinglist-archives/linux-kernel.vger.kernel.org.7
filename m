Return-Path: <linux-kernel+bounces-666466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A65AC7734
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35169E4A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D825485F;
	Thu, 29 May 2025 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAmwy0ER"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1F253922
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493612; cv=none; b=GWrt4nta2ULwZ4rdUQcByBjbuH68Nf5o6Qja0QGLN+ilwtQe/SfqpQYAt7vSz3oVuWYnXafHh5oQ6Dq9k8qL3YsVU9hbVqyIkTBFwTq/IOQ8d+juXb6FmmcxH+uV8gUB4Nb1gZ1ry0g6HdwiD7F58SjNJSlhDedc8eeJ5xEf1uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493612; c=relaxed/simple;
	bh=CANFhZkJgyGsnrInmGKjXkCZcjZ3YXzkDfH+xL7C5tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=r5g+IlAcgbOVSW823fmf+MLe7UYD93DT5O223ksNT51JommDkYuoGj9+xUq+YtWq6x7guF3o8XzXu8rSXhQXFjdoidEwBnSAUYYlCowCoXLenmjQxIJYZX5ThdTE0ad5D/gAnl5zjgGSQkwcDVxUakXgYHPuI69qfPj/18r4sMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAmwy0ER; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310a0668968so484035a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493610; x=1749098410; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0+6lU8x18MkCnRglmEGZnHeaHUfbjOQhfXfqkjM75Q=;
        b=yAmwy0ERJlTDnIK6W7sZ/Ho8PhIICBg9hOHE7ti9zzdopdbbcY+hisQBd3QCrmUz0K
         xvNltDZoiUDCJrSxNouGuA3u4yhzkLprmbqQKVlwaEtmxEz3QYl6SrIT8BE3JthEhdcR
         NS7lzuzRgXbv1vLvr9Cv0DvWKe3uHIJGJyl8wdZFunW4Xko/v+tpligiBY5SnYHgZ7a2
         FuWqwUzZhaxaQHMhFu/INApPUUv40bHul1qcHoCsJ/Rp8zLoJWp2mjEKLPF8GXKH6a9z
         6emzBp+2xmtsXbF0wY3yVBfF6y7jGNvHzdMdRIrqUcMz0rUBtubTDWFkchQq8Bwy3esP
         D/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493610; x=1749098410;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0+6lU8x18MkCnRglmEGZnHeaHUfbjOQhfXfqkjM75Q=;
        b=Y5unRNh3Jgxre6a3XXUs/2Q2qZ92lb0ZiVSxDCJ2yQqg2G5hlrbP7UGcVJQYQ0QdpC
         8ryJ3it50+Ln8pKT/31iCa71WBvVjgpgfVG4NUE4p7VtO/IJAfAyrXIUqCgddrU0DzNU
         yRxwtJn90DTkEab2Sj7WdxEeyid5SJJwJKbvHkEkykrfwa3BOtew7Zjta0fqp6fsslzn
         VKYvy7sm0KjNl3ZpUg3VD9z1dqn2dGuhg1ukmPXVQNNSTnoTwBjlwqrgPdr2/RPTu/tO
         VKd4Zci+UzYlJPB56Npu3xQ7NZB8EH7wm6p9Htwcqh/JxEFG+KoAvwBvNoFvyCUHXXtZ
         jYhg==
X-Forwarded-Encrypted: i=1; AJvYcCW93DwzvPuKVr4Fb6MmA02BLr8607rc9G7z6VMCIZE35q02IiaCYVvfTQ/n0OLYG3p4TMBIaRl1rwP9M8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBeJXgHmkCDBZuGznx4/RnrX+XunaMZA7iDCnrWnVmLvoIdXt
	OvXf4ydv9MfUV5pDTsnJvuVjd9IhWIHTsKuXYx+79DcXKCNWekh2Ox0l3vCnjw4tKBlmEQOiFrt
	V4B9TZorSgQ==
X-Google-Smtp-Source: AGHT+IE9ubP4EXyB04CdzN29eN45hiHLXKn9ZXif4h1X/irDCdN/4AOj6erkhGRhVueGltT8T+vgXt9OVBa/
X-Received: from pjuj14.prod.google.com ([2002:a17:90a:d00e:b0:311:4201:4021])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:50:b0:311:e8cc:425d
 with SMTP id 98e67ed59e1d1-3121dc54006mr1264393a91.10.1748493609979; Wed, 28
 May 2025 21:40:09 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:38 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-3-irogers@google.com>
Subject: [PATCH v4 02/24] perf build-id: Reduce size of "size" variable
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

Later clean up of the dso_id to include a build_id will suffer from
alignment and size issues. The size can only hold up to a value of
BUILD_ID_SIZE (20) and the mmap2 event uses a byte for the value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.h         | 2 +-
 tools/perf/util/synthetic-events.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index a212497bfdb0..e3e0a446ff0c 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -13,7 +13,7 @@
 
 struct build_id {
 	u8	data[BUILD_ID_SIZE];
-	size_t	size;
+	u8	size;
 };
 
 struct dso;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..68bb7c5fe1b1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2248,7 +2248,9 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 
 	memset(&ev, 0, len);
 
-	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
+	ev.build_id.size = bid->size;
+	if (ev.build_id.size > sizeof(ev.build_id.build_id))
+		ev.build_id.size = sizeof(ev.build_id.build_id);
 	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
@@ -2308,7 +2310,9 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	ev.mmap2.len = len;
 	ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = min(bid->size, sizeof(ev.mmap2.build_id));
+	ev.mmap2.build_id_size = bid->size;
+	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
+		ev.build_id.size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
-- 
2.49.0.1204.g71687c7c1d-goog


