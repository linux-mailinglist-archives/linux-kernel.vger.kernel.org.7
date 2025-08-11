Return-Path: <linux-kernel+bounces-761851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A5B1FF4C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E58189254B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463142BE048;
	Mon, 11 Aug 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+EKsLVY"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FB299AAF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754893375; cv=none; b=mrf9KWs4LIN92hnl6cYaK9ekNGeORBqmQd+mpNbXXMvnMsKMDtdkToxjgaSE16cS3Ch81xbLAA7NmFlpDmVNSoavRBVlfB8r6WXqlHmvhg8plo/pmYFR3UXUO4ZXNacle006JFhbRIMK5ZhbLYbRzjzbK9S5cuFUCmWUv5d6rqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754893375; c=relaxed/simple;
	bh=vb944XmRUx1hK1TdfY4vUMaT4mPgrvMgW9KQwecjivM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTlpZJhFof7SXj6beq/yWbXW6gmjsRdapOTsaxoGfxduSvAV29V5a6qGHSidvYFzZ/qvXJsyi0I8w6m6NFGZXHTvTYvi+IImcHLsEnznzVgSHGS9Oak+CdDlgdOWzpLhA3avzTRKsTfZZHvikHT5tos9a/FHJVqoidwkIhh8/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+EKsLVY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7682560a2f2so3965537b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754893374; x=1755498174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+rkNoJTJE6rdyEv/+OSh145DTnxdctDpAvN5QptM8w=;
        b=I+EKsLVYF1OfurxJbT2DrZoAJHHQFRKYnWMSeVudUGnOKiFn8aAUrvLcZrMYQtiSwM
         03No7tyA6eGQ5DrDPa3+V8CDlMVqe3ZZt7rfYFKCgpw+Ex6AfbK68ZxXTdM1o5+vWlhq
         Kd9HxgM+WI28fIJiVEXRdda2ParnpUbrP7nYXyDS9siH4ErhiCcSM/UEETY5ERvoM/LR
         ehq79a2QxIzsURzB5AaresF8FX60LW500sqv3YVkozuU2JiP2Qqb1Urthu/kMTZWJzPC
         Fhn04avIGMwbyZQmZa7TPz//W/OhlWrViUGSmsQEXuOxl5HiGteWyj0+/iRacZq9crnx
         z5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754893374; x=1755498174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+rkNoJTJE6rdyEv/+OSh145DTnxdctDpAvN5QptM8w=;
        b=F5tiCji9H+mbevJ0wpMdka6vy3fiNwbYYonaCHhO4cd+8y/N67zt6kWMO7CB0paVWA
         HHEzrrdisdlmm1hYc85ztB4PBHPP2sBXSwcvvI9d/G9ym6L7UsQ61sWScNJX0cH9xhi9
         r8XjqcbPgc3S05IGotxsKDCVigb7wtC4vLCQnihdGXFa7BEO1fqOYEXDrw5Ew9S0VZer
         4+67eu/cKKIomuTXu27jDDga/3gSNWFod22luS3VqUzYDwSjF81RUzifb8hAqIf2rBR8
         tieThfKfoNR9x0UGp0eG8o5X+UDLR7NwhsGGl0Yi+T1tlhhZrXqZimZkIqGcWnMJJKC2
         K7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr5gdgynozSfM4359rwDz6gfixTAcbGoakS5eRXWuQX9qLVCBDB85QGvtB4qZh9S9Lq2RWwyPHO4ianA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CsnL2cJ9iqxfGqp03lTp/gUrGoHDBRj4edOtRkS5ISFdgDXJ
	tD3xYNUwjBrlJGTfNy13DamcODh9b04tso1evjoFEvKm5Lp+vIbPUSJy
