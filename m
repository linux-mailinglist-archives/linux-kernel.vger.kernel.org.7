Return-Path: <linux-kernel+bounces-786881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0CB36D81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF535E85E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DAB2D7BF;
	Tue, 26 Aug 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt5nYDYi"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311219E96D;
	Tue, 26 Aug 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220919; cv=none; b=rQ8/yvhnjvNh7j7InULF72zmk5RgBm/CaFm+39uJjpL/HKWPtQtHzxIup2cPJ0hyqd6mBxEvompGIlVVbwlLmk03Hx1DZelHwsY9+QNtDi3FGUvjO90tA+Ob8btMnzwTU4KkUE+bKUiV41eNGattMLTwEZLlGZD2PO1zF7EKIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220919; c=relaxed/simple;
	bh=W21NQZVhesJtBq0xj/kSQKsKlU3qd0NhFQAYcSiC7G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=akcC2UZdchyDRVfrNRSj0aO0etL5puh7oK+DgBxnlhwx6dzjYmJXyUHOC7qJFDLhHTTEuiQunTIAmhqN5OI9yLPdDi9fYXHKvLW3Tk7mA8U5q2weFQ3CuyNemB6B4KR+LBDUvMk/YIXIEK6TW7jLa1UAS4BFHZvzOvtNbbAuk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt5nYDYi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so5077678b3a.1;
        Tue, 26 Aug 2025 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220914; x=1756825714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkW0jN2wo9GzfPCzxypiZo0lFb+ddp6azlGYsLnGuuQ=;
        b=kt5nYDYiuUlG33bktvHegsliXF1BjGQ0i2KdJrR427k5r0ioN40QzV1ESoyKh7xmYR
         5psxG6c9Lt3EmO4mGjxKHZ8vCfc1UX4MXPq3K4bEAeqCAnUVBEoNdvhcGl7XA/fuQ/Sn
         kqxsteXqowBkrASrpoXkLHYA9DTFEWcLqwnQvxw8rXEWGwSNsBhixjpRDEpEnl+7XeGZ
         6G3QLLM1bSEQuFNqoqR75fGlCOJKCaRhqmUDCf/xT7al5NrwIf2Hm6MRW9gTNyVZ8mzv
         HjblfNPSepIkgGeMkOHJf1DeVK/7uE+lMPpREOSpt7Yy0lBNDV5bFA9E6OGlOiftqWKm
         xiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220914; x=1756825714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkW0jN2wo9GzfPCzxypiZo0lFb+ddp6azlGYsLnGuuQ=;
        b=QZwZxwok629XgNX/LFgc9gAHrsTIAxt3HWZrnSdFb4b2dvSMI8KIe2Jg/SZC6VVtRJ
         RjBbDUauZR4U4uWppONIN1K5D0HYLUA5FlyXDCjLomQWCq5tU7/MVwGd3bKYqffnIK8y
         t0gBNTefcymevovUQmX1WGkcVCCZMfvDKvUdW3IK9WAoViS62t7uqQbMODz1FLd+4MeU
         POOoqgKmrrBPIqUboKFt/JljGcw5fABkkAAyrk4wtT4vzrf1GxJwcf3B+wXg9CX+YCzC
         6L7hE45BCN90kQ7MN0phed5BM2l0QhlPaS9qWRCFSLlw05L7PNcmm7EbmCqRm5zEunR/
         X4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUaQVJ0kyyJb331/WykrsBmOAdvHRrRbeM5awpSOJVO9dX9j7/3EkfYptfpLrSENPoxR3y3ZDmAhmVj@vger.kernel.org, AJvYcCX7jPK3uSFfwbMzd4mSl0G36t20C2xqsPs5d5tPIeGL9NpOkimbSUKfPJ3DUJbiRwUC2vQbhGcFPiNg5lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7DQRR/jhItiDo4QGLWxAq+kRSDm3hNw51q/FFRL58cntDl/2
	1e0hw/YJDQ9inR0o5g7lEMiRVjhZh75h+DFkcY+6pcQkmhOjIG9fuo1E
