Return-Path: <linux-kernel+bounces-750595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67669B15E74
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5895A46D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AE299950;
	Wed, 30 Jul 2025 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ijtjfvks"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3B2980AC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872318; cv=none; b=Rf5f32jpBl/8ka+SCR9x9VxgBso9CG8vL6iAiLYb1DPvCMqrg38BxSxXl3YXLHnCNNnSoqN0svqC+5NCMCFvgW/hHXA7VimQ0O38Ns1ILf3fjV4G229tD7R95quovBersG/s0MPEbAYWZSGgmMigAO7lZffhK6m8JNsmXgRc0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872318; c=relaxed/simple;
	bh=zMYDgD1v9PbcRgvlt7dYWThewO6Q4BQc0fqBmXE/dmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r02yVbLSvO1oCptShpvfl+8ENyIh8BYsf2thyZN5uSJvBguqtSIxK5SFNqhMXr6srYlKFk6noqxXt/xKmUKc9JBpAC0lDJseU8YfPbIEcNvOZjviVyqyhnnr4biP1/kzZuzTDFww+Y6RAbknhrPlVnO4mxsjFH8U1lsBz5wQHcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ijtjfvks; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso6107077a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872314; x=1754477114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Orl0dxFN5prrJRMhCNo44wNjAVEDhcd1qwh2pT3Fzc=;
        b=Ijtjfvks8xtS+5BwZm9XB/lYS0kaH0370HYACHGkwKNSWfl5i10xUgeBY5Ry4QpPYF
         VYONZCHTQMkpopZeIb6ZtWzfpK5qwAYql1YX1ukTmpuVZbVh9NosmDZEcOyaNnY0po+e
         73TqMOQtncfb3xH+2dkVIQyRSZvaZ/fDzQ/kXdUNDNHpZwf7lW3mZxkvn7vN0t0XVcyE
         pzWC2jdHm9Xka/YAO6pPhV4PqLGwcqoPXcVmGO1MA0mqG2GzIZb2+EHkl8RqvmADCuZV
         hoUJvFP3M/NVSsaE0BFqo73msqpLwsCG/3pY+I+RhyXh4/GOU/MSpHVbTQnerSjabPyh
         ifFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872314; x=1754477114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Orl0dxFN5prrJRMhCNo44wNjAVEDhcd1qwh2pT3Fzc=;
        b=BRY8dJtNIxFS1xcv9zaO36LrtfQ8tLtRj8QMC11gP3pcQQivoyt23bLADDQ9A0VrGR
         es9HrjPU7tICCulxkUZElTYVujPvObKdjsMqlALjgEMZ6EcCQDVcx1uz/o5EGql7zdgJ
         WJ8HkYv1P2PPim952lcXfOtfHKOlWEFsTzbObQg2Ly6fc+8+k0V2yvjHgeXmcn/KvtT1
         yqIgs8l20o9bl00ifKzlRX59vCtGFobAej/YjMDh3rml2lEvbw2XyyJPMqG7XsOLczrA
         4Hf9l5a0W15Lf/b1bfRtfYDByDtC26fTk/e3R0skFsW6dVsM24Lf7vAv6hh6QFxgHho+
         9m9g==
X-Forwarded-Encrypted: i=1; AJvYcCWXzz9lgHS6AA1nXRl+3lhDgleb7VMrU9EstvD9DKuEarzqyQIYkvJLc+axAh+f+35+YI769ug1el2PlAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxigDtFWT/0xePGN502eVE6QWESiuKpLZbUtdJpzxuv67NwBCMW
	fCvXJcFaBMVzOeU8mEPTDjVgUNE7hftMzsR0g9DCp/QcjhM3C5L96FLK
X-Gm-Gg: ASbGncuKD1K8aNumyObd7foraGutweVs80QR59LyM0fcKPjtT776almAPcijtcHpnU+
	r5r0RBHvWOcjga7LohEch1x3j+M4eug1mASU4cREmzUJuoqC+viRqX3FjOxXHh8nBLflRDY5ZbM
	T7KhkABj80178TsJUE/AIcmKtGd7wJxeWcAAGnghKai42n9yT4cmvV+MYXn5ttJGa9SQVpmbQdm
	OGImx7eqsv8dDkL48niGQdbx+y/uX2AB3/R3qfnxlb+k1F83KGmBzQGa/9+tnW7UXxEbOXv239o
	DyQAl8qKfVSEGlTk9Z587pPlw7EmNI33hCCNOzLO4cI+oZTB7n/zWK/O9Ot13GY+9LbQaD7pfLX
	mz980RMfSGdM+fC9rEp78JBWGN+pXI76gsP4HtJrNh3jZZ7AgGorV4J1b
