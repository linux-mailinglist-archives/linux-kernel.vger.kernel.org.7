Return-Path: <linux-kernel+bounces-627604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60401AA5311
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B374A3ABA44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B3292915;
	Wed, 30 Apr 2025 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="triM1FNq"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EE28BA8B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035509; cv=none; b=m+DbmXQEZMo1KWNhwqAXt/DLg+w/tOA3vvLeIuZiKwE62jacbFZmLo2wkq84D+gus9jb+hxaI7+kofSplETc8KZGscRTbRs5PIHWY7e2pRZMeWlbLFdv4OEzNTyc0hIgfr7RFrTtr5Gvrh78ssEjXVuC8C+8HvOmNwzNWpF3CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035509; c=relaxed/simple;
	bh=x1iTOuCNnuksau6+iZvHjhoPDhp0WCruIHotwcEx174=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pIjNl0G69SitkZ+d2TccfSn1zI8WK+sOb12rejVyS0uIX4RQxOcqzz9kDRXuTce0a/vr1S3X3BpnsOJsZwPjzwMkFoBkGf0ZQDsIAP6sq8tggeSz1u5VQLWMbnozeyr2bi0TQFFwCWr1cW4hEFpS4DXmKaL4r+mssr8lB4QqtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=triM1FNq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so159509a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035507; x=1746640307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTvuhDKPIYjHf7Egjh82CR3gFLkm+6BF54DwU8iucco=;
        b=triM1FNqCVjgLmCdqINckmrltY9Czo/nB/x4J9Cdr7A3ytOCFyaRxe3wheTc/WjvJQ
         xtb2ENsdUnUp2sKEE5crdVK8HncfbmQ7gROp286VBQznbu0z1jtFcNzgt9cobR5oT6mI
         PPrxO5dM0Y9mSmHGcVdG6jsbVko/gOmi7nQtHE+USWiqntVYZbCDMLVWrqu6l8IAmFu8
         3cJ06/Cou0da57/HnW7D2AyfBRsUlKoyTcTMrXGeX2FmVfLX7yRP0d0oWEatEn8iM4bn
         Mzf/IiwdN8KwJWWnDM5e85Xr9+MPXGnTWbukjOlskFeDjDo9szcXoNCCGyOEYH4N3kyk
         90SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035507; x=1746640307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTvuhDKPIYjHf7Egjh82CR3gFLkm+6BF54DwU8iucco=;
        b=gD00VbO8iW4IxTIL7m9WacR9Z7cQLFFo195Mk87Tp80pyqtsMrZDTqnwrv8L8maikr
         a8b9CXcF1Hf7yrVeIJFLTZleRSEwawG5o+/lRljh/K50XUOMr8KHc3yYuhsFOYSOopxr
         nIrKub54Ud4ncZGZPpgI2jMUHx4ihRuHJKS1c4HQfqrgZSqGyWdftJ0fYxhiM0Ok4xPD
         5FpiiVMs4/yTocIiS1pAiKzdffUiPl6b6bc7kFxs4AKJBWg7ACwdj0jahfA2JjRcDRgy
         PvA/pMknuW7gk0xXsQkRNIo5tps77nq1eYTa+GDosLr5hZ6qKg3LqRj4VlCMdckr3gd7
         a6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvPdZlRlvp7H5ext0b9ndDbIOiBIU+tVoTz4qPR/qtoCkjOwGE/WQtO+VdqFsSnrdyU32MF9p+ReGOt9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQYIG6/1ZuFzpYBOjFAEyK9fN+ActgLPXEfrop0UQ+00kaR0W
	sCk+SSNNsjREsRb0CFR/+JpfjPhB/NTUrgaBIRrIR7yGkRWOX+vgFm6aazrCbxu2CAzR2XLq63J
	1avT+Qg==
X-Google-Smtp-Source: AGHT+IHPseCWZCSIfP9sB93dm0W0MhWEPRlyV1K8nbl8fnIp2K9Y+W+znyK0oA7t66P0/ARXK1K41jlyGz5Z
X-Received: from pjtd4.prod.google.com ([2002:a17:90b:44:b0:2ef:d283:5089])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c8:b0:301:a0e9:66f
 with SMTP id 98e67ed59e1d1-30a3440127emr6430034a91.14.1746035507300; Wed, 30
 Apr 2025 10:51:47 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:50:13 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-26-irogers@google.com>
Subject: [PATCH v2 25/47] perf hisi-ptt: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hisi-ptt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
index e4cc4785f744..978f5781c990 100644
--- a/tools/perf/util/hisi-ptt.c
+++ b/tools/perf/util/hisi-ptt.c
@@ -59,7 +59,7 @@ static void hisi_ptt_dump(struct hisi_ptt *ptt __maybe_unused,
 		      len);
 
 	while (len > 0) {
-		pkt_len = hisi_ptt_pkt_desc(buf, pos, type);
+		pkt_len = hisi_ptt_pkt_desc(buf, (int)pos, type);
 		if (!pkt_len)
 			color_fprintf(stdout, color, " Bad packet!\n");
 
@@ -91,10 +91,10 @@ static int hisi_ptt_process_auxtrace_event(struct perf_session *session,
 	struct hisi_ptt *ptt = container_of(session->auxtrace, struct hisi_ptt,
 					    auxtrace);
 	int fd = perf_data__fd(session->data);
-	int size = event->auxtrace.size;
+	u64 size = event->auxtrace.size;
 	void *data = malloc(size);
 	off_t data_offset;
-	int err;
+	ssize_t err;
 
 	if (!data)
 		return -errno;
@@ -174,7 +174,7 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
 	ptt->session = session;
 	ptt->machine = &session->machines.host; /* No kvm support */
 	ptt->auxtrace_type = auxtrace_info->type;
-	ptt->pmu_type = auxtrace_info->priv[0];
+	ptt->pmu_type = (unsigned int)auxtrace_info->priv[0];
 
 	ptt->auxtrace.process_event = hisi_ptt_process_event;
 	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
-- 
2.49.0.906.g1f30a19c02-goog


