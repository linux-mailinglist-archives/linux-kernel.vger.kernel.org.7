Return-Path: <linux-kernel+bounces-815612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC53AB568F5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D4C189833A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90407272E56;
	Sun, 14 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM70exrU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CA26B2D3;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854608; cv=none; b=TNVVnWgWqxVw9tnumT2Xk8fo5VQXId7esWItMZGto6h4SujFk2rZoXIeYNX+mBy6rGWPZmgZZ+IsfKynBW2EUrdUFze5i/VIIFhC8M/RXXDztzW+wk/uvd6frYYZZlAFm1pOja5/R+5iVV4Yqg7/LKDoT+5F7Iw76E5WfFdNIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854608; c=relaxed/simple;
	bh=n4r7zMHDw/fPAOcEpKAkNiWA7bMT/Gk7NMP0eqPegkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPNzMV62TEiEdL38mcYMzb7YLtE8CezaM2M0BURnjLGwfb1zsjRAt3eNBflKpZBS7J0uTC9JBB8FLBbn0O0hmUn++5r6il7GXgyzr24AzrahtcXtSHsUuZAZypUbC7JyPELraEBKO0Q04BqPZi30hwzsx8Bu9VcJHoodlD6JQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM70exrU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C748C116B1;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=n4r7zMHDw/fPAOcEpKAkNiWA7bMT/Gk7NMP0eqPegkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GM70exrUvCkp2VCAXOJiUKn+Z4tj1+T8uSrT32ZEsG0/B7Z74yLzH0CT47sje+w0r
	 8eA/HYlhfe1AA6h4MDnlFGuJiTDgRScQw1vzlU1XQk4udUy82TJp7tpB/3pqA8ylVe
	 rQU7OCqi3ZZ8YX7W670D7TBB+A5cGx805prxYKueQgUNamFNrHeMs9iSPQnAdrc3nT
	 yg1CWhL4ydmXp6rwNcX8v9CsQx3tT2Orsb/JCAmHBnoz/5qwvQpfNkPr6kRnenaI07
	 72hoA7IRtTXZJOsaXC72rr8gBTZf8G0oO0cUMigWHFdJz8maX9j/07aIKQNyj469Zn
	 eWTtSk4TNRrOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B98CAC598;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Sun, 14 Sep 2025 12:56:15 +0000
Subject: [PATCH 10/11] usb: typec: tipd: Read data status in probe and
 cache its value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-apple-usb3-tipd-v1-10-4e99c8649024@kernel.org>
References: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
In-Reply-To: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=SEqFsdZj9wQbFtYLraoDyZILplcZKiIw4Wc/CN9A6bM=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3R3KDnc5D/soHDFte8ez7pDPf1GvbN65wT4Mj0Mll
 u659+lbRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAi7w0ZGfYv3iFd9mtTW2v9
 0d1Lth41ipia1Tzt+f5U+4Ucgb+uHFdkZJjUeyaPZcEPpqe1lQECrt+ktZJ+vuW5/cLsyNqzh/b
 /i2ADAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Just like for power status we also need to keep track of data status to
be able to detect mode changes once we introduce de-bouncing for CD321x.
Read it during probe and keep a cached copy of its value.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/typec/tipd/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f546f4ae563af3d411ec6591fe9c3b122e4efaab..f347e5bc625497ddff270e3e9e4d2ddaf3ca6bc1 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -176,6 +176,7 @@ struct tps6598x {
 
 	int wakeup;
 	u32 status; /* status reg */
+	u32 data_status;
 	u16 pwr_status;
 	struct delayed_work	wq_poll;
 
@@ -538,6 +539,7 @@ static bool tps6598x_read_data_status(struct tps6598x *tps)
 		dev_err(tps->dev, "failed to read data status: %d\n", ret);
 		return false;
 	}
+	tps->data_status = data_status;
 
 	if (tps->data->trace_data_status)
 		tps->data->trace_data_status(data_status);
@@ -1551,6 +1553,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		if (!tps6598x_read_power_status(tps))
 			goto err_unregister_port;
+		if (!tps->data->read_data_status(tps))
+			goto err_unregister_port;
 		ret = tps6598x_connect(tps, status);
 		if (ret)
 			dev_err(&client->dev, "failed to register partner\n");

-- 
2.34.1



