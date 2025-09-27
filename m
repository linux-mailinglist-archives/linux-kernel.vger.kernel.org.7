Return-Path: <linux-kernel+bounces-835061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978A4BA6292
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5187D3B4394
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B85235BE8;
	Sat, 27 Sep 2025 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9BsqRKt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E83231836
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758997648; cv=none; b=ixv3tvdA9XcxpAe9FomBIfQRtvIsCaV3QzFHYb6lyy4NPSvEsgOgYz2bJJJssW/4LrQwVvBSWBSrUxIl/z48qIQLVmZcUXWu6HN0FqzSZr6AqropcUqPCH7coHpgNAhHl5AkbJ3f94hGhZFUga6FLQciQlOUm9Bjuxp1rn+6vso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758997648; c=relaxed/simple;
	bh=I22T7JxiFABAm/e5gFk5aHy470m2ilmu3HjJetim2g0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rw9SaRQqruIxgRYVCsoKk6nYJsrpa193+ILjS78uFi2f+WuGjO6aG2bqmLbtfBR9D1kI56Ku0KCk2xKcQuQjwBJVLmpITXXMByz/+idUQFUcYFiy4E3BrRtlKCtF97ivImN6CELZJPPIHC1jAqt/E0QDD8jT8pKuqoT8WkCb/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9BsqRKt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so4819343a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758997644; x=1759602444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQWdFOHyXRj2qTgoQajJtgXcEgv1h3O33kn6+NXzhhk=;
        b=X9BsqRKtZ2PTJ1gkjMtZgwiaaKIYGyytDEY1JTb7CVxtA8KR7MrBFXuAXAhm2RJPRd
         BsQA+/JkGEREzNGs16HM5VWyyRvq1Yt1NcfwMB1H4rtS9EjmkOrnRBoHfrMukF5ETP8e
         cyFAonM/PrPc053zbJtYVekHEgD3LyG6vAhPkJKP+Ycmltaf85wlkmlkJYCVAu+ZSX9p
         QReni86n/VAyKaseXUrXPa5bUy7WnxNHptsppIkynWTz8Ys+u8ZuqOQBBP+oE1vSpxlp
         O5iHQpuN1vRKJ4DFkTFCySWPD99LqV9ULgyP9fW8v+Is8fp62/BSFf3G43/6S3vfQeyd
         CV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758997644; x=1759602444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQWdFOHyXRj2qTgoQajJtgXcEgv1h3O33kn6+NXzhhk=;
        b=HhkhLSSu0IeP6rVJgq6++/kToHds2pZNmJkjRbde+MJK9RczsPME/lS/85KmLeI8zC
         R7L3AbmUFxnG9VOkBO8llw1fB1G6ypNBzh0dJgQMwePVIEKfmbwwS0hVvv/xc8l0g0aw
         zpF4i3SEx4VamfAsUFwovFJ6gptUZe1P/odpePq9RElsxjRCqHJ1ntw5Z7vU7SlXNjd/
         q2EwQ05aezbdVLU6JsdN4DqYnUgjtj7mp6j5p2T6Ixgy/KcUoIT82aC8ZZH/OEXJSGzY
         kp9R9IMv/UXKL0/q/zLr8/L+KiDj3qzZ+22DwWx8vd6g0MAP8OzCeSqAypCA5W30UL6i
         Yd1w==
X-Forwarded-Encrypted: i=1; AJvYcCW3nxlB5/FDmER5hY7elMpH3i6XFAEmiLhgN0wL2oHN55IRre9vK7qOS/BaqxaeE1qi4B6EsMakXzGtoyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmfVkm/91D1BScVj3BdKXf/GBMVWqF+X4VqsZMlvZdrI30zXS
	FnhxABq02f4wnHC+k/yhm+rZcDWiEqrt83jiFh3sBItHSbB6F133h9KD
