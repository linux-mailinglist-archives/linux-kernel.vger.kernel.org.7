Return-Path: <linux-kernel+bounces-780308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22575B30043
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190EEA28048
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283802DFA5B;
	Thu, 21 Aug 2025 16:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8ENoNUY"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262F8224225
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794310; cv=none; b=nskd/TeJjhzmSjggXTDS4/8k/O5AkKGDhhtogewjEkQu6R1LwjNLQ3qDlsCbiE8e1r+eZ3Lf/GJ/e6VqgRwqmB6pii0M81sVnnIgirZIYLqVnVwzL6d7oTHrTvFFupZBbnHw7OlHCJRY87rDPXqqVgqincOuXcUwOe0H0GOuM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794310; c=relaxed/simple;
	bh=FmSZRX3koaRc5xVjwiZ4Y+oDfi8L1Fq1v8ZCc/U6jCU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=T4qTJ6gblAwpFPVTfDbR1bEM5gZbK6kfeAORzPzyGVdx+k8adADHp7UaZP9uo2TGvhKIvLX7ml4wV8IkoJkC3OYFK33tIFbOZP1Lfx2CY409tuJZJ36veChJGOGP1R2TdLqWotApIqyQjbp2TmR/8RTJy/Yalp05dtDkdWTTI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8ENoNUY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso15105275ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755794308; x=1756399108; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1pc3BsmB+4h6SdwgDkAJflcNWhD+GOK23UuzPvNCfo=;
        b=t8ENoNUYCyvfeTkHktjan8UghEpjFqsHjjwqOyc1lTCusMWQYl5TUB97nByIfHwd2k
         8pygEpEU45RIaAn3SWy4SLqa7cnFh7qCH9fKcmsKvf7Zg4sjIz8t+s8gJwrQlXKtGCzm
         6g8uqWyxd/8EHDCLQE06oH5cfpmCAplyRHX2ywD4g4jusaW3wFFR7E/jTpfjdkJPd3RO
         h+hUhn8G8MBKzq6WEkTTPsq227ChYqRHRxyiQ1TTqxuHLV4ufN4Dl4SO/OYFiJ/rmzGc
         5NXQjaQ5Wo3D6vamw4y+5reEAvwbz9JJfEflA+kdXJcXd0ZsLdMwlISnU8JiYBSkkpCa
         5EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794308; x=1756399108;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1pc3BsmB+4h6SdwgDkAJflcNWhD+GOK23UuzPvNCfo=;
        b=Dmt0SOxf7/XBFD1ry/UNPW5Jmb4wxT8EaIA9IhAWaKeXAlh2puN1evZJqXJWEcuu7E
         5WPJozu5yx1qpZJwPZ9+1j3/5A3QcHW8GEuwAqeURpjq/Tx9MGkKvbGpf8q4PzmExUfd
         8/zjoNDAxE+pbVsyb5vKPO0KES22/8yCb3arfEltpQoap54LRXzzalTHkiQtB1QAV5ui
         LSd3+PXT/N9EKMKQ2jP7Ndp8GUKQsxqjztp6dgK3FFVAEsWpMsatTkS2HHH1bvVqa2XJ
         qlCoJxLl00nCFV5r41n+WqURX6k3bap/yQD9AkQWfsQ8q+C9j/kbB4Kln8kPywFxq1LD
         VaAw==
X-Forwarded-Encrypted: i=1; AJvYcCV+AffHU042o7alZIrOEn5HIMuirHwcCap9xzOCoNe83vPEj/CmM9p8A/+5tseDlnkkoCDcLfgOc98YTes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/u13CFjpP7gKb0LaS6c4hggjgzsvGGc6wgk6i+DLJLa2sA/tC
	L2LfodAF/xX2NRYskN87KUb4ltabPXhFNWprvgjX5xJcXUl2PJ9MlW3j/ogJ55laSay0ltE+10E
	IdW+6F1oX3w==
X-Google-Smtp-Source: AGHT+IFt9Ngz+QPPxTxk9IR/2Mz2ApN9qOA4RZARGm+TgXKmf7I0vyXwgMSWF8q54fYHcE9PdsXwH0d1Xdwr
X-Received: from plge17.prod.google.com ([2002:a17:902:cf51:b0:246:500:6de8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c9c5:b0:240:41a4:96c0
 with SMTP id d9443c01a7336-2462ef21b46mr1155ad.29.1755794308363; Thu, 21 Aug
 2025 09:38:28 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:38:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821163820.1132977-1-irogers@google.com>
Subject: [PATCH v2 0/5] Various fixes around undefined behavior
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

Fix various undefined behavior issues, improve tests to make them
easier to diagnose and add assertions so that problems don't recur.

v2: Add Namhyung's acked-by. Drop container_of assert that ptr !=
    NULL, to simplify the series. The bsearch UB fix was picked up as
    a patch by CT:
    https://lore.kernel.org/r/20250303183646.327510-2-ctshao@google.com
    It seems this patch series fell-through the cracks as v1 was
    sent/acked 9 months ago.

v1: https://lore.kernel.org/lkml/20241213210425.526512-1-irogers@google.com/

Ian Rogers (5):
  perf disasm: Avoid undefined behavior in incrementing NULL
  perf test trace_btf_enum: Skip if permissions are insufficient
  perf evsel: Avoid container_of on a NULL leader
  perf test shell lock_contention: Extra debug diagnostics
  libperf event: Ensure tracing data is multiple of 8 sized

 tools/lib/perf/include/perf/event.h       |  1 +
 tools/perf/tests/shell/lock_contention.sh |  7 ++++++-
 tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
 tools/perf/util/disasm.c                  |  7 +++++--
 tools/perf/util/evsel.c                   |  2 ++
 5 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.51.0.rc1.193.gad69d77794-goog


