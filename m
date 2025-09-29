Return-Path: <linux-kernel+bounces-835839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE6BA82F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E887AA5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AD2C028F;
	Mon, 29 Sep 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9gXHsJK"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3962C0281
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128640; cv=none; b=GbRRwVNnmr52y6JHCQ4uV+m7nwkVAaTFxu8/aCfR89zdZHZjobmdOnx4FuvZTdGs4IAiTkjFRLcfMZA0IH+/a5JOud/6Mmxr42yJBGhy+Mjt4I/K8QScQPWvqgdz14feEV0fYjKcgsZSmN+2EAja0Joyu9Zs0hjq6/dGtbp+7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128640; c=relaxed/simple;
	bh=t6cSp78s0xsgJIM8X+WnQ5gua4odTeVTTNH0xY+FGJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBVzGYGVcUdRJOL9+U8IijBmwjLErFObKxUitlusS6NXYeWXcf9MEENWQpOx2t8FQQFOlkBP4uTUbJWEyIJeYaRERj22Jf4YmL7AAPrw2wCxM7MpPu7uUAGA6FH1NEGVwgJNIaN5rNqP2ApH/hXea7YYXjcWUh/EuMFf/l1QscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9gXHsJK; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de659d5a06so17487991cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128637; x=1759733437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=L9gXHsJKh/opr8uvTZzhlf1byzBVTgHnPCISitrgK0AHNMNBxWXjJha8ucQGbEApW7
         nFx2k/UV6w8YxIQkNdnoKVACWQ9y/LCpGmkPH3Wb4pl5SaCu86jqYsfd8OFafMe7na/X
         pKCpJE7aJEKkHTpo5HDJSLGPzuOTYUxQg660oh+TadP3g0TWBNbvFso+SQp/I0b2Qdj5
         t69O/r8jZfrGZ+beVqQiY9EsI+pDQBlCcmdez6IwkO4UabFrzizAo6aY4PnrPy0lWH2B
         avXnQQTaQVKBcY6YQ5SCXIY47HqN+Sd+E+E+Wjm2tW/fObconCksyp5u6u1LWkYEPC2j
         tHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128637; x=1759733437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=eqZYJYCSSI0CmH/wnC/68npK/QXqkMufci1910WiZpovoOXGSqXJ4TG04Klj+si1o6
         AvyP4YLTukPbFxM4brM/PCCkrcovMcDRBrLu+j+31odX6FbfjIg+hAgdLVO/1y604FC4
         kmlbxcABjc6TIHD14HkVpY8caeM6MFXHU8fcpbquQpJJUQH+1dBNna/IwEraP1y8tHdl
         Z6JB7wPRa0oqxR7l0+oB9XFdwNWFNvkOL4IW/zpI756KRMnGYUzfpFxFoRzEVNnVuUmX
         TjbwU+mRMEkf2kJs24WlNuubeDx0aGUwwGaN9BDPgzTCdcKY5VW0wWZ04RYt/dpsceCq
         6jfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEFyw6JobO5Ll4x9+K8BTMKm+YYNUGZpHF+I/ZBCSRKQaxkLhsKAY6L5b+Wvfg03RpeC2Da72ZYQfCubk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7l2HyJZj+OVKTxNsqhqGPjug8y2F5rZWerAM0xFuoHemdHeaP
	sth4YMPTQ3HQcRtYEbaiwhA/4onzSLdFkUxgVSP/mklNznd0qGul5b0E
X-Gm-Gg: ASbGncsK+EmX2+0jAAIWkv4Lj7/AdNXN9qrRkrZ9vl6g/K7PRtFqDSaoeHxhOom1I83
	EAdKDPo5BYTGQ6EdR4VlRlOYgF0LuVu7SzjFbHIfhkPAx+PcQXlJugSQEj3qClLX9EkF8rLUiS9
	023svt9aiaqm1ygkGj8RdbAjBulhLjEZ8Pi7DD6RikLhooXaE4bLQSXfASe+uYEmTWnWdiWNS0M
	vsytLY8BgYj6Sy1V5H0ylF99KLwQpK/Q/V4MDBA5ZbHeGQ9dWElCrV2E4EKauvHQ9cCK0WEPcTq
	m0gnz7+BY84W0Wyne4KpW4f5gcgQXyVQoc0cnwDN1G6v/Z6K585jbsucaAovyX5T3TQHhIec/ba
	U8wEQYkDso4wyHy6Y7nb8ZMS2rKsCAyWU3HG95r3F/f8UJ49OSVM=
X-Google-Smtp-Source: AGHT+IGRTMai0fhlyMeXGP8CzoshUuUh7SI0dyYwCT5ngazauezXgV6/mWhIhXhF9jtnM1oHzxnqmg==
X-Received: by 2002:a05:622a:1493:b0:4b7:9b8f:77f2 with SMTP id d75a77b69052e-4da4b141133mr225203501cf.39.1759128637485;
        Sun, 28 Sep 2025 23:50:37 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:36 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 04/15] staging: rtl8723bs: align asterisk in block comment to fix formatting
Date: Mon, 29 Sep 2025 06:49:49 +0000
Message-Id: <20250929065000.1010848-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align the leading asterisks in a multi-line block comment to maintain
consistent formatting and improve readability,in accordance with kernel
coding style guidelines. No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 3eeea832dcb6..cd41f713a52e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -869,8 +869,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -905,8 +905,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -934,8 +934,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1596,9 +1596,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
-* @adapter: pointer to struct adapter structure
-*/
+ * _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
+ * @adapter: pointer to struct adapter structure
+ */
 void _rtw_join_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1641,9 +1641,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
-* @adapter: pointer to struct adapter structure
-*/
+ * rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
+ * @adapter: pointer to struct adapter structure
+ */
 void rtw_scan_timeout_handler(struct timer_list *t)
 {
 	struct adapter *adapter = timer_container_of(adapter, t,
@@ -1762,10 +1762,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
 }
 
 /*
-* Select a new roaming candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new roaming candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_roaming_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
@@ -1844,10 +1844,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
 }
 
 /*
-* Select a new join candidate from the original @param candidate and @param competitor
-* @return true: candidate is updated
-* @return false: candidate is not updated
-*/
+ * Select a new join candidate from the original @param candidate and @param competitor
+ * @return true: candidate is updated
+ * @return false: candidate is not updated
+ */
 static int rtw_check_join_candidate(struct mlme_priv *mlme
 	, struct wlan_network **candidate, struct wlan_network *competitor)
 {
-- 
2.39.5


