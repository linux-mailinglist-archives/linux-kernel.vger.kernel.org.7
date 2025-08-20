Return-Path: <linux-kernel+bounces-777520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297B8B2DA68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10057726B68
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21652E2EEF;
	Wed, 20 Aug 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="Pt60TgNB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AC26E175
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687503; cv=none; b=T6yy1KlVDxzPnz6cY9qGakGSKmC5Wz+Ca03ch3erQ35pc7NPMGAKJPR4yFTIsbd37u2wB2QBzdCKyWcvuQ8t3dLJNckTZ7m5PzgtRCDKtqsQo4elgK8B7f99Foei+ixNvg8eY/GTsGjU5jZqlnIA6+Zxip1wndfgyY+0hjQiQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687503; c=relaxed/simple;
	bh=mtlpc6Oc+bVnprxHO+2QT0a74MUtF4l1ORTauJCNdSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dj04pwlp3BDxTkAvHkvhUCuSXqR4nGEd3p+0Bv8ndw/DTHde8GRQHJlqc/lf+Kt6Y/puch/DYVeLc70Ao/5KkH1WzIupFNuVMpczu4Z2yGx0ax/w+oC39TFpREdy1h3ZGAp4QMId2fZjXb4wz+QDRcVvBk/RcT53JwE3U0aAxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=Pt60TgNB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445806e03cso61887595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1755687501; x=1756292301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIY9o+m++demIvDBObElDKuuFPYxQeni8PVpK/3jLZU=;
        b=Pt60TgNBs4Zb/fJqrI3XuwXKPY5f83eedsdPLNt0qfTth0owgN0EmZNIRK34UO9rD0
         KEusiXfAPrEN1IT9Bo5iDnEcuigPb49ndhBvuIzvabnJiEz2vUHfyVcSx5s+JbrlBomw
         r8ol7QJokS0bBzd0/i0WOkIEu8H3u6ZiBfC8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755687501; x=1756292301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIY9o+m++demIvDBObElDKuuFPYxQeni8PVpK/3jLZU=;
        b=DK3pIrg1vMLkGnoHLEQ9kMJMxf0djBuNN+oRx8SZi6+XeeRgmK36IYxh7vCHOuGZuY
         XOAwQP9Lg2N5tdwCft8NjAkHbv4TwI816ihlgDLeXAet7wvoULeqScNcfOd9j053wIpv
         RwiyRa2efLGLOnl7sX+a1gSQYJpeUReb4dwn3Cu8S5vmn9bRzIOQRrHrn9aelLlYTjJe
         rYybFjyqjaKw0Y9W7OpWdBNBApPMG6RBMib/UpWH1ZHm/3TbkjBI17YlYzQF+R2EUIbM
         +1u8kQYR5wfyuYy+zs/55/YFljldV1+k2JelrevcIb2AU6VNu0+bsW4jhFNRDko5jDrr
         i0QA==
X-Forwarded-Encrypted: i=1; AJvYcCXQod1zFq3PSZH4xLNX4vZ4CbK9knyv8XzuXRXFC+IZKWFjZF/DbTteZ+gyvsUqHPXx/+Dd5Lf7h1tfp0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy/K/+1ct49ZvkaUMS4Z+4lEhn1jChbVuVT93equ5LvYaAT5e/
	/dq789ie+4+MCbsPx7RC/DL1jD+eH7bQ/Ivfj6mTwqUO+LDEMH7WM6E5gxHA8H4uFH8=
X-Gm-Gg: ASbGnctn0issxLDQnKVHeTvMI/4foHvHUOyVof0Lad0MjUQ0I31UAE91l022jNT8j4X
	c205S6PC9L7rzx/SdtQEKGUJRl58bMKQ+iJno21SbJ9eoEb8PdnVmEug8PZfWupHD7WTzfpWf+4
	vsiEyFSKNiFozBHW/XpqYP/J/eRIZiD9A11NSI1OLxfftn+W43BZCYVmvB4k7z6zRa9gMxTplFE
	sK0YED9ZdQwKNs62xp6gTT8VE+Rq2eO0UV++k0M4urKJlk5XDKTAEmF49ZqZ1khKNkQa/aDSmZV
	r+JM1WYl3gS+rbvlf9C3sZbi5n1wmxUxq5USReTai9AH6yQPUe9QVq4NctDjJw5RI7HpET0AQC3
	YmhW955MUb9nZ7eQbxpu4OZdtiYmTDJTAtmukv8Ywk7QQRcD2NGiBhnwN8ZYB0EKFQLt5
X-Google-Smtp-Source: AGHT+IEQsLcQ+eFDszAlGFwsAowRxUaCxUv86qiKlXCfj7VzA6LxtPPB0hvfbvTQ1V8Am1CNcEPsjg==
X-Received: by 2002:a17:903:1b07:b0:240:38f8:ed05 with SMTP id d9443c01a7336-245ef226760mr31487095ad.36.1755687500953;
        Wed, 20 Aug 2025 03:58:20 -0700 (PDT)
Received: from furiosa-sungho.sungho.kim.office.furiosa.vpn ([221.149.27.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4f6a84sm23212435ad.118.2025.08.20.03.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:58:19 -0700 (PDT)
From: Sungho Kim <sungho.kim@furiosa.ai>
To: bhelgaas@google.com
Cc: logang@deltatee.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sungho Kim <sungho.kim@furiosa.ai>
Subject: [PATCH] PCI: p2pdma: Fix incorrect pointer usage in devm_kfree() call
Date: Wed, 20 Aug 2025 19:57:14 +0900
Message-ID: <20250820105714.2939896-1-sungho.kim@furiosa.ai>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error handling path in the P2P DMA resource setup function contains
a bug in its `pgmap_free` label.

Memory is allocated for the `p2p_pgmap` struct, and the pointer is stored
in the `p2p_pgmap` variable. However, the error path attempts to call
devm_kfree() using the `pgmap` variable, which is a pointer to a member
field within the `p2p_pgmap` struct, not the base pointer of the allocation.

This patch corrects the bug by passing the correct base pointer,
`p2p_pgmap`, to the devm_kfree() function.

Signed-off-by: Sungho Kim <sungho.kim@furiosa.ai>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index da5657a02..1cb5e423e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -360,7 +360,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 pages_free:
 	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:
-	devm_kfree(&pdev->dev, pgmap);
+	devm_kfree(&pdev->dev, p2p_pgmap);
 	return error;
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
-- 
2.48.1


