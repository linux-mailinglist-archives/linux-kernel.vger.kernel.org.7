Return-Path: <linux-kernel+bounces-799675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CAB42ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62A87C1EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD471F4174;
	Thu,  4 Sep 2025 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bqv5S+O8"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FA11EBA07
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949363; cv=none; b=DYT9eg/0oXfywzrnPNaTOy/YPFYsFXZBO1d1WYkFrE1F0QVSE6geqmRbHdKT1BbPvWc3ilJk+83J12Z6pAx1XMlXl8vzRSD5B2ZtNiSEaSMvUVruai5gkCQpOPw+TAWnykENhHLGtDlYTlFo0SRV3ZHFfR29qshrTrDBG1m4ktE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949363; c=relaxed/simple;
	bh=d/a/06MRexX8jkafOM3Tb1PqFQuAWBAEPNY/pLIaUXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwBgr3IwW8JI3BbG2Xd0STZruIvy5D1p2flqQomCkhyRUlgPkKq9zBhiFBgU+3S+7Ks9wu7/fyGYVNy+mHJanJzijJdysw6blzljepLHtxgwcZ7wF1SGUTzuI8BemtWQ2MGC8SCl38l8u30Nmf5bfLepcThxAj+j9tO8BTRPDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bqv5S+O8; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80a6937c99bso61626185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949361; x=1757554161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVxRP/gHP4MJ/VTDLOIdadmwOEyVTedNOpSakKUHi5Q=;
        b=Bqv5S+O88s9yg/IVhSSpd26DwYjfeZ1UOlOFwhGuqjIjcP8v657B+UN/f4RM54nRbq
         pSJ02DJMfBnjD08BfleAXq8k1Yw6I0jyH+1BGnWKyIuLTcBONe5ZGPv+LZQnuOUlPtv/
         vNlwKnUvx1wdeyPi/muJbo07yQgBH+xRJ6X2zPAyJaFmD/3xS/TiWo/OSea1uFAbS2al
         SPveaRVpSjvj9q/ouQ0jSrOZNiKkBahcz6gjHJD/xNqvNL8PvHw9Xc4xkp13nvW7e/8D
         PYpIt0p8eLZRP5MzR8gNNnz9WYu+bCslo714SQWRjNl6OWegt3bbcaIML/0tA3OaQ81s
         VkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949361; x=1757554161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVxRP/gHP4MJ/VTDLOIdadmwOEyVTedNOpSakKUHi5Q=;
        b=bXdL5l3bshJWUUXT0G7pruWkJJ7X3c1eOSxw3jLX6/PUGlLnoQgGxzQOcyHe0aKPVz
         1S1ldEWrebpkEWtKYJd381ycht+7LEsEkiw9mS2TaIi/Hzn0I7ftH5xvyeVP0/8L1G4e
         +GPe+/S22G5fNeeaypIvKQ80T4d8aEYAp0f5duT0HbfUY0fnYSSfW0otKC6D8R1lHSiH
         6iZN/htOzcNC94QJSTozUBoK54uHkXpbE8BOYvP8NV38izMn52F9o5ZeOWXXxFYcNqQ2
         JrB+8p/G+OsHH36LPszIQ/OKBRoIJF6E81Hx4NTYqBr61+CDRe+rMxp5KGhE/GgfhOAC
         9V6w==
X-Forwarded-Encrypted: i=1; AJvYcCULGY8EnswZPz5dRkPENNRQOnoFv1zvUKcfDzXIhTzUz50F/KO2/F65X/SKjxy8UFmNeatsw+5NwKt7o7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzrO/PACQ/5VvKetsXp9a5qfL1rhvICy2uncz63QXcV2s9cOX
	w+gj991QgEqvY1q0+zs+Zxf/xXM8mQtJKWWLbc87KaGYj2sfPYqIZrvD
X-Gm-Gg: ASbGncv4Ik3LrkAmI8wcJsR+0CLkBu2x2y4PiluqHd0NL2ozrtM99/1YfTI6W2GnZjA
	OTCZDJE6NORp6BxEfX2N8nXIculGLaUO125HkUHuS7lGX78N+6fYpvfngyHhS0zihQSOMRKGM1Y
	5+PZKE1wvLLNL8Ne59VsTAdkLOHMxZRXRt1FYdBpfyOGsL63tE15Ave+p0eCRUSTvN7x0gjoMmS
	RkG6GX0aMtTZYcvaWbzp+DxmibYIv/GTgJqxSFVpGtxrnLDU1htRVRjpFknsdK27O5qTJ9Sjkll
	LprM/vBTHRgF07OmpzvIUuUe0q/z0EzKSVsx3mYPfTsZIx2wdxstnqd8bec5++NIDSar+r+ernq
	Mbi4i03KvvwvGpVrkKcepRaxAf1cDdL5fhO3fyMhdkRO/Is3UtqkthD5AHGIJ37tyDZ/+CypQ
X-Google-Smtp-Source: AGHT+IFak0wXCxFGIQKw/J/dmbweQ7MS7EzMJkOOKb9zRTKbr9gDeKeV1PVVkoYtxJHhZaVUvl3eQg==
X-Received: by 2002:a05:620a:40cc:b0:7fe:8292:187e with SMTP id af79cd13be357-7ff2bd544acmr1867603085a.60.1756949360869;
        Wed, 03 Sep 2025 18:29:20 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f78757fsm20378921cf.43.2025.09.03.18.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:29:20 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 14/16] staging: rtl8723bs: fix line ending with '('
Date: Thu,  4 Sep 2025 01:28:57 +0000
Message-Id: <20250904012859.215565-5-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
References: <20250904012859.215565-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust formatting to avoid a line ending with an opening parenthesis,
in compliance with kernel coding style.

No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 25f333bb0816..2c34b68f1d60 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -1112,8 +1112,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter,
 	 * ptarget_wlan->network.phy_info.signal_strength instead (has scaled)
 	 */
 	padapter->recvpriv.rssi =
-	translate_percentage_to_dbm(
-		ptarget_wlan->network.phy_info.signal_strength);
+	translate_percentage_to_dbm(ptarget_wlan->network.phy_info.signal_strength);
 
 	rtw_set_signal_stat_timer(&padapter->recvpriv);
 
-- 
2.39.5


