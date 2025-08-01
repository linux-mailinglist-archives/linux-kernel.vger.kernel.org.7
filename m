Return-Path: <linux-kernel+bounces-753077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3960DB17E5D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA613AB296
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CB229B38;
	Fri,  1 Aug 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB3YL2FN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE92236E3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037166; cv=none; b=SR3CmP3UMz7vs0IYmvG73CZNKhGNFmHQvQrxsZaKaavpmNgxevuuTWyhPr5jF+dcOyuLvNVNBpnsi4Ou9qJ0XZyzBXFJLpNu023Os5cl77X1GuS/te2KKziTlHUyfK10lRe6FtBswxuzycyr2hWD/baMWxcl2pIo8kOXGtaZlVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037166; c=relaxed/simple;
	bh=FMIUakQSKLWOnogEyddNVDBaxSVMMCzVFcBzoICkKek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvEXyNT5szrkMocHgqNxXFzdE1ivJO9vSkA7MjSDL6xMTpkqDmJgA6aH3xVG6fwW0Fb5hDdpIhaSX5bCTsKeS3kSNFmqjiREEG0OoDQIY7fX25htrAJc49DkrJtXRsja3vH2DPESkHVCRk9LwkO6CTeD6iJJ6MxOjzssmE2ikls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB3YL2FN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so2616620a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037163; x=1754641963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2onPGbHFtOLNzYANYUg22nvBv6obu2eVACcu780+yPI=;
        b=NB3YL2FNO7k8Vep6l66HpNO4uD1Zs7+676kGpRZPumLNeultTc/FlClbNIUfqiuUAR
         dGGmNPkhyFDaFsAdPFyaTg53t9AufyVOiB0iXaxqCh4s6w6qGWiJvs9pom2gQNkCzALq
         amZaa8ogYseZw1earOo293fXJRC4dhDmAJS9+74l82FXBhW6xsphOhsHk3B2MV+Dm61r
         2MSrMio56tCe/n9ZuruJsctjjsN8/Q1FnuNYoli1Bk2JbTed20o7nKU4QRGXuHF/nsrQ
         alXFnUFmVuragtrmY5lOg5vYPON6p3gG6Yexx21fRf9jEOAP5aCD/fTWvYui51XgyefD
         m+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037163; x=1754641963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2onPGbHFtOLNzYANYUg22nvBv6obu2eVACcu780+yPI=;
        b=NcGHnC54LktrkeaBK0eNLRVQG6dYVkyHe7WBwjRQ98g5GbGZEbVhjzOA71JkbwKtL+
         W5KAN15+nfqTh9fgh3A8pQWOSvy2wtLLlL4SIAyBRH2r+lf3KwFu/g/42IxY4DR6wvxj
         GDOejEFn/mR+QrHNW9T/rLhYbGre9oFbadOeyC0ZVaS09wKJSmm0aQ1Auyd1n0b8scnG
         TkpNKPQhkDPGT+fL/C+fkSwCNXOZFxc8bhzV38TwkfvGkUK1wiffvuCs1Z7/wYsicLn8
         rkAnmE3B8JQjKzuizZOiLBG32HSbfouqgMtSXiC6vL9BHOO5BSzbRJdtgIRWWotEmyOA
         AjvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEv2R84J3xB8p2R4tnvGH1ZN5mT84o1v4EkbLWdD4Wa1GIp+HuSqLTq53iL6XqJwRYaZ0AW4nAJXjgtl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyglf1nRrtNOduCgS7iI5yBZ0u/J0TFkXASAMSjYrEDVmzYf1f
	fDQM41GMc4xtWkO2CqKL/q+oTpVq/3D8b/BkLTEfEusZkAqtF2xKLoc9
X-Gm-Gg: ASbGncuOwbBa/nK89Q7vnegznHYkFzpCmVKBC+s/uuLilvMOTDxZuXU9l4hgj9i4OEu
	c6iv1pusI606o6VGthzl0P3JRTXoDxgjMjuww65RUqPL0AqlqoONal+VIWjtYj0Uu5O3yHK3b/j
	oeJl+2ifOYDz1T2u/s83o9z7gwxImIDjpZTU7pF0xb6jnPVTKIY3S9dAQrWKv0ibeM8UayqUmmV
	P1fIxf/XMbzmWieP7MWM31bMTX7Zx4NUwRRNrGJtQtyCgqhieUjuqR3uXDiAvC+uOrGe7Kt3Ld7
	gJE3UlEFGpkH/jt9SHaHAwJq63tJFtTB/PDdIs3auzsqcTN0iNN/0CgrapsNcShMbPbO2qjjybQ
	Oq1mjODgCOIzb0jVieODSClkrG1bbeaDV/ULTJiL8/Nfpz1EIPI/5lssSrMJoLA==
X-Google-Smtp-Source: AGHT+IG9Hl6jL80/ej1OiTE+v72RAZtbDeDDG6cYH8dWMac1qZxeD3bRaCW0Cat7/5EFvSCZeScwyg==
X-Received: by 2002:a05:6402:5cb:b0:612:b9bf:2a56 with SMTP id 4fb4d7f45d1cf-615871ba1c9mr10039662a12.21.1754037162382;
        Fri, 01 Aug 2025 01:32:42 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:41 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 8/8] staging: rtl8723bs: move rtw_reset_securitypriv to core/rtw_mlme.c
Date: Fri,  1 Aug 2025 10:31:31 +0200
Message-ID: <20250801083131.82915-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801083131.82915-1-straube.linux@gmail.com>
References: <20250801083131.82915-1-straube.linux@gmail.com>
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
v1 -> v2: no changes

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
index 4c816fb2500b..84984de45788 100644
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


