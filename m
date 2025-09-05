Return-Path: <linux-kernel+bounces-802466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED10B452AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF883B61B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E2B2FDC4D;
	Fri,  5 Sep 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SaHNrXTa"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E727FD68
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063234; cv=none; b=nHnQF2nxnaVZZ7fSorw/h4DV48eoo+0KDzQjjYsrM5IM7YGqgIq9Q4oWQfvGfZuMRa9+5DvA/SepI9obU6oxKD+ZFYRmAtkR+ZicVyfrkcRoUSb3QByjDjwO0tvIyIBAdgt/uwOR5bouy8AaBM9hIOBsJ5PGu1uOCWLPuCyVgpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063234; c=relaxed/simple;
	bh=dypwkIDDK2CppEh3SElXi9CvlbTKiIUDaVTS7Gkyl18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahJ9PZjloQXtfg3T8AMtxpQ0uox4R0pu6WHioh+pOGFIAkIhDr/Noz1lPa8+0Mt+muFEnXH07y2PQw4ynoL/JN7VCGaNSNhoOUUpTNuxlmHVjL3mHM+1dSSWQJh7Nz/Z+ZB3teOjLDcqxuV7X2PtItp8liE/VL0jKbZSx5s/vXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SaHNrXTa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cf991e8bb8so1334757f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063230; x=1757668030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxAbvWJC59UYqF45rKaqQZziatIuw5ZItEvXiiII52k=;
        b=SaHNrXTa2hL250y0Ww8UGA5s0OYaPyfPG9vGo8Ww8d/tBYpnl25092/P6l44Zwu4L+
         cp+KDMuNAkCDxfED6tm1+c4GdSY8LNLm6lcn5k1oAwJ73ZAODS64ZSblnspeZDnp62FH
         x6QcHlU/ZecUD5DedSYrItMFbIh2C3NMLSGLM/8OJ/YK7xqqwKB0CSly8vWsEMecgQ+z
         CYTAkrZiy5D6vB7/J+Mp2IUFixqcgL1UW49lc1kWhXCdW3oy9fIOmuWzX/YTW8V8KhGb
         GP9stY+xZFnaakiVKq3BC7ZJQ9K3pB8EhjO/MjbkOXMzPjKSMF4SG28ipmjmAeEJ1AJG
         cafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063230; x=1757668030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxAbvWJC59UYqF45rKaqQZziatIuw5ZItEvXiiII52k=;
        b=iBt24S8cJ2VG8wOz5PTTMGsjTn7Z6d+gKKKuCTPMQl6XZIj3DqZ/q9ylE1CyMSDTFY
         6E/L5R7M13zBWK81P2ruVRE7gpYdB44mYPgHxc8U1uZvjEGj9wPOYZTJWGR65wJMySfF
         +psBj/jI9Nw/fM6gUpiUp93TcaTaBushncfTfBR7dAm5KKMmIZBnbQRCzKBE1PTe/ZEn
         zAvAG2LHRKe3NI+G/Mm/j01lVpCAlc3xjfkz4yS+2mrWBz5cCYt+p+Y+RFUse/cumQvN
         S+CvEkQPoyPW9Fg9dq7PGzXMo433XEKgNGWPQKNP/NLIwFkXOT6KTwvmtbp6nE7buI0G
         116Q==
X-Gm-Message-State: AOJu0Yzde7y5pQdKg+5UysSNGA5ddgLjKfz4bwVm7MxWc+I4bUIG1C86
	n1kEsXmFoPEKryWIe8o63+aB/4r+Dt5tA+OyAPkY+kDs432KLohdSDj+3or3BCFhS4unIEH6OKb
	Td4Mh
X-Gm-Gg: ASbGncutNzPrBLk5eY1H03MNGU7q9cyKaeKEZEcpmlGpm3X4bkU7zPuGqTQsMAXVHiQ
	Wz7Kpm7YoBYTkHIPaZu+fDMpZtvBQwUy3ydfeEfeqllfL368CQZBmYjwoyb0SHwfrrLOqW3ywcQ
	xTZMcdqegDtvgE21VsEcm2KwHZ8oxfkO/ZwmuEbpTM1bQEk6/12YESQDC9ZP6FRvjGEimY6hB+3
	Ux53wQqKK8jT8IZgEgz4utn8DHkxWacWhqYVK8ZXIXvRPKTqZQbeqZJgV56N3uHc/bNuWUpMV1S
	Ceo1xM2IVXd9qwraL+BLl6wsM8dtrGh1fVRmTuA1QYQ2FQJw4CZ6TanCazUlTvTrAkQGLYJf7r/
	TKI0XB7ZWScyf7eKNK6ugBz/KMnLWcWLZD4NxKCGWKI/jGIOViDeAcJs1fg==
X-Google-Smtp-Source: AGHT+IHfNYMGrd+KAN2rfzAtHCICclBHcGlu0L/H5dSYahLdT4Veg3VdsixFBGsLDuhNWmwzhjpFgQ==
X-Received: by 2002:a05:6000:24c4:b0:3d6:3af4:7cd9 with SMTP id ffacd0b85a97d-3d63af4818emr17510764f8f.12.1757063230376;
        Fri, 05 Sep 2025 02:07:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcf3de7sm35952735e9.4.2025.09.05.02.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:07:09 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 1/2] power: supply: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:06:40 +0200
