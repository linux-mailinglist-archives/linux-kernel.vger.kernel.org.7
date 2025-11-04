Return-Path: <linux-kernel+bounces-885182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E4C32390
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D833AB887
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC85C33B6C9;
	Tue,  4 Nov 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="Or4EZNTd"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12272334C00
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275766; cv=none; b=ch5PVUmj3YkkJeWuHkiwXYM8KCHsE2JsHaIqoqWWO28jLrKvIbnKRyF76LqB96BeslI+GziMGDqZnB5H0rQ3zCUA8meqY985rmL83EmZKOJKhNy08K+qN16GrWxDjULH2m9BlRzVUUG3QRKFPlcimDs0knhXTLdMNw+ZxX9AYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275766; c=relaxed/simple;
	bh=EWO5+Jo98nLUKzqMNaEDKH9OgdjG0IrjZ+odi0gpRnk=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=QosGGMSPKhUJDzlTCe57lb6ZkRKebL0p8PBSKh8arX/W+UeKA8kliiLD2cWz2pcgqJDFwc29hgZblxGzO+MteqK+VywdZy1HlbwE0UrquhlrzoecXdsM7NfTRc8mw3/K/06fbK1/tJVvIZxmN9hgiyD6Q4NqHoSH0uu0Br4kzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=Or4EZNTd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7869819394aso9699257b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1762275763; x=1762880563; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P1UexZIIp+qR5KNU45yjHwV4Htk3+9pyERy+GG7OFns=;
        b=Or4EZNTdcS9OLxZePetbgm7HtovkV4n5usP+bfkQXSrdFdksOe2GNWo+o88zuGH0Qm
         KVPEXzVL9RUU8+4wVqeEuHHKMHWdeiWKSsauxfqsHuB0rYxJHpQ2oiO74O0ZYbaPCIyv
         TQRxEu1C3/0pV6ZN+OdNCWgrT7WHHnDdpqACJvwT+bwK4w/8PvQv+YfsD0XXS4ePbhjw
         GNt2UMusTR1yg85AIW3KoHb+qgV7i7baa/1pH6bS1XWUDrRqcCH7zZgJ73j9h//zLr78
         LOOlKzAfVRLHUjrAiECPNBw6acaAv+0G8D6W9bSanhPep7K2jUIxU4HsrOs7RRzEAeCt
         Swkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275763; x=1762880563;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P1UexZIIp+qR5KNU45yjHwV4Htk3+9pyERy+GG7OFns=;
        b=UI44JNsBT8nxidgwhR7e6m6FfOSxkFaBcPb9pUcWFnyketiS2w5oJNbsIulsPV0I8G
         BLAC3XLUYwQ5Hv6+JvKsEtwMxJLGub2gpSrTuZ7S7zy2hHOEpVi1wj22O9Mne0/3Mff2
         yPJSjCIH67DD/gJimNfb/zmdufzfYHwIHJ7c21nwv91/wRjAd1xNmv8bYCAa53CfViYF
         MEW/582aH8/ON1RNS4Hf/1Wiu7bbzpGER3Gic316onS9bobvzyq9GnHV2rLJ5pqDYXMJ
         UkjX+oORz1fInRYEUsn+zkKFnAxgXTS/Qns70SgFbYsSwGS4eevXgjSfP7JteOP/WHjF
         L0eQ==
X-Gm-Message-State: AOJu0YwJ2Dnd9vLdzIDv524ULo1x3IKjf8/bBQuuR/92WX7iDaQRQkGJ
	16mUm+EgcWPQCWcDWM5ml7vZJKS2Mp9TyAA1v8/a6rXqtPZRdYD9FkWR5dqQJrti5R4Rreg4Kxg
	xXyROd2ebJzEwEEjYmPHu410Dy71c9SwNciIVN66pquOPs/PhqLJ7OQ==
X-Gm-Gg: ASbGncvNUi5JE4/C5lAss55bOG/h8J/BZYoFAY5jKxBcdSOEVQ/Yl8krwxMGbf0nSdM
	wSoQD1ulKmjZ79yI8SnZs3YOOlB8MtOcRO0fHi4Lo4M6xIYH0tgU+xkAzGjKTZGDTQ/DQpmqNdF
	pH3qVdUYA1BkEwAW1UEvHuSKMW303L7HsZOw0bEyq6gW5bybhj4rSJVWq0wQ4m8Aeq+ubNXEnVa
	05iC3ekt9etPFULK3s/nWyZ2/sHePWexC95P965Gt3WtT9CazZNvVKo1qOXWA==
