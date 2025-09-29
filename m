Return-Path: <linux-kernel+bounces-835845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06BBA830B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148421C0C49
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880FC2BEFF0;
	Mon, 29 Sep 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m654r3tk"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACC92C17B4
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759128653; cv=none; b=B7mZE9KIyztuRt8j268UoaSKse3Gds+vNAskNYb8pcYBZPbqnaoYXdVwIsomybd88zWIfyn5BeILL6JYRsV9FpVFVjQplq9KkN26k+jG5A5TYYUYizdJ+JIF3RnYTERRkkVjEEvrnJsSR8yf+K5mR4hU04oHMLzRA6JOwTVH9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759128653; c=relaxed/simple;
	bh=9fcSU8PZLc3G53yaIKcXU1bm8+vedTHObY8TmTInhpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SHxmRcW4scfuJZ+J7vJ6tQcGus0wBiN7bjbeMCEmYOJxm0XJBLINncpf33/kvvfRG04wMT4hKYbHtaoSwUPLq82zXWv47aZCgP4Cqb420DS0r2mmMAlvcBTv/2+/iyLLTskUjr7zppIvSOSVgZYklQ7LNKiWUPS0Awre/JOt2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m654r3tk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f04816589bso458140585a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759128651; x=1759733451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=m654r3tkiXB6k5fOkHbFMe+WBP11rZ39OiYiIRymhxAM9IFZMdqaXv8vQz1GQ4aOj/
         x/OmC6E3k4RltatMln9jj/6xlDZd2XP7+xl6fwGKgBEYwBMbLSlbsMOAQxlZ2JhJTRMJ
         z0mnmMTr1j6wgkSYLqrIrVbAfi+i5jXjAEb7kdj6SLD/hkXhimtD7WHgT8FjKKSI5vmh
         CyX9exGGnyMOAJp6liMmru49NR3494OZ7wWhi4OLJFxBZ2jyjXGRumxFG8TQMDUOk2CZ
         oEeLgjvnreijGGXOCkbhGNLZiy5sF1ukApc6NpgmZnDSsfC708wnnm8NwqmR/2UbrTZv
         Ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759128651; x=1759733451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=d4ky4ugy+w11r34zxtevETcbgMSrp1pYaXmdLmVmXiSX2QGNtV3Z522odmp+E2NZ3Y
         3DpVLJG9zrgsWj4/q927hJOUXDMuHO4NfNC4eFZEaTMsCHDqlj9h9OzF2xd+8s2t4+7G
         7xfAzkJtXJKekeBanES5XsaxCxJG7k92BVZmtpPg0wAZjLVY08rZ0opwSwOrEyhNdRdn
         uwO8QId6aDUIRVkR5li554S1DnCjLwWdOhCfXPQC+D76TJJOIUOd3ZBYl/iYbWgKmesu
         SyFOo4PrSkP8DdSi3inX/sPz3PcbJ2dplexwq0yAjTqMr9ECHdpE9mqQZdHUZSI6Y1LQ
         Kq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnkbOEDPJLMqnJyofYb26mYdbjbJA67K4KbCllfzfNIWMtGfBICDyFUQCNpByMlRxPCqMTNc3L593D5KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLb2Z3WqS5MYD28ApRljd7ERtbQuVFJ2vnnAZphc7QC5kLZ9+
	xBdAves3gLkdEppDsZileNd+T+nvawolIeex4po6tPrbRQOUVOKL/26OD+mVFw==
X-Gm-Gg: ASbGncsLHhKrAtgFxDYO37YLFHZ2q5xJzVNKG2Q1irR/OjsXe/cVwOITE3yXOGBjLpC
	5dXP8yB6sMk/luUmxDOU5MPBFaUEQEetKctV6V7ICnCSnGNfmwtAqU5H2R70vYym3dtTcgKsQyY
	VB7DKiPeRMTg3N8LWG3dVZyRLfgnlNfbMiPoWN8nDG8t1SIKbE4o9Wb2tsJ7StsMSTfK5AV8FNd
	0j4xJpo4mmB0hs/8xE7mxoUIesZ/sO3T9B+8OuumBLA/bRJ2m+SmDH5P6W6F+8fYF3US8sO/SV5
	/RY6jPmhkFsRMR8Ykkc3gxeF2xBBkDTTADDH7a/aQBQ78F/iDu4AFJ2Mf0CtFxnz+asMjQhpdFS
	/0jPH2pqK3Mmfrm2W/ciF7NOaTRXLNKFJtrE4PP3TZy0ucI74qrCWvKgCkDYznwAEW6aI5qQp
X-Google-Smtp-Source: AGHT+IFB/1SUb+6v70Lzh6OZRArqaQYJpAyAMMcK6vy338KffvxQjyIMHlnHN1YoJ0dqTQNeW7NY4A==
X-Received: by 2002:a05:620a:394f:b0:85e:b0:e5f8 with SMTP id af79cd13be357-85e00b0eabemr1847528885a.13.1759128651012;
        Sun, 28 Sep 2025 23:50:51 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874bb9sm69517671cf.24.2025.09.28.23.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:50:50 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH v3 10/15] staging: rtl8723bs: fix unbalanced braces around conditional blocks
Date: Mon, 29 Sep 2025 06:49:55 +0000
Message-Id: <20250929065000.1010848-11-vivek.balachandhar@gmail.com>
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


