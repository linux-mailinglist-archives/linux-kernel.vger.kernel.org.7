Return-Path: <linux-kernel+bounces-744237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D9B109ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784023ACB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFEF2C15A3;
	Thu, 24 Jul 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="xBQ+pmeC"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837F248869
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358998; cv=none; b=tq1R1z1IdPWFJW4XbGOkSobNpti15X/DxTXbOcCwuwLZpKbf7VgdtvIhsd7V4wT8bfm4cIrw0Y1WH1KymDnKqXOmWZFOjkKv8HKA9W2n5jrXK2TOnbPMmhCXMmVGEA0H8HGD31nxio1ThcU3dS2epr4P+r7do8v1W10RDBakoTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358998; c=relaxed/simple;
	bh=AAzmXavI/AStflPpJygGxpFfxnHmYYbjfFhzOslO1ts=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=GlEqU/d8tMqI7HgvKGUB6D/9SQgL00o8R2VY1l/mxQNBYC4RCteW/pEZxZ44leej+3fKFegIGPlrPkdo9NKNg3GBxh5v2biKBXn14Z9iV+Q1h2R8O/oJ7ujibLLUIMQKiIjr1cVFby9HEtxsUrpZZutby8REOmXoRtWNePNW9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=xBQ+pmeC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so158026366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1753358992; x=1753963792; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WvOmaLn/ULPYZJZtgeT74ERNl1YMD2oKsbtoKHFeHPg=;
        b=xBQ+pmeCRG9qjXpq/R5RCvvq/o+jY0AU5IE55ZyH0wwzJP19vzyyH4oY3xK6wBAhbp
         Hxrr2i5mCZQfjL8urc2VO7xM4j+1kpls3WOd5PY0FlAeJzsHzb8V8KbX2ope1uXydIrH
         cCGO58alOU8sZqo02z74bFEllV5iMn43cWtNbfp4EP2DlJY3+sP3H0NSsbz3JvhqQRAd
         gTKk/I2vWZ6ku7Z76MWIIUigfvdQacQ43+ZXGhGmFlJxtdUgZ6qtSz604j2jTLGcdMxm
         edBv5eisO7iE5LIbzb4+C5YLzY5RvnIxiny1wfcGhq4TGpRXff8A+BpEGBE9vVVBt1V8
         uylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358993; x=1753963793;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvOmaLn/ULPYZJZtgeT74ERNl1YMD2oKsbtoKHFeHPg=;
        b=omtGUGXBfhj2EqUXcmSRDPp4okXdtyHc4oTerBEDHwRN08SV6x4SYfQXez6T39Q8/5
         2FHZYwOMIXinNUx/GzvTm+X7NdsTxaWN/INhZ5kjmBJ/0OmAV3zpu896fT1HMbzJi1xe
         1Aqr6f2itHolBuk/raAGxFp9MVTO9MH/PUl1GhbYfSVkJQgWa+VkaDD7KXdSGww/DTvD
         68SbJ8A0zCC2snmxDeGFv64q1bqiQcwEeMhl1cERLcXoVLrUtIB3+7WRjdE4BqIgK9Ro
         CxkRtWk7pcUpFqne9qwCU72KaRhWeSeeQ2Mz/1TTH8US/ZzrGPdWh8ph10Lj3J1H5jRW
         wZcA==
X-Gm-Message-State: AOJu0YzMPuAHT9ESsAJExpVr58g6apBssHnRznrXV2xvKRvUsAw5vBKE
	iCDHfsg+PYOxUW0Lbyy2PSQLEpxFT6/1kqUUE3g5JmHRjvhn74tnnkUuoyYbF4ydKWZED5qEdOT
	j5+GjFOb0PtbFLkc8NZSxJe7Zc3keJ782TlDcFs8uOeScveYwAKs1aYAF
X-Gm-Gg: ASbGncsNnEi1uHeY/1RlovZxJM6lDPoqs+NzymL6ocrrt+fpn3RuELavUjkN90Lolm+
	EQ2i1ZXEFAn4fKDzzzqpVTBnsN83HVjRuKCnMwaD7/gs6tBkEmnvZm0+69Z6Z8jj9Wvny1NMi8r
	15Ghf7616VE4YLHYG3XtErDVN4hBSCQAthCcwqwGbTnvnKEEDJszi2LFGpLVkUfHgBr6y6+gVCH
	nXEl5Dh
