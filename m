Return-Path: <linux-kernel+bounces-767739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6932B2586B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44E01C05D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247683CD1;
	Thu, 14 Aug 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="e1zTqshc"
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6882FF64E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131968; cv=none; b=R8NPheiJzoftQr4ma51b5NYgEw2+5pN0GAF9HfuBrjXwArYvpGnK9J1preHAsXILli1y7Q0izpMoVomuYbuhnfRxIwbXZn96RJzEdMt+m0iCeEJsstCJoq8GJOT+m1b7jzZnplps/LDtVc0pM6KOm6fTs2br5s72KDdKW2XW3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131968; c=relaxed/simple;
	bh=O7IE+ejSOePPSQi6gDfIDMTuvi1ufCtY/CJl7wpk1io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XJrJ2o2DZjeEgvQaxkbjCU1AzQMgqeyzhsLOjzdLOketwO7K0K8bvHQJ6/ls/XW4SZTOYq+5qdN7QpBYu8A0unDLx+e/mTF3JzDOwf81R21D7JgsixEIo5w5icsahysUXBgHMFHjl8udS446rmQSEGqsKBEmsfHmqKtUjMFv2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=e1zTqshc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNgj9K029198
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=1lSOihfzUGPab8epdskmq6Brzg
	pTQgrtOKkOcbHMA0I=; b=e1zTqshcfmmIetIxYgIvE1s2fiMRTNDUhkcp2ZzdQk
	9Yx43lMqmITq5b7DKwKClw8E/h3zWdrMMQIyrC1Z+5SVPCOfa0FlIUqp11HTacbv
	b0ekAscil2+1D3frkLHcPzNBCzYtXtrJjwsQ+H5zJBTCgCGuAxPEPGZN+GfWDwp4
	8N2Zg//Jj447JUcbeLp9CdcyrXaHrXs8NQmUiIX88Emvw1fMZZzItR6N7zTCrKXJ
	p9k8cQB6a5fvK95SBff5qgF8OtJSj1YH2ysXKC1hP4p8h6Wadu5EXPTWwPJCLR6S
	J0YYNdNdknUKZKn+pt4BwBrZSpmDoB4ZouH3LfiFgsRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 48gw544yp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:39:20 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109be525eso11641151cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755131959; x=1755736759;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lSOihfzUGPab8epdskmq6BrzgpTQgrtOKkOcbHMA0I=;
        b=AGHNCoWZ8MlhQQSJkElXV+mH8SZfFmnOhB3MtXLS0Zx3W9l6bF1TVhf+Y2j8ixEofo
         MmQXE9wLRcLQbbizy/78MAPx4thmLeQvqMoDIlMg0D+5ct3cQElHjbFzQWhsQ+lRXVYa
         gEL4J++m5DlgH0HLvUKmgnV7S4LOqFzXfZ0lYiXfflnrJ3fIiK2ni3/tujouR8sszETf
         /PHvDpIcfGhM8t/sMHOigZQROmnhFrqCLFyxdEKTVI14MEkEkgop3ugRV4ulLuWrTEt9
         SBzj16K+Cd4s5subKbHBQ+b81I1b/ty8JvzM0xcFY+y9rts4QYdOOmWLhdV3tbvbfAvc
         Bh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfs3Wdj8haW8VeDSHaGY0DxMDfJuuhnQ8bGqC0OwqYbKX37UXLPnkp0TtiQvs/LrtokbClG6GMs1ZHXuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLoslSkcWqVpEC+CsGgO1SHQCLg4QZmV6oNlEadA3tK/KiqxW
	FZb8YJo3ISxyGGEddEUVTLKVe1jNEbog1rVqumETEuao83dZibHhXhr0HSTjisquFm0sVZSY69l
	juHmzjE2si3ppEegXIE/zjjYLKNbTmAdlLRICaCxGacJHDcnd5x9tqFLVoNU60g==
X-Gm-Gg: ASbGncvDURzM9iTBLouEOYg7syXqt0SNhObTOZmVthiD7yGA0jhahw4rtRli6HopvCG
	qPOrRhrHw6o4B899zmmD7LU+4Eqqjj9w4SM1FJYHM0Pz6d8oLxNkmO0b514T1WRbWMDDaBIieyN
	10YT+XN9PCAPhlO0v3EQcccJ1Hk6Ux5WXE9yWFAPcknsabc821YNHpIHYBYFq2TD8pOuSHvFeAl
	mgvsD6xllzHvkYQOh6gmW4nqCZn74cvPPAyRphAlXmNXXUkB4yQkU8DGLfSqTkoZ7ZbW1Hg9xFC
	Y/cnfbSlsq5qGalrqeyxeTofcuNgHKwhZuyyAq9Ohbhr0kICza3wV8cQVNjzXADNjxhDiOoKfR4
	om6n1ciuUxA==
X-Received: by 2002:a05:622a:5599:b0:4b0:cf35:fd5c with SMTP id d75a77b69052e-4b10a956060mr20519371cf.3.1755131959057;
        Wed, 13 Aug 2025 17:39:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfpfGWrobse0BwUQapUxjeAw1tQ03aWFjrB+6vcenXXQtMBhnSB7KOlKmpNdE2Bb+RvzZWEQ==
