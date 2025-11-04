Return-Path: <linux-kernel+bounces-885184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE9C3235D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D011018C4CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7322338939;
	Tue,  4 Nov 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="aMlFMV0J"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175C335547
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275768; cv=none; b=ab/62KpzJrsk3qbd67dO4t0V5Glhc1bhJD6YS4LbPx/Q/vUmGbEEk+pvN5NYtLAFWw7KRDPb4xmGUn2urIP4Yp47bnaojSM2jx29iAoLFUjYeSeUP91GwtgSKi01V8zqvG5vCRt2QMYtX9ACPt3vm+pc1Wdo02mop8+vy40wy4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275768; c=relaxed/simple;
	bh=Zon3NZlT+povp9UOGd3PLAyKEmPhBG0axuf8/9LGPLI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=fvmKGDBC/CFAOu54avv94o1CNVhrqWNOQsusmT473AraeK+FiZZto54AkIUbfMhHB/f4OBdLZwKgBc+DBoUgPdkW9OOVAlkFBZbwl/xCNM/Ypf5d4HARaDOYPqfe1ImJubHyQXBQTPEs+0XNPP40J5aiMKXPL57WK7K8Fdf2Pbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=aMlFMV0J; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7866aca9ff4so28656057b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1762275764; x=1762880564; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8wD2JB12ScMHHi+okW/c1simKTgKWvUb7h9hwG4s35A=;
        b=aMlFMV0JvXwU+CBiLcpxn0GD5nH+2wz0sJ4pJX9NWCzqXMRGduNr2u6aQePWx7JTkz
         KfBJjSMZemERYC7+mrTA/8Vo86A9ze/PSWTZ4G3hP9Lx6kFBmCPVrVNh7WWtFR8n2IJz
         M/cLN75MFZPUe9Lq8AuVD+aaaHa9Vbmx5oIYnoyOkJsNZv7cZhhoyT5kloFSctf7DKvA
         ZmTAUV5MkymP0RcZqJqFVwPgzZKQZrb0jRIbFdhI5TNj/pH1bWvWU3MiatsL1Kxwf+0E
         EHClFiqA56eKjvneh3HMVbrTXDrzgVTX7wLKN7ejdpmS4LCAjobjpAkIDYz33MjCKoh0
         hqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275764; x=1762880564;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wD2JB12ScMHHi+okW/c1simKTgKWvUb7h9hwG4s35A=;
        b=SJB8SyFA6F7G1j09S6WVLpCHEyYZ0SQCz7MNyealgass8PKqic6Njuqzrw4tnswlwy
         YSuaYFiDULiIxUC2SYIFtd013ynQUQ0VCxT+Kzo/+vrtAvhzFDyLWDmDNXkoTrRoS+Jj
         dF21yBqHVmXKJls6EBChw5WaICuDfprV47pxUVrG11v/ICxCRdooyCmLsbZQLvE8oCM6
         RrEvS+4KS91//L4oWgnF2F5o3Ozq4uSm45cAZkOnEuUvbmwJd0yXCOMgs8oHYmJX3pLn
         fejAa4vRxW2M8UwQ9dvFUAWANKJS5daHK8Nkz3gIU7dAnBIK1GXAQvFhXuEUOBhFiUfv
         RbXA==
X-Gm-Message-State: AOJu0YweoVGD/UXjbexyK1vyyRQIj2rvQP8pf9keYa2vLMILaDUgPBKM
	3m+/YDrvUCx+YPRgdR9Htyy/Qs9E2dYatmjQ2wNTSmKS5dNLVLWVHyoFl/P+soRmdifR7brf9eK
	46iM2RyDA8HINOc/srrWcOli2p6orclOOox2HqtEsQHk5sip21pGbhA==
X-Gm-Gg: ASbGncsCBs6B8rqX9A1A01af5028mQLhz9ZBYxH1iyMSUuAIAFAGl/teymiH0RrywY3
	tPjSCrD1vqe4XEn4pJHUCYoCjAn3xb89Eb/chJ2qtv4SN58uFNXQs2czSTfOJMojpLJ1qUssDHd
	l1tq9o/3fgYLS2Tzdw4N/rQbwFZzbuepRCOqR5m3P8eG8djqcQ/zv96TrlHv+sfD+T1V6RiWu4W
	hx6mXBfceE4K9SpNN8PTVns3ptbFgMMUIcbVi1RBMG+9PQZfaS1VqsM5ZIKlGh2MJjNYwaZ
