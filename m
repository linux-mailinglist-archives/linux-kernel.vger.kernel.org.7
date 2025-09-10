Return-Path: <linux-kernel+bounces-809881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA6B51324
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482FF175DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8625A2DA;
	Wed, 10 Sep 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2xc3j8G"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D71DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497679; cv=none; b=up6iiwRNbRrbvilJDTWn+g3iNLkOpz0qzYf1D9qofTIU/WYDnF9lRbYsnCSYpxoeqZQ12G+o1p5Nv2frDukPmWslG56H1Mo4CQJ6918uSSvD1cVpGIcNdIXuJBeHZBBWAG3VEj9dgEwTc9ob9Kv49Z517xLR9QyVTafisekVbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497679; c=relaxed/simple;
	bh=GmmpTTTP6WPJ/uY7/U7KwXc8e/XFB8UijHtKttx8AzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hdifD2VUUyEM9moXlIuIRaAg1oB58NL8wuYVtuAB4G3nHe97oHs5845hCxNEybyERB+SCrC/Ae7GYV/UmQxqn2+eqWkPH+bg9PTcrbKPO2O0Kbgv2iQ+pLcQWxItflL28PvNBW/9mNNA4H9mjjxDil5KipNqKFRHOcN1ktIucDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2xc3j8G; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso6651033e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497675; x=1758102475; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3vn6PSgl/mr0sMmi9/Ua5wGgFfCymeEDaAVR/5gAnlM=;
        b=L2xc3j8GCkcrrqY54KxcW9DSCeaYVJzq5zSqWG2uSt2gwhUNscysHph6Z/2srmc0GG
         OiwuLIW0fXueE9+OrdoLpl1XP4hpgSbkceGmuSlrVF/2yGzKIpsjxeLotLlJs/R3vaZr
         A7g+umOg2AIuto3INGFGg0Mf3Q4WL7AGz8AcK6O27/g0pC+qg/CsEsHD9ZsRyNwvxyJb
         LVWU7BuoTdOtDsnz4C5+tp8B36X2yWthY46myyDlFE+P4sL+SCrlulG+WGtrK7g257pu
         7kBSXtEJwWbwF9EXkvt8CBx57miVWX4yenhaPUrh92Zh6ZSlGf46bZew+mH4NwaVcQ/I
         NzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497675; x=1758102475;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vn6PSgl/mr0sMmi9/Ua5wGgFfCymeEDaAVR/5gAnlM=;
        b=mC2nmda9fWIXbObjuAl4LiMYgqf0sibAkUfca5n4sZiUUlbb86vRwKjFRUfdMUaOB0
         ZmRwGqT3J457a+0ug4pUcBzMQfXIbMSgIR0EBDJBislKvnfHH5R4VUWdmC4C7lhqNCnO
         nsZ2gt2a9snmuHajnf8VBK8Z/fU3TyrpnsTVPLfS9ZeJd58dcKFAxS/76MhcVLfGzqD6
         XnuItwF5ELCN+8CweXWAS/pLRzekpM/R5ySg4vBybsRCRFz+UjDZgM3qk9jBo1cWpPpb
         qQRX/+3AeRD6y8sDssV8e3qry5AMg2O3dOaWoy2U3fMic9fV52P2+q5r4kDPjikWQq1U
         0nHw==
X-Forwarded-Encrypted: i=1; AJvYcCXtCzwjhILa6C/Yq9BCFHFMDGx3wpshJgqvZ/EC1vS8NdxIlZSCnPexNivaMoTZDOf30/0t2UAlFuhSsDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TcIgKVGxS4IBJ+P3DKb7YglNFe1JuotUwNLm5KgIwJoQTDBX
	H2OYUS12GKzs8a6Xkh20twdV4IGeMNEmyS09R8zIr4Kq0UTQGH80TwrSHQMZ8XELxiI=
