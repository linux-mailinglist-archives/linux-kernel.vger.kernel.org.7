Return-Path: <linux-kernel+bounces-875140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB3C184C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E77E40090E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0DF2F12C7;
	Wed, 29 Oct 2025 05:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpCqOpLJ"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902B2F5318
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716063; cv=none; b=huL0Q21rVUsdb/6H9LYbVWiVqIdhAcA0n85D5W3jEFOoKtXj8RdsMtVq+Xo90/qqDxtZrQhLlxaYqWa1zgsruz0I8GuzX4t8Ws6adCem54LdnrvevpYtmolNdzOUOlKTMRNulYJikKyI8i6xADKLr1NoLqmalyJO4NQABx+hKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716063; c=relaxed/simple;
	bh=542/UtxOs4wTeyeK/jKTiKMC3a0OqaamQ7WTLZorbXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XupUaioS9dbo1HZZ2FQm8zs3vFxOOLy5pH3aPmTlBQS7m1PbO++J6IUnqWgpK1c7OrNG3BcFBPzCR7CN9nUPZoKWuILqR8Frr9r3WkFE4xFKV7fHDDUcjeSo5wM+XfvtJmwj8Zn1Zvz22/8jcE7zN8MDIVYEutkhJNTe11bThW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpCqOpLJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso4341998a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761716060; x=1762320860; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT/10oAHeoVqquR7dMAlDMAandjm5/1/h+dRRja64wk=;
        b=gpCqOpLJptVWtCUgVey71DcqCGHQWN7wb82UQ5cHe18jAMpRiMmX0of2pj9S/XmPza
         2TRouYgtzcytfbuatUNkPYvURB2dxEdAAtMCdqRGPXehjhTmUPTG86LdW0zcuw3x/uD0
         adWPdOWwCnK3TB6tkQ/JoV6DhJLTEtkuUClcLWPqBOgSZuUWg3n3xEu1pAyLiu7nbBk+
         QqXuZeiMY57zIPGXYPciNJ3QS+KAynH4vqlo0d8osltWPUQy4eW2jkoABQCFriox8yj3
         HIhhKaEJ8TLN7+IDAUMgrqM8tb2OAXO5M/8f0QiVSj4XDANoudlneSKrQGRlwQtDprzm
         8hmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716060; x=1762320860;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT/10oAHeoVqquR7dMAlDMAandjm5/1/h+dRRja64wk=;
        b=MvYGExbfQf0QDoNpg4jSOtQrJ+H5lI8XNPD4fk8EluNGO9quoNND1U8W+5FI/KTf7R
         Jue+aMp6xaE7pyEm9uB//Ll5qlm6YsnfpbTWI2OXintlQInE0k8detCRT2hxgCiGyDHy
         8KYE7MVqhBFnGRx2SiBsC/Cu/diTBstsylnbWBdjccSpI0I5Je63rtAnw90IilwzR+7L
         wYct+K3yi1Ph/M9KmnAT+n83CEuSIKf57q5Z9ulg/d/oPmQGhEUzOQLA3C3rWYa3zS76
         IQYM4jkh3Mjjfgz6NpPfHeqWfru82LyZkhlZ+nhbSPYbltZG7C7kN/mTOcals0FQlhbE
         ynSw==
X-Forwarded-Encrypted: i=1; AJvYcCUg1GDmYDoInDhUFm03AZI2OoDnNLKo7ftupJVUl+w42tpP7aRJUnU4sd32aFzFmyBSZFbIX4jUIGkrEZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAe01VlD1fGGFEPS+4QaFVv7UhVW0/xiVUqN++GRPeryW1xZme
	RKzGjHU7Ru/KYHDaUH7RwVWidHuXbDnP2cKa6Bx06851XwNVIaV0o34CQH5joimq0TT3bO4wNvW
	7+bWU91VKJg==
X-Google-Smtp-Source: AGHT+IGOe4Pb1dCo9z9D62bEWfA3YaPeeB5O76SErHIJqTUTT/xA1otwE4sp5XQBWkdyM57M1KRXD8ZAbEho
X-Received: from pjbbf19.prod.google.com ([2002:a17:90b:b13:b0:330:8c66:4984])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c4:b0:32e:59ef:f403
 with SMTP id 98e67ed59e1d1-3403a2973a4mr2030947a91.17.1761716060242; Tue, 28
 Oct 2025 22:34:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:33:59 -0700
In-Reply-To: <20251029053413.355154-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029053413.355154-2-irogers@google.com>
Subject: [RFC PATCH v1 01/15] perf arch arm: Sort includes and add missed
 explicit dependencies
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix missing #includes found while cleaning the evsel/evlist header
files. Sort the remaining header files for consistency with the rest
of the code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f4..a0086ca8385b 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -3,10 +3,14 @@
  * Copyright(C) 2015 Linaro Limited. All rights reserved.
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
  */
+#include <errno.h>
+#include <stdlib.h>
+#include <sys/stat.h>
 
 #include <api/fs/fs.h>
-#include <linux/bits.h>
+#include <internal/lib.h> // page_size
 #include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/compiler.h>
 #include <linux/coresight-pmu.h>
 #include <linux/kernel.h>
@@ -15,24 +19,20 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 
-#include "cs-etm.h"
-#include "../../../util/debug.h"
-#include "../../../util/record.h"
 #include "../../../util/auxtrace.h"
 #include "../../../util/cpumap.h"
+#include "../../../util/cs-etm.h"
+#include "../../../util/debug.h"
 #include "../../../util/event.h"
 #include "../../../util/evlist.h"
 #include "../../../util/evsel.h"
-#include "../../../util/perf_api_probe.h"
 #include "../../../util/evsel_config.h"
+#include "../../../util/perf_api_probe.h"
+#include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
-#include "../../../util/cs-etm.h"
-#include <internal/lib.h> // page_size
+#include "../../../util/record.h"
 #include "../../../util/session.h"
-
-#include <errno.h>
-#include <stdlib.h>
-#include <sys/stat.h>
+#include "cs-etm.h"
 
 struct cs_etm_recording {
 	struct auxtrace_record	itr;
-- 
2.51.1.851.g4ebd6896fd-goog


