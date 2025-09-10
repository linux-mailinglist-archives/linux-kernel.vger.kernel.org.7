Return-Path: <linux-kernel+bounces-810264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86ACB517F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624AA5E3A57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70021DE8AE;
	Wed, 10 Sep 2025 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNk7Jbhv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CA26CE2F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511043; cv=none; b=YxIlnyKUFUgrLo+5uhcgg7Jw3K0+ZbjACINvx8ZjXOYyyo4L1rrBl1YR2A+GFY+n1NUsMAqJRGP4H03zie2IAAEdm1jvovgb9ki40UJyD9pnf8vU8FCPp3zdyZ3G2yEYfW0SFt/ZGCmsaMJJJGRzBHuiT6jHdHUnzri2ElSVuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511043; c=relaxed/simple;
	bh=PVnwbE6gLLGh12OScUU9cLIZPNCEuIOX/UvoSZfZJpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fsC4EdEIYI0nPBmK9AKukIb9OT3awkIkGR1iEj6VVJ4HoiJqt/oEpwUfJje1U4VOLajz6LrejItxWlqAzng/2IWXilrJMzr8lNFlnBx9/o2LpEWJ0fItNfw2WfiSiiX8BW0+Jt4xixsdSRnD32LcLAA6EDv6P4Lz5jk4Y76VEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNk7Jbhv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so29585275e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757511039; x=1758115839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s4FHAHnzfXCBUqHTlXFdb8ZtCYn5mJo7RSwkcTXI0IA=;
        b=lNk7JbhvhtszYQgTYUlG6j3EgOgwoXAMWzMppBBf3emvn/6ASW73GBalcVavaVUF/+
         EWKkmjjMwbGsb+IgMZ8SQ/CyY9ur5cRYFlHQ3Ye3dNSpK9zrOuTN4uq+fTS+Cn7hpqih
         h9GmefJOCI4iAAjxiFTFUFz2uBx+0Y4RDGB+iaSSHYHuWlMvCmgPAK8NU5lWZRb1UBmn
         m0OwVUiJPmMVsMz0uXaSN7XjtOqT7pjZLIJXzx1OWVR2gjdejhklV4G5BWocy1aJSqFt
         yNoBhvwmq5jCh5Ixc4gkt/wjXXC06RXymSfJ3JMVAG4XwhXF7W87dN1zsuL+z47DuRRW
         ZU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757511039; x=1758115839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4FHAHnzfXCBUqHTlXFdb8ZtCYn5mJo7RSwkcTXI0IA=;
        b=fRjAysMpAkZn9CSDl8Iu1akt6UjBK/5odHnZwZ1powSa02STuFsshIskxSeyNYeGuM
         pcfRqqaTNY82EZgxgknDMkfAl/6M99LmfSrp+tShI6fSxDrUig0NcKSFwP957bj5cNYI
         0vfQLf3Ou2vswDTZll52UHw2DoMkAjswBf3fDBZ1/mtMynpfjZkP3SQtc5Q8xmMLlNzT
         2vJqXnu81qnzWky8j83xt5gHJVEfyojd1kfKVfV7T1UwHyStyNpNvc9y4zjKlEe5abDd
         7npDdfq+Qs8/zc0Ol2xI5jVPVZvLEsltV0txGJ0vGxM0hH3RqSgPN6n6WCkX/dEZDdL1
         JcMw==
X-Gm-Message-State: AOJu0YxNgkMPu+nETmv+z4ipl5K2Xb6ygvm2LEvRsmIHmlTKCaOf/edx
	IPc0+vIdaDrwUYphvKDQd9jeVIsEcIDI9zHBedIJ/7KO4OM4VlgIiadq7n02nSlY3JA=
X-Gm-Gg: ASbGncs1X+O7K0Z6vHMvCkJ9vSsTD9E36GzREv0PgGL9hQl85xW3LfaE/GV3KXlreC4
	Ml/W6kATB0cyRm/z/xWdUwclCfS0xD8/8WXgmB/7s5uAuWH0NROw+iYCwUnttkfoi8PRjgp5dVk
	Xn+Tz2UJNRjvO3mTFW/kgyQgHXMlERi/DK1VDMIGfIEz1UD5p0TU1ap7fawyzw3vU08rvVAjcqg
	+2gmnVnWh/9T7N6lRQbvop5nAMNo7RVnCqamIkd5kmpHHbiThU+2FQTSrJEfdFMASOzsZjzJksK
	5Ts/nFPhsdccnl9e/xYZjFsFnzCLmF+3mh1UhS93ABsMbZzdhfZdOnmzgv15ziHO89Awz/VBVCn
	3nVy0T6ov6s2apz+NbtgoFTUATXRcgoIAogQih+m5CA==
