Return-Path: <linux-kernel+bounces-626307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432CAAA4165
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 05:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FE47AEA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 03:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A981DB95E;
	Wed, 30 Apr 2025 03:27:47 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id D7C5A156677;
	Wed, 30 Apr 2025 03:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745983667; cv=none; b=OyBkhkPNsrbclvRC2PiPWV91K16SxCq9hWG5abS3xABUCOad3Dc+CM37ih9nI7TG1kT1s5k2tCCHAfl38rV1kz8n+7jM+EGkU0kJMi853Gi8Tqzpqv50a5gD/RcYMMO1S4ZabBPjMy8+orhW1Rp9Ka3mtjNfCc2OFZxht8l5tr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745983667; c=relaxed/simple;
	bh=RyqIkeyhzJuKKSXmPNNcxDLdS+h53puoWX0VpYlQiSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=gSSK1/8qWCd5DL+CjH/yvw4Uh6nffibp6mHXwftPNNzo3LmrEEyqVIbY2yWjRjHqmQFhCgkhjyvWBuzd1QtWlwQ5Sbr/O7E/Dv6OYO8c0m9CeNB9QKEi07+zdQq4MPAbUehdEpbJt9BWoceGfC52VpmURFSLrEPrm3ASbPQlP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from longsh.shanghai.nfschina.local (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 152716018E584;
	Wed, 30 Apr 2025 11:27:40 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	dan.carpenter@linaro.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3 3/3] alarmtimer: switch some spin_{lock,unlock}_irqsave() to guard()
Date: Wed, 30 Apr 2025 11:27:34 +0800
Message-Id: <20250430032734.2079290-4-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250430032734.2079290-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using guard/scoped_guard() to simplify code. Using guard() to remove
'goto unlock' label is neater especially.

Signed-off-by: Su Hui <suhui@nfschina.com>
Acked-by: John Stultz <jstultz@google.com>
---
v3:
 - No Change.

v2:
 - Remove some guard() usages acrodding to john's suggestions.

 kernel/time/alarmtimer.c | 56 +++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 621d39666e29..9f75aaf1ba35 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -70,12 +70,10 @@ static DEFINE_SPINLOCK(rtcdev_lock);
  */
 struct rtc_device *alarmtimer_get_rtcdev(void)
 {
-	unsigned long flags;
 	struct rtc_device *ret;
 
-	spin_lock_irqsave(&rtcdev_lock, flags);
+	guard(spinlock_irqsave)(&rtcdev_lock);
 	ret = rtcdev;
-	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	return ret;
 }
@@ -83,7 +81,6 @@ EXPORT_SYMBOL_GPL(alarmtimer_get_rtcdev);
 
 static int alarmtimer_rtc_add_device(struct device *dev)
 {
-	unsigned long flags;
 	struct rtc_device *rtc = to_rtc_device(dev);
 	struct platform_device *pdev;
 	int ret = 0;
@@ -101,22 +98,21 @@ static int alarmtimer_rtc_add_device(struct device *dev)
 	if (!IS_ERR(pdev))
 		device_init_wakeup(&pdev->dev, true);
 
-	spin_lock_irqsave(&rtcdev_lock, flags);
-	if (!IS_ERR(pdev) && !rtcdev) {
-		if (!try_module_get(rtc->owner)) {
+	scoped_guard(spinlock_irqsave, &rtcdev_lock) {
+		if (!IS_ERR(pdev) && !rtcdev) {
+			if (!try_module_get(rtc->owner)) {
+				ret = -1;
+				break;
+			}
+
+			rtcdev = rtc;
+			/* hold a reference so it doesn't go away */
+			get_device(dev);
+			pdev = NULL;
+		} else {
 			ret = -1;
-			goto unlock;
 		}
-
-		rtcdev = rtc;
-		/* hold a reference so it doesn't go away */
-		get_device(dev);
-		pdev = NULL;
-	} else {
-		ret = -1;
 	}
-unlock:
-	spin_unlock_irqrestore(&rtcdev_lock, flags);
 
 	platform_device_unregister(pdev);
 
@@ -198,7 +194,7 @@ static enum hrtimer_restart alarmtimer_fired(struct hrtimer *timer)
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
 
-	scoped_guard (spinlock_irqsave, &base->lock)
+	scoped_guard(spinlock_irqsave, &base->lock)
 		alarmtimer_dequeue(base, alarm);
 
 	if (alarm->function)
@@ -251,9 +247,8 @@ static int alarmtimer_suspend(struct device *dev)
 		struct timerqueue_node *next;
 		ktime_t delta;
 
-		spin_lock_irqsave(&base->lock, flags);
-		next = timerqueue_getnext(&base->timerqueue);
-		spin_unlock_irqrestore(&base->lock, flags);
+		scoped_guard(spinlock_irqsave, &base->lock)
+			next = timerqueue_getnext(&base->timerqueue);
 		if (!next)
 			continue;
 		delta = ktime_sub(next->expires, base->get_ktime());
@@ -381,13 +376,11 @@ EXPORT_SYMBOL_GPL(alarm_start_relative);
 void alarm_restart(struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
 
-	spin_lock_irqsave(&base->lock, flags);
+	guard(spinlock_irqsave)(&base->lock);
 	hrtimer_set_expires(&alarm->timer, alarm->node.expires);
 	hrtimer_restart(&alarm->timer);
 	alarmtimer_enqueue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
 }
 EXPORT_SYMBOL_GPL(alarm_restart);
 
@@ -401,14 +394,13 @@ EXPORT_SYMBOL_GPL(alarm_restart);
 int alarm_try_to_cancel(struct alarm *alarm)
 {
 	struct alarm_base *base = &alarm_bases[alarm->type];
-	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&base->lock, flags);
-	ret = hrtimer_try_to_cancel(&alarm->timer);
-	if (ret >= 0)
-		alarmtimer_dequeue(base, alarm);
-	spin_unlock_irqrestore(&base->lock, flags);
+	scoped_guard(spinlock_irqsave, &base->lock) {
+		ret = hrtimer_try_to_cancel(&alarm->timer);
+		if (ret >= 0)
+			alarmtimer_dequeue(base, alarm);
+	}
 
 	trace_alarmtimer_cancel(alarm, base->get_ktime());
 	return ret;
@@ -479,7 +471,6 @@ EXPORT_SYMBOL_GPL(alarm_forward_now);
 static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 {
 	struct alarm_base *base;
-	unsigned long flags;
 	ktime_t delta;
 
 	switch(type) {
@@ -498,13 +489,12 @@ static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
 
 	delta = ktime_sub(absexp, base->get_ktime());
 
-	spin_lock_irqsave(&freezer_delta_lock, flags);
+	guard(spinlock_irqsave)(&freezer_delta_lock);
 	if (!freezer_delta || (delta < freezer_delta)) {
 		freezer_delta = delta;
 		freezer_expires = absexp;
 		freezer_alarmtype = type;
 	}
-	spin_unlock_irqrestore(&freezer_delta_lock, flags);
 }
 
 /**
-- 
2.30.2


