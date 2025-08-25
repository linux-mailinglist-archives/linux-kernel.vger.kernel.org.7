Return-Path: <linux-kernel+bounces-785477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A5BB34B43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A85A5E1291
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A42D28468C;
	Mon, 25 Aug 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0JSPEIg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD928314E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151902; cv=none; b=m1/mZmPwFDGudku+2Z8bC9J/ErBELb8U42IZS1sh+fJM7Ha+xkrqPsK1rdL4pjOZGh4HH8X/DJxw+3iu/s0oIpDZ72qXipYklCdyIDmP1/1SASE9Z/WZCFtvN2PfvbBRaWGcmsPKEXrAIypX4NGXeWwZpNuN1mECNQllcjnqZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151902; c=relaxed/simple;
	bh=WihZ4yyCiSm29dEhkEPRwqpKB4pUa3OiFlScIIRjzzw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OhAo0mg07Td7VowiNC4LbDcTW5FlEXUzfq/PPTFv9GyovsIkupkWS6ZucJI7KfeDFXAheQLUj8fG6v0ClgLh44z+IieM/iL4cz/CXxH6l/BJSDCiOv+IYhW0ckvQnGgYx1I92gRxkfsPmtOWI4qgJ2yApLIgoI+siUGRt4Cord4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g0JSPEIg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71f964bac5dso71467987b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151900; x=1756756700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xDctw1Uz9fUTjPnXqvzAhbi+nh393hqNXf8fzdHpNfA=;
        b=g0JSPEIgof06riU/S6RHyUpMrpBat2PztKoqPkNRg1dOoWrjcGNEjwVS1iGPJnOANm
         6qmewkE1GnsFpp843JRIECqsF0z7drRYieJsFrAOa/oVeBZDjuczNvk7ZrWFbqA8Qpr3
         3b9qztF8mlV/DOwg/0y34yWjThqLt/ynge8Muc3uWtMOpZzZxWAgRyASPoLMtR1pBp8U
         wCTrDSuWwEgwCh/wiAQfMB7H38ZoqhsPF+iTaumIEk9cnNRwNs6rPnaZuoj5TbB8QN7w
         G4DiiLcJM84QMie68fjL7G8VwHWErHYw+3Wz5/6hSou3IqhCxBxR0UzaGaMzxazxl6T/
         cR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151900; x=1756756700;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDctw1Uz9fUTjPnXqvzAhbi+nh393hqNXf8fzdHpNfA=;
        b=pVTH6wyGlAvbvzDftKpZr2UpJpy+FB9RGw0yX0uEvwMl/8XaSU51AikCcE9OeGEhZv
         Om/iTcyDWBwdRmIW91e9e48myQdwF9K+IvuoTHgXHXoUKyRT30tEqCXZIOi3SIZKRoJ2
         F6lXEa8LRIzttnucBOTWPLd/OTMh+JAB183aRaF8kmetadF2oAhwvnx92orm6zHyNZuh
         nxtUiYHkqCJXWWYATqhW+3odNRocq9btqfVw5CfbfPy4OlpQI5uonPk3oC6dC/4IzxEl
         +1JU1D9dZ+B6IEBXLYSpc4oFsobCByBXrU+HOWdNvT+SY+EKeH0CTNA1+vSOhhmazxCX
         jtxw==
X-Forwarded-Encrypted: i=1; AJvYcCW00qMgyjgiwYaQ31JvztUFq4rTLlFz4Ic53pmUlsSvbgRSBbbokX1MUsZu1BTv8GuAFCg06aCj1y+UpOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRrUADlVV/BPJYTKkAN8rssVg+yZPrgANSNwbNndLPv8GIIlk
	BUxHxJOsCpBloxDT4c1ViOSZp8PezYp99Hduz/13JD7fHw6teMHmxonWY3WBezSss3efn0tmLK4
	oK8E7eqUZpA==
X-Google-Smtp-Source: AGHT+IEicRIw7WhgoGEPltjERABHhJvcveZyg9QSkHGNjkO3XrtTBs1Qi2NjcfLrRBQeIh4OgnRChFVOo0PP
X-Received: from ywbcm20.prod.google.com ([2002:a05:690c:c94:b0:721:2509:7b28])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:45c5:b0:721:1649:b070
 with SMTP id 00721157ae682-7211649b5a5mr33206337b3.44.1756151900161; Mon, 25
 Aug 2025 12:58:20 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:58:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195817.226560-1-zecheng@google.com>
Subject: [PATCH v2 09/10] perf dwarf-aux: fix __die_find_scope_cb for namespaces
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently __die_find_scope_cb goes to check siblings when the DIE
doesn't include the given PC. However namespaces don't have a PC and
could contain children that have that PC. When we encounter a namespace,
we should check both its children and siblings.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 56e1b5690dc4..013862ea8924 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1962,6 +1962,7 @@ struct find_scope_data {
 static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
 {
 	struct find_scope_data *data = arg;
+	int tag = dwarf_tag(die_mem);
 
 	if (dwarf_haspc(die_mem, data->pc)) {
 		Dwarf_Die *tmp;
@@ -1975,6 +1976,14 @@ static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
 		data->nr++;
 		return DIE_FIND_CB_CHILD;
 	}
+
+	/*
+	 * If the DIE doesn't have the PC, we still need to check its children
+	 * and siblings if it's a container like a namespace.
+	 */
+	if (tag == DW_TAG_namespace)
+		return DIE_FIND_CB_CONTINUE;
+
 	return DIE_FIND_CB_SIBLING;
 }
 
-- 
2.51.0.261.g7ce5a0a67e-goog