X-Google-Smtp-Source: AGHT+IF9sHg5VXSO50QCBDqS0vPspAIHZHreI6gFNaukDo/oju8p3Ml/vzWsz+xdlaR8tvFGqdrL9bQnu3AXBg7oPwo=
X-Received: by 2002:a05:690e:1517:b0:63f:aa5b:bce9 with SMTP id
 956f58d0204a3-63fd358096dmr116353d50.53.1762275762407; Tue, 04 Nov 2025
 09:02:42 -0800 (PST)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:42 -0500
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:42 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 12:02:42 -0500
X-Gm-Features: AWmQ_bkZBKcIz6XI9FtNNFWqf_HvrtkjXQAJJVoJFV43lplTNNpZo_OVc3FNgPY
Message-ID: <CABtds-08TC6brxcSDqz426BZyXVusp96poGS=GrWfSOTFNULMg@mail.gmail.com>
Subject: [PATCH] drivers/mmc: rtsx_usb: add workqueue-based card polling
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 542dd6baa424b262ef663cfbd2abc60dded6f91b Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 16:16:48 +0000
Subject: [PATCH 4/5] drivers/mmc: rtsx_usb: add workqueue-based card polling

Move the SD/MMC host to a delayed work poll that adapts between a
50 ms cadence while a request is active/present and a 1 s cadence once
the controller goes quiet. Track ongoing sequential transfers so we
can stop streaming cleanly, and drop the clock tree into an idle state
when the card is absent or idle to save power.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>
Cc: Avri Altman <avri.altman@sandisk.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 245 +++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index e23ef4111dab..5d8c72459b3f 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -19,6 +19,8 @@
 #include <linux/scatterlist.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>

 #include <linux/rtsx_usb.h>
 #include <linux/unaligned.h>
@@ -26,10 +28,14 @@
 #if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
 		defined(CONFIG_MMC_REALTEK_USB_MODULE))
 #include <linux/leds.h>
-#include <linux/workqueue.h>
 #define RTSX_USB_USE_LEDS_CLASS
 #endif

+#define RTSX_USB_SD_POLL_INTERVAL	msecs_to_jiffies(50)
+#define RTSX_USB_SD_IDLE_POLL_INTERVAL	msecs_to_jiffies(1000)
+#define RTSX_USB_SD_IDLE_WAIT_MAX	10
+#define RTSX_USB_SD_SEQ_WAIT_MAX	2
+
 struct rtsx_usb_sdmmc {
 	struct platform_device	*pdev;
 	struct rtsx_ucr	*ucr;
@@ -37,6 +43,15 @@ struct rtsx_usb_sdmmc {
 	struct mmc_request	*mrq;

 	struct mutex		host_mutex;
+	struct delayed_work	card_poll;
+	unsigned long		poll_interval;
+	unsigned int		idle_counter;
+	unsigned int		idle_wait_max;
+	bool			idle;
+	bool			seq_mode;
+	bool			seq_read;
+	unsigned int		seq_counter;
+	unsigned int		seq_wait_max;

 	u8			ssc_depth;
 	unsigned int		clock;
@@ -72,6 +87,78 @@ static inline void sd_clear_error(struct
rtsx_usb_sdmmc *host)
 	rtsx_usb_clear_fsm_err(ucr);
 }

+static void sdmmc_stop_seq_mode(struct rtsx_usb_sdmmc *host)
+{
+	struct mmc_command stop = { };
+
+	if (!host->seq_mode)
+		return;
+
+	stop.opcode = MMC_STOP_TRANSMISSION;
+	stop.arg = 0;
+	stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+
+	sd_send_cmd_get_rsp(host, &stop);
+	if (stop.error)
+		dev_dbg(sdmmc_dev(host), "stop transmission err %d\n",
+			stop.error);
+
+	rtsx_usb_write_register(host->ucr, MC_FIFO_CTL,
+				      FIFO_FLUSH, FIFO_FLUSH);
+	host->seq_mode = false;
+	host->seq_read = false;
+	host->seq_counter = 0;
+}
+
+static void sdmmc_enter_idle(struct rtsx_usb_sdmmc *host)
+{
+	struct rtsx_ucr *ucr = host->ucr;
+	int err;
+
+	if (host->idle)
+		return;
+
+	err = rtsx_usb_write_register(ucr, CLK_DIV, CLK_CHANGE, CLK_CHANGE);
+	if (err)
+		goto out_dbg;
+
+	err = rtsx_usb_write_register(ucr, FPDCTL,
+				      SSC_POWER_MASK, SSC_POWER_DOWN);
+	if (!err)
+		host->idle = true;
+
+out_dbg:
+	if (err)
+		dev_dbg(sdmmc_dev(host), "enter idle failed %d\n", err);
+	else
+		host->idle_counter = host->idle_wait_max;
+}
+
+static void sdmmc_leave_idle(struct rtsx_usb_sdmmc *host)
+{
+	struct rtsx_ucr *ucr = host->ucr;
+	int err;
+
+	if (!host->idle)
+		return;
+
+	err = rtsx_usb_write_register(ucr, FPDCTL,
+				      SSC_POWER_MASK, SSC_POWER_ON);
+	if (err)
+		goto out_dbg;
+
+	usleep_range(100, 150);
+	err = rtsx_usb_write_register(ucr, CLK_DIV, CLK_CHANGE, 0);
+	if (!err)
+		host->idle = false;
+
+out_dbg:
+	if (err)
+		dev_dbg(sdmmc_dev(host), "leave idle failed %d\n", err);
+	else
+		host->idle_counter = 0;
+}
+
 #ifdef DEBUG
 static void sd_print_debug_regs(struct rtsx_usb_sdmmc *host)
 {
@@ -507,8 +594,11 @@ static int sd_rw_multi(struct rtsx_usb_sdmmc
*host, struct mmc_request *mrq)
 			SD_TRANSFER_END, SD_TRANSFER_END);

 	err = rtsx_usb_send_cmd(ucr, flag, 100);
-	if (err)
+	if (err) {
+		host->seq_mode = false;
+		host->seq_counter = 0;
 		return err;
+	}

 	if (read)
 		pipe = usb_rcvbulkpipe(ucr->pusb_dev, EP_BULK_IN);
@@ -521,10 +611,23 @@ static int sd_rw_multi(struct rtsx_usb_sdmmc
*host, struct mmc_request *mrq)
 		dev_dbg(sdmmc_dev(host), "rtsx_usb_transfer_data error %d\n"
 				, err);
 		sd_clear_error(host);
+		host->seq_mode = false;
+		host->seq_counter = 0;
 		return err;
 	}

