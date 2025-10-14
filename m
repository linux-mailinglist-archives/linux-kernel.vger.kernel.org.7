Return-Path: <linux-kernel+bounces-853084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552BBDA9A3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF11F58096D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A45301034;
	Tue, 14 Oct 2025 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="QI/PjoEC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF1302150
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459064; cv=none; b=ZTnUiVs3jaOD2hBr/gikHbnm4sfKkBWuL5EFzEaQxE7VLkeyEO5FLjkH1tD13TnjNMrcfM80fffFwJ9jg/1kc4NYzaWFt7dnZk7wgCmsQ2xVFaQ9ybnScn98Wee+WtnZcS08SATuJSNzAHltbsk9qyLXekLqgTldfVPDl8ICSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459064; c=relaxed/simple;
	bh=LtEzRYO9NQcP2743giCq2ceguBK9etlZq5C5sGGoq5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gdGQ90qcwksMxG1bkrboDk0HalnPVbeorHfX7reg6GbswdZpuIvWQIxttZl6DafmoD8BPVSCJriwlawk6avMilQEKcV8D2zwPynVLKN9398yUaHWleOAPkB7mWRGpdOJQSbaCjnLfEQgvFzI5Nn1a+8vXBNEQEkG8KojL9AJ7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=QI/PjoEC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781db5068b8so4431622b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1760459061; x=1761063861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMKlR//4XojOS4N8WfUmrzNmreZndJ+EmT0aEkEBFmo=;
        b=QI/PjoECC8/hbzbeR0DdjSMIQXX6SlZe7vKXX51gFhEq5IAjGbj9oorRRQCWr23BA/
         NdeqxttAtzl4uXySSeuKgC4eC3SV5Xh38eJ3Lg9iPSkog4IpUEOiWgiLZb0bg/PrAkvi
         T2zcw4Uw/1VBR4P5h5ungv8up9Qz5ZPhCde3LSwEkOEZT/sTJTVnggi2Ve5ei+xpokb4
         PZxaxQro9G8SqfiSCVEbAazT2xMMIcKIr52092B8I3UMFnnpglEwapztcwb+yg910Lly
         LBu7Y+iKX0kUUP4ZJW2lFfECp/NiTmjj3II8mTolOfLNACMpwAX90Zn5IHPNf4CfmiJu
         NGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459061; x=1761063861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMKlR//4XojOS4N8WfUmrzNmreZndJ+EmT0aEkEBFmo=;
        b=jylm1rMLqbDABiXItdV+XquALF0MVI0imp2RJUM5UbSC37F+MCTCsgudJB0D21y69z
         j8eQPuF1zix0Z4MPKlPEllzxNh85KMjOpUEtQWEAZU4x9HG7reluuI6sWHtlJj9dfb7I
         ID5AkuUFstF2NBmvmKRLMWOUL6CMr3rDgZqCKDlqcUSEVMA6M+pId147dc2RK1A1bEOy
         M5M6lS6SbCzIh/8/04Z+ZK+g6KC9tzU8Fdmj5W5Rh7FNNeaG07xY5/Zy6vRw0fHezAmP
         /pUBwGYQG1Ujbp9rIe4Vaf8xpnDhj2BCBrtHvaCCxXFmu9PN9jem05ah7OQLEdKH4n5i
         oh2g==
X-Forwarded-Encrypted: i=1; AJvYcCWo6Y/ZOv7MkLdlkl36mBNOASFrdJKvYBlEddhycC03C5lqGnX3+9Mcuzqg1kmhU8jS/BnsTZtl7E9cob4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdVoGArbA8q8ynPbrZo5ftrBU0O0bCV0RiMEawuLyLWvltuBz
	emrMYYIlgO5y+pzsSvW7v6Qg1pFl4s8cKO+MrcTaEAsXX8X+ffZ3wuLoD3WmxnP9mcU=
X-Gm-Gg: ASbGncvRzyGVS3M0taLHgICUpkE4j339ONJ1Im4CyoC+ki2XIxuNCV/KiU/cNUp44eI
	okOgnCxDmiJUrEIyWRcJV4HCiFyBASuI3iPFqhmdweU3Xiuy3s7/lgw1v5BBuJ96gWj85OmzoVn
	uKhLQMoPoppOgHdhvKHfnoaMI6KpPAsLDo5wIIVSyYcvKnQsYauRscTWc0BzpA5zfpxqBvBoD0O
	z79LkeW9EtHu/SB7G/JL6R6A+Ft58LUq8XVOutK9B5jYf7kYkhdon5T4hYV5caJFj0Wgy0pD161
	Z1Qy/13ZTAhFKBN+TAQZ+Tb/ImFTwP7agca/ILlrWbHGYLvasL6isKESMIrciBEJ6nXMQthwuYu
	uS1BtkQTOWWxiflzIfEiYZG90f7JmyFMJb7RHIqPqOYQcsmKfEsPdHfEDMZ9vZvZBxTL5GLWkJi
	8t0eUvZ5u/NB64eNw7+P4tEmWnpNAGI6c/4UoDlt+sgI+D7sgzFQ==
X-Google-Smtp-Source: AGHT+IEjBc/W3YmIEDxLsxWvWRwpU1Kl+Rqt8LvtY6hFaWkAvgkSm2RNpuZl3fYb/NDOwWXt1tuL3Q==
X-Received: by 2002:a05:6a20:12cd:b0:30b:2a99:4424 with SMTP id adf61e73a8af0-32da813018dmr34034402637.17.1760459060534;
        Tue, 14 Oct 2025 09:24:20 -0700 (PDT)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:f1d9:835a:a3cf:f8b0])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7992b0606f0sm15986721b3a.15.2025.10.14.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:24:20 -0700 (PDT)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu/vt-d: Remove unused code in dma_pte_free_pagetable
Date: Tue, 14 Oct 2025 09:24:08 -0700
Message-ID: <20251014162408.2217563-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.0.760.g7b8bcc2412-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'dma_pte_free_pagetable' is only called by
'switch_to_super_page' and is not intended to free the
whole page table (0..DOMAIN_MAX_PFN(domain->gaw)).

Hence remove the code that checks for this and frees the page
table pointed by 'domain->pgd'.

Signed-off-by: Aashish Sharma (Google) <aashish@aashishsharma.net>
---
 drivers/iommu/intel/iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e236c7ec221f..3b3ad7b0c0ce 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -883,12 +883,6 @@ static void dma_pte_free_pagetable(struct dmar_domain *domain,
 	/* We don't need lock here; nobody else touches the iova range */
 	dma_pte_free_level(domain, agaw_to_level(domain->agaw), retain_level,
 			   domain->pgd, 0, start_pfn, last_pfn);
-
-	/* free pgd */
-	if (start_pfn == 0 && last_pfn == DOMAIN_MAX_PFN(domain->gaw)) {
-		iommu_free_pages(domain->pgd);
-		domain->pgd = NULL;
-	}
 }
 
 /* When a page at a given level is being unlinked from its parent, we don't
-- 
2.51.0.760.g7b8bcc2412-goog


