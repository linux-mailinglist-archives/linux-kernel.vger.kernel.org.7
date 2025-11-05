Return-Path: <linux-kernel+bounces-886833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082F0C369EE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4E36620E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F7331A47;
	Wed,  5 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cu89J4G7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665A32ED58
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358283; cv=none; b=X/I4xhZZ7b8Xjczm/huRD80+pE4Z2pRqhVkwh2RXMcJ4uLHfcIjigYVA2XvhPGiW21/oc94vCu2vK7dNN90aHbg7VOj59C2LCVf1HWxu6ragi5AvZ1PzFbQWqNAeRcfDhI/VTz/gWpdY+bKpDwjkBc1XjhfnGXtbtBggL9E2j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358283; c=relaxed/simple;
	bh=grk85sjF01n32HUEeHZMfrtFgSo/JagXsKYG9XfD330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4hbpMJ6lEV4rvSo0Aero9Z4zw21RWU6P/b8oSbYqph4haAYTQAIM9J10IKiSznzv++XEgznaGwXKmSbQems/hU23oYNag4L9XD76rKVNY+SRc4CdDsJtRZqZ6/TFZNEeH09vgVUNtM7QljyuuOjDm6I3Iw3C0vGcZg0pQuVtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cu89J4G7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso9931115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762358279; x=1762963079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7/JvpBa71JfOtKidEFviFOI29HJTQ4dpKTrEsM/LHQ=;
        b=cu89J4G7KVjSaecOcu/O8omJFtDGcPNsmtv6kEROvubIGH5Z6rHyfcz6XCYlhmGA+P
         OXaULNG82WyxFY+eWNItSwTZOkI4Y111vgH+FpvgiZatU0mtKUo4pkvkP/8oQp4uqKi8
         I65ibeexcCKV57mGGwwXbXZCV8Y4/rgL9JdCxWdMnFj76bHMtKy3n0F+YuDWWNfwWl36
         NP+/zDroJk2jIZiWLHKuXoW8/+WMZjwC5vECr88pjzx10Og+3gH2X01P6253yxggatqJ
         hrtukIAvsIpKIpRZJ0FvP57/3D766mvWhUyiN8QvaHblW47fzwaI9TwbJDjbbFV45DuL
         CFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358279; x=1762963079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7/JvpBa71JfOtKidEFviFOI29HJTQ4dpKTrEsM/LHQ=;
        b=Wx5gnyRMSMprklmLNOiuESF0/N99049xFxvi0nryvBqsTQG8FKPPcheQBYQ/UX+ssr
         5Vqee3jYbYtmbhS2kL2WzH+DY4FGYoE3ZF7c5SA4Tbm1FHx47hj4Jl2g4oNnYj+B+byl
         oKKTbnjS4NbG+bdl+4lHgs3/7aUHWTs8J6F4hS4ElcWODwwsHreyvpho0mcxgftpy3so
         spVHzPwSuNt6C/HMZMqMeptzZYBnOB51O244cFkHUaUqYSgg2GyJnfsgDtckmTStjiC/
         r5DFo3HcO70uzK4Y+jCvyTmLj30C+vpZTzaq0igrjg8hXoI48eMewoySrB5xt6yXMRYK
         Rr9w==
X-Gm-Message-State: AOJu0Ywdm75lNSQkZ4TCpdK4m2CEibbB6Vck505Hyr0pVonzTYnYwz8v
	MyXmV3k1/BTwyF0/Nnk1wT+tCcSx6kQJQgI5nSOrgDz/UJ36zFPCko056CypRTgIiZWKruGbEHD
	Ki8NT
X-Gm-Gg: ASbGncuan9hyptztBRIVksYqwm2IbxfrX3um8SQSORfNN/q8q0JWoVUYZlbdmt+lfh1
	WQB46EpcqLNmUsOV11XgM2LcKmGhulOTw4x34xthzKCOCo53kztjxv3KSu+qVR8azb9QeS1XXEH
	E8nvSgConCu+HxEqssQG5BwDlGLd3ui13LBNA29VEJqub86oy08zqY0gYcoA2RYbkkAVhRIXspu
	nks9cJVY0uVF4eGtocnjbEIeeCizWfacELwL0dybcVbI/mjAVDfTWPTgMQ9zSn6bFFKcmAXbtQf
	kKY5PYL8vjEE7nyX3gjhIMu2cUj2KMD2e9LJ8nrhngW3YqZ+1dVOzYCbw2z2YjOKGM8VyGvqafP
	fsuAprpxLzFGy+Pfu/iLY3UwFAUaLkZCNlVy0d8PSOeXuE6HYfhLT3IN1N9WDDQrD8sbtlCuWC4
	7xZ/2nHtmddbUtII0Ch9PeCZRQOg0dGKBW8w==
X-Google-Smtp-Source: AGHT+IHo7HnClSy+Sn9IiiLMeR93GNnuA4NgdJUp4IkSAPro5gqZR0uQLn2I+AtxyZHtt51f9TXbQg==
X-Received: by 2002:a05:600c:5488:b0:475:dac3:69a2 with SMTP id 5b1f17b1804b1-4775ce164c5mr32789045e9.27.1762358279231;
        Wed, 05 Nov 2025 07:57:59 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm55567045e9.1.2025.11.05.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:57:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] platform: x86: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:57:36 +0100
Message-ID: <20251105155742.293326-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105155742.293326-1-marco.crivellari@suse.com>
References: <20251105155742.293326-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the same behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/platform/x86/gpd-pocket-fan.c                      | 4 ++--
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/gpd-pocket-fan.c
index 7a20f68ae206..c9236738f896 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -112,14 +112,14 @@ static void gpd_pocket_fan_worker(struct work_struct *work)
 	gpd_pocket_fan_set_speed(fan, speed);
 
 	/* When mostly idle (low temp/speed), slow down the poll interval. */
-	queue_delayed_work(system_wq, &fan->work,
+	queue_delayed_work(system_percpu_wq, &fan->work,
 			   msecs_to_jiffies(4000 / (speed + 1)));
 }
 
 static void gpd_pocket_fan_force_update(struct gpd_pocket_fan_data *fan)
 {
 	fan->last_speed = -1;
-	mod_delayed_work(system_wq, &fan->work, 0);
+	mod_delayed_work(system_percpu_wq, &fan->work, 0);
 }
 
 static int gpd_pocket_fan_probe(struct platform_device *pdev)
diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 2f8cd8d9e0ab..ebbedfe5f4e8 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -183,7 +183,7 @@ static void atla10_ec_external_power_changed(struct power_supply *psy)
 	struct atla10_ec_data *data = power_supply_get_drvdata(psy);
 
 	/* After charger plug in/out wait 0.5s for things to stabilize */
-	mod_delayed_work(system_wq, &data->work, HZ / 2);
+	mod_delayed_work(system_percpu_wq, &data->work, HZ / 2);
 }
 
 static const enum power_supply_property atla10_ec_psy_props[] = {
-- 
2.51.1