-	return rtsx_usb_get_rsp(ucr, 1, 2000);
+	err = rtsx_usb_get_rsp(ucr, 1, 2000);
+	if (!err) {
+		host->seq_mode = true;
+		host->seq_read = read;
+		host->seq_counter = 0;
+	} else {
+		dev_dbg(sdmmc_dev(host), "sd multi rsp err %d\n", err);
+		host->seq_mode = false;
+		host->seq_counter = 0;
+	}
+
+	return err;
 }

 static inline void sd_enable_initial_mode(struct rtsx_usb_sdmmc *host)
@@ -807,6 +910,119 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	return 0;
 }

+static void rtsx_usb_sdmmc_poll_card(struct work_struct *work)
+{
+	struct rtsx_usb_sdmmc *host = container_of(work,
+			struct rtsx_usb_sdmmc, card_poll.work);
+	struct rtsx_ucr *ucr = host->ucr;
+	struct device *dev = sdmmc_dev(host);
+	bool present = READ_ONCE(host->card_exist);
+	bool changed = false;
+	bool prev;
+	int err;
+	u16 status = 0;
+	u8 pend;
+
+	if (host->host_removal)
+		return;
+
+	err = pm_runtime_get_sync(dev);
+	if (err < 0) {
+		pm_runtime_put_noidle(dev);
+		goto requeue;
+	}
+
+	mutex_lock(&ucr->dev_mutex);
+
+	prev = READ_ONCE(host->card_exist);
+
+	err = rtsx_usb_get_card_status(ucr, &status);
+	if (!err) {
+		host->ocp_stat = (status >> 4) & 0x03;
+		present = !!(status & SD_CD);
+		if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+			sdmmc_leave_idle(host);
+			rtsx_usb_write_register(ucr, CARD_OE,
+					SD_OUTPUT_EN, 0);
+		}
+	}
+
+	if (!err) {
+		err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &pend);
+		if (!err && (pend & SD_INT)) {
+			rtsx_usb_write_register(ucr, CARD_INT_PEND,
+				SD_INT, SD_INT);
+			if (prev && present)
+				present = false;
+		}
+	}
+
+	if (!err && !present &&
+	    (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER))) {
+		rtsx_usb_write_register(ucr, OCPCTL,
+				MS_OCP_CLEAR, MS_OCP_CLEAR);
+		host->ocp_stat = 0;
+	}
+
+	if (!err) {
+		bool busy = READ_ONCE(host->mrq) != NULL;
+
+		changed = present != prev;
+		WRITE_ONCE(host->card_exist, present);
+
+		if (busy) {
+			host->idle_counter = 0;
+			if (host->idle)
+				sdmmc_leave_idle(host);
+		} else if (!present) {
+			if (host->idle_counter < host->idle_wait_max)
+				host->idle_counter++;
+			if (!host->idle &&
+			    host->idle_counter >= host->idle_wait_max)
+				sdmmc_enter_idle(host);
+		} else {
+			host->idle_counter = 0;
+			if (host->idle)
+				sdmmc_leave_idle(host);
+		}
+
+		if (!present) {
+			if (host->seq_mode)
+				sdmmc_stop_seq_mode(host);
+			host->seq_mode = false;
+			host->seq_read = false;
+			host->seq_counter = 0;
+		} else if (host->seq_mode) {
+			if (busy) {
+				host->seq_counter = 0;
+			} else if (++host->seq_counter >= host->seq_wait_max) {
+				sdmmc_stop_seq_mode(host);
+			}
+		} else {
+			host->seq_counter = 0;
+		}
+	}
+
+	mutex_unlock(&ucr->dev_mutex);
+
+	pm_runtime_put_sync_suspend(dev);
+
+	if (changed)
+		mmc_detect_change(host->mmc, 0);
+
+requeue:
+	if (!host->host_removal) {
+		bool request_active = READ_ONCE(host->mrq) != NULL;
+		bool card_present = READ_ONCE(host->card_exist);
+		unsigned long delay = card_present || request_active ?
+			RTSX_USB_SD_POLL_INTERVAL :
+			RTSX_USB_SD_IDLE_POLL_INTERVAL;
+
+		host->poll_interval = delay;
+		queue_delayed_work(system_wq, &host->card_poll, delay);
+	}
+}
+
 static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct rtsx_usb_sdmmc *host = mmc_priv(mmc);
