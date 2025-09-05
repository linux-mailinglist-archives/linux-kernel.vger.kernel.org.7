Return-Path: <linux-kernel+bounces-802453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DCB45283
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8FC3A11BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5E3093C0;
	Fri,  5 Sep 2025 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JusYlXTc"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119128505E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063118; cv=none; b=OEe/0C8icoRbBnQ+W2Gaf//OJdBtLCU7Xn+nM5T06s+bK1hAkI0sAsp1x9ew96Gmra/vI5QYOA3p6Ya954X2fYJsPEeEkXadWznydkHR+kHH1fPMM1NX8nVhqdoOGt7EY7l6UHCwjFuzTU1JU0vDtPJdkubPeASwMlDzJM+xdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063118; c=relaxed/simple;
	bh=KQKQVJ7lJzRB3wBu/0Dgv/3ZrfXT/Pn1PrSSG8Lq3Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKwJ7Lkecis2S3cXIabkQgkI0/TdEDrGDZM8e4J6nI2bACzY/U8tBRD7x5eRQeV0jaZpJayFCeM5L1g2onR7GSKSXPpA+H7TMHcUcsZnJ6o3QJ4R/CqFoCgoB1w4OA8V1645cM+zwT5gP6AfIfcCUsfg0V7CeAbfDJucqwqEti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JusYlXTc; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so11909415e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063114; x=1757667914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+xd/zkrq9qnCtuPpoVr2SZdLtt3PbE8CPFIIoENU5A=;
        b=JusYlXTcMeQA4qGayJ3Sj+yL2aUtegL5KG+GsjeVm+vh9r6fllgqpAcreyIlzShsEn
         cRQi+heiXZqe5N3GuGGsye5aclpx3xzlnAxlKMHuGmH3tiO5wVHFz+3+r5K5D8rsOotS
         t+Yv5k4Sq/Z538OcKQMYUPeUGrRxHa9LGazKDdXyyahemJryjCBQdSU0n37h8jR0Y1TX
         3Q/888xGIBTZrvYe6MPaV11MNl88uDfE8hHvOmijR7LV69DdFX1/6XtRhP0+FZHAsDA7
         zubwj95EesbIyTsEg0w7pdL/qkYLsHSyZXBbDBszgtZJkgXB3sPOYlreGEQip1CMEewh
         NIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063114; x=1757667914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+xd/zkrq9qnCtuPpoVr2SZdLtt3PbE8CPFIIoENU5A=;
        b=bvbmPXwKQruehqDtggCgumfqOHlf8tX61BDZURQxV/Ap04cmrssiqQ4egHERWp+BaH
         VQGqd1KDpA5Wtbscyb0nxiuRjUcPt+XCwstLYXnMqb6Xvs0Tfi7Bz1NbHgl1E3/YeSMe
         ndwLNmO7VvFrSCGnEIYYXfgXPigK4i4W2WV/Nep6rJLoAULSREVSEJ3/mLynu11d6kle
         oFIBaTiSzFn4ikADUTC4iu7ThnljyuxdN0H0ayS6VmZhIiHX+ckKlio147CsIoL8zmbU
         ZZpxARCxv3Z+HiQMDIOlB5gYiHhibDr1WiDGz8EZlEE9MpKDe/4CtQ41L9akyPeJVbt5
         DN6g==
X-Gm-Message-State: AOJu0YzUVkCiQJ+HrqkIWqPU9Ncb+nIIF4JBCopW12FdDNQTzche7pWp
	Rdz49X+DtY5UzDVhv+DZZU+qvcL4+2tXIW5gVs5w9aYsnXIei6aV1q+7CNpqFLrYsxUWiWOiDst
	wMHnV
X-Gm-Gg: ASbGnct0n7riUse3+xBG+UdNr//OcjV3kYhjbH11v4VvVKhkytXElVQxCNT63AbxHNa
	eXY+ydg13wFLXViyKJTaBYuvLn2XBJTy9UUcwxKIVXfpp9/fmzYddD7C6YUIJVP3H1TH8Hw0IUz
	JYWyDOCHBWIiFIH2PNMtDMc5odX0vk8it+BPhVFusk7OYAuNSQxHlyCSaYt5GX1Fx6OddkOh6XY
	WiJ9QjhFqxpwtp8QZDwuxWK/UZH1pO5Q1ExcDzTcuTflJoDvT4KiCsHfPUpFOQsNFpKB4/mrd4Q
	OpDaiQJASUDYYjX9TnK8QCtd43v+lMnyFDKN995VWW/ggZhFcHzVgOIu+CAmzViKZlJaBC5glrN
	DqR37UzKCFBXQULAXzNtUP7hbjh1J8LMXmblgwuVhrERB9p0oDqJbkQ9sIQ==
X-Google-Smtp-Source: AGHT+IGliwPQzMpMR1QlkorP2dKk5+DSC/EvCZeJQnsDT+TYenQJ/XIyO1x6P/liehaCAtNovimi5w==
X-Received: by 2002:a05:600c:c1c8:10b0:45b:8600:2bcb with SMTP id 5b1f17b1804b1-45b86002ceemr135661645e9.7.1757063113655;
        Fri, 05 Sep 2025 02:05:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd07480d5sm34118215e9.8.2025.09.05.02.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:05:13 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 1/3] net: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:05:03 +0200
