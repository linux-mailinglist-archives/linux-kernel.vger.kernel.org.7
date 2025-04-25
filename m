Return-Path: <linux-kernel+bounces-621124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F03A9D446
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663A84C1AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788622A4D6;
	Fri, 25 Apr 2025 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rT+VduVM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE81227E82
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617228; cv=none; b=QgCsDLKjOcWoXaeNP8PmZ9CJseTgCcPQ/P1zrF68cIhgGvTtzVkJBRd2185zNz0NkRZslbzjdv2XV2fnf3bnNR4JtBW2o53151VMTF/N2dPNvSP0Tm+zGZ+iAXO14cIaDZIVGT1mTOHoUWyTHMsNevB6uM+HGI8hO/zVqX8DkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617228; c=relaxed/simple;
	bh=NW04OdUCBUXB0XwIkvNApQLAwj8ekPQOiMfdRIxQWTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Pn+23usexM1sqjxLHZiKhPtc9drdvjM32XCWhRH6tjIpJx96i4xLSlWCnnXmA/8XrCBwdlvbI/BnvTh2XOO2YV49QaebBe9iozAvqCIiEdQhfFHTn6ea6JoAFyguzl6rnjvNszpQP/cPmX+bKjyaeD7LtHWmD6+Jie7C34PmaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rT+VduVM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso2828460a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617226; x=1746222026; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBRzvY9/oqGcvbYk2oQ/5pWM3xndZw3DROLAFfIr7HU=;
        b=rT+VduVMIASn2Mtjy8X+n8ZMTqllJQjpATimXQDfB/2Wb9SAgPUUglsncOp9P3yGWz
         f40Rzv4CzbE0NGXzgepuXt8Efb0oebzbmtgtSdR5aTOIusuFsfd6NYxBzoDq1/dwucBC
         AO6c/xDdXKEQ3aXXpmZffBEp/I3m6yPAQ2pVK2atwh52Orj3caTe5x0gWRjz9geahNEw
         UslxmGtoClL0vK6G6H/Ae71Ci1mmGAq398betV3yc0o2BCAFsTCaypXa06DSLTCDyQm/
         +f454oe6+eGQMH/heHqY6wROMidhMhhHwnHK97m/di+JnlAVdw3RFX8QSkL8s4C0UbzH
         Xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617226; x=1746222026;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBRzvY9/oqGcvbYk2oQ/5pWM3xndZw3DROLAFfIr7HU=;
        b=ZYvUqs/yqICnUyawohn9FyjOZHsRXqHL6UQlsS43y2qDLoH2IKFOjhfK7yL3xM455Q
         /LmUN8YF848RdRJfZhUc63cuEc6ovBIbLBG8u2g40o8pHtvJrUBzfa5uJqnPc36CPQcv
         TsDes0K/frYKDVLxn/V/6iskVDMLPyKScUrMCNhlxnB+rI2dXSe1AdR9GJmFf1BUZnt1
         E5LU/t/pBkoyOnEE8WEMq6TE3SMtS6/7GNmmUwRa4prrOq2r4GZQzSHOaCE7zjtF6lip
         ZQCkAvZz7qCvzTOXj4LCNPUK4M+p3HJu28qbZRTYi30DsBi1Zbl/hX78kWiSG1eTvSGb
         m+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVKGHJMoKHtbAn8Mxan6Xe4LUk18bmdhloLLaNLAUS1NZcxNWqz4lhVbq4v2obW5mEdq6ChT57haba68iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9Ev/0z5WYAQEkTvFG24tTIz8op5oCvHDSmXKIa89JF07zh+M
	MHyRrDRYGqUqwnVArC23TOQGVmC9PRQu3tU/21gE/JO4LoVsaP51gjsMqBrN+fJQHU2SIE0q/ax
	WRAttwA==
X-Google-Smtp-Source: AGHT+IGGlxlrXc4zeoAxvuCibveLAo4hf2bW6wySquqYWmKShkqKk+8FF4aoVv7ok9S5AQIRvxzmpRZUU6A2
X-Received: from pjbpa14.prod.google.com ([2002:a17:90b:264e:b0:2ef:95f4:4619])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5104:b0:2ff:53d6:2b82
 with SMTP id 98e67ed59e1d1-309ee3f9ac3mr11267255a91.11.1745617226120; Fri, 25
 Apr 2025 14:40:26 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:00 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-3-irogers@google.com>
Subject: [PATCH v3 02/10] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow parse_uid to be called without a struct target. Rather than have
two errors, remove TARGET_ERRNO__USER_NOT_FOUND and use
TARGET_ERRNO__INVALID_UID as the handling is identical.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.c | 22 ++++++++++++----------
 tools/perf/util/target.h |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 0f383418e3df..f3ad59ccfa99 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -94,15 +94,13 @@ enum target_errno target__validate(struct target *target)
 	return ret;
 }
 
-enum target_errno target__parse_uid(struct target *target)
+uid_t parse_uid(const char *str)
 {
 	struct passwd pwd, *result;
 	char buf[1024];
-	const char *str = target->uid_str;
 
-	target->uid = UINT_MAX;
 	if (str == NULL)
-		return TARGET_ERRNO__SUCCESS;
+		return UINT_MAX;
 
 	/* Try user name first */
 	getpwnam_r(str, &pwd, buf, sizeof(buf), &result);
@@ -115,16 +113,22 @@ enum target_errno target__parse_uid(struct target *target)
 		int uid = strtol(str, &endptr, 10);
 
 		if (*endptr != '\0')
-			return TARGET_ERRNO__INVALID_UID;
+			return UINT_MAX;
 
 		getpwuid_r(uid, &pwd, buf, sizeof(buf), &result);
 
 		if (result == NULL)
-			return TARGET_ERRNO__USER_NOT_FOUND;
+			return UINT_MAX;
 	}
 
-	target->uid = result->pw_uid;
-	return TARGET_ERRNO__SUCCESS;
+	return result->pw_uid;
+}
+
+enum target_errno target__parse_uid(struct target *target)
+{
+	target->uid = parse_uid(target->uid_str);
+
+	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
 }
 
 /*
@@ -142,7 +146,6 @@ static const char *target__error_str[] = {
 	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
 	"Invalid User: %s",
-	"Problems obtaining information for user %s",
 };
 
 int target__strerror(struct target *target, int errnum,
@@ -171,7 +174,6 @@ int target__strerror(struct target *target, int errnum,
 		break;
 
 	case TARGET_ERRNO__INVALID_UID:
-	case TARGET_ERRNO__USER_NOT_FOUND:
 		snprintf(buf, buflen, msg, target->uid_str);
 		break;
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 2ee2cc30340f..e082bda990fb 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -48,12 +48,13 @@ enum target_errno {
 
 	/* for target__parse_uid() */
 	TARGET_ERRNO__INVALID_UID,
-	TARGET_ERRNO__USER_NOT_FOUND,
 
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
+
+uid_t parse_uid(const char *str);
 enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
-- 
2.49.0.850.g28803427d3-goog


