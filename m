Return-Path: <linux-kernel+bounces-894658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01BC4B873
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FFD3A79C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBF280035;
	Tue, 11 Nov 2025 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="lqp4qStc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD627E076
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762838433; cv=none; b=HknQgq5lDLq7NAfJsg+PJIR1AMZKdgLj6yjAYvb12PoYe22UfkS+yGA6QdEFcd1qTr6+WSXj8ESMb2y8iEqs9/XFCRBCyfSNi0pNS7a+ZT3EufiI9nF58dpfuzP1M1aE838X6O24BGcyvI9Wd9T6UZ8mByYN4CGVD0nCkLzULLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762838433; c=relaxed/simple;
	bh=MsGZR4CIigNxmVNtsBjkuslmczZOe3BUpgUHKm0cYkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grCVjYZQz0zSjzzXDjSQpj006tP+dncVGUmv6zS7ySA5Vatkt1CNY0MyviU5DRjSnFvYvnL2dsloOTS5RnBNL8qRzLmYJMI0+TPrshzvM4vi6AJrtvRbtLkkXuh6sqFUA/dZv3uQTwcSyjhC8FdOkyFJeiHvON2FIaHxFFaM2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=lqp4qStc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298250d7769so10359225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1762838431; x=1763443231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x4H4gg2Lcobibmd978yXCBL5nbfbalKNhdhPRuAkriM=;
        b=lqp4qStcsxyOQb5tjJRznOf3qyVFvg1O7CeOR/ERrmWPsHBtQUIcFkCL1/c7qP6KuV
         KPI19l7I57g2Tv3NMA+CblbnVoG6MRJpMi0enWfJQAN+gdLlReS8n2XQrWT92kpd/9Ig
         pbnt0RhIO5FAWL32DKmXBFkr54VxkDCe55dMIu/j5gMM0WjXoOz4veQNNAfR93WPZ1ff
         LFewLrOSDxAsYc+LaxjqxwoJMtteV8ua9/zID41WBsdQeEmpamSH0VoD6pqZN55ySo01
         ssfTW6iLtElKisIEufFY/2alhOQx/2LZYik5bO3MaQVE+Iuo1iWK0/+XVY17OLN0AZ3H
         gngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762838431; x=1763443231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4H4gg2Lcobibmd978yXCBL5nbfbalKNhdhPRuAkriM=;
        b=E8A6tJC7DACTq5tUEQoplytUN+WJJzBYYQUUlFaAOAthpchxxguuzRBBCUHJk5PaOX
         Et8soJrrhvlxJqwA0pgopDdJ1bdW0jPCEIhYb4m6tF1tg3bXUeAI8JqyTc2dYXTbAE3E
         pcA8+nXF95C6zHsIuFGXtFIAqS0nZJf7FqRUIFIB4pSVFf1KOrmhv20awCNzOJ+MynbG
         gA8/Qhkg5nmCkt/808sNK/ThDgH7KTME37r6kHjYpCA8Cd99Nfh7QZlr/zOiTtbgDkKA
         xamYUmF3iG6tW3FstHqHAAB9bG+mYtKbNVwx/+Msr+qNHwT6miBmGs/j1CiFMx6pWXIo
         xi3g==
X-Forwarded-Encrypted: i=1; AJvYcCWeW6waDEjrUZFTMY+13L9cYSCK72yw420NgjkLnWL2IjaguU4TB/7PkAlXnmQEE9lT6ueG0u3F7MUsFm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlm7uvaLCZCovQHjjejuemURoIp0Le5qim/KvNXdbTdmkOOUPB
	KAnTiGBfqcj/Dkksq8GC+/CPSzMrO5TrvqIKpQ3WPpfSLpdrx7q5Uv1MJz3+enCTEqs4sQScA4g
	P99X7
X-Gm-Gg: ASbGncu1gt4VgVbHn+njpdzJXcBDyH0SepnxJ3nH8ysKbYSe3OvIrxh9dHXGQuE2vms
	sKU7j4BHcfp0CF9wi9lnt22Azw6jsEmuU07wswk2AHs7M+FSSa5YQXf605QiEwMITwZy0JRmxC4
	sZzk+EG6T7GRF43BWwfzeBLC+op1xLaklNM4n/awticxKCdrCtcjfiBVYNYuAEQauCXIK+RqE2S
	Ie9gT9mLa+nSbBWndOm/VByawzNAyGTr5A5e0FLsdMCGK+sDndBUfVoInRX2Ca7Bjza5DvpAchb
	CKoDSlnN5m/AK/v10fWHowEEvuTy/lRNOky4onxLpr20vafQLzSGPX9tChzRbRaQISlRNbL6Qpo
	KsqOLgjtFQlyPBUR/1PmXc8B0jRB3RLZoN4+hcvgffbqlNE7RB/n8tRHJy8YuAgvAgf5n/oXKhA
	FG0cyVl5FkhplY7rZZ9RGx7EjKXFOnoiT9GyLkgm1DEoBw1HftAgutsHC0kiocTagQx8jxUIy+B
	tPLPIhgUEll2w==
X-Google-Smtp-Source: AGHT+IFEo8tXEL2NbUTNjumP8kGSLnsc6s+Aig2BEhXOkA8QpOXitP34VtROaAWnvoEDWGx0+ZxVFw==
X-Received: by 2002:a17:902:ec90:b0:295:560a:e474 with SMTP id d9443c01a7336-297e56c9f49mr148104925ad.32.1762838431237;
        Mon, 10 Nov 2025 21:20:31 -0800 (PST)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:d06b:bc4a:a8ce:4149])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-297e8d3f9easm95923785ad.106.2025.11.10.21.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 21:20:30 -0800 (PST)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Dmytro Maluka <dmaluka@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu: Remove redundant null check in iommu_iotlb_gather_queued
Date: Mon, 10 Nov 2025 21:19:52 -0800
Message-ID: <20251111051952.1985154-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers of 'iommu_iotlb_gather_queued' always have a non-null
'gather', so we don't need to check for the same in the function.

Signed-off-by: Aashish Sharma (Google) <aashish@aashishsharma.net>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..f66f25051584 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1057,7 +1057,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 
 static inline bool iommu_iotlb_gather_queued(struct iommu_iotlb_gather *gather)
 {
-	return gather && gather->queued;
+	return gather->queued;
 }
 
 static inline void iommu_dirty_bitmap_init(struct iommu_dirty_bitmap *dirty,
-- 
2.51.2.1041.gc1ab5b90ca-goog