X-Google-Smtp-Source: AGHT+IHUaFnS9uUo5ijADXutpiy6RBSYYHJ7sD3cNoFvMnl2JLOP9s99ehdcvU8/BxWxg1wyPxvzKva+PEwyv4SDFik=
X-Received: by 2002:a05:690e:2417:b0:62d:9854:f1c3 with SMTP id
 956f58d0204a3-63fd356f292mr130110d50.33.1762275763449; Tue, 04 Nov 2025
 09:02:43 -0800 (PST)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:43 -0500
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 12:02:43 -0500
X-Gm-Features: AWmQ_bmFEsdHmnc-Z5zXVZwYVijByXEQl50UPKz7i8qJbQeVQHSTLql8-B-4znI
Message-ID: <CABtds-1=hvKzpKJK7X4xrGJcG4-14MB52YfJLP=19ihTUASmtQ@mail.gmail.com>
Subject: [PATCH] drivers/mmc: rtsx_usb: expose CPRM ioctl interface
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 3273869107d69ffa9a97a50d41a71cc220cbc425 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 16:30:57 +0000
Subject: [PATCH 5/5] drivers/mmc: rtsx_usb: expose CPRM ioctl interface

Add the user-facing CPRM command/response ioctls, track response buffers
inside the host, and register a miscdevice per controller so
userspace can issue raw CPRM transactions against supported readers.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>
Cc: Avri Altman <avri.altman@sandisk.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 544 +++++++++++++++++++++++++++++-
 1 file changed, 538 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 5d8c72459b3f..211297ee2f20 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -12,6 +12,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/usb.h>
+#include <linux/fs.h>
+#include <linux/bitops.h>
+#include <linux/mmc/core.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
@@ -21,6 +24,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
 #include <linux/jiffies.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/compat.h>
+#include <linux/vmalloc.h>

 #include <linux/rtsx_usb.h>
 #include <linux/unaligned.h>
@@ -35,6 +42,42 @@
 #define RTSX_USB_SD_IDLE_POLL_INTERVAL	msecs_to_jiffies(1000)
 #define RTSX_USB_SD_IDLE_WAIT_MAX	10
 #define RTSX_USB_SD_SEQ_WAIT_MAX	2
+#define RTSX_USB_MMC_CMD_RETRIES	3
+
+#define RTSX_USB_IOC_MAGIC		0x39
+
+struct rtsx_usb_ioc_sd_direct {
+	u8 cmnd[12];
+	__u64 buf;
+	__s32 buf_len;
+} __packed;
+
+struct rtsx_usb_ioc_sd_rsp {
+	__u64 rsp;
+	__s32 rsp_len;
+} __packed;
+
+#define RTSX_USB_IOC_SD_DIRECT	_IOWR(RTSX_USB_IOC_MAGIC, 0xA0, \
+				struct rtsx_usb_ioc_sd_direct)
+#define RTSX_USB_IOC_SD_GET_RSP	_IOWR(RTSX_USB_IOC_MAGIC, 0xA1, \
+				struct rtsx_usb_ioc_sd_rsp)
+
+#ifdef CONFIG_COMPAT
+struct rtsx_usb_ioc_sd_direct32 {
+	u8 cmnd[12];
+	compat_uptr_t buf;
+	__s32 buf_len;
+} __packed;
+
+struct rtsx_usb_ioc_sd_rsp32 {
+	compat_uptr_t rsp;
+	__s32 rsp_len;
+} __packed;
+#define RTSX_USB_IOC_SD_DIRECT32	_IOWR(RTSX_USB_IOC_MAGIC, 0xA0, \
+				struct rtsx_usb_ioc_sd_direct32)
+#define RTSX_USB_IOC_SD_GET_RSP32	_IOWR(RTSX_USB_IOC_MAGIC, 0xA1, \
+				struct rtsx_usb_ioc_sd_rsp32)
+#endif

 struct rtsx_usb_sdmmc {
 	struct platform_device	*pdev;
@@ -64,6 +107,14 @@ struct rtsx_usb_sdmmc {

 	unsigned char		power_mode;
 	u16			ocp_stat;
+	struct mutex		cprm_lock;
+	u8			cprm_rsp[16];
+	size_t			cprm_rsp_len;
+	bool			cprm_rsp_valid;
+	u8			cprm_rsp_type;
+	struct miscdevice	cprm_miscdev;
+	char			*cprm_name;
+	bool			cprm_registered;
 #ifdef RTSX_USB_USE_LEDS_CLASS
 	struct led_classdev	led;
 	char			led_name[32];
@@ -123,7 +174,7 @@ static void sdmmc_enter_idle(struct rtsx_usb_sdmmc *host)
 		goto out_dbg;

 	err = rtsx_usb_write_register(ucr, FPDCTL,
-				      SSC_POWER_MASK, SSC_POWER_DOWN);
+					      SSC_POWER_MASK, SSC_POWER_DOWN);
 	if (!err)
 		host->idle = true;

@@ -143,7 +194,7 @@ static void sdmmc_leave_idle(struct rtsx_usb_sdmmc *host)
 		return;

 	err = rtsx_usb_write_register(ucr, FPDCTL,
-				      SSC_POWER_MASK, SSC_POWER_ON);
+					      SSC_POWER_MASK, SSC_POWER_ON);
 	if (err)
 		goto out_dbg;

