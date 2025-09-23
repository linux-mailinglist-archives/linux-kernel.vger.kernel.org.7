Return-Path: <linux-kernel+bounces-829309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC89B96C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7413618A876E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B02E7F27;
	Tue, 23 Sep 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hrJgptjG"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CF778F59
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643751; cv=none; b=Zg4fA+gPNkaBYZqGyLpklfpGaPeBCBzkR9hZtgCukKLXxlkI2LEpfe8pS9Hx2Lmf7Cxy0I7eMIJF2DNKvADgP4nEMXR0SlR0tFqlte8hxz/xO4LqBz7gGGw+MOjYqOJNs69L6cg7hlxnkB8B0KfAzPbyg4/6q3n+u/kQUZnKXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643751; c=relaxed/simple;
	bh=nXovU8Z9lcvw9h3dBvRi7sK4wfZTfh+iEEWHXqhJ3Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gE0tdL7aWfgR0PI72YWiYcCCLaNrDOqV5Tb2Zl007wMsvpj/Sj+OglHcoLCVLB9W3ojZR+Rzye1goyWQMKzPL2kA7AF8dy9FveWvqold+x2PHgDUQ9F8fMVltj9R4nbYlx8u54P0X6g+7DB9ZzrGt6/TxxiAtEgVRkJn3jNfx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hrJgptjG; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=/P2H1HQIzFcvBqE1RaZPIVfxAOIj1n2GfQ8xkB+a48M=; b=hrJgptjGe9W5aKrd1enuA+sSmn
	MKx1/Ul2LJhp3H/0IFkIMuZ4nwauMdgCGnEWABx3ndmV20WisphFQiTniPZzJGmKCcVkMHJmlT8QY
	ureCAY3MA457mlFwaqJh60GKQYvOZWEEJtTXYoC7EPd+cctMFKrLZm3xLwYg7gP7w+1Zl2UbVtW+y
	Kelhw6TYv07lO58n0yGBGwPgbpifXFHXZGFhdii6vvp4vPTwpqhn1bMs7KODJi6nT3SZYsN9vQl8w
	w2ZakftmKyiw5UnZ51sqTnKh4HTYTdTnUXpU3RlZ3FBNL1DqB4d0KQUZO5Xyl70Lzpg14/ELvmNcb
	ZMvs8PfA==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v15Zi-0004vp-Vi; Tue, 23 Sep 2025 18:09:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 1/4] mfd: qnap-mcu: Calculate the checksum on the actual number of bytes received
Date: Tue, 23 Sep 2025 18:08:50 +0200
Message-ID: <20250923160853.1925674-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923160853.1925674-1-heiko@sntech.de>
References: <20250923160853.1925674-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of an error message, the number of received bytes can be
less than originally expected but still contain a valid message.

If the transfer itself ended in an error we would exit earlier already.

So calculate the checksum on the number of received bytes and not the
number of expected bytes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 2be429a50611..e3210541ec56 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -175,8 +175,8 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -ETIMEDOUT;
 	}
 
-	crc = qnap_mcu_csum(rx, reply_data_size);
-	if (crc != rx[reply_data_size]) {
+	crc = qnap_mcu_csum(rx, reply->received - QNAP_MCU_CHECKSUM_SIZE);
+	if (crc != rx[reply->received - QNAP_MCU_CHECKSUM_SIZE]) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
 		return -EIO;
 	}
-- 
2.47.2


