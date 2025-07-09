Return-Path: <linux-kernel+bounces-723611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C89AAFE915
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028F11C80534
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235C2E0409;
	Wed,  9 Jul 2025 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="S4a+aTEW"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C192DFF04
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064546; cv=none; b=aV9cZseJrrzSIIKLfdn6OKay23jOXRI2OkF9Ayv0KHsD74ZSPaeqdtdvTbFnwRa+Ju7sVsLntTn2muroG08Fc2VQGSmbeWfLwYiIkRr5B7EfmOz3Wb0fjGUTF0n7m0Xq4z1dx5hnv7prOrZysbOq2d7PSfl4dporWtMZm/rGW38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064546; c=relaxed/simple;
	bh=dX8aDAQus10+ARfQJcvwjNcEfHz5PxQHBqUri8THBws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXVfhVmyQbIHC35S0/feGl1rLYsX24zDrqJ6sM7ZX+RXrsiTmzqcT4on6T9n4oxZaQG562utJ8N0ShmlI5g/y1mAB/P0wIVfBZTSbpsivZkGfbMTscYP5TAedecnjLCo4YMRzX/xGu+Q4+UhJ+Y0vqsf1oFKR1UVGEfOvyOhcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=S4a+aTEW; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064525; x=1752323725;
	bh=cv9a+2twXQl1jbhyzihfbl+qMqFqefRQSxIXNMTNAZU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=S4a+aTEWZXqdSxasu9i3Q+ySNFKsGE6HU7UxVyUC6GEoGsTpR0KltvRQsJTDgGh5a
	 350dBTTlFeQAAzFqSSzDFlFOYHI3zGr/Z7tEYcQJDWK1rqWna38kO+yjYX/epLPSxK
	 VazVxsefzojxYJ13aMqb9pfErLLF7c/g2htlvs+3jTtq4dIf6gTAW6dii0Y5vekOxZ
	 A/hSIJWLlM4wFee/P0tJ+sWiPmh/kVYKz5GMtBH232hMHYMviptdNho49wQ+rH2De1
	 dz2YyjnbV2QHebzrjMx3c7IuEWan88jH3R7FRF0XHhyzltsgRtpGiE3mKzJJbKUlpN
	 YQqIIr5CP74kQ==
X-Pm-Submission-Id: 4bccrX5QDzz1DDrW
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:13 +0200
Subject: [PATCH 5/6] iio: imu: inv_icm42600: Drop redundant pm_runtime
 reinitialization in resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-5-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Remove unnecessary calls to pm_runtime_disable(), pm_runtime_set_active(),
and pm_runtime_enable() from the resume path. These operations are not
required here and can interfere with proper pm_runtime state handling,
especially when resuming from a pm_runtime suspended state.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 1072bea11c73d09a9a0e6ea9d4a5c7a72248dca7..37b3a7754da1c4e381e38c9871e55a941e19cef4 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -904,10 +904,6 @@ static int inv_icm42600_resume(struct device *dev)
 			goto out_unlock;
 	}
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* restore sensors state */
 	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,

-- 
2.50.0


