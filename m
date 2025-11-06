Return-Path: <linux-kernel+bounces-889508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D7C3DCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F40B1891684
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E63590CC;
	Thu,  6 Nov 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpObOfek"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6C2359FA2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470964; cv=none; b=Kok+ZFL1Bu2XfSoRRCo3g7c05zPpXmCF7Mh/FQ/mUAVElMntbbOCmVW4340ZlMC5Yxn3LaNUPxYTg1fC8EJundfQ7djeEF7t52uDeB0A8kdpk/VUBdgE0/uF5RhVdkdQz68J9UkeuLD5SpqOZMyRMMVC3h/kSAgznFQDraCw7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470964; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R+Au+3xMvCQgYb7C3viQq14+rKhtWLpYrkuyeeUjcSpt6roYO5yiYt4W3sQTDmoEpXcaWROdxW2QV5qZ70F4m6eX1ow5jLF+7/aNinQ/1353ibkupXHbyEdHCuoowr2nlb+ZV/pdL23ZI2T4cLXmu3EoBhtvCpLbXTcCGLTWPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpObOfek; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29555415c09so2107655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470962; x=1763075762; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=cpObOfekKgmF/Wr/e2BhDr9Id0SkoWP0yK6vGkdkeuDCC/ijjHbwqvS2hYh9+7xUTD
         iiJ7UKLi01kq3f1V+/DE/pSr26ENrWyC8uOOOHaLT4CTDuQfAOJOj1eDFfcmPKBZBxFo
         5U5GwGwsgkg+qkExfgwd06dWsNvY9hWSuvUC5uCTJvlt3TYNknO2nXNSj5vS2uJAp40Z
         5HWmMGJO06VF6jwJndR9yFhKlXbtc9jvf9DycJCOVv+vLy8hlZnTN2aPvpGbOErzkuGY
         hmOS8E63mFUt9KJ3pyKshJOMUeZuEiGNkweOHX/B4rAbt5PmwEMM3GNiSUsPLYRnD/6s
         tkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470962; x=1763075762;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=rm3EL4Sz4GBZyk/OIeJNHGDUFoaLHwgQh+7mUM6mMifvrzjBDhZatNz6mLuPWWidme
         GYq0WUPs978T5CfBJhUD7E8UVlKKFn8fOoodVj21MUuVsnf74e4M/h1IZxeFNiQjIKd7
         FPk5/rois66mUEq+7vKnmseBikx1AiM7Tk9oaVnWZxkjUfB13tZBjLH2gx1fQl2F2bfK
         XC1Kz+ceFcTec+FX3IDmLu7R9hjUpFiUx3vEsoBTq4ZrOAVE5eyFXviW7pUdED5DRF5Y
         18IopTDJDcFIcMg7xyM9+/MHws8JiQcwsMXOwW/PVZwXSy9uaGcazBcsB0W+kkG5YyFk
         0lJA==
X-Forwarded-Encrypted: i=1; AJvYcCU5pZbthB9G0zN4pUHwbsC9zN/k9fq2cOPDgv6m7eQil9AWmvKN6Nuxd2GPI9RYWbt+SCIdmJVoczSBuWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XRpTkw2oiavxQo9zpPqf5IczvHait+WYvZ9u0GQbU1VeSiBN
	sPzxE2g06WyEqej+GmZGKj4QbjnjiSxG96afJhYEW3imKjqgWuax6+FL7zMhPJI9mvidQag3EVY
	8kZJKTASuSQ==
X-Google-Smtp-Source: AGHT+IHGozQui+AGGQhIfFXH2HFvKRA7CZtWpQ/Mv2fL+bTBN/Rcs9YJrd0UGOU3Fx1UbKXIr+g8XrJOLICv
X-Received: from dlbrs16.prod.google.com ([2002:a05:7022:f690:b0:119:49ca:6b95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a85:b0:295:ac70:10c4
 with SMTP id d9443c01a7336-297c04575a6mr15133595ad.47.1762470961751; Thu, 06
 Nov 2025 15:16:01 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:02 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-13-irogers@google.com>
Subject: [PATCH v2 12/18] perf test stat: Ignore failures in Default[234] metricgroups
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.2.1041.gc1ab5b90ca-goog


