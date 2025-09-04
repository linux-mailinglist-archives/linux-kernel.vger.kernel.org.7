Return-Path: <linux-kernel+bounces-799888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B01B4312C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 548CA4E53B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4B025E824;
	Thu,  4 Sep 2025 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iu5iX7Xq"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7F25D20D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960351; cv=none; b=d3WTWsrVhbB4RkKrlN5Nb29H0a8WogfbQOn96/7pLJOqj+jawuOTd1JwLmoSc6cI+lCUqHvwqEQXt8+IUxrTglWMXIOEa/xAfhowU7Cqml78pjf+0APIbOLNd52GmxzmSoHMNDK+8nQaim9j3T8AfcqhXore6/9zhEdgRNLjos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960351; c=relaxed/simple;
	bh=u+bva/+LfPt05RVTOBRKCLoU6rA9fPkmVSp5pxfNe4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aaKRb8+H0XqY58DlKKL60wPJ/+OAnT1qiMxg1zM8c1iryXHtPw05SWXwm5vgfwNef5Qc27o7HwPw3bdnMpb/kOfcmhx0aKJO4FT1tb3PYYXucJVUmtTd4U+IT2NI7eyhpQLDK/gimpTwjhVexcaAhIe8Bz7PoxF+A8mtOK0qK4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iu5iX7Xq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32b698861d8so533469a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960349; x=1757565149; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqLlT9pOYsKIiELgr3Sg7FTquyunCdkidduCA3qG0sY=;
        b=iu5iX7Xqxk9Vif0dn5Fowxaphbx0DlRWup3l1seG+M35HU4IDGrcsVx/FxGbJKtkr7
         BMyX3R35/slybeXhwPPxyM6auBlQSOB4ETMUeCbbNZmeTy+/6EFlpI0Miixo1fkP+zuM
         ffpa8zBoFW3j3DrmWBvEtmdH0CTHYwPGjJPnMuccGT+vou0MmtqNwhQil7x2NHLIXbXI
         Gptgf7ySzMBGgjFu/LnrsF3aZjq7YspRjTf4TFhvoSQpnQCgXmI04IUHobpyKS+Jr/j2
         SXZ/qjSuSSCw4BHrGkpDqB+FB+H7Oe1d6EzbsH5l2J1l+7eglvze3umdowzvklH48Nv0
         bgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960349; x=1757565149;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqLlT9pOYsKIiELgr3Sg7FTquyunCdkidduCA3qG0sY=;
        b=nW6Dqm+bnab0ph9Fb7ettixWnCEJqfSqAJ/bWzBSUjwIUkZgDGZcrNGX/aalR1/z7K
         nQ2xYPTNnGhNDdzVgUjyzCKaLaunUX2HC8oR7BqGZFKi4m0ToaRff0QJcAkRY3T46r4v
         omn8XLuKoqpkP/7uAWPKDtSCDa7X9kyKS5f3XISrxPynY3xQuhYAIoStgpu9lL8D79kX
         8ZiJyJhUGNoZkfCkcK6XBJZfIuG1bPQEeWXcintS9Oo6SjXJgmHV6reW9nPku1vmJknZ
         RIVaBTyfhkI6PLdDa/7f3Bejy/6ri4NLoq+o/rHOFk1AVAvDxY/5Ry2FW05trr8cLy41
         yMPw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+qLxzGB3W9n5Oaiqosf+iCp3ERhzGlK/iA90ZKkM8QnhJRt5Km8rkXe1I4i6TySMaoj3G3p5blMvu4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kEqxbgFlJzxB/xFVQSMAtirsOOfnygDR6VUmHqzzbnnkRN+F
	ZWJdU7LvBe5KE8UKbMa3v5or30dY8+fMekVUn3rGlBfDbLok27o1Q7ecU1WtQvJy2vikSR4ZfAl
	wzGdF3bLA9Q==
X-Google-Smtp-Source: AGHT+IGwvTXeM5FCHwvs/qwb/80EVYFAoeYn9+s/Dro0JccJkyeGUVVcrEWod7xx2CAJya7A68FcFv/+i2DT
X-Received: from pjbsq11.prod.google.com ([2002:a17:90b:530b:b0:325:220a:dd41])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d81:b0:32a:34d8:33cf
 with SMTP id 98e67ed59e1d1-32a34d834d4mr6945280a91.31.1756960349273; Wed, 03
 Sep 2025 21:32:29 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:04 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-10-irogers@google.com>
Subject: [PATCH v6 09/12] perf jevents: Drop duplicate pending metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Drop adding a pending metric if there is an existing one. Ensure the
PMUs differ for hybrid systems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 69aec4661a13..7978ca7ef16c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -498,7 +498,8 @@ def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
   for e in read_json_events(item.path, topic):
     if e.name:
       _pending_events.append(e)
-    if e.metric_name:
+    if e.metric_name and not any(e.metric_name == x.metric_name and
+                                 e.pmu == x.pmu for x in _pending_metrics):
       _pending_metrics.append(e)
 
 
-- 
2.51.0.338.gd7d06c2dae-goog


