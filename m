Return-Path: <linux-kernel+bounces-852915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AD2BDA372
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49F16355910
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCB92FFFA6;
	Tue, 14 Oct 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLwUSO8I"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D52FFFA0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454279; cv=none; b=rvR+bjfzkPuLmjhguehGnXtKOWAflJfMYNG7xSN/LvjvhVxxRCRGmp0wJcg4FILFZDFOvM+ABFkmCY/+T91PRPQt0ap/zem7KBWzBryVDsQABNwaEB/8iGs01tJmSINzUvIv0VgRIgGtoiXntVCQs4j+0IDKD13maySBTpd3hMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454279; c=relaxed/simple;
	bh=C6Dad8JPpdCuqjz4s5GhSEa3XOS5lpXoC8lCTSueqRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDgjv7gQ5T48k1RaFFXeT+H+cCeNrdNrMftjipfmLJySl6FkkFW+UXFmBopzlquT1NzZvnptV4sECbMwlvDGdJhNZL0+SoSxJvKJ2zrEMx6gMgUDRJKaprLkjApMAh32dObaItTv4JWZCjt/pmCsvb7wW+oa3YMqc/RWJcfPGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLwUSO8I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso5840860a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454277; x=1761059077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=kLwUSO8IXDx86Hc256rzNrF+RWcYtp8rDCwR2okvRkJcGu++Flof4Qq3zVz1A71dp1
         ByD0CosaP3pe80EZz8noDOwMIqSdMZAy2E/PQPLI3W4nO8OMBa9A5GgU4ZFNhpIwtJ83
         xgq93mxszTUoLffbM1UDaOSBZ9prGqV0DRo0VL1CZr3fIzmiXky7/6d8lH2LTCsBXDqO
         LPIHgVdtvXuqbjcg7Fr4UsXRkoalntbRzJvVolv/CQpiOS/eQgpyQO4U3lmt0mQ/Jxy6
         lnklAMIeYksI2Y1fMSbIToWCihUOKXac3ehCdd+ySq31sxwi95Z3RxRFhI8JXlykUr6w
         BCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454277; x=1761059077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLtZQAdEAm9Qpl1KbOMuUjIonMp2MqyrH/XDjYnJ7DA=;
        b=Q7K/5sgbZaL2Uksrg0YlD0kOIZHN1K9bYW6ZC2kdpfg9JXvE2vUHltvo2Gcph4qytd
         FntX57X6vwQf3/jbMmAqmoFAhg2638LWG9PDE3/5Y1raNRL2+oW4eRUM1vYDARnqzA8z
         CVu6FxPl/pnwtboCh72og6X+kYP++LdLYHGzaFlzwvotpE6jE9pOpLp2N0J8HSs5WnvX
         q9j0uk45EExk7eoMzbKiZjFAxQtNATVoakCRgvgExN/Q8dKRVa/0q0Dxnec4Vzbq54o1
         Anju95uQ6H+LuRnjpPbK5QCD+07QXxJlBdWXPF9S5tu9HTnMLgk1cECF04AmqzvtxBQk
         nRCg==
X-Forwarded-Encrypted: i=1; AJvYcCW/bBnA3CkX5sWshLWjwHMSxcyULwQauOEN2OkZgOMVmJtdeT7MaxzV4dNUlZ/+d9HUu3oSHYZMD1OGcRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWfnTlx65QBg3gxW1kJiUgrl321uOjjMjhAsLVjDJrmCHWrXZ
	f0vKDNSoBPcuKclLhavRhiGpWPrHn/E9AWylDpXoqcywpX2SmvbUpw/7
X-Gm-Gg: ASbGncv6ThvgMwl2UvCRmKCoUY5BCp4cLvKKIIsUU7SUiQaL/cpz0wirTUXT5vX0ceq
	58wc3iuqsHhAjYl7Q4yDczuQQrfKwILfclFFBPNSmyoENq9dwAF2kOjZGqe+nFa/vjx/0Feag2k
	PwgOiGhRzFyeZ+6vVd4q778wnTYH8ue9ICkTQWfZ2BC+FL9YqIhF2vOoEwzGPL0DiT9F/dPMbSe
	vLXUTa8oVXkd+ZnYtYOlrz34bjNaAia/f05gEObaD7NXNid32ReLxpI640HEdxsRl9ewtsL4ipq
	TpT7AzA0bzdnzlg7pYJHIyCRLhlP4DV7z62Ujlj2+NyQCqSwwsQ0Jmqsktmt+I+HRpqxlYnbOtv
	0NTJfH+u+Poqmd+fzbGJ1OZ+MuHbHiM9mJBoNX9CxeRh9d91h44e9Zw==