X-Google-Smtp-Source: AGHT+IGbW9nuEQquGFBk6D25fa0JMrDH8WQ0jztEhqtb+20/B62tKDDcVkTJj3xKuK4iohaBIXg7pg==
X-Received: by 2002:a05:600c:468e:b0:45d:da4a:8dd0 with SMTP id 5b1f17b1804b1-45de6b386abmr89000025e9.27.1757511039212;
        Wed, 10 Sep 2025 06:30:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm30387015e9.3.2025.09.10.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:30:38 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 10 Sep 2025 14:30:11 +0100
Subject: [PATCH 1/2] tools headers: Remove unused kvm_perf.h copies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-james-tools-header-cleanup-v1-1-7ae4bedc99e0@linaro.org>
References: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
In-Reply-To: <20250910-james-tools-header-cleanup-v1-0-7ae4bedc99e0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

These have been unused since commit 162607ea20fa ("perf kvm/{x86,s390}:
Remove dependency on uapi/kvm_perf.h") in favour of dynamic discovery.
Remove the unused headers to reduce consistency checking overhead and
noise.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/arch/s390/include/uapi/asm/kvm_perf.h | 22 ----------------------
 tools/arch/x86/include/uapi/asm/kvm_perf.h  | 17 -----------------
 tools/perf/check-headers.sh                 |  2 --
 3 files changed, 41 deletions(-)

diff --git a/tools/arch/s390/include/uapi/asm/kvm_perf.h b/tools/arch/s390/include/uapi/asm/kvm_perf.h
deleted file mode 100644
index 84606b8cc49e4..0000000000000
--- a/tools/arch/s390/include/uapi/asm/kvm_perf.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Definitions for perf-kvm on s390
- *
- * Copyright 2014 IBM Corp.
- * Author(s): Alexander Yarygin <yarygin@linux.vnet.ibm.com>
- */
-
-#ifndef __LINUX_KVM_PERF_S390_H
-#define __LINUX_KVM_PERF_S390_H
-
-#include <asm/sie.h>
-
-#define DECODE_STR_LEN 40
-
-#define VCPU_ID "id"
-
-#define KVM_ENTRY_TRACE "kvm:kvm_s390_sie_enter"
-#define KVM_EXIT_TRACE "kvm:kvm_s390_sie_exit"
-#define KVM_EXIT_REASON "icptcode"
-
-#endif
diff --git a/tools/arch/x86/include/uapi/asm/kvm_perf.h b/tools/arch/x86/include/uapi/asm/kvm_perf.h
deleted file mode 100644
index 125cf5cdf6c5f..0000000000000
--- a/tools/arch/x86/include/uapi/asm/kvm_perf.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_X86_KVM_PERF_H
-#define _ASM_X86_KVM_PERF_H
-
-#include <asm/svm.h>
-#include <asm/vmx.h>
-#include <asm/kvm.h>
-
-#define DECODE_STR_LEN 20
-
-#define VCPU_ID "vcpu_id"
-
-#define KVM_ENTRY_TRACE "kvm:kvm_entry"
-#define KVM_EXIT_TRACE "kvm:kvm_exit"
-#define KVM_EXIT_REASON "exit_reason"
-
-#endif /* _ASM_X86_KVM_PERF_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index be519c433ce47..6eacc02fbb1b3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -40,13 +40,11 @@ declare -a FILES=(
   "arch/s390/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/perf_regs.h"
   "arch/x86/include/uapi/asm/kvm.h"
-  "arch/x86/include/uapi/asm/kvm_perf.h"
   "arch/x86/include/uapi/asm/svm.h"
   "arch/x86/include/uapi/asm/unistd.h"
   "arch/x86/include/uapi/asm/vmx.h"
   "arch/powerpc/include/uapi/asm/kvm.h"
   "arch/s390/include/uapi/asm/kvm.h"
-  "arch/s390/include/uapi/asm/kvm_perf.h"
   "arch/s390/include/uapi/asm/sie.h"
   "arch/arm/include/uapi/asm/kvm.h"
   "arch/arm64/include/uapi/asm/kvm.h"

-- 
2.34.1