X-Gm-Gg: ASbGncuLMd0PywVCIVi+rRUAYwDBTKOLpx+Uqem1GjO/bSlrZBC+2BrlzMz6XbEb/Qn
	7KUDmrR4v2aU/eGBbtuPzc76eF30os4q0P+qRkDPgIAlJsEmoLLnXjurRFHfUUyRt/LTA7+jEFb
	KdYojFVR7QwFCCUDElTlFKbdjCNuf+y01j9Fy19EeKyu1N7cqjLLSdG4CoG0d0VaXJOBnplCmYS
	8TnptMK3eATz88fkX6IB6qpi6oLGe00a/j/g+c2p8pSopE8Y4EvOqUC0PxLIeMK/Vz4u8GBGGb2
	lofCjtksyoHaK5zarPtpLpMx2QAcP4cA8xZz6C64EkfTNhfvCTcC7y0t/2yvflwk9aFPuofY207
	3N9IFijZ9FPcQAbDClPFzdxDLWMIktuJd
X-Google-Smtp-Source: AGHT+IFtsFoIkWeV0W6TKqeUon3LMVDpZHDcWlfb3zT8ScMuOJij+KRvziNm4yRPVu1pxeCaBRtljQ==
X-Received: by 2002:a05:6512:3d07:b0:55f:4bf6:efed with SMTP id 2adb3069b0e04-562603a10famr4438159e87.1.1757497675329;
        Wed, 10 Sep 2025 02:47:55 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fa5sm1139655e87.25.2025.09.10.02.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:47:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Sep 2025 11:47:52 +0200
Subject: [PATCH] RFC: ARM: drop support for HIGHPTE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-arm-remove-high-pte-v1-1-d0899882815f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEdJwWgC/x3MOwqAMBBF0a3I1A5ExYBuRSyiPpMp/DAREYJ7N
 1ie4t5EESqI1BeJFLdEOfaMqixoDm73YFmyqTZ1a7rKsNONFdtxg4P4wOcFtnBLN1tMTWMpl6d
 ilee/DuP7fg5UmHtlAAAA
X-Change-ID: 20250910-arm-remove-high-pte-6ead9c6eb336
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Russell King <rmk+kernel@armlinux.org.uk>, 
 Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

Matthew Wilcox suggests HIGHPTE is a burden for the
kernel MM, and only one ARM system (vt8500) is currently
using it.

This deletes the use of HIGHPTE in ARM32 clearing the way
to remove the feature altogether.

It was introduced in commit 65cec8e3db60 "ARM: implement highpte"
in 2009, so this RFC is intended as a discussion item to
check if it is still a desired feature 16 years later
or if we can get rid of it.

To: Russell King <rmk+kernel@armlinux.org.uk>
To: Matthew Wilcox <willy@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-arm-kernel/aMDYdp3H-yOHU1Pm@casper.infradead.org/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                        | 11 -----------
 arch/arm/configs/vt8500_v6_v7_defconfig |  1 -
 arch/arm/include/asm/pgalloc.h          |  8 +-------
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1f3df39ed4068f215a3460d5c4e021136438eaa..5545583946a2433f86a5ba2d6ade34f5e931ae74 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1229,17 +1229,6 @@ config HIGHMEM
 
 	  If unsure, say n.
 
-config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM
-	default y
-	help
-	  The VM uses one page of physical memory for each page table.
-	  For systems with a lot of processes, this can use a lot of
-	  precious low memory, eventually leading to low memory being
-	  consumed by page tables.  Setting this option will allow
-	  user-space 2nd level page tables to reside in high memory.
-
 config ARM_PAN
 	bool "Enable privileged no-access"
 	depends on MMU
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 41607a84abc85adfc9d8d2d520354576e1e274d2..a91e6547378136b3e1264aaddcac7d6ddb66987d 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -10,7 +10,6 @@ CONFIG_ARM_ERRATA_775420=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29c0dc619c0929aa761df861a5dd2d..ef6cb3e6d179e63c7edbcaf69e6b21847b354a0f 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250910-arm-remove-high-pte-6ead9c6eb336

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


