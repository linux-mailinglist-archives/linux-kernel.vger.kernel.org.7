Return-Path: <linux-kernel+bounces-840556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80098BB4ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613137B152A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877D27A935;
	Thu,  2 Oct 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkqWvTkJ"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69D27A924
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425849; cv=none; b=XKrpP5CtBIirv9mX35DncDzAGv1rFl1NaT7yFd0MnR2W28d2BjPSu/CeWpx2dzObPK1QyO5gUwrL4jNONIACjPs0UPvTPhw6hsw3K7eIR07JrulfXEtk+IblYHT4HxGmjBzFD+8LC6sVYbmz/sokGkwf/LV2j0Rd10I4lJfU9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425849; c=relaxed/simple;
	bh=5n9IQxhQnrtRL0g75FJvXbLi6NKxdrA+D/K1gRh776c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XlAT9gXBJARdi4SWrhFSiyQ56KvqYBKE+EGT05cHXSISXdczp7BsSU2LXKZ97Tuaw9shALY9QtfPViAnVRAbN0E9JZSGS/oPBWoPB28WSdbd8yaBybz0aL75Jo9FAFHR6ilMWJjVJoVBecMRxdZvTFuoJrsXB17aMyCkLcMrwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkqWvTkJ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4e06163d9e9so12411511cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759425846; x=1760030646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=517GtrgrBRpB5jbWrmyDvVuILb+G3yKPnRvwoNOqYBg=;
        b=FkqWvTkJtnSYXeDs8jGtRnQxrOW1Cf2VeAAeX3mxQrUgffzBhtEX/P1n0CXwaSKywx
         RfiLuVYWd7Ph6hBDxIUim/lk9CRKy5glCqkOBTqI/29sDVhUSWAvhXsfe77o5eBzeYYH
         Ct511h75PRlfIopeOkWp+y+LewX/kHeDaiUMYLrOyTwL0XmLO2g1l2BMXSppcV5yp8dO
         ylp6Pqt9aOkNdpyzHFqcBDyp31XuZr+vF54uNt15jCHYZ8zMqEvFieF1aHZ7mCv7mPdk
         cAFQy/sENHb4RVPLKggpo1OOm5XyHArbF/8z3sttgsxh4VYodt5LjH1dkD1TBV/rKq94
         qMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759425846; x=1760030646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=517GtrgrBRpB5jbWrmyDvVuILb+G3yKPnRvwoNOqYBg=;
        b=T0H2PiNu/bxVS2iDUAJoU5X2bgvhBREX9G1JWnKQzOvUjYZu/9v7GmsfB/Ak3C91/S
         bzkly0YjbzoeGNbj/du6O/w7vfEZN8yyIII8udOzsZIhzektWH1fZ1W0+J6een6stmgu
         iknk6F9T8wfaUi3DdN9rJw4ScfNawDBZ/0WpTMuctiL2ujwNExxwD/tQynmJckzBw2Ix
         byIjoKDJusG71XiwdEkSUY9EmMwYlIr2WSf35Jhbk1mBGeKilCzAF4w3TWnzYQBG6yPh
         XcCeXjXt5Sk9WdZfLCIL3o147tq7tBqRt8XoC1BdS8kC7lKH4EhIE9VVrAnBUzBosZwu
         hn7g==
X-Forwarded-Encrypted: i=1; AJvYcCUq+Cx2zA3NML7nRZfYVjax8NHt2HV/cvhKBnKzbwoI7ixnCi8ODcmmN0lPogtaOn7sw4iSxFx9aX870HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6jFfNzyQ5npTVTdwEQ7MbEhEBiBALFuDKl1QWNlKEz/YShEQ
	JIuTEZ5gZpky9m/q3G+79XPqfewWDNUoH1djBnSHZt1tUmxd1l9Lyt8s
X-Gm-Gg: ASbGnctwGwQhzpZzpg+wKDZlgRZyGTO1HXGsZCswV13ff0maIxQZ0pQO+r8oEU08C5g
	wodNUdPVGINuX9nk+toiG4tvsCepVsZRAqxsldQwXS0/ELkB0QEWyCWzlX2aalVrSirEEqv7L3S
	3zbT1kRYR5zWJ/cpw4svXjgXhP3xNjZThCC2NusbyOjnVBjXSdCX7ba/z2u7WI6XBaIMk4n2bYg
	2mjmNNn4by7lGIhZhJpZiB5qKQNKlHzPQAMtC+HAGSXKehrOuos0J0r8aRE90MnshLySKevGgVJ
	6xAoNGnAD81TROfF4ppMSWxQhua8SGnoiUu8v7Mob3My7uqfG0Fp+wJV/Lm8zKVUGEiHpcKEKat
	IJkj9SBR2TWoWrP73ckLI5+Cvq6wBQ4v8wkr5sftyN4zLfwoT/IE3ACe8jVlA0SQT/vEq2YCBaz
	EH/o92Qdq1fQ==
X-Google-Smtp-Source: AGHT+IF/k+pp7Xny67XggJRcWmhBUxIPgP+eUxWO7RljDYDoYdWsdWHipLMnddwW7+4lj23MCbNDCA==
X-Received: by 2002:a05:622a:4d0e:b0:4dc:cb40:7078 with SMTP id d75a77b69052e-4e576a3c704mr1717771cf.19.1759425845748;
        Thu, 02 Oct 2025 10:24:05 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cbd3d9fsm24504971cf.32.2025.10.02.10.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:24:05 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v4 10/16] staging: rtl8723bs: fix unbalanced braces around conditional blocks
Date: Thu,  2 Oct 2025 17:22:58 +0000
Message-Id: <20251002172304.1083601-11-vivek.balachandhar@gmail.com>
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

Balance braces in conditional blocks to match kernel coding style and
prevent potential confusion. This improves code structure and readability.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 34fdef878b51..14015541557d 100644
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


