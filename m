Return-Path: <linux-kernel+bounces-848968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43677BCEEC0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579E34218D1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5AE1B6D08;
	Sat, 11 Oct 2025 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="faWQtRtw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197FEEBA
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760152516; cv=none; b=RF7i+SnlQRssxCwemTXgAHYZ/OvmdFa0kAOJU3bmI8JxSNIhY5jDoXKG6i2lV/ciVySqpWH6n3/C42VNTDvMH1SzYGhNyCHoofICwuWdrxl9oiiKRseQEyRW+gvY9ykw5YqX5dteX2JiHWXq+9/XeahJ3HYBqlcIjUguu6ymJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760152516; c=relaxed/simple;
	bh=T5m96n00h9j0rwBj2nC35ttbnxoSv61in8rfpFxj3fI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TxloLjr7SeIwEMS8O5EhedG5khgK3ocVY/vzzuT6SrXl15FiF1y81e6V7RinSrj3cZw9glycfMRRmZFAxJ3SaZHDrNqItAfQ85V2m4qLCF0Ba7glPBP3I0yLsLsKzk63n12XsZZeYe/BVzGwSy+tb234BjFfJwtXibsB53hBYf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=faWQtRtw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2698e4795ebso26340845ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760152515; x=1760757315; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xC2iEqXbWN1thmmL3fYhGYvST5k9EmpT4WpUUIQfjzE=;
        b=faWQtRtwyoSecIyE4ye3+GZFCPJqhNFSV752O6K4wsR0VI+N3IfVyZesif6GMZrEM+
         pyFXwURs2IMxO/W9wdCaVmr001ku00jPNPtMKIodM77fF6Kcoi9q+HyFFhxHcCBjsTdz
         ZYk9PxhD7HEsvmMdXrVH+o/VUCnk1h/8jsshR1XsRF276x2M4TiQkwggbD1DrbjBKy7A
         dgexgywdUK2R8QQvFCAIrn0k+e8dhYdldselHSw7LJsbOvmqkYfN2esip8n3uY9o2WmV
         CkmBTgi7RwJF5SiJ9OVSUViDfRsJNWs9k8FLtzq1GX00GAVtxg87p3Fn2+jFlz3E7zz7
         roaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760152515; x=1760757315;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC2iEqXbWN1thmmL3fYhGYvST5k9EmpT4WpUUIQfjzE=;
        b=RQcaaV6YEB0c4sMDO/dWRqgy9ZvmFQ0I3JghEmY/dL7vvMM7fG3CiGWBHPNYaY03UL
         yOS9k9T1FIhSQVi5z+gJV+vCgtHGACSWp8OmBFtOgTLWMAdZCCZImHmWRv/H87uF8Z8r
         7vVPMU7yYAArmnlTmkEoFmWf+zym3HYtop2VOdst6Gh3ZNwlZVu3SHEozmYCK2s3qfP7
         CKJSByIgb+T+JgErMDmINXXUNnruj5kDYKGBZZyD04ksiiXfeER/5jlIjuzaN9noSzVB
         +RpZq7Oqw+G+qo9WleNe1JUf/3y98fo8Bmz16ySYZ+aj5yldjUTLsLplnOIXD2uCWX0Z
         Ltew==
X-Forwarded-Encrypted: i=1; AJvYcCUAMiC8c8UJslgX7bmOuCEZEe0yRB/K1cIy11i1cuf8UwA+39ffZ36fn3Xf9zX7UrkMSPAkkfct77xpv18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6tyneteEDO370gYkC2dManqWUbOBKn13Gl0B4Yr7IcyRWNlS
	rS2+13PB3RK3pUn8UgBKfwMixzOtCTmfEGXa8FO999+e2j4A2Od74tDyzMMWhkjoODo=
X-Gm-Gg: ASbGnctkXQDhohGxrVsSPOnJ2weW5FEYxqkQdK4zhGLy7fO1RG/QJ+3jwmhQzqBOFYd
	amf3iJHinzvYz/vv5CpHMK8l/j0jZwSgix8Q1vszk3lzxzOdJX5okE3s/HheWH5i3ZlIgrlM0Ic
	mdY30/tObdLx3j6XsqAhMeHtbphLCCpGiAefqt0eKjqtfWzw0fiMYTlMo4UU1u8vJX8zm3I7OXp
	KjxVc/Xshj9RAomtOwRTPvpdlKdrmNGex0B7GOqAOWL6wVzqojOM8s0ZDs2FUpI57JoqFe/18cq
	0aKTFf3mXH8QBQg94DLZrPGTt+dibdd1CuI4Dxez4U4/uwbLqD4XmuLKju0A44kKc6vB1+fizbl
	5zVPJHMNyWfPnC5VTCqftYhpO3oLkxXErTl1CSnt8YEPBqX4xmXNZVbstbxoSc05ZFccddYdNnZ
	DEYkhv8ZXvUCykwB5J6w==
X-Google-Smtp-Source: AGHT+IGazKTZCuo3QvlO68e49AlCvJAUzg/nhX9t12iwUEoG/vrNKdi3oaHu1O2JRqQ12XuI+dvu1A==
X-Received: by 2002:a17:903:2405:b0:267:8049:7c7f with SMTP id d9443c01a7336-29027356377mr203066565ad.7.1760152514619;
        Fri, 10 Oct 2025 20:15:14 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6792f508c6sm3496863a12.24.2025.10.10.20.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 20:15:14 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Date: Sat, 11 Oct 2025 11:14:48 +0800
Message-Id: <20251011031448.2699-2-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
References: <20251011031448.2699-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To preserve PCIe performance, ACS is enabled only when
AMD IOMMU is not disabled.

Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f2991c11867c..38e8c38c5f10 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3314,8 +3314,10 @@ static bool __init detect_ivrs(void)
 	}
 
 out:
-	/* Make sure ACS will be enabled during PCI probe */
-	pci_request_acs();
+	if (!amd_iommu_disabled) {
+		/* Make sure ACS will be enabled during PCI probe */
+		pci_request_acs();
+	}
 
 	return true;
 }
-- 
2.20.1


