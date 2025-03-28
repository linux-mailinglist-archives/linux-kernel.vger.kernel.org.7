Return-Path: <linux-kernel+bounces-580510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA8A752BC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906023B2119
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECA31EF391;
	Fri, 28 Mar 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCwZdV6Q"
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84A186294
	for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743202947; cv=none; b=hECQtnYUXuJQAnoKECvfxZv2Yosxu6W7AWE3B7AGu1K6HDb8621aekjsm5pscueehU59CrnGoPfUPQVWCi1CQKrvgaUod3oX3Qsq8FLwPnsB+BcJOswU4yAHXkhxYl3RBCZ+MnfRMjxIUXY3GOuPh9GT+4/XGgjYt9ceqeA7SZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743202947; c=relaxed/simple;
	bh=ZN6wVVCMEhcmzcXonAZh+haaH/EN1Xdf3JTE+MN9W0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I0+oKN7Y+vBuNydt9MyCy8yI/sZsmGEHsgQ2mEHWvKWQG/W/ZUTJOLaj/r3DiXpJLljMYf1NtF0w6YldJwJonORbn4wraJCd03xr83bDFl8rCnKFVOM8OlRO7vK/sww98XOlkqhTo3Pfx1qy5Rjt0YQYARxK6qEfIYFeVZw4th8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCwZdV6Q; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c72e6e51ceso709672fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Mar 2025 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743202945; x=1743807745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nJtcLwv+MoOAs6aXYFtFBeMD1903rPNKE/DweqmvEKw=;
        b=fCwZdV6QEms/Uh/sK+gKAaMMo9euaguJXyUz7xoeXgtPwpz51DH2tZlFSOSrUqJsgu
         7t2+OozJMq3xP6b9cs9go/06s0Ks/tDbPMDHwGjcyWHQDyN//lAYz3gjgOi7BDGz48KK
         HZF+pj+xBUNBDNXuTQWreqjORfsDC/iogmc69N8I8LttwtKn6+KCjwF94eE5RfhXKH27
         df0kW2Lj9o6Z/cJHxE3qMeDnCYH/sCxal6Am+tHUgUAyw5ghsiSsEyfDnJTJGnGMZ382
         zaNj7SU5AxSLNVcTXvKU9NSZriF/AW96WRKtHQiOUceS9p55mI8YOxQMDqmG7ibMQgOp
         s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743202945; x=1743807745;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJtcLwv+MoOAs6aXYFtFBeMD1903rPNKE/DweqmvEKw=;
        b=LIbgLGo9TUYMJXdQOu4cm39FKPl8YOCTfAaYQkdRQkEq23B9HYB3608XuaaGpnnX2T
         stjlrxH4tMnKk8Jh0PjBw71Udsk0f72mu3e0xa3dCfZXAdj2CJdTLVmHc4IbtMu1aB/Y
         +3D8QfaJTH/6H9HXHESK7GWiSZOWydCqp+pfbyEk20x5NcGNQ+JFZowwXN29D7hv6flz
         mxD5p7F17lkjsAaYrY2fOa+PgIT8w6S3zrgoRnmTLKgcd0MSF8zrPmP5uC6OlFQmzH1J
         92qlra3UYMF5oHfXhHPySWGfcE1taVk8xwwASmqjRH/2wPdL8cP6WjUVXqZnhivCNdf4
         4m9g==
X-Gm-Message-State: AOJu0YwsYkZGmn19cJclnbD48E3OGFXz/f9SNxNQPkrE9LBVQ82CpJtx
	XQECWjdqZWEsNwDwL3Dix4+P4FC159Tghy+S2OORC9p11p0vvb4kCHSwgyYYXOWJqXOLcceJxK8
	7uG0Fo8/rXcKlOz6Dc43PhJGYsdUi3aP/Y4hpi0XeJuhtSdSAKZSJugNkY5uzO7TzdG0rcphXDi
	wGIvKWOB980rgDiqvi9GZtPIS92w40RL+wrJDQuq0t
X-Google-Smtp-Source: AGHT+IFpLYIxrftQ/0+0eBQlsDTFykw3trImfr8UrBCqDF49M09kMBcewWjMvKsU0DvJa2TVW7yllpVk8Zs=
X-Received: from oabpl2.prod.google.com ([2002:a05:6870:4e02:b0:2ba:487b:683e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:41d3:b0:2c2:416e:cf43
 with SMTP id 586e51a60fabf-2cbcf4e87e9mr595378fac.12.1743202944879; Fri, 28
 Mar 2025 16:02:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 16:01:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328230219.826726-1-ctshao@google.com>
Subject: [PATCH v1] perf report: Skip unsupported new event types
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dvyukov@google.com, ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`perf report` currently halts with an error when encountering
unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
This patch modifies the behavior to skip these samples and continue
processing the remaining events.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..d58fc1ed2fdf 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1639,8 +1639,13 @@ static s64 perf_session__process_event(struct perf_session *session,
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(evlist));
 
-	if (event->header.type >= PERF_RECORD_HEADER_MAX)
-		return -EINVAL;
+	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
+		/* This perf is outdated and does not support the latest event type. */
+		ui__warning("Unsupported type %u, please considering update perf.\n",
+			    event->header.type);
+		/* Skip the supported event by returning its size. */
+		return event->header.size;
+	}
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-- 
2.49.0.472.ge94155a9ec-goog