X-Gm-Gg: ASbGncsgFLGNHDaytNffZwlwUXLXn9pBFP5dJMW/FlVZX6K5dDX/QVgCqrsJYsRQ5Ng
	0oGPb//TeCRoW5UfJheF782f9J8vXyy1CiNkHl6tSALHGGHr66/cLn/7orQwxkHbDMa3IlamwFX
	r8LM6zJEKmWabVGhUarJU1M6irhhL3Lk/Pv+h3JXtFvbtTTZ6kAYrH2lxhzk/kSTCmM7qAekKxO
	EjQESnRyzqwkwCcVkkR/dGjsJGSUzPsyVGvfQXYX+eF1oVddMCmEc2cR5toGzQi4I/YxMMHBIZ9
	uiERPtmcISa/2HrX8QDeC/ez1fSAkYOY7bk64YDEXR0PgkddFdP64nn9KIbYEhngTDflsWE38Pq
	P6LylAj6EjU9SN0RCCP8KxwbvSScikzcu9T0AP0cb7cBiUZ6SO6ElbsGAsZVe0oxfaLqV7nTXRQ
	Ho
X-Google-Smtp-Source: AGHT+IHzU+aiH3IO9AF5z3S6/qnurfmF3lWjYZ8bVEdWvmfo2izIybdRVaH4K3G/J1amzl+E705jog==
X-Received: by 2002:a05:6402:13d2:b0:634:ab36:3c74 with SMTP id 4fb4d7f45d1cf-634ab363ee7mr8188743a12.9.1758997643660;
        Sat, 27 Sep 2025 11:27:23 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-35.web.vodafone.de. [77.25.33.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634bf4a5351sm2691010a12.43.2025.09.27.11.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 11:27:23 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: rtw_hal_set_def_var is not used
Date: Sat, 27 Sep 2025 20:27:00 +0200
Message-ID: <20250927182700.184174-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function rtw_hal_set_def_var is not used. Remove the function and
resulting dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 65 -------------------
 drivers/staging/rtl8723bs/hal/hal_intf.c      |  5 --
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 16 -----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  9 ---
 drivers/staging/rtl8723bs/include/hal_com.h   |  2 -
 drivers/staging/rtl8723bs/include/hal_intf.h  |  2 -
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |  2 -
 7 files changed, 101 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index 07e9d3423651..70b5b289f9cb 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -663,71 +663,6 @@ void GetHwReg(struct adapter *adapter, u8 variable, u8 *val)
 	}
 }
 
-
-
-
-u8 SetHalDefVar(
-	struct adapter *adapter, enum hal_def_variable variable, void *value
-)
-{
-	struct hal_com_data *hal_data = GET_HAL_DATA(adapter);
-	struct dm_odm_t *odm = &(hal_data->odmpriv);
-	u8 bResult = _SUCCESS;
-
-	switch (variable) {
-	case HW_DEF_ODM_DBG_FLAG:
-		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_COMP, *((u64 *)value));
-		break;
-	case HW_DEF_ODM_DBG_LEVEL:
-		ODM_CmnInfoUpdate(odm, ODM_CMNINFO_DBG_LEVEL, *((u32 *)value));
-		break;
-	case HAL_DEF_DBG_DM_FUNC:
-	{
-		u8 dm_func = *((u8 *)value);
-		struct dm_priv *dm = &hal_data->dmpriv;
-
-		if (dm_func == 0) { /* disable all dynamic func */
-			odm->SupportAbility = DYNAMIC_FUNC_DISABLE;
-		} else if (dm_func == 1) {/* disable DIG */
-			odm->SupportAbility  &= (~DYNAMIC_BB_DIG);
-		} else if (dm_func == 2) {/* disable High power */
-			odm->SupportAbility  &= (~DYNAMIC_BB_DYNAMIC_TXPWR);
-		} else if (dm_func == 3) {/* disable tx power tracking */
-			odm->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
-		} else if (dm_func == 4) {/* disable BT coexistence */
-			dm->DMFlag &= (~DYNAMIC_FUNC_BT);
-		} else if (dm_func == 5) {/* disable antenna diversity */
-			odm->SupportAbility  &= (~DYNAMIC_BB_ANT_DIV);
-		} else if (dm_func == 6) {/* turn on all dynamic func */
-			if (!(odm->SupportAbility  & DYNAMIC_BB_DIG)) {
-				struct dig_t	*pDigTable = &odm->DM_DigTable;
-				pDigTable->CurIGValue = rtw_read8(adapter, 0xc50);
-			}
-			dm->DMFlag |= DYNAMIC_FUNC_BT;
-			odm->SupportAbility = DYNAMIC_ALL_FUNC_ENABLE;
-		}
-	}
-		break;
-	case HAL_DEF_DBG_DUMP_RXPKT:
-		hal_data->bDumpRxPkt = *((u8 *)value);
-		break;
-	case HAL_DEF_DBG_DUMP_TXPKT:
-		hal_data->bDumpTxPkt = *((u8 *)value);
-		break;
-	case HAL_DEF_ANT_DETECT:
-		hal_data->AntDetection = *((u8 *)value);
-		break;
-	default:
-		netdev_dbg(adapter->pnetdev,
-			   "%s: [WARNING] HAL_DEF_VARIABLE(%d) not defined!\n",
-			   __func__, variable);
-		bResult = _FAIL;
-		break;
-	}
-
-	return bResult;
-}
-
 u8 GetHalDefVar(
 	struct adapter *adapter, enum hal_def_variable variable, void *value
 )
diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 961b0563951d..462553d296ff 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -115,11 +115,6 @@ void rtw_hal_set_hwreg_with_buf(struct adapter *padapter, u8 variable, u8 *pbuf,
 	SetHwRegWithBuf8723B(padapter, variable, pbuf, len);
 }
 
-u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
-{
-	return SetHalDefVar8723BSDIO(padapter, eVariable, pValue);
-}
-
 u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue)
 {
 	return GetHalDefVar8723BSDIO(padapter, eVariable, pValue);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 18244adad9e0..57c83f332e74 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2839,22 +2839,6 @@ void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 	}
 }
 
-/* Description:
- *	Change default setting of specified variable.
- */
-u8 SetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable, void *pval)
-{
-	u8 bResult = _SUCCESS;
-
-	switch (variable) {
-	default:
-		bResult = SetHalDefVar(padapter, variable, pval);
-		break;
-	}
-
-	return bResult;
-}
-
 /* Description:
  *	Query setting of specified variable.
  */
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index 7fcb874d0eb3..6f1f726d1630 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -1236,12 +1236,3 @@ u8 GetHalDefVar8723BSDIO(
 
 	return bResult;
 }
-
-/*  */
-/* 	Description: */
-/* 		Change default setting of specified variable. */
-/*  */
-u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
-{
-	return SetHalDefVar8723B(Adapter, eVariable, pValue);
-}
diff --git a/drivers/staging/rtl8723bs/include/hal_com.h b/drivers/staging/rtl8723bs/include/hal_com.h
index 7ea9ee2b3975..74d6c892c401 100644
--- a/drivers/staging/rtl8723bs/include/hal_com.h
+++ b/drivers/staging/rtl8723bs/include/hal_com.h
@@ -138,8 +138,6 @@ void SetHwReg(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg(struct adapter *padapter, u8 variable, u8 *val);
 void rtw_hal_check_rxfifo_full(struct adapter *adapter);
 
-u8 SetHalDefVar(struct adapter *adapter, enum hal_def_variable variable,
-		void *value);
 u8 GetHalDefVar(struct adapter *adapter, enum hal_def_variable variable,
 		void *value);
 
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index 2fa2382ad5f3..82b60899129d 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -199,7 +199,6 @@ void rtw_hal_chip_configure(struct adapter *padapter);
 void rtw_hal_read_chip_info(struct adapter *padapter);
 void rtw_hal_read_chip_version(struct adapter *padapter);
 
-u8 rtw_hal_set_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 u8 rtw_hal_get_def_var(struct adapter *padapter, enum hal_def_variable eVariable, void *pValue);
 
 void rtw_hal_set_odm_var(struct adapter *padapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet);
@@ -262,7 +261,6 @@ void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val);
 void SetHwRegWithBuf8723B(struct adapter *padapter, u8 variable, u8 *pbuf, int len);
 u8 GetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
-u8 SetHalDefVar8723BSDIO(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level);
 void rtl8723b_SetBeaconRelatedRegisters(struct adapter *padapter);
 void Hal_EfusePowerSwitch(struct adapter *padapter, u8 PwrState);
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index 2ed1fc8549ec..06e0a549fa9d 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -223,8 +223,6 @@ void C2HPacketHandler_8723B(struct adapter *padapter, u8 *pbuffer, u16 length);
 
 void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val);
 void GetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val);
-u8 SetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable,
-		     void *pval);
 u8 GetHalDefVar8723B(struct adapter *padapter, enum hal_def_variable variable,
 		     void *pval);
 
-- 
2.51.0


