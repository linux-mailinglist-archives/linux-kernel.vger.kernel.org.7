Return-Path: <linux-kernel+bounces-724529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EEEAFF403
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FD71C4454F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB0524467A;
	Wed,  9 Jul 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FScjL0Rs"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E7241664
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097239; cv=none; b=DoIff9f16SYhsWkt+qefyDoJ4TYKms7mjyxBSkfq1m0fKHGXhzLe1K6lKL9jdji42fvfd+47vW1XhKo4squTR6kyECq1mSYS3m/48rKS5EfhTJDjiuGsjqi8uPTfb0/WXm/pDDWDPzpTHSw+Y8hd4IjeyJdHoYR5jf1dX1RnSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097239; c=relaxed/simple;
	bh=1lk85E3pggo+4g2GknSYWSWNs6o0Mw8jBXtuFvYNkFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=L56Y3uv+a/cXcIXAOG9CYo1hum+5RSch0B56GD27TizTRg9OxLejDyMfjFFXgjCv60yGl4pgxWrAsQXP4+6n33wHQE1YOd4ntg8x2NTqm8CuWB0T9Jz45xTDJiTyY3dDt9F0Th0YsjEwsdgq8dwCqmYDgUG869/i6yGTjlKOfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FScjL0Rs; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748efefedb5so258867b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752097235; x=1752702035; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=FScjL0RsBI9fOqixWgw+s3e0+ZVU6uRoglAfNGTOq4KMPjaGwfvlvsO3bneN9Sg+Rs
         j6q+LX5Ds0EbGDcGfdcZqXXwQQo4/0Q+rBJqjt3hLjnFzpbWs0iE0E/6oCSqSQF/zAjm
         6tl976wwpI83zeobotT8tN+5t91xiVigcPGyAt2wRxXHeJt04PhRaN5nKhFx+nOGh5MA
         BYXDpDFt4cB1A9JTOCB2k3cGM6+9jmJmY/I3yyOIyJnpK59wsEAjnSW2CLGMf2TNtTga
         +j0cEU7uyN34aMcuf4ErsRIv8ywSMD+FeTYrioFJaMHeTmyOjbhAFlhdHTWzOlF2QdI0
         A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097235; x=1752702035;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RNkMgAEj4/GnB7BeI8C0UUIpPaOTXLCNgb+45zsMxs=;
        b=rz4PcfAJiBO3PhPWyXVPTffVCHlcVukE/+FK/cHymt/uG6z4K8N6vVrrss3ZB5E18o
         kwDUhebzj2CkUJNag4yoW0lqpELkZtdxYs5kXSqaUrW6DLWost7nKN0bXia4T56R0xqa
         x70/lNcYvqHSPEUsVjX/3D6ZY8ETzLkkHudGbCekZeXfA853/JaVMmzJb7t3U2yVYzTu
         kPM/ckxKTpSj/DWmyiieNuLXRhUlEQVC9Ukhiny8Y1LSwJ/vipsR9o31Bd217MtUBNrk
         +kx1iPSZeUhsvPu2r4KhHjX4yZGFr10HNpXiQsME/lyZWCu7NUcLGMrmaZ3ZSaIhlx9l
         XvHg==
X-Forwarded-Encrypted: i=1; AJvYcCVBP3+N4uaU0qWevXXi6wiwlMuwbRPRluY4k6Og4uXxK/1YxtSahkmzLkXY7N7LPc4CRIxe3p0SoEPgoGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+ekJNpnkVYRzzy+lzjhKRf9vfA+GToodFh2s5iEuy7LimFY2
	nRnznA6faAcouhkKW46XV+14MqzMk10lOCw14PYkLA4hmcPWsT060mPfGveQlPGYmtY+Do8Fv3X
	bPlhXtJQWOA==
X-Google-Smtp-Source: AGHT+IH2bEm5D5vL0/SOlKgLMUnkYuyDxrvhEh8Sk1TmdRPm6c9OAhUY7JUi0TVyz5YNrku0Gkgejj3nrlBH
X-Received: from pgr1.prod.google.com ([2002:a63:1141:0:b0:b2f:a31c:f7bc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e91:b0:215:efed:acfc
 with SMTP id adf61e73a8af0-22cd5a06069mr6978021637.7.1752097235636; Wed, 09
 Jul 2025 14:40:35 -0700 (PDT)
Date: Wed,  9 Jul 2025 14:40:18 -0700
In-Reply-To: <20250709214029.1769089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709214029.1769089-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709214029.1769089-2-irogers@google.com>
Subject: [PATCH v1 01/12] perf hwmon_pmu: Avoid shortening hwmon PMU name
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


