Return-Path: <linux-kernel+bounces-782831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEA6B325D3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E531CE1804
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F3B13EFE3;
	Sat, 23 Aug 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFKzAvbM"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A633991
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909153; cv=none; b=N6aSv9pw+mChJ/VJ7Ib/dyxE0CM1LXVqE7dUk0gwA9KC+woHchZd4XfBpB2ycw4qTZAfjt9TuxeYRqsfBAG8xe7+R5bHRu4H5YTdVWCdr0EaQj/oxFicl6sVBGiKTwfdrW9yF6SikRHjx65aza/TkAXHpQuLy4ElVy8bDjxzJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909153; c=relaxed/simple;
	bh=Dc3cNk44/tRuM2VojGcEzzSNDOPpGyR342/mBE8AYFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oZPZIc+ZmfC238cvQ3DhfsovZhBR1uTiZ+uslO/ghxIBYhIA6Cn+ZLXpxI42QXzK7qZlTKI/JTCss/DHct/p/+lepWy5Sr/HQGc6bnpztnQ4oDpSzjUU6uKdr/ZefBOP8mT96veIFKuZwMeD0RSwBLVhyqrSIfG3JUhX+1q1z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFKzAvbM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2461907278dso22432565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909151; x=1756513951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=AFKzAvbMV3/4suLV56f+kW8wYB1GVQHgU+Ic5MKMWY8F0+Ysh2UEpr0Z4aq994HiHG
         bQQsdVq95iqYzBAcMryylwTYgc/QzQblMpmiDl60qe6qnic7btottAsBe2AK7HIjEpgR
         +RndbXGfCyMYw88aZ3ItGtIM6d7WwmLbFob/RR1tfK05Br6mV52UaTpoQpLBixncaUGM
         WNieaeHSXI5dDV+TmHajrpd2xKqILpHFhTCzEHIEgWZm7Zj9M7jr86XM+BS+t2Xf4axd
         qgOwwz5XCGBlL57kWPNum4OhC8k35QNZiYvHlof/ALUQLVnVPRxCBICDD0iEPwJIJJac
         TGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909151; x=1756513951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=LGDWVuTki6dU3KwTamK2loGhIHn6vFsyylbqnLqzyzd3DHTBpEwmHDa6B7oXHVvAWC
         MoxcbiqZT8Nt/94YHz7aL6eBHyffDcISuOitjzHW0wizWTOz0vODFUVYQKv1rx8xxWZx
         CNFhNuEHGjsykBxn20DKV3MUsb2wlXp+BwNDJfuvc7kIdQwKFcrGQJjcA7ReQgqoOWGo
         akXnq9ALFVSqVoTWa5nmArG3o5DFj2UgU4T1t7B3NMoGR0kdyghV7lIawa0WZxHC1uOn
         9cxGe4DzNTIkltmg48cGayigb1BbcTjfjWGmUG7vP58YRR9mPHf7lqwJxvGRklP64H82
         z7nA==
X-Forwarded-Encrypted: i=1; AJvYcCU95zxoSV7Fp91ZJl1bvdetK77Yu4tLdPtyfOa6XvMRxnCW8V5GDDy4rygDneJT9DF9Y8TeTnW7agv3NI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBq2B0spdx30oD6QRq1u+xB6ygMu2OfrAB6IqZaGyxtvRlPvu
	Kc0UDrl7/RqkHeooLQsQtt5eelcQ3kvfU0Q9Ej8WshKrW8eRj0QfeBzZcwTKfVGUy63+rBQOTaI
	17Dswf/tm9Q==
X-Google-Smtp-Source: AGHT+IHRINNwvyZt4lXIFjt25RkSON9R8J4szK9janrxGyoVx2sOxv0HYEXd2hph/CfK/OG2Ux3zgjtJdVez
X-Received: from plbme5.prod.google.com ([2002:a17:902:fc45:b0:242:fe10:6c5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:243:8f:6db5
 with SMTP id d9443c01a7336-2462ee0baa0mr79386145ad.6.1755909150886; Fri, 22
 Aug 2025 17:32:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:57 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-2-irogers@google.com>
Subject: [PATCH v5 01/19] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.51.0.rc2.233.g662b1ed5c5-goog


