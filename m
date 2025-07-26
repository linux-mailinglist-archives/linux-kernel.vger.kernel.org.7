Return-Path: <linux-kernel+bounces-746613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A20B128F5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850CE4E43D4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9420125F;
	Sat, 26 Jul 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9JSg6Xs"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705C1FF7C8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504424; cv=none; b=TnQBRRPzAzd5ZIEXxN2NQqkWIM364ZlLWF4XQBwljHkAI0O0P2vwnL91G/K0DPbpihT8VFUaqe7N+NWjKPah36BEK/rAU8A5DqDiHfV7hzChzCSTxJXHyvNCDrVwo98Cn9lvsn8tlPfU+YRkoqdYX26BYZ1ybv7o8s4004waMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504424; c=relaxed/simple;
	bh=1YE2UOp6wXhpwFE/MVztUoGBMbU36yVaKY1t9lc7KrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf9JkGb6TJgJJmh76cRBWrQaD/bOHKhTqbDeTsNS0yOYbq1vb0FsNVoj3GGYkG9nm1YtHrXu66ovoI4wOuVsLjBGa7m8oQPBetZMXjdMeAMxpmFrV9T2PgrCeJPUpVBKk5BzfnQaiLq+oaOnIdgiZ4fgsTFwvCJfPuwxVK3Ievs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9JSg6Xs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e32cf22fdfso258961885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504421; x=1754109221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ranevgSJeBzK24ZwK0Y6Bfek06oJTvOetUee3n/vCQE=;
        b=d9JSg6Xsud05KZG32QUITO6G8O9InjnDcdfkJB+A71SMnkQ84RunLl9FiVlbf6Dmf0
         NOceYBvndkcIUShtF9oUsGXU7aKkrky/SEC5MOJu5nZB3Jsc5vHq72t8t5ICkVzTPO04
         BcDOdE98MjeVU8RGplItzAadhqgFPBzJetVB7cS77PvHYTs7LMKr5oVC0qd6KLnmyOyy
         KfsPWWnPiR581fhAeqBZjRj1M2fy7lRTtksjgjgvqXmQiDpoUyNUl2Px7rrtkQJ7iKBv
         smSFErCkJ84g31gMSbLjnjLfteXobOSV14PDqpKMCir8GX3igcDSazHk7EY3U3Wk4A7/
         fL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504421; x=1754109221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ranevgSJeBzK24ZwK0Y6Bfek06oJTvOetUee3n/vCQE=;
        b=H1miREc1HEM8f/r5vyJo8oo1GbrtsTAU+i3Fo41BZkRyYSHtriWv3E0PL1BnMWyrqv
         BYHgCTUDxv8ferkxwjaH51G2SRZVXXR3zcz66wlUJUJHz6Ns6NAnDaZcugigcsLZvB38
         4BDJyheIGsGPKafBMaNRdLkymK0wHsL5Swuodc3EmtSvYQkJZPZByW6ZvC8ROwBR+UZh
         oTvZcc6PY2cIO8n5TeFEZAo+70uyD427nzsyhtru/nDKzNPDboabt/lC4GbuRJ7T/pu6
         b+er1I06Jqcd4JZiLBJzaSOnwGDl7TGR1IAa0C+Iiloe7ICoww30xg/SEP7t9uaWAlgR
         nuOg==
X-Forwarded-Encrypted: i=1; AJvYcCW7MXAbE4AgfeW0X5U39HmuuNV7uO5yHJ8qRufX7/BjXWYN8GeO8tfhDPpFPytPi7FJ5h8tsE93XU5v6Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZaZIchnzrIDFoepxyV55aM2keKnU/rJ9LNzdAhpHZycjuOsk
	WhLvRUnFX1alH1ExISWeb3Utg2Y7vB/iCqL9LjKcy+dTbNDoxZ+LNLQFqSf4kQ==
X-Gm-Gg: ASbGncsWfHLvOJa+jSpyO7omwWGM2+d80I7zpMdUlfgjiaoJELXAZmyJop9uA/MRbaZ
	bNMI702oLdg4u2z5p0n62Z3zs2hE8ETnMXssOLgrBb2VEXaAMMdKhSCYdxsK7J7t5xBwUjd4eZd
	+/fA0m7rMNDqmVjtYrmfz52SEIrOv089p4MF4vh0ya8UjOw5aFc2CK6F6528oZU+amYICLsG3FH
	wc3GRW6Cpg09SVjrge7SnUdkUIGLUbqpXgnSg5NBr2wW7g5dmaMjlVqPiB4syyLBmA6beEF4+r6
	8V2gODy5gt+VIa6FhcAY/ciFrmGH2AX2Y7lliNm+Sp0Hulrm5CCZuC3lG7w8p9DkzyJR2OndIWN
	4RR6nG28+e6/jY3VTK5Wdz22HaUYmvoJj/TSFI0PeYnkuOa9LcpI=
X-Google-Smtp-Source: AGHT+IEQhpxP5sR16IKQwYkgzpXNVxpWWrQ4zHrWQnWyvrEu0FMk2B/Vn0y3xpS6mdSBtlKmmVHKCw==
X-Received: by 2002:a05:620a:2915:b0:7d4:653a:e9a8 with SMTP id af79cd13be357-7e63bfa2698mr606426285a.48.1753504421425;
        Fri, 25 Jul 2025 21:33:41 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:41 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 07/20] staging: rtl8723bs: align asterisk in block comment to fix formatting
Date: Sat, 26 Jul 2025 04:32:05 +0000
Message-Id: <20250726043218.386738-8-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
References: <20250726043218.386738-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aligned the leading asterisks in a multi-line block comment to maintain
consistent formatting and improve readability. This aligns with kernel
coding style guidelines for comment formatting.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index fb1768284c2e..0c985593ff0c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -842,8 +842,8 @@ static void find_network(struct adapter *adapter)
 }
 
 /*
-*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
+ */
 void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
@@ -878,8 +878,8 @@ void rtw_free_assoc_resources(struct adapter *adapter, int lock_scanned_queue)
 }
 
 /*
-*rtw_indicate_connect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_connect(struct adapter *padapter)
 {
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -897,8 +897,8 @@ void rtw_indicate_connect(struct adapter *padapter)
 }
 
 /*
-*rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
-*/
+ *rtw_indicate_disconnect: the caller has to lock pmlmepriv->lock
+ */
 void rtw_indicate_disconnect(struct adapter *padapter)
 {
 	struct	mlme_priv *pmlmepriv = &padapter->mlmepriv;
@@ -1501,9 +1501,9 @@ void rtw_wmm_event_callback(struct adapter *padapter, u8 *pbuf)
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
@@ -1546,9 +1546,9 @@ void _rtw_join_timeout_handler(struct timer_list *t)
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
@@ -1666,10 +1666,10 @@ void rtw_set_scan_deny(struct adapter *adapter, u32 ms)
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
@@ -1748,10 +1748,10 @@ int rtw_select_roaming_candidate(struct mlme_priv *mlme)
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


