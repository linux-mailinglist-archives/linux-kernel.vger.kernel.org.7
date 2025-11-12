Return-Path: <linux-kernel+bounces-897555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C56C531E2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 988F4504722
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3D343D9E;
	Wed, 12 Nov 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BZOq0iz7"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9333F39A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960962; cv=none; b=PUfTL1hAowtzHSd+Jx9Q1TfGC0NX4kSD6yUONdnDQq9UyOScrRTgXl225aCo+UGTBxzvHpjZ/+KQm/XSLsHxyC8U1ln07ZdfNDABYiGlRXilF1CyVq/QYa7HwddmGjXoI9QnZxhdFDFpb1I8zRqUnZcPJfA+v/YdWeeSGWEr5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960962; c=relaxed/simple;
	bh=uJVSK5aYHf9PqYstWTAX4v/czLiKhA9I0TGHQKP62RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onRvE++yWL8zbEFK+wnArUgBNn0tNaAR8EXLWPjMBxWbBBZyRXVsGp5KzCYVuKRrANaOGlALiN583HulCk+StPVCzbU86KtDx6uewaBPkdaJCn/4B4u8FfM0/UZFoUJOnSSi2q7d4pJGRsynfAF5BsHZUTtbf5C8JxrNY29tOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BZOq0iz7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso795068f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960958; x=1763565758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILLjcNFKCShCpCjFdgdkPREBFmKKVtEX1F/DK1p7azU=;
        b=BZOq0iz70zOcpAtmPOxSzKDpl+7PbUSZAntimF8njn4Yf9xY91zHMhTJGdD8JPcBme
         4av2kPiFcnDm3+FBlQTqOVnbwt5i3yshyEthtNFb31fDQBZlxCJ1V+G/jSCpzuF/tQlY
         4K2wuRDYIjH02fmCpSyEYyrXsSmKbcFJZdtaEGwY4Hjg0uAvcMDXbpMerAiNLN65Vg1m
         tdTj28quiuUgUW17druyQCgQEgGVZaVt9LpUTXfRKh0b5A37X5+T7bjc4ZpVrdOEq0O3
         uvnqJZ0/4knv0sK4hlq3E1fHAqG2T/SAK4W8l7k83safQL6UJIa9bphGBc1UpeYCAnMi
         csAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960958; x=1763565758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ILLjcNFKCShCpCjFdgdkPREBFmKKVtEX1F/DK1p7azU=;
        b=SwYwMdQUw9C6/UzHxM5y5Qt0UW2BvuXizYRkwUDB0al6VDiGEn/k0fxWAhcrM5SL3+
         9eaFOqJs+YAH43oS/bwrRsa1Th54EleizBHROW+KwXqrDO2sdadN2GqgigjNDImfrhNH
         n+RwFbAeBCPY4u+3GbydWu3Pz1vhBSxC0zbMtWxfRo4eiTSDATj/sMevqrPnNk7nxzy1
         /ff7mWqbNb3LCFTfwNzBVBKQFPwuLpAi6WrwpxzMmg5PMuzQoyiAWJpvLrZWMi4X6s+7
         MFGn4FVZzcDNubhHeDeUS1sQtm9opSAiIJaaOSQ+BPuC48cy8To2jkrCxXpyOCj7+FX5
         lAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUsG8FSKNgqGSLFJxT6tBrcJ9Lug9QNUqt2elfAFBRE5uzcoZfBBfzp3YluHIZbyK0rEGHS1XIswERypI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4F4hInjGnCiOtI+AhL8vJ3wSf/cSquI6CGl7UDj+RDND2vXf
	FGSWb6u93n3xteqDWO0ScfmnrJvDu2/n2oCRn3vElzI/5aFyBL8sD8NkgFzTLX/h1uVWBaykD9P
	LQvP/jGg=
X-Gm-Gg: ASbGnctRp43XLQCxTqmCTpuIrL95sghvOftJVwVNk4mHJVyCult/DIve6Au9hYzQHMR
	r+41Jfpq++QBhivbqpjpHR8XtUi/hZiBrYZ63IyAjUCusFpeDw75zZcGAuEvVvX+C+0of83WCyQ
	TVBf/fUMYbK21Arz1toObV5SvvFfc5bjI71Du5YbElWhssYxqVmGgpMbigoua+ApkO+5v+tM/64
	L7xxmbmphf+uQqBhq4GNiyDlxT34nZbFuq3fNdFfxPJvfwBE+Wy3zq4Q7u8HXwbNpYEc+qBZsU6
	w9RDwx42fhIAj5RREgzIRDwHMGWOR9fzSZ96o79w8Zd77mGg4MTRsRcxOCdFu5wHohwUPXQZuJx
	XCaBqrGkDe+pbRHngbc5CRcMrETR+O0lMzVfH4NKjS/C9OZ8oLbOd+Q5tGSMXLWuWhX6x3YBKqw
	fe91BxPfH2DQ==
X-Google-Smtp-Source: AGHT+IGjdUCcCG92Q/jqFroCRNOfWwVifVOKjjlFDKz+QCM71f6L1+0atNpuSmvuBiDEBaoYhQJwCQ==
X-Received: by 2002:a05:6000:420e:b0:42b:43cc:982f with SMTP id ffacd0b85a97d-42b4bdb0267mr3253494f8f.39.1762960957948;
        Wed, 12 Nov 2025 07:22:37 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:37 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:16 +0000
Subject: [PATCH v4 10/13] coresight: Remove misleading definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-10-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

ETM_OPT_* definitions duplicate the PMU format attributes that have
always been published in sysfs. Hardcoding them here makes it misleading
as to what the 'real' PMU API is and prevents attributes from being
rearranged in the future.

ETM4_CFG_BIT_* definitions just define what the Arm Architecture is
which is not the responsibility of the kernel to do and doesn't scale to
other registers or versions of ETM. It's not an actual software ABI/API
and these definitions here mislead that it is.

Any tools using the first ones would be broken anyway as they won't work
when attributes are moved, so removing them is the right thing to do and
will prompt a fix. Tools using the second ones can trivially redefine
them locally.

Perf also has its own copy of the headers so both of these things can be
fixed up at a later date.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/coresight-pmu.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 89b0ac0014b0..2e179abe472a 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
@@ -21,30 +21,6 @@
  */
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
-/*
- * Below are the definition of bit offsets for perf option, and works as
- * arbitrary values for all ETM versions.
- *
- * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
- * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
- * directly use below macros as config bits.
- */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
-
-/* ETMv4 CONFIGR programming bits for the ETM OPTs */
-#define ETM4_CFG_BIT_BB         3
-#define ETM4_CFG_BIT_CYCACC	4
-#define ETM4_CFG_BIT_CTXTID	6
-#define ETM4_CFG_BIT_VMID	7
-#define ETM4_CFG_BIT_TS		11
-#define ETM4_CFG_BIT_RETSTK	12
-#define ETM4_CFG_BIT_VMID_OPT	15
-
 /*
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.

-- 
2.34.1


