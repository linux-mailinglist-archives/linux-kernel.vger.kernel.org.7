Return-Path: <linux-kernel+bounces-875035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F2C180E0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19D284FCE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA32EA470;
	Wed, 29 Oct 2025 02:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFy2gnHy"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753072E7F29
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705129; cv=none; b=mOGkIlmf/rACfVm2sY+VaVEeujiFaCbNhbwzAQ0lqCntVgOEr8XpkEhLD+0CE/pVMFOLpurdqzG6789JfG/E3EPUjlpvVBi4CfI8do+fRi29bXD9pLaZtxj8X7S3PduqhaVK7sNo3P+8+SwlDv0pgus26+RVQzMej/G3/InDi7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705129; c=relaxed/simple;
	bh=zYNJmlon8r/JHG3Xpn9ntElzz/UgGYjwUNixebL2tkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AcyXCoNSBhui26SoEP24BUuRLgF9kG+2ghotrZzsWE6pEy9vxHzkyYgdi6oOYdYnErChqbqALukXa5YVxuwkw9TYavZClRrmZTx32HUe/8lsetI8SpLEeu2EwwN0dm5plgK0J+U53WxIFXAPDvKsf7vPT/AfMGjNgoidV6S5ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFy2gnHy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33255011eafso6281668a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705127; x=1762309927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6qoeYX7P7dZob4Bvz9VKgpFSbzrkhmCImjfBPhgn1s=;
        b=EFy2gnHyZ5BWurS6tG5Li664Lvj8+ODJHoCqwRczBSG6eyikl4oW6KrtnQdXvQPCzJ
         P+pu2ZgXrPOmm8jVfGZsI/S3nu3qWelGIqyFdAwT1k2Xk14NmtBqrBCIIasJxWyYcVFf
         JJdM2r8avql/ynSr7h4qohn+jBYiZi+2qQoRq965wDbL83u9B3OcAppzzK3bh3AH2Lhg
         BJrAmxJU5KKU351Vz5wkbYyP4KQRt/EtYnPAN0NSRqsS/zu6cKUfGAMo0Yg9oFQAhFRk
         2OOhQtxFGtWfOG37roGJA2M5aRPPnyCOtnCruesp7IDFySXvWl+o9/Jm7x0nwe+bDBJU
         slhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705127; x=1762309927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6qoeYX7P7dZob4Bvz9VKgpFSbzrkhmCImjfBPhgn1s=;
        b=DA9zXPWykQpyC9jiQI+UCKfgDlM+uxjW73lfXIgbDfix9zT9Yj4g4Qo6/WVFI0F+1H
         P15jOHqY6/K+NzAbpVy7e1gEXYN3LItFaglIKXl5YZ9sV3OWErcgRJ3aM3oyJ29gJa6z
         jIvSbBnJ+fUiP2wuYCqL6niP79ctCzdOd2r8sNLuiP+Wd5tczt61eIItybrkxU5HZW5C
         Uhu8G12P5jQPGwEUYUXdrY30wzn5Y68CxJFupQDl8NJjNoXUvkwAZ4+ahSF2a0hg9ci1
         9PIrIWWiemrq7x9s4LpkkCGEh7c/0qrFB7PcSZw1+N3zZ+OqoUCwMEhAFVqeDzXhFKCW
         nbNg==
X-Forwarded-Encrypted: i=1; AJvYcCXiTyLGSMmTkIC0/l70U2QqZ2wZ1G8WxxShSgmgkuSu3V5P/rACi5y+DsRH2X8JWaL8Bj8V0VTnV/TLfEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNxAAPaxzRWBd93xGwDXkvD9HOOJmJIaGYJz/4KkxhkV8m0tl
	EYY5/kxc6aj1BSiAlTNreZySZDHuCbPGNo2e+ataxM/LvK0U3gdYi5/E
X-Gm-Gg: ASbGncsJjs+awCBAhQya2f3BJEZhjqRXYR7AEHTDbOEU6cErOcWpV/3cfBU8LNQhuz+
	SeF92MntZlFEeD224ruJX+Z2aLxDr4hj1KgYA1jYuOy2PNOYqvjIjkO35n+GoTgIVRNm3Cifxo/
	l/klr/LLp6Zt6PLP83z+TqLBWJQLHf0OKr7cPLvyTxGmWzjVCkhQLaROEUySc6NGo8XzJo9hMtY
	CF/Kzr1GoT+06kqkG/OiTuryZCtGIF2NAWaPBjV28ELHlyr9Qg47/PSigSlsheZZhdbQmCI/IBh
	4HsntEtIIgXVUPMseUlhjpx6Cmmm4R9cmkdlnOMPd6VsQIqtT3b93rYpEcrBi+u/jU7xLwfcJaj
	av5k5Au9hIdO80anCuSOZh2uCJ+AyoOezDszxGU2GWF4lZrWYGGOHMVMOsI5TpKLCwp1CBOiD6d
	ABwz1x5keotV7msBtZhKlphN0nnCL3U2bTnf8/RBAryDSDWBN1z6TUz0X+wg==
X-Google-Smtp-Source: AGHT+IELIohm+a85sePD0UFgSVnJbmnjewzzZy+ustTJJxjo6UFTuJaxy6bk5m8Cbv3z6kHyDqZwZg==
X-Received: by 2002:a17:90b:5285:b0:32d:e75a:5009 with SMTP id 98e67ed59e1d1-3403a15d171mr1418626a91.1.1761705126491;
        Tue, 28 Oct 2025 19:32:06 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:05 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 2/5] arm64: Provide dcache_clean_poc_nosync helper
Date: Wed, 29 Oct 2025 10:31:12 +0800
Message-Id: <20251029023115.22809-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

dcache_clean_poc_nosync does not wait for the data cache clean to
complete. Later, we wait for completion of all scatter-gather entries
together.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/arm64/mm/cache.S               | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 28ab96e808ef..9b6d0a62cf3d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -74,6 +74,7 @@ extern void icache_inval_pou(unsigned long start, unsigned long end);
 extern void dcache_clean_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_inval_poc(unsigned long start, unsigned long end);
 extern void dcache_clean_poc(unsigned long start, unsigned long end);
+extern void dcache_clean_poc_nosync(unsigned long start, unsigned long end);
 extern void dcache_clean_pop(unsigned long start, unsigned long end);
 extern void dcache_clean_pou(unsigned long start, unsigned long end);
 extern long caches_clean_inval_user_pou(unsigned long start, unsigned long end);
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 503567c864fd..4a7c7e03785d 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -178,6 +178,21 @@ SYM_FUNC_START(__pi_dcache_clean_poc)
 SYM_FUNC_END(__pi_dcache_clean_poc)
 SYM_FUNC_ALIAS(dcache_clean_poc, __pi_dcache_clean_poc)
 
+/*
+ *	dcache_clean_poc_nosync(start, end)
+ *
+ * 	Issue the instructions of D-cache lines for the interval [start, end).
+ * 	not necessarily cleaned to the PoC till an explicit dsb sy afterward.
+ *
+ *	- start   - virtual start address of region
+ *	- end     - virtual end address of region
+ */
+SYM_FUNC_START(__pi_dcache_clean_poc_nosync)
+	dcache_by_line_op_nosync cvac, x0, x1, x2, x3
+	ret
+SYM_FUNC_END(__pi_dcache_clean_poc_nosync)
+SYM_FUNC_ALIAS(dcache_clean_poc_nosync, __pi_dcache_clean_poc_nosync)
+
 /*
  *	dcache_clean_pop(start, end)
  *
-- 
2.39.3 (Apple Git-146)


