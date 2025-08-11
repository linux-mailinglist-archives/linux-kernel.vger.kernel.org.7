Return-Path: <linux-kernel+bounces-761856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3227B1FF51
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104F5174762
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6672D879A;
	Mon, 11 Aug 2025 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNraw4PI"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984B2D878C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893389; cv=none; b=CLW68gSVa7IJnZ3btTS/mhPQR163qPNVS+aqZgfK/lQxb1SrtevrMN/INLwNQ9hJkUZ1TClwDXBoARDywKGAe6OWL0OHjWC6t5I1OheE5+5J1v49vmGEYwUlrKc1fUKYzulBSDY/j/abqKMXGKmciwC/PM8lqLL54HEXH1A5rIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893389; c=relaxed/simple;
	bh=RV5GCs2kHr/zrsTb0VPTOztxezwZbzu7WRt0nwukgMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxI4o2LmTHuqceftnf8YLcZiWBdVzQBCe7WsRVMxfpexW1WMSCmMRT3HPb8w6tEFVtRCPfyqPo/5qlvmw1ZzhiVD219cxpRDYCTbQWKLkVwUFQx66T97JO65CdAjt1cGoVqnW2jkqDseTc/qrngDzAglWya5xgow6JoTOwJ7kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNraw4PI; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso4791750b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893387; x=1755498187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht5SZSKxZ6Td3vTrSxznrM26w1SVeWme5zze4IvOuHE=;
        b=fNraw4PISJipN0LCPr05IG4+/1wNu4MzCZdbgCFOB6dZD6hoDAfY2egIW46BQMabRP
         q9rVGWsTTybFdrsvoznamw3MpgMmE4vHI9oqkiw5hPrh7GgQH9aHUoQQKQEQm6dbrsUt
         AUpJKvu426YSc8VU/5yOLJdwYrXYLX0fGcrImCbULiLkHR9Cf5nvl7j4t77vom46gscI
         YqUIko8zS7ARDEaawpe5z7/stU5XIdtaCIMbGUtNK1XkG/wuWV+ICQ7Ud8MwM0pe3r+Z
         Z4AqzJ0wfZpWhbRpjzHSqUpw06+QMzpNxMm3RMRM1lMfoX/sDwoR/6eq331gvV0NrVpp
         z8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893387; x=1755498187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht5SZSKxZ6Td3vTrSxznrM26w1SVeWme5zze4IvOuHE=;
        b=NcpVfCwPsRAvkj0nCr5klrQwDk6mtGaoU8p/fk1sqF/9rR0BzaSfFctubfVeJDEhjS
         Cj21mGCimT1+Vca5i65cOgaXam0U/oMRHMlFbOG0wol2QCi9H7EsKD91o3WVYoi6TxGp
         llvAIBb50x1TRuOsa0ChxVcVdFfUBwSQJgmeW1FCFezVC6D720xa645tA7fyqxLR8Cuu
         HbHcJ3tTE8y1MENhUOLul+p6BFg/Gjw3wsqFQy1G1prnBtUmF0kFKGZsKNmsxBrG+iy/
         uyO8+7RBqauGumBAIW/ZcnO6KqU1u2TgU3hGaXVirdU/8JlEXUSPbvvTlFPbv1zF3tyf
         rZPg==
X-Forwarded-Encrypted: i=1; AJvYcCX2tydNY363VhPlU0qdQWMFxgCSxJROXJjbFd+ptRbdpG+pc1e0JhJxXvVJNj+VLhFHy0q/BQH6bryXgLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9/XWTLjjS4pvRFmgGSayfCW82p1+0Z9zKkLhCN+bl6g90x8US
	CvqZUuNsxOKsRO/UjiDdX/JUdgnZZdKI8TIxGtN+G1mX9iF+qnQDvIlg9HAfryXal12SKg==
