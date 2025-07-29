Return-Path: <linux-kernel+bounces-749501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18185B14F20
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD13016EC87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005E1E1A3F;
	Tue, 29 Jul 2025 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNV2l+B3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BEA1CDFD5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798410; cv=none; b=RVDEjvL9Ys2xPjEq4UrvnZ0tKtfP/u7qLgHHRyBCFiac3XyLUVfZ+QKP+mt8meR9JN+ltHoCu/Qoo+fv3DTEzhmYIQVbHK8sAIX2DvVfRcY07Bq/lwh/zSI7UMcm2V1m98rQGuueyYjdijH2qoyV4oWH59IodpmzvVSzlNMMzt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798410; c=relaxed/simple;
	bh=FjA+c9Z3l+4QM+NHVNGoenTDXDVzESzeLLANK4ezG8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWhrbmv1/A1x0tk7hER2TTtgxmniwN4yPhkaJ4ZbE+5z/Ox/SYXfwcCsio0VEqfqhw8c25jxTNe9hB59PYVGvb8LH/LS1ScmeWj/LVtaJDzuiQPlJDG3tARFUdrl6ITRH3N3ggCcmxtn1s9dgqbNsAajFuEzsRWnWp0p1u3kZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNV2l+B3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24031a3e05cso8625545ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753798408; x=1754403208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yitw0gBISuOZ2v41sPRu4k5vKVXgFczbihRYKhefvpk=;
        b=BNV2l+B3h+IonYv8CbtOxZuSWdsbn5d/IOMsrF+wc8SPzM+EGS6iJQz/uWdDhR4uu8
         +5ZrFwdpoC57g/794FJzJj+bfP01uoxdEAPM4xh5JdF7m/28ZayqMY5lvwWlTKqPXPbs
         gya5Qta/hD/QpL+/BcVZlbMBGJYZzAzqsVFYX7dSj2n4I+QtQbSkL8ZVYd1kxBKedi9+
         rSurpwC6ENEWnql7AO90YqgawaCATuGRVl8naCgf4hDml1rd2JmSwFgMUqElnXLkJGdQ
         zPvHQvqnjoYIYlYnnzdBRyQRlh9v3xyif6w+6vRal2SQcLGYpLYwmwv8Qxl6pEfcbKAr
         OXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798408; x=1754403208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yitw0gBISuOZ2v41sPRu4k5vKVXgFczbihRYKhefvpk=;
        b=Zfmy9n3X6bH44krYTzOCAe6pLC75sN40jlxwnb8vWtpXTxIVuViGAlLsMaEdYzTud2
         Ul8XcsXKkd4LTNjO73Y8TM5nqipzmNudxdtoS3IfZ47H1AExfk6L/QRk2hF6WLslYqn8
         vG7UR+0MnTwnBj3PRdg1baOQVlHsleyCEFNvhgf8wGcSsJOnfN+W85qgF8khDBi8Z/Xp
         uV6JpLb7P4DfzJdBbfBsFpc3wbeANTBWHP/WiB6Jy5x9HZSOHWIhpxa0h5RN2a1zHFCR
         /CopH5KFkQOkbNjKok1LZ+cq7itc9uEND4XAvrkMyXEY2PB2zKzPdGEcWNYxCHzaw5Yv
         ut2w==
X-Forwarded-Encrypted: i=1; AJvYcCVR1FxjeCHycul/RGE08AqCoZyG/ivRAss5wq0hQF2ygzNwSjdPX2RFclZQgtendJlzL11GXyu2Eneic3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP294k57T05xs/Q0uCutHj7ws+4bSVkq2gLtZwQVizThIW6FZL
	GyZoDcrMeNq7T206t7tLrw3Oybk1FviIN84Hn+entrR0GIq5D14hM58s
