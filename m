Return-Path: <linux-kernel+bounces-893488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0539DC47861
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039A71880756
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43863238C15;
	Mon, 10 Nov 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyWZkCss"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9018A956
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788214; cv=none; b=Y6HpAQ/KeksICQJNdNr3S9KKJJKvl2ApcXdyC7lMTY5caW0oSIT0j3hIsQKm06gZkPa1L2J1a0/+CYOv/RXOcFkr6pm12CAY2wLRrfhWbJNNqdnyKm4MCukg+vC8sLAAGtG+cjrfW21pMgDRHOB5SP88uOi3chyI2Jlca0RbVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788214; c=relaxed/simple;
	bh=GdHSs7TzXmWvdSTb+/PJjTybSrtu6XC4eUOHhDiqAPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RGg1ENILMgxrc3hdDKH2dFYWV/mokd1OBuKBN61om5de9NoXBdRuL+NZUeESNogU33QAgc/VYDBQ0M4XTdJt55MVKUfdhPZzb5+e64qoHjYMksNhAXAbGIRAVfjyFZxjYB/per7cVzuL0nLaWg6cD9wwnQgCiH6F6v1dIRba9MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyWZkCss; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5945510fd7aso2356040e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762788211; x=1763393011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i7J7C7wbHVXZYEnWHw5tr2cps0UUQ2yhnk9iJvnGkwo=;
        b=hyWZkCssbfEgIVSSEoLmH/OAN24sRqgZ2y4G24rB346FPhFl5qVAt3mc5L/5NZdPUB
         K5RdlWgL0+y5Dbh5LALqOBRDbuR3G5YPe0mvDwqGO48vcWgNtt7W8gLCHBZKz2lh0dZu
         W5GTcD5dVm8a9EGoQFkEjAOgTT7M6mex11Jtc1DrmJkJi1vIvypu1szZBiMtJREGA1Ek
         BrGhPj/H71FxTCQ2mSVo59zCshyZ6hzUHoPdaCCT0LLjDP3ASYS+oUAlU2VNr7JphhCB
         6ME/6li3SYro6msoQ6IC23dIGY4E+eOBJnsoREgyAa37K2SbPybRev0Hai+jHeilkSY0
         13zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788211; x=1763393011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7J7C7wbHVXZYEnWHw5tr2cps0UUQ2yhnk9iJvnGkwo=;
        b=bzFeshkDUnnMd+ewqyO44RXnn9Ak73r17ytPiywkFq9wc0r1HHZH4VykNndfM1PkVQ
         qA3EErIfbLPS+q38XCV93OTin3nEaSsnuHBB4kN5wnO6xFEYjYTjHnIQoZtEwxQuHTzt
         uxt1ZYu35rMPrCXsGC2e5/6pBOv7jCBqWCFrE4vfCsX7lS91oFTXqCRXLowecJJt1DrC
         VFtXR/8b9IUiFe2yb/9v3bxY7GFxa2jUdNU5AfhaXYDvmsbocn9EQu126cKyXeVw/OA3
         zxPEnnMk1DPZSSqiJrgYTruNlG5cQkYxgu8aloBujEQrJRShjU+ogOg2Cxp7l3oz8uCt
         gTVg==
X-Forwarded-Encrypted: i=1; AJvYcCVejw8eOy/qsvl4sLFFiLhGbwkD8YsyfsqCAc8IiLGAnCG/BMn5dVHiXziNUyHvtnIlAvxL9WhDDE0PWUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWYbTXhZGh/9vc9G0r+98Wu5NUpmat03EjoIx2CricCbZk90j
	Q2Oy4k3ZVAmORXwYGBhvRHONErFROl7TLnun/r13x70nkCAmZOlY614i
X-Gm-Gg: ASbGnctLgPnxJ1qSRr8SfrLI04+HZUmMbcQE1k00pIGLDQ71WlG5mYA95Zm0PEORa+L
	XPtr3ce+JJKIIh/whRM2F7LuG/31wvB3MaBe1xte/ejcyXQ4do48QQ+C9vWzAjspthkcUDSr3Nu
	8UwOFVipPjKAmkOM9mSRTzNwbxWd+arcW8KfA7DHQLFMznS/9W2dUeP+8kI2jjHYFuJE+A/Zf9Q
	3o2Lud1n/LnBKm81Q4nwZ54akGUOGUQXkM1SpfmJVu5oq1oI6FxZQ2NNIqUIjXUIa6lZ3iuhjUz
	z0h4u23hCwHs7WtylABzZtBZGGWAOYUezT6APrXkEHPi72spnmU2EH8445b9e8k4GQf3QJ3gwW2
	CInNM6Dhlei1BNwMgg3nK4+/SdxuFbe3LXNKzmpd2setDUZ6yuITyJ8Vbtcx9PxU8fzdDWhjHI0
	I0X67259eYxVa8CgKcK4AyyMsAhSX7KNvRw8S0Dps1vCPoD9eE8XaAu/cnx6Tm2ptZ/pftSZAS2
	QYey4CF1Qv5HuakpdA=
