Return-Path: <linux-kernel+bounces-791038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C94B3B16D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7433B7981
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 03:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDD226CF7;
	Fri, 29 Aug 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbr9SVSP"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B1126BF7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436857; cv=none; b=Copj35SOajAEPgoNIsIvHge/89tnZZO0wwUhqYOIjDpCeNPxnM7WUXGOe2yMySEeWpIjsvx6pKkygoFeNbmSoaq/q3bEtTAWWH9DKOqXJYtA07A6njEU8Voh1yZNKggF8X8A2TvLsm9X73q9Ziz787XSGJBnCO7EP854rLnnEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436857; c=relaxed/simple;
	bh=t5xyoj8wIHdlPAnXsxGru1L/7ouPIq9H4n+12YXzBfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NRftMED1n2Q+JZaUs4khYNF4PXSXkrMq8+cE6CHQUyOZFgkzBqLIQkr3EVAhuzynGO1fuYyS3aTx5Lv9Fq/r9DbdT41JZ6P+nmTdPJl65srr3XtxIx4I87rRQ1v7N9wNww//YoU6OzMqIHiGprftTvfUaZLWbo6yKEI0lFdQU6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbr9SVSP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c409a09a8so2245253a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436854; x=1757041654; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20U3jn/8wAJzOpL1hveSchRqqYuGX3fi3dVG3vYVRqs=;
        b=cbr9SVSPM71mZrYr+PJm5ncTC5NKQr53jBnNbmz415jNvHDT8+VwlQs31x88EYCd+h
         LHSAC5ql5AcFeVyqvfq+aqbofxQ4EhHqoa5EmG2+SWz8XzAyyXZlSqwzFkC4hwJff6uf
         PjHuS+YY05i08GBSPsrpSRJRAgfOy8zmgX4rvQjsYRj+XUIT7l/+CHpT39zTkvlNytet
         JKFIwPboOfVOXXvCnn9BUeCbFM9JEHGjgIfTJmD4yBPy6B+OVGraJ/du+Y4aORUdlr2U
         YeNLkyR5aAz6Z9vAPdoLux4Bjkz5H3E/e3S1Yz5FCdEPvIUDV/aF6CtKq+LQPEJYi0BY
         3xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436854; x=1757041654;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20U3jn/8wAJzOpL1hveSchRqqYuGX3fi3dVG3vYVRqs=;
        b=V/651RAIXBti0ASEtbVhu2lCWYuK9UdQuzoBh7KhtVCNL2r2J67ghaJTjNPVzpIcYj
         CSaAIX7XO9uZod2PNRMnwanYK6un8whZgQf4iOyAoycyPQtAL3dekgWkrMcCKwZAToEG
         KmwTZZxcg0xdsf04LEc0VbVEzTkaCJntPPk+OOCEAwaFJ6gRytAOB5rYkjVggKSQKDQt
         2f/Vv1i8a1csYMUfDCItrKwMjZqVsqmUSugoutDHSu6hl5AZt1wgW9x7DR9n8tihtISM
         80r+Cr5HTnrs18vPaHqTO0cGd/8DktxigSmm1msQSYP4qVBlfBQa+A8buXp1jA0kcG5C
         Yffg==
X-Forwarded-Encrypted: i=1; AJvYcCUmmYF3QxN0TWEeNeKO9Cttib0wHINVEb4KJcGjMOjGLEKzsO/yUai5XYst9ugQrMpnLax9E68jQzlScKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1FqadjomdEjShyfKC3+hMkomKuWzMJfhJiw9c/jn/ycEzQ1V
	SP6YzJFYZ0CL65NLCZW7xgbtj/cxwUFxv7E6Vb5qQc5BSbUrLNnBdJJxvyjnKMiaE5bdVMkxZF2
	PjyKirojyLA==
X-Google-Smtp-Source: AGHT+IFjxqk31hpFMspKZJBhWcvU3koR0zXOFKwFgSTPECY2WmzRaTFOTjIKkldnRUAUvOddJHXUhArN7+TH
X-Received: from pjbdb15.prod.google.com ([2002:a17:90a:d64f:b0:31f:335d:342d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a128:b0:243:bb99:a100
 with SMTP id adf61e73a8af0-243bb99a3d2mr4303651637.46.1756436853865; Thu, 28
 Aug 2025 20:07:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:15 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-2-irogers@google.com>
Subject: [PATCH v5 01/12] perf jevents: Allow multiple metricgroups.json files
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

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index c896108ee4cf..69aec4661a13 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -637,7 +637,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -690,7 +690,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.51.0.318.gd7df087d1a-goog


