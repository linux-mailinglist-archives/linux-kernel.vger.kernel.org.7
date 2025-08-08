Return-Path: <linux-kernel+bounces-760147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1EBB1E71A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC0072803C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE82749FE;
	Fri,  8 Aug 2025 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omJWWZUz"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC002741CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652229; cv=none; b=f4s1VgIomDWnns2G3ecB4PWeTgsoHH/lo3s70Bnp6c/D2pL8Jq0fFlpqx+2iLFphVfiC7ND/vhI9lGSIdZ56TJSMiAKYP1C8QzMYs5ZqmtEVn0AVHgtTPkUCQlaDIzh+CASp3/udj4JKtKMoM5yI7cVyjUvkkbQG7s9uT3F/aaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652229; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FcDx+EYeV3tl0OQ7NaELsbYQ0xrS9fF4ZvZDRMneiZqHu9qW//ICt7ryKKLj4/OHgclA6YeTSG7s9TTQL3N2m10C5pFOZqC7yE+TIZMRwkrBqGrOqMlES0I5QADfslnoSwnHBvk6l6yEhKWtB/sNRta9hPQWDxfMGRG7mEznRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omJWWZUz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7910123a0so1778446f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754652225; x=1755257025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=omJWWZUzdcFut4gg0WYJ+7sTVTNsy45LpZZYfw9yGhUcPO02RcfstVFxNLL7WnUuxM
         TsZAk2a6ck0VKlFRqp2N00Dipo9HlnD7hqve8iZpZ3uFJRkwpEZW1gUP0THmSoMIqINv
         q5Exza0HwePNCIjnoBfvZSfy3hDMfNpcvCvfulzLkiVT9mnNs9AukNg67RFcm2yc5tNS
         F5ZunCkDvQO0eL3dEYkBDee04z+cWvDyZWV9W7CAPO72P+3SpiollnpCoc4akehWQkXH
         xrpyHF+BzP+ZUPHSm+Q5PvX2ag1GkIOZ/+WypxXwu0drJz9xYLYj8vVZr8vhWJUZP4y+
         r7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652225; x=1755257025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=QC/vuj1imEkbIXFs8WlH4bL09IaCYd30x98/ZtPi4uNczXzDvwH0kes/wotwGH++qu
         bKxzxQ301HNVCQe/5zjNFZPQwMBdia2mdfJWaooTarxX/p47IlYaipOtKeKuzxhJPxAX
         /PAqHB7wsVYaz5b4uQCAXm0FmSnzvMDP5zmyuP8BOUIg/dWZLtpjLKvDW0BUlzk4yZOE
         Gx1pWp+i7d7gVEABpMQcmeXXLKMzGvIzelFMR3JCd9zIAteA3coyKKncvsD6vgK+Jfzv
         MLVCT9TWc7zentsWn8aFXg4rZR8vTR2HcdP6quII3PybjmaAMWlmbf5GAk7WTMu+9KGf
         gr+g==
X-Forwarded-Encrypted: i=1; AJvYcCVoB6PPgMuWq7N0x5k2ywzhxSEvR+YWIjYS/Nt9H3bzD+/uvJmRbVy3UDWzO5DnSvD6qF52o50HoAngddU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JtFgB2EzPiBiQVS7ojxiTimtcvRBlolkQRSKHdspZSd+oRu3
	SETRf5ydYdjpFqkme38Y6Qlpvgk82wauf2AqDWewW9Fm51xkxvqq1nmgT20TXOHCn1g=
X-Gm-Gg: ASbGncstoNdnGpxlnmbyTTNeqbOwMNn/f7eYqATF0t7oR4Aex0zg3LCcMlcjc8i1zVv
	vOjkn1RSriWzWdd7h4xAX+XUZrh+Gyp94+iJFd/Jyr3EHjly/aKmWARKT4o3Jn+LuX1zkCjscGu
	I9WnycS7DuMoIftqNRPtNEh5RXtjZNzQxAXDDxRYKxP58sJakFRn71Gf4ApcMhPS0rJtlF0xl3A
	6CkTV5db3/JghW9fhk3ypHYrgpeRadmhSrYNqw02Q3TJbpLjT0k2iLwOV97uFocmKv6H+g8PH0J
	RSwmk7stvJXeUm/wLk+Fl98Qnn8nKxzlJtrHTyz1eIW980VaxA1TOtD+SQCeJputsPJSZWlJQd9
	DGoAPh6qyj/dezixoS32qAKNL1ArEckI=
X-Google-Smtp-Source: AGHT+IFB5Rhb7EHeEiI/ams6KhI9UuNHFiZtaUNiO/aRfCno9CNSrWB+oIrGqone/4N7uev3L98hjA==
X-Received: by 2002:a05:6000:2083:b0:3b8:d493:31f4 with SMTP id ffacd0b85a97d-3b900b83c8bmr1969857f8f.48.1754652225356;
        Fri, 08 Aug 2025 04:23:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45923c34af8sm233482635e9.24.2025.08.08.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:23:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 08 Aug 2025 12:22:58 +0100
Subject: [PATCH v6 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-james-perf-feat_spe_eft-v6-1-6daf498578c8@linaro.org>
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