@@ -977,8 +1028,7 @@ static void rtsx_usb_sdmmc_poll_card(struct
work_struct *work)
 		} else if (!present) {
 			if (host->idle_counter < host->idle_wait_max)
 				host->idle_counter++;
-			if (!host->idle &&
-			    host->idle_counter >= host->idle_wait_max)
+			if (!host->idle && host->idle_counter >= host->idle_wait_max)
 				sdmmc_enter_idle(host);
 		} else {
 			host->idle_counter = 0;
@@ -1015,8 +1065,7 @@ static void rtsx_usb_sdmmc_poll_card(struct
work_struct *work)
 		bool request_active = READ_ONCE(host->mrq) != NULL;
 		bool card_present = READ_ONCE(host->card_exist);
 		unsigned long delay = card_present || request_active ?
-			RTSX_USB_SD_POLL_INTERVAL :
-			RTSX_USB_SD_IDLE_POLL_INTERVAL;
+			RTSX_USB_SD_POLL_INTERVAL : RTSX_USB_SD_IDLE_POLL_INTERVAL;

 		host->poll_interval = delay;
 		queue_delayed_work(system_wq, &host->card_poll, delay);
@@ -1106,6 +1155,457 @@ static void sdmmc_request(struct mmc_host
*mmc, struct mmc_request *mrq)
 	mmc_request_done(mmc, mrq);
 }

