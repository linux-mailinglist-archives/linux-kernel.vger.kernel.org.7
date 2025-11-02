Return-Path: <linux-kernel+bounces-881851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F00C2910E
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D2A3ABB69
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D47219313;
	Sun,  2 Nov 2025 15:26:12 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7671339B1
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762097172; cv=none; b=Fs05APmzOlktvfSw7tqKddR0rdgmjp24jTin7M9lB3f1Bd0zXZTJAZviBNKziIbz3WlT7W30psMfNyqHf2RQjTHYQyWRF0rOwjuCP0r85pHsB+ogCePpauCcyj6Khkl23cga5tAEe2TQ1pTNHHxk+yJsyKsIVCE1kgaaBYTuKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762097172; c=relaxed/simple;
	bh=TM5xg7bglH2dpuu5Ugsc9jR3ADV+9opvunL9JC+du+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kS2jhE9qOfRsQndZYpPRHjKi4Lar4mug6vrAFCnryeWDPeVXJaMNaeNXu9eyvSyyhe0qSbPJWeBooQmDgsDZFSqL1fWl0k9ocBLAO71sFkxaHub5yUMeZVGj3mUgkxxNH4mPROivISgWeU5SYy5+6F1TCmA4r0pBtPzrJt5E4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782e93932ffso3510946b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 07:26:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762097169; x=1762701969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zC2EWIFmO/b6O/9kQYZkUFIE/EFo57R2sMcA7mhMUvc=;
        b=SZLC75SpIFrHuGcv4Rlr/AXveDc2Dz6K7iAxAC8Pa2sC7ccVi3lEC/M5NIiZ7XUdIP
         UVLx0rvbXbnvxacUBIbM7MaicoikrswGWNrxZuviMhdRfHUisDDVtPQsHVYJSaoFYpGZ
         RVYqeojTrSZtFgW8kFhco/DJJi4ztA2j4np6624/K29Zqs36Ikggiu052iwbQ960Wyvf
         RsAi6U0Ti3bpsF/XyUHjyYXmPzxSJkKu1p6z+ID3m2/hJvI8UEJihTXrarCUG8BJIBv+
         NvsoKInN26MEIv0c4plaB/aHT/Qxj4ix43OjcbeVpVf0N+rwM3pT5a9/0Ucc+hk0hnBZ
         fdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgy1cI/U/LAD12LjL2dzU0MhvMC2dmMgpK9UxPMIX2Igg1Y04rd24ujLfKBvzTfuH/KTWKMhxkXHQfuPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyquhf0j8t6hQqWY02NCOTbDPYyrJ2HV/6k8lbL/An8fIRvyny1
	8DK0BvSqAJg5PMz4aqrvuzf3fcbtQipb176TJJ2Fs3d2jQw6znK8BZeI
X-Gm-Gg: ASbGncv6Mq8gChu1GKSN39Ij38eowzm8yeemLKpG+5kIMGl01YdtV6/UdShgYu/acsC
	nnWKClBmcw5hk5sDJ09K5iXfiwiVi5cOhY2InXLL5GBIwiS03CwvoPuNJgHTU6wznPLNdth/Ii0
	BNQvScHCnDorFvgLKFiV9PACknV2DThFKNAxEhuo23BfbnuaQkLsR8PZwldV2kvJfdwGbFFDtGO
	iCukLcUiOShP7m2Q906/sOApladhcm+j+lHS52B9ewp9jnpfWalSqMbP3f7Wmq048eDelOsxVyg
	QmW/yteKHhvyz8TrbQWZJ9XbonSFaudh4FZyj+xMaqVwTp5ahEaxI+RwdP9yQ1n7SuCB3CPfEb6
	uRIS8ucSTyDNd2wK2Hi8v1fsm643Ywi8jTOFknOGvy4bUvWeDlouDOOhfq3IyN3swXxr3RqQ1k4
	ASxiGFNZ3iKkSRxDOP
X-Google-Smtp-Source: AGHT+IHeyFe96KVSJeEapIw7VWITGx5W78yGriGCxM/XFVTKizvTQExyDBiZPO1IvRrVzFVvf1CAag==
X-Received: by 2002:aa7:88c8:0:b0:781:1e80:f0c6 with SMTP id d2e1a72fcca58-7a7790db00dmr13031370b3a.17.1762097169054;
        Sun, 02 Nov 2025 07:26:09 -0800 (PST)
Received: from localhost.localdomain ([2408:8352:470:257e:e57c:a7ee:fe27:1bfa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7aaab2718cbsm1609822b3a.28.2025.11.02.07.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 07:26:08 -0800 (PST)
From: Huiwen He <hehuiwen@kylinos.cn>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] md/raid5: remove redundant __GFP_NOWARN
Date: Sun,  2 Nov 2025 23:25:40 +0800
Message-Id: <20251102152540.871568-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
remove the redundant __GFP_NOWARN flag.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index ba768ca7f422..e29e69335c69 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3104,7 +3104,7 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 		goto out_mempool;
 
 	spin_lock_init(&log->tree_lock);
-	INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT | __GFP_NOWARN);
+	INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT);
 
 	thread = md_register_thread(r5l_reclaim_thread, log->rdev->mddev,
 				    "reclaim");
-- 
2.25.1


