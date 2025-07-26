Return-Path: <linux-kernel+bounces-746626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA5B12902
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFA9586157
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B220C469;
	Sat, 26 Jul 2025 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJxPqO1A"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E09223DE9
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 04:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753504459; cv=none; b=lTmjSpzvZEaIfKm5TYnCM7ChbDyIp4rqzcweGBVLhWvahLMaaLaz/B9NoOhi++LqvE5/gMtm8m/kl4+FN23MI5egyTIyaEQU0MuTqW2RLgBBkaMhpxL8WD4jH+dW0AzESSOLrsmsbDoiRib951lvp3ABIr5x6oyaxnroN9tPI0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753504459; c=relaxed/simple;
	bh=d2e+T2yU2a4AET8w22kASfi4lDBNypov0MLe6Ab0DR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MN8KMEGwrfRgjYCqhIaPwzlex12xMmZlBgKQlSP6YfR0ATZ4UcwIuIG/Mwm1UCpdXTuLbeKAz039yeh+4fNkemd4NZ6SokUoPs4JzYxWXc4NVCCKj2VYGu+hfi0riPSmbEl8KMIc6LEEnu68ZhxDQtDMp9tfqJ61Fc/VlrY52hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJxPqO1A; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7dfff5327fbso343023885a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753504457; x=1754109257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC+5ntkiMYOcg9q9ULRx/adh+E/wjCdGyK8BZoGwft8=;
        b=PJxPqO1AqsVIkDgc7ysMhK8grDNSbkIOGmmC0Cc3ZXd/cgQE5SLNG4BdyzMY2wF4I+
         4flhjG5x8LmmqLjXHcjdML7H744dzeREjb2y6RBxqK+Ps+VWiZ8VAO2sTTDjgBP65+hw
         TSX9cPYMkdbK6V0RFWugxot2t1566AhlRJvvs4vD5B8bS1/9nUWXARREX4bzQMeq/ndI
         litKAZaIo9NncoanAXS6UxgFihe76fGfzH5Aazr6a/D9BY72O/ZLGnkeURerpXnwRFyH
         hd2EpkJ24WJUpo1WVYXnn4/6iOTgY1Q3943UGQFyJsR0U70fxqhCEl+H+HBXxfjGyxzr
         7Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753504457; x=1754109257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC+5ntkiMYOcg9q9ULRx/adh+E/wjCdGyK8BZoGwft8=;
        b=S/jvnTknZLXE96muYt3hBw0pnrp3C+YJEIESveQZDCkH6pWZ10tIDXLkYxCuytQKyM
         7dMeoPBl70WN4SjABj4t4U0rAvJ4kqIM2diQ/xYHx0UJ08PO/KalGnm2VoCUMkHcuZqU
         niPqtzBoE3TdzhfCHWpVGdFCiUHNVsYbCSf752978xiMjQrCyEs7ZdWxLXXJNWUmOkNc
         Lh7ICq/W3oFOGBEtGkazWMxldsNcg4dYuUBryFzlXYC2AmBBdpjyROYgsz0sp0cOhQIB
         98DVFuaVLRbsPk3ENNsrHoRNOprjw8hbhpQFhLVwyBiVKF+7pC+6DA7gdSBQOBJi9bER
         pKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tpaveKYhkdNm/gPFfjkr/B8bsso8/eQ41hUqgzd81L/OyQ7l6LDLbiLxZg/2rfKkNuw0d9DYo7Zok18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxl9Z/DUnkFbgK29Ti3vNM1elU3U1twLZoCR4YhvzsVMFi9Ye
	1egFcD9Y1hXPZQDaPXZz3J1tciyGHWGlqSah1VXnt9JXBwfgDEcWbh5X
X-Gm-Gg: ASbGnctmU/GapBuH+pxNF56ZX6qrJ8ahBXa6LhbywpG/b8xebx1F1IMAU1GoZuh48JZ
	Go0BOtS3ckagBb8f1STE0Vit+UBaZjGL/z+WTtZNps8vWK/xm9iaS/QPcFOIRxEhNLvdgWocL6k
	72mR3ic1P0LLY6uqTaubedDYAqMz8mKPMReSEERTlACBrZYn7BLQBB0b5abzRvJ8+a4AAooGiuq
	pF3TihgIYezV7dP7gEjz3w92FfB93SKURFgh9+/HrjZ3tpPpsWDa9DqH5bxDLtB7Ry5HUgZUR+B
	H+0bWhvDXGVtS7vfjpF7hs4w3yYPtrIfoZTAqYnzLm3q680NFPN5r/wOT9sIGahSEnEtZOv9UgK
	79MzlKnjTN27yrZ4wBOv41DWVNmIpCAr+FkT9GQthy4bhBlcTsjo=
X-Google-Smtp-Source: AGHT+IEz2pv6WB1PyFs4FPgWVH3seutfTorp8cVLUTzAsCHl/hXSEJr0qXxLqZTGBIZh+iqHRC8RYg==
X-Received: by 2002:a05:620a:2ae9:b0:7e2:c5ff:2078 with SMTP id af79cd13be357-7e63c1c74f7mr477625085a.37.1753504456831;
        Fri, 25 Jul 2025 21:34:16 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e6432a885asm70322185a.36.2025.07.25.21.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 21:34:16 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH 20/20] staging: rtl8723bs: merge nested if conditions for clarity and tab problems
Date: Sat, 26 Jul 2025 04:32:18 +0000
Message-Id: <20250726043218.386738-21-vivek.balachandhar@gmail.com>
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

Merged nested if conditions for clarity and fixed tab indentation in one
place. No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index dbaaa2357ee5..7c189a823c00 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1157,8 +1157,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
 						rtw_free_stainfo(adapter,  pcur_sta);
 
 					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
-					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
-					    if (ptarget_wlan)
+					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true &&
+					    ptarget_wlan) {
 						ptarget_wlan->fixed = true;
 					}
 				}
-- 
2.39.5


