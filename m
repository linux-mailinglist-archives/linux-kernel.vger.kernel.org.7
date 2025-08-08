Return-Path: <linux-kernel+bounces-760152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C601B1E724
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98DC1894EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F1275AFD;
	Fri,  8 Aug 2025 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puixu1OU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA39274FEE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652236; cv=none; b=mLm9aexjartLI2a81aQfiXcnaS1H4T9UwKFpdD8DtekmSb9BXtKaWZxf2Fdb4YGHAEk72dOybJQKB8hxLU16oFvALO0y8bL1M7/wlUiY69AvsIkTEGnWZylz5Vc8Q+wR1u7ydwgCovrAFu1G3G/Z0xzqsbzOhMTDLpupvPcF1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652236; c=relaxed/simple;
	bh=+jA3Ncis4HX5+y5SYS2TqC8tE0E6O8ym2X0vV73LTxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMb0bZfrZbqGbcZ+6VSPF3x/RYsj9ed7afzBZE/zK7nsFZioPd1kHpGREf9Ei83pYXDadJ+tVZyou1WRZMc5aj8vriJui7o/FSfiy39o+518YgZ939iLE+cyMgBup3WRAtuWOQxqoJifHpxLL1NocUgqhrC+aymyX5b/PpBcZZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=puixu1OU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so1002958f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652233; x=1755257033; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzFFhgGYuB4xjedzO7rx53MXxPvJ8n/ZLwqm/7UkgOI=;
        b=puixu1OU81PFNutFaE9ziePdV2eCVjqJ6z6sW3SoocDnQKeUwua4qYqdECwHiHRJry
         /h9QMhHPgX5Ql8fllkeF174rg6WO2ARxmip3vno0CyV/SGH/FugVukGQTOSYRqwNVyqn
         +g+PixDqbRU3q7BzEuG45gVRR0tAgLuG93/qeT90ZY+h5NpTc0dkKqcaRJTJSJDfNoYj
         udniaaFjK++mfxK/AA5/CO6/7YvDjmWL9Vu27HyfpSST9nGyzgB8Dk5sHZ2FsYpW1049
         nid00XEgWTnQMEa6WT5G9C6ZYPNAC9qKMwnU76z2jw3YHRg4mkevxgHPR3nBW0X15jMb
         5e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652233; x=1755257033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzFFhgGYuB4xjedzO7rx53MXxPvJ8n/ZLwqm/7UkgOI=;
        b=YtSxyTZWkpCH9FyZQ2rVfJ1aUWiVW7NW69O5xRTQZduZKhJUTdhpYNrUXqGfkwPZ0P
         UFVGXkvvX8/ffvwRIa18aViF+L1R9ND4vCWa5ttlHcSHUnTX1xOlrXCYCbzzYUymTRl+
         kPrrjJ+SCWMlLNx9ATK6cL/GRTa1iWZCh0/OczBvJUpF8wYa2vqUx0WUJwlb38f6R2vK
         v6pHTvKwoIz8ZomFO1iL2TKTPnkadpipSYZ6jg/6QRfnwndAIlks0l8e8S/AHoNj+sHB
         lHmeGrzO8H2z7EEgsKJfhz/HLuSBn9VmbvPPcqEBhlzZI8hzHKblIkKfOqBCM/zd8lj3
         judw==
X-Forwarded-Encrypted: i=1; AJvYcCVChiA2TrdWFE2zdVqXaTrBnTMh0Jo3heMfzxZIKzYu0jdBJ/08Ehoh7BDjhHxKrF6Xw/XSdSjOly0XN9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWGxSiLMBwpr0dUADtUf3p1BkVw017V74oDqubg2T6AaoMbB0N
	4Jot1EO9IFft8D1TDebJOLKLD1Ov3eaUkIQvYT8HOJxpai7eXpSEyf4P01xBhKYE8Jk=
X-Gm-Gg: ASbGncsfRZRU9chTVuTe44rYbmAnuhdihA3/DlW2TH65jIl4J+gxnXgbpUtBA3ObXYy
	Oq/aH6KUCXBkRKpBDVa3qKhJjycM2kJ+SIAJd1/W0ZBzS9fov5ChKAzLbkZMhEiLlWyTuEifux/
	Y+3LaB2awjrQdVsZ3gjQRzwbXEh6XqcT6hm7enK3lZVLxJYJbXGHmHK/6jtuJ5YVrI8CwPKEq+z
	MomCgW7qYo/kQ8M3UgzWdYDd3Y5aX+MJm/6JaIV2BpwQkQtYe3MziBPYmKXCGwky4pK3DbMzv6X
	Yg+rseM0fWSmUtMiOepfdodsed0A+QW07SE0Iji5JL6rCykuQ431Ehtcjm9QOjTP8tSJw8dzzv0
	c9ZlaneTxtSgClihC3O3FfHDRKZnNuBoKyQNGrArCcg==
X-Google-Smtp-Source: AGHT+IFA08gaH/PE8BI7LMp8YziJ1EgstGveIjmcsXTetOJTEOPbmTHS6Iwam90twv6fI5T7D1HpPA==
X-Received: by 2002:a5d:64c3:0:b0:3b8:d337:cc33 with SMTP id ffacd0b85a97d-3b900b5026dmr2094550f8f.28.1754652232546;
        Fri, 08 Aug 2025 04:23:52 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:03 +0100
Subject: [PATCH v6 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-6-6daf498578c8@linaro.org>
References: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
In-Reply-To: <20250808-james-perf-feat_spe_eft-v6-0-6daf498578c8@linaro.org>
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

SPE data source filtering (optional from Armv8.8) requires that traps to
the filter register PMSDSFR be disabled. Document the requirements and
disable the traps if the feature is present.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/arch/arm64/booting.rst | 11 +++++++++++
 arch/arm64/include/asm/el2_setup.h   | 11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
index 2f666a7c303c..e4f953839f71 100644
--- a/Documentation/arch/arm64/booting.rst
+++ b/Documentation/arch/arm64/booting.rst
@@ -466,6 +466,17 @@ Before jumping into the kernel, the following conditions must be met:
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
index 3a4ca7f9acfb..a0361ddcdca4 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -392,6 +392,17 @@
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