X-Google-Smtp-Source: AGHT+IHulO8SbF+m+xqs94001tnJHzK4YfZ6e4AqFOBfQddGkX20d5N5vga3aLzI/716AKlWIiQMHQ==
X-Received: by 2002:a50:9fec:0:b0:609:a91:87e with SMTP id 4fb4d7f45d1cf-61586eef919mr1936150a12.1.1753872313417;
        Wed, 30 Jul 2025 03:45:13 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:13 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8723bs: move rtw_reset_securitypriv to core/rtw_mlme.c
Date: Wed, 30 Jul 2025 12:45:01 +0200
Message-ID: <20250730104501.150270-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730104501.150270-1-straube.linux@gmail.com>
References: <20250730104501.150270-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the function rtw_reset_securitypriv from os_dep/mlme_linux.c to
core/rtw_mlme.c to reduce code in the os_dep directory.

The file os_dep/mlme_linux.c is finally empty now and we can remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile            |  1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 60 +++++++++++++++++
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 .../staging/rtl8723bs/include/mlme_osdep.h    | 13 ----
 drivers/staging/rtl8723bs/include/rtw_mlme.h  |  1 +
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 67 -------------------
 6 files changed, 61 insertions(+), 82 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/mlme_osdep.h
 delete mode 100644 drivers/staging/rtl8723bs/os_dep/mlme_linux.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index 8560b84a3146..19c0525ec3e0 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -48,7 +48,6 @@ r8723bs-y = \
 		hal/HalHWImg8723B_RF.o \
 		hal/HalPhyRf_8723B.o \
 		os_dep/ioctl_cfg80211.o \
-		os_dep/mlme_linux.o \
 		os_dep/osdep_service.o \
 		os_dep/os_intfs.o \
 		os_dep/recv_linux.o \
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 1c720947955e..69b64d605186 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1116,6 +1116,66 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	rtw_update_ht_cap(padapter, cur_network->network.ies, cur_network->network.ie_length, (u8) cur_network->network.configuration.ds_config);
 }
 
