Return-Path: <linux-kernel+bounces-842356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FFBB9921
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D0DB1894336
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0FD28851F;
	Sun,  5 Oct 2025 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN0YZmx8"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96A28727C
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759680022; cv=none; b=RxXukauecchVkWqpQ5Hgu577W0IZhRxdk/kL5WVak/TgPb7pmndqv5gARDZqVT5z9fDUVvBIaIJJ4XRs+72HnI9CcKzPG72/X6qfLcfwYyJAxnE9YRO0tnTDDPHug2nIMfHhq2chAUdULaDbJcLpDex3MpvE7fViYYi42KA7NFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759680022; c=relaxed/simple;
	bh=KtXar7DZM0l2+GL7nQOIJKmMTbYu5UycVXVuLeg1o74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+ahvB2VeSGgrPfGgLuKFEjnozwWn4S6wVbeZsR1xwmOgw3DkWo1EGJSqzV9gw/qXT1FZPZdIPUWGwgmZD5GTOAmpGvzCLJt4V6wgBWF3GwTuG+vRqvyI1ZS1t7dKmULxfmvp+NrRnOJU2/n3U0UBm+3wKMdSXOlQ/AlYB3217E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN0YZmx8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7800ff158d5so3440681b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759680020; x=1760284820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNEHIKGjr5cFoCF/LF+uK+ZZb0/rQaBUls4FLPZu7hw=;
        b=DN0YZmx8MxwiC+GA3TGYEhBu7sGP3bo6ng8CDl1c0BjAKk4NIHDus21TXF9LAcGwKa
         9MlR928/9TK7129y+yYpWCTEnilE7ammaZJj9wt++koNaX1iMhoWrZXtWK6kDKnk9kL9
         cu4c8yZjz7A4jFUNAz9Drtr7+Njt7e70MtHtZwtmxwKw8UsqbSJ2/XQ8cUP422rtU4RU
         2KwS1JI8XbwGA0rvqEmUE7u9Axb6lpJLLTCgSu422IuKCaJVivD4zu51bv/xistmDj33
         Q1hRrdi1CuEwS17z+hQWGCiXbeNKHSfRqSdFC3l+6EXRYn1lAA28N7K5kGRxzEDllxw3
         EgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759680020; x=1760284820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNEHIKGjr5cFoCF/LF+uK+ZZb0/rQaBUls4FLPZu7hw=;
        b=MK1xHbUDXWif9BvJn4lHCa3ZxXlG8DSmMhdzKpKW1mva5a1Trok6axDfQomUNz9Zv0
         utIdSS91V1YEv+0z5Ar6Eam2DL23RTCU4nLpLn1bk//dvnmHzBsRysSv7s9qnZGY6ROt
         rDdN9mNGt4mWZHQtCloF5Hg53YOWZPJPQ5eV4QOAcNGkQuHF8RGnIVgREb8hSYfgs6xb
         tbWqDbg9FDKKZqsXs8giwATUNp5dOrTorF+RtthwncxgwfTfBBXsdfpp2d75ksIZcnpP
         JnmpLGaWJke5kip+OcDcTwFAaale32MnSIx4/O7nnxeznVifjuKHVWdITxZwPOQQpJt6
         cTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXuRKzSxOu2rqXLwuYutHWxONrGb9esZLq2myaOZgqZ6sAF+kcgz8ZwLpv/AS0o5uBMPNnb8xLx+wT94SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE/0Qyx5AcReTV242BDbX72wEWUfrFyzU+025XhzNtmKaCNSCK
	wEYBKk4k2Yk87c6b4oqLP/uMiuQGIUYCym/IVdy6LJWGrvM6XqolKF2Q
X-Gm-Gg: ASbGncvR1/VOSltP+K0iLy9IJV5q1flctRo0TpgpsII4kxn3Y3akmV6jBUZUg2G7f7I
	JEX5g1YymCZYTiSO6HZR556QuIZUpZ5ipEbUnJ/ABcPeiUqDiKKvuMZIdqGIESyQTY2JK/P8+0E
	VWYkyOn7a01r2wVllPxJQDngnBHm0wnOPku3D99Ixt/AaWMILNdaV9wEMWfRZxvRzjp91mjaM+Q
	MmbOyhDI6XcK6y1Y1grZQBjcBQWuxkL+YL8qi3N29nkGeeBvv+/ka42Npo7rXQdp6jla+SPpQWC
	7BwIMl10+n0bo40f/Ra620k2Od+etyWkD/FjIEcMrG8x2pSxPpAiekiTUHW/bvhfcPXE97v04Pu
	/h8k0LP9rTJx2eX6reBS2aWtEFRxYCKYKMNgAd/K/M7/vOJqqLUjX7727bBHJ
X-Google-Smtp-Source: AGHT+IFbMORClUNlmsaxwc+iSakePmH0AYcYLMYlHYqIgx//Yq0c6ae7Wsjba298dMnFASZdc0YnMQ==
X-Received: by 2002:a05:6a00:23d5:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-78c98cb698fmr11694812b3a.21.1759680020289;
        Sun, 05 Oct 2025 09:00:20 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm10145241b3a.32.2025.10.05.09.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 09:00:19 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH 2/4] staging: rtl8723bs: split long comments in rtw_ap.c
Date: Sun,  5 Oct 2025 11:59:18 -0400
Message-ID: <20251005155920.381334-3-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251005155920.381334-1-trohan2000@gmail.com>
References: <20251005155920.381334-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch splits overly long comments that exceeded 100 characters
into multiple shorter lines, following kernel coding style guidelines.

This is a coding style cleanup only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 93ab0015ca89..2c906c1137bf 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -391,7 +391,9 @@ void update_bmc_sta(struct adapter *padapter)
 
 		memset((void *)&psta->sta_stats, 0, sizeof(struct stainfo_stats));
 
-		/* psta->dot118021XPrivacy = _NO_PRIVACY_;//!!! remove it, because it has been set before this. */
+		/* psta->dot118021XPrivacy = _NO_PRIVACY_;
+		 * remove it, because it has been set before this.
+		 */
 
 		/* prepare for add_RATid */
 		supportRateNum = rtw_get_rateset_len((u8 *)&pcur_network->supported_rates);
@@ -655,7 +657,10 @@ void start_bss_network(struct adapter *padapter)
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
 	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
+	/* if there is wpsie in beacon,
+	 *the hostapd will update beacon
+	 *twice when stating hostapd,
+	 */
 	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
 	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
 			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
@@ -835,7 +840,10 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	p = rtw_get_beacon_interval_from_ie(ie);
+	/* ie + 8;
+	 * 8: TimeStamp, 2: Beacon Interval 2:Capability
+	 */
 	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
 	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
@@ -1127,7 +1135,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  update AP's sta info */
 	update_ap_info(padapter, psta);
 
-	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
+	psta->state |= WIFI_AP_STATE;
+	/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
 	rtw_indicate_connect(padapter);
 
 	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
-- 
2.50.1


