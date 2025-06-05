Return-Path: <linux-kernel+bounces-674368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0131ACEE08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DAC3ACCEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20024248888;
	Thu,  5 Jun 2025 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBnqFB8W"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F411A229B28
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120612; cv=none; b=NBCOIhcXckNP9hvlBictO3oZ3lXc0W3YPh3GAAg6af5Nel2aCIFkaZZKDVF0okX+5yILhq5hpWbZ+42zgYXXmC/NYnEemvlfLuklgAePUZDAQ2f2yvXqBQiiGa75MdVQI5Ai8GvkyPU3PFOj8eh1ia3pGsjtuj45FHDSrKmsWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120612; c=relaxed/simple;
	bh=A8p4QmQp9wR2AXfusr2+sCtSzzwzACEYf3Bfr59fy6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slcd+L+ZjnhVB95gs3Z6cjKO/I9F7DAkVmt6evt8LeyCR6mCYg26pYlGD3SBqZ34199j2X/JNs7utefBHd6uBeBlfLzKs4rqLNOScYa7Us92ajtzL528LwJbVDDnip8Yv8nOJmEDLPndAm8LMod0Mkzfw0L30PZzSdM66Myq4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBnqFB8W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso2800515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jun 2025 03:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120608; x=1749725408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJT+aMqYEQmL5PQmYJEFo4Ezn3ppsHm7b3c7sVHPycc=;
        b=lBnqFB8W62cIHGxi/l2e/u4uNFLYFju/asuB2jhozPO8EdFHsexiFcGv1ihfTy8961
         ljnk1+Tk8yQOzH75dKIkD9zd9nL0/+DONIKScxvDgeL0e0AYKGv1c4AEC3gbqjNzQ59H
         W+e8/HjWWdEbAPOW/TeqI6botBbH2jQAm2LfFvibq6fx8sULEO0mwPr198ybCehbW5o7
         Y6k9qyLPFfSlkpNKgR+nZTdAbrE7G5RPoEBjqOMBqgkSSPKXzb3QCKQh6YlPRH2HhKln
         EmjDfiA05/TjOOr1eTRJG2hK6Ut3+E5HLu5KjU4kLfibJ4wFii4zoG29EBra1la1LAbq
         V/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120608; x=1749725408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJT+aMqYEQmL5PQmYJEFo4Ezn3ppsHm7b3c7sVHPycc=;
        b=udrb4HewSyym+pElMGCOIWASAGjP19HQTmJ3vpkaubiIj2WPUiBELmRLJfnwaFCwgR
         NsmX8pUd+Puba4tlvqRQyzN3+usx8ta4/YPBQSsYFXlXMVAIguXd23KIkQn2Z/bKEKJH
         BoiRJXizQAzSPKwz5nSzsgKMz2eOh0JGO4o45Blt4aDfba36uTU2PUjcmah/1Zwfp2rb
         xBRwY3FRfP2+HtZxMEQrTSidyYbKsYWIJxlqlMB6G6M3WY9NCV9rYidT1/MRAEOzo9M2
         l+UZGlKFy1ZrnOc2VoDetPxIHatqgINvGf9f7OYjyjRZr36FgsXxnEj2GIkDDcYXFMu5
         A4qg==
X-Forwarded-Encrypted: i=1; AJvYcCW8zF5bJXf+X0tQ6hGa5iALJ7F05R9WjPlIenp4gXHEcqwbkaQR52RIoambsn08lRclEr6GAfDXT41LXBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXjqwT9VeHwaze28SWShi3Lwumr6HIriWAFTdlHRGg+ccbt3a
	JTe+8EbL/hmeeEL0UzhoKVXgfU7Lt9SYSqXDAKOkf4mr1FaDw1eeTaf1wBzNmn5WZz0=
X-Gm-Gg: ASbGncskaSyb5g1ZWMfoc0uZcAaDAW407p2MBsE9fDS8jj/qDbrEpokiNtqDAkdYK24
	G241r0XF5GjKfKqsl0PUgq9S9t7YYiOUqHkWrU+P1X72Xz8f9UKbQhl3h2pomL5X1lB+/9KxMmN
	F0ysZTy1aKmHqlZhWr0o6ivGgy1kO3gd1CxEyxEZf35QDb/JyTnw8PQfuNO4JGpddD9xLKvAp5E
	BTJWI88dFxF4XtRnMlIBixISFFGbDJpVzCa2Vd4/boizUWk+T5dP3iCTvSJzALA2PfV2Xt75NDG
	8fseUT53PEvkaOjez4NvWFtDnXlSLi3wuLTbJH/HiIxGVTJaAPn0qkAeW9VXt4sRGGw/84A=
X-Google-Smtp-Source: AGHT+IEIHZpq8QHSEooXwNXyVEvqtUmnqaRzbft3GX1X+wZQal8zl6fwpJ0RAE4/3G1qpRtDL/8FwA==
X-Received: by 2002:a05:600c:310e:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-451f0a7c518mr63230645e9.14.1749120607969;
        Thu, 05 Jun 2025 03:50:07 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:07 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Jun 2025 11:49:02 +0100
Subject: [PATCH v3 04/10] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-james-perf-feat_spe_eft-v3-4-71b0c9f98093@linaro.org>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/arch/arm64/booting.rst | 11 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index dee7b6de864f..abd75085a239 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -404,6 +404,17 @@ Before jumping into the kernel, the following conditions must be met:
     - HDFGWTR2_EL2.nPMICFILTR_EL0 (bit 3) must be initialised to 0b1.
     - HDFGWTR2_EL2.nPMUACR_EL1 (bit 4) must be initialised to 0b1.
 
+  For CPUs with SPE data source filtering (FEAT_SPE_FDS):
+
+  - If EL3 is present:
+
+    - MDCR_EL3.EnPMS3 (bit 42) must be initialised to 0b1.
+
+  - If the kernel is entered at EL1 and EL2 is present:
+
+    - HDFGRTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+    - HDFGWTR2_EL2.nPMSDSFR_EL1 (bit 19) must be initialised to 0b1.
+
   For CPUs with Memory Copy and Memory Set instructions (FEAT_MOPS):
 
   - If the kernel is entered at EL1 and EL2 is present:
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 1e7c7475e43f..02b4a7fc016e 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -279,6 +279,20 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
 .Lskip_pmuv3p9_\@:
+	mrs	x1, id_aa64dfr0_el1
+	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
+	/* If SPE is implemented, */
+	cmp	x1, #ID_AA64DFR0_EL1_PMSVer_IMP
+	b.lt	.Lskip_spefds_\@
+	/* we can read PMSIDR and */
+	mrs_s	x1, SYS_PMSIDR_EL1
+	and	x1, x1,  #PMSIDR_EL1_FDS
+	/* if FEAT_SPE_FDS is implemented, */
+	cbz	x1, .Lskip_spefds_\@
+	/* disable traps to PMSDSFR. */
+	orr	x0, x0, #HDFGRTR2_EL2_nPMSDSFR_EL1
+
+.Lskip_spefds_\@:
 	msr_s   SYS_HDFGRTR2_EL2, x0
 	msr_s   SYS_HDFGWTR2_EL2, x0
 	msr_s   SYS_HFGRTR2_EL2, xzr

-- 
2.34.1


