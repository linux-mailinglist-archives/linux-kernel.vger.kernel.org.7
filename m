Return-Path: <linux-kernel+bounces-579022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FA6A73ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 20:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567C417E4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 19:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A03623372D;
	Thu, 27 Mar 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="chh3c9or"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB98231C8D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104199; cv=none; b=RVkrSIoT2mckKe8MHA2Wx9Q6V/gc7MvdPapgRJvxoef+x55t0SVKKbIGe4UFfE6uOjLhUPcL2rITtPNbvMNcBZlv5mCcFbiIUUrW+RpT5WOlCEdPgKy/2bJaR9TbWmrgPL0+6yPlzNFCde1tgQL9YhdprvoEXPZ9RvR/boAF7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104199; c=relaxed/simple;
	bh=q46J2sWpYtBWydQrJdezKrDrWVQPLFB+HmLkUTYUTa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGfc1wxILkb/UJATcsUsHs8EIQsvdE7jxVkK00It3YGWRnA9JTRT/gSQvVGwbh9iSJZJuqRoEEDFm+8k2iFhanrDFjSs39f7K/rfkg5Ocdly+K9vHRYON7fDJ/XD2xgg8spKTM7oAxWd3m4CT/XB9Grvk/I5/E3zc/xVn1/ztZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=chh3c9or; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso1646632a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 12:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104196; x=1743708996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j0mOzBIBbWihlBNi7mWaZI+CG3uEBnbuDjvN2IYRxw=;
        b=chh3c9oregGex1q6jRWSZVlQOmNUAIyBTk4rbAECpry6AX4Yo8rS9ZIA2vvM6EIqzr
         2xBG++dX8qxB6xmheuNviueJuse9OZQGg6V+5pxcgnNxZ3C5XZXRKzM2wbSh2j1Jg4WU
         DIShCpek5N1JRpqQvy6G32xJrN9p8KtM6KcXMxb8WRXBwhRfKh7U/bPHb1FtKrDxLfhc
         hjbcp9H+BkYL0A7tHh+61R9KQ1cSZkUff0e+Vkz8DKB/hvh0U1jUtLt3pqdYfRb6RQRI
         tnY2YMiZpjh60kMq/u+7h2QM7W/yFfcfZIH30f2M/1Rbhjjl4zMvXWl9lsAIu149GPPv
         cKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104196; x=1743708996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j0mOzBIBbWihlBNi7mWaZI+CG3uEBnbuDjvN2IYRxw=;
        b=ZxzcIqOyijZr8B+xMnuTLHKDfJdwcP2QU8OrIafxh0ShXNMQ3L9bZF5WeVyohXkYsx
         KApAwhjrtnlAikwn9lsfF3MOupgsBzoxhezrBPmvn6jycc2xkOJRAyl9zmqUUe1DcBCP
         mZzLs/VAocv0aFg5S5FeCdIwbGTde4rPCkOsFR/1G0tVYlNBQD2B2c5CrxuUJpTnyRb/
         pyjArkxHHHIvY9zYR5jrFDvlwnriAhZbDevLGFrkKjrUVgmAsvuyjNra3caATkyDXREt
         DG/8NsBi0iEPrIJvY8XMnhqkqcIKHzO1DeOqE/ivsRZt+rzwn/srU1TO6XJtl3PnvFYE
         qmrg==
X-Forwarded-Encrypted: i=1; AJvYcCWUEV5hG9x/DxmcRawcI/wYaHj5fc5z706yNaRYRLWiw4Nzhurj0K9Y06lSqbzHO5ZXCvFnVkrjb1ofEf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkD0miuLIv9WloirpMsspN6LcHUtOxyDtiYDVK/BRQacxepeHr
	+wOTt5pL9NlgXb85pZgTOXAW0/z5MI50KQesBSgiSDmn6WBEUcGoDbWzRy2CAoY=
X-Gm-Gg: ASbGncsUvDTnN+l7BnRA8QVmTimACp6AbzX4OxYHMzILnwsF+q4vZw/t0XY36fScC6G
	il0O4x5NaIquAz/92RluF6NNyhAvnnkDmenWwym4PTOSiTNoV91xeglzxssWpB/QAaWm92wimqH
	9qUV1Et6yRQuMgcJTRRrZul/PCjaXsmZXjQ7XTi/SgCLFX/oR572+uaGlwoLyBMkEntI2D29bGE
	pY2GhNDQSDjyyakzssu5C4G3hzxejFNJ3CmNFH1Dx6OL8vkBzqpVtC/dGvGNRz/gjMHHsemFSQq
	PIqXh+agin6EbmBEOLliKfwGTFzerZeK6aw+gdUK38mJB6MmutBjwGa6YA==
