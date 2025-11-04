Return-Path: <linux-kernel+bounces-885183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090FC3238A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271DA3B8117
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0933A038;
	Tue,  4 Nov 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="sR/FTJQk"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DD334698
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275766; cv=none; b=hPPIeFlny/uTvjGkcUOwycmdnz/v1qAAHUVpWDHTWrqgOlHaVSmSk/wGSVCVox/4X4as3P1oLX1cnLs5qpY+CkbRyGzKCf2psJ18FYm0CxtAZd4TRob1aELIvCLh83cdgO6clsISh9stwsHcQMEQVwAQf+8TIwxifyClFbg63E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275766; c=relaxed/simple;
	bh=FTxMFO8xGalAHrARCSEc6RGTYHypYqCbfpsw5eH3Om4=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Content-Type; b=S59CBfJGOm5lPZd640hAqm0dBDK74mrt/8VSqV2JsUDlrVeC5kkVrlbuK7oFG+zE2ZlHP7GjLw7tbDQY81N87GpUB9dIR+Kz2Q9RQsSvx3EuWc1KnbAqAqdtAXyRgwo1RlYX3PJCZayqvMTFGs3wypiTX14aJHgMAJlxtTGRTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=sR/FTJQk; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63f97c4eccaso4041704d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1762275762; x=1762880562; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7z4YmMAFCFWvr8KNe1E4XyH7r7ruEqu6RVRoWJgd+ew=;
        b=sR/FTJQkvh9dsSekuXOfSzihf6wiWnumA6BBbhdMnMKa2VBMQPrXzz9xKZYghQiDu1
         ZEx92k64R7Ge1/BQ+oOAg2FuSrMu4kTtbbVAHKBgPakjywxZJ+gXec3E6Uhh02t2cD8U
         XYt4arApaOHmfZBVgqugeQsubfV1jewG9jNYLh9RwXwglmw8FFWwQfAqLvInFfUPZlS1
         P0Kp3FbJ+BNb1o8k7tkd1DPYC1HB0SaZRx4aN2SChLjBQmSGpPVfZ2FS+taumTVw2uir
         NcF9Dzt5Zv/+mEViyV3jxLhXsCrLC1Sk7OPsvHrTL0ZO/LvJhlPKuHr1gbpzgP1Ndkzg
         zdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275762; x=1762880562;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7z4YmMAFCFWvr8KNe1E4XyH7r7ruEqu6RVRoWJgd+ew=;
        b=Rsk1uRBgR3ZWWCYn6EX11A4mlLqnqqssqSAQTP7SdXXWB2fGI59YbWeDlFBj90V3mM
         LzjyPaK71dkOUx5HSEXDghQPo9eADIYEER42sSFrXsHM6CFKhGnGgRKc9s5yhM8gL/xy
         0O8co1+tI3M+hbg4uV9zqWxbvnoy52QNkWDwPXh4qeNsy6hbb61tB/Zj/jLKumH1oc5G
         4Uj8VKiRVa+/9KumF1QLMgHitSYAgDXrwVt2lKp14ba7p4OZdp9Ta28KkB/5Mf974Pt2
         TvFAvNICn0QYqsDCtlo+GzFqcWVtJqN6coC04F/6/7TiX6RBpGx4DPtgxXtTImsuUIeW
         zTcw==
X-Gm-Message-State: AOJu0Yw49+vWy4bXqAsyIFEjm1DIZ4y7/oLutvKangRnzoZwy4GOQwEl
	DGVGT4Hxx2c8004ihOrTUnVlaj7aAqpZjEChi7g/IqlCMs1meC5A7hPe/+d/xWF2+wcefu17d1l
	Uvts+K6wyFisl2174G4Z0Wu7iYoW/TnahmYcaHqfY14JXbs5uMvFHzQ==
X-Gm-Gg: ASbGncuwO0wEATxGFOeQjYGF8AA2CFMBzW/reEyypVuDwKr866/9TDqzn7w7lqUHzp4
	gQvUwYcvseUkbQhbwvrA6gRVxynkX/iSFM/I4p84SepI77E894dqyNIVMc5lxuyJomPXHt8H1N2
	Ke/bSPBFEk4MyX2aSDRB5rRSdoYaO39izcVCJYxelkxZhX576LvOJ5MdbcAoTFhadNoYKugEN1A
	R/lX8pkRJulC7b01q34IyQVQbaIHjtW9lYmnUsfzuxWXP/OXQT3WMX1PahDTQ==
X-Google-Smtp-Source: AGHT+IE52iYp2KC+Z6TCoWXMPh+3n11znG3xcxvSwWyrQmsCjR3X9bc4IYENLwuFfG0icZOdZwo1GM8W1KhQ25ImPkQ=
X-Received: by 2002:a05:690e:c47:b0:63e:102f:e00e with SMTP id
 956f58d0204a3-63fd3572665mr153404d50.53.1762275761369; Tue, 04 Nov 2025
 09:02:41 -0800 (PST)
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:40 -0500
Received: from 239600423368 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Nov 2025 12:02:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 12:02:40 -0500
X-Gm-Features: AWmQ_blhBjqs6hg5upJiZYd7b8UbEecDFsa1gMcCL3PkKggNliBopFcWa_EvYLg
Message-ID: <CABtds-12OYfBo8pS5zZrNp7Rvgifh0jqZ3SyRvoZz+mAVJM3kw@mail.gmail.com>
Subject: [PATCH] drivers/mmc: rtsx_usb: gate UHS/MMC caps on supported
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 2dfdbea7ff59c9f7b4927a8d020810bfb1c11e24 Mon Sep 17 00:00:00 2001
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Nov 2025 16:02:01 +0000
Subject: [PATCH 3/5] drivers/mmc: rtsx_usb: gate UHS/MMC caps on supported
 parts

Only advertise SDR50, DDR50 and MMC DDR when the USB companion reports
support, and treat MMC DDR timing like DDR50 so the host can switch to
that mode safely

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
 drivers/mmc/host/rtsx_usb_sdmmc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c
b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 84674659a84d..e23ef4111dab 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1097,6 +1097,7 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
 		break;

 	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
 		*ddr_mode = true;

 		rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1,
@@ -1161,6 +1162,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 		host->double_clk = false;
 		break;
 	case MMC_TIMING_UHS_DDR50:
+	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_SDR25:
 		host->ssc_depth = SSC_DEPTH_1M;
 		break;
@@ -1343,8 +1345,14 @@ static void rtsx_usb_init_host(struct
rtsx_usb_sdmmc *host)
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34 | MMC_VDD_165_195;
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
-		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |
+		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
 		MMC_CAP_SYNC_RUNTIME_PM;
+	if (host->ucr->supports_sdr50)
+		mmc->caps |= MMC_CAP_UHS_SDR50;
+	if (host->ucr->supports_ddr50)
+		mmc->caps |= MMC_CAP_UHS_DDR50;
+	if (host->ucr->supports_mmc_ddr)
+		mmc->caps |= MMC_CAP_1_8V_DDR;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;

-- 
2.51.0

