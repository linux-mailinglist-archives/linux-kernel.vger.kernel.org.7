Return-Path: <linux-kernel+bounces-898547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A3C55858
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 075B534C111
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2782D0C63;
	Thu, 13 Nov 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F24r1SzR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722D288515
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004062; cv=none; b=WuHJ5/KP9f1yXQUAiuUV6jp39cpee6D+J4IvtyEXOgIDx6xJc7T9xOdpiJopsSwqQqSzQOCZ/k7r0InKwBdXJxfAcFKwBMdTAMzlgxi6QnPbFuotMrzPwji69IwbvBnhmO3LqYBtV2OvHHzwBjDR9wKFb0IJpWxLsKq+xVkuVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004062; c=relaxed/simple;
	bh=eC58kngvKnZBaxpuxmabHi5Z7uj3JfvVXlXN6Lqlu4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FmjhA7JxzxmarN2fvqi9XAoIvTu31XXNWNEJebPVRo8ztTONyn2rOSWN/QI/2f3xnh35iAgXpQCB8O5wga01pE26bJK9IPSzGWcqPRfvz2ZBAHT3RdWafGCRODw9GaaqtEPLExrVcmGsh4NL/sh2MhLUhaSrbLH9iwzNVdQqrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F24r1SzR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956cdcdc17so3954575ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004061; x=1763608861; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvhFYOBpTW9GV2iBS0jKxxq9+qzprLqMkGzjNH24eUI=;
        b=F24r1SzR2ivGymGaLrYmp64zJAw+rd7+7o1Qny7YT6WkHyMGxDtFwkcxMaYuY7GVDY
         D8lwKz/UA+4kv1pthJPTYhS4CTPOhfh74CcaoJsTyM6+CydG6jQM0ig0ws7HcH62xIFH
         MhcRrcBtw6RZQzXbCsy9bPumaptovuoGyyqdfiVNjDP2yrx9yIQC+kV2W9Gt1LCag2fE
         ttCmtLFRhnB1VOBJLQk/39HU+sq1HIGOfppDIOj+d33bSTdF8ifI6lehWCL+cpgCOdrn
         ZtneOpqZemyWKgK7G4D9QeaD1Zh4TDwz0LJL20InPlR44DyXsZ79dp3z3aKkewyMlfTP
         7lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004061; x=1763608861;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvhFYOBpTW9GV2iBS0jKxxq9+qzprLqMkGzjNH24eUI=;
        b=na/UNiv9XyRVWJZ9ZUVPExJy6SXZqPvfjP5vl9TAFZ79qtzcDlmXyo11mmNdlB3VfY
         gzL/RC6QUhMjN4R58oUImBToxU/zHko6nwkiFzs6WLzokJLOg8rUOb4xFUk6tRw7MiBa
         vV5XhFSUZC6lKMcNwCFUWxEu3M2qWjuTu3KjjQMseWKre4TuQ3ADtxWVgnm8ENV2KkU7
         bCcxVhC4+jtc3oQBxGQtV01jmar9HD1aefElG0LhpifX2VQOX8K+m+c5KYFpmPLiQKKy
         r8jnLfKex3QHDb0vxcRE1x5tHki2gFii97bcV3uifv3jmlHP+nCt5+OpY4kmvsV6fC/K
         pCKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYLkqhATzyjCqKIQpBXHLIRscrZyg32IbaQK441AsR8XYrMTHrAyiQQlYtWigh3W/AdzKwhwgqpNR9MHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJGpQmSG3R/0OOfNxtpZImNoTJMr3M9najIEvuBNUlnWjXHds
	YT1heXvGSXeru2tYN42xCjm6XrG5wWnQfEQKJlpYBe1FZXO7xGI/ReB+YF1KV2awh3mNsOaX1yW
	tkmb0Rt3O9w==
X-Google-Smtp-Source: AGHT+IF6MRNDBzUAfgeIQSurBAUjDMymTf+Vm3CyNpHhZNgx7Z5nQLvJUxcRg+7wkxcO5+WTiA3qrehN0Tsy
X-Received: from dlbvv20.prod.google.com ([2002:a05:7022:5f14:b0:119:c913:cce9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e847:b0:297:d6c2:d06
 with SMTP id d9443c01a7336-2984ed34d80mr73166115ad.20.1763004060804; Wed, 12
 Nov 2025 19:21:00 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:51 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-4-irogers@google.com>
Subject: [PATCH v8 03/52] perf jevents: Allow multiple metricgroups.json files
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow multiple metricgroups.json files by handling any file ending
with metricgroups.json as a metricgroups file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3413ee5d0227..03f5ad262eb5 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -640,7 +640,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   if not item.is_file() or not item.name.endswith('.json'):
     return
 
-  if item.name == 'metricgroups.json':
+  if item.name.endswith('metricgroups.json'):
     metricgroup_descriptions = json.load(open(item.path))
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
@@ -693,7 +693,7 @@ def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   # Ignore other directories. If the file name does not have a .json
   # extension, ignore it. It could be a readme.txt for instance.
-  if not item.is_file() or not item.name.endswith('.json') or item.name == 'metricgroups.json':
+  if not item.is_file() or not item.name.endswith('.json') or item.name.endswith('metricgroups.json'):
     return
 
   add_events_table_entries(item, get_topic(item.name))
-- 
2.51.2.1041.gc1ab5b90ca-goog


