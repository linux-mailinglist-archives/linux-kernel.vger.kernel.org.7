Return-Path: <linux-kernel+bounces-846119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47187BC7173
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07073B5032
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF5913B58C;
	Thu,  9 Oct 2025 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b="b7PSGVoL"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F317D2
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972159; cv=none; b=FWElRxTL0t1bEQTGF4lJgXpSVIBRxRG/Ds1YjH+wHDRzrMkdsxcxD3cott4sX+d9oHrKdBtK3qJiaaPFZjxhAyV4yX7DigLzgtWys3vNIdfB1UgrmGF4e9HsD70d3yOo8MqFJvk5ZMz3jbQwfjYPLDP7Cy1+lfD1UIr9GSni85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972159; c=relaxed/simple;
	bh=91+WbqIZVIOE4sofIpB0yEZNBPRPt4wB+LIzBkBCdpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4RCv5GUvHehlHxsssf8e7vcpob7vIpnWCISgk2Qk8AJ8Vk6Z5x4Jt1qAEl7D3p8eE8aVH24ePT/LXX3bHYLC3/KzUGxCqfLb8RNgiW3uRLnltz5tDxWMwF42bPJ5BXaZ8Eqwsd6cPs0QsdmrFKmSu74YbxLJAVswyhVBSDoGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net; spf=pass smtp.mailfrom=aashishsharma.net; dkim=pass (2048-bit key) header.d=aashishsharma.net header.i=@aashishsharma.net header.b=b7PSGVoL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aashishsharma.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aashishsharma.net
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-796f9a8a088so53968b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aashishsharma.net; s=google; t=1759972157; x=1760576957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf6SXDKqJICw08NoDh9xk9/MF/JYlGO1Q1LMu9XTd6E=;
        b=b7PSGVoL2m/VjzMZRPjv/4PeCgSpx4AhphuEX7cZSLrGrgrz7nJmFkyqnKOAuqWr0K
         GzwPoWP75LxGaTUFU0G9zwg4pCym4qhhGMBhzALPDhO9thaynk7XdBc+cxfbHy1T1D6l
         6qQZvRdWcmiUAYLHqLGPYWg7MXblHZU3sBZYzf7WpwxiNmG23F/lBbOoVzxQGvY3C7cm
         EqHvQaEP+FUQGiry4mIF03gnC1jJOCvbl0fCtye/nUQkg/2A6yZjTqSY+JvjTrqVPflp
         slfuAWtZGXehy3gogEfaq4k/kum1hrZMsqjzjA+W30FY7TENb4zNXf8U+7arxZaucKVI
         R+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759972157; x=1760576957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uf6SXDKqJICw08NoDh9xk9/MF/JYlGO1Q1LMu9XTd6E=;
        b=V0szlCOdLP/tHPKhU0+wQZqr6I1vdXQ7jCgToBobNdGk+l7gtztTRmGPK+euGlaUnD
         +hzG9yWqgIJxTkHjYrKYaUyiO4C+VbaNGVEBIhBDwJj0Mufhv62lKK3NxYEwA712NrbQ
         sk+wa5c+t+mII9vlO+F4Kn8m50fE7PK3TDrTqV4t1FNUT7ALxHWDXqdZO8bwPnBxXdZK
         7nmWNdg1YhWrmb/9RLRf6IGEM/BqftfwYNOe1WQVDc3hrjHzRUhBXApqXok6jtNGn4WW
         9olXbEHQ98sT+4IgJKiRy1oORfp45Y2vb6/r0p5gt0LtyZPKHUvplAZbISgh/SGT4XOc
         sRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUCXZy4p8bW3xvD7VhSbuMZqKNdmaeXahETu8Xwnkr9oTx3gj7bx4cmMt1phIR2IqxWzfXg/RsbWSpJKpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4lNFWT+Sp0dL4t7mqW5LAeHkMVe72ITjQMckqbPKReenQ+Bp
	/zZun8cVrVYLNE4fqgQEnJ/7G9cojJB0IHSQalQTRzK9SNMRD8I85xeaxaoIoS32CPU=
X-Gm-Gg: ASbGncumLRjpaC2Oc4+wzYiU9NOOvUyJPBwR/2jW7SVQOEsWSKlS+piucKjtoRHOJYr
	n24ezXF2ob5ynCVsjn/FTLdTonl21OEBt8FHz/XO2dhVGharp7zv6AtqM+6nXweqoaCVbq58ky/
	68MpZunACi4dpVbcBzxawv03isXCaMihSZSaEjjoMK7TrpLPK0xqUq64UR/DVpURtJYrb7SRbhv
	ON6X67ph9bbx0Wzo0swhp9BreyLQbHCgIPTmDW1HVhi6HmiNUK2XTyKE1EscYAdt+TnxQFvFNn9
	+det7GQegBTs0LiAyf/uoflW+cCUwK7VNt45D+g2UgtBlTdE2HaUOPjYGYMl/8oAF/6cjVLUMxr
	NkGJjsFLOXgYviFQtlWOP+WQrorzTi4wq5RC6wtjftyDCt8yIFqicnu/I/mrKusu754S4DeT7PQ
	3EceTO8h3MlfO/q8o1JmLWNKQPaZp0BpZb1BdbRSdmZUtq
X-Google-Smtp-Source: AGHT+IG8Hn5ffuKifHjR9/YsygBkJPCAVUztAOOOJeVgTKeXeNze6yjiQg5d2xADPv3Ea5hlzzceZQ==
X-Received: by 2002:a05:6a00:cc9:b0:781:189:ae43 with SMTP id d2e1a72fcca58-79386e51126mr5418064b3a.20.1759972156874;
        Wed, 08 Oct 2025 18:09:16 -0700 (PDT)
Received: from shraash.sjc.corp.google.com ([2a00:79e0:2ebe:8:6608:a363:a036:abf1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-794e33efc2bsm995186b3a.77.2025.10.08.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:09:16 -0700 (PDT)
From: Aashish Sharma <aashish@aashishsharma.net>
To: Vineeth Pillai <vineeth@bitbyteword.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Dmytro Maluka <dmaluka@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Tina Zhang <tina.zhang@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aashish Sharma <shraash@google.com>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: [PATCH] iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb
Date: Wed,  8 Oct 2025 18:09:03 -0700
Message-ID: <20251009010903.1323979-1-aashish@aashishsharma.net>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Invalidation hint (ih) in the function 'qi_desc_iotlb' is
initialized to zero and never used. It is embedded in the 0th bit
of the 'addr' parameter. Get the correct 'ih' value from there.

Fixes: f701c9f36bcb ("iommu/vt-d: Factor out invalidation descriptor composition")
Signed-off-by: Aashish Sharma <aashish@aashishsharma.net>
---
 drivers/iommu/intel/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..dcc5466d35f9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1097,7 +1097,7 @@ static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 				 struct qi_desc *desc)
 {
 	u8 dw = 0, dr = 0;
-	int ih = 0;
+	int ih = addr & 1;
 
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
-- 
2.51.0.710.ga91ca5db03-goog


