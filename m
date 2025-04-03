Return-Path: <linux-kernel+bounces-587783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F87A7B04C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A28808F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2E71F37CE;
	Thu,  3 Apr 2025 20:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrr93mPD"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A001F30DD
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711890; cv=none; b=i4Ea5YCI/gJ5lNoIrfKuCcozlpmIVNjQNvsTx3WLOPpiEd+eohO5vW1LdfsnYJcdI+sANxQag8TCkD6UzvLsEZXlfnYbcmAMPDH3P2aMnve8pHC36VHqXm51BzGAyPQPNJa126qela7TjsqxirrD0RkK63RVKEEkYIJ3hXw1vcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711890; c=relaxed/simple;
	bh=bJfB6u7Ba5L05AgA9wAe9Ds8TZ0wWwO/HWK+I789ioI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZJgseJoV0yV1B8Umo50QTRLYxGHpgRCm0Ci2E/rWW9oqQlFXHITe7+MuWaE2DDybto0jb3Oy7CVsa69n28Z3sTgLtmOrAvRC/XRyR16D16lhafqn0r0hbAl5yQM7qrqTTE3B+WVTk0xY+INmYlnAP2I4R0dn3/D5vE0z7yNzgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrr93mPD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2254e500a73so10705045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743711888; x=1744316688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRkNhQokk2FGmI6E6ywUdIUe2Ks9OEjNqCR63wcowWw=;
        b=rrr93mPDiYC+NShie8K/XWv51CVFm3jOsIGquRG8S/qciq1slsk7UmvMA8/5Geqol2
         YCO2Itn3fceJeLKSDbgXPSPK88cOUL0wPib87URBvKjYuYX0SDsfF7eevd9Xqza+tK3N
         iXPx7VZH82JHfuokMnpioYNoJ/tSDuOUZTLtbXR4Sr5ZyqL3uESs2iZm+URTcu7ibNAh
         Li6y6/b1kFuiMY+2h15o3LBBbhHsdaJSdvaCuA7T5TwB04HrIoMgrQxFokjsM8Go8KuP
         1htXrIrA/lJTysHzRdgiKcHWquJJjvK21elxv4lCMj7hI90T+G9dNT8/CrXI9PpNLq/B
         YqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743711888; x=1744316688;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRkNhQokk2FGmI6E6ywUdIUe2Ks9OEjNqCR63wcowWw=;
        b=bM2vS1ALObxDq1995Ur9NtA0b7mtrzav1tXAWzchQsCWHEFdA40HCCCivzsquu/a9w
         d9+Df/5fQpfSaSDIwRnCMXY65mJe7ZcVTmXDzCG1GSG0reQoEC/c/TFJAbPMfXrQR/uW
         HJ6PcdKhIoJ7Iexv4oFjsd2V8sFLJE1tnvEx2u+X/sorecHU6POEy2mfc0LkN0riOeqy
         +eM5F4parGT1qzXV+6Y8BN9fDDKHY+PM5ZjxHm+9FHG96yqf7SB6H1PzHKGbmM3IZfQd
         7mSfoCc8VdvOoeItpGKNyoGxKf6Id6Aq12qZ4RBoBFpxWtDBnSRz/LPZkEpEx9FSLJnr
         I2fA==
X-Forwarded-Encrypted: i=1; AJvYcCWAs0ph8DlZWzjN/fCbxVZV4kPaFzmSitiDcbbGPt3OhOLHH6uP3cVnAaPK9udOH0jyjyCFpGeZtc7wEC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYd/xYH4gdhaozcTFlSUCcKq1OWt6mx6452dhcXmwKDSdx+Mpu
	zEQjFvh4DzzQTINViGu6BtxXGuVI1yciaIvJw/dNkUDNhatPrhNtNTxJSNS4Qel3WO5eykROnzb
	mlJsqow==
X-Google-Smtp-Source: AGHT+IHWDO/5M2fCSVHvmzRMrnuToohUfpuJh+UsPsfUghfHJeFXsbikUT0hXKvJp3jc7nt+shYR87GdY9k7
X-Received: from plri2.prod.google.com ([2002:a17:903:32c2:b0:220:efca:379c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c9:b0:220:ca39:d453
 with SMTP id d9443c01a7336-22a8a05e77amr5995565ad.17.1743711888439; Thu, 03
 Apr 2025 13:24:48 -0700 (PDT)
Date: Thu,  3 Apr 2025 13:24:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403202439.57791-1-irogers@google.com>
Subject: [PATCH v3 0/4] Add support for a DRM tool like PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

DRM clients expose information through usage stats as documented in
Documentation/gpu/drm-usage-stats.rst (available online at
https://docs.kernel.org/gpu/drm-usage-stats.html). Add a tool like
PMU, similar to the hwmon PMU, that exposes DRM information.

v3: Minor tweak to the test so the skip (exit 2) doesn't trigger the
    trap cleanup.

v2: Add support to only scan hwmon and drm PMUs if the event or PMU
wildcard can match. Add a test as requested by Namhyung. Add file
comments.

v1:
https://lore.kernel.org/lkml/20250211071727.364389-1-irogers@google.com/

Ian Rogers (4):
  perf parse-events: Avoid scanning PMUs that can't contain events
  perf parse-events: Avoid scanning PMUs that can't match a wildcard
  perf drm_pmu: Add a tool like PMU to expose DRM information
  perf tests: Add a DRM PMU test

 tools/perf/tests/shell/drm_pmu.sh |  78 ++++
 tools/perf/util/Build             |   1 +
 tools/perf/util/drm_pmu.c         | 689 ++++++++++++++++++++++++++++++
 tools/perf/util/drm_pmu.h         |  39 ++
 tools/perf/util/evsel.c           |   9 +
 tools/perf/util/parse-events.c    |  30 +-
 tools/perf/util/pmu.c             |  15 +
 tools/perf/util/pmu.h             |   4 +-
 tools/perf/util/pmus.c            | 101 ++++-
 tools/perf/util/pmus.h            |   2 +
 10 files changed, 952 insertions(+), 16 deletions(-)
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh
 create mode 100644 tools/perf/util/drm_pmu.c
 create mode 100644 tools/perf/util/drm_pmu.h

-- 
2.49.0.504.g3bcea36a83-goog


