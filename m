Return-Path: <linux-kernel+bounces-896199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD7DC4FD6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D524F4CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAD43624B5;
	Tue, 11 Nov 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMHvR5g9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA635E554
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896163; cv=none; b=eLQDGYmaodIg5BntPsBLiAKdijEHoqck63giXB8XAk+c2nPOwEw48NgylBPQPPC5tpcjhSdkl6ah2sGUgGZi6maBHvOAw97KTh+UJkoi8v2nHS3dEPTQRHVnQgXbVEe4N1TQM96OAWEfbEUX2HT0JrFT0WZGbVYTQ+mrioIFBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896163; c=relaxed/simple;
	bh=QjO8gSjusfZ0mPendJr0+QHEFToVhbHiU4PqR4DkANY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aDrf1u8O4+d6xrpxJuSjeMAz8I7rkz/2/U9GwyET6ay4RGaZPCSf+yzZamQlJwK9iJm1cbVfjvvqSxfXQa+9fqjRP2byy130CvkpEjb4u5qASb3DmoxmwnWjQPisIn5DIXE5PQB3TLZ+/1gLyuQOQ0qyaueT1H1nmMq/lyyfs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMHvR5g9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295592eb5dbso1432445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896161; x=1763500961; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=eMHvR5g9t6hNK8mQpHF/38hj+CQXzPIGYxdACBMVzlPhT5c3Bajz8uhhGCXCqlITfO
         zWg19/BCZgrJmPpLnNtj+eeWxMVKJaozpwwziGWguASJTTFk2KKbXUv69qaV091/8Nvc
         oWkSYM96oA73NCS+iLDZNkn1M0SUEzUXIBQB7agq6Cf4XNSKdzbnG8QEvRC7kMOYDWwi
         U6470uvpPIhI83o0W7mxf9T2DPvDj8b7Kveyu9TBXJmPeeOXYxIJlSIRkgMVW/tMI1Ee
         a7+PrIuVWad82ojcqQKbYtH7VSvoyNlpxGz5O5eqiUaK/iGcyziDp5cmxhyrwjl34caR
         oa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896161; x=1763500961;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlhPdv0WtdedRwVAzlOAlu+LBijAGUItUQ61/Soo80E=;
        b=vR7FowruEwo2rWi43QY3QF0ldxbr7KOjmB418NQ2i6zU0X9RupFjiok5c/aMLvl41k
         qNzcvvB/pxJ6nGzMCL6JakAf7TsTOjc0Bmds00B54Jv4P+KXGcLqutP90PkAZBVSjfjJ
         MdWX9xnrDrQ9VSHjBJi6W1pvf9NnJustYtNQNOY0ep2Es5K+iiIQwzn2aCinIc5rv4gI
         t+mssLIRqsrDna7QEzRsmr6SNmdxwxgEoG2zj+ILl+Vw2LeSZDUaAUvr/WZoJ+4fePBr
         F0a+HOy2FcTFYQSb0z0+oTjNp9Gl8HDhPSLYkfUR5XYjH+wVtZvHP5wmZIouLqQbiqzI
         CtRg==
X-Forwarded-Encrypted: i=1; AJvYcCVXR/88nsz5CXvw1UQNYujv5jX91wEnOSATGPlQRqKHdFcCGuIPXBD6vQ4pe2C3a79DUECqJF2XBLpPccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPkLCrF97jC1t/v+G82LL5wK1jU2Esgcv0sJ/OJwbaFCeY4n4l
	wcqhj0IVB5UHM7ZGzOHdxpqWdXCLyfdExaducV53Q07VtPBcsOxNFoX4SBclQy+kfmE9Jb2xKB3
	Xi0QhFHHwFw==
X-Google-Smtp-Source: AGHT+IGsDfl4twdhaYyKV1djwFY3TzFmwb7L5cYITsoNZUky8W7ncDvZyauJ+wyk7SW0EPD713vT5kKwTaG1
X-Received: from dycpw12.prod.google.com ([2002:a05:7300:de4c:b0:2a4:61a6:6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60a:b0:294:cc8d:c0c2
 with SMTP id d9443c01a7336-2984ed78ff6mr9651815ad.27.1762896160946; Tue, 11
 Nov 2025 13:22:40 -0800 (PST)
Date: Tue, 11 Nov 2025 13:22:00 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-13-irogers@google.com>
Subject: [PATCH v4 12/18] perf test stat: Ignore failures in Default[234] metricgroups
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


