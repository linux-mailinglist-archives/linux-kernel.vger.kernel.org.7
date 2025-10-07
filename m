Return-Path: <linux-kernel+bounces-844016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB9BC0D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C82EE4F3EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F942D5412;
	Tue,  7 Oct 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqkF/84t"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E912D8385
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828427; cv=none; b=sRIMO9OMaHmMlNKIU7zvv5rS+XKyXZicgsswNciRSFztsrKvXQyZYrq2GtFEdGtKX96+EqlNbBMStUFnIYmk7/arETzE9VOe52UVrH/7u40rgw21pv7WkSRbxLizsO02h22nsBi0a+K0oOpkw9jgY/1/pchVc71BX7QZfY4zOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828427; c=relaxed/simple;
	bh=H/UgL4VVfV8j6In49ISHZnc15XoHZHlSo1QR/T+B/r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXzfWp9r5G5C4oh4latfAkseDK1BcR2ztwlz+6kLA2ioWHRTFeVd0CdAYEXAGVa6tSTUoyFFv8KmaX3+WGv1EDnj1I0Hb0pbrc8ILFl07cSpJhObsgsm/OxLN7fhwsu0MITd8s2bcddSjwMqTydy/gDk4ffpreN2S03odTt2jVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqkF/84t; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f343231fcso3782697b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759828425; x=1760433225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opAzYnuvyQ0YBSNx1xW1h2lQ5m+q74fF74UQplgI5Os=;
        b=AqkF/84tEie0HcwAbzqH8/vxZSATikzbMIvEtoT+X+q6fGNS0R8XQvzGYfT9QurKOL
         apJJj0vrDnvwbEXQnYKuyzxGN5K7aXEtCyqkto+4+mTP0Qb+fMsLXk2M9AiuMwWtR0Jw
         K1RKcp/Xdv7uH4mjlAcLZm9Ganj/j2l0649QWxhx3KhiYzuz8Inc6gd++30S9vHVanzu
         EczZiLKHyemzI61iwxeqBpSa48HgjNWB8nk+r/dx4RCyhBiN0uaSRKMpj6niz2PDf+N2
         A8kX8a8sbqqElfNDfiN9x4zZFf7hGI4qiQABYvJ4g5fMJGuh5OM88vl1dPW+z/bX4v4V
         AGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828425; x=1760433225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opAzYnuvyQ0YBSNx1xW1h2lQ5m+q74fF74UQplgI5Os=;
        b=shUH99d8S8M4umLF6BNTdLOkTSOIlauoGL5tjoZIYAMbkb/uaLWpQ+4zW98jTOFqeZ
         J+yVplyPdGqDz6Fy9Q3Nx03eObu9Xb8iLR6p/zPFze9kHHhZjCreJpQaPjgsZNTmo7xL
         uRfyuwIeBbut78mnosn0taUk/rfMy/26Dv1674CAvOFIIiwiblI3cTZheK0UvAG2FdCC
         5Ou8e5w8UVfVmyPs23LSu90A2sLtVRdKiYhHSgch0XjZE0HPPAVEjJTcIBxtH6dW1J8p
         ABKk8pfUPh985+iCbRC9LCmn50y903YrI+k29aTPUMjr4FMf0HQhyQVXRjdNIw96Uqw1
         imEw==
X-Forwarded-Encrypted: i=1; AJvYcCW4yHLsLoRCZYJtU79HMCzSz8Xw7ybjqo8VKs0lK2vHKqkXwX9i1VY+ZIHRR86M3N40NDKgQvR6kCHlwkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6DZyOTDT0ZQEsC/iOwixD8haqjGWrDwDL/l+MmI6dah28W2w
	t+76+6QuNAi1jvi6sWWzl5Tlcjx7w4/YncIgQs4zyPZZPPvMriD+0hfr
