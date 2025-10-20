Return-Path: <linux-kernel+bounces-859996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B43AFBEF1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61251348360
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9829B775;
	Mon, 20 Oct 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dzu7zjRg"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01329AB1D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928061; cv=none; b=LAGzBHRiDXPMhwlCgrywJfTbfZmhzjY+pTZWvBEQWCBA5LVLzxlnI7Ti8OLEaLqQ1iqi7aR/SdPuY68DvqCDqbMvFXT/9VnPxFrfHfGKwALTzOaXcPdTNp6aPOSe8qNEA9Oe74fl9zbr967QTW/p/7/vgnxFfpkkzC3yu+bJHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928061; c=relaxed/simple;
	bh=UpRxe00P+c7+vyYZYzkM4qwGhgttHXs/vvOHzwK6E4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKN/yvy+JMcUWWP0XXIshhZ+tH8s5LfdpRcZVAq4nhEyCJ0keolINH0EIdglHtNYuJjk74OPdP8XoHsowNwy0I6s73x8Fc1VOHyb21vB3m9clbl/BWvYEud7/NR/9GGoL/qFRpkefQEReAwDh9QMxvV/FA2g/8QdHifeGeSYjio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dzu7zjRg; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3307de086d8so3150243a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760928060; x=1761532860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=Dzu7zjRgYaeJiSV4kL2RQgeNMYs9lBfL34V/gtT+z8DEVd+Vey1tETnopzNUO164hj
         ZWfqkq2NifdhFBmMqkt8b2MwJxRj/qRVc8DWiZ3mHpXG/s7VM4/oCxz0mokyptBW0VaJ
         w3dQHr8q9kzmAtuoJIP/YmhpsxD1CtH6xigLmgIdtmoqogS+LN2isa9yR88SJWZWHoPY
         77adrQ8S0cCuQOHex7JmxUbxHXTLabVuTuQqAX3t4tp+ib/Y/EB9xuIasU6h/Ix1C3wp
         95niGEKjiJ4KXbeHfpnQ84qSAcoHr0yXP06DC7QMoeJID/Gzrw5x1kDyqy7xn9nsMIrZ
         76FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928060; x=1761532860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=qVhHKhJu7PW7aGR0Jz3/WddaojrKmKQwTYa0XVyGsX5QSA97ALxMaM3Uz0CBEo13XB
         TmHHoVylqUV2cW0KQt6AO58aKXBmKgiSFZUgtrLH9hfu516K7HfOiiItdMFHlzHdK3Ba
         uGXMxkmaVZiVQAZK6CfpZIVH8vlRzkbc/Vv6GXmBWPWHcasOQJlwrFHmh/zDZTDK3gMn
         kR22YoKD7HT5aSjddY+RbSRvs4w6VKbJVABLS7pmj67cv7HHmy32UXQKewoI3PooiGeu
         03ZurGBzA4sb5P4cUkCrh2v/Tn0QsrX5g9WmkS4FIL7FQaQNoKRUOtrJ/u2PazSAQ7ce
         N5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHe2fdh8Rqbb22KtgEsuepuyqxqKHROSNE3vpX5o4TxAFOi302w2F0RW47K31vmO/cLjMlTyw6rj1GC0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiT/xt5XR5gu9PuxtDlluY5rTuzdO+qTnKv2E172yoxjLHLGj
	nY66tCx91WuyPjuCsJWIFtF5QLumim1OgZn3dXOpYBF0XKSDIGgs+1W+
X-Gm-Gg: ASbGncsrneYRXLRjPtp2Tkibbp87nu47EfS/woYSB7o7bzlCWF9+xh/IhqHgeIYk4/S
	J3yE5X5IMSg8QJic4RQ80Kii4hD6XJG87QOcw1N6VOoIl5g/E0/r6QQYaBSzD2vXsFZOrW5ewP9
	pz2DvwyteEZRFii34OI2WdLIK3hJ43WwexKnDY+OxMHO0E/mBKjcdTfofO8s4GWFUTlpOfTg6Sk
	anv5NrNO+j0hWTwQb848CFJYAApivLbr9v/1ZX3puOZg1nLIMgmZpB9zcFViDueS5aGndpDeUQ+
	4gWpVL7Zli3BcuXNfguUpO+bH2nrzTJ8Yy3aP1QCdIar55BYunOciqYZAvcoJiABgs3BrGS5z6P
	fjb8YcVr2qzqKiHVHCjkqZHEkySD2xYpfj9IJA1gxfte1qUTkrbvzaMqCYQMPSkoMeMXQmNra6p
	dzPKYr/baf
X-Google-Smtp-Source: AGHT+IFt0GDoRx9gJXuSFEkLE1HjOlhETzFdQe+hDtnu+sHRGQW2KotFg7OOFFY+3KrIiMsrBK4qyA==
X-Received: by 2002:a17:90b:388a:b0:32e:b36b:3711 with SMTP id 98e67ed59e1d1-33bcf90c00emr15314358a91.28.1760928059800;
        Sun, 19 Oct 2025 19:40:59 -0700 (PDT)
Received: from HUC.. ([210.57.99.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de30555sm6603334a91.12.2025.10.19.19.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:40:59 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: hupu.gm@gmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	justinstitt@google.com,
	leo.yan@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
Date: Mon, 20 Oct 2025 10:40:49 +0800
Message-ID: <20251020024049.6877-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling perf with BPF enabled, Clang is invoked during the
build. Some cross-compilation environments require additional compiler
options, such as `--sysroot` or custom include paths.

This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BPF
skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
allowing extra Clang flags to be set without modifying Makefile.perf
directly.

Example usage:
    EXTRA_BPF_FLAGS="--sysroot=$SYSROOT"
    make perf ARCH="$ARCH" EXTRA_BPF_FLAGS="$EXTRA_BPF_FLAGS"

Change history:
  v2:
    - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
    - Update commit message
  v1:
    - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..f1f2efdbab8c 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,6 +1249,11 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
+# Allow users to specify additional Clang options (e.g. --sysroot)
+# when cross-compiling BPF skeletons, enabling more flexible
+# build configurations.
+CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0


