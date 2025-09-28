Return-Path: <linux-kernel+bounces-835293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B393BA6A69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E593189B8D2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4A29B77E;
	Sun, 28 Sep 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ypo/HyyC"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791DC245028
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046002; cv=none; b=CgLyvMK46bRjbIvvN1/5LSo8EH141q1GzxR3aGctp0b4Z/96OAWQIMl4HcbqokmjcKzlHEmZoALm1AANJ1NZr2kcnYAVxqVO8x+E2bCsWqP7eg7hcnPR+1rY4kjKgjTi6gTIgB0n6Lt3Q6mJsot/oZCH3SlHs6qUbSdgtVkhi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046002; c=relaxed/simple;
	bh=uYZ5IK1FTpOCbYNP61ldu2wAWMPnSD+m5gAYSA1y73M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PqovZUNkcRYJh7x5F63CIbXGOXxxYgGumJ1AGphFlIczlqG0muJ+lyUU1R7aXur1vXC4OpNp2HMwT04l77zU5yNbqg5iXVddeQe8EjlcJAPTMn8O0x6AJ3mQbu78YEQU/3E9gDO2l+sZtY33I6dQS830oiYN4RFC+iP0l9kw+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ypo/HyyC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54a74f9150so3108801a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759046000; x=1759650800; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AwDk0uCNivTcVsDsRE5/fRsH4mSCZxsprGiICUsfJw=;
        b=Ypo/HyyCZ9HI2WGWaZg/rtxRXSzphyB7Tm+dLqLaZaypysMNRYKk1SjqjJeWxOY9SQ
         kYzUJcXzfRgicJhe/03fVv9IcfhtcsFEggV9K2ATw0/2w3DRSD2yFR4OwTWFah+V+WqW
         pWHPJmo8QWs5B0o6Ny+gzgTgmguob+5KLGS5UhXp9vCeBWys4zRsPmkOwjIUSnhMlUQ7
         1wFnKsLYrzglLMPMnXDEIdhbM7m/M+4h0xNdYV0RkYUh3JqfxdTr1xAPZABTkzxOVby+
         m222h1c1aK4cvvKhh51VDfG8rxhTwcmqgYMx37yZeoyFSzQbCOQr7ArU8/93rkNKfBLt
         7mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759046000; x=1759650800;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AwDk0uCNivTcVsDsRE5/fRsH4mSCZxsprGiICUsfJw=;
        b=UPXJ5wb+JrKS9GuT1yxok7N4ki5lhrrRN8qWkgH4tWqwoXYTstn+keghtvUcQs9KVd
         iEK+hgBGlBObG1iufq53vus8jRShrtzVD39NRHd5GQh8Tl5ATNp6ft5Fk3TNM2zC2M0d
         wF/L6PVO7/oEOyXy73yb5UlcfrEBfosOhF7H8+EkxzJvQAm/cZEO4QMhoaR1qXOUG54q
         xrnbKomOMVS6+QvW9Z3kXOwyxjFNvmEIGGgtTs+cZfSwBr2aDdyzk0QaEjfyseYvX9Pi
         NbFWsxqSWKJ+VgaxTdfS1OHCQb/fVwRlAGgO2NOo8Z9a4XN5cnBSYZmEuU1VtRiYVFrf
         Kh4A==
X-Forwarded-Encrypted: i=1; AJvYcCUZBrxFNT784faSgmh20xdQ7O6Qn2Et4Pl9QPf721L8jD6+++5PLwJPDLmgy3wPFEyrjbHAor91fE2KGSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9V4jVyCV0RfV2+nIGkziI83N60GA3jtFot59tKK3u+SnpFbPC
	IENxhlqnKcDwhBZhalzlwMFGo0DPhgbkGzSJHtYV03eTYFIzfj1nIAzoBxQqgiOi6lU=
X-Gm-Gg: ASbGncvwN1wy8EeAdUPAOsouwvPIIwucZshpgJk/BNoYtnsrOwqotzpKy0Qz024D1sQ
	fhljEkGy2WUAAsaJTbR8GdgwMhHwqwpI0MANb5Yxijk4CYUJgGWd66Qqbqo0yhHy/PmgONRQ+k6
	+vE1SxpFw4q/MnQIELvREBsc5C+riw9SUd+GksyRHUQRj68fDWCPHbOQHtbxxVWVMS9Zz5mHA/k
	XbP2sG1+U87Jj34oZlA0k6TwboIdBbKkhQQCO944mrTOLaSa8vmHfWQw73HTAc11c0swu1M4Bpo
	x15ZEoUBgMO0eFKq/7dxErimaIup30mtsD31G3BiF64PKIrb7vWvTStJFmSL8VTf50NnkpNbp5q
	VfmcgLzQhLlh/ps78KqofmU70k6FMZ7x9C7UrUa5Y5sEweCjMCHolpsEwsQicV2zrtuE=
X-Google-Smtp-Source: AGHT+IHkVLr2GZuNjDyXevI+888VozHlhvOkrw3eWZlJjp5Td8JmDZsLN8RetVbQmgVfPUm/I4Rq/w==
X-Received: by 2002:a17:903:4b04:b0:271:479d:3de2 with SMTP id d9443c01a7336-27ed4a1a2cdmr126605265ad.13.1759045999607;
        Sun, 28 Sep 2025 00:53:19 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab640esm98722895ad.128.2025.09.28.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 00:53:19 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Sun, 28 Sep 2025 15:52:57 +0800
Message-Id: <20250928075257.1542-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..6e9eab365123 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3212,8 +3212,10 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
+	if (!amd_iommu_disabled || amd_iommu_force_enable) {
+		/* Make sure ACS will be enabled during PCI probe */
+		pci_request_acs();
+	}
 
 	return true;
 }
-- 
2.20.1