X-Gm-Gg: ASbGncusRutJXS4pc7wcVxC3nntZqu3/XXLN4j3CsO6+DbBMIMwsODjitGqsjSEZQEu
	tAA5lmcHkXhqahKaZWpQg05H62dmxaDdqmbiiohLxMbQttqx+fcCipkFkOlwqeV5WkVih+CJPoc
	VWeSyc5nl1CamrvYVPmqS0MjpkO75oqS02Q+V01YcoHvj5Z3chDtZAIMAu5FT+vaDwr7EbXQvvj
	slF3JI9gLH3fuGFn33qId6wR3OzzPwnH0oRpV806hH65/zAWXKbAfLQgn70R59z+gFc8l4/Iz9k
	G2ZdNayTmsy0+EB50ZJNBTTeHUxJhmO36guQZF95fdquU6Nhcpx1n/CZ0CO0JCSXTr6lqNeypiX
	v+gtVva4=
X-Google-Smtp-Source: AGHT+IHpvhGFD8Uqd1jZ2V5zDm4pk296jsaMf5yG31mSyBIsRiAJP8sCr7izZINDolhSKeMp8La4lQ==
X-Received: by 2002:a05:6a20:939d:b0:243:78a:8294 with SMTP id adf61e73a8af0-24340e2f1a5mr25415816637.59.1756220913907;
        Tue, 26 Aug 2025 08:08:33 -0700 (PDT)
Received: from localhost ([2a09:bac5:3983:16d2::246:5f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771fd80300csm1468446b3a.106.2025.08.26.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:08:33 -0700 (PDT)
From: Ryan Zhou <ryanzhou54@gmail.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ryan Zhou <ryanzhou54@gmail.com>
Subject: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate child device xxx.dwc3 but parent is not active
Date: Tue, 26 Aug 2025 23:08:26 +0800
Message-Id: <20250826150826.11096-1-ryanzhou54@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue description:
The parent device dwc3_glue has runtime PM enabled and is in the
runtime suspended state. The system enters the deep sleep process
but is interrupted by another task. When resuming dwc3,
console outputs the log 'runtime PM trying to activate child device
xxx.dwc3 but parent is not active'.

However, the child device dwc3 continues to sleep pm_resume, calling
phy_init and phy_power_on, which sets phy->init_count and
phy->power_count to 1. Later when the system meets the conditions
for deep sleep again, it attempts another 'PM: suspend entry (deep)'.
dwc3 driver executes sleep pm_suspend function but dwc3
already in suspended state, skipping the suspend process in
commit 0227cc84c4441 ("usb: dwc3: core: don't do suspend for device mode
if already suspended"), so phy_exit and phy_power_off are not executed,
keeping phy->init_count and phy->power_count at 1.
During the next deep resume, phy_init and phy_power_on will not be called
due to non-zero count, but the count still increments, preventing recovery.
Eventually, this leads to USB device phy cannot be reinitialized.

Log:
[  130.284870][C5 t2624] PM: suspend entry (deep)
[  130.391369][C3 t2624] dwc3 51600000.dwc3: dwc3_suspend
[  130.406326][C3 t2624] alarmtimer.0.auto: PM: dpm_run_callback():
platform_pm_suspend+0x0/0x90 returns -16
[  130.407873][C3 t2624] alarmtimer.0.auto: PM: failed to suspend: error -16
[  130.417756][C3 t2624] PM: Some devices failed to suspend, or early wake
event detected
[  130.438254][C3 t2624] [asr_drm_resume][726]: ==debug==
[  130.440178][C3 t2624] dwc3 51600000.dwc3: dwc3_resume
[  130.440950][C3 t2624] dwc3 51600000.dwc3: runtime PM trying to activate
child device 51600000.dwc3 but parent (51600000.usb) is not active

Solution: During the dwc3 suspend process, check the runtime state of dwc3
to ensure it enters the suspend process only when in the runtime active
state. This way, even if the system suspend process is interrupted,
the parent device will remain in the active state when resuming dwc3 from
deep suspend, allowing successful resumption of the dwc3 device.

Signed-off-by: Ryan Zhou <ryanzhou54@gmail.com>
---
 drivers/usb/dwc3/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..20945cad29a1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2439,8 +2439,6 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 
 	switch (dwc->current_dr_role) {
 	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (pm_runtime_suspended(dwc->dev))
-			break;
 		ret = dwc3_gadget_suspend(dwc);
 		if (ret)
 			return ret;
@@ -2671,6 +2669,9 @@ int dwc3_pm_suspend(struct dwc3 *dwc)
 	struct device *dev = dwc->dev;
 	int		ret;
 
+	if (pm_runtime_suspended(dev))
+		pm_runtime_resume(dev);
+
 	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
 	if (ret)
 		return ret;
-- 
2.25.1