X-Gm-Gg: ASbGncuku6C3SoCtsGKBWhaZ4an9lHgRuCfB8N5E8f/WK9b6V99sJs4KLVSQzjKf08J
	Z1fSvJAhVBtnwJQuoaj836WhWQK7bjpMaGZguzRctQP2hO7CGNX2LGI1kXHYEMxQgpd3H80ydrb
	uC8/N6rj4eo/2xeCEs1qzPXK/VFy9J6aoAsVpI7N/KPrA0+FwN4Qvg3Dvur5v/jdnmaw81lHCU3
	dHHNVq2hIU9p1i5HByEM6tAEfNAwDOYZCybuQSEvqQy8EzsgXjq7KInj0fEHgY8qbCNea9rKY86
	b13dCsPdpXAv9KUJ6J3l+9v+1/2uKJHhhepcPGHymgFpw25AgmKESOfwNNMU9e72t3GFOcae/gn
	rvKK4VNedN/VDIpI+dJZ2CZK0ks+WUuD+7/Nu4SG7lzGYzUe0Iu47LafXaChM
X-Google-Smtp-Source: AGHT+IH0Xi6QX34wK33uFsruT6XEcZ2GkCDm8OpGSqZvNf7vocGfys3dHjIUDaAFqUilWev4P+Ey/g==
X-Received: by 2002:a05:6a00:3d51:b0:781:2320:5a33 with SMTP id d2e1a72fcca58-78c98d5d5a9mr17484592b3a.9.1759828425410;
        Tue, 07 Oct 2025 02:13:45 -0700 (PDT)
Received: from Deathstar.anonymous ([172.56.42.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm14941784b3a.13.2025.10.07.02.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:13:44 -0700 (PDT)
From: Rohan Tripathi <trohan2000@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rohan Tripathi <trohan2000@gmail.com>
Subject: [PATCH v3 6/6] staging: rtl8723bs: wrap long comments in rtw_ap.c
Date: Tue,  7 Oct 2025 05:13:03 -0400
Message-ID: <20251007091303.491115-6-trohan2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007091303.491115-1-trohan2000@gmail.com>
References: <20251007091303.491115-1-trohan2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes instances of comment lines in rtw_ap.c that exceeded the
recommended 80–100 character limit. The affected comments were reflowed
to span multiple lines, each starting with " * " as per kernel coding
style guidelines.

These are coding style cleanups only. No functional changes.

Signed-off-by: Rohan Tripathi <trohan2000@gmail.com>
---
v3: fixed space after *
v2: one comment had a * with no space after it
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 121b9db76711..b12b53a8b3be 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -655,9 +655,12 @@ void start_bss_network(struct adapter *padapter)
 	cur_bwmode = CHANNEL_WIDTH_20;
 	cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
 
-	/* check if there is wps ie, */
-	/* if there is wpsie in beacon, the hostapd will update beacon twice when stating hostapd, */
-	/* and at first time the security ie (RSN/WPA IE) will not include in beacon. */
+	/*
+	 * check if there is wps ie,
+	 * if there is wpsie in beacon,
+	 * the hostapd will update beacon twice when stating hostapd,
+	 * and at first time the security ie (RSN/WPA IE) will not include in beacon.
+	 */
 	if (!rtw_get_wps_ie(pnetwork->ies + _FIXED_IE_LENGTH_,
 			    pnetwork->ie_length - _FIXED_IE_LENGTH_, NULL, NULL))
 		pmlmeext->bstart_bss = true;
@@ -835,7 +838,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	memcpy(pbss_network->mac_address, myid(&padapter->eeprompriv), ETH_ALEN);
 
 	/* beacon interval */
-	p = rtw_get_beacon_interval_from_ie(ie);/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	/* ie + 8;	8: TimeStamp, 2: Beacon Interval 2:Capability */
+	p = rtw_get_beacon_interval_from_ie(ie);
 	/* pbss_network->configuration.beacon_period = le16_to_cpu(*(unsigned short*)p); */
 	pbss_network->configuration.beacon_period = get_unaligned_le16(p);
 
@@ -1114,7 +1118,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	/*  update AP's sta info */
 	update_ap_info(padapter, psta);
 
-	psta->state |= WIFI_AP_STATE;		/* Aries, add, fix bug of flush_cam_entry at STOP AP mode , 0724 */
+	psta->state |= WIFI_AP_STATE;
 	rtw_indicate_connect(padapter);
 
 	pmlmepriv->cur_network.join_res = true;/* for check if already set beacon */
-- 
2.50.1