X-Google-Smtp-Source: AGHT+IGNWM6S21bzU0XoTWR974rIys3veGAIybXrExisEh/rDnRYzg9D6JZ1GRFWeZPcXPF4f/r9JIiwi2O6aGtI9cA=
X-Received: by 2002:a17:907:3c93:b0:ae9:c789:13f9 with SMTP id
 a640c23a62f3a-af2f8860f32mr627333466b.30.1753358992323; Thu, 24 Jul 2025
 05:09:52 -0700 (PDT)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 12:09:50 +0000
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Jul 2025 12:09:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 24 Jul 2025 12:09:50 +0000
X-Gm-Features: Ac12FXwbJuTRIR4gq5N73MLa7PHYJhAMniyxljVyz5WYYG8XsKgP_uL_5IUD4YM
Message-ID: <CABtds-0E8gfvtEZMrKmof4656wxkUKkGphfkSS=tb_4tQH2RRQ@mail.gmail.com>
Subject: [PATCH] mmc: rtsx_usb_sdmmc: fix SDR104 timings
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 21134948f99d3c232671392f53b83b5575dda2fc Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 24 Jul 2025 10:53:20 +0100
Subject: [PATCH] mmc: rtsx_usb_sdmmc: fix SDR104 timings

With the current rtsx_usb driver, SDR104 SD cards do not work due to
incorrect timing configuration. This causes data corruption when the
card is accessed.

Fix this by copying the working timing configuration from the 11 year
old RTS5139 staging driver, which was removed in commit 00d8521dcd23
("staging: remove rts5139 driver code"). These values are known to
function correctly.

Tested using a SanDisk Extreme microSDXC 128GB (previously affected),
plus several other cards. Copied ~1GB of data, tested rapid removal/
insertion, suspend/resume (S3), and verified data integrity afterwards.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 54 +++++++++++++++++++------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..a56c725d99fb 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1036,7 +1036,7 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 }

 static int sd_set_timing(struct rtsx_usb_sdmmc *host,
-		unsigned char timing, bool *ddr_mode)
+			 unsigned char timing, bool *ddr_mode)
 {
 	struct rtsx_ucr *ucr = host->ucr;

@@ -1046,50 +1046,64 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,

 	switch (timing) {
 	case MMC_TIMING_UHS_SDR104:
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
+				 0x0C | SD_ASYNC_FIFO_RST,
+				 SD_30_MODE | SD_ASYNC_FIFO_RST);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
+				 CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
+				 SD20_TX_SEL_MASK, SD20_TX_14_AHEAD);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
+				 SD20_RX_SEL_MASK, SD20_RX_14_DELAY);
+		break;
+
 	case MMC_TIMING_UHS_SDR50:
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
-				0x0C | SD_ASYNC_FIFO_RST,
-				SD_30_MODE | SD_ASYNC_FIFO_RST);
+				 0x0C | SD_ASYNC_FIFO_RST,
+				 SD_30_MODE | SD_ASYNC_FIFO_RST);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
-				CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+				 CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
+				 SD20_TX_SEL_MASK, SD20_TX_14_AHEAD);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
+				 SD20_RX_SEL_MASK, SD20_RX_14_DELAY);
 		break;

 	case MMC_TIMING_UHS_DDR50:
 		*ddr_mode = true;

 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
-				0x0C | SD_ASYNC_FIFO_RST,
-				SD_DDR_MODE | SD_ASYNC_FIFO_RST);
+				 0x0C | SD_ASYNC_FIFO_RST,
+				 SD_DDR_MODE | SD_ASYNC_FIFO_RST);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
-				CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+				 CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
-				DDR_VAR_TX_CMD_DAT, DDR_VAR_TX_CMD_DAT);
+				 DDR_VAR_TX_CMD_DAT, DDR_VAR_TX_CMD_DAT);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
-				DDR_VAR_RX_DAT | DDR_VAR_RX_CMD,
-				DDR_VAR_RX_DAT | DDR_VAR_RX_CMD);
+				 DDR_VAR_RX_DAT | DDR_VAR_RX_CMD,
+				 DDR_VAR_RX_DAT | DDR_VAR_RX_CMD);
 		break;

 	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_SD_HS:
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
-				0x0C, SD_20_MODE);
+				 0x0C, SD_20_MODE);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
-				CRC_FIX_CLK | SD30_VAR_CLK0 | SAMPLE_VAR_CLK1);
+				 CRC_FIX_CLK | SD30_VAR_CLK0 | SAMPLE_VAR_CLK1);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
-				SD20_TX_SEL_MASK, SD20_TX_14_AHEAD);
+				 SD20_TX_SEL_MASK, SD20_TX_14_AHEAD);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
-				SD20_RX_SEL_MASK, SD20_RX_14_DELAY);
+				 SD20_RX_SEL_MASK, SD20_RX_14_DELAY);
 		break;

 	default:
-		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
-				SD_CFG1, 0x0C, SD_20_MODE);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1, 0x0C, SD_20_MODE);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
-				CRC_FIX_CLK | SD30_VAR_CLK0 | SAMPLE_VAR_CLK1);
-		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD,
-				SD_PUSH_POINT_CTL, 0xFF, 0);
+				 CRC_FIX_CLK | SD30_VAR_CLK0 | SAMPLE_VAR_CLK1);
+		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
+				 SD20_TX_SEL_MASK, SD20_TX_14_AHEAD);
 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
-				SD20_RX_SEL_MASK, SD20_RX_POS_EDGE);
+				 SD20_RX_SEL_MASK, SD20_RX_14_DELAY);
 		break;
 	}

-- 
2.48.1