X-Received: by 2002:a05:622a:5599:b0:4b0:cf35:fd5c with SMTP id d75a77b69052e-4b10a956060mr20518991cf.3.1755131958543;
        Wed, 13 Aug 2025 17:39:18 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-183-206-55.red.bezeqint.net. [79.183.206.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c71068csm357825e9.29.2025.08.13.17.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:39:17 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 13 Aug 2025 20:38:47 -0400
Subject: [PATCH] lib/crypto: ensure generated *.S files are removed on make
 clean
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-crypto_clean-v1-1-11971b8bf56a@columbia.edu>
X-B4-Tracking: v=1; b=H4sIABYwnWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3eSiyoKS/PjknNTEPF2zJJMUEwvjVBODtCQloJaCotS0zAqwcdG
 xtbUA0b/gnV4AAAA=
X-Change-ID: 20250813-crypto_clean-6b4d483e40fb
To: Eric Biggers <ebiggers@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755131956; l=2701;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=O7IE+ejSOePPSQi6gDfIDMTuvi1ufCtY/CJl7wpk1io=;
 b=1ZKUlxBymgujUOGOAaAxqgW7+GP++NlcYPABLpIEGJhUQQFl4G9h5w+3oVmTlY2QzQHD7QZGL
 Q0JSzwJoopdAydmNpPkaYv7+So36WbPxmc7wRrEBa/364BE39K5V6w+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 2aIZtEnCm_SDyhUBO7WHThd-OHC4QuLT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAwMSBTYWx0ZWRfX/V6yVFRBtW/H
 BySsNTdu7NlavmOhxaMYf02ZusWGWqj+cvKbGXtltuYNHfKoOf2crsWaRMEeAwNL/ima7xT1Dd1
 etfcRe/ayYAm89kB/2YmBoBkzynepyTdOiVs9EguegALX7R9bAa0/21qONhesx/phdHTDvz4RvT
 fwfDAUxM6HV/dcQVwj6jKaUPpBwHgi4iXdC9/PqiC9n2xXXp6VhfwxZpFA66oHqgKgGt9TMseE5
 lhQkB2p4LefsrEgU6bRho3WboYyCa9YlIjvWlesQgftRhm85wiccOJOusMzNsRVjFc/KyTCyYp0
 Wanp/EMLwY3d5e9DvRhYrwlpv9nq1/zKNqfW3LoX+E9Qx2L9YUOILw3/H5MvUTFGxBDhVYwQsYm
 GFaRTbEA
X-Proofpoint-ORIG-GUID: 2aIZtEnCm_SDyhUBO7WHThd-OHC4QuLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=10 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=10 mlxlogscore=235 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508140001

make clean does not check the kernel config when removing files. As
such, additions to clean-files under CONFIG_ARM or CONFIG_ARM64 are not
evaluated. For example, when building on arm64, this means that
lib/crypto/arm64/sha{256,512}-core.S are left over after make clean.

Set clean-files unconditionally to ensure that make clean removes these
files.

Fixes: e96cb9507f2d ("lib/crypto: sha256: Consolidate into single module")
Fixes: 24c91b62ac50 ("lib/crypto: arm/sha512: Migrate optimized SHA-512 code to library")
Fixes: 60e3f1e9b7a5 ("lib/crypto: arm64/sha512: Migrate optimized SHA-512 code to library")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
An alternative approach is to rename the generated files to *.s and
remove the clean-files lines, as make clean removes *.s files
automatically. However, this would require explicitly defining the
corresponding *.o rules.
---
 lib/crypto/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index e4151be2ebd4..44f6a1fdc808 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -100,7 +100,6 @@ ifeq ($(CONFIG_ARM),y)
 libsha256-y += arm/sha256-ce.o arm/sha256-core.o
 $(obj)/arm/sha256-core.S: $(src)/arm/sha256-armv4.pl
 	$(call cmd,perlasm)
-clean-files += arm/sha256-core.S
 AFLAGS_arm/sha256-core.o += $(aflags-thumb2-y)
 endif
 
@@ -108,7 +107,6 @@ ifeq ($(CONFIG_ARM64),y)
 libsha256-y += arm64/sha256-core.o
 $(obj)/arm64/sha256-core.S: $(src)/arm64/sha2-armv8.pl
 	$(call cmd,perlasm_with_args)
-clean-files += arm64/sha256-core.S
 libsha256-$(CONFIG_KERNEL_MODE_NEON) += arm64/sha256-ce.o
 endif
 
@@ -132,7 +130,6 @@ ifeq ($(CONFIG_ARM),y)
 libsha512-y += arm/sha512-core.o
 $(obj)/arm/sha512-core.S: $(src)/arm/sha512-armv4.pl
 	$(call cmd,perlasm)
-clean-files += arm/sha512-core.S
 AFLAGS_arm/sha512-core.o += $(aflags-thumb2-y)
 endif
 
@@ -140,7 +137,6 @@ ifeq ($(CONFIG_ARM64),y)
 libsha512-y += arm64/sha512-core.o
 $(obj)/arm64/sha512-core.S: $(src)/arm64/sha2-armv8.pl
 	$(call cmd,perlasm_with_args)
-clean-files += arm64/sha512-core.S
 libsha512-$(CONFIG_KERNEL_MODE_NEON) += arm64/sha512-ce-core.o
 endif
 
@@ -167,3 +163,7 @@ obj-$(CONFIG_PPC) += powerpc/
 obj-$(CONFIG_RISCV) += riscv/
 obj-$(CONFIG_S390) += s390/
 obj-$(CONFIG_X86) += x86/
+
+# clean-files must be defined unconditionally
+clean-files += arm/sha256-core.S arm/sha256-core.S
+clean-files += arm64/sha512-core.S arm64/sha512-core.S

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-crypto_clean-6b4d483e40fb

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


