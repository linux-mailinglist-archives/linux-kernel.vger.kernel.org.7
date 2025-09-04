Return-Path: <linux-kernel+bounces-799730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC9B42F92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 287387BACFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D405B2367DC;
	Thu,  4 Sep 2025 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTSXUCrX"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BC224225
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952118; cv=none; b=ldzVoDhIQ6ADOdDrLc3jx6JnD9yD7NgM8nQhfX0kzXptlpmfkzal7mcmLZqlyN2rm8bQty9+y1MJeNtIN3ijFRhuFqGLaC0Yc+nu9BPvpgL87sVJNzV3j3zRsVyNBuprLZnGkDBUu/Hb4LGgErX+dzyWa4rZRgHLQ3e59Ss6t7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952118; c=relaxed/simple;
	bh=9fcSU8PZLc3G53yaIKcXU1bm8+vedTHObY8TmTInhpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LXzQfAe1SGtbnRwZr4W4dCv2NYfYQ96Qz+RL0kY12JRThnHlOYMGMX+YBa/Phn+dbwPMkV8jOz+yyscKtE/NrKpIFYjFN3qN2ru7ccEgTvX9NCcGJOTl8KCb1IqTQ4vlhIv2P2xtkZuzaAvTGiR4ckbDKu5GbQLAfHHvMe2kWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTSXUCrX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-72226768824so4328866d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756952115; x=1757556915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=DTSXUCrX5zPAe+e8sJgDDg2o9IvSv/lqjQSSeqmklrD8AGQQYqtO0N9Xzxdf4rdxCs
         oxN+I8B4VAXf6EylzXobgW11r5LJxl3YLmZwsHaODOz1qtYoYLuXH2841/8BfsJ8CvAY
         UlMWD6tChlF9pPeR01Mo8s2LoEtbfnncbhOzRAa4lm4BnQb22mfV7wg4skXv9hsgcqug
         jF8YE+C5LCsQAU5bG8QBrYsh7W8A2RE4YYd1prHz/cQgjCpNx2MoQPL92DRlCrkI0bGk
         sVGZrEYgcCv7YaUno2qXQBvQmg/5nk3SHXjfMuMWcB5YXKVAafdGPKxNFbpNJ3bGE03/
         /lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756952115; x=1757556915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMsQLzfREBWexRu+GN5366HpVTxolXnaYPuOdM55sFg=;
        b=ViBSWMTWJPWLnm/Q8xP4GlSf5kVi2Ye4DQMF5Dd5gqeShyAk7PVYEAo+bMQzSdk1qj
         e/QbiemClePx962bnAcwRznMMTi6hscTg/SZP4M/i/zfJfCT86GiUArPHnnGg+OrUQMM
         Er1GtKQRvkZSTmsicl4C1ki6TbJln97ZvuyHim7Vp0VA0e2zw2DHfDXq9mO8Q+LFJNhT
         FqB/cnyWib6I+ogX3090O802MZESzqlHNMUMqtbQeZS53NDy3ZlAPdUBQtocZAOVxxrD
         XmLnYmBiBq1kMbJpia0WgDMcJheGWiEuDDXBxnTpziEIrftxtUi7ddgzo/xSMaaprK8P
         brLg==
X-Forwarded-Encrypted: i=1; AJvYcCUzVKtS1L1NYT2gQ3tcRzZf4NrbFyOiguFuJshurEKmXzgIlNOCnrYQfimyp1HF2ugxFPvtBjs0+bNv0uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmJ7pNiP9sV6KjNnVb3GTX8CyZyLix/l9GsetRhd9QcyaXfnt
	NbSztiC4VQ+uR9Rrbi+4dCOs6Qeo2540E3vAjLd60nDFv5PUr3n3iG/XF3zOcQ==
X-Gm-Gg: ASbGncssmzbwyD/Nsld4MuWHe5JzIDCiHM9G3sFoTO1V9fAKyB0EOMciEALyVLYpdH7
	WrCIGbqHetR3CHuILczpGTKX6JeCQ8eZuj6othIqU4xkCmiEzXIx2zgtSFQr0Oo1BH5aYRQyzVH
	BEy1AI86vkwbaAZ4sy4DhP7+R4rxQ2xmSkAsw80Skiu7Q9OEgj4syq7pMuU3BLUg52wTRUPukzn
	ZNaPX36kbKk5vpuEsSW9J9hlSUPVfE+dhergHeqUYioTdGj13McsT6x5xqE2OSyQgJbcdDlhg+P
	tqXh14Lc/s0Bg9bOHM7qZzmXNIPYODB0aWKX4klMJfWdoggAARp6ioLovJfw0x65KcOnkiQqLEl
	fbcEdqalxojIKYrfz1XXe63QlrW9RP87F/tw8/xlgl83x+MKGjqk=
X-Google-Smtp-Source: AGHT+IHUXNaffbsZdMbCgX5ExDY64JlgIBmgJ89fMamL5Y5pBJVeELzY7CRcnq2dB8wPzqYZv0uKlQ==
X-Received: by 2002:a05:6214:1c82:b0:709:b92d:e84 with SMTP id 6a1803df08f44-70fac75c92amr207317956d6.16.1756952115169;
        Wed, 03 Sep 2025 19:15:15 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad2cb78csm37714076d6.19.2025.09.03.19.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:15:14 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH v2 10/16] staging: rtl8723bs: fix unbalanced braces around conditional blocks
Date: Thu,  4 Sep 2025 02:14:42 +0000
Message-Id: <20250904021448.216461-11-vivek.balachandhar@gmail.com>
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


