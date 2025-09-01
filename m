Return-Path: <linux-kernel+bounces-794575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39EB3E386
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8DE164870
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4C321F4F;
	Mon,  1 Sep 2025 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSLJ8OHF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0859212FB9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730514; cv=none; b=DJAPdsAEIjYP3HpD+TkpqXtkoNufbwPAi1EnmTQG+vYb/3WPLlrtt6+j34qF6n7wjX4YxyRjTqC35NmyQpGvDqx7IqLBvxta7I7z/7WYXKdHJ1UOtDiERvs9mEfbA7XIZG9TqWKaBkkNJVAxX6LWHw6dS+eUP8/jXDxIqM1Ib0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730514; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2uV5UrtcerXJpA6E+bW2mBZMlYgDltBZZs3K0JdEw2Oq99d0krRuYrCdj9dqf/UbcnrSA5q/ezUCdbYgBhuwkVP7zcb2S5uUmJBJysoL/uJD1WpNPCZ7F6ZzXDxMkQVO9agrL1AyXNzYtwNYWr2LLo2U99WNXL0jfunWbVy4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSLJ8OHF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so6204815e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730510; x=1757335310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=KSLJ8OHFtKsK31Tw0zIpqb4zGK/GIZkebUUsXm04g/yN7z9rANcdK++IHl2GGgvR10
         VbKsEwO8pHlpyPDc/onLGlRyKyOKpO2Gz6gH+T7kITDRZnkXHl1E/HvHFOA3zd15KS02
         3DEE82X6JnAEVkaRLhdCDPBagc/MaeBwykBJzs3Be6WfQheQwQ7Y4Bqn8yWzPFzDJ+Sk
         WxTtZhIotGOdpb014s37v+pWQlBBEjSMnJO5tMbShwijUZNNkiYStI644IBez0UUY3Hp
         inSCquu5VgIn990JofdVJiG1vCOQ41AlylV47uLclxeQal0tNCIj+nxv9BUWVfsDtSUH
         Q8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730510; x=1757335310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=Ix0NLrRWz+KgfF3ljNb/ImcgPA6Gt2b1DbO6clEcAp1LGG3PTCzLjyDeDyWH+itii0
         hzeah9lXjCowYYH46vA5UmJ6OpEX4bVLoNtu7PzQNhBpgsAouhZoehSe7PAK8avm49Ko
         azUGwIYv2rb96PvpJ216rVfgVZOtZK9K+MG2b+cwTH3EnGriAE47pNnFRFxXN4MltAZl
         TJhc+ywjHhWJlbRCkyqzi3KfB3gGh6tpwHmRjPRSLJo6oqdT2s7624XYB518VKKQOkgu
         ruzLtBubt8D+ksz5PdSiCFfYQ8yuTUh9YU/MTMfg68klMb4tyUwvcIQfx5PG+y8lv+zx
         tm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+P6J+BZnffZ0NZOKZxVUgZBPQ9KM23+UGF6obN6/nrToZY307DulmMjQAujxHt9Boy32OPAXio5UstjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyv009ifcIKDgJ9rrbu0eCputuz3cako+8uCmpSbjt96qcj8tx
	kfaJgRjYO4dAmMsZtbjyNv25dAk8YeljTawcZRDV1nfAmonmTvhteLy3tZ0xjyBd5pE=
X-Gm-Gg: ASbGncsU4+hgYqbiu3zVGx0ue7y8RSpxyTroDnA5WRUDtPYgx4CtHlEXn9JWGU/n8dA
	ToDRfuykNxFmR8nvEUkA5G60pnU79neCTc4WkSbNZStwuF9mbGpAlNPjUcgnKSBYyePuk+/J5lG
	bnzgV53Hd/TL8B8bzZJYvIuHi3CJWOXnbRoe7rEuytzV7HnXMEY+Mr3xT1IcO+Yg5OXwuaWzG9e
	FeVg2duqWiFnKDsBqzJ5xk23jVcRMO4glT0+WOAF8M8ntnsZJiqilA2NH19AI2IdMQtwbmTrcPC
	r0w9Mow+V1UkbbvE6a+J8CMff3BGpEpBooIDjbEhN937358AzJabHE1oDYbwBrDIBcho0UbSHqs
	0ViR62gNIH8Jwnfqqn4yRR/xW4SYUzE6dMZZ7JMPemQ==
X-Google-Smtp-Source: AGHT+IEpKxBP9k/vYtw8Ht1MbnsTYjDO7wEj/uW0QbGaAjhmSNIBbT3ZI/wMtrWxLNIo5Z9MYwmVUA==
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr50627485e9.1.1756730509844;
        Mon, 01 Sep 2025 05:41:49 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:30 +0100
Subject: [PATCH v8 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-1-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
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


