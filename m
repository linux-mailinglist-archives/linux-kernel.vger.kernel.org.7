Return-Path: <linux-kernel+bounces-873129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDFC132EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8F4E7364
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1362BDC35;
	Tue, 28 Oct 2025 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAhKlf00"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388C78F29
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633378; cv=none; b=YYMCmRaUafJ8N2axWBqHahXob5kfAICiGz/0DqFYrccXEzsYXzNPyxktyf3FsAChYiAYLLopCJpeNuRd68pGetwDTiQFjw2wdxwsb/a/CO+6ARi3lVvJqauZpqDUF93x3SKcBLmzW3VGBnSzpPNr5p05XxUnM9Jp9ZXLhzcRcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633378; c=relaxed/simple;
	bh=fIpLWlJZgNMVBNwv1Qi28QT9txbaMkE9WZofpeGLL44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8NJvGJbtsgm9zH8041o6oBukKre+hYVmjktgzVIH5xLcv6iNvmg3JyjN2W0ykgs8llHvtFgkYw7DFJ0IILA2DW4bEf+DYnB2ls2kqVs70Rb8lMznTBGD0+pa15rkB0se7spzl9muj2zRJyrZwts6oe8g+DRSFuKkvPapaHTDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAhKlf00; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290a3a4c7ecso63488365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761633376; x=1762238176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=WAhKlf00a90QiFnzImHQoIkAhc/wIBuKyFnC+lMM7EJQCTvPL0dl0HgQFGOkKK7Fmd
         uZhtkcbluoVSwgY4e94hV6pHV1Aho+4N2UO7FISgTHfulzAAFodsDwrimwjOJf+IgHzH
         1Sd2r/GHtRzDd+d67OMlPwh6fhMdVsCOQB5OXz83jUrx/o8/1lF1vV8IO2ud7hwerZ/l
         ETybXYi9ptdRtqHkcCsQ8gyx+wDMVEj7nxSe/W8ruSSqAd7V+EyDqVv3jzf8oumfXThf
         vVE2vcvlALANA8gvgyuUlENZYUxCUWslRgIJTFFMtX18FEEQuaW0zbESvaUqysTy3+v3
         jQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633376; x=1762238176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=jyp1TOrxmHHhY/q/STOnx1PByAmBPx7/sUsLVvjRAQ8pugbtdJEOSCvP3G4RJ0mUw+
         YwEQIKfJz9nucAVIo0dOqfdl3hA2+O1w8sFV+FxIrYNMdgcW+ZKnx0pxOrV3ht3lVY0Z
         tkemHEK6GDbnBBfjcY4iNd4ckI1/c7ozj3PhJoUy3LswSfX57WyqrGqKjQ3zkKbUx/Ti
         rLBrFe7s9GuFIPxUn22b0+z1kCZHRbx68ZLROWDa1bicwt/L2odBoRzW4vgAzK+0g6ct
         325KNNwQz9XDnMMxk1cA7GgXBqzDHelmxkcpTzi3ctGzWvZfXyBDEOsbgjc4rWorOTfw
         b/7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb8jWteW6QY5k0jfXrD77EHYxMlYoA32ButljuzsGHObv3ai1LjDLlyyL14qwe2WaUhM72Y4FgVBjXS8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fYMgZJZWscp+sbmfw3RmsODFwojkTGEKs+xMggI9AvwCsJhb
	6/14wa7dxeeGWFgmE4atHKBBYepzSYWjGa/cs/827BCDit3gIyQMOIiLx0r6NRIYw8AP0Q==
X-Gm-Gg: ASbGnct5gNYS85miwgO07jEhU55vWH/rkZQ1ZASugIKuJxMV01i5PQLYp48x8UGY0/6
	kL5rEio0D/H+LrTEpWSxRwa+C0JpxMCBXE41mV6pR3WNGPYLMLAYjHs6knmfFcu/iaJ9zbfErht
	EUepI5rLBxHxFWH+feq1nHwHXSNgZYMBhacFo+a4b/EX33OrSIiIK16uUZYmcgoaRR2uMKEd1wg
	+SZXUFF3jIwUBSb5jTTiR0Q4nuosoECz5ez3j0o5jB9PN4opIFDLtZ8xXcQ0taQIXQoCZqbzsal
	zkIKm9p6Pu8g06jRTmMmwlRKLnUGdepxLwfttzN5yBvJMb8u21SVX5Sqe6fQx+rJZZKHgRsKrAg
	tw+N/2lOY/DGakjuFp8koZLLBfEkHfpsuh+XoCiSMBTBRFg7fIIp3zI+lRTPPPdjFnCct4+d96q
	jSLG1c58GQ3Ex1aTZHDkFwWA==
X-Google-Smtp-Source: AGHT+IH2v3C/umCB14OlrxNqF3tzlUkDCN89YW3HVw9JkHJXqPm2mOQ48IiDSJJGHTDX9O7MPiIkwg==
X-Received: by 2002:a17:903:b50:b0:264:a34c:c6d with SMTP id d9443c01a7336-294cb3ecbc3mr28327115ad.37.1761633375933;
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm105914585ad.6.2025.10.27.23.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/of: Fix device node reference leak in of_iommu_get_resv_regions
Date: Tue, 28 Oct 2025 14:36:01 +0800
Message-Id: <20251028063601.71934-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_iommu_get_resv_regions(), of_find_node_by_phandle() returns a device
node with its reference count incremented. The caller is responsible for
releasing this reference when the node is no longer needed.

Add a call to of_node_put() to release the reference after the usage.

Found via static analysis.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/of_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..02448da8ff90 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -256,6 +256,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				if (length == 0) {
 					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
+					of_node_put(np);
 					continue;
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
@@ -265,6 +266,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				if (region)
 					list_add_tail(&region->list, list);
 			}
+			of_node_put(np);
 		}
 	}
 #endif
-- 
2.39.5 (Apple Git-154)