X-Gm-Gg: ASbGncuL/8+ffw16mpM2srfQUGVldU2Mn7/uizBCCaxNbXoMoXwN98eeeoFtuS87BWi
	HIjFuiO6S7JDgpYjA/3fwyGAisPyaWYa7mwI2sMDsPLcffYneMvK5Y+V/F1BvvLFqqhrS/CvuiO
	/c5XnA1UlW1Hl2meqZ+I5+MbaEJ9Mn2skOL3Ptev58ZFmtxiR+8pwuRFu5WoPurupX7EBaApWr0
	fTE7u6Iep2z+AiVvJi1tCJtBsqRu3Kyzr4IwM60Ws8R4FdiydqOjtnEBlYwQL+4B9NisfmK83jE
	R0mITVucr9LxnugbZ3HyjBOlesp94EwwEzzZZpdwIabhAcqsJmjWqWRtTmTQgd704auT69dALmH
	e6vxBtyw3v644e5VqHOG9BS1H1v8CjA7a8w==
X-Google-Smtp-Source: AGHT+IEh8uGgxD/fdfhuPyfTdSWJ4/hYFFr9SgxPTOKH4o1yLWj1vXkRgP+kd9clAvFUmaIRreFW3g==
X-Received: by 2002:a17:903:298b:b0:23f:fa47:f933 with SMTP id d9443c01a7336-24063cd35b2mr53089125ad.8.1753798407855;
        Tue, 29 Jul 2025 07:13:27 -0700 (PDT)
Received: from localhost ([2409:4089:1091:3d13:b803:71:1df8:9600])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-240469a8084sm36273345ad.79.2025.07.29.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:13:27 -0700 (PDT)
From: ashirvadm04@gmail.com
To: gregkh@linuxfoundation.org
Cc: philipp.g.hortmann@gmail.com,
	dan.carpenter@linaro.org,
	sayyad.abid16@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ashirvad Mohanty <ashirvadm04@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Replace magic numbers in rtl8723b_InitBeaconParameters
Date: Tue, 29 Jul 2025 19:42:10 +0530
Message-ID: <20250729141224.16013-1-ashirvadm04@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashirvad Mohanty <ashirvadm04@gmail.com>

Replace magic numbers 0x6404 and 0x660F in rtl8723b_InitBeaconParameters
with macros TBTT_PROHIBIT_TIME_8723B and BCN_AIFS_CFG_8723B, respectively,
defined in rtl8723b_hal.h. This addresses the TODO to remove magic numbers,
improving code readability and maintainability per Linux kernel coding style.

Signed-off-by: Ashirvad Mohanty <ashirvadm04@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 ++---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h  | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 893cab0532ed..d6c75854f27a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1197,8 +1197,7 @@ void rtl8723b_InitBeaconParameters(struct adapter *padapter)
 
 	rtw_write16(padapter, REG_BCN_CTRL, val16);
 
-	/*  TODO: Remove these magic number */
-	rtw_write16(padapter, REG_TBTT_PROHIBIT, 0x6404);/*  ms */
+	rtw_write16(padapter, REG_TBTT_PROHIBIT, TBTT_PROHIBIT_TIME_8723B); /*  ms */
 	/*  Firmware will control REG_DRVERLYINT when power saving is enable, */
 	/*  so don't set this register on STA mode. */
 	if (check_fwstate(&padapter->mlmepriv, WIFI_STATION_STATE) == false)
@@ -1207,7 +1206,7 @@ void rtl8723b_InitBeaconParameters(struct adapter *padapter)
 
 	/*  Suggested by designer timchen. Change beacon AIFS to the largest number */
 	/*  because test chip does not contension before sending beacon. by tynli. 2009.11.03 */
-	rtw_write16(padapter, REG_BCNTCFG, 0x660F);
+	rtw_write16(padapter, REG_BCNTCFG, BCN_AIFS_CFG_8723B);
 
 	pHalData->RegBcnCtrlVal = rtw_read8(padapter, REG_BCN_CTRL);
 	pHalData->RegTxPause = rtw_read8(padapter, REG_TXPAUSE);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index a4a14474c35d..5b4e303e20eb 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -71,6 +71,8 @@ struct rt_firmware_hdr {
 
 #define DRIVER_EARLY_INT_TIME_8723B  0x05
 #define BCN_DMA_ATIME_INT_TIME_8723B 0x02
+#define TBTT_PROHIBIT_TIME_8723B     0x6404
+#define BCN_AIFS_CFG_8723B           0x660F
 
 /* for 8723B */
 /* TX 32K, RX 16K, Page size 128B for TX, 8B for RX */
-- 
2.43.0


