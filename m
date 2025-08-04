Return-Path: <linux-kernel+bounces-755194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AABB1A2E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5087A1812D7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6272609D0;
	Mon,  4 Aug 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nBXMycAZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162838D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312859; cv=none; b=I2o0q+hNeT++HtDxLAKLhenCdQWPjnqsuuJ/zih5sYM/7QL6IxePJmk4Pc537KYYh7VeKarx/5RybPeAbZOHswzPbaGK+If/HqBD17kyEH+cUoP+sf4pMMiY+TdqgKE/vcqeqWW8vKA2P/9n+YflnFVOmvaVkAGysxYB831gCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312859; c=relaxed/simple;
	bh=t1VVDq5gsgWO4hJuz6Bueawo6Sfhw2PRg1m+lLHu2eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA8VVClPv4w8RfxvBMuL71SaJyLk454pRrTF+d2gHlBHtprByB/oKi4bLYe02AJ07dvFU1ZWzCAg1QpsXOMvUHdsvkt+d2bKnGfvYIM1zNts4UCliUpS/X6xAfv3ZVkbr79OigJhzAQQVFiHmwMiwn+GkJkUsoLA2n90KkoI9hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nBXMycAZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=99LrBt/odIJurv9nnoEhYRVaTFqvbrSDf57BXnFddig=; b=nBXMycAZg9wxYuKJpGlOHaojA5
	2oMn4OBjXtxKdxDgrP5p5Skr/weeWm0KStj7mvIAK5DKkfuVUIVTteOTZYlUlpVVWL4F21+Sg3eOj
	4a5/0RhNyWVFeTwSDyUNr16oEX9B1GNphrpghXOFg+3E4y/OTF5BFfd1MW4vIEJYD255hqs06PRdY
	4IRU7GjsDee+BTT85AWSMATKeThylmNJy7KFdjAPkTwwJXI31hr919y3mQuUNIoaZJuHQCoXUHFcc
	8QO4+3xED0XCOHqCL0WT38zhNSy4AmiVdHWVIjOSQcHJdfgvGVmIGHSNfyBTskRkxk5jfgly5nFLK
	el1kKWIw==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uiuuc-0004Ov-Pn; Mon, 04 Aug 2025 15:07:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mfd: qnap-mcu: handle errors returned from qnap_mcu_write
Date: Mon,  4 Aug 2025 15:07:24 +0200
Message-ID: <20250804130726.3180806-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804130726.3180806-1-heiko@sntech.de>
References: <20250804130726.3180806-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qnap_mcu_write can return errors and those were not checked before.
So do that now.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index e340e9337b98..6448237c4c35 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -163,7 +163,11 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	reply->received = 0;
 	reinit_completion(&reply->done);
 
-	qnap_mcu_write(mcu, cmd_data, cmd_data_size);
+	ret = qnap_mcu_write(mcu, cmd_data, cmd_data_size);
+	if (ret < 0) {
+		mutex_unlock(&mcu->bus_lock);
+		return ret;
+	}
 
 	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
 
-- 
2.47.2


