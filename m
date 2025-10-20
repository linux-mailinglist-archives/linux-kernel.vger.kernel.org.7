Return-Path: <linux-kernel+bounces-860001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066FFBEF1E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A1A3A77B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384226B756;
	Mon, 20 Oct 2025 02:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Con6+I6T"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40261D6BB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760928367; cv=none; b=NFdclQ+bYOB+4o6C+Sx0JPRN72w56llWDD2wm79mcpeA36hF7+d3wdzVBLFsFSn9UJplD0hDA634t1rflBefct2rm3B8ZHl+H3LIHiequcxRGimCTl/qkMeWrp17GdVHOTOHDIxgH6/vJkI1z0nVtq4ZwXoEOnEfVGJJu8V8bi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760928367; c=relaxed/simple;
	bh=UpRxe00P+c7+vyYZYzkM4qwGhgttHXs/vvOHzwK6E4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gUVYu5eIt9F/qbNQ4deX8NMB23+u27RArR+iZZUr7qkbSe2PZ38hUlJjw+NcEfxBGQAdxZsiC2TyW4UErbGV40ohVTejpEQ08Hu/fFAMHNlwJb1S6M/D/SARsWhAk+CFippLdmjQbeW3PJdhidMoC9UKbckTGn4G1UBpbd7Lkes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Con6+I6T; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-793021f348fso3434742b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760928365; x=1761533165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=Con6+I6TLzKyD4OMGKQPCd7Eo7ikjFqN6sn5MNdVHxLJKfbPGohiz/ylUAWA1ixFW2
         cxAwmvXNfHINVixAxnxqAug1ID9/cGEP7i7SLtEye8IybwxlQIe+I/LySjJSxGsLOR2h
         1OhusVum+58KgBI1gDxDj8neLeVZD1fatCK6oFcly2kV5rnnhGYE6TVo0uEzTS6ZhJbh
         E/hQDY6eZGLXfQHKKBWsmdBDydD3COecfKPA1A2ZOBXCr5g8Yl/oUagEaYlW42TSLnfk
         NWgnCc+3hu5pW4oTO08J7CCOjhJlsqZHISQn+4T64+/tz68DUvObQ6W+JF2KSoHPoVhJ
         FSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760928365; x=1761533165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbkL5b+OBi8ON0V+7ODZODiLlH2T27rLkYqjonV3JTU=;
        b=JeKf4KBUW04vjOlt7RjwkGCDxhxgB/WDyzq1J1qFA9gLMIkb/D/VW5WqRsSKClE5cz
         NKMwEfI/fXfp+t5ZhGRkB6wsIv2uNhaCOq+XzSgI69lCtIhJB4yk3pcjv4SQVqHO9tfZ
         6wKgGx9au99FPbW9S4Js2uoYnIN1maP+jfS/bV/mUzBxpBIMjMX1RfuG9jUAcTCqPjYd
         90pGxPSg7lgds6V+WPgLdDxRxVRXrIrhl2E9a4jjyQXD6aoVcLX3ARVSFHtzIExmNqZU
         6MjtojOrW2adwA0SNipnD0umyfFi7370O3BmYlJD7Yq5+J41odktcLr4Uu6KTYMCe6tv
         xGaA==
X-Forwarded-Encrypted: i=1; AJvYcCVj0I1THTPdPgHHbjR49hSAT2fcA6o7AAYkAjErJgwraQqi5c35vxwYnbMUdmQrvT9ktUY2V1Bgbo6fgD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLXFkigh/TEi+q4tc1LCMLE7iy1ubFiFsX/wEUDljiD+kd7Xzm
	n9LtzyJjHfFVLAM2/vJb//rUcaLMMHQty6I6q9fSMYXLm/R/7gDxhHQt
X-Gm-Gg: ASbGnctodcNvsAndCKU182bbzD7MYiU8S2pmP4SsjZ+HD30ol2YK/CDsNvlsWGQfdur
	vw8Dq0FF+F5isIEGqJpseLvbVFxk8bjxwDev5gwZ7seuRK3m18Mufv69S4G6oyAJJdm3l7YByZv
	4gshNmZnUtXo7Be64rLS9D5pJqrL9ED4M7u1FcmH7C87tW1zdEVz4G7UTbnY97U6Y/4/+5KiFfa
	vAA50jLYybwcFBMdysjDZBhUe52eBjPBPa5vKTG2E3fMELXyCCkEOC4Hk7EkxmcFKVn2rto8RsC
	wk88aUUFfpGYGUcfFkOFjBnvIMA3qeK0Ivrwa8SRPGR3Kc7l1OtpXkVDYCaCm1F/iTKbBTFqflo
	46dMECC/671Zzhu47dN/tbPgbez4JHzzwF0jAdhzrHa3P9f+QBjzO5EoFkZtjkBHMaUVmQYTR0z
	0vPiWKE7Nn
X-Google-Smtp-Source: AGHT+IGScCN8jrW6blCf1a5d5iFZipyC+xf9/0KOw00npZ7H8R0ddDTd3FLRDcxSXXxl0i+leZXodA==
X-Received: by 2002:a05:6a00:3696:b0:784:27cb:a2df with SMTP id d2e1a72fcca58-7a220a61ac4mr12878664b3a.1.1760928365026;
        Sun, 19 Oct 2025 19:46:05 -0700 (PDT)
Received: from HUC.. ([210.57.99.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301230a1sm6761277b3a.71.2025.10.19.19.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:46:04 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: namhyung@kernel.org
Cc: leo.yan@arm.com,
	irogers@google.com,
	hupu.gm@gmail.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
Date: Mon, 20 Oct 2025 10:45:31 +0800
Message-ID: <20251020024531.6900-1-hupu.gm@gmail.com>
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


