Return-Path: <linux-kernel+bounces-836585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C7CBAA190
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D208D7A2BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362921F151C;
	Mon, 29 Sep 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Q2Ssv1V"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390507FBAC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759165570; cv=none; b=nDSV8e0XDwHfZ5VM4u6N6qMFWqM8fiOtzoY2oC5btdysfWs1z8tirRJ5obznDPla1NO18s7gxj91xZUkzTEG6WJJbKgpELE9nglFVG/e548/+wyAVvxGuDJbU7u04ohFvaNibdzsmZ3pgV2c3B6VphE/DFJWZXPSB4TpuiBS9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759165570; c=relaxed/simple;
	bh=iFS1gtjqbfcAPO4iObW65Zff0P/0SdXf0lTHAeX8zMU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=UrzMWkWHNRZZY9p+tlVEJTC4JLFs3IOcB/NTeQwtQwALwckV+/qW3E+U38N1MId8H0+LKh4YQMkxDy5GyN/BgcU5llxNc3aKTRdUpfOtUT0yMEWe6Cyc08UTUefRgvcD80zsOSaDWkGpyY4jWd9Ilen3AvM1+y/PjkbF4ebqkWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Q2Ssv1V; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b550fab38e9so3374569a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759165568; x=1759770368; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=snlLicTLsHAexHJ9k3MVwvQ4rdm1IRza8zeEcjBK9Go=;
        b=1Q2Ssv1VJ6MDC2PgQ4eiEwaDypsbRwfeI7hJbFx/s1riRtmQHop6JLzq280w/6ZjI/
         zKI9AGsCZeksbO+aezJFkjKegHnW0kiu1jMuktt2557iTsXHIzU5AddIEk/WN89KRmtS
         9nuuI1KySqmokcBTI5ZK/PfHRyu818m0R+aeiATU9Iks/Dp3KVuDzw5POr+Htu1YPCex
         5dIqTJlmV2ssVjxCPyTs7MqAzO2HUDcRs6MCI9NEfRFxrpqzQWdM3AMVzZt4n/xEl3dC
         JyNrP32D3+Hv2MAdKO1deMKx2x253azsGm+YuHEwyMLxthVeAkKmgmR9dqhb/0LaW/gx
         MfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759165568; x=1759770368;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=snlLicTLsHAexHJ9k3MVwvQ4rdm1IRza8zeEcjBK9Go=;
        b=O6+D8+8EfWIvIbsHRE2Dfu/uZfGUTOPW8FoEKjZQL6kGb1CYZPKWygKv76j+oJysu1
         WQHylbWcJhZXwoWp79Wogplmqqg6vM1J8aHMFS07UOxlRtaB4MzdZdln7kSmv0jKkx+5
         BUVbqdnvOs6dlKhJfUa2UJyQ1zV3u/PCzp/96oBfrIxDaBqhNxXXGVHvrpojrcHN863G
         FPzG7xxQeIS04tC74qAlKLip3C9bOZ2364r4MQXhm6XctZDPig42HWppF3AcOFHhoePN
         8prD/ix4G6LV8oRimDEv3OmbMEStuDsEAj9VeS/liHJ2OHMAW851AOo3gjodpn8Pnqj9
         sDbw==
X-Forwarded-Encrypted: i=1; AJvYcCWMAryJA5gxJxpFj2E4+dRcep4T2jyaRpCuVXy083ur3W3G+34bF5Lz/Ai6BIpYvGu7w1vauqEu65zcB5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwN7s+c8+rC9RObqKIEvU2VjFfNF9AxLZghdFd1RgO3jjEcVr+
	JgLNar9qumhTs/KzK+lT9McnIAYTYJFwmoo6ZYok9JvO+/v6d7Jn/pvSZCuLX5fguNFPsQPnBYw
	DpI5fu7+gcA==
X-Google-Smtp-Source: AGHT+IFJefW+xPA43YsWiGbUNNt6HwJ/aC/79hyiKRYLADaOxxSns/2jjuTFrkO6U0aAqypinBRYS2DIWNxR
X-Received: from plhw6.prod.google.com ([2002:a17:903:2f46:b0:24c:966a:4a6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:26d:d860:3db1
 with SMTP id d9443c01a7336-27ed49e9100mr201365335ad.24.1759165568591; Mon, 29
 Sep 2025 10:06:08 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:06:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250929170600.59000-1-irogers@google.com>
Subject: [PATCH v1] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, this patch was previously part of:
https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/
but is self contained enough that it can be merged on its own.
---
 tools/perf/Makefile.config | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..7bc2341295c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1181,20 +1181,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   else
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
-
-  ifeq ($(feature-libtracefs), 1)
-    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
-    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
-  endif
 endif
 
 # Among the variables below, these:
-- 
2.51.0.570.gb178f27e6d-goog


