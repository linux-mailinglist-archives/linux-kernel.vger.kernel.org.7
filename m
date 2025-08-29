Return-Path: <linux-kernel+bounces-790915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2EB3AF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6A718945AA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19ED1A08CA;
	Fri, 29 Aug 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9jgA06f"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECEA189F20
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427627; cv=none; b=JX59K6jMzvRYpBYaY/hHHl1dBCmDqiKnf2hBftiyivzzUYG2jqj822t2UvlBGfsR1Ue5LLGBTZ4m880z6BR+NQqPU1YLMJDITd88+YT732SqxI6pwROf3BDTVbEKGyMugdsuxSSUMhlInRruc3Y8/vPqprRz7zOoU7VEzNrIAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427627; c=relaxed/simple;
	bh=Q56VG0oXv7fc6qv0ZFPm5cKl52Q7ty3jvIzKtCq+/TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNNLOSwLpUh4oXf68lxoq2Q6yPT6W4l6jRm10O/n94LtL0DExA9eov43ggzb2uR7jCdvo5UgPeDAVc5HGYpLKP9XCyNDRyNqfcBNaRDUQbq5yNwEY4sjFzyDG2P4pMFDHc55UyZ1TpOcxCx1PRHEzXF+SxkhsChYFLWzJsDTHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D9jgA06f; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-770530175b2so1264044b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756427625; x=1757032425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6XaNX8Mq1vSJ5IzdJQsqjDN1yWPQ2JHHVDMfjlEZJI=;
        b=D9jgA06fdi1B7eieK1oZDcMUkWM0G5DIRqqCCNvahQaHv2fvOKUlF3i2GnQdApP6sT
         wVBaCI5FHohhRo1ZpMVCN7SYOl1EGPNG0BxOIsCOSQ3fuvDrjZk1G7JS5ZghEmrOqrld
         BjSqLfPA27o3pOHUhEXO7b60b+zYTEjeTQY5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427625; x=1757032425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6XaNX8Mq1vSJ5IzdJQsqjDN1yWPQ2JHHVDMfjlEZJI=;
        b=icQxy7a9gP6cxljxxXeJnu10apN0WV5lWBbRN9Nm3zqlV1UebKdcNNL1ak55SwkuXz
         IH17w5iBkRzZKQ195SWdD+Fh0lQxL6H7c0KQFnu7Pc1TP16wlFcUpDq3nQ0eiLkt2aaz
         Jw0zE4LD0JKxJyKEQfOAgOAGQf+8s/sQ7UkdSMpRTpHmumua+CcT1xHHLvj2aJz6vbVe
         OjoQHwRKWZgq7/z93UJ6nMFWgHf+yW2wOQj4TP0oZOFIMsA0kcVPPwT6ZfTOEYe23x/2
         eIonOacaxybBsF71hWLaQEpICD6NgfAQIW0vPZwJDqV5chSD/VWtTqS53d6a670Zpsbn
         5qwA==
X-Forwarded-Encrypted: i=1; AJvYcCUevBBcM9fKdYGM1MFEtDR5/zbLz69hyaSsBtQAZCyr+khoF+v0jWJPrXPxFiUDDpHcX69g2GkfpmBIswU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23tMCQYMW5F8xuepACuDhxHFguJS7IdmaLDn2RsQf1m6Xuu0K
	/IUcELAmQbLRqdbvN6T2Ngt14djiVc4k/IUWDFlVJv9Nz5b3kHELWryqyi/qjMj/zw==
X-Gm-Gg: ASbGncut1fSyF+6plr/Sbf5AdaCILODp7JCForzvuUlDkNzldsczgNehkGiWJOuu380
	lA/wVC5ihLQpKlGWMLcnfEZMF744PAWkFiUFT0ZtK1ZZhGkSKHzzguAdtCkezlVFfIGs7CpdSF5
	7CQ3qrEJYnLchqL0hy2chv7s0mwXgZ9ylsm/E37wLShNN3JkDltOuG1hRiSysuq7dHmqUWwWpZs
	wEX7yp48WBzEOz9VxR3mPKsLkQVqKEa+a4mwbHXdwaY5uY5k1mXNE7IpADyzqwv6n47iFrBftHI
	vlqFnUaZe8x1jTF7+Sh7BDeq91t95n1EhnHU+J1js8HUyktN/5ncIKNxuDq9uqAQuymn0hkgKtP
	VMbqN7OOfX4nX3xE2rf54Diu6WazGV3EdY1RpK1umk1rP4ijhshBLBM34JMkW1DhF7aPJLK0=
X-Google-Smtp-Source: AGHT+IG5QB6/LyVNvh+/P2eNw80P808BpcaNCzzRcETaF4BYYBlIiW2JcWPH6sU5e+JuKFxHv0k4hA==
X-Received: by 2002:a05:6a00:1786:b0:770:5931:e05d with SMTP id d2e1a72fcca58-7705931e21cmr21439515b3a.31.1756427624841;
        Thu, 28 Aug 2025 17:33:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2893:df0f:26ec:df00])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a4e24e3sm621877b3a.78.2025.08.28.17.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:33:44 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com,
	Len Brown <lenb@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] PM: runtime: Make put{,_sync}() return 1 when already suspended
Date: Thu, 28 Aug 2025 17:28:27 -0700
Message-ID: <20250829003319.2785282-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
In-Reply-To: <20250829003319.2785282-1-briannorris@chromium.org>
References: <20250829003319.2785282-1-briannorris@chromium.org>
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

    pm_runtime_put(dev);
    pm_runtime_put_sync(dev);
    pm_runtime_suspend(dev);
    pm_runtime_autosuspend(dev);
    pm_request_autosuspend(dev);
    pm_runtime_put_sync_autosuspend(dev);
    pm_runtime_put_autosuspend(dev);

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 8 ++------
 drivers/base/power/runtime.c      | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 263c28d5fc50..1be18e871f1d 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -43,15 +43,11 @@ static void pm_runtime_already_suspended_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, pm_runtime_barrier(dev)); /* no wakeup needed */
 
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
-	/*
-	 * We never actually left RPM_SUSPENDED, but rpm_idle() still treats
-	 * this as -EAGAIN / "runtime PM status change ongoing".
-	 */
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put(dev));
 
 	pm_runtime_get_noresume(dev);
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
-	KUNIT_EXPECT_EQ(test, -EAGAIN, pm_runtime_put_sync(dev));
+	KUNIT_EXPECT_EQ(test, 1, pm_runtime_put_sync(dev));
 
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_suspend(dev));
 	KUNIT_EXPECT_EQ(test, 1, pm_runtime_autosuspend(dev));
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 3e84dc4122de..17cf111d16aa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -498,6 +498,9 @@ static int rpm_idle(struct device *dev, int rpmflags)
 	if (retval < 0)
 		;	/* Conditions are wrong. */
 
+	else if ((rpmflags & RPM_GET_PUT) && (retval == 1))
+		;	/* put() is allowed in RPM_SUSPENDED */
+
 	/* Idle notifications are allowed only in the RPM_ACTIVE state. */
 	else if (dev->power.runtime_status != RPM_ACTIVE)
 		retval = -EAGAIN;
-- 
2.51.0.318.gd7df087d1a-goog