X-Google-Smtp-Source: AGHT+IGpmyTorrxqqfyOLp5u4SrpQu7Rpqruo8E8kgCgcJIvPLF0QbvbOAIbXlHQFPaZX5TaXdWLbQ==
X-Received: by 2002:a05:6512:3b20:b0:594:51ac:13e with SMTP id 2adb3069b0e04-5945f15f87emr2348073e87.17.1762788210431;
        Mon, 10 Nov 2025 07:23:30 -0800 (PST)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a03459bsm4081392e87.48.2025.11.10.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:23:30 -0800 (PST)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] nvmet: replace the dangerous sprintf function with the snprintf function
Date: Mon, 10 Nov 2025 18:23:26 +0300
Message-ID: <20251110152328.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the dangerous sprintf function with a safer equivalent, 
snprintf. This will improve driver security by checking for 
out-of-bounds errors in the page array.

Fixes: 7e764179c867 ("nvmet: use type-name map for address family")
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/nvme/target/configfs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..49dfeb4194b9 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -60,10 +60,10 @@ static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (nvmet_addr_family[i].type == adrfam)
-			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_addr_family[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
@@ -162,10 +162,10 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (treq == nvmet_addr_treq[i].type)
-			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_addr_treq[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
@@ -286,10 +286,10 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (port->disc_addr.trtype == nvmet_transport[i].type)
-			return sprintf(page, "%s\n", nvmet_transport[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_transport[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
@@ -331,7 +331,7 @@ CONFIGFS_ATTR(nvmet_, addr_trtype);
  */
 static ssize_t nvmet_ns_device_path_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%s\n", to_nvmet_ns(item)->device_path);
+	return snprintf(page, PAGE_SIZE, "%s\n", to_nvmet_ns(item)->device_path);
 }
 
 static ssize_t nvmet_ns_device_path_store(struct config_item *item,
@@ -412,7 +412,7 @@ CONFIGFS_ATTR(nvmet_ns_, p2pmem);
 
 static ssize_t nvmet_ns_device_uuid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->uuid);
+	return snprintf(page, PAGE_SIZE, "%pUb\n", &to_nvmet_ns(item)->uuid);
 }
 
 static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
@@ -440,7 +440,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_uuid);
 
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
+	return snprintf(page, PAGE_SIZE, "%pUb\n", &to_nvmet_ns(item)->nguid);
 }
 
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
@@ -486,7 +486,7 @@ CONFIGFS_ATTR(nvmet_ns_, device_nguid);
 
 static ssize_t nvmet_ns_ana_grpid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%u\n", to_nvmet_ns(item)->anagrpid);
+	return snprintf(page, PAGE_SIZE, "%u\n", to_nvmet_ns(item)->anagrpid);
 }
 
 static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
@@ -519,7 +519,7 @@ CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
 
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
+	return snprintf(page, PAGE_SIZE, "%d\n", to_nvmet_ns(item)->enabled);
 }
 
 static ssize_t nvmet_ns_enable_store(struct config_item *item,
@@ -544,7 +544,7 @@ CONFIGFS_ATTR(nvmet_ns_, enable);
 
 static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
+	return snprintf(page, PAGE_SIZE, "%d\n", to_nvmet_ns(item)->buffered_io);
 }
 
 static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
@@ -714,7 +714,7 @@ static ssize_t nvmet_passthru_enable_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
 
-	return sprintf(page, "%d\n", subsys->passthru_ctrl ? 1 : 0);
+	return snprintf(page, PAGE_SIZE, "%d\n", subsys->passthru_ctrl ? 1 : 0);
 }
 
 static ssize_t nvmet_passthru_enable_store(struct config_item *item,
@@ -1348,10 +1348,10 @@ static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state); i++) {
 		if (state == nvmet_ana_state[i].type)
-			return sprintf(page, "%s\n", nvmet_ana_state[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n", nvmet_ana_state[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
-- 
2.51.0