Message-ID: <20250905090641.106297-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090641.106297-1-marco.crivellari@suse.com>
References: <20250905090641.106297-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/power/supply/bq2415x_charger.c | 2 +-
 drivers/power/supply/bq24190_charger.c | 2 +-
 drivers/power/supply/bq27xxx_battery.c | 6 +++---
 drivers/power/supply/rk817_charger.c   | 6 +++---
 drivers/power/supply/ucs1002_power.c   | 2 +-
 drivers/power/supply/ug3105_battery.c  | 6 +++---
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 9e3b9181ee76..03837c831643 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -842,7 +842,7 @@ static int bq2415x_notifier_call(struct notifier_block *nb,
 	if (bq->automode < 1)
 		return NOTIFY_OK;
 
-	mod_delayed_work(system_wq, &bq->work, 0);
+	mod_delayed_work(system_percpu_wq, &bq->work, 0);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f0d97ab45bd8..a19fca6d0a29 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1474,7 +1474,7 @@ static void bq24190_charger_external_power_changed(struct power_supply *psy)
 	 * too low default 500mA iinlim. Delay setting the input-current-limit
 	 * for 300ms to avoid this.
 	 */
-	queue_delayed_work(system_wq, &bdi->input_current_limit_work,
+	queue_delayed_work(system_percpu_wq, &bdi->input_current_limit_work,
 			   msecs_to_jiffies(300));
 }
 
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 2f31d750a4c1..d670ccf9661b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1127,7 +1127,7 @@ static int poll_interval_param_set(const char *val, const struct kernel_param *k
 
 	mutex_lock(&bq27xxx_list_lock);
 	list_for_each_entry(di, &bq27xxx_battery_devices, list)
-		mod_delayed_work(system_wq, &di->work, 0);
+		mod_delayed_work(system_percpu_wq, &di->work, 0);
 	mutex_unlock(&bq27xxx_list_lock);
 
 	return ret;
@@ -1945,7 +1945,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	di->last_update = jiffies;
 
 	if (!di->removed && poll_interval > 0)
-		mod_delayed_work(system_wq, &di->work, poll_interval * HZ);
+		mod_delayed_work(system_percpu_wq, &di->work, poll_interval * HZ);
 }
 
 void bq27xxx_battery_update(struct bq27xxx_device_info *di)
@@ -2221,7 +2221,7 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
 	/* After charger plug in/out wait 0.5s for things to stabilize */
-	mod_delayed_work(system_wq, &di->work, HZ / 2);
+	mod_delayed_work(system_percpu_wq, &di->work, HZ / 2);
 }
 
 static void bq27xxx_battery_mutex_destroy(void *data)
diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 945c7720c4ae..032b191ddbf5 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1046,7 +1046,7 @@ static void rk817_charging_monitor(struct work_struct *work)
 	rk817_read_props(charger);
 
 	/* Run every 8 seconds like the BSP driver did. */
-	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
+	queue_delayed_work(system_percpu_wq, &charger->work, msecs_to_jiffies(8000));
 }
 
 static void rk817_cleanup_node(void *data)
@@ -1206,7 +1206,7 @@ static int rk817_charger_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Force the first update immediately. */
-	mod_delayed_work(system_wq, &charger->work, 0);
+	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
 	return 0;
 }
@@ -1226,7 +1226,7 @@ static int __maybe_unused rk817_resume(struct device *dev)
 	struct rk817_charger *charger = dev_get_drvdata(dev);
 
 	/* force an immediate update */
-	mod_delayed_work(system_wq, &charger->work, 0);
+	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
 	return 0;
 }
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index d32a7633f9e7..fe94435340de 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -493,7 +493,7 @@ static irqreturn_t ucs1002_alert_irq(int irq, void *data)
 {
 	struct ucs1002_info *info = data;
 
-	mod_delayed_work(system_wq, &info->health_poll, 0);
+	mod_delayed_work(system_percpu_wq, &info->health_poll, 0);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 38e23bdd4603..15b62952f953 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -276,7 +276,7 @@ static void ug3105_work(struct work_struct *work)
 out:
 	mutex_unlock(&chip->lock);
 
-	queue_delayed_work(system_wq, &chip->work,
+	queue_delayed_work(system_percpu_wq, &chip->work,
 			   (chip->poll_count <= UG3105_INIT_POLL_COUNT) ?
 					UG3105_INIT_POLL_TIME : UG3105_POLL_TIME);
 
@@ -352,7 +352,7 @@ static void ug3105_external_power_changed(struct power_supply *psy)
 	struct ug3105_chip *chip = power_supply_get_drvdata(psy);
 
 	dev_dbg(&chip->client->dev, "external power changed\n");
-	mod_delayed_work(system_wq, &chip->work, UG3105_SETTLE_TIME);
+	mod_delayed_work(system_percpu_wq, &chip->work, UG3105_SETTLE_TIME);
 }
 
 static const struct power_supply_desc ug3105_psy_desc = {
@@ -373,7 +373,7 @@ static void ug3105_init(struct ug3105_chip *chip)
 				  UG3105_MODE_RUN);
 	i2c_smbus_write_byte_data(chip->client, UG3105_REG_CTRL1,
 				  UG3105_CTRL1_RESET_COULOMB_CNT);
-	queue_delayed_work(system_wq, &chip->work, 0);
+	queue_delayed_work(system_percpu_wq, &chip->work, 0);
 	flush_delayed_work(&chip->work);
 }
 
-- 
2.51.0


