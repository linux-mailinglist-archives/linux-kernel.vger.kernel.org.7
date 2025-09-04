Return-Path: <linux-kernel+bounces-799671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6CFB42ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927911C2344D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC11CEAB2;
	Thu,  4 Sep 2025 01:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyxbor01"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEC374C4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949353; cv=none; b=GmZ55Yhf6gOyzz/AYaQYfhTyDPAKEg5ZFUamiZGkpVldgC0Tpgz7gEKUzc34hHc/0BmPiEqhgd/yosc4ee3ruYHgr4St4zc0OZ0pVrYgkUa/wCSkGRiNsDKFu7xRXDAfdw3sI4QQfy2SgcYWkmdmGK9Zin0zi+8MhI6KR8dQuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949353; c=relaxed/simple;
	bh=9fcSU8PZLc3G53yaIKcXU1bm8+vedTHObY8TmTInhpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlADaY6EdrJ/77WtJgfahi6mfZoIaGrXR8oH9yoq1W9/YU7gF3dr5Qix0LsK152SVBD9a29xNkmfiAKSTh7r7WcIxtRkgQC+pC+BNxVYc9qvL8C0ifg2izd03YkjMxqaRyJRRV6UAgHmyfJ/aqmqxVLMStoW/blsr3izcEmnOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyxbor01; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-804437f9470so177580785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949351; x=1757554151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=fyxbor01sFU8O7IG90q4TjEUWJLl7n+vC0fVd+shJRGiIwZa2bp5nDgd9fYtNokUC3
         xPJTGlidlfZYM7aVdWhkbhezSBJv+tLRMFutlp0hY20iabw7nUMv87Coywa0fJnNQs/h
         GlpUVJ6aX3481Y/p7OAc6DV2Ws1guLm2CmxVopPd3tz1I0rROQCzPhZ5BjqkhDUYzy6h
         /Yi0lU1diXqOSPcbM3r3db1Rpl9q/RKcxBRd/6EUfCl1rlqPg91EJAoMUSgkeIxefYxR
         tg9bvJwCa+oC1nTzratJu6IL16PUyCnkk2/itmsSWkvxdYB/bxitVu9rehvKREoM+Pg9
         R8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949351; x=1757554151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=dlfhtzVpy5bVVQElfXD7/AuSRJtC3TjhHV12ISb/CUAVm7rXI1FMfgwKmhemGQiRuE
         a3jgffMHcvZKBomMNjcm2qDHIOAacgtnqvoB8ypNU8jDheiapWAur0IHAJ/8GrLHaUdy
         faPkKySiUS+BHtr++tShQOGJDcn5TIc5GDOyck+GDYLmPnFBBDKBuNXMY9JsfIDoVaQ+
         ANlgo/HgXCuchdftB1Ql++5JUaBRPyrMjh8A/OXWl6SATzXR1sN5NIzl7nRhCLlHBl5e
         Lrmf7uSJ0IbaU0u6eaG0nEcERbwYA0TswttuEw8jwdktNwkJOXbQZ5JFDUYtXc+xVDXx
         IPaw==
X-Forwarded-Encrypted: i=1; AJvYcCU//FgqNBhup6F5aLxCrbzGFMz3iveLYWymQ4bvuUDJzqEfMkn+iWK7Pnf9U/pkNCFlZezNNKN8QbC+Kag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWJQL5n84DtJTr1zvtIKQYSK+zsIGowPdqkTVQDPLh0zMK3cg
	zXAyuuoDMqa/nbGKiRbky9E6I7JyOFQkSn+pkm+H+uySlYvnVlkfRGbzQH+koQ==
X-Gm-Gg: ASbGncsKLTWTv0NX2Vu2Y2jEmXzbvYjLRyZv2Kgjo/MDA2C361yTze219i/E7hW6hNa
	W7PuR5/F13E4Qfd7atAcHrUZDkIHMMf8Rn+pTVXm7jkCdZfXmj0XvRDAJLWJwSuB5WymQs+g28G
	xbaggLTwQI8dfmixJkUb4a/O86P/hcKYmIBkOwYHICQifhtIxxMFnO36FjSQtbpAeYr/9pGYgUe
	SS7D6olX4tauvf9W+rVcNuqbenmdUhuczN+fqAtwWVaesDTBquTKd5X/V7NzmollGQPHimhgmt1
	QsNYi80un+falbZFHwM5/BqA2iOqKoX9q+yLC8oh/EfuGw3/h+jvcn0ldyZFwuVDLpIUAxLdjKF
	DHNiBsHeOdT6ve2Gl1p0FSNZdxgWcV78nY0BPqxSsZjQC93s/fqM=
X-Google-Smtp-Source: AGHT+IHnPvuUC3nlAXJVULvaOVMLtqz2tocTpafM2+s2KrX7WNkMAz9X971W9yQIS+h53DhrHk43Dw==
X-Received: by 2002:a05:620a:710a:b0:806:6a46:ac20 with SMTP id af79cd13be357-8066a46acddmr1062226285a.3.1756949350976;
        Wed, 03 Sep 2025 18:29:10 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:10 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 10/16] staging: rtl8723bs: fix unbalanced braces around conditional blocks
Date: Thu,  4 Sep 2025 01:28:53 +0000
Message-Id: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Balance braces in conditional blocks to match kernel coding style and
prevent potential confusion. This improves code structure and readability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index a2b1e34765ac..050fc54e251b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -785,8 +785,9 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 					} else {
 						pmlmepriv->to_join = true;
 					}
-				} else
+				} else {
 					rtw_indicate_disconnect(adapter);
+				}
 
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
 			}
@@ -1674,8 +1675,9 @@ void rtw_mlme_reset_auto_scan_int(struct adapter *adapter)
 	else if (rtw_chk_roam_flags(adapter, RTW_ROAM_ACTIVE)) {
 		if (check_fwstate(mlme, WIFI_STATION_STATE) && check_fwstate(mlme, _FW_LINKED))
 			mlme->auto_scan_int_ms = mlme->roam_scan_int_ms;
-	} else
+	} else {
 		mlme->auto_scan_int_ms = 0; /* disabled */
+	}
 }
 
 static void rtw_auto_scan_handler(struct adapter *padapter)
@@ -2412,9 +2414,10 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
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


