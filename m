Return-Path: <linux-kernel+bounces-840457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90262BB4777
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8B07A2FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA00124679E;
	Thu,  2 Oct 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="TLD6FZTi"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB617082F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421792; cv=none; b=JUD9oV+lK0w1mhrZID8zto/U8G5icuaDcBI5MMz+rm4P3aPO1YQnmy+fff8JKOEJQX5a2EopI5EmEQCCexWgR+tUnNZVs7qFdq+k2/yidfAMcujuB6qZMhBVsGEVcy+EyJnHJa8IlcNxpoZBNlW12nf17BL3AGzSVRHK4yKOcJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421792; c=relaxed/simple;
	bh=vOP57pLo9t+NIdpLJnSYQ9SV9U2TJKKVwuOHtKXSaAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aF05Vgr1OjpZXj2RJbSrp0ukYONELVV47zkcjM9JkYkv3mkMeXYUlNs1J1GXSRh63Fy4LBc0/Z7ku6pgxdkuXRaMxTZ7z/conttJuOx4KbIB/hqC9n8PaeoyUBIFUG/7mPPCM3gBH4eBckdq2Klse9fgygrzcBiL1wpY+lMyr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=TLD6FZTi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4de659d5a06so7154621cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1759421789; x=1760026589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxritUvOZnvW7GTOw2Z5mKJYXhzRcHFVVfyj1Hwre+Q=;
        b=TLD6FZTiV+sCKd5btj/FfNZ9nhk2R3I9SL3QEdaJZdTYj3DuURIh19iBrlBThjNpab
         ERqPXgqL9gHn9Ucamr16Q0EMBzIUWwKe8lu9js9nW//MThRMiSRewobZicdvHIWAEARW
         ccyYl0rj5e2DFRX3/0k9XV5M5v04rIrCZckagrMc2a1ZEY7Jn0zhRmE1N8Zex+Yqe/Iv
         ERZiSfZFVmgveJMUsvOWoa0SLJYwXF8GsRjNkDjwFG26/DUmZy+mNSFyGVbrqOBBvqZ0
         addk3Q8J0QEW/PljHqhxb9xSYWu//psdyruXG/bXQWmlMr5FXhOxr2EQQZX0T5KC3Gs8
         rxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421789; x=1760026589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxritUvOZnvW7GTOw2Z5mKJYXhzRcHFVVfyj1Hwre+Q=;
        b=QzBn7i5wOsfN1IuwF7c57yRKcmZ/J64LoCExsVJ5lVbEP2lZlTsJEM0dUIctKT/Z5H
         T3T8cu8xS7g3/k6nVdY13xgEG/0iwVa76hmCJnSmnvAmu8YoCR2DP9L9F0plZsr6WCQY
         lDavZLYjxB47Hj36YvVNwSs/UXZtPZNhTMLbdCfY7mZdgcfA/uxmVEX7pHioQ7hm/A2X
         IUA+qTuusEF+yP699jD8L82zAs1TMR2YChWpBU5tPKz/to4UWBghzcN92Kmu3SyWnCZw
         QUOlMVDfjn5N1dYaB8I+tWpP8b70VUxHpz+aabVWsEYV58/cpwU5tPNX9dvPGDxfFYyk
         Welg==
X-Forwarded-Encrypted: i=1; AJvYcCWQBI312pjNtlPlXaK4A79sFdZogYojYweb0n8qFDHEyzaAK0wy15+TDTn1kW8/ixUWwZRBONT9JzMLh04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhF6HyDvOeuunxU+mfng7wQz4jl3hLufeMNITW6okDDMcbcxqM
	Q5HiSKsc3ocLK/1hps3ySvO5opWDlA7CyktikSWZ6jmen2yWfV4wvOuG9h9ZkvgjmzQ=
X-Gm-Gg: ASbGncuur+8zFpTe2kvkA/9ROmE19l86Hp1QWl5dOZGHeETTqb12lln32niJFfho3Kz
	3GPlVPipGJn1Tk/NJ9FlJvcnozZo2OD2P0xiZFEAVRFTylT8iaklRyt9FFVdV0jSRhb+oUpBUd4
	eGTJ8XDIpSzgNYtV0Z/t6V1ODCc1ZYZZMADfN5+L67BywOwnd5pfAegng4rOi1GWApR2Wa7sUKO
	FDB5zNdVTxRw4YAGK55oo7cF+55ckwyM9fVjaGnt8Cw9n7ODBtRCn0TX+HQGinfI3KjRucK6100
	fyR6MHLQjNNUrYTRoxbHBDxgdaziZiAoE0KZJKYy7izS/FVWaTgdu+45PUb9vcBSmI6vTkTACEV
	ovdYkevVvAHiJ/CR4CbS3zfCCafhNyrSmI/3lAXv36KzNbveNc54/MwwOWSmIbO0SOI9ifNxmwt
	TcuwFBhCcqL4oQlDEGhger21om4PsJDG4=
X-Google-Smtp-Source: AGHT+IEVcrgDPTukLnX7GKNxMifNYwBRtwRpqPpzAI3H9EctG9klhVojcgO2GIKDXibk9hO5aPas7Q==
X-Received: by 2002:a05:622a:598b:b0:4d9:5ce:3746 with SMTP id d75a77b69052e-4e41de6f81cmr106450431cf.46.1759421788717;
        Thu, 02 Oct 2025 09:16:28 -0700 (PDT)
Received: from vineethrp-dev.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e56d9cd10csm14093781cf.42.2025.10.02.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:16:28 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	dmaluka@google.com,
	shraash@google.com,
	efremov@linux.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD
Date: Thu,  2 Oct 2025 12:16:23 -0400
Message-ID: <20251002161625.1155133-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INTEL_IOMMU_FLOPPY_WA workaround was introduced to create direct mappings
for first 16MB for floppy devices as the floppy drivers were not using
dma apis. We need not do this direct map if floppy driver is not
enabled.

INTEL_IOMMU_FLOPPY_WA is generally not a good idea. Iommu will be
mapping pages in this address range while kernel would also be
allocating from this range(mostly on memory stress). A misbehaving
device using this domain will have access to the pages that the
kernel might be actively using. We noticed this while running a test
that was trying to figure out if any pages used by kernel is in iommu
page tables.

This patch reduces the scope of the above issue by disabling the
workaround when floppy driver is not enabled. But we would still need to
fix the floppy driver to use dma apis so that we need not do direct map
without reserving the pages. Or the other option is to reserve this
memory range in firmware so that kernel will not use the pages.

Fixes: d850c2ee5fe22 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
Fixes: 49a0429e53f2 ("Intel IOMMU: Iommu floppy workaround")

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f2f538c70650..17a91f881b2e 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -66,7 +66,7 @@ config INTEL_IOMMU_DEFAULT_ON
 
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
-	depends on X86
+	depends on X86 && BLK_DEV_FD
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
 	  thereby failing to work when IOMMU is enabled. This
-- 
2.51.0.618.g983fd99d29-goog