X-Gm-Gg: ASbGncvo6BIK9wFKWbZi9DUWiAdjFYedQ1Xisfrv4qbKAefEfIceZLpCZ6TfHxY81zn
	F0GVyDXtZ0SgRnUwTvZOgDV5oCuURrmwVRfCh3VRzF6BWuJFQ2zn1GiIJhTjVMIOqb1LDCyu3vU
	QmGejXWGZfucJ4uT1sknnRqlgyj+1IvjzFTi47592+V0hW35hEhSAHU6isG1A5LpFF2uaxgZka4
	VSyCKQY6jYYNpZBBxvLLrwA+EWU/ZHlIMzg8uSo6hET5O/QceJa7+7M9G9YkUNnQsbSKrXZE5sM
	63VkkePD9aH6Lxb0IAvnMfviyM+08RZNAufH8zRvcUdJdVOzMnvOdhrcxM46n6R9iCcn1obUVCo
	3ESb78AiQNmz3QHEFd+kMuNnSc6A2yM1j5ozEmavYNUGAk1IZVag4dO2XqgZEH6sXBQ18DruG9/
	WBm+uF7XusVfEvxhGtk8zWDVNEsFu0cLkbK3ACsQg7
X-Google-Smtp-Source: AGHT+IGlmrVK0CCzFeHYRPCVHjfCoB0sZhL0rSac5kgBAIFpd/p4/sJ7sycMyphj3Vz1IC64n9ZNMA==
X-Received: by 2002:a05:6a00:4fca:b0:749:472:d3a7 with SMTP id d2e1a72fcca58-76c461a68e1mr17163990b3a.18.1754893387403;
        Sun, 10 Aug 2025 23:23:07 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:23:06 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 08/11] staging: rtl8723bs: Enforce alignment match open parenthesis
Date: Mon, 11 Aug 2025 14:21:31 +0800
Message-ID: <20250811062132.102525-8-changyaowen19980629@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811062132.102525-1-changyaowen19980629@gmail.com>
References: <20250811062132.102525-1-changyaowen19980629@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit force the alignment to match the open parenthesis
from previous line.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index a11afebc8b9e..e82f8a07b630 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -307,7 +307,7 @@ int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
 		bAllow = true;
 
 	if ((!pcmdpriv->padapter->hw_init_completed && !bAllow) ||
-		!atomic_read(&pcmdpriv->cmdthd_running))	/* com_thread not running */
+	    !atomic_read(&pcmdpriv->cmdthd_running)) /* com_thread not running */
 		return _FAIL;
 
 	return _SUCCESS;
@@ -364,9 +364,8 @@ void rtw_free_cmd_obj(struct cmd_obj *pcmd)
 
 void rtw_stop_cmd_thread(struct adapter *adapter)
 {
-	if (adapter->cmdThread &&
-		atomic_read(&adapter->cmdpriv.cmdthd_running) &&
-		adapter->cmdpriv.stop_req == 0) {
+	if (adapter->cmdThread && atomic_read(&adapter->cmdpriv.cmdthd_running) &&
+	    adapter->cmdpriv.stop_req == 0) {
 		adapter->cmdpriv.stop_req = 1;
 		complete(&adapter->cmdpriv.cmd_queue_comp);
 		wait_for_completion(&adapter->cmdpriv.terminate_cmdthread_comp);
@@ -527,7 +526,7 @@ int rtw_cmd_thread(void *context)
  */
 
 u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid, int ssid_num,
-	struct rtw_ieee80211_channel *ch, int ch_num)
+		      struct rtw_ieee80211_channel *ch, int ch_num)
 {
 	u8 res = _FAIL;
 	struct cmd_obj *ph2c;
@@ -777,8 +776,8 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 		 * Especially for Realtek 8192u SoftAP.
 		 */
 		if ((padapter->securitypriv.dot11PrivacyAlgrthm != _WEP40_) &&
-			(padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
-			(padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
+		    (padapter->securitypriv.dot11PrivacyAlgrthm != _WEP104_) &&
+		    (padapter->securitypriv.dot11PrivacyAlgrthm != _TKIP_)) {
 			rtw_ht_use_default_setting(padapter);
 
 			rtw_build_wmm_ie_ht(padapter,
@@ -1184,7 +1183,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 			BusyThreshold = BusyThresholdLow;
 
 		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > BusyThreshold ||
-			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
+		    pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
 			bBusyTraffic = true;
 
 			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod >
@@ -1196,7 +1195,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 
 		/*  Higher Tx/Rx data. */
 		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > 4000 ||
-			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > 4000) {
+		    pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > 4000) {
 			bHigherBusyTraffic = true;
 
 			if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod >
@@ -1302,7 +1301,7 @@ void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 	u8 mstatus;
 
 	if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
-		check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
+	    check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
 		return;
 	}
 
-- 
2.43.0


