Return-Path: <linux-kernel+bounces-739324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F2B0C4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899BF1AA449E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2732DAFD5;
	Mon, 21 Jul 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVbujU1W"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EB2DA746
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103121; cv=none; b=aVIrtbCg72gDSabcsgZV8N6O8v0s2ivQbd4C6lLeyxZNZyBI1u5tJj6XThrH4xsGp+K3Yj/S6tO/PAbBy5118t24YcGcOfZB8+HKX3qditpKvIfEGxbTzNFYMsUoJL39af6GciuU4ONTWY9jffecMzyZRYO6Psomtu8AmlOA3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103121; c=relaxed/simple;
	bh=nJUr8QBs1Bj7YhbHeTnMBeiABjZ7mfBR47rSyL99+v4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNUnz03VLMh2GbbaFFSvTLTqkVRVRKvXsmGj2RYjZZTVKIDR5kmTSH+wbqqkiX4/GaUY7/pMIXGJEvTmyxx+sUtYHh8ZPKMcgUAC8KQsn0kkIAgbCXA75NqMfprzPth4OqtxMyeYgkSGh30i50B+BA231X/cS9DoGFC+HDshwyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVbujU1W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso44560905e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103118; x=1753707918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tni0DswMrCD5TnIk9k/V3+/ZJa/XagFEwHSR8GX4s6s=;
        b=VVbujU1WJJxNMWptGL1MuqhqSglHGREDqloEnea94M8o/79Y0Elv5GUHRq9aV8hDMa
         nYEih5oypVNndAIKclJnj0nHkE3SQrFDVGPil4B2sG7ZRQmwUjumjRiU9Ee9YdNhUKTQ
         0lNX8iDqawKj5C3CbFDTqcoxhnyOsI6cXRE1cPHUcikfXKg2EqctXYMl3ru4S+/y9ZLV
         xgGxlczM7TuaYO8bAYwkYTEquN/MnP5vCFr31wT1rj/pfX7d1hteZsCx0ItM7amh9KT8
         Zn8huAyG5sfloZt2pRZI7z4LoaDM5w6RsZjE+4w5zmwghTJexjp4ZiVXb8xyAZHYwrbS
         NHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103118; x=1753707918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tni0DswMrCD5TnIk9k/V3+/ZJa/XagFEwHSR8GX4s6s=;
        b=hRIAPYCOfoUv9cySXNmfAXrQEeCzgCSPBtcVinrhI43Hop8bdoPj4SrQm/WECSqVEo
         tqUzllOr715v/2XroyfH8n7E7hIlf45Sjm7HOhwVdUDTQV8xd9GeX1DyXvRrdhWLdFD/
         xElKB6o90V43YLdeqP2ZyZPGjqYrj4/2lAfJDtiyU0BwmfwMFJpDrbjbp58tbXhMtQbQ
         3t2I4Ud2yfJEIvGxDgeN/dt5NBv87Rh+/8X5a3YV7KJPTSSpOVF0n2wNuO6egbdhqQ2B
         eYx/08BUXyZhxELQK3IFG/ux2Z/RZwEGpgNwYkIwWLRyVcCEKsAalN8p2ihARMDTquCz
         CzDw==
X-Forwarded-Encrypted: i=1; AJvYcCVPfm/6YyYKXdSBpokqpfZPhrlKRpV8PT7W8zYZPFUPqXHabmcs+vsWzcEKwGApPLf5iHb/oqiPnjEqWs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nUnBKCSXTDaNBQFXKpuapD56cxqkJhB42JafBvCgnseB96An
	6iYSQHkKogy2r4fOQagnHLUsjs9p8/DU7Mn+tO5dO1XhjC9TgV92pPBkFsj3PAYIDhE=
X-Gm-Gg: ASbGncuOox7MvK5mcX44orABRtuecQO/Qjlrsc2eCOcfwU0qCD11aMcUACigdArc10N
	gd6EV8zcOhE+FdRrTtt34xAczAlRG03N/f8r7v9bImjApizkUX7JCpVNsRHFBU/HKR+pbddt7gL
	EH+KDmpjKGYYfWvOzs3oFs0XAqRgO3QNnJ1xqASsKqaFPEmrG9Fic5xj0IWdHim0SMS1BFcUIwu
	EUiM0xmr/qI4BVwdGiBLc5/9u14GUP+nUvBOIEnzE+T/PCGIFKsQa5FTjETil2tIfhClSbNBEhU
	xjDREF7Ch5Eve5A84NZp7QT0TMGyRG6YYLwa44WTiTgGeY2TWpsmYpVK4RU67BXvvZVcSJwBMKC
	LqRe4o+vOY6Ejnm5ahjBGR8pwZQiobFAo79BZtgTVZQ==
X-Google-Smtp-Source: AGHT+IEbTWNhdSsCoye5ChJxrRKNCcL1bytD0ny/gbd0G1tPqNJCslwd6wNxX0L6BGInIzH8XxTY9A==
X-Received: by 2002:a05:600c:5298:b0:456:15c7:ce90 with SMTP id 5b1f17b1804b1-4562e38a72fmr200645775e9.12.1753103117481;
        Mon, 21 Jul 2025 06:05:17 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:00 +0100
Subject: [PATCH v5 06/12] arm64/boot: Enable EL2 requirements for
 SPE_FEAT_FDS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-6-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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


