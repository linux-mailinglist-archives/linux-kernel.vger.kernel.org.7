Return-Path: <linux-kernel+bounces-753075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22197B17E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CF21C28220
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50066223707;
	Fri,  1 Aug 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYwvI4V9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B702206B2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754037163; cv=none; b=I3EmEZ/jGY2iXMdSNu6uggtdVEWfQenbRMJ8zskTaILdIcgK3oeHVNjGHQYuE7kTKbjhOkoONRAmy/7nryBljqA7i4UIioUYqA229OIobvZfPESk4OnRZa35740y34FaanNw2n8UE4iuctE5tkVuknLNJmH3bc19p+WZaYj4OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754037163; c=relaxed/simple;
	bh=u4ILaCmJ1NI7frw+wzMCZE2/gYH+BzJEYUtfuQsAqfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7cx153C2/Ky9EEyKwRJAKK6LIL5FYGpG2O/Gsn+CRwTXJ6X0q/Sse+wCDkrY3m4Fah14/deAXh9FSmjmHYE7rqGIvBObMfQWChdlqpCbTxHaKyQldUKCSBZ4TTs8JEJX/8SjGP64QkTpkQNEJyw3Tc+qhkpI89PDF+0iULmCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYwvI4V9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so2644677a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754037160; x=1754641960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTHDESjkBUS6IAMRUedeGkKS6hmPI5IEjbKpB43coI8=;
        b=cYwvI4V9gv52KFtdipcNSGXzN5lvMxacfGGAr54lAlELBPwBmzC3bBVWiZNVLFjZBl
         rMcp7LuTqQQOLfISrbw60JSS8FusMXn3fr1V2uNOElNaXAqMEff24ChIGUL3YDE742iN
         noAjisTDTQa/gnXLHixd4x+vwDRjKRleVUuUQYNwtO8IfTGYSHyci20qV8rUTZNP8dYQ
         O/SxxkGEL6BlIK+R+jy0FPMFcGScHkhugolOkiKaLfYIDk1td6KYPOtvq+UcivxBubAa
         JIOlYC/JEa5sKSYOpOSoroTN6xV3gaXhj6Mbc+LI75KStzIC4EEZoK2RkW7PgLGaZtpa
         OD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754037160; x=1754641960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTHDESjkBUS6IAMRUedeGkKS6hmPI5IEjbKpB43coI8=;
        b=q0AxpauLCXFlPc9nXw3HRjRfG2vLW+xqUBklXForfcqnxwitcGBG6UHM9sPXR5ek+z
         hCAV4T85U83MZt2/duJy4qEs4z+itHZDspRdY1NUbErJDgYBpdLGTMFQmyK1HhOOZx3j
         g+V/4lJ9T+0lXTAmiD4tJ2pCx4sH7Q07jXIqzXBg37Bc//gUXkTrTdbXVumu5kInwosd
         uivL1jAg6TY1CBJ7bqP0lH+WneICDDU6tc4eckcXhQ/n5Za41xws46AjXKH5Zac2DwUi
         Xw4yHRvCUAxbY4htPxGRKEwMOKQA8eSfxWjgH0wNrWbH9zjfMqCZiRIDC3LT4+rDN/+x
         PeSA==
X-Forwarded-Encrypted: i=1; AJvYcCVkTnlyjzHebSkgm1zcbsmRWDbNCTUqUy0IKQoAv+PmlI1CMvdyjMFVfl7PJf+Hf1ya120KiHF3k0cQlk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrMhWsQVLBQ1Q3UkTouGmMOnnSy+qQm0zxWyQz/rcbPuW2C/hl
	4LI6aRUGeatctCUSQw0QIV2GC6Dhc6DmSjjBaD0tiK7uMnIOwVqe29+X