@@ -832,10 +1048,14 @@ static void sdmmc_request(struct mmc_host *mmc,
struct mmc_request *mrq)
 		goto finish_detect_card;
 	}
 	mutex_lock(&ucr->dev_mutex);
+	if (host->seq_mode)
+		sdmmc_stop_seq_mode(host);

 	mutex_lock(&host->host_mutex);
 	host->mrq = mrq;
 	mutex_unlock(&host->host_mutex);
+	sdmmc_leave_idle(host);
+	host->idle_counter = 0;

 	if (mrq->data)
 		data_size = data->blocks * data->blksz;
@@ -1051,6 +1271,8 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		if (err)
 			dev_dbg(sdmmc_dev(host), "power-off (err = %d)\n", err);
 		pm_runtime_put_noidle(sdmmc_dev(host));
+		sdmmc_enter_idle(host);
+		host->idle_counter = 0;
 		break;

 	case MMC_POWER_UP:
@@ -1060,11 +1282,15 @@ static void sd_set_power_mode(struct
rtsx_usb_sdmmc *host,
 			dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
 		/* issue the clock signals to card at least 74 clocks */
 		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN,
SD_CLK_TOGGLE_EN);
+		sdmmc_leave_idle(host);
+		host->idle_counter = 0;
 		break;

 	case MMC_POWER_ON:
 		/* stop to send the clock signals */
 		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
+		sdmmc_leave_idle(host);
+		host->idle_counter = 0;
 		break;

 	case MMC_POWER_UNDEFINED:
@@ -1367,6 +1593,13 @@ static void rtsx_usb_init_host(struct
rtsx_usb_sdmmc *host)

 	host->power_mode = MMC_POWER_OFF;
 	host->ocp_stat = 0;
+	host->idle_counter = 0;
+	host->idle_wait_max = RTSX_USB_SD_IDLE_WAIT_MAX;
+	host->idle = false;
+	host->seq_mode = false;
+	host->seq_read = false;
+	host->seq_counter = 0;
+	host->seq_wait_max = RTSX_USB_SD_SEQ_WAIT_MAX;
 }

 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
@@ -1397,6 +1630,8 @@ static int rtsx_usb_sdmmc_drv_probe(struct
platform_device *pdev)

 	mutex_init(&host->host_mutex);
 	rtsx_usb_init_host(host);
+	host->poll_interval = RTSX_USB_SD_POLL_INTERVAL;
+	INIT_DELAYED_WORK(&host->card_poll, rtsx_usb_sdmmc_poll_card);
 	pm_runtime_enable(&pdev->dev);

 #ifdef RTSX_USB_USE_LEDS_CLASS
@@ -1423,6 +1658,9 @@ static int rtsx_usb_sdmmc_drv_probe(struct
platform_device *pdev)
 		return ret;
 	}

+	queue_delayed_work(system_wq, &host->card_poll,
+			 host->poll_interval);
+
 	return 0;
 }

@@ -1436,6 +1674,7 @@ static void rtsx_usb_sdmmc_drv_remove(struct
platform_device *pdev)

 	mmc = host->mmc;
 	host->host_removal = true;
+	cancel_delayed_work_sync(&host->card_poll);

 	mutex_lock(&host->host_mutex);
 	if (host->mrq) {
-- 
2.51.0

