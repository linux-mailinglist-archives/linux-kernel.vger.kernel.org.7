Return-Path: <linux-kernel+bounces-840550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D01BB4ABB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21653B33A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3626F2B3;
	Thu,  2 Oct 2025 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F596PX3A"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819926E715
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425837; cv=none; b=QEak8hTliLhfzFJKMIwrJt42Q5mE8QDCz9G3l7s087UnDEImSEu1iSp/LLaXW5ce5qTELGCx3Euyk3J8ixIMMjX4BYAsArBhSpvLoE9L5ukzMQ6h5ITKOf242ilmnSST5fxvfJAR0J3KGPEyMf/ozt6P9pHsfjdBeC2dyFmLvRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425837; c=relaxed/simple;
	bh=gLqaqDCDdle/KvgA2xR1oczrA2cmUnFNtS2KtHaVGA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZ+aBJpSlkAUsoR4ZkLubxWnh67OQsr+/uUOSIiXPPKx0NA9GI4Ybq1Zd1LOJptYIY8iVRPoJHN6lsGYhV4i82cluNKQI6KIvqOniEiu/l+CDjDaVfRCbteBGHRrhverjpYk8P7rd3GqLZsw+59xNDRBwAFKJKy5I94TTJU+oLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F596PX3A; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4e3117ea7a2so19050551cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425835; x=1760030635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWd5BC2XgSagrwNc+rN7Wfr2/BH16xqhtfWifgZDwag=;
        b=F596PX3A8jCvmsOuOkqlgqlkhu1XCGNLxKQPxLWKs8wvTa7s8qUz+BP2gaWCK1FMSM
         zpsaU6SL22OE4sPgUzfwDtvoBzsy4kPdWM0LtOgtaDZWlL5eIUUcQKJWhwH7wadSd9Y1
         2AuPUy1jmLNhMwalxl1z4HEaBRgjQV8aroetDLhSGk8tWwP8M0oNI08C/6YF2HMIwMRZ
         1GIWbVbeNLTo08XOxzWWJFHhu8k2l7XJqPF8tK6+Ky1MU2Vjh3daQOcla0GViwiUg4AQ
         /gufrmSQSx09Axng3EomIRlx2j7KjdGdH/5z2l0hdb3S3A7kTRD/YvqVuq/vGW7htOcV
         j6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425835; x=1760030635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWd5BC2XgSagrwNc+rN7Wfr2/BH16xqhtfWifgZDwag=;
        b=Y3mytdBs5ho0grpoltv//yKhyWrmC9Y/yUKO1kvceEpJtVZR5a8aXgtbx+1wLoui3j
         +DXBa1uatjSC/Xq1Jmq+pUHGGw9S7vQoyqhLMpg/HpQn27WZIEMpUbJH2wF2n2LZCydf
         EDgBK7saE7WmQQc6FL7r5AgTAC+Q3aZE5BLG+l6GcFMZS8HTs02YzJZK9Rzum/FDUyGT
         acnjpBRMuhFT93BQnUGrACQ2HEn7FbXCvRtwGdDfY08wHOYDO9xiDsumNSluD4GrOr3u
         svy5deWylM7AbXJigjDJJRXFydITDwbaVpQFz9tJw7fR3ThH7ZIRnF23whnbReDqfrIA
         iTJA==
X-Forwarded-Encrypted: i=1; AJvYcCWVzhs3z/QzmWe2VQ46QYrztBIrdg+qzEJEQDXLvsjG5JoeXMhJZwLetgpXawXWwn8BVK/wt7Dfa6gnrcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hVs+w9+/g0mQ9oukWkdaadHAp6PTGuEMik+LA3p7X/Bdv8xi
	WTTgQiBjrCQFcmDc9VuHwPs/NM086HnamYNgVag07qLfYtKhuSU24UQ+5sOM5Q==
X-Gm-Gg: ASbGncujmCLHe290LT3QLBdwqhEBIrJNMySLftqzxSLoF0dQjx3iQiADFK//qK28XLY
	u+QZUf5ZZA/0EIqmEqOVhzY0YRDm2w6dEXzpuInIJ7+SGGr3ygOKD1DB7mMaUiv07CCXPdkO27y
	2mM0DzbGjIdecAM5FIXvDYwnMC35idW52Wx1ItbJqMTs+4O3ZkuUGI4IKvU6x0nBwwHGyNTHDbM
	zXnbSjibsITLGJd6TqeMo9g6uEJXAYRjfMMDuKoOgBpBRX639BpeWS53C87plAuMHxA7pYejkXb
	lBtAiC3JRryvs32tDeWIOLsOszesPtffCHhaZGrYnBXA4880QJdf56Ql347CnFk7+FLxDQ1NyrX
	rYnFGXILLEC3b7PgHqsaEFBcM8PrZhQSL1YvYnzFYFdFf6tF2YefmBb8OSK8lGCQi7qlKcysMqx
	c=
X-Google-Smtp-Source: AGHT+IGaYSVVuUQxkF0uoFyFGDCVwC2Plw92ZS2jW5P5DTXGaEG4/HIb8G+lJD9ZfWkG7QY++FH2uQ==
X-Received: by 2002:a05:622a:5a92:b0:4df:194:b479 with SMTP id d75a77b69052e-4e576b23b8cmr1139471cf.59.1759425834552;
        Thu, 02 Oct 2025 10:23:54 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:23:54 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 04/16] staging: rtl8723bs: align asterisk in block comment to fix formatting
Date: Thu,  2 Oct 2025 17:22:52 +0000
Message-Id: <20251002172304.1083601-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
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
index 3eeea832dcb6..c898c10f0813 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -869,8 +869,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -905,8 +905,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -934,8 +934,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ * rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
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


