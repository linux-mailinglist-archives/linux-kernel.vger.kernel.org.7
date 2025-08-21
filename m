Return-Path: <linux-kernel+bounces-780313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0451B30050
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AC26037F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA82E090E;
	Thu, 21 Aug 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RQ6cb4Oc"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2359C275AF8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794334; cv=none; b=cJFEwaFEfQNH6sZ8Ql8bpqyi+yLBIb7TZhODTkcLrGsoA5NBCyWX6V2NPH9FU/ZmAnfqDRVZBvg89iVsYKF4Z4q573gAG8p9DI2Klsnukp8MeMcxMJyWBwCX5yk3y+G8TKlScf1Zc2PlT82cMVV/rwF3qt2Ps0sDxcT51hfnQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794334; c=relaxed/simple;
	bh=3YKELvxuxV1PLL+vU0ZK9NzmOjLBL5HGYpAzwG/O+C8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Rv/rBaGrnGq/sIB91MnNJUWkp0CYht2gfd6z0EI3i+5pgzRS6sOZ8VdIvcKXeiZdpjfXA5V6zZeWfVxYFFrQfVcuupKroktWqmp7eRd1mySTDJsfh1Xad9Tby+lMY4Mvfn4Li8FM9B6k7vydwz87q8IkxM4/EzSY7V6fBHw7KqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RQ6cb4Oc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2449b4f316fso10074665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794332; x=1756399132; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBnlfMNnAXJvRMri5tmfNXUyqLPNFnaI1ehQvuqCmqU=;
        b=RQ6cb4OcYVTVdMBxN2oZGQXvq56q+jDOYtBsiXaPozHpckbPSlj3/kubP729gDMIev
         Ph1pOBd2uJqeC3hVwAjGe7QHGvQg//CVVjjoO36/wEjVNCLFaETJpv/88yj7gAMsd+V/
         Tg3M2ydxSp5SuQX4ppBZ+bzaWigpDbvFizISWfldt25PBJPTMa95SO+62Ii3FoALDRNt
         LYRxaEWVkZu2YzrLJiD/9mp/QY0hZgvWHmT9faOEbHhN7pHaeUJ1zZw+PgjxnYNz/ZI3
         89KLApcgmS3aOQL4OtbeR5lsZkJplGrTlSLobVc2acXs+sfn5QioN1/4CVJwA1zXySw/
         gK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794332; x=1756399132;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBnlfMNnAXJvRMri5tmfNXUyqLPNFnaI1ehQvuqCmqU=;
        b=JEGqbo0n/OXrm/BEzJQ/FTJNJ7m56MiR28qMCwbDkvu0KnlTTeJt1uUdwPGIeChLEz
         6W4jWohOjxde/tUS5KLtFpkPz/gtrBmGs+yaWVbog3fC/tZVFaTWIhPjE0bMHeW7nt+Z
         YdPvojqxqAfFTPlAeFwodxXWWdwRXONbySkiG+YYuSopbAOHWTw2L9wbJCqNZf85UCfp
         3cw7yWearat6+yDlsKuNRLbstXrKPDrtWWOYETv/UbylRjyfO9sZyOTud/jjgtVCKWnH
         4X+p6ZJheYdG2PkItelKQYiZ1czLYF5gVKxb4HdN5bLWNokC5XaOhtQaSbQiEUvGPGOR
         KHMA==
X-Forwarded-Encrypted: i=1; AJvYcCXAzDTJxwvInUs3JPlamLeCHoAILok9w1X17TDmlU4pABwlwfM2zXMByIeOtd8M4ucg5pGFc13qM2Sb9/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7Sb2wenGTzu5stJLhC9p7H2exKMIjx4mOJDEVO7VIwYX7k/N
	98YC6q88QMRgYc3kT5tmPbjWhDzvPoHXMI3EoIVuzJsXN9BalDrxFi1ZyBalMEudBhdXm6TajfD
	dr3uXXyFDjg==
X-Google-Smtp-Source: AGHT+IHvI/QHnU0J+1JnVYyGfrBbKwfv6jXDDIgr4Q/WIz4zqzZnImtQy88yiDm7axpXD3oCDs3aSJ3xNyFN
X-Received: from pfbhc8.prod.google.com ([2002:a05:6a00:6508:b0:76e:7044:f5e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a106:b0:238:3f54:78e7
 with SMTP id adf61e73a8af0-24330b219f1mr4841106637.45.1755794332330; Thu, 21
 Aug 2025 09:38:52 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:19 -0700
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821163820.1132977-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-6-irogers@google.com>
Subject: [PATCH v2 5/5] libperf event: Ensure tracing data is multiple of 8 sized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	Blake Jones <blakejones@google.com>, James Clark <james.clark@linaro.org>, 
	Jan Polensky <japo@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf's synthetic-events.c will ensure 8-byte alignment of tracing
data, writing it after a perf_record_header_tracing_data event. Add
padding to struct perf_record_header_tracing_data to make it 16-byte
rather than 12-byte sized.

Fixes: 055c67ed3988 ("perf tools: Move event synthesizing routines to separate .c file")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 6608f1e3701b..aa1e91c97a22 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -291,6 +291,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
-- 
2.51.0.rc1.193.gad69d77794-goog


