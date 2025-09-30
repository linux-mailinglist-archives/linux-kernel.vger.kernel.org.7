Return-Path: <linux-kernel+bounces-837808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1162BAD3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C841B7A3816
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D36303CA8;
	Tue, 30 Sep 2025 14:44:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B2173;
	Tue, 30 Sep 2025 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243472; cv=none; b=UHTekyDrDhFV24fIXvjDcS+CcDDH8BwTdnx+ZqyLqUVDdP6OsXtRDOWz9zQ5+FFn+VzMJRQhW5oVKJe+w9cDqAcz2cczoe2/kDNRwhTqtVqHJRtYlGhbCkKOxsyOQHoEk6rRytb7nIyWuiEPObmR3PxDEYl1ld5XT2roO6yiAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243472; c=relaxed/simple;
	bh=1CwdVmIm+Nr31PfAvroGq2l2A824KFdb1d9O4EKtaug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nopXvwobdAnjRVCYbnHUkW1URrx+85vYPS+e7XVAyP3QMI9+d8JXRqDZkfwWhcr+I3d90HEhAZSVGnJpzHhUZ+PKpeApBJCbm84WthFEtP/C/iUbXdA8vhtbUuQQroqpsQcIUrOjgCe1DGjLxvZZaEb/1sfB0br48lg7qAPIFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A10C4CEF0;
	Tue, 30 Sep 2025 14:44:30 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
Date: Tue, 30 Sep 2025 16:44:27 +0200
Message-ID: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm Trusted Execution Environment (QTEE) is only available on
Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
the user about this driver when configuring a kernel without Qualcomm
platform support.

Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tee/qcomtee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
index 927686abceb1536e..9f19dee08db491c3 100644
--- a/drivers/tee/qcomtee/Kconfig
+++ b/drivers/tee/qcomtee/Kconfig
@@ -2,6 +2,7 @@
 # Qualcomm Trusted Execution Environment Configuration
 config QCOMTEE
 	tristate "Qualcomm TEE Support"
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on !CPU_BIG_ENDIAN
 	select QCOM_SCM
 	select QCOM_TZMEM_MODE_SHMBRIDGE
-- 
2.43.0


