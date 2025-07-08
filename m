Return-Path: <linux-kernel+bounces-722400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F81AFD997
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E0A5873A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079C24500A;
	Tue,  8 Jul 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOryIe73"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4EA241661
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009549; cv=none; b=heUG+/Va9TaaZSKOEaxeSPKIL1ccHk0y8xX6/3fDMYqOo5yU7O+ZuMQ59Zthf8IPWaIuEU/1iDEXJWD4OHaoEu8LAa95/I3tysWCxtKKF0+9GNcvsrpfwjYBnU066BAYGc/LPA54nYz8yma2IB+Q3UEc9lleqL5E8YdprFpWeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009549; c=relaxed/simple;
	bh=/r2lCkVpHjNdcNoQl75PHhSNBW+eTSqrGZ8u6lL3il4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bDRdQQNZtvWpYR8jvs4bEdCjPlgQOvn6nZXjX0T2dtTpGaYUwzWMyDKOXlt/fzlLxA1HlxtUVvGrAKVYKeqMreSQQv3F537ltY8YWk1kb1UUJeDk326AdxP4x249iWgIKxDnX13P2UYF93Df1DPfmWP8c7uHSkpJkYmvDdsT7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOryIe73; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so64972205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752009547; x=1752614347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N9ppbA3Dziw9f+Gq7+g/lqzO8ZWjV1AZzCW5sxUxza4=;
        b=hOryIe73IHe2i9/RJ/k+t/wr0sW747dVEca9lwBEKBCPBbm+wAED66q93fHp6ud9xJ
         ACWcyITmJpi0JDoLVt7CUBZIJs/fZHxb8HWvSO61wve6OmHklx33bXX2w0gf943aNuC2
         gfvoBbqDPr5WCsAf7qcT+6CfDMRco3mF+RBTlIEPSCOlPdX9MWDhIZLrxCkjTWecmjjP
         NymD7U/KoL+Z5UGnV/+Z4OtOJL79uoe0Qz9ToRUS8BlGI5QI9JjJ1oQ2/wuHCNQXya4j
         1BNDLU0kK8axKQZjEs9GoHZmrDFuhgWxdF2+/j6NvcOShS66raNty6ShJhtZg1DlcYPq
         WYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009547; x=1752614347;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9ppbA3Dziw9f+Gq7+g/lqzO8ZWjV1AZzCW5sxUxza4=;
        b=t/ceRWQW0IFKOMtNa9AGCfd4zJdMM/fM+qaFki76og5+GADP2ELlkfALUoMdES8Im4
         4DSBuQIBrJf3MbYEWP2L5UKHHjHZ+5A+mRiqSCdSFZHRrzSMz6YQ0hvNrt0oxy7V3bwO
         1xCD308bYdlJSDCyk242rVc3IjQMfP4MfOiTKJAqpsjv7RiE/7gtdsC0S+QpgzzK0rca
         tqz7gcDtGze099hNPQz2Rn5PjRvqzg6wGAX+lhdm9od4gfMZg9I/APagepd011IatDmf
         Y90eq3nzeJrvmHY75kZG3l/vBGIaV6/cs+6HbjSIWTD7BGPWk/0zfFoBKCdZzY3CFMjB
         Rx+g==
X-Forwarded-Encrypted: i=1; AJvYcCUiMXhhrfxLox/2vw8ftcpQK6NsIGmWeNSA3JWkNAQGEgbM6BXb43IVmjDnp3Oj0y6wzP0lguolSWg9Tzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/6jUnamSukiw18w/lvd541zcIdTAvgUmgsxt3FGkyf2JfPLD
	wUF3FeRoFdVz5RQ2dJ9UlqW1Zb0+Ky5diIEPF4HyDaj0E5uIeUjDF7u9dyklzYrVvIswHhwTUJR
	dExGktOZmPE+jWBUw9xz4kzUUiQ==
X-Google-Smtp-Source: AGHT+IFRfw4pTGFX/9EXPFjhu3f/ZefIS2qykEOeZXJTgQKNfsuYTs/2F1brghTX77EF0NOj3G+FJnQVPa3iukxtjg==
X-Received: from pjur4.prod.google.com ([2002:a17:90a:d404:b0:2fc:3022:36b8])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc8:b0:235:f77b:4b0e with SMTP id d9443c01a7336-23dd98c1b3emr17254305ad.41.1752009546961;
 Tue, 08 Jul 2025 14:19:06 -0700 (PDT)
Date: Tue,  8 Jul 2025 21:17:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708211705.1567787-1-danielmentz@google.com>
Subject: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Liviu Dudau <liviu.dudau@arm.com>, 
	Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
behavior") removed the last user of the macro iopte_prot. Remove the
macro definition of iopte_prot as well as three other related
definitions.

Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 96425e92f313..7e8e2216c294 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -85,11 +85,6 @@
 #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
 #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
 
-#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
-/* Ignore the contiguous bit for block splitting */
-#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
-#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
-					 ARM_LPAE_PTE_ATTR_HI_MASK)
 /* Software bit for solving coherency races */
 #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
 
@@ -155,8 +150,6 @@
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
 
-#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
-
 #define iopte_writeable_dirty(pte)				\
 	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
 
-- 
2.50.0.727.gbf7dc18ff4-goog