+static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
+void rtw_reset_securitypriv(struct adapter *adapter)
+{
+	u8 backupPMKIDIndex = 0;
+	u8 backupTKIPCountermeasure = 0x00;
+	u32 backupTKIPcountermeasure_time = 0;
+	/*  add for CONFIG_IEEE80211W, none 11w also can use */
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
+
+	spin_lock_bh(&adapter->security_key_mutex);
+
+	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
+		/* 802.1x */
+		/*  Added by Albert 2009/02/18 */
+		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
+		/*  */
+		/*  Backup the btkip_countermeasure information. */
+		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
+
+		memcpy(&backupPMKIDList[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		backupPMKIDIndex = adapter->securitypriv.PMKIDIndex;
+		backupTKIPCountermeasure = adapter->securitypriv.btkip_countermeasure;
+		backupTKIPcountermeasure_time = adapter->securitypriv.btkip_countermeasure_time;
+
+		/* reset RX BIP packet number */
+		pmlmeext->mgnt_80211w_IPN_rx = 0;
+
+		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
+
+		/*  Added by Albert 2009/02/18 */
+		/*  Restore the PMK information to securitypriv structure for the following connection. */
+		memcpy(&adapter->securitypriv.PMKIDList[0], &backupPMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
+		adapter->securitypriv.PMKIDIndex = backupPMKIDIndex;
+		adapter->securitypriv.btkip_countermeasure = backupTKIPCountermeasure;
+		adapter->securitypriv.btkip_countermeasure_time = backupTKIPcountermeasure_time;
+
+		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
+		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
+
+	} else {
+		/* reset values in securitypriv */
+		/* if (adapter->mlmepriv.fw_state & WIFI_STATION_STATE) */
+		/*  */
+		struct security_priv *psec_priv = &adapter->securitypriv;
+
+		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;  /* open system */
+		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
+		psec_priv->dot11PrivacyKeyIndex = 0;
+
+		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
+		psec_priv->dot118021XGrpKeyid = 1;
+
+		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
+		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
+		/*  */
+	}
+	/*  add for CONFIG_IEEE80211W, none 11w also can use */
+	spin_unlock_bh(&adapter->security_key_mutex);
+}
+
 /* Notes: the function could be > passive_level (the same context as Rx tasklet) */
 /* pnetwork : returns from rtw_joinbss_event_callback */
 /* ptarget_wlan: found from scanned_queue */
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 080c321665c0..f1c16ddacc83 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -40,7 +40,6 @@
 #include <rtw_qos.h>
 #include <rtw_pwrctrl.h>
 #include <rtw_mlme.h>
-#include <mlme_osdep.h>
 #include <rtw_io.h>
 #include <rtw_ioctl_set.h>
 #include <osdep_intf.h>
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
deleted file mode 100644
index 3930d9e6dab7..000000000000
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#ifndef	__MLME_OSDEP_H_
-#define __MLME_OSDEP_H_
-
-
-void rtw_reset_securitypriv(struct adapter *adapter);
-
-#endif	/* _MLME_OSDEP_H_ */
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme.h b/drivers/staging/rtl8723bs/include/rtw_mlme.h
index 3cf68b85eb32..4c15d0194d4f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme.h
@@ -395,5 +395,6 @@ u8 rtw_to_roam(struct adapter *adapter);
 int rtw_select_roaming_candidate(struct mlme_priv *pmlmepriv);
 
 void rtw_sta_media_status_rpt(struct adapter *adapter, struct sta_info *psta, u32 mstatus);
+void rtw_reset_securitypriv(struct adapter *adapter);
 
 #endif /* __RTL871X_MLME_H_ */
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
deleted file mode 100644
index 918d9496d7cc..000000000000
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#include <drv_types.h>
-
-static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
-void rtw_reset_securitypriv(struct adapter *adapter)
-{
-	u8 backupPMKIDIndex = 0;
-	u8 backupTKIPCountermeasure = 0x00;
-	u32 backupTKIPcountermeasure_time = 0;
-	/*  add for CONFIG_IEEE80211W, none 11w also can use */
-	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
-
-	spin_lock_bh(&adapter->security_key_mutex);
-
-	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
-		/* 802.1x */
-		/*  Added by Albert 2009/02/18 */
-		/*  We have to backup the PMK information for WiFi PMK Caching test item. */
-		/*  */
-		/*  Backup the btkip_countermeasure information. */
-		/*  When the countermeasure is trigger, the driver have to disconnect with AP for 60 seconds. */
-
-		memcpy(&backupPMKIDList[0], &adapter->securitypriv.PMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		backupPMKIDIndex = adapter->securitypriv.PMKIDIndex;
-		backupTKIPCountermeasure = adapter->securitypriv.btkip_countermeasure;
-		backupTKIPcountermeasure_time = adapter->securitypriv.btkip_countermeasure_time;
-
-		/* reset RX BIP packet number */
-		pmlmeext->mgnt_80211w_IPN_rx = 0;
-
-		memset((unsigned char *)&adapter->securitypriv, 0, sizeof(struct security_priv));
-
-		/*  Added by Albert 2009/02/18 */
-		/*  Restore the PMK information to securitypriv structure for the following connection. */
-		memcpy(&adapter->securitypriv.PMKIDList[0], &backupPMKIDList[0], sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-		adapter->securitypriv.PMKIDIndex = backupPMKIDIndex;
-		adapter->securitypriv.btkip_countermeasure = backupTKIPCountermeasure;
-		adapter->securitypriv.btkip_countermeasure_time = backupTKIPcountermeasure_time;
-
-		adapter->securitypriv.ndisauthtype = Ndis802_11AuthModeOpen;
-		adapter->securitypriv.ndisencryptstatus = Ndis802_11WEPDisabled;
-
-	} else {
-		/* reset values in securitypriv */
-		/* if (adapter->mlmepriv.fw_state & WIFI_STATION_STATE) */
-		/*  */
-		struct security_priv *psec_priv = &adapter->securitypriv;
-
-		psec_priv->dot11AuthAlgrthm = dot11AuthAlgrthm_Open;  /* open system */
-		psec_priv->dot11PrivacyAlgrthm = _NO_PRIVACY_;
-		psec_priv->dot11PrivacyKeyIndex = 0;
-
-		psec_priv->dot118021XGrpPrivacy = _NO_PRIVACY_;
-		psec_priv->dot118021XGrpKeyid = 1;
-
-		psec_priv->ndisauthtype = Ndis802_11AuthModeOpen;
-		psec_priv->ndisencryptstatus = Ndis802_11WEPDisabled;
-		/*  */
-	}
-	/*  add for CONFIG_IEEE80211W, none 11w also can use */
-	spin_unlock_bh(&adapter->security_key_mutex);
-}
-- 
2.50.1


