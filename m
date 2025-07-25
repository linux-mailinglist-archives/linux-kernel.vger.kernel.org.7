Return-Path: <linux-kernel+bounces-746368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED00B125D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C765A1024
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ACB25A352;
	Fri, 25 Jul 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GIjRAtLv"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056B224EF7F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476639; cv=none; b=gDilWR+T7EMkzbiKBI5RYo5H6uE/FXuhGgQ3B+30lsgLKZWgec2qgaM8iVZygV6uwKH0oKenw4mvj32/Y+VtWL+SDhR5bckLAcjyvMwonJgCJ3qE3ldxv2fGRp7gbKIMDUf+6ZfCPP6HJJXOlbCzponeEbNgVrKjxFhIuyFdCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476639; c=relaxed/simple;
	bh=qOznhkI0sgRd02iZWwCidU/OgKiVAFD924soV3QB2mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoDvLCwQBbOQ9G2i7OsTypEtLThoEJnYWrKTlmQRoPRNU9e14Tw9uDHbXOUFaSHEVU4CDtTxYw2zKcHSIHH0YYT0LRKAv2R3CFNEkOnK0j4mKnmquJVgez/JWT+ZxVEAPlYSEaWXAnP11yQx8QghEi5qorI0NqXC4QColNl7dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GIjRAtLv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so24323805ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1753476637; x=1754081437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+7CxWng/6yV3C/vih/JoVMAM53+8hoZqlb7N702ZCEM=;
        b=GIjRAtLvL2ZyWwvkcHh956iJo5csCp1ddUerQdYtz4DxgxmqDRRrzSJ9KPyIy0AM+v
         GDiKHN+V1f6s2RQVwtUs/+mefoSngH7ZUm35Fieui0c2GwcDcoHWxG+7jmVlY5uUpGqm
         aMTQF3EYXmjpbLxIW0ruP/h+VXlrW6ZUERBCmjoo7b36k5vidd0RxV0D0jVwfCvI99Dy
         KMyPtrFCVbXSjfPeZULVsw7sqxcZqeiqfWYyfpBi6AR8EJ3BPBusvQEheqfiiVafRxPk
         Fi0HCwbITl4wnNLzByM9UH4i+XLEqSuC/7QxpGGh+TtUylnVmyiJHO5eSj7WeXT/VMiC
         lN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476637; x=1754081437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7CxWng/6yV3C/vih/JoVMAM53+8hoZqlb7N702ZCEM=;
        b=gGb6V+tVbo6afMZjYZA4t+eO5rY/N+SC07vh0D8nA+trFTS1pN523yPC8dfqBKfE54
         J1DJUgVu/IJe59J8oI30WyHHvSPMzcSWVj6u+a8HbfLv/rTcuT5HTxen49mIFxEsxGlV
         0Tz4EChQ8nGEU2pDaeGSQFLhXWyInKI/ufuRJ5buNNk973eMwueFKi5puME8DQYDwJHA
         mBbjQMO0DYM5Mppk4wcjUuzHu9MfCdgAe9dyh8gP2jeC+ILFli+wD03f3IDyZn57VMcG
         e0MeJDyn8WnKHdgNeAVOep/QjWVzJjfKd6VoFxJQ4iUNpH/GHEVfwraJ7/bbqBXgmITU
         kPvg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Mmnp5+NyJaJrk5dXdj2QB61MUdnjkdSx44emThEfHguS8vTEarl6r21/qft/FZkpc+0o5/zJ3uQVNXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyswBfl1oenNpEh+syTH9dZsDsdGOhKXNT4lQJ05hwDspq7vIFw
	nVZtC//I4Q2yYmn0SRAHBtEHQ/6W5pm8hyXxHksK1rDdb1vpXgJqqhidnOCl26TkyMc=
X-Gm-Gg: ASbGncv6t49yQTxK6svLIMCVwATTbBnfX2nZGBiS/wXzPS09Rb4l0Mo5t4Io2XEeRxk
	WSBypzYaneArPBYiymPHvpnVX7m1LEJo9+jNHbtGAF1Y7IjyjJBvrjLMMnmWpAe2RgTBn9jRyyp
	SFucpS1ZCRcep8A0GMKcy2tl6FHU/euAAJ5Z90xrJ7IbFXT6yx3iBliYwXMrxcJ+8PlvfSb1zBy
	UWSSc1Um8Om+8sW48sEtvURCfDyxBKpLpkkxqQt8MZDGKFX/Op5Nb5pw8KGzXw4VaMDF1gMEr4r
	wnOcI/K1TJvwFTzyeGEDHOdSKdaI6ZLYxAo6hbXbQw66L5+RoR6YTH0gvPMm6cYHlqt/bJasKMu
	LRW6PZqyRMLFvPaKatRWkEMYw1FZmo6lCJ9dbrJl89a7hAg==
X-Google-Smtp-Source: AGHT+IEDQ87H8ajZgmrcoy7AQkaFkGRZDiUZ3CUFGkJjETMa1Gw2W0pltyotcDJxADSW+OypslSKeg==
X-Received: by 2002:a17:903:2345:b0:235:e1d6:4e22 with SMTP id d9443c01a7336-23fb3040f6cmr42762535ad.18.1753476637079;
        Fri, 25 Jul 2025 13:50:37 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23fbe5656adsm3725935ad.188.2025.07.25.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:50:36 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: Initialize discovery subsys after debugfs is initialized
Date: Fri, 25 Jul 2025 13:50:05 -0700
Message-ID: <20250725205005.1983426-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During nvme target initialization discovery subsystem is initialized
before "nvmet" debugfs directory is created. This results in discovery
subsystem debugfs directory to be created in debugfs root directory.

nvmet_init() ->
  nvmet_init_discovery() ->
    nvmet_subsys_alloc() ->
      nvmet_debugfs_subsys_setup()

In other words, the codepath above is exeucted before nvmet_debugfs is
created. We get /sys/kernel/debug/nqn.2014-08.org.nvmexpress.discovery
instead of /sys/kernel/debug/nvmet/nqn.2014-08.org.nvmexpress.discovery.
Move nvmet_init_discovery() call after nvmet_init_debugfs() to fix it.

Fixes: 649fd41420a8 ("nvmet: add debugfs support")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 175c5b6d4dd5..b6247e4afc9c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1962,24 +1962,24 @@ static int __init nvmet_init(void)
 	if (!nvmet_wq)
 		goto out_free_buffered_work_queue;
 
-	error = nvmet_init_discovery();
+	error = nvmet_init_debugfs();
 	if (error)
 		goto out_free_nvmet_work_queue;
 
-	error = nvmet_init_debugfs();
+	error = nvmet_init_discovery();
 	if (error)
-		goto out_exit_discovery;
+		goto out_exit_debugfs;
 
 	error = nvmet_init_configfs();
 	if (error)
-		goto out_exit_debugfs;
+		goto out_exit_discovery;
 
 	return 0;
 
-out_exit_debugfs:
-	nvmet_exit_debugfs();
 out_exit_discovery:
 	nvmet_exit_discovery();
+out_exit_debugfs:
+	nvmet_exit_debugfs();
 out_free_nvmet_work_queue:
 	destroy_workqueue(nvmet_wq);
 out_free_buffered_work_queue:
-- 
2.49.1


