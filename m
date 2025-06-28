Return-Path: <linux-kernel+bounces-707507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362AFAEC4F3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 06:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C2B16C674
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 04:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DB21D3D9;
	Sat, 28 Jun 2025 04:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Yw833qF"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784AF1A239D
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086235; cv=none; b=JR/TNm1/bYcMr2NoVv5wQmDG0Dl14hcGkrbn+zdFs62pR56wakD7gULtBP7u3UCpUrgoaalDM4uxlBA6am8C9WS5u9krX+M+PCHvjn6iCPhSajuMuQWL7ZRpVOcwRYdoA75xVeyXaAZDnIPZqbBigqBCbOpL2XnBxKRs8a2sIx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086235; c=relaxed/simple;
	bh=qdkXYwZwQilwi089YMqVjrMiZV659L43XoqfQaPVoIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=D+xz/EUx/oNv7Ua7iEOSSE8PyZThf4qA8H3EF5Wq5deN1zahL/C5Pa9pkgU9z1lySHl883Hy8VuGXO+f6G/Y7myOAHhdXvXY7C5dbooFKsWx5Z+FKCyyxXWyKq6JT49ZoIOcAxHFmD79wxNMjZ8zA8uzpngxH2Dgm5pRWSBLcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Yw833qF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso2349132a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 21:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086233; x=1751691033; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHMRbh0OGf1VtE1XWliHZ+PxZ7EmgPTkysBcMOF3iMA=;
        b=0Yw833qFrakwic99I7ZWCJNaM9YgZN0VKZ+DKX6iOaXXR24oRi9r++vx7PM+qiJ5wf
         4IGC/OIMPvKg0mvzsv72hdFskelJ5lxCdMC2o0ETCFXUTHH+BGxKwoW7laEh0bq+uO1R
         wGvLcVUSj8Z1RZ1DpZM+ZzA4DMcC+YzAk2UYWWlSrl1EjBFkxT/EJ/8pcW8W4ctgHWxW
         LaWT8eRflOJAg18f929KAuFQlqrjuqu5S6fl/D6oB6MoK939gnoI0CglzlMu4h96yPGR
         HV6oQgklh1G4v34FcdYMTV9W4mYFME4McLjt+uaCm/5E65HxTgnYPQp8z5TdLeTzHcoq
         1hBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086233; x=1751691033;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHMRbh0OGf1VtE1XWliHZ+PxZ7EmgPTkysBcMOF3iMA=;
        b=GiKxvgeplrwNtJWPT/Suc+9jI2hriHyiOWg6zpaAEj2WR0bL724s+vEnGCEUkYE9fx
         BvB4azmk9YTx5yvChCt2bjKBgXux0138J44XdyqNeY34WQJCIVWq5DeCF2NEnR70GfK9
         t/eEovaxSGqMX6xvvlzLqTOxRrun5DwkRqxN9aib2fNxPo7trVghlJcusIfdFkAXBEp/
         Ey9I6EKXa6Rvuzx6KoYQrQB68alERhoF11gUqz452LdtZpHRUyeBuK4EGkjo/9I44EO+
         fXpaCRif9pF4yilY/xp8KnuBD1dk5GSeJ9FUkMEB2PB3b1esk+RQvNBRsDCdYyHznKhJ
         sVqw==
X-Forwarded-Encrypted: i=1; AJvYcCW3O4oBQGWzQEG7Zdbs+VQ111niIh0eW/icrWw9kzufREx78iqoihp4A+/n/T3NOpM3OcDTgnNO0Sawlzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl2h4Bedwlk4XG4FvB1/2AZ+WCYFwMACvdyycpMoFVAKw4GdLk
	ZC1mzS4k1GWsRk0T9XDdHUPJ4nR2al9d13mz34Sic/NEc6AQZNtqtTCjHKPWkLyxrb29IJSorN7
	RxC30/WIjOA==
X-Google-Smtp-Source: AGHT+IHzrdpNZ4XNIDdNjlsvrqmnHu6/tHgF2wIWWYBQAj1mUHX5enrK0cHOp9OGdPIH+ISvTxd9nYV2j4tA
X-Received: from pfbic3.prod.google.com ([2002:a05:6a00:8a03:b0:746:2117:6f55])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:392:b0:1f5:8c05:e8f8
 with SMTP id adf61e73a8af0-220a169ca84mr7170694637.25.1751086232767; Fri, 27
 Jun 2025 21:50:32 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:49:55 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-2-irogers@google.com>
Subject: [PATCH v5 01/23] perf build-id: Reduce size of "size" variable
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
2.50.0.727.gbf7dc18ff4-goog


