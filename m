Return-Path: <linux-kernel+bounces-877932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC95C1F620
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE401899C1E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D74347FD7;
	Thu, 30 Oct 2025 09:47:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84344C6D;
	Thu, 30 Oct 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817652; cv=none; b=Q0S+HH5utDFxDgV/+tkcgwq1HId4Wv7nxAAEBzk9yPaqUiz+B6sGuFhpS9Pw8gDjPL4+GLwzUmU8XkaKjYHrVQGi3BZEe0aFxjgUteVDnXXrdFm1NObPwcqD9UHS7EhVkA8k5DzO2W/K6CsDgDVOSiD/q+7l51Kn7L91Sehd6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817652; c=relaxed/simple;
	bh=sn+bKtHsVI42aoD+4isPVZxb22meB/qiiVkfiZk1lOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axqWL4k+8O+cachzsAaQ2d1mVUEAN0rdFMe5PhyhgbrhdBseseA/nGL+9S19gJxyClGi+/Z/nAVyHYe5aPxsBiTNdKIIr5fuTPd5nvYF7dI7RFZghLvMI31O4sWXiPTunOYvqsgmknDfYSz6OW0DKQ5iQitX6pP3CcfNp4uADec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F277DC4CEF1;
	Thu, 30 Oct 2025 09:47:29 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bjorn.andersson@oss.qualcomm.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] arm64: defconfig: Enable SCSI UFS Crypto and Block Inline encryption drivers
Date: Thu, 30 Oct 2025 15:17:19 +0530
Message-ID: <20251030094719.4873-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These drivers will allow using the crypto functionalities of the UFS
device, like Inline Crypto Encryption. Both of these drivers are of type
'bool', so they cannot be built as modules.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---

Compile tested only

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..9f89b3ce1262 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1230,6 +1230,8 @@ CONFIG_SCSI_UFS_RENESAS=m
 CONFIG_SCSI_UFS_TI_J721E=m
 CONFIG_SCSI_UFS_EXYNOS=y
 CONFIG_SCSI_UFS_ROCKCHIP=y
+CONFIG_BLK_INLINE_ENCRYPTION=y
+CONFIG_SCSI_UFS_CRYPTO=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_CLASS_MULTICOLOR=m
-- 
2.48.1


