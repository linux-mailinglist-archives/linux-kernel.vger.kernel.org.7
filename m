Return-Path: <linux-kernel+bounces-871969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDDC0EFE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DFB3AE596
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867B30BF79;
	Mon, 27 Oct 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiIdaDij"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A02C21DC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579215; cv=none; b=VjIPyb4LmL1uycK6mTDh1/NIGEcusZ3wsyGz4I+RXtHBV5IR7nZacMwjSGDScifsmE/A8aGJ5QV5oqRI8N5nxlk50tBufdsKdb7DeVGEQRYHo4S4yISp7X71O0pj4NbhfThxcd3afvv8gEL92TU0H+VGcIZd3nlmGd9jQs24wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579215; c=relaxed/simple;
	bh=WdBEdLpSforioHhbukeXfUmMVDWPeJnblF0f8wKYRHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=revxQk518I8UreCAbt3zK95rKOpjnAHUD2mGaPE9RvU48PcIozrNfDcS0bsF6sCLMfPlDsFtWwK0xq5ubGAr2hTamUZD9i35e4Ct8BmOV8JQL5ZjDYgj7nZssFurqCGtv/kdOosMo4CBr3gohhlc/Qi2floNHeLrc8ScpxYwgQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NiIdaDij; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso3459021a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761579213; x=1762184013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyCJFEF05gZrJ9JMkK8QYJcfOxWfVMGePa9EE1L1ZCg=;
        b=NiIdaDij8RPnXWj5KP9bBwW3FrHfB1ghyPDE6n0usJ9YA8UycbUr3YgbZG6mQqrl0C
         72emAI2qz26zXXMge2PohWi7BIchYLVh3yTPyDC5rUQd5g41O1yX49NxVx2kbMO0/uqk
         k1AKn+GP7QwYp1gAZYlSrhv0NMentposByT5A7ucW9TSaG9sE8v2r2OxDeH03xzWAGll
         RPjOEYjuxxRQoCXOp/wYVDcREfLlsRpGehLV86qjGeQRDL5nfjrPGbsVFCFIuM7Aj8aG
         72lg8xsHUz6MWUB5o7oTcIcIpXM8E6XcZwO7aE2VL9x5uaP1wknA2GwB/nTnOANX97pZ
         VkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579213; x=1762184013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyCJFEF05gZrJ9JMkK8QYJcfOxWfVMGePa9EE1L1ZCg=;
        b=NnOEklbS7h3UqVDV3xoPe8Ee31yLCaQuGCtE5YhAlTCOfVSsmdBV+/q9//ALsZDN1Y
         Uv0HXOCzq2Wc7Iit8nPbFxUzr5tCsS2hmhCAFYfUwSUdhza5Gdw2AIxTM8vGl7FJRIgK
         IBoJoBbpzkGiVzDX95hG7SeHerxxnVgzW7+4ZJlm1F/oZUwWkagrT0ATquN1THpRD0eN
         csfDfx/WPASw+NmpWJ1dqd/sZ0sRD9u6q6m3RE4o8R0zdHqnX/ghkyMrP7+1McTpI2Mw
         XAo3CP2glAWYK1g3yq3Oe0rOl6mCPhRNQaBkniZAvWJeUzX6NdjKVbjpkk5LB5PX6vVo
         BvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNBWHRwEyG9gPTa92yXADA3k+snx69qLVRJUtQvHILg07+7IuEWMCHuGQIXQTCVpcJ8k+IzmmLXN8bCgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CJ14hMZHIa1vtZY7Z7WV+osdTlecSfARvRIJtjctnxRq55oN
	Oo4dW2odmm8yyZFFOSVVW/BL/yVTIY7rmgiiRNCHA87c3dQmudAgcaKh
X-Gm-Gg: ASbGncvzTa7D5/jdt5l4NXwDSIuGSqt7WiSpKQRrts+seBawWeVoltX1qoMJLdjMJzE
	e00EcpqDHM/88T9uYBRWKZB1d+vcgvnuKBg+HIwJqmCPNvYf7d7wqDplqOA4EX1aZH1nfAfea0+
	GSJb3mES8L0aVgCfImBnWvnAseUD7TMh8fww0YUwj8OmhpNpmGHnH/SWj57Luxw0V9He/lcaLA4
	ZlGyHyFCV70h+zLQuPljqFWwmDyO6IApZq6PRxdf7PJ2fBivAPZc2o+0EaRGrYuXEzZ0PD/BJTR
	QLw2LPTSNIBWaZduotr7c594vUFYiqe/q0kP1GQeN3VXR/Lb1AYHRdAVKr7hgat58cTukMkQL0g
	vrnTiUTqSgWxF2V841MPGh/zJK9K8fr6x+ju9k/faciU2DxXQlWUDHdB1nkB9/POiCS1D/8jLcM
	PeRCYaRODlTeMhmIz9y+NYTlM3bUI488eR
X-Google-Smtp-Source: AGHT+IEshwgNJwDO9dUyM9pXppLasDaedDty5cozPvWHVpiDiRN+D5hXAsbWqdxeVF4eaG1w7MO3rw==
X-Received: by 2002:a17:903:124e:b0:24b:270e:56cb with SMTP id d9443c01a7336-294cb3e5310mr4051855ad.27.1761579213005;
        Mon, 27 Oct 2025 08:33:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf4a40sm87272165ad.0.2025.10.27.08.33.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:33:32 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephen Warren <swarren@nvidia.com>,
	Hiroshi DOYU <hdoyu@nvidia.com>,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] amba: tegra-ahb: fix reference count leak in tegra_ahb_enable_smmu
Date: Mon, 27 Oct 2025 23:33:15 +0800
Message-Id: <20251027153317.66454-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver_find_device_by_of_node() function returns a device with its
reference count incremented. driver_find_device_by_of_node() is an inline
wrapper that calls driver_find_device(), which calls get_device(dev) and
returns the found device with an incremented reference count.

Fix this by adding the missing put_device() call after the device
operations are completed.

Found via static analysis.

Fixes: 89c788bab1f0 ("ARM: tegra: Add SMMU enabler in AHB")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/amba/tegra-ahb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index c0e8b765522d..6c306d017b67 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -147,6 +147,7 @@ int tegra_ahb_enable_smmu(struct device_node *dn)
 	val = gizmo_readl(ahb, AHB_ARBITRATION_XBAR_CTRL);
 	val |= AHB_ARBITRATION_XBAR_CTRL_SMMU_INIT_DONE;
 	gizmo_writel(ahb, val, AHB_ARBITRATION_XBAR_CTRL);
+	put_device(dev);
 	return 0;
 }
 EXPORT_SYMBOL(tegra_ahb_enable_smmu);
-- 
2.39.5 (Apple Git-154)