X-Google-Smtp-Source: AGHT+IHdjjEQNX6IhpahJsgRaqmFMHO1OoFraaA5RvWPqmrRHezthFdgwqtl7qWclGaf4FKMvnzgWg==
X-Received: by 2002:a17:90b:2649:b0:2ff:4bac:6fa2 with SMTP id 98e67ed59e1d1-303a7f65282mr7819841a91.16.1743104196370;
        Thu, 27 Mar 2025 12:36:36 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:36 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:56 -0700
Subject: [PATCH v5 15/21] RISC-V: perf: Skip PMU SBI extension when not
 implemented
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-15-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

From: Charlie Jenkins <charlie@rivosinc.com>

When the PMU SBI extension is not implemented, sbi_v2_available should
not be set to true. The SBI implementation for counter config matching
and firmware counter read  should also be skipped when the SBI extension
is not implemented.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 drivers/perf/riscv_pmu_dev.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.c
index 7c4a1ef15866..d1cc8310423f 100644
--- a/drivers/perf/riscv_pmu_dev.c
+++ b/drivers/perf/riscv_pmu_dev.c
@@ -417,18 +417,22 @@ static void rvpmu_sbi_check_event(struct sbi_pmu_event_data *edata)
 	}
 }
 
-static void rvpmu_sbi_check_std_events(struct work_struct *work)
+static void rvpmu_check_std_events(struct work_struct *work)
 {
-	for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
-		rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
-
-	for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
-		for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
-			for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
-				rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
+	if (riscv_pmu_sbi_available()) {
+		for (int i = 0; i < ARRAY_SIZE(pmu_hw_event_sbi_map); i++)
+			rvpmu_sbi_check_event(&pmu_hw_event_sbi_map[i]);
+
+		for (int i = 0; i < ARRAY_SIZE(pmu_cache_event_sbi_map); i++)
+			for (int j = 0; j < ARRAY_SIZE(pmu_cache_event_sbi_map[i]); j++)
+				for (int k = 0; k < ARRAY_SIZE(pmu_cache_event_sbi_map[i][j]); k++)
+					rvpmu_sbi_check_event(&pmu_cache_event_sbi_map[i][j][k]);
+	} else {
+		DO_ONCE_LITE_IF(1, pr_err, "Boot time config matching not required for smcdeleg\n");
+	}
 }
 
-static DECLARE_WORK(check_std_events_work, rvpmu_sbi_check_std_events);
+static DECLARE_WORK(check_std_events_work, rvpmu_check_std_events);
 
 static ssize_t rvpmu_format_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
@@ -556,6 +560,9 @@ static int rvpmu_sbi_ctr_get_idx(struct perf_event *event)
 
 	cflags = rvpmu_sbi_get_filter_flags(event);
 
+	if (!riscv_pmu_sbi_available())
+		return -ENOENT;
+
 	/*
 	 * In legacy mode, we have to force the fixed counters for those events
 	 * but not in the user access mode as we want to use the other counters
@@ -878,7 +885,7 @@ static u64 rvpmu_ctr_read(struct perf_event *event)
 		return val;
 	}
 
-	if (pmu_sbi_is_fw_event(event)) {
+	if (pmu_sbi_is_fw_event(event) && riscv_pmu_sbi_available()) {
 		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_READ,
 				hwc->idx, 0, 0, 0, 0, 0);
 		if (ret.error)
@@ -1945,12 +1952,13 @@ static int __init rvpmu_devinit(void)
 	int ret;
 	struct platform_device *pdev;
 
-	if (sbi_spec_version >= sbi_mk_version(0, 3) &&
-	    sbi_probe_extension(SBI_EXT_PMU))
-		static_branch_enable(&riscv_pmu_sbi_available);
+	if (sbi_probe_extension(SBI_EXT_PMU)) {
+		if (sbi_spec_version >= sbi_mk_version(0, 3))
+			static_branch_enable(&riscv_pmu_sbi_available);
+		if (sbi_spec_version >= sbi_mk_version(2, 0))
+			sbi_v2_available = true;
+	}
 
-	if (sbi_spec_version >= sbi_mk_version(2, 0))
-		sbi_v2_available = true;
 	/*
 	 * We need all three extensions to be present to access the counters
 	 * in S-mode via Supervisor Counter delegation.

-- 
2.43.0


