Return-Path: <linux-kernel+bounces-617510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB3A9A17E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 08:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7347460329
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 06:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88B1E1E06;
	Thu, 24 Apr 2025 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yjaH60Ua"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07621DF24B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475594; cv=none; b=t26gzbcoJfhJuP1LcSktCzClSutMM9h66QR5QY2R5jrWn4DVvkL0X46HB2ATgDT0hTO+l5n4uETSKLRgWrRXkkfSv94VBRLXrxr7yBseByACTQPcwb/yC3lVKFEuEPc3tec53aSM3XeJurSKUw+MA5ot5HGfyeEQTPmX/QLowms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475594; c=relaxed/simple;
	bh=Lb/YeGLXncWYBNdkhGT20s0Yot4+J+u/9UYr8SPdloQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IqgCbetql95JnPGGiZACE4iIExqksgJChSZ6VATl1AG/F9t2Qp2MaFYXhcbnv2cjfQedZjwdTOZKPFgxJcEZip1UWCk10BCQhsLB1N1KR5zrSWVfUf5P2QPd6Mxbr++iQVzO1yj+gE1O+l2OTWMOUMIRlmYdKqs61/jiOPSIK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yjaH60Ua; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b5f9279cso560176b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 23:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475592; x=1746080392; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuK6SffuhbPTlhkbILGQsvEsS+vrJa/bVOZ+xV94WkI=;
        b=yjaH60Ua8zsWJ47Fyox4kPrjZILnyASygLgJbTc0aiqXSoMqgmTcghI88Xg+J9a+wJ
         LdnvF2y7BTTCaXmp6rHzXd78TOgC4Xy91jDETluyPAh21rxmvKUuvhLMYYzJ8qL7XfYb
         a2uQiP94J28HF+MuZ2IRe5+XHQU+rvwHsdZ08PSz8BiXRqLR/IhZ0/19XbcXffH54ozD
         PpB06N9JlaPRDCE7Nx3gPx1uburrC9U70YQQ0JYlr3EIrHmHSiqEm611uvOqEs1pYKjb
         8Xn6kJoe/6Sg8LVe+1NzTLfi5XIw+CeCf9tKqWqvCDuQ561asvGPVlWB1SFIpSsZRawT
         gpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475592; x=1746080392;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuK6SffuhbPTlhkbILGQsvEsS+vrJa/bVOZ+xV94WkI=;
        b=qgplIQkgERG2z9D4s9Zai7QYVKizoG9L4TwWEbkltqxB0Ggz+y4I7GI4hl5EE+nsMG
         dosJnn21Jxrpic6R2FI8dt8/ZgjGcmrHp3GxaWmgrnZu4WCFP6XBEzzMMZNxjxFw0sm5
         Gr7FLMXLUoZEUWmPup3c7kVP+soK8ZqO0wVjJ1zbdJV1uh9eztGg5Z0MRuw6KH9+cAum
         XKMcwmoxF6hoejj4WtZaz5Z/BNGltVRX7/kZOhjPp1vHuj51jlEq8JGSQLnyZhK6BiIv
         2gWRZ0/H/WYZTkzfh0nILFDfmOsnrjCAFSjhVmcmGX79xlxatQlNXkRHCiC4ke12Ylia
         3XCA==
X-Forwarded-Encrypted: i=1; AJvYcCUjAtzEgWhpmGIMSdpafkAcw0zYjtv3josg23LOV690QInbqIitksEfdHTP0lKkKv/YumSuoVRxtI1F0Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzD4Az5xjJDbi1Yh+f8owleGCppmR2heoDGKW6m4onC5D/A6YC
	GehtovamS85xCP1XMGrI/XJDZTeACSUWcBylhTg7mrdeOzijc+1piBLg1dM2GzfQWcLEDIYfVJ4
	9kDizkw==
X-Google-Smtp-Source: AGHT+IG2GWeJwdL101iS7oxbv6AKvJuCKccU9bVWijePyQLiL/hUhmFnZRrtdWaS/plLdDtxY0SMICJFHpLu
X-Received: from pfbfw9.prod.google.com ([2002:a05:6a00:61c9:b0:736:415f:3d45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179d:b0:736:4bd3:ffab
 with SMTP id d2e1a72fcca58-73e24abe8c1mr1761157b3a.17.1745475591884; Wed, 23
 Apr 2025 23:19:51 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:40 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf build-id: Truncate to avoid overflowing the
 build_id data
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Warning when the build_id data would be overflowed would lead to
memory corruption, switch to truncation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e763e8d99a43..5bc2040bdd0d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -951,7 +951,10 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size)
 {
-	WARN_ON(size > BUILD_ID_SIZE);
+	if (size > BUILD_ID_SIZE) {
+		pr_debug("Truncating build_id size from %zd\n", size);
+		size = BUILD_ID_SIZE;
+	}
 	memcpy(bid->data, data, size);
 	bid->size = size;
 }
-- 
2.49.0.805.g082f7c87e0-goog


