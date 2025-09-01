Return-Path: <linux-kernel+bounces-794580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E632B3E37E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2AC18898C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF82334708;
	Mon,  1 Sep 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePXwn0MV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8132C30C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730520; cv=none; b=hNY5i3r9VULDHuZj8BDsp31HjSOkAi597xivgS7l4KvZ/Hk0ETni2SA16NXQgYQk7ZtXbz1qKze7bHAmyRTSZD7dbuVLA3cdktzLtRVStci342IW2xh+1fYp5mV1VwBrf7FMxSVaerqo8OJ9waSfCA18SpG09gdtvjAR9itRPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730520; c=relaxed/simple;
	bh=oruhsQ/XnkBWLsHo0pDjGsCJg2Naa/yFYEoihUsJuQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RwQ5++fDuKt/uHM1cP/Buyk6qOFlAmS31ePafXmZrQOFi7EuB8cvajkD+DkkmwRYgIc6EyWWvf/2J/NOwdrGEYwvHFt+HAFXOFTLv4Nw+XQcev/bZ4HCC26OPqhiUfTkIjdT/3xFwxfpQGYVa3OF6zcu+KQORXU9YiJapnswwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ePXwn0MV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso25802755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730516; x=1757335316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH4IhsI7u0PxrBs1+bnHSTEJenEfrd4F7dzjVPqlBZM=;
        b=ePXwn0MVt5XH9a0y83Mm4/qPuBH6c1iqF+heiqdhm6mdcVaTNl09RjCndaUPFMYIXe
         2f6QEOMDKVXkhjXhsxWUjuz0EFd56W81UXcWGtoIQQ1EWR7FkWwVZHeMCaRl/F00dWJ8
         wOTViPmFHbxSh5K/O43+ROhAHCbjiEtfroH3r0XBi/CK/0RU5ZiD5aABEeVdIaLuFcCT
         Mz7YqdI6eutp4FM+Gy286/s77SleRaKz0JUoUfj0JGurRhWx23RPXsQjMmSyA1xZzmNd
         sJ1pvBXpvymqZm5DPJtdtty9K9ntvCJRAEawBzb1o1diPUvfKtXQrD2aQ6t9zAP1duRj
         QBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730516; x=1757335316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH4IhsI7u0PxrBs1+bnHSTEJenEfrd4F7dzjVPqlBZM=;
        b=RM1U/d/Xf0XzICnBDYlXVqafMC6Hb6u9sgfaU9/MhmYMpiK7Uvu94YXgiURUUNlb1X
         mOkrNEW9Dy0a1jpR8HGAUP1311+92mTHp49h+LLwmw29GrDy/sDkmXrQRf9qfIXNGd3O
         lPvtVYHzpBggwEqz5r5uqSR3agct90cBsiyqHntpPzLDj3/dCOT6b2O86lNIC6F9O3/H
         H4ua9ZamtGEA4gTxU9NXCtUu30m2sFnXjCF4c9UHwKT6mcb5yYLL0DPT6APjzAQ1DE6q
         RUtmhDtcvk8x0RGgSYFkRUAwa0EzOezJIFCJ2nA0DXorSADD7C0oRT8tiEftd2AnVT0U
         0ACg==
X-Forwarded-Encrypted: i=1; AJvYcCX9X9TEcHbu5/XSksOgUvjvDKkomWobxWCMfj0iPfjKS9Me18uRcj4lqI6srB69xM4FW8ivKS9IKRLF9b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznunh+utYa5JaEVEPs2dgG1lgVm1dOHYUzXLBbaSxsalHeRFsL
	xYv6ObTx/nAaBYZqkes4Z0ua95VDUduvf8dpNasg1Vcre6e8Yfn1q08+azJ4N9Xbvnw9Of7HyTh
	pHyu4KWs=
X-Gm-Gg: ASbGncthld8K/MU4k2bDas3B9xmh4JWdNyebzOby24YxVrS/lmtJZs6wEKV3MBjqW58
	L9fLSeVDXcp3qBoPBcVN3cxi2jo2cyn143JpuxVEUBxFkuy/pH/AnmMszZiH7vA3qC267jOh/do
	ph/WIRqKZUhaTGsm/PLcfKSN+5VyEpMLsEtiHLRZxdPg7a1ioViHs7gaLlTmJRZcFrW8DMs+XUb
	FZ0Lswrq6qOJeYzD/Dm3OIH/+TNteZI/ZmYjKBuXo8q1uaqM7XyRwxklStvJtAfmGqcUK5lEPp/
	3LobdLVhCiG9GlngDnB0hrlE32EzDn5m210Aj6VZ5cska1gbq6UrF6c0PKb2Ezb/CVzn04liBvp
	pzwT8dIuJFpxX+3+VBNMz4qXZHwv80IdusS4ziR1Y4Q==
X-Google-Smtp-Source: AGHT+IHhau7EY0MQDlSyqPT+GtgoSvzp5Mp3oC9O8x1gCNdLj74/uD4J58UjK1u3FTzG5sPU+DMpPg==
X-Received: by 2002:a05:600c:3b10:b0:45b:8f38:8d36 with SMTP id 5b1f17b1804b1-45b8f388f6bmr19047285e9.30.1756730515555;
        Mon, 01 Sep 2025 05:41:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:55 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:34 +0100
Subject: [PATCH v8 05/12] arm64/boot: Factor out a macro to check SPE
 version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-5-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

We check the version of SPE twice, and we'll add one more check in the
next commit so factor out a macro to do this. Change the #3 magic number
to the actual SPE version define (V1p2) to make it more readable.

No functional changes intended.

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..a305386eb2e3 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -91,6 +91,14 @@
 	msr	cntvoff_el2, xzr		// Clear virtual offset
 .endm
 
+/* Branch to skip_label if SPE version is less than given version */
+.macro __spe_vers_imp skip_label, version, tmp
+    mrs    \tmp, id_aa64dfr0_el1
+    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
+    cmp    \tmp, \version
+    b.lt   \skip_label
+.endm
+
 .macro __init_el2_debug
 	mrs	x1, id_aa64dfr0_el1
 	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
@@ -103,8 +111,7 @@
 	csel	x2, xzr, x0, eq			// all PMU counters from EL1
 
 	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
+	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
 
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
 	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
@@ -263,10 +270,8 @@
 
 	mov	x0, xzr
 	mov	x2, xzr
-	mrs	x1, id_aa64dfr0_el1
-	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cmp	x1, #3
-	b.lt	.Lskip_spe_fgt_\@
+	/* If SPEv1p2 is implemented, */
+	__spe_vers_imp .Lskip_spe_fgt_\@, #ID_AA64DFR0_EL1_PMSVer_V1P2, x1
 	/* Disable PMSNEVFR_EL1 read and write traps */
 	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
 	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK

-- 
2.34.1


