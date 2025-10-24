Return-Path: <linux-kernel+bounces-869361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860B6C07B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB43B6CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B82A1BB;
	Fri, 24 Oct 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7Jh90TF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09127470
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329760; cv=none; b=U4TszMlrZQFIof3vQgBEbDQbhWbQ6aMSPSY143ZhA+s2hvC8iJ/ZIQebbczWUWy2ry32uQ68xCP2qNmFMDAo9F/CSxQQXYPyzi/iuiBXeoRpKCWo0m8qyguIZbm/8QqlEqKiX87U876aI5PdZPEIX3U78MsrMnxcBUz8/2o0c3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329760; c=relaxed/simple;
	bh=P76X8fvD2MPpFKEqZ6KTULh/PtWaUcgqMGqGoPlTXhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tppdsIcC48oJi+LJGuowPlV1lwvcZjmApmpvGqM/sPiKzbCGhzCeYwEF5nmMScCH5PUEybQt8kCsqIpuP6XJUAfXt+N9zEW3GNE+u1bbxq8rJZlL1Mn8GRplWtNNjSKQZ3fTAIa+zoLgOKDZ0Ps/gwzjO9X9IR/2n95XW/AsowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7Jh90TF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso2377520b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761329759; x=1761934559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bw6e/G1JuUENm9jQKnlNnUfVAgZw6BFTm2ZBl0ARA9Y=;
        b=D7Jh90TFvDqg1AA23ORLhBAmMvEg//iivjvuBuPZayv/CVbq6jxeL3ejKI1QO5oMpH
         fFDF6yanpjRvHSqBDO83+h8bQVXqlM59kLe/eenQTluwBurj581RA9MirUWguvyINYKx
         N4seQmeu2RwxPEHDp6HCY3Zp2oDVZNzypuzk3M69VlZO2jTGxNrAMyVDghNaELM8G436
         6SIgWn7IZlBcImEdF7EZmeXA4tpRQ9vPgpxD35Yr1SysMok9/SPDdQWs9JJOzuE+kvRY
         qbbv7IGrAU9o/1HHBm11d+GVOl2LJ5z+fz/RzWcwL0xs2mFBKi0SqVBbhu4OBOLmwlxt
         F2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329759; x=1761934559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bw6e/G1JuUENm9jQKnlNnUfVAgZw6BFTm2ZBl0ARA9Y=;
        b=lq7sFquC0EEDXCohPH+03+ktTAlJGzgV/4nzvgzcx43b/Jk56KEVz9rZGbmdyJUhUh
         s09kPS3WmUbTVNjrLlsiJ6OsVg37qNw+7n34gFCWkTvmwKpvLfhm15Of+0O3yAqID6r1
         KcryPFHZuWhPz+3lygN31fViVxw30eld24FaHD8zVEb0or0gaEFDqFdVmfOEITdqjG5t
         pbvI+Tch+lqeR+HkWwK1zDGymcRV/gIAz68Y32RFO6nE8VFa24jxcl6sdLEzvoFwdoAr
         DsYaf+2Z5ustbbtfD3IE/NyWFVXeGJ2uQUULGlOEvdru7nCUy0uXeJwgd6MjrVyVpKv6
         yB1w==
X-Forwarded-Encrypted: i=1; AJvYcCUeQU+nHfDAWbMWwo1z8B+XBef8wyacLb6xGMktMst67eWvhAqOax7YHi779UgoN1qJ5+BCK2CWu4cPwVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgxZV0mHWO8uhMEqF+HDy72+/8mPuqFmfA3uIkyMuvEQq+lp4
	q/8kolHbLdWhcLQo6mCxBrgBD6sQLBmdwP7k/irt25qdINphWcAI1xdm
X-Gm-Gg: ASbGncuRo4mqQXjL1V30Q2tkSdMYa0mkPu/wB4PRwKtHar5oI6TjjOg5/JfTIGKSLgd
	F3XByHo09E3rs0AKBvL7Mlk3w7HW2FiZmay6sMNoAjVaBoa/cFATwPnGoDIradlBQPwnOSQxgaf
	47QQj59YHPKrIPJphKWcx4DjuiFKcl22jTvL9eToNQM4h11x9APZvA4mozMFX9WYxdc0afyrbj+
	qp4mu2i1GpB421+vw9xvkxES2wxwI8oppkN+1FPoUBmPiqwjf8a+EV65xBiumzQYhVNn3zJYOy1
	qBi9IOooXXO5n2QUIE+QAS+xEHDZXskCqV9eTL8hcR4svgEl7MuVt1g/58WpB79VbrtvWm+3Qgs
	Yn6qDxNto37Un22l2Dots7ZPdUHekS0rPk8EIl5dXe324oVoR+YXk8383R52ZtLTO07JZyZNG1s
	N0TQapEQ==
X-Google-Smtp-Source: AGHT+IERA4tLz/ey+sqksaDd8O95SOQ+ftiTfmWz64Iw16YMS2qgAAmuUfqe+GtaoobHM8lLLXWy9w==
X-Received: by 2002:a05:6a00:cd4:b0:7a2:8343:1ac with SMTP id d2e1a72fcca58-7a286765c7bmr3304816b3a.2.1761329758753;
        Fri, 24 Oct 2025 11:15:58 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b822sm6724210b3a.40.2025.10.24.11.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:15:58 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH v3] net: ethernet: emulex: benet: fix adapter->fw_on_flash truncation warning
Date: Fri, 24 Oct 2025 23:45:41 +0530
Message-ID: <20251024181541.5532-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
string truncation warning when built with W=1.

Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
drivers use to report secondary firmware information.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 drivers/net/ethernet/emulex/benet/be_ethtool.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_ethtool.c b/drivers/net/ethernet/emulex/benet/be_ethtool.c
index f9216326bdfe..752f838f1abf 100644
--- a/drivers/net/ethernet/emulex/benet/be_ethtool.c
+++ b/drivers/net/ethernet/emulex/benet/be_ethtool.c
@@ -221,12 +221,20 @@ static void be_get_drvinfo(struct net_device *netdev,
 	struct be_adapter *adapter = netdev_priv(netdev);
 
 	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
-	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN))
+	if (!memcmp(adapter->fw_ver, adapter->fw_on_flash, FW_VER_LEN)) {
 		strscpy(drvinfo->fw_version, adapter->fw_ver,
 			sizeof(drvinfo->fw_version));
-	else
-		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-			 "%s [%s]", adapter->fw_ver, adapter->fw_on_flash);
+
+	} else {
+		strscpy(drvinfo->fw_version, adapter->fw_ver,
+			sizeof(drvinfo->fw_version));
+
+		/*
+		 * Report fw_on_flash in ethtool's erom_version field.
+		 */
+		strscpy(drvinfo->erom_version, adapter->fw_on_flash,
+			sizeof(drvinfo->erom_version));
+	}
 
 	strscpy(drvinfo->bus_info, pci_name(adapter->pdev),
 		sizeof(drvinfo->bus_info));
-- 
2.51.1


