Return-Path: <linux-kernel+bounces-666862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78C1AC7D10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFC03B582F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465228F95A;
	Thu, 29 May 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tveF6x0L"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A528F537
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518399; cv=none; b=blNmbEbn7k1yqaTb2XuzCGJZseH0SRTaKKZQjsFO8ORlegP0M3Idjk8FBw0Gkk/SuuWOmpAwH85Msn+PQatyIIh6lkjjOMQjrShmvtVsRs7jVZ3IbVLaoovNakLSV3JS0fcrvXrKabfwTjOu4x85AE1Ml7rJad7pO1NNiaV4uHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518399; c=relaxed/simple;
	bh=41eja3GEP0F1NgK0VkDUcr/lsnX2RYh7poVYaCc8trk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/rPCjZoVW6UHDwhPy1itEHS38OUJUklmmk7bGtLQihfCMawkt/BPXK43r25+iqC+0ad91lthmQ6gfb2iURryHkn1pjVZThNOVHNgHr0ikpaZRclFRdAuF7DibPkKYfx4y0qR9Y6jfsLr3yapXhRSWaOC7kftRCH7nO7279vp60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tveF6x0L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso5007725e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518395; x=1749123195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBZfytqoLfoLLkCHGYVhQ8mByrfQ3MODercYrOljLZA=;
        b=tveF6x0LTIphKP0aCxdlfKc6YExlp970rewGPdO21OJbNl2+9FGI3ATNw1+E1PWQzK
         piOir6s5Zg7F923RnCnR+lolV/VDHDGz2kL0a2SDJnpmdeQPOFr9MYqrjWZuzViUGMkk
         iiOACc1+kD/SAiO0EvAkwYWN8rg4K+54IrCrxAD0Xv4g/+UokivZJiq2Cs9cd8EDqvUw
         i1T3cJ2XNU//3WyGHgPEXE0FTtUTRMUoFhP71AdThszN18Cv28QWn79uC2KFsg806wT8
         XT5X262iL2LUat2vREw/3jzw7Rd1UjSHApYXAdlJY1rxA1Xm4RNNUPS+M0IrmQRbQOoK
         6I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518395; x=1749123195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBZfytqoLfoLLkCHGYVhQ8mByrfQ3MODercYrOljLZA=;
        b=oVNGTGmSZonN/pOaQJSTyZ+vyi2OyG83vGew93JH/zibvZNxE0SrtI4ZKX1oqjX0xn
         RBhabQluLPtAE98h6ZKcQVyv6wvfrVaep+8xGg8lD0sJnbql/Aan4uyptABywH3oPYBV
         8eftxNdWkh1CdxqoUf3UN/hldl3YI3S31OZzZk8PT+KvrL+ZbwOo/SkaGkG2r+fGLlQX
         aB9Cqv67tL4WX6YhAUBPSHrQhuEDxYMPOqcm/9dfvk4s6LyKDi5JTS2mLCKAVYhJbrXD
         LTOGxsaTS45ZBdpG1yBw94R9NTUVWt96dUdeoQqsr7Rj1AFvPSFQQsdnREtJ2ywTnZzn
         sHbA==
X-Forwarded-Encrypted: i=1; AJvYcCWY286H0TeTOo5+TY42O3fV/mjAPuwp1270ieCwguQuAemZT4aAmh+1FIMjPDuUa3ANAAiG/nHFgRudDME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLgXDVK959sPNwkbZTKUKGJOocV5w9+icKDN3QUzpZFPqwt+WM
	xZzVVaroH/Y0dmn0kLtjyzIf1zJydL0vOlTNjXZJBo8YbdzgZ3Bh64XRmrT4RkYCwOo=
X-Gm-Gg: ASbGncvxZIgOA+gonF19QZdkxMbGA6IcRYC/r3s0nOTWJZpN6AU4aG69g0iOrqAXluc
	YMfoM61yv3ZmY0K6MWH2PZaB9dIqDiDBP4YMfqh3IQV9/pLhaxcbRfWYyP4D5vyGlguZMj0wc9i
	KR5SFaRPCXs9ixIxDj699H2nkaUL9yirBmx+gRkFwoIRC7Fgh2ATCUWzkwPx6oNtm9xAfaOyg3p
	It3bg/C1mCPiJLjz36zzo03zJh20YBekkIYVD8EsysxpwT/NAA09BJKC0dQBrZZ7jmC4pvfinqK
	0IeqM8YcBusbKFu4lR9LWv96p5jIaisoKgcOmjSaW/3I6wpvAzc0xdZOMBmZ
X-Google-Smtp-Source: AGHT+IHMMfVW7IE9nbkSMy9wDfF0tmM1c9IXy+rbxej/RhTBlE7UtH3OLrCFPOGZOGsnCFRe6FkZLQ==
X-Received: by 2002:a05:600c:4394:b0:450:cc79:676 with SMTP id 5b1f17b1804b1-450cc79077fmr23266695e9.20.1748518395511;
        Thu, 29 May 2025 04:33:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:26 +0100
Subject: [PATCH v2 05/11] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-5-a01a9baad06a@linaro.org>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

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
index f6d72ca03133..6d0d8c25e912 100644
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
+	and	x1, x1,  #(1 << PMSIDR_EL1_FDS_SHIFT)
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


