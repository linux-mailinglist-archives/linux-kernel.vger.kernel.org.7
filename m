Return-Path: <linux-kernel+bounces-799723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E632FB42F8B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A791566678
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234ED1F0E26;
	Thu,  4 Sep 2025 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQQC9Pej"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B81F8723
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952111; cv=none; b=iH+t3FhPXWJhmvnJNSOmMEU+yELhJTwx4qtmj7vP/k3a7Fvy+7Q0V7RTm9/WyRelbIIEA/QYNY/FiXhKCRGchGWCsltCbgOaJ9u2aUVGgL3X5b2GUgMndTidb+yxkhyD8kZ3UdoKuAlZRpzDtlBG/1IivDGwRAQqOmXvRjCivlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952111; c=relaxed/simple;
	bh=t6cSp78s0xsgJIM8X+WnQ5gua4odTeVTTNH0xY+FGJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nR/wvCBOciUfzre6oaTsHPPT7BPibZ53RbBt/JlgiZ5OXp8OPp16/1Z7hSQFGNRpTPExiCYz9tdsTr0H0a6sSnV+NLHDgwCC9OyudQpEH21eIlAUvCvmPO21npKKbFckHs1ReGS6NDfvgarAQFTpSaEu6VvI/SH2ekddAwOmqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQQC9Pej; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80cc99fe980so61652185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952109; x=1757556909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=HQQC9Pej4ZG/MLPaRhFqUmrzTR2Al7mVmWuJgXSqRPYXu6rqZeE1uUo3zgZp10FC4g
         acl+f0XZwWsh+NUtCpNz4vVQ8zPbWOfN6Ll1F16kqG8MbIHMLB1RP+gJJgovsggf8lsA
         sUq7UF0MUa44Ve8lkWE+y8dx3rLXOE0j4f6GSMZVHDIVPPqNumezpCz8puB4uwWUeYP2
         K5qRHfh4D+3mwZUw5eCoHRHKbFyfbhNBJbjU6TH6uwmQ/5B3T8AqnLQRfRnw2lbP1CvD
         TV/bdZG/3ZCTRIF6Rh9owKsKBX1v8hXowyAl5+Z8GGRDQi5sQ0AAuOwtapniaVbEamsZ
         c5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952109; x=1757556909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZzqBglcCR6z9WUwCh48OuTmyh9v+X8bzE5uxp+FKJw=;
        b=xQ32S02NbMfvg51HdEpP2DHWSIGnP9btW8rarapDvtDK+JbXKF2DaifFgXzVZ6BhKF
         fUlICdMEbSXiueVCZNibXpGAAW01sOtq7bSSt2A35P179T9O/A30HmOaFYJ1pLuezH8g
         BmEXkrkLITxxLeGnK9R8Hii3OxptQ4W91hW+DOC1AcY8367BAx9Xcv409dQvvKkIG3ts
         iXYdCFZFxrfCEU2w4auGVN0OrIIBbwng8KSCw8ffmTZOwOOUrF7QEyAPvUcQFUZOUCLu
         sq/xvvC0dFGMQl4T2ccPo0WTNyUffVfrUqmRvdDpjugKI89RaWSwN5cmH9gjuBOZVUop
         sH6w==
X-Forwarded-Encrypted: i=1; AJvYcCU4m5qhmINp1+fcuj5GoJ1te/w6XrslNB10yDvajMBky9utk3JxXcyos6f4SUesqSCkTMIvWnfQSKn3RPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkflmQ0jWbhG8iuMVUxXpRW5hJKLpitXJuQsm5yjMQTjfn9bAF
	xTsTkUB1g/v3Gpoi/Lz7m3u6wOlvDwz3jJJF5IjXFyGzwmbXUR6S8C+V
X-Gm-Gg: ASbGnctSZi6uUyUhjK8+k5PBZ+D21/w1WERXNXniUbwEMPZTzenLMKna7QLKupGRZ/y
	nr1KalxLGR8wFbityUc+qAD63Vk2LrPCnP5jjFtrkQcHVsTiqABv178GbtW9o+Y+1VC5fiAA59d
	HVQ83ZYOzSNAUXbA9wzpkLgouGf9D2ifsvyUTGmGpzz7MOhtu30A1QPlKb9VAjK00wpqefRhKue
	BW63OkNIEU90sQGsq8mpxBk0+wN4zrkp4jE2hZi2Z8p/8mThzp9N3CsQujrOkrnr3Mqkv3zigm0
	yJiv3NfF41Y5ZIlgax0mJEsPdENgS6PhBjukt2eUYip7cOF2MwXrTYQV72FljBfNf2Mz2lxg6nA
	QhdUGt8WIGaqqZEdf2Y2RGLuscZx9OCDPIpf4Ymf1NBR6R2cIYbqtDBmQSKyIPQ==
X-Google-Smtp-Source: AGHT+IFQike7l/+zOttraj1oPCqSfblyiw2+GKeIZMRM/rYegNo6E/KoGLAJh5bsi60kYcTD6jl5ow==
X-Received: by 2002:a05:620a:3187:b0:808:234:d472 with SMTP id af79cd13be357-8080234d881mr886662185a.31.1756952108881;
        Wed, 03 Sep 2025 19:15:08 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:08 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 04/16] staging: rtl8723bs: align asterisk in block comment to fix formatting
Date: Thu,  4 Sep 2025 02:14:36 +0000
Message-Id: <20250904021448.216461-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
References: <20250904021448.216461-1-vivek.balachandhar@gmail.com>
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


