Return-Path: <linux-kernel+bounces-807336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F4DB4A323
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE121BC6A9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF813081A0;
	Tue,  9 Sep 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="iFDQVoRg"
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B13081A1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401899; cv=none; b=nn2hQGiC6YSRUN4T41zcOywvPMRpP0+xEFWqGHKl+skaVzSoELfMCI99dDic3HzEaw5h2D/1YPchizacuhYX8FYBVaR+qAnQh1IWz9fKkrVolmisPKTxJG+mPZHWd3jr8tLXCCc0ZLxFMNYwdzb/Sdk4pgaFKHEs9RDMZa/tLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401899; c=relaxed/simple;
	bh=OL3zTc++fWocVV76N9Qrx3mPmqq+2NTo3NP+aQUzDpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQ2N/ZuakWAYr7iUUv6Wlc7q8vROLyCDLmDw+1Kdg3xeIrTUuaV5WdMl9VeLhNF0X0ELCKRMUbRfLURUpdmyPkGyjyFuk+06D/qFRP+MX6l4qW+soFplWk+VbHUpCWBgdo4GmxTpSM1bQaCkPc0C75PTHocXoMsps3pr5mgCLG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=iFDQVoRg; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1757401891; x=1757661091;
	bh=tceitGNVxLxyezCWiChxK4zQKtJl6rtYJ4s3FymhP8g=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iFDQVoRgFHYP2++0Dl2aN7UgDIawbjp7S9qyyqgZF5NsFyPgI6vaYgFKr4QeVaMI1
	 H/HcOBRsrEV1fYfOP8AQOI8xU8z2QBWZNkWhR/IDUbfM0mqdLO7ZIXLD2+iuCwp0UL
	 penLtq0sZpeqHv5C//KrVtQ7Yubt9X1JoFiJ+0gbHew+gXg4rIn+eH2gNNNVQMNjF2
	 qV3Yeqqo5TkwfsKQaLoawidO1793XoxZz4DsuuUNlEraza4MDw368n4hfRznOpTD4d
	 DaKk/rA07sXT26YbDXaa4mJg92/87aMXJvDGeoHas9DEKxBJxJ+zj9fLwLw70TwXRX
	 U3WdJ0NGCG/eA==
X-Pm-Submission-Id: 4cLZk85pLMz1DDs1
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 09 Sep 2025 09:11:09 +0200
Subject: [PATCH v4 3/5] iio: imu: inv_icm42600: Avoid configuring if
 already pm_runtime suspended
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-icm42pmreg-v4-3-2bf763662c5c@geanix.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
In-Reply-To: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Do as in suspend, skip resume configuration steps if the device is already
pm_runtime suspended. This avoids reconfiguring a device that is already
in the correct low-power state and ensures that pm_runtime handles the
power state transitions properly.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 41b275ecc7e25ea0b8cdf59be514cdf8a4957ab4..ee780f530dc8612cd25dc2216b153ef4e8c32b7b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -837,17 +837,15 @@ static int inv_icm42600_suspend(struct device *dev)
 	struct device *accel_dev;
 	bool wakeup;
 	int accel_conf;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
 	st->suspended.gyro = st->conf.gyro.mode;
 	st->suspended.accel = st->conf.accel.mode;
 	st->suspended.temp = st->conf.temp_en;
-	if (pm_runtime_suspended(dev)) {
-		ret = 0;
+	if (pm_runtime_suspended(dev))
 		goto out_unlock;
-	}
 
 	/* disable FIFO data streaming */
 	if (st->fifo.on) {
@@ -900,10 +898,13 @@ static int inv_icm42600_resume(struct device *dev)
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct device *accel_dev;
 	bool wakeup;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&st->lock);
 
+	if (pm_runtime_suspended(dev))
+		goto out_unlock;
+
 	/* check wakeup capability */
 	accel_dev = &st->indio_accel->dev;
 	wakeup = st->apex.on && device_may_wakeup(accel_dev);

-- 
2.50.1


