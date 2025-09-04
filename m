Return-Path: <linux-kernel+bounces-799664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C5B42EC3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0871C2330E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D861DE4F6;
	Thu,  4 Sep 2025 01:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQaJo3Qe"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087A1D7984
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949193; cv=none; b=gdc9RWFki7UIkOJD5rmSnWylqJUdIDKzWrqgGeMgs54bOHACyy5fMUP/QOte/y3CluxE6MRObm32IwDfTnGftPBxFzLNgEFkSxIDT4RDj3FhU34gwurAsZldJNRzTINyRFF6Mq21smiu9sV8m0tZEVqfrgAIt8CXNTh1bFsNO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949193; c=relaxed/simple;
	bh=t6cSp78s0xsgJIM8X+WnQ5gua4odTeVTTNH0xY+FGJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqN418Di7Lk14l93oIU71gF9/QRt3RP7iI4U7bmz5ylXKBWFlkme8yORCNVoMFp0SOWBU0onQIvyohIsBsEBDdv9XrC/JvKU2Nb9UlkZotU0rgutjbqUjHqaeUSJEOnvVn9Fv/SjfzZpva/2IAMUTPKX1+iDW7lJy7jIoNP2Snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQaJo3Qe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-71b9d805f2fso4789826d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949190; x=1757553990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=lQaJo3Qe9IqodNvKsyDXjHsdEZ7m5iVdIr6TbGKPzCgmT5STfjl4XWQv2Agr67MVyJ
         KB7rOD2gSdkteYwwv/YHIwI/50SbsjXOOWwY6XVifBxXJQhT83kc4k3OjZNvhtbYIeVc
         ZmjZLxDgSmYngsR43Ejkofsy6TrrZoOmnf45gWklpEuPhAdSqtLIDDK97CuJB8GXtsPm
         KZWLDaQAoojBfUDfdK4jMJ/a6xQ0/g5mSZAGG30hu9KH716vrQ3t2elBimHYsYcuE68x
         GwpBAMpShXOBbAwV+YsiFnW95BQ1dwJ9sBemGl1CXHT63qqZy5+RDwmtmSVFdOtIQZkZ
         A43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949190; x=1757553990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=sMLGeTkbgc9fkYxuQR5Df20wGmXEakRlQq/PW0u7BlbUj7Z3V87TzI/6mcv+4LqN1F
         qv8wDr8sJglSQrQkWnfyS3DPlvixMp4ug3ddU50OQRmW7vglR/U4PJ6qKG2qg9iRznB9
         1LQgpP6S7EnEYtDfTwEtLcUf6dznQO7cDHj08VuIG5K3TRhBZhi+bnrqIX630k1jDq5T
         IsLqyNXz6gwFb2pYl5YyyH2Euz5M8ZQ8rtxtV2lb18z3mlikpmXuuXw1l3WeTB0XgpLS
         wmRNcums4cgeLqYw2Yio8MpAQXpcl2prutbhxSHcDp2O99dVHOYCNjdZBgFGLxInN4nB
         7UOw==
X-Forwarded-Encrypted: i=1; AJvYcCWO08sdyxgju9RNhFN8pvRRDnp/J6L0fNBAco0kS1GOPm38PbzdytEnpF66xzMP5hSZ+83z+s3Gj0txWmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6tZKu/jgrrhl/03sCv9a36R7dQxiMehQ+fnvTXM7KGSQbvX1k
	br1Dx9OKLbZ/hs51gWwYPPvIafXx0AsbAOSJy/yfif/UEwg0i3+VBRii/KY53A==
X-Gm-Gg: ASbGncsxnxn4GDwqhZy+N8VYyfw0GVH0L1gqYVOKKDi3bI8HeHkVhCadPqJjxBD73e/
	SkmafJemdWGSotdFdTnsHNknQFGYr8FmoESJyyTQ2KVw+fZpaqhDFEQOBUV6J+YaemLFk6iIe8x
	5tNVXKuyVEYMNyvvCB5S7n9j1sUz2n8fWZKrDiAPQVt2IxNohctEs2Sq5Em69i+c8e5dE3/CtLA
	OOUw91SNsAesO8gT5nxK0Haa0NPvpg33FqffWhuFaif5FDGpBrStxzG3LwFhzIiAKPP+yCCbWHT
	KV/pRAwRfCYgJjVgzxMhodUM3b2Zt6iurF5mKC8XmiVbDSfd5TM1/XhiKkAWfun+qkixhwn7Ezf
	YiejJMyqVxqWmjhebCP0EeLE2F/GZaHD0XpMnFwHib9nZGh2hzEA=
X-Google-Smtp-Source: AGHT+IGYGdwLwTWby8sdQDjLB43X6KM/WS5I8MepBpWtGFWYSlr94mSBJ14DrQ3pYcC4Lri0gLLo5A==
X-Received: by 2002:a05:6214:20ad:b0:713:bf18:cf32 with SMTP id 6a1803df08f44-713bf18d062mr187282296d6.10.1756949189802;
        Wed, 03 Sep 2025 18:26:29 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:29 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 04/16] staging: rtl8723bs: align asterisk in block comment to fix formatting
Date: Thu,  4 Sep 2025 01:25:24 +0000
Message-Id: <20250904012529.215521-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
References: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
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