X-Gm-Gg: ASbGncvRoA3DbPqmxyfYc1Q/4FOH+yN2tNqcx9gLEh5tkvk3wtWWsDdtMDEtnjtnqIX
	b2EGBm6QdWhZKpjgI5cfilWbbbADlhBrRotfczk2BJjmwKXY1R1MngWtzFnxID660saXFUWbXlj
	eVjxh9ZfVdumZYsqpIptkNH2Nvhjgcsbj+FuA/Wc0BLWdr41DMQ6So9uLlPpkoid9bo//MdyZmi
	/vSsMOk9GDA3RHRzyX30KH5GsNPJXJrcrM5Etx4wjRcOaNAQAgGMhpAtLDIny6+KiR9vr1Qk/Tf
	qM4hBplLlhJTd/tzpFVd3cCgoT3/dbyQPjg9AzH17c98dVnXvLzw09otJtPQyWffLy51QeQ1hV0
	ua25KxcbCZnGRqw4kwBkDdmenhEa4fjmHadDnzZJtf0R28ZybV9aNK3/Qq9+vJg==
X-Google-Smtp-Source: AGHT+IHO1dD7rOATDlB/3W92rSORtlW5/aV6FE72dj4ndusMskVWj81AZO9BAxh5Wt6Hjv0zjjXEcA==
X-Received: by 2002:a05:6402:4302:b0:615:a5d5:972c with SMTP id 4fb4d7f45d1cf-615a5d599e9mr6125936a12.6.1754037159717;
        Fri, 01 Aug 2025 01:32:39 -0700 (PDT)
Received: from tumbleweed (ip-77-25-33-2.web.vodafone.de. [77.25.33.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a59dsm2362735a12.62.2025.08.01.01.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:32:39 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/8] staging: rtl8723bs: merge rtw_os_indicate_connect into rtw_indicate_connect
Date: Fri,  1 Aug 2025 10:31:28 +0200
Message-ID: <20250801083131.82915-6-straube.linux@gmail.com>
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

Merge the functionality of the function rtw_os_indicate_connect into the
function rtw_indicate_connect to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2: no changes

 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 13 +++++++++++--
 drivers/staging/rtl8723bs/include/mlme_osdep.h |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 17 -----------------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 2e957f00bd75..b0384244a950 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -901,12 +901,21 @@ void rtw_indicate_connect(struct adapter *padapter)
 
 		set_fwstate(pmlmepriv, _FW_LINKED);
 
-		rtw_os_indicate_connect(padapter);
+		if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
+		    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+			rtw_cfg80211_ibss_indicate_connect(padapter);
+		} else {
+			rtw_cfg80211_indicate_connect(padapter);
+		}
+
+		netif_carrier_on(padapter->pnetdev);
+
+		if (padapter->pid[2] != 0)
+			rtw_signal_process(padapter->pid[2], SIGALRM);
 	}
 
 	rtw_set_to_roam(padapter, 0);
 	rtw_set_scan_deny(padapter, 3000);
-
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/include/mlme_osdep.h b/drivers/staging/rtl8723bs/include/mlme_osdep.h
index 4bb7a01caf4a..00c0a44c125a 100644
--- a/drivers/staging/rtl8723bs/include/mlme_osdep.h
+++ b/drivers/staging/rtl8723bs/include/mlme_osdep.h
@@ -9,7 +9,6 @@
 
 
 extern void rtw_os_indicate_disconnect(struct adapter *adapter);
-extern void rtw_os_indicate_connect(struct adapter *adapter);
 extern void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie);
 
 void rtw_reset_securitypriv(struct adapter *adapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index f85e17ae0e7f..326acbd8dc84 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -6,23 +6,6 @@
  ******************************************************************************/
 #include <drv_types.h>
 
-void rtw_os_indicate_connect(struct adapter *adapter)
-{
-	struct mlme_priv *pmlmepriv = &(adapter->mlmepriv);
-
-	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) == true) ||
-		(check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) == true)) {
-		rtw_cfg80211_ibss_indicate_connect(adapter);
-	} else {
-		rtw_cfg80211_indicate_connect(adapter);
-	}
-
-	netif_carrier_on(adapter->pnetdev);
-
-	if (adapter->pid[2] != 0)
-		rtw_signal_process(adapter->pid[2], SIGALRM);
-}
-
 static struct rt_pmkid_list   backupPMKIDList[NUM_PMKID_CACHE];
 void rtw_reset_securitypriv(struct adapter *adapter)
 {
-- 
2.50.1


