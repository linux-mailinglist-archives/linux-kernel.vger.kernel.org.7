Return-Path: <linux-kernel+bounces-726657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E5B00FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85457B612C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA1295DAA;
	Thu, 10 Jul 2025 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A16fptkP"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD9B2F0E42
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191507; cv=none; b=STDYj5s51GbCqKz4Y8KOq5p1n+gjURMy7piCF2YzFlNFq+mvuKeB4NNJtdGijiHziHAUtBNT5MduTMNgS1qBPmhSmJ2R9SkRzoo2APG3viZLCt96i85Rytd6kN6+QJ51IMmXjFEYvLo4tglzsi5/YW4B5saM+Ckuzt/aPPWM6Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191507; c=relaxed/simple;
	bh=1lk85E3pggo+4g2GknSYWSWNs6o0Mw8jBXtuFvYNkFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=in/WAmQbDAgBFjoDtb9EnXcfYKIZrc4rd+/AYhjXlt+P5kvCi1YOhegGLzrHGigtAVTeJ8/piMRHZua4vFB7uBlu0Y2p3+MjtWfdggg+Ipw72woww5KU4YX7DKejFHm7QcvSX7FlCla9nvpHtSGFjBRllWLXVQaJauIwgA75tG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A16fptkP; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74b537e8d05so1340240b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191505; x=1752796305; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=A16fptkPUgMygWL5n7EteLN9T4o9of8nwLL2MQo/A3AEpbJOp3ZeioPHB9/xIIOXqu
         S5Un/v7xQk+bHi3k4yzpEbB27I3CBIGAF+hJkNzOLC+/qt+zpXBx4oQSiGFAc5yDzj45
         oYha+KdWFW5lFNunyEWp1zcHC8d4fBLuVPYFAjmUW1mbanY4NFuNIK5Ft3x/PmD1xAYd
         R0vbBRC0zPkxvqYijirXUY5sv8c9C/Xj4ORIxH6ZLa5wRVeuMW+IsfugogN5sB67651+
         /oreDCWkTWhuQ9Zlgo5XwN1eEkRw626eJLhl51okoa8cEAXuFcHZwbdENkXe2bbyXQ7l
         1xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191505; x=1752796305;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=LgWdtUsZ4HG/9B9+L3/VnTuBxzeG3hzLdO1G1Y+WnKvplcrD8kcq4cbY8eD1/kNvKJ
         Ue4sVM8EhG5EHk7qGJux4F6gG8a7nNrz/xkHkYAVrOLxQOK9pYPqTanCCIseHzKKrd6T
         xs36C2N9Phl9R8GhUkFWa0SHo/CKTZlcnDvtFt1EmA+ZJ3u1X62T+fcHjWYPj/qaBPRw
         IRk8cTU169jHvuW1i6hFeaJIOH80+p/uCKBd6uzVtCVRKl28ov0uvFheOm2w39GZKru1
         SlC5Opxeq8gh9PMc+j1RzoteC/uTyRnWnkZeyHcLtL9OC7tNqNIQnEw4V6Z4ZBTuDTO+
         OXSw==
X-Forwarded-Encrypted: i=1; AJvYcCUvzr2IpBYiPgMBUq59GpMhQrxB0WChuJluqUqcH1MFEKU9mNdcD+1O1ygoP+Yd381ehtirjJeK3LJYqXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVaP7XkEdfKggt7AcMBdHasRvtgKk03xk3Bru2hGI64fRnKC1
	TAALo5cxc8AK9SUFZKzueZVp89nxxQ8b5mhO2tu4NK/ZvsjQhklaKM+WWCRwu5kIMcrw6BwKrMA
	84wI82c/Bsg==
X-Google-Smtp-Source: AGHT+IHhdLwz+3hSGBHFsdbHDLyXIj63VirYBMWizArAnpS5ZmCGhuVXeLyvLkf5528juWTzIYXLANFzoFZC
X-Received: from pgct4.prod.google.com ([2002:a05:6a02:5284:b0:b2f:a31c:f7bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c709:b0:215:efed:acfc
 with SMTP id adf61e73a8af0-2311dd59489mr2325349637.7.1752191505056; Thu, 10
 Jul 2025 16:51:45 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:14 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-2-irogers@google.com>
Subject: [PATCH v2 01/13] perf hwmon_pmu: Avoid shortening hwmon PMU name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Long names like ucsi_source_psy_USBC000:001 when prefixed with hwmon_
exceed the buffer size and the last digit is lost. This causes
confusion with similar names like ucsi_source_psy_USBC000:002. Extend
the buffer size to avoid this.

Fixes: 53cc0b351ec9 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index 7edda010ba27..416dfea9ffff 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -345,7 +345,7 @@ static int hwmon_pmu__read_events(struct hwmon_pmu *pmu)
 struct perf_pmu *hwmon_pmu__new(struct list_head *pmus, const char *hwmon_dir,
 				const char *sysfs_name, const char *name)
 {
-	char buf[32];
+	char buf[64];
 	struct hwmon_pmu *hwm;
 	__u32 type = PERF_PMU_TYPE_HWMON_START + strtoul(sysfs_name + 5, NULL, 10);
 
-- 
2.50.0.727.gbf7dc18ff4-goog


