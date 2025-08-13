Return-Path: <linux-kernel+bounces-766696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B4B24A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BA586B98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CE2E5427;
	Wed, 13 Aug 2025 13:05:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685EC2C3260
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090322; cv=none; b=ulIKt9+yDdVm30GvcLsHoCuvaNgbknZgyf/y9d1x+A72SPNIWbBjIHg5r5snYLiA3Zbwsm95y225yZzWwnEgg6zr2OUvN4MKmdO1SiOpkQJ7pzP0oElZ7+lZOkbc+Qrsw0XkotlT5aXqMYpcY9EdNeWZAXVeT6yGjEufhuvELDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090322; c=relaxed/simple;
	bh=CAh8Bd4Fl1/kWVp+FgGu4f/htKk8Yvm+AIGtG289KqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkWVDMXDiKkYWFjlz96cTpL0YzfMGdwUNqM7jLnYHqjzD5klcjXUroaSYy8m5VNG9YS6N5WQ8fogYeS10BskKnpZDxlhiaJ6aab8qpFLfgcBsMvqNPuSPp/Nr8aT1IPYDAnzwCc+znyFhBo+I1oZqzHz3I3VMujQrxjAqtyRM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9E4C4CEEB;
	Wed, 13 Aug 2025 13:05:19 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] misc: apds990x: Drop superfluous return statement
Date: Wed, 13 Aug 2025 15:05:15 +0200
Message-ID: <673e667895603b1a1b1ae8ec89e333ac15f4412b.1755090287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop a return statement that immediately follows another return
statement, and thus is never executed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/apds990x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index e7d73c972f65dc42..58946c4ff1a5af95 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -984,7 +984,6 @@ static ssize_t apds990x_power_state_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", !pm_runtime_suspended(dev));
-	return 0;
 }
 
 static ssize_t apds990x_power_state_store(struct device *dev,
-- 
2.43.0


