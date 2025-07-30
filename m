Return-Path: <linux-kernel+bounces-750591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEDB15E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB095A43DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308E9293C67;
	Wed, 30 Jul 2025 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyuCR0sl"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6EE2949F2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872315; cv=none; b=m/e+EJCzl5qHk5gy7OEqx/8dz8+xsDa1xgaw2XYwjZQKzcOW5huS8ZRrk6iL07L3SZqvXRZ60TGQcsL8TK0TS8OCJJ4ez9QeRjEuOn1O+q5qmA5MXaSBj+s4y32BjOHEihSIYd4Z8iumP+XeUjmagJExvAu/9I6RAfVTlxOUaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872315; c=relaxed/simple;
	bh=213EVC+0UVwqwh4SAqNbTXFElUgCZw5dNB4DgvuHqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxDlyNFBW+nxxNDIdsF0jSjJdPwHzSszUoR92+BzS+OpodTrmaZCDgPE0fA7T94nIo8OUhJDQN7+rC6ZbD+EkROS3LWagE37jmZtzGUAjp/PuskYhBMJt+JH5CUgooWkH7GgVk5SgQ3ALrvX0SsAcaXvNLWx+eJSylFzGJojMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyuCR0sl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6157c81ff9eso2085920a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753872312; x=1754477112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp2PMrXLI/gbGEVH6n9WhPc+A6Nzp3ouOjOI/qshZbo=;
        b=CyuCR0slAWDjkWw97H4hwBUx2apFZkflfIdGNMwo6LkWJEaLVoqpK1NNRQy22UgrNk
         VPBoLRt/drC5VGi1pXlbLZd5E3bbWe3TFQlRYaxyMn8KJ4JzacIaTcUjJ5lPO9VG4jBE
         cizVvnwRpKDeLGEs8yXaRUB8yMnXOThdwL4/Z+KhjA9yySuJPkDvdz30zAIVCpVP+g2R
         wO/ybVvQcCx2U+i+yUVh8sUQK/hteVbjF1TmNuFqi5R7ARIaMZcPFyNBlszJbcu4RyL1
         WtvHcdA9C3MpjZy0hWyKJMj6rpQLBX+Vg9yGGBcEF9oDJqY3qskkshY4K15i3kWXxwvG
         XpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753872312; x=1754477112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp2PMrXLI/gbGEVH6n9WhPc+A6Nzp3ouOjOI/qshZbo=;
        b=cYFBdKuj+z4TVXQrEAiezDwL8rKaa4q04WgNmW4Mzo68HKU1sqIAB+IyQNJYNTvc03
         D/WeAvCvW+q4PECbeTzyJprlIe/YjqDpGhPV9RoNrWs2S7/lyjetaLbNfxTLGHEQ5fql
         aQkosVexYfd7puhGXc3/51e2AfxWUDJOEsIr9eD5QkHVt4kl0JSA9VooGEMILGZQSgNm
         dsenq6a1xfAM7/xeftoVUzR/MVmGkichCFLnzmGx6dFhEVnLxYh3TW0Xq/Iy0I8Y6PNe
         cWP1HIW2wMMTARh5Ee0Nc1HVnFryF7T4OK/ejWE0jCJkWd/wvCZgwgav9RGw8NaD4BZV
         aFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUQlkBT4bssNXOAbWBNpHih72RL28bJhoVq56mYR9pVfkjfBsMv0p4OgO7Ic9SvygV8q+1n4ievqA3rGoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MMzVf9XTrKUhWQx5HDTNQx4IR+vv52CjBUvay/7E8/SA72LD
	YnBH3MYUEF4O0+a+r10qlbiJEKRJtUgfmYl5xu7zP+hyuzl15yeH+s3K
X-Gm-Gg: ASbGncsiwAQmE7a1KwSdgN9sPMXcHCR11Fbod8NYGhf3X8zieYKVvV1voykWNnfB2JM
	Grdn28SJL3DzvSH2AB8TJBCaqiT5vAsZGRYMiMoDIihNiqNkUeinj6M3ShnpgNr9uuol2K8tBTy
	hxYOoI6tcRFPqDCjT4WlJvQPFC++C4B1o8JREONFsY/fKcXt5Qu9D8k6/J4PP+mVulBVcZZkZe2
	ghxqCrUQYNegKyzlgPwTViWJnvPEUvWkdg2NVmECncT8ikDcEteUG4NVvRYrM3/i7XXiki8Loz2
	QmQk6QlfB68UmED6WoaKLQROsaSLs8CCsd3WLyVaJhqcsh8nH6HBxT0/5U9Knbg/mUxPgRxWNzc
	vA2IN6ur65hYQidwkFBSSRz3u7WnM5U8MpljY8jNu4jwqfcxXq/6MDQlMeMP1SIrQyeY=
X-Google-Smtp-Source: AGHT+IHq3jDlrsvJ/ol1RfNeI83klIIU/EwAubIlTAI7K4FGKPInNe5pZk7IDHPVEm86DyphLjKVyw==
X-Received: by 2002:a05:6402:51cd:b0:615:87a6:58a7 with SMTP id 4fb4d7f45d1cf-61587b5a205mr3216376a12.33.1753872311530;
        Wed, 30 Jul 2025 03:45:11 -0700 (PDT)
Received: from tumbleweed (ip-77-25-32-208.web.vodafone.de. [77.25.32.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6157974fde0sm1582734a12.7.2025.07.30.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:45:11 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8723bs: merge rtw_os_indicate_connect into rtw_indicate_connect
Date: Wed, 30 Jul 2025 12:44:58 +0200
Message-ID: <20250730104501.150270-6-straube.linux@gmail.com>
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

Merge the functionality of the function rtw_os_indicate_connect into the
function rtw_indicate_connect to reduce code in the os_dep directory.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 13 +++++++++++--
 drivers/staging/rtl8723bs/include/mlme_osdep.h |  1 -
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c  | 17 -----------------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index bc74c7838a3b..38238ea5ec99 100644
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