Message-ID: <20250905090505.104882-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090505.104882-1-marco.crivellari@suse.com>
References: <20250905090505.104882-1-marco.crivellari@suse.com>
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
 drivers/net/macvlan.c                          | 2 +-
 drivers/net/netdevsim/dev.c                    | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 2 +-
 net/core/link_watch.c                          | 4 ++--
 net/unix/garbage.c                             | 2 +-
 net/wireless/core.c                            | 4 ++--
 net/wireless/sysfs.c                           | 2 +-
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index d0dfa6bca6cc..8572748b79f6 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -369,7 +369,7 @@ static void macvlan_broadcast_enqueue(struct macvlan_port *port,
 	}
 	spin_unlock(&port->bc_queue.lock);
 
-	queue_work(system_unbound_wq, &port->bc_work);
+	queue_work(system_dfl_wq, &port->bc_work);
 
 	if (err)
 		goto free_nskb;
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 3e0b61202f0c..0b7c945a0e96 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -836,7 +836,7 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 	nsim_dev = nsim_trap_data->nsim_dev;
 
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
@@ -852,7 +852,7 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 		cond_resched();
 	}
 	devl_unlock(priv_to_devlink(nsim_dev));
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &nsim_dev->trap_data->trap_report_dw,
 			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 }
@@ -909,7 +909,7 @@ static int nsim_dev_traps_init(struct devlink *devlink)
 
 	INIT_DELAYED_WORK(&nsim_dev->trap_data->trap_report_dw,
 			  nsim_dev_trap_report_work);
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &nsim_dev->trap_data->trap_report_dw,
 			   msecs_to_jiffies(NSIM_TRAP_REPORT_INTERVAL_MS));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 03f639fbf9b6..2467b5d56014 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2950,7 +2950,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	IWL_WARN(fwrt, "Collecting data: trigger %d fired.\n",
 		 le32_to_cpu(desc->trig_desc.type));
 
-	queue_delayed_work(system_unbound_wq, &wk_data->wk,
+	queue_delayed_work(system_dfl_wq, &wk_data->wk,
 			   usecs_to_jiffies(delay));
 
 	return 0;
@@ -3254,7 +3254,7 @@ int iwl_fw_dbg_ini_collect(struct iwl_fw_runtime *fwrt,
 	if (sync)
 		iwl_fw_dbg_collect_sync(fwrt, idx);
 	else
-		queue_delayed_work(system_unbound_wq,
+		queue_delayed_work(system_dfl_wq,
 				   &fwrt->dump.wks[idx].wk,
 				   usecs_to_jiffies(delay));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 25fb4c50e38b..29ff021b5779 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1163,7 +1163,7 @@ static inline void iwl_trans_schedule_reset(struct iwl_trans *trans,
 	 */
 	trans->restart.during_reset = test_bit(STATUS_IN_SW_RESET,
 					       &trans->status);
-	queue_work(system_unbound_wq, &trans->restart.wk);
+	queue_work(system_dfl_wq, &trans->restart.wk);
 }
 
 static inline void iwl_trans_fw_error(struct iwl_trans *trans,
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index cb04ef2b9807..7c17cba6437d 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -157,9 +157,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_dfl_wq, &linkwatch_work, 0);
 	else
-		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
+		queue_delayed_work(system_dfl_wq, &linkwatch_work, delay);
 }
 
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 01e2b9452c75..684ab03137b6 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -592,7 +592,7 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 void unix_gc(void)
 {
 	WRITE_ONCE(gc_in_progress, true);
-	queue_work(system_unbound_wq, &unix_gc_work);
+	queue_work(system_dfl_wq, &unix_gc_work);
 }
 
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
diff --git a/net/wireless/core.c b/net/wireless/core.c
index dcce326fdb8c..ffe0f439fda8 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -428,7 +428,7 @@ static void cfg80211_wiphy_work(struct work_struct *work)
 	if (wk) {
 		list_del_init(&wk->entry);
 		if (!list_empty(&rdev->wiphy_work_list))
-			queue_work(system_unbound_wq, work);
+			queue_work(system_dfl_wq, work);
 		spin_unlock_irq(&rdev->wiphy_work_lock);
 
 		trace_wiphy_work_run(&rdev->wiphy, wk);
@@ -1670,7 +1670,7 @@ void wiphy_work_queue(struct wiphy *wiphy, struct wiphy_work *work)
 		list_add_tail(&work->entry, &rdev->wiphy_work_list);
 	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 }
 EXPORT_SYMBOL_GPL(wiphy_work_queue);
 
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 62f26618f674..8d142856e385 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -137,7 +137,7 @@ static int wiphy_resume(struct device *dev)
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
 	rdev->suspended = false;
-	queue_work(system_unbound_wq, &rdev->wiphy_work);
+	queue_work(system_dfl_wq, &rdev->wiphy_work);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.51.0


