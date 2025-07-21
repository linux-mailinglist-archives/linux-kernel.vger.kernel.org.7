Return-Path: <linux-kernel+bounces-739296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD5B0C485
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE41E4E535C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D472D949A;
	Mon, 21 Jul 2025 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8IUd5rF"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DD2D838B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102461; cv=none; b=MIB98LxHAXZT8+bNP5Bjv5KS5CHBc3ihhF/fGqrtUOYK2YSmzu7c+hgvzhNBRz3PYx0wvM3QRQTrPP5rSRSlP4IjaCF4A1yEoSikcEFdMW9EJSA0SWRJQ9cj6Cl9yHEdhXJzos7KKs/+3zStgQz4mx9QNqYLuDf6udMgO3/VETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102461; c=relaxed/simple;
	bh=9uMRLY3tW+LsgB/KLohPx6Pdb8SvPdWaSQtNDtaYois=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i93X6RN8WAR+5zLjXLajh/1T9T/E0qTu7XSbt2So/bKnh8H7q60BrcbT+j538aYMjdjjf75+GrC9KWkLL8ua6xHrPHKHSKhQuqtwua60YCtbOewUA1j7c6M71psFoF/8Nq+VWI2QCFFC/dswr0snGDWJ+r2wErk0ZKG+/bhujzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8IUd5rF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-451d7b50815so32589065e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753102458; x=1753707258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ei/HnJSvouST6mpmth1X7iDdKdrsxcGxYeWK5nNgG1Y=;
        b=b8IUd5rF3lST3qLZiWb3W7Lv6O1hdCBY4xt1vT07xZDIBK/BSvGx1Irl6oabnSJonC
         8XNSJn8sMgoWfA5wn8ZtG2offtlJEnmO0UdvcKKWpkRa8AIMZZvdhRX64cPFjnlY1XtU
         KDE2EBbAG96tK8po1r4UFt4UgZ2BIGbFBZcoiS6TLZYdmU1v45ZcbVrEDeVy6pVixlrz
         5xR3hYv8nZ/N6RgcvRIRD+qPJSzqtN1rE/OMYh+f8nObga/G24VvnS7owLnrrT7uk3+/
         agqnOu60t8Vi6KXXIJx3owSIHiwuPgq2ll6UZwLLJ85UmMa+DEXlga7NHR5K0VVsdQP6
         o/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102458; x=1753707258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei/HnJSvouST6mpmth1X7iDdKdrsxcGxYeWK5nNgG1Y=;
        b=k91/sGG6tWltbbLE+BOz5Uyg9ru7sFViyiPCW3ZzGyxMnHYAB6INc3i6xZwSFctq0G
         j4sAPGhk7Y3rv0xP3bH4RbqbHavy3zD8MCCk9NdCs54em9PLRunyPcaQPEC15hZWfwbE
         j1LKksWf8sVK7HwTNjvs/HaNYv8UptnF2ti2TM4GdHVQwE7dSxG37V7CfcM8NkCarvyx
         M18qGfhHDs0lipCA4GakyqR7a8Iic6Ty0EtYchxTceG7k/HCZcsU7oLGcS1JKXvlbEDO
         4BgwYUQ8TPgE4DlUzXw0cDZ3e9fgIoAqAfOBwaTUGyI+77PJ8ePhJaOYpBVI2r8FV+hx
         4a/w==
X-Forwarded-Encrypted: i=1; AJvYcCW811SpbMjPeiI8KlMNg5O371HQ9WXlESqjSmc2lBuC0ubI0gZQoiAMRkPJwHymGzSSEg+1n/SF/MuIW/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGfY6xmRpD/ZuuK6zdgCVLkCkP4hDjdBc4NNH4of/KKJoJ9xR
	EEmVBaU9xdT5MSs13+ujpwV6ul3ofr0S9bihXqDiuH9hm+8XbD2h0s5HtjhaWtKtmcg=
X-Gm-Gg: ASbGncuRNMoyp02bwCGzB1p9UD/JTk6hXeo62en7BrdsYyDz3nx4pxMZtzREmgWNuga
	zceqzkM3WYD/EXQeApkCcLQxUMb2wHFap/RKxwpEF5KjwtpCYbEdygxLWXibDfXfynmlPO/oG8u
	z/Cb4oxK58QFnuGbxoRhpfyfolY4epGKLTbL8Zwz1Ak5rjrWAlggYCI6yPgjoYa0IQkWhwPk8wD
	jjJ2HUpiyN1P80jYLe3oAQemTusbqGMn0J2x6F5PlRE+ORmSwJ1vH3SUnPOAmMBKjSqs7p9Poo1
	IJhj5PehsrwlECTXTXWUg+gxJLz5DBf6J+WFw15DhKZ0gPaNyH8nY4Xh9soySgVnAlyouubS385
	3oZR09QLiSV74Hx4CK9PslPz2Ay0HOiM=
X-Google-Smtp-Source: AGHT+IGXHG3FB2msUxbdeDts98g2pPebzoNgn/wdUbPPp8qpa2AIRfLTEy0hX7PjnhlcduPhaxdQQw==
X-Received: by 2002:a05:600c:1c0b:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-4562e37c48cmr144674035e9.28.1753102457591;
        Mon, 21 Jul 2025 05:54:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b75de26sm98995225e9.33.2025.07.21.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:54:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 13:53:37 +0100
Subject: [PATCH v4 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v4-6-0a527410f8fd@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v4-0-0a527410f8fd@linaro.org>
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
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/arch/arm64/booting.rst | 11 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index ee9b790c0d72..b4f6d487a322 100644
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
index 2bb0d28952e4..7c89e0d6e739 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -284,6 +284,17 @@
 	orr	x0, x0, #HDFGRTR2_EL2_nPMICFILTR_EL0
 	orr	x0, x0, #HDFGRTR2_EL2_nPMUACR_EL1
 .Lskip_pmuv3p9_\@:
+	/* If SPE is implemented, */
+	__spe_vers_imp .Lskip_spefds_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x1
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


