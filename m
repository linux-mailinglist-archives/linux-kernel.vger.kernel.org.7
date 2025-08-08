Return-Path: <linux-kernel+bounces-760151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69964B1E722
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064277B3259
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE5275866;
	Fri,  8 Aug 2025 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymSeUHxw"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291F274FED
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652235; cv=none; b=Z7lO/ChGYam897Itz4OeDT+/EfVCkwv8kRTQJveE89jYZ6qRB1lt+ywAYohM+3Ut9ACoXzx5eQt/csDZiYSkFH9yQfA1c7vsbuDYtPeGcGdICPQODayf9Whe3UbEyqwMNijoZEZINeo5bBBr0TTuG+B13ZeoqDy1rC00h5B2kSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652235; c=relaxed/simple;
	bh=2M6WcB6KkvvOnu9SyMhbI08CMGWnnDOzfm+WTNCBqlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzi86Sw1kwRS1QVQk5VlRcbcnbKIHFWPjSM8iPXm3x2aZk0ZOYAB5/AnBhITZHirD38IDJRCzkSxSkfxlJjgNUz6eNPXPhmVbN74QloDs9M7RfXJ0GbDI4lYzEfX/VcSiS+v8rvaL5Uwxu5p0QZ35qZtK+lnQtjMADbzzwKOJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymSeUHxw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458baf449cbso19137845e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652231; x=1755257031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXydwqwRaP7AXP8zkgHzJDBJPfnaYLIQgQCT9Y2uDB4=;
        b=ymSeUHxwTMKi3VaTYQhTpCgbrrKehNqptGeCmEF0wpl4H8IfvJrneTlgWYbtZNxDcz
         kEtIE7Lhbm0T5A0TrF/xfPFd7V0SMZi2GSmmNI9NxpySw7dLwhZj4ezjZ1evdndqd35f
         fmXVX48v57T+bYYhuELBV0Qhv+Iyn95M09g9LrQOtSXWhLig1+0Jx61oGCLHVtJ047F4
         x6PUcRTpxia53eP6MeiScdh4olyJ8DqXQsXU+pUKS4TMtOG310ngaVMigN+RnVWYiaIX
         LFP9p2yJUtb0n69fLebWucJ/K47rqZ+Kyj92odk+KiPOgEBkYKXMccNaJiClg3YWiH1g
         y3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652231; x=1755257031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXydwqwRaP7AXP8zkgHzJDBJPfnaYLIQgQCT9Y2uDB4=;
        b=oyN/omXG+A5GUfM4hSa2K73vzKGCA9U2Pk2BkbcGLU4NLnKMFMYo7P0mR11GE3zsXi
         CFE8RUT9EKECy1yTp0Q9G9R9B4ouo5GYPe+Q//YDPhv7EMSpnI/AQ0eP/yN76k75dW/P
         3P28yU7qU+bn0foKjrZVQYvcoH4pxJHfFyJhAMRw4rhhrVo+PRqFh6dGNwRx1mtfW26h
         MXP3tQzU1BOgmT8YShgDJuixocCI55Ip59ACqP9roA1FWjkJxw/vK+irXx+wD91CR8/p
         dC+jc5Tsf9r/3jmMWxC6M1hlQNUC3VIlcrq/YIH1ZNiZzzO/26YraB8YXXK9ou7gMsp3
         +Yog==
X-Forwarded-Encrypted: i=1; AJvYcCWoFw3RbYrfvTVHywC6tlvOswBZ5hOQxrJEsT9eXJFu09Vr0XaZYbAgxA2/DMqW2kscjxWEjxdCAN3EAgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8bH8lxGnZJgXjxKxguPHm8Ylscg9VqBdQBqlzLxshTCQpZrXM
	mh7dyfhWkJOjpZyNRPesK6yIJLi672t49LMtoA/VC4wOm1vmePcK8SLB5C2WmmIYPoo=
X-Gm-Gg: ASbGncuGdML0z4Tqr/dM4E3MP69xHrrgEmNW/UE/qgyEL1cLDT8LaDzpQp8U/yZWB6P
	ggQB3k++MiqIKcSapMcg1emRfoTUcunwv7+MtLdhQq3mveBy6i07YYL0get/7oBlT1Zka7oL8Zv
	weOYgAMTbb89VRto8A4cU/P6K+f5bea1vHwtAcFHAK9OpTupHlUixzk565M4On62qX8mJ12nBH2
	BnvLORhrhHDo+PljregHY3FY9ljINxqzv4saLQRyg9U2CWmkMAUjuwUgbs4nLZ+Zur56U0WJfSo
	iojlsZWA3CyC1var5+ikHahXaxxoYrKJH2CKlpwQwYBc2J1PYoKV1SWPyLcz27Ox8rytSnvg+2R
	w/8q15sD88zecL7bWDO2bwAzuMBQwSpE=
X-Google-Smtp-Source: AGHT+IGZt07Gv/AHxus95QP1UL0e334J3rp5xUM7DnDTXPfXeFD0bRifb9xINgGQEjtvNdHSQjLqQA==
X-Received: by 2002:a05:600c:154d:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-459f4f3cf5dmr26410715e9.3.1754652231142;
        Fri, 08 Aug 2025 04:23:51 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:23:02 +0100
Subject: [PATCH v6 05/12] arm64/boot: Factor out a macro to check SPE
 version
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-5-6daf498578c8@linaro.org>
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

We check the version of SPE twice, and we'll add one more check in the
next commit so factor out a macro to do this. Change the #3 magic number
to the actual SPE version define (V1p2) to make it more readable.

No functional changes intended.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/include/asm/el2_setup.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 46033027510c..3a4ca7f9acfb 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -103,8 +103,7 @@
 	csel	x2, xzr, x0, eq			// all PMU counters from EL1
 
 	/* Statistical profiling */
-	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-	cbz	x0, .Lskip_spe_\@		// Skip if SPE not present
+	__spe_vers_imp .Lskip_spe_\@, ID_AA64DFR0_EL1_PMSVer_IMP, x0 // Skip if SPE not present
 
 	mrs_s	x0, SYS_PMBIDR_EL1              // If SPE available at EL2,
 	and	x0, x0, #(1 << PMBIDR_EL1_P_SHIFT)
@@ -255,6 +254,14 @@
 .Lskip_brbe_\@:
 .endm
 
+/* Branch to skip_label if SPE version is less than given version */
+.macro __spe_vers_imp skip_label, version, tmp
+    mrs    \tmp, id_aa64dfr0_el1
+    ubfx   \tmp, \tmp, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
+    cmp    \tmp, \version
+    b.lt   \skip_label
+.endm
+
 /* Disable any fine grained traps */
 .macro __init_el2_fgt
 	mrs	x1, id_aa64mmfr0_el1
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


