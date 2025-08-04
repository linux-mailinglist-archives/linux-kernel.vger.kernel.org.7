Return-Path: <linux-kernel+bounces-755193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C7B1A2DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059B9180BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475E260569;
	Mon,  4 Aug 2025 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gKxRH/5Y"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176324BCE8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312859; cv=none; b=M/1QfCw0YbHHCpN3HBUbdD8U6Uycgp49JRjjZ3l6PfYbCSLoLDVIfSR6C61pBfstcs6ECrygkJyD4VjYDDogRIRlyuC4lSwewEg2P6IGlfTqtaP2g7XVVPGl6Bm5tSuSPk8ktpTdvMOXw3/pCiPbV3b8bdMzqtTcrG6fv2GcdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312859; c=relaxed/simple;
	bh=c2KCw+7/JubXkEWrkrjGSF3igBfPYanRA/j2cUU0QLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXYZFhOx5yFi7IR62dIiAwf3mKjaR5rDdwecMz8DOs8PdopW4QW7FaH6dZCbRrt2ZIGCYkzhMcyHXMzhJmY6oNX8uLaDkXItBXpCzYcvnKm/XtjMZuR3nZgm7yM39dVlForJgLb4K9A9RvSiTq2avsfPReAM+fB2DdoTKyM+kJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gKxRH/5Y; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=QUVGRAbMjoz729uEHckqeaG16KmrbTwZ75S0p71sw8s=; b=gKxRH/5YmFOaKDRkJ6PLVzYFRx
	NtuUiI6Xe+s7TLB+wJs8HvGg0YUxxM0wKn0Tlwdoi4UkkdL9jSY/1Rper2bJ0WC8ddEVqUKOrRkPs
	FBaIrwXJV976wR9aiRLmkq3RGmaEIS9kurnJcv0IDcxbfEiaBQ8sZGNkuLwBnK+WABWXuA2S98rjR
	S/bUTq2zGjAQ1Rv8sGzCBXdvN+Q0iKxddNtGp9abBCNmHUoAGyzz6dTqbkZJmqmJQzEzcOdJLLZa5
	CpiqVRZOpa/AB4NvtIEskpLj7xttxZhRkJ4WA6BdvXZVz/p4h3TIsdojse6k1l7Wi3cmxM55UTR91
	o0InBXSw==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uiuuc-0004Ov-U1; Mon, 04 Aug 2025 15:07:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mfd: qnap-mcu: convert to guard(mutex) in qnap_mcu_exec
Date: Mon,  4 Aug 2025 15:07:25 +0200
Message-ID: <20250804130726.3180806-4-heiko@sntech.de>
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

guard() makes sure that the mutex gets unlocked when the function returns
and thus removes the need for unlock gotos or similar mechanisms and
therefore allows for a simpler function structure.

So convert the qnap_mcu_exec function to use it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 6448237c4c35..7bc44c64b7fd 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -156,7 +156,7 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -EINVAL;
 	}
 
-	mutex_lock(&mcu->bus_lock);
+	guard(mutex)(&mcu->bus_lock);
 
 	reply->data = rx;
 	reply->length = length;
@@ -164,30 +164,27 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	reinit_completion(&reply->done);
 
 	ret = qnap_mcu_write(mcu, cmd_data, cmd_data_size);
-	if (ret < 0) {
-		mutex_unlock(&mcu->bus_lock);
+	if (ret < 0)
 		return ret;
-	}
 
 	serdev_device_wait_until_sent(mcu->serdev, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS));
 
 	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
 		dev_err(&mcu->serdev->dev, "Command timeout\n");
-		ret = -ETIMEDOUT;
+		return -ETIMEDOUT;
 	} else {
 		u8 crc = qnap_mcu_csum(rx, reply_data_size);
 
 		if (crc != rx[reply_data_size]) {
 			dev_err(&mcu->serdev->dev,
 				"Invalid Checksum received\n");
-			ret = -EIO;
+			return -EIO;
 		} else {
 			memcpy(reply_data, rx, reply_data_size);
 		}
 	}
 
-	mutex_unlock(&mcu->bus_lock);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qnap_mcu_exec);
 
-- 
2.47.2


