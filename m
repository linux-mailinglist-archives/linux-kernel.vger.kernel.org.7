Return-Path: <linux-kernel+bounces-833110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17415BA13E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC137BB768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606A631D748;
	Thu, 25 Sep 2025 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsJnY0DQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869C31CA46
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829386; cv=none; b=eVJqpIT/FvH0hQ9vpJ+sevK63VhydWO6QPBIjSd/Hwr1dMTPQjE8g5df3grtPVN8sttEbVzJKuxvf2qg1NjrUryADIE0q86QAspPFq7L+j95SF3XLCu73w7+0EnwhNnFsXf6MVYH5AUskFydVG9oTSzGbr36B8i/fZtEpyWbbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829386; c=relaxed/simple;
	bh=LAZQD/pEHja6O8K/SPscN5qIKkE6Cr9T0qE9OsD7fIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOTWPJAbPyuyoc4vXHnZZJMn+mfi8O3tklT+irZi1Nz1QptArMQN3ZuYfCbRTnkh3Pdh2/4uEA6v6GguR0j90Dg1h8wdO/4pCqDHNbhfQwYX2DU3eLe034Q7Jk3l5MY0siRuArzxxbL1fOWHIC5ul4vXgTdqwrZtI8e90YEbLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsJnY0DQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so1838705b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758829384; x=1759434184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7MMUWfpwmVWVY6VmS+MHYWz1tm5Ol/92uheqg9vXNM=;
        b=NsJnY0DQhGEjzx0Ecauop6kcdm3Ha4zgQduaZYWpjA6Lq2ePYMawgKF2Eh30sSshgh
         r3hkoou7RO+me85EwOqG9CHsTC92qn8Rz6FV4iiaEYeV1E4Ll42UjWmaqiP7lK27TTGA
         52gRp4mEMmr+YXnCXDGZkHBkXrtGMfPHRcBDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758829384; x=1759434184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7MMUWfpwmVWVY6VmS+MHYWz1tm5Ol/92uheqg9vXNM=;
        b=QLXAMhfwqZRns/zZUULer40PiDgYKIB88CAcP9iixLlItBke57BZuELptMlS8qxX9j
         +ZWasXbjdMJ8PQl1Bp8ii8AQgKIhsJP3PlQ1Te+F1R2QpOci37AbUDLTrmugBaxC1Cto
         eONrCEoRyJW2QgtLPcDv42IEah3OBOLcn6B2eF+Ps2cNB109SKnso3GVfEk7HInWCISu
         ahFHQx5J5J5rkORfhWyGP41PF99Hefl7EWYQ3OHkAEMsZPIJK6CPEbj51iZnA0m2EfB0
         KXGSTT8iNYUPCvjt6i8g+j1bQI1P2sGYDhKxGEbtD7lO2LQQeKy9dwIG75Aded8CPpS8
         Dxsw==
X-Forwarded-Encrypted: i=1; AJvYcCV4JcteUgLFj8tP6rB9XJxJaEnRpnMl3QVZRDJ/X2fN1pHlhBj4/+nXYwv3GXH0UMMPxJTu7x1bj34XuKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ifFPMtx9PMHFpb20p8Vp38XcS2C79O/+Kgg/BfOTXp2/oRyN
	b0u5vvF+7eVKOjDXptZ2bkNtopSJdXTujDy45MB6t+4RJPlD+AGwPFvAqPWHBbEcEA==
X-Gm-Gg: ASbGncvKfQZDmS9Jw8+agh5KAy8p4f2VD/hUTU1Pnb07DvynCPTI4H8E14Ikg3cuzB+
	WUKa+w0N7yCXnfDL65zba/wHznYssAOia9g/GY7GF7QED9QI9WWzm4UwRmKHfzgsVSTFqvrfB5m
	s4lDmwUQvb3+L/BdMwErZohjq0eKbdg+K1MGkIr0SXkT5MyD4i4dPrnPWL3yE7RU6sToY5V6inU
	+A1bh2u5X39AMACjbtbJTI1j/6eVk/jChbr7SHUwfFIujFbSqwOvbgYbmoIEZ/UY6Jt40WrImzm
	4SmE76Z8anwGHmES9ECCeJH9iVRXQ7DTc6QA7KbSGfNTgq/ATHOckMNvWf2xv5qkjVW5f9x5wCU
	ELOkvnjXCmj9WifvznLAShR+JcTC4RqKXBcVr+Vw4i89QTUjaMfdb1cVYUQ++
X-Google-Smtp-Source: AGHT+IHnkBZ9JmGUyM8gf2p4sZEIPwm5JSjjSFaLxm2T8Z3fLSOBYOHkNo6la9usss7KQlzkZV0D7Q==
X-Received: by 2002:a05:6a20:e212:b0:2dd:5588:49eb with SMTP id adf61e73a8af0-2e7c79c5b13mr5645775637.19.1758829384529;
        Thu, 25 Sep 2025 12:43:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:ef44:9df6:231a:cd29])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-781023e5f41sm2606013b3a.42.2025.09.25.12.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 12:43:04 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	kunit-dev@googlegroups.com,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v2 2/3] PM: runtime: Make put{,_sync}() return 1 when already suspended
Date: Thu, 25 Sep 2025 12:42:15 -0700
Message-ID: <20250925124216.v2.2.I2cdc7d58d89da55bfd53d78f81c7e08e4b10eb80@changeid>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
References: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pm_runtime.h docs say pm_runtime_put() and pm_runtime_put_sync()
return 1 when already suspended, but this is not true -- they return
-EAGAIN. On the other hand, pm_runtime_put_sync_suspend() and
pm_runtime_put_sync_autosuspend() *do* return 1.

This is an artifact of the fact that the former are built on rpm_idle(),
whereas the latter are built on rpm_suspend().

There are precious few pm_runtime_put()/pm_runtime_put_sync() callers
that check the return code at all, but most of them only log errors, and
usually only for negative error codes. None of them should be treating
this as an error, so:

 * at best, this may fix some case where a driver treats this condition
   as an error, when it shouldn't;

 * at worst, this should make no effect; and

 * somewhere in between, we could potentially clear up non-fatal log
   messages.

Fix the pm_runtime_already_suspended_test() while tweaking the behavior.
The test makes a lot more sense when these all return 1 when the device
is already suspended:

    pm_runtime_put_sync(dev);
    pm_runtime_suspend(dev);
    pm_runtime_autosuspend(dev);
    pm_request_autosuspend(dev);
    pm_runtime_put_sync_autosuspend(dev);

Notably, I've avoided testing the return codes for these, since they
really should be ignored by callers, and we may make them 'void'
altogether:

    pm_runtime_put(dev);
    pm_runtime_put_autosuspend(dev);

Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---

Changes in v2:
 * Drop superfluous parentheses
 * Add Dhruva's Reviewed-by

 drivers/base/power/runtime-test.c | 2 +-
 drivers/base/power/runtime.c      | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 2e966fd96664..eca9885e807d 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -42,7 +42,7 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 	pm_runtime_put(dev);
 
 	pm_runtime_get_noresume(dev);
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
 
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3e84dc4122de..faa68bf9ef3d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -498,6 +498,9 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	if (retval < 0)
 		;	/* Conditions are wrong. */
 
+	else if ((rpmflags & RPM_GET_PUT) && retval == 1)
+		;	/* put() is allowed in RPM_SUSPENDED */
+
 	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
 	else if (dev->power.runtime_status != RPM_ACTIVE)
 		retval = -EAGAIN;
-- 
2.51.0.536.g15c5d4f767-goog


