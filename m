Return-Path: <linux-kernel+bounces-739319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE77B0C4BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8817AFCC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ACB2D9497;
	Mon, 21 Jul 2025 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Btk3rW9a"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8242D8771
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103113; cv=none; b=AcAQFNeznwmxjXujNVHrkOtJY0NytU2bLg5pRLQixVpgRVKuRYCcU1rdsgG8BYBi5ZiDZ5ant6Fboq+GgMfo/hdgEdXJUHIABpIZQIIQzuFGg2BV0m+WV0zgZwlWKC5X1CF+R1rCOpEMNlSUhL0QVOd03tGqvSkxKquwKbSxKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103113; c=relaxed/simple;
	bh=ajsH4sm5qIk98uVqstoVul55QamJ8yj95QFZdJtL4io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZF99VDrk0bs8kwvW7HlsUEnJLunidN6bfIirR8L9sfsDNvDHmVI2HQETUVHxAjG/j5nXoIGvxAh9Gfpe3M6PcPDEAtoRwpdSaqA02IU3yqLTd/RSrMTyOYtJEUBDvXzkJcF3mDgCWRm1nj0BIVtVJQ6uY/pAnTCfipVKQfSU5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Btk3rW9a; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so2141336f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103110; x=1753707910; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgBaXSS6eoL+tzDWl4vbvLMipClDtwiPdRYN3wg5eT8=;
        b=Btk3rW9aWAfCrwcaormqPLZRNf7IPkm8nNVxe7f/iDXNQkO3zjgd14W/Dn0KxScFBt
         T5Wc1drdZDdPTrk2pmiIM19klMSm3KQY44ZcJTVXiPyoYJ4JN6YshoBxgDy5AyhX7kp3
         B+4ZkBl6n+K/Qwh2JaW5YAQUEn76Vvaa+9kXLcn2IZJX+YpU4VwuoRAEF7NvbwE//XOI
         TmYmbN3gTfSaFKk9fC1e08wExe8+9YN1bSBJpqIQ/aXO8AS676J7XTKYbjWi68bdg01a
         MXzJYkZZUIDOc1wXKpjW4QiDmZWhdA/OnY1zb+zyyyXq4K5FDN5iiCPTnqY5Bc64+s8t
         mLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103110; x=1753707910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgBaXSS6eoL+tzDWl4vbvLMipClDtwiPdRYN3wg5eT8=;
        b=OAZoZ5Pj7Jcam8U602iQ8LL+2tul+JUzI5wFMeMBrncI4FyWPmCIZEEp1IgMkDsTbH
         3E2ocikUwsuwTZsrYJaTvi6/RkLQY6hmmV3W/l8GxOF8RKe1oT4wQVSf+8EZwL9dFIBJ
         qTbRCYv1nZuqTH52ttjqewUWO10np7s2acIYmLzASM2o7R4TEQiBZw0PIwd16sc1L7ms
         AEIYTRWfk1qt4TVRw71CgiS3SKnkFFd/7TexX6uH8nQR10ZeLW+0nGwBtD2EXg/JPerl
         7iBwvjjIQ1WyG/oPFKzgmGZ5lSGQgeuOMTxCrzzeE2cik4lrdbuBByi2uRX8p6vBVM7C
         1XjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOWrfbvyiTtrxjVP8gDeTnjjsCFGfTxda7GJKDDE8WA1rD55DErxa5fusEx4L/hBuXsgcIePaS+hmu0AE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9UBXmsPp9YnvgxUdnlKDz5oWQdzZlx9M+ArrJ8xHL1vWQDZy
	y8DQM6NSPhznfOurb5/p9fQSujJLDG+OzPrzIi0EvRIsTAvnQ5Oh7UjuakemzdsUDW4=
X-Gm-Gg: ASbGncvwe0IoDI9qqYrkOstrk7S5Fsr8mHIard/EMy59AkgkLsvmMTtmgXxVdzc3BbH
	C8YO2IgetQ6VV7nExaHhiVSJiYexjoFaXlApwrudcQ4y77niXdriWQtxflXFjBUwsscIG+v7lxP
	YVSPiWFVRjkJfFoZn63ZX7Emvbl0M11Jpc/tAs3ZEdp6d/9H1tCcCxBftlQpoa/Ki+m1LkWK9/t
	PxjaUCxF/7QQIyKLdd7iNG2YrAa9NmDywBIIupjrJduxkDkBacEuLsxxuVgvtTsObY1dveyCyEi
	S9ewCb5RgXAZjx9B9JV6OlJYQNKl1RYPkGKO+UBe4hY1aU5/Jgc7B1q3aGnJlX+TqVelNQY1Non
	yKtjGf6pTSDugiOQ7en5Fa9PBvBkoN5s=
X-Google-Smtp-Source: AGHT+IHW55CRAG6BTroVDQBsZVUrLOllfWSe7q6H/nJVZXgEqWqhx0CeR+WIH7uAuxzefIuhCImklQ==
X-Received: by 2002:a05:6000:4704:b0:3a6:cfca:efee with SMTP id ffacd0b85a97d-3b60dd6aa5amr15956756f8f.17.1753103110115;
        Mon, 21 Jul 2025 06:05:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:04:55 +0100
Subject: [PATCH v5 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-1-a7bc533485a1@linaro.org>
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
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 James Clark <james.clark@linaro.org>
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
index 8a8cf6874298..2e897d8a4040 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2859,11 +2859,20 @@ Field	0	RND
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