X-Gm-Gg: ASbGncu6fZXgvbjbfJE8X1toOsyfIBKhmPsIf5vzW4TSnCgtjiU0anoCzUh3yUBoYDU
	UDPGNVtDBPcsIfs7rLu6nNFenZfh6qEuDbLgpS6ljFnCHzKvKWMz6c65okXJMyTviUeyPwNkSPj
	pCo27AiokfXkjUrGO/pbBt/C83GS8jyJry+gEyXLAuitzfz3EyqOV1STqQYS1xWINUleOqhxSIq
	WVHHDUxaeYtUdKWK+OleqhX8v7HITpCDeIFW6fqwgrrFcCbVl/d+Qbl/9iIVYilICJb0N3HFSwZ
	BUdMXkWAbtFp3bBB5jcBn+ZolbC23SlXrCRxB4rVzULZWI1hGNtZDALdTthPNy5UVpceokobgAs
	TH3GiYtd690WflaiwiqJsISbgew6bt/4JiZSh7uZZcrOoyyonepKPtsEHCHD8nMdf9rt4sd92VW
	hgmIHXpFho9mMBOk6KvXhty+psTLDkMGtqqr/249ab
X-Google-Smtp-Source: AGHT+IGISaQiNL2nljP+IMsXa56DSbAJrtX3Akp9ft4bJjSSyk9kRYZdB6UYHvnM4Se3HvX+ydFZUQ==
X-Received: by 2002:a05:6a00:4c8d:b0:76b:ea1e:78b9 with SMTP id d2e1a72fcca58-76c3727388emr20855456b3a.1.1754893373523;
        Sun, 10 Aug 2025 23:22:53 -0700 (PDT)
Received: from wen-HP-ProBook-445-14-inch-G9-Notebook-PC.. (36-239-105-221.dynamic-ip.hinet.net. [36.239.105.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm25861623b3a.42.2025.08.10.23.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 23:22:53 -0700 (PDT)
From: Yao-Wen Chang <changyaowen19980629@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yao-Wen Chang <changyaowen19980629@gmail.com>
Subject: [PATCH 03/11] staging: rtl8723bs: Remove empty line
Date: Mon, 11 Aug 2025 14:21:26 +0800
Message-ID: <20250811062132.102525-3-changyaowen19980629@gmail.com>
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

This commit removes the empty lines.

Signed-off-by: Yao-Wen Chang <changyaowen19980629@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c  | 2 --
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 2e59a26e6318..fae557a0d143 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -438,7 +438,6 @@ void update_bmc_sta(struct adapter *padapter)
 		spin_lock_bh(&psta->lock);
 		psta->state = _FW_LINKED;
 		spin_unlock_bh(&psta->lock);
-
 	}
 }
 
@@ -1258,7 +1257,6 @@ void rtw_acl_remove_sta(struct adapter *padapter, u8 *addr)
 	}
 
 	spin_unlock_bh(&pacl_node_q->lock);
-
 }
 
 u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index cc2ba213d07e..c4ead692928b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1260,7 +1260,6 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 	pmlmepriv->LinkDetectInfo.bHigherBusyTxTraffic = bHigherBusyTxTraffic;
 
 	return bEnterPS;
-
 }
 
 static void dynamic_chk_wk_hdl(struct adapter *padapter)
@@ -1480,9 +1479,7 @@ u8 rtw_dm_ra_mask_wk_cmd(struct adapter *padapter, u8 *psta)
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
 exit:
-
 	return res;
-
 }
 
 u8 rtw_ps_cmd(struct adapter *padapter)
@@ -1552,9 +1549,7 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 		} else {/* re check again */
 			rtw_chk_hi_queue_cmd(padapter);
 		}
-
 	}
-
 }
 
 u8 rtw_chk_hi_queue_cmd(struct adapter *padapter)
@@ -1923,7 +1918,6 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	}
 
 createbss_cmd_fail:
-
 	spin_unlock_bh(&pmlmepriv->lock);
 exit:
 	rtw_free_cmd_obj(pcmd);
-- 
2.43.0