+static int rtsx_usb_cprm_rsp_config(u8 rsp_code, unsigned int *flags,
+				 u8 *rsp_len)
+{
+	unsigned int cmd_flags;
+	u8 len;
+
+	switch (rsp_code) {
+	case 0x04: /* R0 */
+		cmd_flags = MMC_RSP_NONE;
+		len = 0;
+		break;
+	case 0x01: /* R1/R5/R6/R7 */
+		cmd_flags = MMC_RSP_R1;
+		len = 4;
+		break;
+	case 0x09: /* R1b */
+		cmd_flags = MMC_RSP_R1B;
+		len = 4;
+		break;
+	case 0x02: /* R2 */
+		cmd_flags = MMC_RSP_R2;
+		len = 16;
+		break;
+	case 0x05: /* R3/R4 */
+		cmd_flags = MMC_RSP_R3;
+		len = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (flags)
+		*flags = cmd_flags;
+	if (rsp_len)
+		*rsp_len = len;
+
+	return 0;
+}
+
+static void rtsx_usb_cprm_store_resp(struct rtsx_usb_sdmmc *host,
+				    struct mmc_command *cmd, u8 rsp_code,
+				    u8 rsp_len)
+{
+	int i;
+
+	host->cprm_rsp_type = rsp_code;
+	host->cprm_rsp_len = rsp_len;
+	host->cprm_rsp_valid = false;
+
+	if (!rsp_len)
+		goto out_valid;
+
+	if (rsp_len == 16) {
+		for (i = 0; i < 4; i++)
+			put_unaligned_be32(cmd->resp[i], host->cprm_rsp + i * 4);
+	} else {
+		put_unaligned_be32(cmd->resp[0], host->cprm_rsp);
+	}
+
+out_valid:
+	host->cprm_rsp_valid = true;
+}
+
+static int rtsx_usb_mmc_deselect_cards(struct mmc_host *host)
+{
+	struct mmc_command cmd = { };
+
+	if (!host)
+		return -EINVAL;
+
+	cmd.opcode = MMC_SELECT_CARD;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;
+
+	return mmc_wait_for_cmd(host, &cmd, RTSX_USB_MMC_CMD_RETRIES);
+}
+
+static int rtsx_usb_mmc_select_card(struct mmc_card *card)
+{
+	struct mmc_command cmd = { };
+
+	if (!card)
+		return -EINVAL;
+
+	cmd.opcode = MMC_SELECT_CARD;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	return mmc_wait_for_cmd(card->host, &cmd, RTSX_USB_MMC_CMD_RETRIES);
+}
+
+static int rtsx_usb_cprm_exec_direct(struct rtsx_usb_sdmmc *host,
+				         const struct rtsx_usb_ioc_sd_direct *req)
+{
+	struct device *dev = sdmmc_dev(host);
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_card *card = mmc->card;
+	struct mmc_request mrq = {};
+	struct mmc_command cmd = {};
+	struct mmc_command stop = {};
+	struct mmc_data data = {};
+	struct scatterlist sg;
+	unsigned int rsp_flags;
+	u8 rsp_len;
+	void *kbuf = NULL;
+	void __user *user_buf;
+	u32 arg, data_len;
+	unsigned int blksz = 512;
+	unsigned int blocks = 0;
+	bool restore_blklen = false;
+	bool send_stop, standby, acmd;
+	u8 dir;
+	int ret = 0;
+
+	mutex_lock(&host->cprm_lock);
+	host->cprm_rsp_valid = false;
+
+	if (!card) {
+		ret = -ENOMEDIUM;
+		goto out_unlock;
+	}
+
+	dir = (req->cmnd[0] >> 3) & 0x03;
+	send_stop = req->cmnd[0] & BIT(2);
+	standby = req->cmnd[0] & BIT(1);
+	acmd = req->cmnd[0] & BIT(0);
+
+	cmd.opcode = req->cmnd[1];
+	arg = ((u32)req->cmnd[2] << 24) |
+	      ((u32)req->cmnd[3] << 16) |
+	      ((u32)req->cmnd[4] << 8) |
+	      (u32)req->cmnd[5];
+	cmd.arg = arg;
+	data_len = ((u32)req->cmnd[6] << 16) |
+		   ((u32)req->cmnd[7] << 8) |
+		   (u32)req->cmnd[8];
+	cmd.error = 0;
+
+	user_buf = u64_to_user_ptr(req->buf);
+
+	if (req->buf_len < 0) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	switch (dir) {
+	case 0:
+		if (data_len) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		break;
+	case 1:
+	case 2:
+		if (!data_len || req->buf_len < data_len) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		if (!user_buf) {
+			ret = -EFAULT;
+			goto out_unlock;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = rtsx_usb_cprm_rsp_config(req->cmnd[9], &rsp_flags, &rsp_len);
+	if (ret)
+		goto out_unlock;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto out_unlock;
+	}
+
+	mmc_get_card(card);
+	mmc_claim_host(mmc);
+
+	if (standby) {
+		ret = rtsx_usb_mmc_deselect_cards(mmc);
+		if (ret)
+			goto out_release;
+	}
+
+	if (acmd) {
+		ret = mmc_app_cmd(mmc, card);
+		if (ret)
+			goto out_restore_select;
+	}
+
+	if (dir) {
+		if (data_len < 512) {
+			ret = mmc_set_blocklen(card, data_len);
+			if (ret)
+				goto out_restore_select;
+			blksz = data_len;
+			blocks = 1;
+			restore_blklen = true;
+		} else if (data_len % 512) {
+			ret = -EINVAL;
+			goto out_restore_select;
+		} else {
+			blocks = data_len / 512;
+		}
+
+		kbuf = kvmalloc(data_len, GFP_KERNEL);
+		if (!kbuf) {
+			ret = -ENOMEM;
+			goto out_restore_blklen;
+		}
+
+		if (dir == 2) {
+			if (copy_from_user(kbuf, user_buf, data_len)) {
+				ret = -EFAULT;
+				goto out_restore_blklen;
+			}
+		}
+
+		data.blksz = blksz;
+		data.blocks = blocks ? blocks : 1;
+		data.flags = (dir == 1) ? MMC_DATA_READ : MMC_DATA_WRITE;
+		data.sg = &sg;
+		data.sg_len = 1;
+		data.error = 0;
+		sg_init_one(&sg, kbuf, data_len);
+		mmc_set_data_timeout(&data, card);
+		mrq.data = &data;
+		cmd.flags = rsp_flags | MMC_CMD_ADTC;
+	} else {
+		cmd.flags = rsp_flags | MMC_CMD_AC;
+	}
+
+	mrq.cmd = &cmd;
+
+	if (dir && send_stop) {
+		stop.opcode = MMC_STOP_TRANSMISSION;
+		stop.arg = 0;
+		stop.flags = MMC_RSP_R1B | MMC_CMD_AC;
+		mrq.stop = &stop;
+	}
+
+	mmc_wait_for_req(mmc, &mrq);
+
+	if (cmd.error)
+		ret = cmd.error;
+	else if (mrq.data && mrq.data->error)
+		ret = mrq.data->error;
+	else if (mrq.stop && mrq.stop->error)
+		ret = mrq.stop->error;
+	else
+		ret = 0;
+
+	if (restore_blklen) {
+		int err = mmc_set_blocklen(card, 512);
+
+		if (!ret && err)
+			ret = err;
+	}
+
+	if (standby) {
+		int err = rtsx_usb_mmc_select_card(card);
+
+		if (!ret && err)
+			ret = err;
+	}
+
+	mmc_release_host(mmc);
+	mmc_put_card(card);
+	pm_runtime_put(dev);
+
+	if (ret)
+		goto out_copy_err;
+
+	if (dir == 1) {
+		if (copy_to_user(user_buf, kbuf, data_len)) {
+			ret = -EFAULT;
+			goto out_copy_err;
+		}
+	}
+
+	rtsx_usb_cprm_store_resp(host, &cmd, req->cmnd[9], rsp_len);
+
+	ret = 0;
+
+out_copy_err:
+	if (ret)
+		host->cprm_rsp_valid = false;
+	kvfree(kbuf);
+	mutex_unlock(&host->cprm_lock);
+	return ret;
+
+out_restore_blklen:
+	if (restore_blklen) {
+		int err_restore = mmc_set_blocklen(card, 512);
+
+		if (!ret && err_restore)
+			ret = err_restore;
+	}
+out_restore_select:
+	if (standby) {
+		int err_select = rtsx_usb_mmc_select_card(card);
+
+		if (!ret && err_select)
+			ret = err_select;
+	}
+out_release:
+	mmc_release_host(mmc);
+	mmc_put_card(card);
+	pm_runtime_put(dev);
+out_unlock:
+	kvfree(kbuf);
+	mutex_unlock(&host->cprm_lock);
+	return ret;
+}
+
+static int rtsx_usb_cprm_get_response(struct rtsx_usb_sdmmc *host,
+				      struct rtsx_usb_ioc_sd_rsp *req)
+{
+	void __user *user_rsp = u64_to_user_ptr(req->rsp);
+	size_t to_copy;
+	int ret = 0;
+
+	mutex_lock(&host->cprm_lock);
+	if (!host->cprm_rsp_valid) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (req->rsp_len < 0) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	to_copy = min_t(size_t, host->cprm_rsp_len,
+		       (size_t)req->rsp_len);
+
+	if (to_copy && copy_to_user(user_rsp, host->cprm_rsp, to_copy)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	req->rsp_len = to_copy;
+
+out_unlock:
+	mutex_unlock(&host->cprm_lock);
+	return ret;
+}
+
+static int rtsx_usb_cprm_open(struct inode *inode, struct file *file)
+{
+	struct rtsx_usb_sdmmc *host;
+
+	host = container_of(file->private_data,
+			    struct rtsx_usb_sdmmc, cprm_miscdev);
+	if (!host || host->host_removal)
+		return -ENODEV;
+
+	file->private_data = host;
+	return nonseekable_open(inode, file);
+}
+
+static long rtsx_usb_cprm_unlocked_ioctl(struct file *file, unsigned int cmd,
+					   unsigned long arg)
+{
+	struct rtsx_usb_sdmmc *host = file->private_data;
+	struct rtsx_usb_ioc_sd_direct direct;
+	struct rtsx_usb_ioc_sd_rsp rsp;
+	void __user *argp = (void __user *)arg;
+	int ret;
+
+	if (host->host_removal)
+		return -ENODEV;
+
+	switch (cmd) {
+	case RTSX_USB_IOC_SD_DIRECT:
+		if (copy_from_user(&direct, argp, sizeof(direct)))
+			return -EFAULT;
+		ret = rtsx_usb_cprm_exec_direct(host, &direct);
+		return ret;
+	case RTSX_USB_IOC_SD_GET_RSP:
+		if (copy_from_user(&rsp, argp, sizeof(rsp)))
+			return -EFAULT;
+		ret = rtsx_usb_cprm_get_response(host, &rsp);
+		if (ret)
+			return ret;
+		if (copy_to_user(argp, &rsp, sizeof(rsp)))
+			return -EFAULT;
+		return 0;
+	default:
+		return -ENOTTY;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static long rtsx_usb_cprm_compat_ioctl(struct file *file, unsigned int cmd,
+					     unsigned long arg)
+{
+	struct rtsx_usb_sdmmc *host = file->private_data;
+	void __user *argp = compat_ptr(arg);
+
+	if (host->host_removal)
+		return -ENODEV;
+
+	switch (cmd) {
+	case RTSX_USB_IOC_SD_DIRECT32:
+	{
+		struct rtsx_usb_ioc_sd_direct32 direct32;
+		struct rtsx_usb_ioc_sd_direct direct;
+
+		if (copy_from_user(&direct32, argp, sizeof(direct32)))
+			return -EFAULT;
+		memcpy(direct.cmnd, direct32.cmnd, sizeof(direct.cmnd));
+		direct.buf = direct32.buf;
+		direct.buf_len = direct32.buf_len;
+		return rtsx_usb_cprm_exec_direct(host, &direct);
+	}
+	case RTSX_USB_IOC_SD_GET_RSP32:
+	{
+		struct rtsx_usb_ioc_sd_rsp32 rsp32;
+		struct rtsx_usb_ioc_sd_rsp rsp;
+		int ret;
+
+		if (copy_from_user(&rsp32, argp, sizeof(rsp32)))
+			return -EFAULT;
+		rsp.rsp = rsp32.rsp;
+		rsp.rsp_len = rsp32.rsp_len;
+		ret = rtsx_usb_cprm_get_response(host, &rsp);
+		if (ret)
+			return ret;
+		rsp32.rsp_len = rsp.rsp_len;
+		if (copy_to_user(argp, &rsp32, sizeof(rsp32)))
+			return -EFAULT;
+		return 0;
+	}
+	default:
+		return -ENOTTY;
+	}
+}
+#endif
+
+static const struct file_operations rtsx_usb_cprm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= rtsx_usb_cprm_open,
+	.unlocked_ioctl = rtsx_usb_cprm_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= rtsx_usb_cprm_compat_ioctl,
+#endif
+	.llseek		= no_llseek,
+};
+
 static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
 		unsigned char bus_width)
 {
@@ -1600,6 +2100,12 @@ static void rtsx_usb_init_host(struct
rtsx_usb_sdmmc *host)
 	host->seq_read = false;
 	host->seq_counter = 0;
 	host->seq_wait_max = RTSX_USB_SD_SEQ_WAIT_MAX;
+	mutex_init(&host->cprm_lock);
+	host->cprm_rsp_len = 0;
+	host->cprm_rsp_valid = false;
+	host->cprm_rsp_type = 0;
+	host->cprm_registered = false;
+	host->cprm_name = NULL;
 }

 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
@@ -1658,6 +2164,27 @@ static int rtsx_usb_sdmmc_drv_probe(struct
platform_device *pdev)
 		return ret;
 	}

+	host->cprm_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_cprm",
+				      mmc_hostname(mmc));
+	if (host->cprm_name) {
+		host->cprm_miscdev.minor = MISC_DYNAMIC_MINOR;
+		host->cprm_miscdev.name = host->cprm_name;
+		host->cprm_miscdev.fops = &rtsx_usb_cprm_fops;
+		host->cprm_miscdev.parent = &pdev->dev;
+		host->cprm_miscdev.mode = 0600;
+		ret = misc_register(&host->cprm_miscdev);
+		if (ret) {
+			dev_warn(&(pdev->dev),
+				 "Failed to register CPRM interface: %d\n", ret);
+		} else {
+			host->cprm_registered = true;
+			dev_set_drvdata(host->cprm_miscdev.this_device, host);
+		}
+	} else {
+		dev_warn(&(pdev->dev),
+			 "Failed to allocate CPRM interface name\n");
+	}
+
 	queue_delayed_work(system_wq, &host->card_poll,
 			 host->poll_interval);

@@ -1675,6 +2202,11 @@ static void rtsx_usb_sdmmc_drv_remove(struct
platform_device *pdev)
 	mmc = host->mmc;
 	host->host_removal = true;
 	cancel_delayed_work_sync(&host->card_poll);
+	if (host->cprm_registered) {
+		dev_set_drvdata(host->cprm_miscdev.this_device, NULL);
+		misc_deregister(&host->cprm_miscdev);
+		host->cprm_registered = false;
+	}

 	mutex_lock(&host->host_mutex);
 	if (host->mrq) {
-- 
2.51.0

