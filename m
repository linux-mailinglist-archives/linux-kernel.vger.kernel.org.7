Return-Path: <linux-kernel+bounces-898088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B05C54528
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D663B65FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03622299A8F;
	Wed, 12 Nov 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cyq1n7q4"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071562C21E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977203; cv=none; b=NOAWZylHE3fMARMvToVS8K5phU5tlCHFZBknc1+NkpWBUTCHV8zjQ66uWA32D90slmMbjN/9GLoj89XqH5rI6Y+jc+aTYVJmOYGQdgBeKqBUzanpxfRY7MCaHxLIrbuewsKNduIP2JMgdVfQFMqB5/v9hX4nMWlBe4nC5RvGT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977203; c=relaxed/simple;
	bh=yYYSEm1+78KFE95YmQCyenLnSRE/5b8iEhqKQfSJY+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HVGdzC2ebeHPbjfydkWcd1K24892nic0Sg+3zj+3thrnc50mgKDZvq2SOADQgAJBl8cIwmIdpJVcC8NJ27g2u7vBQdzIqjxBOQpLJilb/dKaEbxkbs4aqTzdlKqRwwFlxn/YsXOjUD6xnqptjWLJBNJuXoUBp+aTM3dky8eK3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cyq1n7q4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295595cd102so83195ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977201; x=1763582001; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWhwDpn/WcIzrlLSKPaqF4IGWaujqE9kQM3MysbpHr8=;
        b=Cyq1n7q4v7HbBx38n63bzi+esySXHpGg1yJAu4gbI2SzcjQYlBf3VLkvD8PjGKt8K/
         aPMsUYkEWAyNCH9jquw8N17A75VFhgv4xHC0qwmE0+XnO0NhW8X8Pjg6pqgqlfVObir5
         Jo2bTfMQ9Pjyx6f7Ab/eZps36+H/Y3CrMtoribkH25Rap2lAl8IIrY1TE1i6RSHjStDj
         UPcyG45IViUWo9uAyNIUr1ZUYriy1ZXbCEUdhuXjHiPCsAmZil9pY6xaWSz3uX4RxiMQ
         h9GXCUm5vWOd+fnf47cL4sTfKGB5AFSOT9aKYB3an4FsR7sfd1C0qau52hCByEnkbVTs
         pVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977201; x=1763582001;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWhwDpn/WcIzrlLSKPaqF4IGWaujqE9kQM3MysbpHr8=;
        b=G+QyHkFXrZ0fPjFEWZ/FS5T/Sjjh/Epel77MNPpu2wFwUXRaYiNA8WkgR2e0753rKT
         mHX1pF6HmmcMTK9J9SJxRpN9cGd5Qub/2wAH3xVhUST4yxPBOv0wFXfBmZHXGLYhqz7Y
         ASueJxzOb68MqFfcfnD7qyu6y6UBHMe9AemTGTxpdIPMZujjoGfD3bdnZd02h2Pusb9U
         50c+oB6CHmezGq3Yvtjayw/YUY0tGeZ2hZRgXhodz4XheIhoJi+wh7P6U9TesO79OCs5
         X67rJycwAEmjzRbK//O8a9uMRw3kRK2wndJVnCJQ2hPlAORfEsfOIZPbf2Fm7f9kV4aP
         ql5w==
X-Forwarded-Encrypted: i=1; AJvYcCW1e2ZDFEgwhBbMz3hHhkZoZ67plRVk4fQDXdkysGkFXKOkAYhohCrcULPBNRd+qFifFtzwow2l2ACmwiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqypuapwXUi9JV2or6d4c39N4JZJOafm9weJI7D8MlG38y7Qyw
	aDe9jh/17gvN9dtKDJSKj/fQvstY+BdHqrCy789jv6B50hpw5OgcrxnTVLVDoOphcZVfsCbrk14
	+3BkhinLHjA==
X-Google-Smtp-Source: AGHT+IGr8jqCt/mQgH8SPenACb3EoRr0g3D/bK0976Lf844ug4u46eKIIXxBLg83l6XVCi7QbfIWMrTnn91V
X-Received: from dlf13.prod.google.com ([2002:a05:7022:40d:b0:119:49ca:6b85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e94c:b0:296:5e6b:e1c8
 with SMTP id d9443c01a7336-2984ed92467mr56093505ad.13.1762977201529; Wed, 12
 Nov 2025 11:53:21 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:09 -0800
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112195311.1673981-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf parse-events: Add debug logging to perf_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If verbose is enabled and parse_event is called, typically by tests,
log failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0c0dc20b1c13..e522082c5a21 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2236,6 +2236,8 @@ int parse_event(struct evlist *evlist, const char *str)
 
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
+	if (ret && verbose > 0)
+		parse_events_error__print(&err, str);
 	parse_events_error__exit(&err);
 	return ret;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog


