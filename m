Return-Path: <linux-kernel+bounces-826379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8EEB8E5CD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 23:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B023AFE00
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EF213E89;
	Sun, 21 Sep 2025 21:00:39 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6261E2307
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488439; cv=none; b=uqAc/uWu4HHhI205+OonYVFSDMkzsK66GwMxWGdhDM21j2FALPW3laazR/Z4nl2oaAOMVOoB76qEmvqfXD5YJiZoMmcm4ZTDLs7/Hd8Ncaw/mB+J0it5iuemvFGvOgo/eN1lKl0rASfJpYORb4T/76jXdnCuEndrT/Eb+8Nrjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488439; c=relaxed/simple;
	bh=NIWyqrdVpcJkJSnQhzEUFF48okr2+Tt2x8hkMQXXY0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLZ5GiPgM4xADWlQplesRc469GzuihTqjzKwLVoNhMmnBjhS2uVI7jR46DSOi5VMNN/lyYQfOOjoVWDRWyS6igQrobEX/xZmyuXuk3p0p3a+CiKek2dbGOfLJLf1VBq4SDd21oIPN8GJD7AAl40OcflMkTQ8MeX7Eb18/koxPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-36a6a397477so6484741fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 14:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758488435; x=1759093235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tnq3whidfUbSyI01Dbd5Axx5f8c/cBp1VDXFGzOiqDk=;
        b=bJL2AkWng74waipjHDtBLso+WA91rgajymyW45EcEdCnpQSr/whFqHurIBubqPRRca
         nut9k0P70G/U5hHTcR6kZchoUtz8T3zeGIWWQstI7d1UMGscgNICVrYSWpftyGlgR2UZ
         47B1i6pz5HZ76W1PBcrJ5QcjrCwUtw7F6hb72/6iD2yPsUocYbqS4t+MJsH9TUkP1v1h
         f6XPpDM1t473Ol5M8QVzsnI+BYPz9fWTSB/sh/Ozx6v19y1p/AIdeZRDtmR6i7r4nIct
         Ce2RzYKlDJgep5LVVbGS6osRq43OlfWi7FDBKJIde5C+nJ7dTa0dikW2PjLf7ogBdayc
         WCYA==
X-Forwarded-Encrypted: i=1; AJvYcCV19Hihjn6uTETIeGUI57yYsvYAKisevj1Sf1obVz8MajPArz4SQN8VEKZKxrNEcNI0pcFi1wKX5vl6fFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSUibyswe+12Jwy2OEmjVpyXSuFMq/NmnoQGO30+bVxchO4Qf
	aksOYpE1zScrztDvtzAb74gfM25tbXjf+ahnW6aCjCqnYGO/C3f8GLtV
X-Gm-Gg: ASbGncvmnIxuBGqGdW0mxh180iMnpUxBLBZvB3+Sdfiy30VadtQs9O7UYe2DZ8q+/Ql
	nkgW5L/QwxONahfUML4oLt8rdwhRhMbr/cGnKWRQYN8BcEBPDtEPNXHug3b3HkWSJmQCv4T7tZ0
	qAp+DHDTanFJt4wHv1zo0hZEVI9qyo8M6ZgoxCw/TEW/dSrFEI0WTZBaib4doDi/DtrqPS11/Zl
	kTz9mnZTBrmAb4HLwoPXtTVikMCYgzKCQWkV7CC5vpXOgNW8EfrLvF61cvjisPC72+nhjiI349S
	Tj+E7iKymcXMOoZ6k59tWfCPD52H+QKB2XZ60dPyIll3J4XQ+PNRjZYi1SlaqkY0Q+vwvfmus6i
	H2yq4rl9MTYjf+uFdAD8jsEyDCKuNq2tPP0X5YwWE/XPrnPdEm99koA==
X-Google-Smtp-Source: AGHT+IHWDEIpvh/jZmfjdQezodsjqFHMDizdjfQhTutLpe3+p3SxDzNZWpqwzgcTN8gpCNT+MkwAmA==
X-Received: by 2002:a2e:bc20:0:b0:360:e364:bb4a with SMTP id 38308e7fff4ca-36415065678mr35023011fa.17.1758488435081;
        Sun, 21 Sep 2025 14:00:35 -0700 (PDT)
Received: from hackbase (95-24-75-193.broadband.corbina.ru. [95.24.75.193])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36417473a75sm18095051fa.30.2025.09.21.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:00:34 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <kees@kernel.org>,
	H Peter Anvin <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: notify@kernel.org
Subject: [PATCH 1/1] x86/Kconfig: Fix PTDUMP and all options that use it on ARCH=i386
Date: Sun, 21 Sep 2025 23:58:15 +0300
Message-ID: <20250921205819.332773-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit f9aad622006bd64c ("mm: rename GENERIC_PTDUMP and PTDUMP_CORE")
has broken PTDUMP and the Kconfig options that use it on ARCH=i386,
including CONFIG_DEBUG_WX.

CONFIG_GENERIC_PTDUMP was renamed into CONFIG_ARCH_HAS_PTDUMP, but it was
mistakenly moved from "config X86" to "config X86_64". That made PTDUMP
unavailable for i386.

Let's move CONFIG_ARCH_HAS_PTDUMP back to "config X86" to fix that bug.

Fixes: f9aad622006bd64c ("mm: rename GENERIC_PTDUMP and PTDUMP_CORE")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Popov <alex.popov@linux.com>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910ba2ef..05880301212e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,7 +26,6 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
-	select ARCH_HAS_PTDUMP
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
@@ -99,6 +98,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
+	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
-- 
2.51.0


