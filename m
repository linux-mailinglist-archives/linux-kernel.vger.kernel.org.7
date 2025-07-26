Return-Path: <linux-kernel+bounces-746619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD2B128FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F821895B39
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2829221ADA4;
	Sat, 26 Jul 2025 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6wmrZ09"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03121A428
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504439; cv=none; b=newFBKt0QiqSnsEjjDRxcDIUMsDZXmGw1uUPKT4jfdfdYxWQVvPDPHP8RTeg/AFDprM3Gh0/6b5f3Ks9cmAkjdc8AwHcK2QctDJioFRpc3AAowwYopJJg/AJ9qgg9Q4aUwTkwpqUy2vsilRkwiqXV3XgdG1WZqo476SMre5cZ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504439; c=relaxed/simple;
	bh=bHpCkXw2jAUbdB0APKtn+P8IbyPZtBP4nbGI46DyLuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOUTvKRIe6BR3kEcKziar7IOLEMtUX5OUQJFtEc4fjbN4viiehzaxiqRrPBh9SUB/of/g1tdiBzwq7Xd8l36PANBnxXcLqMqedgzMpR4668Yp4xX9XXANdn0v0yJC7ppPz1unt4gQM8jE+QoWBF3/yGPtZ4+mEeePneoaD4Kmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6wmrZ09; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e1d89fcc31so273928985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504437; x=1754109237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63m/SWyED5sYk+Oa2JkBziHJjgzvSnwpbvgqu5JEyLM=;
        b=J6wmrZ09NPufAjTl0qbWEeaelwWkgs4dr7cK2nDs1HJ7qGZPNhfUVEGdL9nt1lowBj
         tnJx0DD0+O8QDUtPTD707OYLXmfRhKUu0ZmPvvCSyr7KSPgVB9O/eez/ozyoe8RY9aCr
         znQUV+wUuzStPDk8+80ybGwy+6lRhTrBCsOasCB4W8lmFLdY44peceGZ2a/V/FmFMr4u
         yM/futW1UuG0fSAe7cgsqn5px30rFGC0IY8WdDOefkVTKjh2sJncmPWCVdVjP78G2mQl
         AAz1MmEHlAzd2RXkQmmjh4ngza1ZfK0PGcRsyT07TD+Z561v9HDNABUWAdfnNBErqLb9
         eukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504437; x=1754109237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63m/SWyED5sYk+Oa2JkBziHJjgzvSnwpbvgqu5JEyLM=;
        b=AChdXUz2UYOPFqGpsRStDpEIQhDZJuKhviBMpoTdGt9iNTcOpKC6hGranrjzhBRjVf
         QIGYkEKUnXnouCyqBMC/AnKTAPDj2dKdeUR95G6n9uh78iGI1n3ZLb1Yct4rEM3T7J/A
         OXyJRaUq+TurxuJbYeBZafbU/7gcPxVBAi3mckY0tkOGduEcxHDDhSGdfWNpYOYmNUP1
         U0yr+C9GGhj0XKpyINkMNQ7IgGkzV6bBBUWO+0soq1Tmj9K20os3Lo2IkwNw2IBn9mQC
         aT4G9EIrAWj4duYId6SLvlWLBw1xJFN7er/gepxppQWs8ngQq7CkVpP/dYELY9rBkCdV
         6mcg==
X-Forwarded-Encrypted: i=1; AJvYcCXbatX3fMSVxQlEttTqfFgdvRgfUBZ7ul7n7cg2u8c6IbGvLD25CJB79WpTqrZkMOQNxAdwD7VhbqlKqQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwpkv2PK4NKOJYo0CjdT5jM8LELJBmVojCtKyF1b1irlQDvSo6
	+GYoSwaWDpEQyjizl5QaQkCrmDH6eG7ENSF/waWcn88WsvhZO68CFqkGwtFDBA==
X-Gm-Gg: ASbGncuP4fuyxSkC12oAEM4fUJv1+kc6tIA2tRyKLnJjRvckcyvwy8ZyXxGgvTZG69M
	nhOt2yyo1A0zI1nYEEkZNeGgOKmFe1zdWlELeI2JmsgbRQ+W/PfKNKFgeXwMFHfh6+2dDMCh57s
	ziB+inlNtoeRHLHSkQn5eDLUaqKvObJyeRaq7jcQXoB7sA3KJSOZu/MuzCMX6wqsjfplYrQ+LSZ
	Jt9YxHVyhSNz+IulvqXnnZI3amoZVcFts0BUnetNgCUpOPO+mzmVZ0WPvBNrmdyQ1wlZaj5tYuJ
	Alpx1ewzph8+z53N6nj3eKZUyPdrbYrt7+bEg0fBREJDY1Q1tgPZis80UP9vF3PNduVZTj/FCY/
	VhW2Pv8XhLzbk1nfUkJnutfDp2JQ6VA4NGupe4heeDIEOL9x6qFw3wT9LeZtp/Q==
X-Google-Smtp-Source: AGHT+IGoCI3vD+pDpwPHdI/MTAevkKbu28bSsdg2wSHhYsvByghAdZ5a+1YJUELp9vOMzDuwhZjohg==
X-Received: by 2002:a05:620a:370d:b0:7d3:f17d:10c8 with SMTP id af79cd13be357-7e63bf9d6d5mr613157185a.43.1753504436927;
        Fri, 25 Jul 2025 21:33:56 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:33:56 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 13/20] staging: rtl8723bs: fix unbalanced braces around conditional blocks
Date: Sat, 26 Jul 2025 04:32:11 +0000
Message-Id: <20250726043218.386738-14-vivek.balachandhar@gmail.com>
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

Fixed improperly balanced braces around conditional blocks to match
kernel coding style and prevent potential confusion. This improves
code structure and readability without changing logic.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 0679253355fb..3702d7e7a954 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -758,8 +758,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					} else {
 						pmlmepriv->to_join = true;
 					}
-				} else
+				} else {
 					rtw_indicate_disconnect(adapter);
+				}
 
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			}
@@ -1578,8 +1579,9 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
-	} else
+	} else {
 		mlme->auto_scan_int_ms = 0; /* disabled */
+	}
 }
 
 static void rtw_auto_scan_handler(struct adapter *padapter)
@@ -2281,9 +2283,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie,
 			operation_bw = padapter->mlmeextpriv.cur_bwmode;
 			if (operation_bw > CHANNEL_WIDTH_40)
 				operation_bw = CHANNEL_WIDTH_40;
-		} else
+		} else {
 			/* TDLS: TODO 40? */
 			operation_bw = CHANNEL_WIDTH_40;
+		}
 	} else {
 		p = rtw_get_ie(in_ie, WLAN_EID_HT_OPERATION, &ielen, in_len);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
-- 
2.39.5