X-Google-Smtp-Source: AGHT+IHOP13PRRe4fGKU2dX23aWl9ytYNiSEVee2M+QWQRc3N0N3lx+44qmDmxKAuSsya1+ebXRuBg==
X-Received: by 2002:a17:90b:1e0c:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-33b513ebbedmr32981127a91.34.1760454277165;
        Tue, 14 Oct 2025 08:04:37 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:36 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:38 +0800
Subject: [PATCH RESEND v8 05/21] drivers/perf: apple_m1: Support
 configuring counters for 32-bit EL0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-5-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1977; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=C6Dad8JPpdCuqjz4s5GhSEa3XOS5lpXoC8lCTSueqRM=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZtj5N/ZWQEde4e5ZFUO3AlX4qFFD8lhBDKy
 EoZXWDxP9yJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbQAKCRABygi3psUI
 JG4BEACXO8SeA3FJFQKbiTtnTJEBCSvQBz+ZfDqNYwU0oRv29B4KlTl2p+d4t5UTnHnfWgMqObs
 bkqHaEX/JgaUrBV2p3EF4JiZuTzDM9CSxpmhMX78n3PBWBy8eEiYI3dnXWyVW+kO82Aift2PjhJ
 On99dgGH/wkolrZE9y5qo7X4YCBQ2s9BeaPSnqmH71jKw/IEc+pGDvAaZqQyx3/7A41BXBRBgeU
 x9oNiTPEw3rmIoTtkb2V2125TXN8qJNdiuYLNJrTALHCJ69Fk2T4oYy9HIbRnK3s34PZh0Nh9IT
 cSokHqlhB9GMMWwsyBnHu5PTPME6609MNPNZNrQ8kjBWbXrJiZoWzX9x1wJDmUz5csPVa/Io34Z
 7dMfpQTdGa6ihQARW5mJvso13v9zKBeEvZUi4LjnLZ0xtv7rX759VWCnEKRpdLUdXECWI3FHbEj
 IHSQLtDohunqO6ZqtI+I4y3rSqxYhSOKSkqMWtU7lOlNjcB4PUpn62xKm09AknM5UGAwhwO5KGb
 R3gW+qMf/ZxKw4hat16SIjSQq7JlO2jcgviXIEYRO2k6lWtHYivbJKTJ3bS2sOJJXHr0ME80/Tk
 bd0GUypd7crXvpMhwfv59mKAtj9WrEUsPNIKVbZMZ/dympBIbjomJCSo09nTQShOGWVi1PBN4cF
 X5JBu3phEhVYSCQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add support for configuring counters for 32-bit EL0 to allow adding support
for implementations with 32-bit EL0.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/include/asm/apple_m1_pmu.h | 2 ++
 drivers/perf/apple_m1_cpu_pmu.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/apple_m1_pmu.h b/arch/arm64/include/asm/apple_m1_pmu.h
index 02e05d05851f739b985bf416f1aa3baeafd691dc..8a667e7f07a517419c22a4f930947347be8546f7 100644
--- a/arch/arm64/include/asm/apple_m1_pmu.h
+++ b/arch/arm64/include/asm/apple_m1_pmu.h
@@ -38,8 +38,10 @@
 
 #define SYS_IMP_APL_PMCR1_EL1	sys_reg(3, 1, 15, 1, 0)
 #define SYS_IMP_APL_PMCR1_EL12	sys_reg(3, 1, 15, 7, 2)
+#define PMCR1_COUNT_A32_EL0_0_7	GENMASK(7, 0)
 #define PMCR1_COUNT_A64_EL0_0_7	GENMASK(15, 8)
 #define PMCR1_COUNT_A64_EL1_0_7	GENMASK(23, 16)
+#define PMCR1_COUNT_A32_EL0_8_9	GENMASK(33, 32)
 #define PMCR1_COUNT_A64_EL0_8_9	GENMASK(41, 40)
 #define PMCR1_COUNT_A64_EL1_8_9	GENMASK(49, 48)
 
diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index b5fe04ef186f04b4af32524fe433afb79979b791..fb2759069fe9e47146f0342fa46e40f3ab836926 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -348,10 +348,16 @@ static void __m1_pmu_configure_event_filter(unsigned int index, bool user,
 	case 0 ... 7:
 		user_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL0_0_7));
 		kernel_bit = BIT(get_bit_offset(index, PMCR1_COUNT_A64_EL1_0_7));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index, PMCR1_COUNT_A32_EL0_0_7));
 		break;
 	case 8 ... 9:
 		user_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL0_8_9));
 		kernel_bit = BIT(get_bit_offset(index - 8, PMCR1_COUNT_A64_EL1_8_9));
+
+		if (system_supports_32bit_el0())
+			user_bit |= BIT(get_bit_offset(index - 8, PMCR1_COUNT_A32_EL0_8_9));
 		break;
 	default:
 		BUG();

-- 
2.51.0


