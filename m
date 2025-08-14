Return-Path: <linux-kernel+bounces-768418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B5B260E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04ABE17E693
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA20C2ECE8E;
	Thu, 14 Aug 2025 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVE1kZ4D"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712792EA72A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163562; cv=none; b=f7FxiSIxWmka1qDhIUFThnbQlpt9zBnqiLWzLoqGkh4nUldyF4TCxglOyi6GyFs32O5Z9tHplcy9+SDIHGLfJttZbw6mbgcgmLKbs1KcK4es19GKmxeL4X35vOqUFd9983D0RblTmG4qT8AaTxYEboAKoRFKHlJ4QpJqZPgNKDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163562; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpQI3HiCfs6Jke35jisJ9dtAnJRJRca8/HLmsz54Ve7LjeaJAKIerEV3zVgC6niTPHft1i31vchMXhVN2ZyyQoFGjk8FMSlSm51d114Nz03huCqUaQhdLFNsi6vSVVfkutbPOndK9ymRR+boEHDrLW5KNcw1u7QEyVlnbx0cqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVE1kZ4D; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso3225235e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163559; x=1755768359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=dVE1kZ4DMWvjobvT1UbW3o+gMQ71xDrIorQujvcxwL+bteea2tnhFv2zL1jsuSw7dA
         d22C3relist1PqWR8OdDQ0B3PS8qL5fifNTbjsmNyiBNtbdSKdYUEygKwnwfXgTqQhog
         mgrHyRMq8L2J2xdlUeFIlZQOW760vJliGPNvNnwIP2J9+TtMRfot9vje0YufpRBO9ilb
         dsh8vDl0e6EQsGlMWyG7Kb5FdZBQ4u6UZQdVZNQCBTtrDVc0Dc6dO1cAnjzRvlG9tNLI
         s72tNplwzYN01Upc8pWpmZcLx9kDNMPA1CnQWYcAVVa7R7ekUkYTIEF38LyN09tLG27y
         z1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163559; x=1755768359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=qHtgYP3/PJLV7MOIUwL1zG563WLAyzSB2JiSC8mNxegBKP1D8hgUf8LeQsESHvMEcM
         eVHVfGHT8wgxJpeME9rCF8//9u249apeZX1GHcTlEwu2+IFRTNGH6f3025NJz6GPUWpF
         AUc2BKfg0Iq8AQEqSEZ9/Ezds0tP7WHg3Z3Smnvw+8WwCJi9Si3EfQkPqYf3bldy4sqI
         H50YNhCkOPL/gBNTo1SeDb366TC9rW95YusyNOc8nDZTgYd3GQy/tVuizJeKWoS4eH9E
         43pmazpsiNTOMcvAfPccgzZC8RP+Tw7UJF6jrydbIKBWf43HzS1yJKbrKZ7h1IMRF5qY
         lLnw==
X-Forwarded-Encrypted: i=1; AJvYcCXBzwZVqFjNq8qZkTS3YUEI+/APNGRogBAokD5pL9oGf0vPFppnzeNu2UsyfDm3GiZ7BreSlWqoEOkq7Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRo93BbRNUUdj2FOs65KHA446enuQ1CXzrkzh5wj3CCOnM7tWn
	bPokc3INbASoJvKDyaeMLj/V9w+nzkodHIbgzT/NRa5KDDhRdo+HnEbemFYbHWbuZ9Q=
X-Gm-Gg: ASbGncvCW1/btr6oYvQJDYUbeIqeapodKHtUr7YWXkDSXyUG4Am2P+5llzP5zKcsKy6
	1sPy+7Z9JgUCEMpyzKaOmQr57X9D+lW3xB2BBhOKdmkHADMozES3vqV8j28C+AwA31WtwWV8Y5y
	DutI2VoYJ08/Gm4iWNy/ksNzXNcCsRFcDWZUeKZ8Z1ONQzJLwE5CU3KYhxnNezLQczMWISHLVAl
	RSAnU+SwZj30qRyFb2wD+CTaSUJFCPFFp123YyFsqoNXaV21rzrAyfIOj4U654g4rJ8X9kJVrwq
	+lqa1XuFNlTfGcRnD6DK36D1wNkd699f0gjUbGnn+AcDqKReCTKaP0yIZu1R2GNFTpiBaF7p/lw
	geU9w+pRUbUGU3h6KSDZUr1EY6bhitY4=
X-Google-Smtp-Source: AGHT+IH3aH4s+NYnAVYfqbXpSrP1ix9p1QHXe6mSxBCrVv3jDGybUKX6JctDT3xmTAkJSTP0/FwOIA==
X-Received: by 2002:a05:600c:450e:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a1b6753a2mr19666565e9.31.1755163558609;
        Thu, 14 Aug 2025 02:25:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:25:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:23 +0100
Subject: [PATCH v7 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-1-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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

Add new fields and register that are introduced for the features
FEAT_SPE_EFT (extended filtering) and FEAT_SPE_FDS (data source
filtering).

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..b743fc8ffe5d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2994,11 +2994,20 @@ Field	0	RND
 EndSysreg
 
 Sysreg	PMSFCR_EL1	3	0	9	9	4
-Res0	63:19
+Res0	63:53
+Field	52	SIMDm
+Field	51	FPm
+Field	50	STm
+Field	49	LDm
+Field	48	Bm
+Res0	47:21
+Field	20	SIMD
+Field	19	FP
 Field	18	ST
 Field	17	LD
 Field	16	B
-Res0	15:4
+Res0	15:5
+Field	4	FDS
 Field	3	FnE
 Field	2	FL
 Field	1	FT

-- 
2.34.1


