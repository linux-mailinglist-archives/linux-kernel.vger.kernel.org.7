Return-Path: <linux-kernel+bounces-880606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6CCC261D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3831882532
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97CB280A56;
	Fri, 31 Oct 2025 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALcijxMI"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE71E9B3D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928003; cv=none; b=shX2ABoyHvVth/yhyRvYf5xG0IqoY1K4VgcKqsv2H9S1YtFlXqAk6AaPEL6kpN7fDGQBpsb4eqX2VlfOk9XhFYB6D7gxpKxaPGy0i9Fmc7G3qVLEkjf/tcI5GVUw9bXOsDvv6ydFdLNxYyJHsuQAGJd3odSk5rDg4wLTCdWxSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928003; c=relaxed/simple;
	bh=aFM2GNujzxVsQyhmP57xjxMcqYfoxDpjgoh4PV5rLj4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=SUCrgdOh8nkt5L0UTft5Oz60NEIg0buP5vpnVPmEuMSFVnTpnBP7Hnav6/SouZhk513NGA78KVvycS1ZAMAz29zXR1Gc/96+C6oboQXR7dDyxbEp3E2mhz2TN+RD3ICpV9wRegrFJSSLh2ogoISNB3t+EaTOJpM0g2vVNkHA5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ALcijxMI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290bd7c835dso27103885ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761928001; x=1762532801; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MJ5wTxyIGhkSgxSwr5/lDAZSF9YM9vLUs7BuLenptwQ=;
        b=ALcijxMIQ4aQ+XO7mWqlcrdem8sCrAK+BcwDHzXpYd7LKI4f8vmnAt6xywC/C4vCcs
         L6yKwWF5mM5E6tl3cSz2TZK9tSNvFiX5B2WTn5R48ra7mMFRmusOJPmumMSlTgQtlxZS
         HZLepDBFEF4rR8tzCPSbGtjLmCJHNo7ajfg+2oYaLQ18guMknKsrzyLYANybIGw+fFu0
         kUN4Arwq1K4UXYTrD66gGrJNlXPOzWaZJ4aFWQ7afEwEpkNNfKElQ64u/UqdX+ZX6ccF
         Q5/Io2xjB1sc7ZjDEjTbxFNu1kjpmzXLhuigUIZx+lsU1nnTL5fvIyjoaH9Ou7xTmCH3
         tg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928001; x=1762532801;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJ5wTxyIGhkSgxSwr5/lDAZSF9YM9vLUs7BuLenptwQ=;
        b=rjaXkYMo0LjfHI+oddzPY3W+/djlGxdnnh4X28gEiKhbe2HXd1LLmaX6P4NJ/n1XZD
         7EVYEcQJK3QbM2kzQ6DaUJ8/6DVAjGdMOt90XDYsEUMiQXeHGo1IOmCOvbd5vaFho6Uf
         m9cjb7hk4wptcCITqhdFUkAb3vx9iV/9qbrbtgx6hltigB0IfZVYohq40Jfg8ccmX4zv
         2xSRBAIFk5D7SVhkv4V9MLX3zRoKNA51nmlmVSvUpS0Q8R3kfymnmT+4zb5aV7K5D3I8
         m8TL4slyKfi/NTS2KMAJ0q9I9+19H4CCkd3lQUECKt7M0TqYZuL0CMsgXPXZRS/B5nw8
         SVew==
X-Forwarded-Encrypted: i=1; AJvYcCWn1MFWAUSSvfCDe4XqoEmwrHzLPAfWAyWzVzKj1w3gL03C7I+qqqSxMxhVC+ajgL/vRYfbxvAQvyke+to=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePxGMHWH2OlBGcDzMtNcR9RuVZ1H6UM/LxmaZfe3TV/nj2kis
	IFD4774nVKlqvIbKSVNnWhn7HiL7WiCzhveniwX8ESMKQg03Spn/Brw8fmpUngmmkEipRiG9Yrh
	usV5PX6U/FA==
X-Google-Smtp-Source: AGHT+IGqzeQNFo9eZuSMefnUMIWuDO4SEu5Sqd6gAL3qsuKNC3EDvj3K+NUnEMB3YhqprC4/SfYhertKPrkP
X-Received: from pjzj21.prod.google.com ([2002:a17:90a:eb15:b0:340:8351:124d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c409:b0:276:d3e:6844
 with SMTP id d9443c01a7336-2951a493552mr62350685ad.33.1761928001013; Fri, 31
 Oct 2025 09:26:41 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:26:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251031162637.1456191-1-irogers@google.com>
Subject: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB to MiB
From: Ian Rogers <irogers@google.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
rather than MB (megabytes) where the values are powers of 10. This
patch corrects the unit for uniformity and because such units may be
pattern matched against.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
index 7a5d1bf543f8..8d028a7c2777 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
@@ -29,25 +29,25 @@
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
 	"MetricName" : "mcs01-read",
 	"MetricGroup" : "memory-bandwidth",
-	"ScaleUnit": "6.1e-5MB"
+	"ScaleUnit": "6.1e-5MiB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
 	"MetricName" : "mcs23-read",
 	"MetricGroup" : "memory-bandwidth",
-	"ScaleUnit": "6.1e-5MB"
+	"ScaleUnit": "6.1e-5MiB"
     },
     {
 	"MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
 	"MetricName" : "mcs01-write",
 	"MetricGroup" : "memory-bandwidth",
-	"ScaleUnit": "6.1e-5MB"
+	"ScaleUnit": "6.1e-5MiB"
     },
     {
 	"MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
 	"MetricName" : "mcs23-write",
 	"MetricGroup" : "memory-bandwidth",
-	"ScaleUnit": "6.1e-5MB"
+	"ScaleUnit": "6.1e-5MiB"
     },
     {
 	"MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
-- 
2.51.1.930.gacf6e81ea2-goog


