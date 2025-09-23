Return-Path: <linux-kernel+bounces-828948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9531BB95EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0FA2E6C41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B355E322C9B;
	Tue, 23 Sep 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKb1qztN"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67452F6576
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632416; cv=none; b=BupkVtV83lHolvLGHJ7NbDavwWodh88JhJLuSDIk8yDnaNz3WgF1I8ZZGInTvL0tiYVq4E4uhZJlJ73UmiMYXNzjypf26jh4ToFmgUeALxw/BakPU5+STMgtTubEt/z2CODtarWtcCEbCLqXOw81TljQb4dyQ2ShixQZWXSjt/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632416; c=relaxed/simple;
	bh=fpgqG3PPMbLAJYHf4nYwntPFHa09JCf1vAbUPv7WyK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cP6q/FJgjhyAlMYfR4zU3y5yIGmCMHxD09m3vJz8EBSzy5t4lHS0DNP1dfLFvuS8mIPAvSCuX5zRKmGZdb3/RuLVKHAu1lGgs8cYkb63Edbgqd7PW/x8+BcnfblkBGkPDFO3W0dBL7RxiX5O+11nYZu/zFnM3e0nkUmES92rZjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKb1qztN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3307de086d8so4898044a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758632414; x=1759237214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh5SwzIzASTLhVaTpXrHPJRdBlRjDqtp1v+iQDlbfos=;
        b=QKb1qztNBsVv64+uUomfinPRzxWdml6FUnZQIp71Kmq9PLESlRpIdTjV2vm7xeMHBk
         85vsJ/eGIsFErbUSnG0IBAIehA9RZdQRs7g9y7WyXxITRjh4DNgMA0oo/jTaKgis6qVB
         g7Ngxbvy4I2FtYLe5+nxJWfmaAGL7NnB5T6r9Y9T8bTeXBFpg6VO5x/RPGjKHD9Hjgtz
         zqnIu9sBSHV4epFaW4Eekc6uV4yjnmTCa5alBrpasj1U0IZ/eZ2d/vzIQ/G8HX0S12iy
         5iBw+NdMirdPf168dvna9M+VoTUc+r2V1248smyNT10s/9J+jJ+potbqQkbXSHIdYnDP
         KQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632414; x=1759237214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nh5SwzIzASTLhVaTpXrHPJRdBlRjDqtp1v+iQDlbfos=;
        b=ILYsTkM1kb5mJVS9Vs8doK/xbyUEyBhvvJyhTHaA3leBQJ71FVurd6Wk0STpcg8x7I
         uAPvpl/3gfFNJTIUTERZKVXSckHLkRdfcYw8icKL5kQSs0Gl+aOSWz9o3QYYCQC4PpES
         YFX6AIjxX3wVIR7Qo9Eoc0Og17WespBBZXULtKpvyMmBVgj6tfKRles5HYd6ENhGnz9a
         yk0bPo4GGGduAhghVIkr8cKFOdH2PYb9msQJ9iFPRJmq6KUn5ThSMzNCBt3mnkiMokIz
         8tbiXkf6MZBJgstIgqqvuTj+L3XWgBgUg64xoHTcun79jMCp9agEhVWbhcJN0AUsv4re
         uCDA==
X-Forwarded-Encrypted: i=1; AJvYcCURo+6CKKhKur5+rlP5foNvPM3yICb0WP8RMSwqH3sMKatg3qRRJZPy6ite7iEkHRb+WbA0oN0oYO2emKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZVqPESmmAjSEhF8S1PEMQYsSKs/WP3z6dEDu6K68ZXWfnACA
	YoBzkuOG2vj+pZd8bH64mGnYF5Lh8vjjSzxK6JehZFGDgfz85SW8ePD+zmyg15OmB8U=
X-Gm-Gg: ASbGncuRQO7XHc72L13ciQn4sJmz7iiMGNQI2OuY8XFdDWC9tsDfv6U8UUQcufNY4fZ
	7V9kk/Unpm3cLlbVHheuG0UfB+mkByAi3S9tiDkIyUnHCfRUzWRKt8mm+Iv12syasNY9YM83VVj
	7c+WtyJmid5tMCZlx3e1iqK44k5w6w+dEpH2w6JZkWzF40ULTg3aNyQ+XlKry27vLW9FzFSTSyY
	ihmAuQDV/IwHkw3SNdnCQrGMMezQapEZCTRzhfDE5LoGPlnrqPfWlWvB9Sqtnj/kuahfCr1/5lv
	2XB8iaP/+GGaggnfbI7WpAuMcRTHxTHhwknmoj4NvCH1pt2N2oHa/ZppWWiIfNOOkDrqhVzX+Cf
	f3IeXx44jFKCNmTH6p94vmzyRCH+6s8Op7w==
X-Google-Smtp-Source: AGHT+IEVwoSV/1C7G9K+WLOLmPwik9m4PPFJYbHnIWzyucU6AzZaAx84ogTIVfkz9b6BwPzEVvys1w==
X-Received: by 2002:a17:90b:3a8a:b0:32b:c9fc:8aa2 with SMTP id 98e67ed59e1d1-332a96fd4c8mr3170726a91.20.1758632413614;
        Tue, 23 Sep 2025 06:00:13 -0700 (PDT)
Received: from lgs.. ([2408:8418:1100:9530:4f2e:20bc:b03d:e78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273f557sm19059243a91.15.2025.09.23.06.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:00:13 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Santosh Sivaraj <santosh@fossix.org>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] nvdimm: ndtest: Return -ENOMEM if devm_kcalloc() fails in ndtest_probe()
Date: Tue, 23 Sep 2025 20:59:53 +0800
Message-ID: <20250923125953.1859373-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc() may fail. ndtest_probe() allocates three DMA address
arrays (dcr_dma, label_dma, dimm_dma) and later unconditionally uses
them in ndtest_nvdimm_init(), which can lead to a NULL pointer
dereference under low-memory conditions.

Check all three allocations and return -ENOMEM if any allocation fails.
Do not emit an extra error message since the allocator already warns on
allocation failure.

Fixes: 9399ab61ad82 ("ndtest: Add dimms to the two buses")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
Changes in v2:
- Drop pr_err() on allocation failure; only NULL-check and return -ENOMEM.
- No other changes.
---
 tools/testing/nvdimm/test/ndtest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 68a064ce598c..abdbe0c1cb63 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -855,6 +855,9 @@ static int ndtest_probe(struct platform_device *pdev)
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
 
+	if (!p->dcr_dma || !p->label_dma || !p->dimm_dma)
+		return -ENOMEM;
+
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
-- 
2.43.0


