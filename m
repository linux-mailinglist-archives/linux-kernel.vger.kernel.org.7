Return-Path: <linux-kernel+bounces-640566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF82FAB0687
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 01:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31C14C7D13
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 23:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B50233736;
	Thu,  8 May 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ao4yOyV3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351E21D3F0
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747217; cv=none; b=ak0dlXTQRgEnWWhiNJWGUuSWDt6Qx9NOGycZ6OOaIGY8jFtYb3VS2G8lvsU4t7dpHbTtrzZE5vJJQETlDNb50EE7UoY4yPyAVOwitw/gG5UAjMXvzjfARnmFQ71HZojMgkvJzIJcYWEfL2gdqf/NDm0sq8SWw8hQ6umUbkfEaco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747217; c=relaxed/simple;
	bh=oSI4AdvwmcSLbAbbuCxcWerS/mPOdTcxQRziDu39kWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfSszawrAePWuChbcRxM1f/OoH3ZZBVWgCM+j8tB0R+sgQXry8an3XsSsiovQTmgc1VX435TkI+1uf2rrftd1JFw2Mu4jCZDwCEnzGJJ8AEC7dPq+0RYQQPllAjNYb0pZawwExvYKlp8EKpqea4Y0E6hu8qjnSnUvDwiaExfULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ao4yOyV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB11C4CEEF;
	Thu,  8 May 2025 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747216;
	bh=oSI4AdvwmcSLbAbbuCxcWerS/mPOdTcxQRziDu39kWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ao4yOyV309QJqgvD0J6pZSDfn7PX/Sk94PVY6wDwhdmjl1VIBygrgblIKi6BsKnXK
	 ORKXHZI1zKuT6K9yU2wfX6rFUtHc/8H5HVc2l6nEnWr5YA15Jpj7S1QC1HytNCGnSs
	 8BM2MlCkJxh7P4LdBjpkkHdgSsXaxoj/Deo5okICE9KP8T/BnXjLYPgO36bBfFr6h0
	 nXaryJJM5lLpvpSr2Oc1Aj3SW7tA7PGm/nzT5Z9PcZoxjsOYpTcMIeakgwE0xE1A52
	 vOm3hzR3Izo78oZ/TwKWx8bx4GQvADvP0zpR05RFAWYMPZtAz0dCLtQfHEAXmYUT6B
	 hLL7OVlKMJXhg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 65C08CE11F1; Thu,  8 May 2025 16:33:36 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 04/21] drm/amd/pm: Avoid open-coded use of ratelimit_state structure's internals
Date: Thu,  8 May 2025 16:33:18 -0700
Message-Id: <20250508233335.1996059-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1bcf7d5e-b89c-4118-b872-c8896bdbdc19@paulmck-laptop>
References: <1bcf7d5e-b89c-4118-b872-c8896bdbdc19@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The amdgpu_set_thermal_throttling_logging() function directly accesses
the ratelimit_state structure's ->missed field, which works, but which
also makes it more difficult to change this field.  Therefore, make use
of the ratelimit_state_reset_interval() function instead of directly
accessing the ->missed field.

Nevertheless, open-coded use of ->burst and ->interval is still permitted,
for example, for runtime sysfs adjustment of these fields.

Link: https://lore.kernel.org/all/fbe93a52-365e-47fe-93a4-44a44547d601@paulmck-laptop/
Link: https://lore.kernel.org/all/20250423115409.3425-1-spasswolf@web.de/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503180826.EiekA1MB-lkp@intel.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: <amd-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 922def51685b0..d533c79f7e215 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1606,7 +1606,6 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	long throttling_logging_interval;
-	unsigned long flags;
 	int ret = 0;
 
 	ret = kstrtol(buf, 0, &throttling_logging_interval);
@@ -1617,18 +1616,12 @@ static ssize_t amdgpu_set_thermal_throttling_logging(struct device *dev,
 		return -EINVAL;
 
 	if (throttling_logging_interval > 0) {
-		raw_spin_lock_irqsave(&adev->throttling_logging_rs.lock, flags);
 		/*
 		 * Reset the ratelimit timer internals.
 		 * This can effectively restart the timer.
 		 */
-		adev->throttling_logging_rs.interval =
-			(throttling_logging_interval - 1) * HZ;
-		adev->throttling_logging_rs.begin = 0;
-		adev->throttling_logging_rs.printed = 0;
-		adev->throttling_logging_rs.missed = 0;
-		raw_spin_unlock_irqrestore(&adev->throttling_logging_rs.lock, flags);
-
+		ratelimit_state_reset_interval(&adev->throttling_logging_rs,
+					       (throttling_logging_interval - 1) * HZ);
 		atomic_set(&adev->throttling_logging_enabled, 1);
 	} else {
 		atomic_set(&adev->throttling_logging_enabled, 0);
-- 
2.40.1


